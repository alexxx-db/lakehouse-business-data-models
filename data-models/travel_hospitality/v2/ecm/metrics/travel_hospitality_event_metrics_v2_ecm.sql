-- Metric views for domain: event | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-07-10 20:24:18

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core event booking performance metrics including revenue, conversion, and booking velocity KPIs for strategic event sales management"
  source: "`vibe_travel_hospitality_v1`.`event`.`event_booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the event booking (tentative, definite, cancelled, completed)"
    - name: "mice_category"
      expr: mice_category
      comment: "MICE segment classification (Meeting, Incentive, Conference, Exhibition)"
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', event_start_date)
      comment: "Month when the event is scheduled to start"
    - name: "event_start_year"
      expr: YEAR(event_start_date)
      comment: "Year when the event is scheduled to start"
    - name: "inquiry_to_booking_days_bucket"
      expr: CASE WHEN DATEDIFF(created_timestamp, inquiry_date) <= 7 THEN '0-7 days' WHEN DATEDIFF(created_timestamp, inquiry_date) <= 30 THEN '8-30 days' WHEN DATEDIFF(created_timestamp, inquiry_date) <= 90 THEN '31-90 days' ELSE '90+ days' END
      comment: "Time bucket from inquiry to booking creation for sales cycle analysis"
    - name: "booking_lead_time_bucket"
      expr: CASE WHEN DATEDIFF(event_start_date, created_timestamp) <= 30 THEN '0-30 days' WHEN DATEDIFF(event_start_date, created_timestamp) <= 90 THEN '31-90 days' WHEN DATEDIFF(event_start_date, created_timestamp) <= 180 THEN '91-180 days' ELSE '180+ days' END
      comment: "Lead time bucket from booking to event start for demand planning"
    - name: "deposit_received_flag"
      expr: deposit_received_flag
      comment: "Whether deposit has been received (risk indicator)"
    - name: "is_room_block"
      expr: CASE WHEN room_block_count IS NOT NULL AND CAST(room_block_count AS INT) > 0 THEN TRUE ELSE FALSE END
      comment: "Whether booking includes a room block component"
  measures:
    - name: "total_bookings"
      expr: COUNT(1)
      comment: "Total number of event bookings"
    - name: "total_contracted_value"
      expr: SUM(CAST(contracted_value_amount AS DOUBLE))
      comment: "Total contracted revenue across all bookings"
    - name: "avg_contracted_value"
      expr: AVG(CAST(contracted_value_amount AS DOUBLE))
      comment: "Average contracted value per booking"
    - name: "total_expected_attendance"
      expr: SUM(CAST(expected_attendance_count AS BIGINT))
      comment: "Total expected attendees across all bookings"
    - name: "avg_expected_attendance"
      expr: AVG(CAST(expected_attendance_count AS DOUBLE))
      comment: "Average expected attendance per booking"
    - name: "total_guaranteed_attendance"
      expr: SUM(CAST(guaranteed_attendance_count AS BIGINT))
      comment: "Total guaranteed attendees across all bookings"
    - name: "total_actual_attendance"
      expr: SUM(CAST(actual_attendance_count AS BIGINT))
      comment: "Total actual attendees across completed bookings"
    - name: "total_room_block_count"
      expr: SUM(CAST(room_block_count AS BIGINT))
      comment: "Total room nights blocked across all bookings"
    - name: "total_room_block_pickup"
      expr: SUM(CAST(room_block_pickup_count AS BIGINT))
      comment: "Total room nights actually picked up from blocks"
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts across all bookings"
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission paid to intermediaries"
    - name: "total_concession_amount"
      expr: SUM(CAST(concession_amount AS DOUBLE))
      comment: "Total concessions granted (revenue leakage indicator)"
    - name: "bookings_with_deposit"
      expr: COUNT(CASE WHEN deposit_received_flag = TRUE THEN 1 END)
      comment: "Number of bookings with deposit received"
    - name: "definite_bookings"
      expr: COUNT(CASE WHEN booking_status = 'Definite' THEN 1 END)
      comment: "Number of definite (confirmed) bookings"
    - name: "tentative_bookings"
      expr: COUNT(CASE WHEN booking_status = 'Tentative' THEN 1 END)
      comment: "Number of tentative bookings requiring conversion"
    - name: "cancelled_bookings"
      expr: COUNT(CASE WHEN booking_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled bookings (attrition indicator)"
    - name: "unique_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with bookings"
    - name: "unique_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct client accounts booking events"
$$;


CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_revenue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event revenue realization and variance metrics for financial performance management and forecasting accuracy"
  source: "`vibe_travel_hospitality_v1`.`event`.`event_revenue`"
  dimensions:
    - name: "revenue_category"
      expr: revenue_category
      comment: "Primary revenue category (Room, F&B, Space Rental, AV, Other)"
    - name: "revenue_subcategory"
      expr: subcategory
      comment: "Detailed revenue subcategory for granular analysis"
    - name: "event_type"
      expr: event_type
      comment: "Type of event generating revenue"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment collection status (Paid, Pending, Overdue)"
    - name: "revenue_month"
      expr: DATE_TRUNC('MONTH', revenue_date)
      comment: "Month when revenue was recognized"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month when revenue was posted to GL"
    - name: "is_voided"
      expr: is_voided
      comment: "Whether revenue transaction was voided"
    - name: "variance_bucket"
      expr: CASE WHEN variance_amount > 0 THEN 'Favorable' WHEN variance_amount < 0 THEN 'Unfavorable' ELSE 'On Budget' END
      comment: "Budget variance direction for performance analysis"
  measures:
    - name: "total_actual_revenue"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual revenue recognized"
    - name: "total_budgeted_revenue"
      expr: SUM(CAST(budgeted_amount AS DOUBLE))
      comment: "Total budgeted revenue for comparison"
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after commissions and adjustments"
    - name: "total_commission"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission paid on event revenue"
    - name: "total_service_charge"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges collected"
    - name: "total_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on event revenue"
    - name: "total_adjustment"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total revenue adjustments (positive or negative)"
    - name: "total_variance"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (actual minus budgeted)"
    - name: "total_revpar_contribution"
      expr: SUM(CAST(revpar_contribution AS DOUBLE))
      comment: "Total RevPAR contribution from event room blocks"
    - name: "total_trevpar_contribution"
      expr: SUM(CAST(trevpar_contribution AS DOUBLE))
      comment: "Total TRevPAR contribution from all event revenue"
    - name: "avg_group_adr"
      expr: AVG(CAST(group_adr AS DOUBLE))
      comment: "Average daily rate for group room blocks"
    - name: "avg_per_attendee_revenue"
      expr: AVG(CAST(per_attendee AS DOUBLE))
      comment: "Average revenue per attendee"
    - name: "total_group_room_nights"
      expr: SUM(CAST(group_room_nights AS BIGINT))
      comment: "Total room nights consumed by event groups"
    - name: "total_attendee_count"
      expr: SUM(CAST(attendee_count AS BIGINT))
      comment: "Total attendees across all revenue transactions"
    - name: "revenue_transactions"
      expr: COUNT(1)
      comment: "Total number of revenue transactions"
    - name: "voided_transactions"
      expr: COUNT(CASE WHEN is_voided = TRUE THEN 1 END)
      comment: "Number of voided revenue transactions"
    - name: "unique_bookings"
      expr: COUNT(DISTINCT event_booking_id)
      comment: "Number of distinct event bookings generating revenue"
    - name: "unique_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with event revenue"
$$;


CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_inquiry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event inquiry pipeline and conversion metrics for sales funnel optimization and lead qualification effectiveness"
  source: "`vibe_travel_hospitality_v1`.`event`.`inquiry`"
  dimensions:
    - name: "inquiry_status"
      expr: inquiry_status
      comment: "Current status of the inquiry (New, Qualified, Proposal Sent, Converted, Lost)"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Lead qualification status for pipeline quality assessment"
    - name: "event_type"
      expr: event_type
      comment: "Type of event inquired about"
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment of the inquiring client"
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which inquiry was received"
    - name: "referral_source"
      expr: referral_source
      comment: "Specific referral source for attribution analysis"
    - name: "inquiry_month"
      expr: DATE_TRUNC('MONTH', inquiry_date)
      comment: "Month when inquiry was received"
    - name: "preferred_event_month"
      expr: DATE_TRUNC('MONTH', preferred_start_date)
      comment: "Month when client prefers to hold event"
    - name: "lead_score_bucket"
      expr: CASE WHEN lead_score IN ('Hot', 'A') THEN 'Hot' WHEN lead_score IN ('Warm', 'B') THEN 'Warm' WHEN lead_score IN ('Cold', 'C') THEN 'Cold' ELSE 'Unscored' END
      comment: "Lead score bucket for prioritization"
    - name: "budget_range_bucket"
      expr: CASE WHEN budget_range_max < 10000 THEN 'Under 10K' WHEN budget_range_max < 50000 THEN '10K-50K' WHEN budget_range_max < 100000 THEN '50K-100K' ELSE '100K+' END
      comment: "Budget range bucket for opportunity sizing"
    - name: "is_converted"
      expr: CASE WHEN inquiry_status = 'Converted' THEN TRUE ELSE FALSE END
      comment: "Whether inquiry converted to booking"
  measures:
    - name: "total_inquiries"
      expr: COUNT(1)
      comment: "Total number of event inquiries received"
    - name: "qualified_inquiries"
      expr: COUNT(CASE WHEN qualification_status = 'Qualified' THEN 1 END)
      comment: "Number of qualified inquiries in pipeline"
    - name: "converted_inquiries"
      expr: COUNT(CASE WHEN inquiry_status = 'Converted' THEN 1 END)
      comment: "Number of inquiries converted to bookings"
    - name: "lost_inquiries"
      expr: COUNT(CASE WHEN inquiry_status = 'Lost' THEN 1 END)
      comment: "Number of inquiries lost to competition or cancellation"
    - name: "total_estimated_attendance"
      expr: SUM(CAST(estimated_attendance AS BIGINT))
      comment: "Total estimated attendees across all inquiries"
    - name: "avg_estimated_attendance"
      expr: AVG(CAST(estimated_attendance AS DOUBLE))
      comment: "Average estimated attendance per inquiry"
    - name: "total_estimated_room_nights"
      expr: SUM(CAST(room_nights_estimate AS BIGINT))
      comment: "Total estimated room nights in pipeline"
    - name: "avg_budget_max"
      expr: AVG(CAST(budget_range_max AS DOUBLE))
      comment: "Average maximum budget across inquiries"
    - name: "total_pipeline_value"
      expr: SUM(CAST(budget_range_max AS DOUBLE))
      comment: "Total pipeline value based on maximum budgets"
    - name: "hot_leads"
      expr: COUNT(CASE WHEN lead_score IN ('Hot', 'A') THEN 1 END)
      comment: "Number of hot leads requiring immediate attention"
    - name: "unique_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties receiving inquiries"
    - name: "unique_channels"
      expr: COUNT(DISTINCT source_channel)
      comment: "Number of distinct inquiry source channels"
$$;


CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_lost_business`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lost event business analysis metrics for competitive intelligence and win-back strategy optimization"
  source: "`vibe_travel_hospitality_v1`.`event`.`lost_business`"
  dimensions:
    - name: "loss_reason_category"
      expr: loss_reason_category
      comment: "Primary category of loss reason (Price, Availability, Facilities, Service, Competition)"
    - name: "loss_reason_detail"
      expr: loss_reason_detail
      comment: "Detailed loss reason for root cause analysis"
    - name: "competitor_property_name"
      expr: competitor_property_name
      comment: "Name of competitor who won the business"
    - name: "event_type"
      expr: event_type
      comment: "Type of event that was lost"
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment of lost opportunity"
    - name: "loss_month"
      expr: DATE_TRUNC('MONTH', loss_date)
      comment: "Month when business was lost"
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', event_start_date)
      comment: "Month when lost event was scheduled to start"
    - name: "win_back_probability_bucket"
      expr: CASE WHEN win_back_probability IN ('High', 'Likely') THEN 'High' WHEN win_back_probability IN ('Medium', 'Possible') THEN 'Medium' ELSE 'Low' END
      comment: "Win-back probability bucket for prioritization"
    - name: "revenue_size_bucket"
      expr: CASE WHEN estimated_total_revenue < 25000 THEN 'Under 25K' WHEN estimated_total_revenue < 100000 THEN '25K-100K' WHEN estimated_total_revenue < 500000 THEN '100K-500K' ELSE '500K+' END
      comment: "Lost revenue size bucket for impact analysis"
  measures:
    - name: "total_lost_opportunities"
      expr: COUNT(1)
      comment: "Total number of lost business opportunities"
    - name: "total_lost_revenue"
      expr: SUM(CAST(estimated_total_revenue AS DOUBLE))
      comment: "Total estimated revenue lost to competition"
    - name: "total_lost_room_revenue"
      expr: SUM(CAST(estimated_room_revenue AS DOUBLE))
      comment: "Total estimated room revenue lost"
    - name: "total_lost_fb_revenue"
      expr: SUM(CAST(estimated_fb_revenue AS DOUBLE))
      comment: "Total estimated F&B revenue lost"
    - name: "total_lost_meeting_space_revenue"
      expr: SUM(CAST(estimated_meeting_space_revenue AS DOUBLE))
      comment: "Total estimated meeting space revenue lost"
    - name: "total_lost_other_revenue"
      expr: SUM(CAST(estimated_other_revenue AS DOUBLE))
      comment: "Total estimated other revenue lost"
    - name: "total_lost_room_nights"
      expr: SUM(CAST(estimated_room_nights AS BIGINT))
      comment: "Total estimated room nights lost"
    - name: "total_lost_peak_rooms"
      expr: SUM(CAST(estimated_peak_rooms AS BIGINT))
      comment: "Total estimated peak rooms lost"
    - name: "avg_lost_revenue"
      expr: AVG(CAST(estimated_total_revenue AS DOUBLE))
      comment: "Average revenue per lost opportunity"
    - name: "avg_competitor_quoted_rate"
      expr: AVG(CAST(competitor_quoted_rate AS DOUBLE))
      comment: "Average rate quoted by competitors"
    - name: "avg_quoted_group_adr"
      expr: AVG(CAST(quoted_group_adr AS DOUBLE))
      comment: "Average group ADR quoted by property"
    - name: "high_win_back_opportunities"
      expr: COUNT(CASE WHEN win_back_probability IN ('High', 'Likely') THEN 1 END)
      comment: "Number of opportunities with high win-back probability"
    - name: "unique_competitors"
      expr: COUNT(DISTINCT competitor_property_name)
      comment: "Number of distinct competitors winning business"
    - name: "unique_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties losing business"
$$;


CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event proposal effectiveness and conversion metrics for sales process optimization and pricing strategy"
  source: "`vibe_travel_hospitality_v1`.`event`.`proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current status of proposal (Draft, Sent, Accepted, Declined, Expired)"
    - name: "approval_status"
      expr: approval_status
      comment: "Internal approval status of proposal"
    - name: "event_type"
      expr: event_type
      comment: "Type of event proposed"
    - name: "issued_month"
      expr: DATE_TRUNC('MONTH', issued_date)
      comment: "Month when proposal was issued"
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', event_start_date)
      comment: "Month when proposed event would start"
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month when client made decision"
    - name: "is_accepted"
      expr: CASE WHEN proposal_status = 'Accepted' THEN TRUE ELSE FALSE END
      comment: "Whether proposal was accepted"
    - name: "is_declined"
      expr: CASE WHEN proposal_status = 'Declined' THEN TRUE ELSE FALSE END
      comment: "Whether proposal was declined"
    - name: "revenue_size_bucket"
      expr: CASE WHEN total_estimated_revenue < 25000 THEN 'Under 25K' WHEN total_estimated_revenue < 100000 THEN '25K-100K' WHEN total_estimated_revenue < 500000 THEN '100K-500K' ELSE '500K+' END
      comment: "Proposed revenue size bucket"
    - name: "response_time_bucket"
      expr: CASE WHEN DATEDIFF(client_response_date, issued_date) <= 7 THEN '0-7 days' WHEN DATEDIFF(client_response_date, issued_date) <= 14 THEN '8-14 days' WHEN DATEDIFF(client_response_date, issued_date) <= 30 THEN '15-30 days' ELSE '30+ days' END
      comment: "Client response time bucket for urgency analysis"
  measures:
    - name: "total_proposals"
      expr: COUNT(1)
      comment: "Total number of proposals issued"
    - name: "accepted_proposals"
      expr: COUNT(CASE WHEN proposal_status = 'Accepted' THEN 1 END)
      comment: "Number of proposals accepted by clients"
    - name: "declined_proposals"
      expr: COUNT(CASE WHEN proposal_status = 'Declined' THEN 1 END)
      comment: "Number of proposals declined by clients"
    - name: "pending_proposals"
      expr: COUNT(CASE WHEN proposal_status = 'Sent' THEN 1 END)
      comment: "Number of proposals awaiting client decision"
    - name: "expired_proposals"
      expr: COUNT(CASE WHEN proposal_status = 'Expired' THEN 1 END)
      comment: "Number of proposals that expired without decision"
    - name: "total_proposed_revenue"
      expr: SUM(CAST(total_estimated_revenue AS DOUBLE))
      comment: "Total revenue proposed across all proposals"
    - name: "avg_proposed_revenue"
      expr: AVG(CAST(total_estimated_revenue AS DOUBLE))
      comment: "Average revenue per proposal"
    - name: "total_proposed_attendance"
      expr: SUM(CAST(expected_attendance AS BIGINT))
      comment: "Total expected attendance across all proposals"
    - name: "total_proposed_room_block"
      expr: SUM(CAST(room_block_quantity AS BIGINT))
      comment: "Total room nights proposed across all proposals"
    - name: "avg_room_block_rate"
      expr: AVG(CAST(room_block_rate AS DOUBLE))
      comment: "Average room rate proposed in proposals"
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts proposed"
    - name: "total_av_package_amount"
      expr: SUM(CAST(av_package_amount AS DOUBLE))
      comment: "Total AV package revenue proposed"
    - name: "total_fb_minimum"
      expr: SUM(CAST(fb_minimum_amount AS DOUBLE))
      comment: "Total F&B minimum commitments proposed"
    - name: "avg_commission_percentage"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission percentage across proposals"
    - name: "unique_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct accounts receiving proposals"
    - name: "unique_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties issuing proposals"
$$;


CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event invoice and accounts receivable metrics for cash flow management and collection effectiveness"
  source: "`vibe_travel_hospitality_v1`.`event`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of invoice (Draft, Issued, Paid, Overdue, Disputed)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment used or expected"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed with client"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month when invoice was issued"
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', payment_due_date)
      comment: "Month when payment is due"
    - name: "payment_received_month"
      expr: DATE_TRUNC('MONTH', payment_received_date)
      comment: "Month when payment was received"
    - name: "is_overdue"
      expr: CASE WHEN invoice_status = 'Overdue' THEN TRUE ELSE FALSE END
      comment: "Whether invoice is past due date"
    - name: "is_disputed"
      expr: CASE WHEN dispute_date IS NOT NULL THEN TRUE ELSE FALSE END
      comment: "Whether invoice has been disputed"
    - name: "aging_bucket"
      expr: CASE WHEN invoice_status = 'Paid' THEN 'Paid' WHEN DATEDIFF(CURRENT_DATE(), payment_due_date) <= 0 THEN 'Current' WHEN DATEDIFF(CURRENT_DATE(), payment_due_date) <= 30 THEN '1-30 days' WHEN DATEDIFF(CURRENT_DATE(), payment_due_date) <= 60 THEN '31-60 days' WHEN DATEDIFF(CURRENT_DATE(), payment_due_date) <= 90 THEN '61-90 days' ELSE '90+ days' END
      comment: "Aging bucket for AR management"
  measures:
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total number of invoices issued"
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Total amount invoiced across all invoices"
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total amount collected from invoices"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance across all invoices"
    - name: "total_room_revenue"
      expr: SUM(CAST(room_revenue_amount AS DOUBLE))
      comment: "Total room revenue invoiced"
    - name: "total_fb_revenue"
      expr: SUM(CAST(fb_revenue_amount AS DOUBLE))
      comment: "Total F&B revenue invoiced"
    - name: "total_space_rental"
      expr: SUM(CAST(space_rental_amount AS DOUBLE))
      comment: "Total space rental revenue invoiced"
    - name: "total_av_equipment"
      expr: SUM(CAST(av_equipment_amount AS DOUBLE))
      comment: "Total AV equipment revenue invoiced"
    - name: "total_miscellaneous_charges"
      expr: SUM(CAST(miscellaneous_charges_amount AS DOUBLE))
      comment: "Total miscellaneous charges invoiced"
    - name: "total_service_charge"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges invoiced"
    - name: "total_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax invoiced"
    - name: "total_subtotal"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total subtotal before service charge and tax"
    - name: "paid_invoices"
      expr: COUNT(CASE WHEN invoice_status = 'Paid' THEN 1 END)
      comment: "Number of fully paid invoices"
    - name: "overdue_invoices"
      expr: COUNT(CASE WHEN invoice_status = 'Overdue' THEN 1 END)
      comment: "Number of overdue invoices"
    - name: "disputed_invoices"
      expr: COUNT(CASE WHEN dispute_date IS NOT NULL THEN 1 END)
      comment: "Number of disputed invoices"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_amount_due AS DOUBLE))
      comment: "Average invoice amount"
    - name: "unique_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct client accounts invoiced"
    - name: "unique_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties issuing invoices"
