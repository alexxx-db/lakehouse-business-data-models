-- Metric views for domain: event | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-27 02:47:23

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core event booking performance metrics tracking pipeline value, conversion health, attrition risk, and booking economics for MICE and group event sales management."
  source: "`vibe_travel_hospitality_v1`.`event`.`event_booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current lifecycle status of the event booking (e.g. Tentative, Definite, Cancelled) used to segment pipeline by stage."
    - name: "mice_category"
      expr: mice_category
      comment: "MICE classification of the event (Meetings, Incentives, Conferences, Exhibitions) for segment-level performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the booking is denominated, enabling multi-currency revenue analysis."
    - name: "event_start_date"
      expr: DATE_TRUNC('month', event_start_date)
      comment: "Event start month used for time-series trending of bookings and revenue pipeline."
    - name: "inquiry_date_month"
      expr: DATE_TRUNC('month', inquiry_date)
      comment: "Month the inquiry was received, used to measure lead-to-booking conversion velocity."
    - name: "deposit_received_flag"
      expr: deposit_received_flag
      comment: "Indicates whether a deposit has been collected, used to assess booking commitment and cash flow risk."
    - name: "contract_signed_date_month"
      expr: DATE_TRUNC('month', contract_signed_date)
      comment: "Month the contract was signed, used to track contracting velocity and pipeline conversion timing."
  measures:
    - name: "total_contracted_value"
      expr: SUM(CAST(contracted_value_amount AS DOUBLE))
      comment: "Total contracted revenue value across all event bookings. Core pipeline KPI used by sales leadership to assess committed revenue."
    - name: "avg_contracted_value_per_booking"
      expr: AVG(CAST(contracted_value_amount AS DOUBLE))
      comment: "Average contracted value per event booking. Tracks deal size trends and informs pricing and upsell strategy."
    - name: "total_deposit_collected"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts collected across bookings. Measures cash flow security and commitment level of the event pipeline."
    - name: "total_attrition_penalty_exposure"
      expr: SUM(CAST(attrition_penalty_amount AS DOUBLE))
      comment: "Total attrition penalty amounts across bookings. Quantifies financial risk from underperforming room blocks and attendance shortfalls."
    - name: "avg_attrition_clause_percentage"
      expr: AVG(CAST(attrition_clause_percentage AS DOUBLE))
      comment: "Average attrition clause threshold percentage across bookings. Informs contract risk policy and negotiation benchmarks."
    - name: "total_commission_cost"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission paid or accrued on event bookings. Tracks channel cost of sales and informs distribution strategy."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission rate across event bookings. Benchmarks channel cost efficiency and supports rate negotiation decisions."
    - name: "total_concession_amount"
      expr: SUM(CAST(concession_amount AS DOUBLE))
      comment: "Total value of concessions granted on event bookings. Measures discounting pressure and its impact on net revenue."
    - name: "booking_count"
      expr: COUNT(1)
      comment: "Total number of event bookings. Baseline volume KPI for pipeline sizing and conversion funnel analysis."
    - name: "definite_booking_count"
      expr: COUNT(CASE WHEN booking_status = 'Definite' THEN 1 END)
      comment: "Count of bookings in Definite status. Measures confirmed pipeline and is a leading indicator of realized revenue."
    - name: "cancelled_booking_count"
      expr: COUNT(CASE WHEN booking_status = 'Cancelled' THEN 1 END)
      comment: "Count of cancelled event bookings. Tracks cancellation volume to identify risk patterns and inform cancellation policy."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_revenue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular event revenue performance metrics covering actual vs. budgeted revenue, service charges, taxes, commissions, and RevPAR/TRevPAR contributions for event P&L management."
  source: "`vibe_travel_hospitality_v1`.`event`.`event_revenue`"
  filter: is_voided = FALSE
  dimensions:
    - name: "revenue_category"
      expr: revenue_category
      comment: "High-level revenue category (e.g. F&B, Space Rental, AV, Accommodation) for revenue mix analysis."
    - name: "revenue_subcategory"
      expr: subcategory
      comment: "Detailed revenue subcategory for granular P&L reporting and cost center attribution."
    - name: "event_type"
      expr: event_type
      comment: "Type of event generating the revenue (e.g. Conference, Wedding, Gala) for segment-level profitability analysis."
    - name: "revenue_date_month"
      expr: DATE_TRUNC('month', revenue_date)
      comment: "Month of revenue recognition used for time-series trending and period-over-period comparison."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month revenue was posted to the ledger, used for financial close and accrual reconciliation."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment collection status of the revenue record, used to track receivables aging and cash flow."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the revenue record for multi-currency financial reporting."
    - name: "recognition_method"
      expr: recognition_method
      comment: "Revenue recognition method applied (e.g. point-in-time, over-time) for compliance and audit reporting."
    - name: "revenue_source"
      expr: revenue_source
      comment: "Source system or channel originating the revenue record for attribution and reconciliation."
  measures:
    - name: "total_actual_revenue"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual event revenue recognized. Primary top-line KPI for event P&L and executive reporting."
    - name: "total_budgeted_revenue"
      expr: SUM(CAST(budgeted_amount AS DOUBLE))
      comment: "Total budgeted event revenue. Used as the baseline for variance analysis and forecast accuracy measurement."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net event revenue after adjustments. Core profitability KPI used in event-level P&L reporting."
    - name: "total_revenue_variance"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between actual and budgeted revenue. Measures forecast accuracy and operational execution against plan."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total revenue adjustments applied. Tracks correction volume and potential revenue leakage or billing errors."
    - name: "total_service_charge_revenue"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charge revenue collected. Measures ancillary revenue contribution and service charge yield."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts collected on event revenue. Required for tax compliance reporting and remittance reconciliation."
    - name: "total_commission_expense"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission expense on event revenue. Measures channel cost of sales and net revenue impact."
    - name: "avg_revenue_per_attendee"
      expr: AVG(CAST(per_attendee AS DOUBLE))
      comment: "Average revenue generated per attendee. Key yield metric for pricing optimization and event format benchmarking."
    - name: "total_revpar_contribution"
      expr: SUM(CAST(revpar_contribution AS DOUBLE))
      comment: "Total RevPAR contribution from event revenue. Measures the impact of event business on overall property revenue per available room."
    - name: "total_trevpar_contribution"
      expr: SUM(CAST(trevpar_contribution AS DOUBLE))
      comment: "Total TRevPAR contribution from event revenue. Measures total revenue per available room including all event revenue streams."
    - name: "avg_group_adr"
      expr: AVG(CAST(group_adr AS DOUBLE))
      comment: "Average daily rate for group room blocks associated with event bookings. Benchmarks group pricing against transient and budget targets."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event contract financial and compliance metrics tracking contracted revenue composition, deposit obligations, attrition risk, and legal review status for contract governance."
  source: "`vibe_travel_hospitality_v1`.`event`.`event_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the event contract (e.g. Draft, Executed, Expired, Cancelled) for pipeline and compliance tracking."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of event contract (e.g. Master, Addendum, Amendment) for contract portfolio analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract for multi-currency financial reporting."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the contract becomes effective, used for revenue recognition scheduling and pipeline timing."
    - name: "execution_date_month"
      expr: DATE_TRUNC('month', execution_date)
      comment: "Month the contract was executed, used to track contracting velocity and sales cycle length."
    - name: "credit_approval_flag"
      expr: credit_approval_flag
      comment: "Indicates whether credit approval was obtained, used for credit risk and compliance reporting."
    - name: "legal_review_flag"
      expr: legal_review_flag
      comment: "Indicates whether the contract underwent legal review, used for governance and risk management reporting."
    - name: "master_account_billing_flag"
      expr: master_account_billing_flag
      comment: "Indicates master account billing arrangement, used for accounts receivable and billing complexity analysis."
  measures:
    - name: "total_contracted_revenue"
      expr: SUM(CAST(total_contracted_revenue AS DOUBLE))
      comment: "Total contracted revenue value across all event contracts. Primary KPI for committed revenue pipeline and financial forecasting."
    - name: "avg_contracted_revenue_per_contract"
      expr: AVG(CAST(total_contracted_revenue AS DOUBLE))
      comment: "Average contracted revenue per event contract. Tracks deal size trends and informs pricing strategy."
    - name: "total_fb_revenue_contracted"
      expr: SUM(CAST(fb_revenue AS DOUBLE))
      comment: "Total F&B revenue contracted across event contracts. Measures F&B pipeline contribution and catering revenue mix."
    - name: "total_room_revenue_contracted"
      expr: SUM(CAST(room_revenue AS DOUBLE))
      comment: "Total room revenue contracted in event contracts. Measures group room block revenue contribution to overall lodging pipeline."
    - name: "total_space_rental_revenue_contracted"
      expr: SUM(CAST(space_rental_revenue AS DOUBLE))
      comment: "Total space rental revenue contracted. Measures function space yield and rental revenue pipeline."
    - name: "total_av_equipment_revenue_contracted"
      expr: SUM(CAST(av_equipment_revenue AS DOUBLE))
      comment: "Total AV equipment revenue contracted. Tracks ancillary AV revenue contribution and upsell effectiveness."
    - name: "total_initial_deposit_obligated"
      expr: SUM(CAST(initial_deposit_amount AS DOUBLE))
      comment: "Total initial deposit amounts obligated under event contracts. Measures cash flow security and client commitment level."
    - name: "avg_attrition_threshold_percentage"
      expr: AVG(CAST(attrition_threshold_percentage AS DOUBLE))
      comment: "Average attrition threshold percentage across contracts. Benchmarks risk tolerance in contract terms and informs policy decisions."
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of event contracts. Baseline volume metric for contract portfolio management and legal workload planning."
    - name: "executed_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Executed' THEN 1 END)
      comment: "Count of fully executed event contracts. Measures confirmed deal volume and conversion from proposal to signed agreement."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_beo`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Banquet Event Order (BEO) operational and financial metrics tracking estimated vs. actual revenue, service charge yield, and BEO execution performance for catering and event operations management."
  source: "`vibe_travel_hospitality_v1`.`event`.`beo`"
  dimensions:
    - name: "beo_status"
      expr: beo_status
      comment: "Current status of the BEO (e.g. Draft, Confirmed, Completed, Cancelled) for operational pipeline tracking."
    - name: "function_type"
      expr: function_type
      comment: "Type of function covered by the BEO (e.g. Dinner, Reception, Meeting) for event mix and revenue analysis."
    - name: "event_date_month"
      expr: DATE_TRUNC('month', event_date)
      comment: "Month of the BEO event date for time-series operational and revenue trending."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the BEO for multi-currency financial reporting."
    - name: "setup_style"
      expr: setup_style
      comment: "Room setup configuration (e.g. Banquet, Theater, Classroom) used to analyze space utilization and setup cost patterns."
  measures:
    - name: "total_actual_beo_revenue"
      expr: SUM(CAST(actual_revenue AS DOUBLE))
      comment: "Total actual revenue realized from BEOs. Core operational revenue KPI for catering and event execution performance."
    - name: "total_estimated_beo_revenue"
      expr: SUM(CAST(estimated_revenue AS DOUBLE))
      comment: "Total estimated revenue across BEOs. Used as the baseline for actual vs. estimated variance analysis and forecasting accuracy."
    - name: "avg_actual_beo_revenue"
      expr: AVG(CAST(actual_revenue AS DOUBLE))
      comment: "Average actual revenue per BEO. Benchmarks event function value and informs minimum revenue thresholds."
    - name: "avg_service_charge_percentage"
      expr: AVG(CAST(service_charge_percentage AS DOUBLE))
      comment: "Average service charge percentage applied across BEOs. Monitors service charge consistency and compliance with property policy."
    - name: "avg_tax_percentage"
      expr: AVG(CAST(tax_percentage AS DOUBLE))
      comment: "Average tax percentage applied across BEOs. Supports tax compliance monitoring and rate accuracy auditing."
    - name: "beo_count"
      expr: COUNT(1)
      comment: "Total number of BEOs issued. Baseline operational volume metric for staffing, kitchen planning, and event operations capacity."
    - name: "completed_beo_count"
      expr: COUNT(CASE WHEN beo_status = 'Completed' THEN 1 END)
      comment: "Count of completed BEOs. Measures event execution throughput and operational delivery performance."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_beo_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "BEO line-item financial metrics tracking catering item revenue, quantity variances, service charges, and tax yield for food & beverage cost control and menu profitability management."
  source: "`vibe_travel_hospitality_v1`.`event`.`beo_item`"
  dimensions:
    - name: "item_category"
      expr: item_category
      comment: "Category of the BEO line item (e.g. Food, Beverage, Equipment) for revenue mix and cost analysis."
    - name: "item_type"
      expr: item_type
      comment: "Specific type of BEO item for granular menu and service analysis."
    - name: "revenue_category"
      expr: revenue_category
      comment: "Revenue category assigned to the BEO item for P&L and GL reporting."
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of the BEO item (e.g. Billed, Pending, Waived) for accounts receivable and revenue leakage tracking."
    - name: "item_status"
      expr: item_status
      comment: "Operational status of the BEO item for fulfillment tracking and exception management."
    - name: "dietary_restriction_flag"
      expr: dietary_restriction_flag
      comment: "Indicates whether the item has dietary restrictions, used for operational planning and guest satisfaction analysis."
    - name: "service_charge_applicable"
      expr: service_charge_applicable
      comment: "Indicates whether a service charge applies to the item, used for revenue yield and billing accuracy analysis."
    - name: "tax_applicable"
      expr: tax_applicable
      comment: "Indicates whether tax applies to the item, used for tax compliance and revenue reporting."
  measures:
    - name: "total_extended_amount"
      expr: SUM(CAST(extended_amount AS DOUBLE))
      comment: "Total extended line amount across BEO items (unit price × quantity). Core catering revenue KPI for F&B P&L management."
    - name: "total_item_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total amount including service charges and taxes per BEO item. Measures gross catering revenue contribution."
    - name: "total_service_charge_amount"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charge revenue from BEO items. Tracks ancillary service charge yield and billing completeness."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on BEO items. Required for tax remittance reconciliation and compliance reporting."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across BEO items. Benchmarks menu pricing and informs catering rate card decisions."
    - name: "total_guaranteed_quantity"
      expr: SUM(CAST(guaranteed_quantity AS DOUBLE))
      comment: "Total guaranteed quantity across BEO items. Measures committed volume for kitchen production planning and cost control."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual quantity consumed across BEO items. Used with guaranteed quantity to measure overage and waste."
    - name: "avg_overage_percentage"
      expr: AVG(CAST(overage_percentage AS DOUBLE))
      comment: "Average overage percentage across BEO items. Measures production waste and over-ordering relative to guarantees, informing cost control."
    - name: "avg_service_charge_rate"
      expr: AVG(CAST(service_charge_rate AS DOUBLE))
      comment: "Average service charge rate applied to BEO items. Monitors rate consistency and compliance with property service charge policy."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average tax rate applied to BEO items. Supports tax rate accuracy auditing and compliance monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_inquiry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event inquiry pipeline and lead quality metrics tracking lead volume, budget range, conversion status, and channel effectiveness for MICE sales funnel management."
  source: "`vibe_travel_hospitality_v1`.`event`.`inquiry`"
  dimensions:
    - name: "inquiry_status"
      expr: inquiry_status
      comment: "Current status of the inquiry (e.g. New, Qualified, Converted, Lost) for sales funnel stage analysis."
    - name: "event_type"
      expr: event_type
      comment: "Type of event being inquired about for demand mix and segment analysis."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the inquiry was received (e.g. Web, Phone, RFP Platform) for lead source attribution."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Lead qualification status for pipeline quality assessment and sales prioritization."
    - name: "inquiry_date_month"
      expr: DATE_TRUNC('month', inquiry_date)
      comment: "Month the inquiry was received for time-series lead volume and conversion trending."
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency of the client budget for multi-currency pipeline analysis."
    - name: "av_equipment_required_flag"
      expr: av_equipment_required_flag
      comment: "Indicates whether AV equipment is required, used to assess ancillary revenue potential and operational complexity."
    - name: "catering_required_flag"
      expr: catering_required_flag
      comment: "Indicates whether catering is required, used to assess F&B revenue potential and kitchen capacity planning."
  measures:
    - name: "inquiry_count"
      expr: COUNT(1)
      comment: "Total number of event inquiries received. Baseline lead volume KPI for sales pipeline sizing and demand forecasting."
    - name: "converted_inquiry_count"
      expr: COUNT(CASE WHEN inquiry_status = 'Converted' THEN 1 END)
      comment: "Count of inquiries converted to bookings. Measures sales conversion effectiveness and pipeline quality."
    - name: "lost_inquiry_count"
      expr: COUNT(CASE WHEN inquiry_status = 'Lost' THEN 1 END)
      comment: "Count of lost inquiries. Tracks competitive loss rate and informs win/loss analysis and pricing strategy."
    - name: "total_budget_range_max"
      expr: SUM(CAST(budget_range_max AS DOUBLE))
      comment: "Total maximum budget across all inquiries. Measures total addressable pipeline value from inbound leads."
    - name: "avg_budget_range_max"
      expr: AVG(CAST(budget_range_max AS DOUBLE))
      comment: "Average maximum client budget per inquiry. Benchmarks deal size potential and informs sales targeting and resource allocation."
    - name: "avg_budget_range_min"
      expr: AVG(CAST(budget_range_min AS DOUBLE))
      comment: "Average minimum client budget per inquiry. Used with max budget to understand budget range spread and pricing flexibility."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event proposal win/loss and revenue metrics tracking proposal value, conversion rates, commission structures, and deposit terms for MICE sales effectiveness and pricing optimization."
  source: "`vibe_travel_hospitality_v1`.`event`.`proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current status of the proposal (e.g. Sent, Accepted, Declined, Expired) for sales funnel conversion analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Internal approval status of the proposal for governance and pricing authority tracking."
    - name: "event_type"
      expr: event_type
      comment: "Type of event the proposal covers for segment-level win rate and revenue analysis."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the proposal was originated for channel effectiveness and cost-of-sale analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the proposal for multi-currency pipeline reporting."
    - name: "issued_date_month"
      expr: DATE_TRUNC('month', issued_date)
      comment: "Month the proposal was issued for time-series proposal volume and conversion trending."
    - name: "event_start_date_month"
      expr: DATE_TRUNC('month', event_start_date)
      comment: "Month of the proposed event start date for forward-looking revenue pipeline analysis."
  measures:
    - name: "total_estimated_proposal_revenue"
      expr: SUM(CAST(total_estimated_revenue AS DOUBLE))
      comment: "Total estimated revenue across all proposals. Measures total pipeline value at the proposal stage for revenue forecasting."
    - name: "avg_estimated_proposal_revenue"
      expr: AVG(CAST(total_estimated_revenue AS DOUBLE))
      comment: "Average estimated revenue per proposal. Tracks deal size at proposal stage and informs pricing and upsell strategy."
    - name: "total_av_package_value"
      expr: SUM(CAST(av_package_amount AS DOUBLE))
      comment: "Total AV package value across proposals. Measures AV ancillary revenue pipeline and upsell effectiveness."
    - name: "total_fb_minimum_committed"
      expr: SUM(CAST(fb_minimum_amount AS DOUBLE))
      comment: "Total F&B minimum spend committed across proposals. Measures catering revenue pipeline and minimum guarantee exposure."
    - name: "total_deposit_required"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts required across proposals. Measures cash flow security and client commitment at proposal stage."
    - name: "avg_commission_percentage"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission percentage across proposals. Benchmarks channel cost of sales and informs net revenue projections."
    - name: "avg_room_block_rate"
      expr: AVG(CAST(room_block_rate AS DOUBLE))
      comment: "Average room block rate offered in proposals. Benchmarks group pricing competitiveness and rate strategy."
    - name: "proposal_count"
      expr: COUNT(1)
      comment: "Total number of proposals issued. Baseline sales activity KPI for pipeline velocity and sales team productivity."
    - name: "accepted_proposal_count"
      expr: COUNT(CASE WHEN proposal_status = 'Accepted' THEN 1 END)
      comment: "Count of accepted proposals. Measures proposal win rate and sales conversion effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_function_space`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Function space inventory and pricing metrics tracking space capacity, rental rate yield, setup/teardown efficiency, and operational status for meeting space portfolio management."
  source: "`vibe_travel_hospitality_v1`.`event`.`function_space`"
  dimensions:
    - name: "space_type"
      expr: space_type
      comment: "Type of function space (e.g. Ballroom, Boardroom, Breakout) for portfolio mix and pricing analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the space (e.g. Active, Under Renovation, Inactive) for availability and capacity planning."
    - name: "floor_level"
      expr: floor_level
      comment: "Floor level of the function space for location-based demand and pricing analysis."
    - name: "divisible"
      expr: divisible
      comment: "Indicates whether the space can be divided into smaller sections, used for capacity flexibility and utilization analysis."
    - name: "outdoor_space"
      expr: outdoor_space
      comment: "Indicates whether the space is outdoors, used for event type suitability and seasonal demand analysis."
    - name: "accessibility_compliant"
      expr: accessibility_compliant
      comment: "Indicates ADA/accessibility compliance status, used for compliance reporting and inclusive event planning."
    - name: "natural_light_available"
      expr: natural_light_available
      comment: "Indicates availability of natural light, used as a premium feature dimension for pricing and demand analysis."
    - name: "catering_kitchen_access"
      expr: catering_kitchen_access
      comment: "Indicates whether the space has direct catering kitchen access, used for F&B capability and event type suitability analysis."
  measures:
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total square footage of function spaces in the portfolio. Measures total event space inventory for capacity planning."
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average square footage per function space. Benchmarks space size mix and informs portfolio development decisions."
    - name: "avg_rental_rate_full_day"
      expr: AVG(CAST(rental_rate_full_day AS DOUBLE))
      comment: "Average full-day rental rate across function spaces. Benchmarks space pricing and informs rate strategy and competitive positioning."
    - name: "avg_rental_rate_half_day"
      expr: AVG(CAST(rental_rate_half_day AS DOUBLE))
      comment: "Average half-day rental rate across function spaces. Used for pricing consistency analysis and yield optimization."
    - name: "avg_rental_rate_hourly"
      expr: AVG(CAST(rental_rate_hourly AS DOUBLE))
      comment: "Average hourly rental rate across function spaces. Supports short-duration booking pricing strategy."
    - name: "avg_ceiling_height_feet"
      expr: AVG(CAST(ceiling_height_feet AS DOUBLE))
      comment: "Average ceiling height across function spaces. Measures suitability for large-format events and AV/production requirements."
    - name: "avg_setup_time_hours"
      expr: AVG(CAST(setup_time_hours AS DOUBLE))
      comment: "Average setup time required across function spaces. Informs operational scheduling, turnaround capacity, and labor planning."
    - name: "avg_teardown_time_hours"
      expr: AVG(CAST(teardown_time_hours AS DOUBLE))
      comment: "Average teardown time required across function spaces. Used with setup time to calculate total space turnaround time and booking density limits."
    - name: "active_space_count"
      expr: COUNT(CASE WHEN operational_status = 'Active' THEN 1 END)
      comment: "Count of operationally active function spaces. Measures available inventory for event bookings and capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_space_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Space allocation utilization and revenue metrics tracking rental charges, allocation status, setup configurations, and complimentary space usage for function space yield management."
  source: "`vibe_travel_hospitality_v1`.`event`.`space_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the space allocation (e.g. Confirmed, Tentative, Released, Cancelled) for utilization and pipeline analysis."
    - name: "event_type"
      expr: event_type
      comment: "Type of event using the allocated space for demand mix and revenue attribution analysis."
    - name: "setup_style"
      expr: setup_style
      comment: "Setup configuration of the allocated space (e.g. Banquet, Theater, Classroom) for operational planning and capacity analysis."
    - name: "booking_segment"
      expr: booking_segment
      comment: "Market segment of the booking using the space for segment-level utilization and revenue analysis."
    - name: "space_block_type"
      expr: space_block_type
      comment: "Type of space block (e.g. Definite, Tentative, Wash) for pipeline quality and utilization accuracy analysis."
    - name: "is_complimentary"
      expr: is_complimentary
      comment: "Indicates whether the space was allocated on a complimentary basis, used to track concession value and yield impact."
    - name: "allocation_date_month"
      expr: DATE_TRUNC('month', allocation_date)
      comment: "Month of the space allocation for time-series utilization and revenue trending."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the allocation for conflict resolution and demand management analysis."
  measures:
    - name: "total_rental_charge_amount"
      expr: SUM(CAST(rental_charge_amount AS DOUBLE))
      comment: "Total rental charges across space allocations. Core space revenue KPI for function space yield management and P&L reporting."
    - name: "avg_rental_charge_per_allocation"
      expr: AVG(CAST(rental_charge_amount AS DOUBLE))
      comment: "Average rental charge per space allocation. Benchmarks space pricing realization and informs rate optimization."
    - name: "allocation_count"
      expr: COUNT(1)
      comment: "Total number of space allocations. Baseline utilization volume KPI for function space demand and booking density analysis."
    - name: "confirmed_allocation_count"
      expr: COUNT(CASE WHEN allocation_status = 'Confirmed' THEN 1 END)
      comment: "Count of confirmed space allocations. Measures definite space utilization and committed revenue pipeline."
    - name: "complimentary_allocation_count"
      expr: COUNT(CASE WHEN is_complimentary = TRUE THEN 1 END)
      comment: "Count of complimentary space allocations. Tracks concession volume and its impact on space revenue yield."
    - name: "complimentary_rental_value_waived"
      expr: SUM(CASE WHEN is_complimentary = TRUE THEN CAST(rental_charge_amount AS DOUBLE) ELSE 0 END)
      comment: "Total rental value waived on complimentary allocations. Quantifies the revenue cost of space concessions for yield management."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event account portfolio metrics tracking account value, credit exposure, event spend patterns, and VIP/national account segmentation for corporate sales and account management."
  source: "`vibe_travel_hospitality_v1`.`event`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the account (e.g. Active, Inactive, Suspended) for portfolio health and churn analysis."
    - name: "account_type"
      expr: account_type
      comment: "Type of account (e.g. Corporate, Association, Government) for segment-level revenue and strategy analysis."
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical of the account for vertical-specific demand and revenue analysis."
    - name: "credit_status"
      expr: credit_status
      comment: "Credit standing of the account for risk management and accounts receivable prioritization."
    - name: "is_national_account"
      expr: is_national_account
      comment: "Indicates whether the account is a national account, used for tiered account management and strategic sales reporting."
    - name: "is_vip_account"
      expr: is_vip_account
      comment: "Indicates VIP account status for premium service tracking and high-value client management."
    - name: "preferred_event_type"
      expr: preferred_event_type
      comment: "Preferred event type of the account for demand forecasting and targeted sales outreach."
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Country of the account for geographic revenue distribution and international sales analysis."
  measures:
    - name: "total_lifetime_event_spend"
      expr: SUM(CAST(lifetime_event_spend_amount AS DOUBLE))
      comment: "Total lifetime event spend across all accounts. Measures cumulative revenue contribution of the account portfolio and identifies high-value clients."
    - name: "avg_lifetime_event_spend"
      expr: AVG(CAST(lifetime_event_spend_amount AS DOUBLE))
      comment: "Average lifetime event spend per account. Benchmarks account value and informs tiering, investment, and retention decisions."
    - name: "avg_event_spend_per_booking"
      expr: AVG(CAST(average_event_spend_amount AS DOUBLE))
      comment: "Average event spend per booking across accounts. Tracks deal size trends and informs pricing and upsell strategy by account segment."
    - name: "total_credit_limit_exposure"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended across all accounts. Measures aggregate credit risk exposure in the event account portfolio."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per account. Benchmarks credit policy and informs risk-adjusted account management."
    - name: "account_count"
      expr: COUNT(1)
      comment: "Total number of event accounts. Baseline portfolio size KPI for sales coverage, territory planning, and market penetration analysis."
    - name: "vip_account_count"
      expr: COUNT(CASE WHEN is_vip_account = TRUE THEN 1 END)
      comment: "Count of VIP accounts. Measures high-value client base size and informs premium service resource allocation."
    - name: "national_account_count"
      expr: COUNT(CASE WHEN is_national_account = TRUE THEN 1 END)
      comment: "Count of national accounts. Tracks strategic account portfolio size and informs national sales program investment."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_catering_menu`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Catering menu portfolio and pricing metrics tracking menu pricing, cost margins, capacity constraints, and sustainability attributes for F&B menu strategy and profitability management."
  source: "`vibe_travel_hospitality_v1`.`event`.`catering_menu`"
  filter: active_status = 'Active'
  dimensions:
    - name: "menu_category"
      expr: menu_category
      comment: "Category of the catering menu (e.g. Breakfast, Lunch, Dinner, Reception) for menu mix and revenue analysis."
    - name: "menu_type"
      expr: menu_type
      comment: "Type of catering menu (e.g. Buffet, Plated, Stations) for service style analysis and labor cost planning."
    - name: "cuisine_style"
      expr: cuisine_style
      comment: "Cuisine style of the menu for demand analysis and menu development strategy."
    - name: "service_style"
      expr: service_style
      comment: "Service style of the menu for operational planning and labor intensity analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the menu pricing for multi-currency financial reporting."
    - name: "sustainability_certified"
      expr: sustainability_certified
      comment: "Indicates whether the menu is sustainability certified, used for ESG reporting and premium positioning analysis."
    - name: "contains_alcohol"
      expr: contains_alcohol
      comment: "Indicates whether the menu contains alcohol, used for licensing compliance and revenue mix analysis."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the menu became effective for menu lifecycle and seasonal availability analysis."
  measures:
    - name: "avg_price_per_person"
      expr: AVG(CAST(price_per_person AS DOUBLE))
      comment: "Average menu price per person across active catering menus. Benchmarks pricing strategy and informs competitive positioning."
    - name: "avg_cost_per_person"
      expr: AVG(CAST(cost_per_person AS DOUBLE))
      comment: "Average menu cost per person across active catering menus. Measures food cost baseline for margin analysis."
    - name: "avg_contribution_margin_percent"
      expr: AVG(CAST(contribution_margin_percent AS DOUBLE))
      comment: "Average contribution margin percentage across active catering menus. Core profitability KPI for menu engineering and pricing decisions."
    - name: "menu_count"
      expr: COUNT(1)
      comment: "Total number of active catering menus. Measures menu portfolio breadth for variety analysis and operational complexity management."
    - name: "sustainability_certified_menu_count"
      expr: COUNT(CASE WHEN sustainability_certified = TRUE THEN 1 END)
      comment: "Count of sustainability-certified active menus. Tracks ESG portfolio progress and supports sustainability reporting."
$$;