$$;


CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_function_space`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Function space inventory and capacity metrics for space utilization planning and yield optimization"
  source: "`vibe_travel_hospitality_v1`.`event`.`function_space`"
  dimensions:
    - name: "space_type"
      expr: space_type
      comment: "Type of function space (Ballroom, Meeting Room, Boardroom, Outdoor, etc.)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of space (Active, Inactive, Under Renovation)"
    - name: "floor_level"
      expr: floor_level
      comment: "Floor level where space is located"
    - name: "is_divisible"
      expr: divisible
      comment: "Whether space can be divided into smaller sections"
    - name: "is_outdoor"
      expr: outdoor_space
      comment: "Whether space is outdoor or indoor"
    - name: "has_natural_light"
      expr: natural_light_available
      comment: "Whether space has natural light"
    - name: "is_ada_compliant"
      expr: accessibility_compliant
      comment: "Whether space is ADA compliant"
    - name: "has_catering_kitchen_access"
      expr: catering_kitchen_access
      comment: "Whether space has direct catering kitchen access"
    - name: "size_bucket"
      expr: CASE WHEN square_footage < 500 THEN 'Under 500 sqft' WHEN square_footage < 1000 THEN '500-1000 sqft' WHEN square_footage < 2500 THEN '1000-2500 sqft' WHEN square_footage < 5000 THEN '2500-5000 sqft' ELSE '5000+ sqft' END
      comment: "Space size bucket for capacity planning"
  measures:
    - name: "total_spaces"
      expr: COUNT(1)
      comment: "Total number of function spaces"
    - name: "active_spaces"
      expr: COUNT(CASE WHEN operational_status = 'Active' THEN 1 END)
      comment: "Number of active function spaces"
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total square footage of all function spaces"
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average square footage per function space"
    - name: "total_theater_capacity"
      expr: SUM(CAST(capacity_theater AS BIGINT))
      comment: "Total theater-style seating capacity"
    - name: "total_classroom_capacity"
      expr: SUM(CAST(capacity_classroom AS BIGINT))
      comment: "Total classroom-style seating capacity"
    - name: "total_banquet_capacity"
      expr: SUM(CAST(capacity_banquet AS BIGINT))
      comment: "Total banquet-style seating capacity"
    - name: "total_reception_capacity"
      expr: SUM(CAST(capacity_reception AS BIGINT))
      comment: "Total reception-style standing capacity"
    - name: "total_u_shape_capacity"
      expr: SUM(CAST(capacity_u_shape AS BIGINT))
      comment: "Total U-shape seating capacity"
    - name: "total_hollow_square_capacity"
      expr: SUM(CAST(capacity_hollow_square AS BIGINT))
      comment: "Total hollow square seating capacity"
    - name: "total_cabaret_capacity"
      expr: SUM(CAST(capacity_cabaret AS BIGINT))
      comment: "Total cabaret-style seating capacity"
    - name: "avg_ceiling_height"
      expr: AVG(CAST(ceiling_height_feet AS DOUBLE))
      comment: "Average ceiling height across spaces"
    - name: "avg_rental_rate_full_day"
      expr: AVG(CAST(rental_rate_full_day AS DOUBLE))
      comment: "Average full-day rental rate"
    - name: "avg_rental_rate_half_day"
      expr: AVG(CAST(rental_rate_half_day AS DOUBLE))
      comment: "Average half-day rental rate"
    - name: "avg_rental_rate_hourly"
      expr: AVG(CAST(rental_rate_hourly AS DOUBLE))
      comment: "Average hourly rental rate"
    - name: "avg_setup_time_hours"
      expr: AVG(CAST(setup_time_hours AS DOUBLE))
      comment: "Average setup time required in hours"
    - name: "avg_teardown_time_hours"
      expr: AVG(CAST(teardown_time_hours AS DOUBLE))
      comment: "Average teardown time required in hours"
    - name: "divisible_spaces"
      expr: COUNT(CASE WHEN divisible = TRUE THEN 1 END)
      comment: "Number of divisible function spaces"
    - name: "ada_compliant_spaces"
      expr: COUNT(CASE WHEN accessibility_compliant = TRUE THEN 1 END)
      comment: "Number of ADA compliant spaces"
    - name: "unique_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with function spaces"
$$;


CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_group_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event group room block performance metrics for inventory allocation effectiveness and pickup optimization"
  source: "`vibe_travel_hospitality_v1`.`event`.`event_group_block`"
  dimensions:
    - name: "block_status"
      expr: block_status
      comment: "Current status of room block (Tentative, Definite, Released, Closed)"
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment code for the group block"
    - name: "booking_source_code"
      expr: booking_source_code
      comment: "Source of the booking for attribution"
    - name: "block_start_month"
      expr: DATE_TRUNC('MONTH', block_start_date)
      comment: "Month when room block starts"
    - name: "cutoff_month"
      expr: DATE_TRUNC('MONTH', cutoff_date)
      comment: "Month when block cutoff occurs"
    - name: "is_deposit_required"
      expr: deposit_required_flag
      comment: "Whether deposit is required for block"
    - name: "has_complimentary_rooms"
      expr: CASE WHEN complimentary_room_count IS NOT NULL AND CAST(complimentary_room_count AS INT) > 0 THEN TRUE ELSE FALSE END
      comment: "Whether block includes complimentary rooms"
    - name: "pickup_performance_bucket"
      expr: CASE WHEN pickup_to_block_ratio >= 1.0 THEN 'Over-pickup' WHEN pickup_to_block_ratio >= 0.9 THEN 'Strong (90%+)' WHEN pickup_to_block_ratio >= 0.75 THEN 'Good (75-89%)' WHEN pickup_to_block_ratio >= 0.5 THEN 'Fair (50-74%)' ELSE 'Weak (<50%)' END
      comment: "Pickup performance bucket for block management"
    - name: "attrition_risk_bucket"
      expr: CASE WHEN attrition_percentage > 20 THEN 'High Risk (>20%)' WHEN attrition_percentage > 10 THEN 'Medium Risk (10-20%)' WHEN attrition_percentage > 0 THEN 'Low Risk (0-10%)' ELSE 'No Attrition' END
      comment: "Attrition risk bucket for revenue protection"
  measures:
    - name: "total_blocks"
      expr: COUNT(1)
      comment: "Total number of group room blocks"
    - name: "total_contracted_rooms"
      expr: SUM(CAST(contracted_room_count AS BIGINT))
      comment: "Total room nights contracted across all blocks"
    - name: "total_picked_up_rooms"
      expr: SUM(CAST(picked_up_room_count AS BIGINT))
      comment: "Total room nights actually picked up"
    - name: "total_available_rooms"
      expr: SUM(CAST(available_room_count AS BIGINT))
      comment: "Total room nights still available in blocks"
    - name: "total_complimentary_rooms"
      expr: SUM(CAST(complimentary_room_count AS BIGINT))
      comment: "Total complimentary room nights granted"
    - name: "total_room_nights"
      expr: SUM(CAST(total_room_nights AS BIGINT))
      comment: "Total room nights across all blocks"
    - name: "avg_pickup_ratio"
      expr: AVG(CAST(pickup_to_block_ratio AS DOUBLE))
      comment: "Average pickup-to-block ratio across blocks"
    - name: "avg_group_rate"
      expr: AVG(CAST(group_rate_amount AS DOUBLE))
      comment: "Average group rate across blocks"
    - name: "total_estimated_revenue"
      expr: SUM(CAST(estimated_total_revenue AS DOUBLE))
      comment: "Total estimated revenue from all blocks"
    - name: "total_actual_revenue"
      expr: SUM(CAST(actual_total_revenue AS DOUBLE))
      comment: "Total actual revenue realized from blocks"
    - name: "total_attrition_amount"
      expr: SUM(CAST(attrition_amount AS DOUBLE))
      comment: "Total attrition charges collected"
    - name: "avg_attrition_percentage"
      expr: AVG(CAST(attrition_percentage AS DOUBLE))
      comment: "Average attrition percentage across blocks"
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts for blocks"
    - name: "avg_commission_percentage"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission percentage across blocks"
    - name: "avg_rebate_percentage"
      expr: AVG(CAST(rebate_percentage AS DOUBLE))
      comment: "Average rebate percentage across blocks"
    - name: "definite_blocks"
      expr: COUNT(CASE WHEN block_status = 'Definite' THEN 1 END)
      comment: "Number of definite (confirmed) blocks"
    - name: "tentative_blocks"
      expr: COUNT(CASE WHEN block_status = 'Tentative' THEN 1 END)
      comment: "Number of tentative blocks"
    - name: "unique_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with group blocks"
    - name: "unique_bookings"
      expr: COUNT(DISTINCT event_booking_id)
      comment: "Number of distinct event bookings with room blocks"
$$;
