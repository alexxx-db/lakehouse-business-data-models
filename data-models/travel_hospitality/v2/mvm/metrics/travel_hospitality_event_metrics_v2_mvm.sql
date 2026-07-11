-- Metric views for domain: event | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-07-10 22:17:24

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the event booking pipeline — covers pipeline value, conversion health, attrition risk, and booking mix. Used by Sales, Revenue Management, and C-suite to steer group-event strategy."
  source: "`vibe_travel_hospitality_v1`.`event`.`event_booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current lifecycle status of the event booking (e.g. Tentative, Definite, Cancelled) — primary filter for pipeline vs. confirmed revenue views."
    - name: "mice_category"
      expr: mice_category
      comment: "MICE segment classification (Meetings, Incentives, Conferences, Exhibitions) — drives segment-level revenue strategy."
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', event_start_date)
      comment: "Month the event is scheduled to begin — used for demand forecasting and capacity planning."
    - name: "event_start_year"
      expr: YEAR(event_start_date)
      comment: "Year the event is scheduled to begin — supports annual trend analysis."
    - name: "inquiry_month"
      expr: DATE_TRUNC('MONTH', inquiry_date)
      comment: "Month the initial inquiry was received — measures lead-generation seasonality."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the booking is denominated — required for multi-currency revenue reporting."
    - name: "deposit_received_flag"
      expr: deposit_received_flag
      comment: "Indicates whether the deposit has been collected — used to track financial commitment and cash-flow risk."
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the booking — enables property-level performance benchmarking."
  measures:
    - name: "total_bookings"
      expr: COUNT(1)
      comment: "Total number of event bookings in the selected period — baseline volume KPI for the group-sales pipeline."
    - name: "total_contracted_value"
      expr: SUM(CAST(contracted_value_amount AS DOUBLE))
      comment: "Sum of all contracted booking values — represents the total committed revenue pipeline for group events."
    - name: "avg_contracted_value_per_booking"
      expr: AVG(CAST(contracted_value_amount AS DOUBLE))
      comment: "Average contracted value per event booking — indicates deal size trends and helps benchmark against targets."
    - name: "total_commission_cost"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission paid to intermediaries — directly impacts net revenue and channel cost management."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission rate across bookings — used to evaluate channel cost efficiency and negotiate rate structures."
    - name: "total_attrition_penalty"
      expr: SUM(CAST(attrition_penalty_amount AS DOUBLE))
      comment: "Total attrition penalties incurred — measures revenue recovery from under-delivered room blocks and attendance shortfalls."
    - name: "avg_attrition_clause_pct"
      expr: AVG(CAST(attrition_clause_percentage AS DOUBLE))
      comment: "Average attrition clause threshold across bookings — informs contract risk exposure and negotiation benchmarks."
    - name: "total_concession_amount"
      expr: SUM(CAST(concession_amount AS DOUBLE))
      comment: "Total value of concessions granted to clients — tracks discounting behavior and its impact on net revenue."
    - name: "total_deposit_collected"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposits collected across bookings — measures cash-flow security and financial commitment from clients."
    - name: "distinct_accounts_booked"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique accounts with event bookings — measures client base breadth and account penetration."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_revenue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial performance metrics for event revenue — covers actual vs. budget variance, net revenue, service charges, taxes, and per-attendee yield. Primary source of truth for event P&L reporting."
  source: "`vibe_travel_hospitality_v1`.`event`.`event_revenue`"
  filter: is_voided = FALSE
  dimensions:
    - name: "revenue_category"
      expr: revenue_category
      comment: "High-level revenue category (e.g. F&B, AV, Space Rental, Room Block) — enables revenue-mix analysis."
    - name: "event_type"
      expr: event_type
      comment: "Type of event generating the revenue (e.g. Conference, Wedding, Corporate Meeting) — drives segment-level yield analysis."
    - name: "revenue_date_month"
      expr: DATE_TRUNC('MONTH', revenue_date)
      comment: "Month revenue was recognized — used for monthly P&L trending and budget cycle comparisons."
    - name: "revenue_date_year"
      expr: YEAR(revenue_date)
      comment: "Year revenue was recognized — supports annual performance benchmarking."
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the revenue record — used to track collections and outstanding receivables."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the revenue record — required for multi-currency financial consolidation."
    - name: "revenue_source"
      expr: revenue_source
      comment: "Origin of the revenue (e.g. direct, OTA, corporate) — informs channel profitability analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property where the event revenue was generated — enables property-level P&L comparison."
    - name: "subcategory"
      expr: subcategory
      comment: "Granular revenue sub-classification within a category — supports detailed revenue-mix drill-down."
  measures:
    - name: "total_actual_revenue"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual event revenue recognized — the primary top-line KPI for event financial performance."
    - name: "total_budgeted_revenue"
      expr: SUM(CAST(budgeted_amount AS DOUBLE))
      comment: "Total budgeted event revenue — baseline for variance analysis against actuals."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after adjustments — the true bottom-line event revenue figure used in P&L reporting."
    - name: "total_revenue_variance"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total actual-vs-budget revenue variance — negative values signal underperformance requiring management intervention."
    - name: "total_service_charge_revenue"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges collected — a significant ancillary revenue stream in hospitality event operations."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts collected on event revenue — required for tax compliance and remittance reporting."
    - name: "total_commission_paid"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commissions paid on event revenue — measures channel cost and impacts net revenue."
    - name: "avg_per_attendee_revenue"
      expr: AVG(CAST(per_attendee AS DOUBLE))
      comment: "Average revenue generated per attendee — a key yield metric for pricing and package optimization."
    - name: "avg_group_adr"
      expr: AVG(CAST(group_adr AS DOUBLE))
      comment: "Average daily rate for group room blocks associated with events — benchmarks group pricing against transient rates."
    - name: "total_trevpar_contribution"
      expr: SUM(CAST(trevpar_contribution AS DOUBLE))
      comment: "Total RevPAR contribution from event revenue — links event performance to the property-wide TRevPAR KPI used by Revenue Management."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total revenue adjustments posted — large values indicate billing corrections or disputes requiring operational review."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_inquiry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead funnel and conversion metrics for event inquiries — measures pipeline health, lead quality, budget sizing, and conversion velocity. Used by Sales and Marketing to optimize lead management."
  source: "`vibe_travel_hospitality_v1`.`event`.`inquiry`"
  dimensions:
    - name: "inquiry_status"
      expr: inquiry_status
      comment: "Current status of the inquiry (e.g. New, Qualified, Converted, Lost) — primary funnel stage indicator."
    - name: "event_type"
      expr: event_type
      comment: "Type of event being inquired about — enables segment-level conversion analysis."
    - name: "inquiry_month"
      expr: DATE_TRUNC('MONTH', inquiry_date)
      comment: "Month the inquiry was received — tracks lead volume seasonality and campaign effectiveness."
    - name: "inquiry_year"
      expr: YEAR(inquiry_date)
      comment: "Year the inquiry was received — supports year-over-year lead pipeline comparison."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the inquiry was received (e.g. website, OTA, direct sales) — informs channel ROI analysis."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Sales qualification stage of the inquiry — used to measure lead quality and prioritize follow-up."
    - name: "catering_required_flag"
      expr: catering_required_flag
      comment: "Whether catering is required — used to forecast F&B revenue potential from the inquiry pipeline."
    - name: "av_equipment_required_flag"
      expr: av_equipment_required_flag
      comment: "Whether AV equipment is required — used to forecast AV ancillary revenue from the pipeline."
    - name: "property_id"
      expr: property_id
      comment: "Property the inquiry is directed to — enables property-level lead pipeline analysis."
  measures:
    - name: "total_inquiries"
      expr: COUNT(1)
      comment: "Total number of event inquiries received — top-of-funnel volume KPI for group sales pipeline management."
    - name: "converted_inquiries"
      expr: COUNT(CASE WHEN inquiry_status = 'Converted' THEN 1 END)
      comment: "Number of inquiries that converted to a booking — measures sales effectiveness and funnel throughput."
    - name: "lost_inquiries"
      expr: COUNT(CASE WHEN inquiry_status = 'Lost' THEN 1 END)
      comment: "Number of inquiries lost to competitors or abandoned — used to identify conversion gaps and competitive pressure."
    - name: "avg_budget_range_max"
      expr: AVG(CAST(budget_range_max AS DOUBLE))
      comment: "Average maximum budget declared by inquiring clients — indicates pipeline revenue potential and client spending capacity."
    - name: "avg_budget_range_min"
      expr: AVG(CAST(budget_range_min AS DOUBLE))
      comment: "Average minimum budget declared by inquiring clients — sets the floor for revenue expectations from the pipeline."
    - name: "total_pipeline_budget_max"
      expr: SUM(CAST(budget_range_max AS DOUBLE))
      comment: "Total maximum budget across all open inquiries — represents the upper bound of the addressable revenue pipeline."
    - name: "distinct_client_organizations"
      expr: COUNT(DISTINCT client_organization_name)
      comment: "Number of unique client organizations in the inquiry pipeline — measures market reach and prospect diversity."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Proposal pipeline and win-rate metrics — tracks proposal volume, estimated revenue at stake, conversion to contract, and pricing competitiveness. Used by Sales leadership to manage close rates and revenue at risk."
  source: "`vibe_travel_hospitality_v1`.`event`.`proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current status of the proposal (e.g. Draft, Sent, Accepted, Declined) — primary pipeline stage indicator."
    - name: "approval_status"
      expr: approval_status
      comment: "Internal approval status of the proposal — tracks compliance with pricing authority and approval workflows."
    - name: "event_type"
      expr: event_type
      comment: "Type of event the proposal covers — enables segment-level win-rate and revenue analysis."
    - name: "issued_month"
      expr: DATE_TRUNC('MONTH', issued_date)
      comment: "Month the proposal was issued — tracks proposal velocity and sales cycle timing."
    - name: "issued_year"
      expr: YEAR(issued_date)
      comment: "Year the proposal was issued — supports annual win-rate trending."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the proposal originated — informs channel-level close-rate analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the proposal — required for multi-currency pipeline valuation."
    - name: "property_id"
      expr: property_id
      comment: "Property the proposal is for — enables property-level pipeline and win-rate benchmarking."
  measures:
    - name: "total_proposals"
      expr: COUNT(1)
      comment: "Total number of proposals issued — measures sales activity volume and pipeline coverage."
    - name: "accepted_proposals"
      expr: COUNT(CASE WHEN proposal_status = 'Accepted' THEN 1 END)
      comment: "Number of proposals accepted by clients — numerator for win-rate calculation and sales effectiveness measurement."
    - name: "declined_proposals"
      expr: COUNT(CASE WHEN proposal_status = 'Declined' THEN 1 END)
      comment: "Number of proposals declined — used to identify pricing or competitive issues driving lost business."
    - name: "total_estimated_revenue_pipeline"
      expr: SUM(CAST(total_estimated_revenue AS DOUBLE))
      comment: "Total estimated revenue across all active proposals — represents the full value of the sales pipeline at stake."
    - name: "avg_estimated_revenue_per_proposal"
      expr: AVG(CAST(total_estimated_revenue AS DOUBLE))
      comment: "Average estimated revenue per proposal — benchmarks deal size and informs resource allocation for proposal development."
    - name: "total_av_package_value"
      expr: SUM(CAST(av_package_amount AS DOUBLE))
      comment: "Total AV package value across proposals — measures ancillary revenue potential in the pipeline."
    - name: "total_fb_minimum_committed"
      expr: SUM(CAST(fb_minimum_amount AS DOUBLE))
      comment: "Total F&B minimum commitments across proposals — forecasts catering revenue floor from the pipeline."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission rate offered in proposals — tracks channel cost commitments and margin impact."
    - name: "avg_room_block_rate"
      expr: AVG(CAST(room_block_rate AS DOUBLE))
      comment: "Average room block rate offered in proposals — benchmarks group pricing strategy against market rates."
    - name: "total_deposit_committed"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts committed in proposals — measures financial commitment secured from prospective clients."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_beo`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Banquet Event Order (BEO) execution and financial metrics — tracks estimated vs. actual revenue, service charge yield, and BEO completion rates. Used by Catering Operations and Finance to manage event execution quality and billing accuracy."
  source: "`vibe_travel_hospitality_v1`.`event`.`beo`"
  dimensions:
    - name: "beo_status"
      expr: beo_status
      comment: "Current status of the BEO (e.g. Draft, Confirmed, Completed, Cancelled) — primary operational stage indicator."
    - name: "function_type"
      expr: function_type
      comment: "Type of function covered by the BEO (e.g. Dinner, Reception, Meeting) — enables function-level revenue and cost analysis."
    - name: "event_date_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month the event covered by the BEO takes place — used for operational capacity and revenue forecasting."
    - name: "event_date_year"
      expr: YEAR(event_date)
      comment: "Year the event covered by the BEO takes place — supports annual catering revenue trending."
    - name: "setup_style"
      expr: setup_style
      comment: "Room setup configuration (e.g. Banquet, Theater, Classroom) — informs space utilization and labor planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the BEO — required for multi-currency revenue reporting."
    - name: "property_id"
      expr: property_id
      comment: "Property where the BEO event takes place — enables property-level catering performance benchmarking."
  measures:
    - name: "total_beos"
      expr: COUNT(1)
      comment: "Total number of BEOs — measures catering operational volume and workload."
    - name: "total_actual_beo_revenue"
      expr: SUM(CAST(actual_revenue AS DOUBLE))
      comment: "Total actual revenue from BEOs — the realized catering revenue figure used in event P&L reporting."
    - name: "total_estimated_beo_revenue"
      expr: SUM(CAST(estimated_revenue AS DOUBLE))
      comment: "Total estimated revenue from BEOs — used as the forecast baseline for catering revenue planning."
    - name: "avg_actual_beo_revenue"
      expr: AVG(CAST(actual_revenue AS DOUBLE))
      comment: "Average actual revenue per BEO — benchmarks catering event yield and informs pricing strategy."
    - name: "total_service_charge_revenue"
      expr: SUM(CAST(service_charge_percentage AS DOUBLE) * CAST(actual_revenue AS DOUBLE) / 100.0)
      comment: "Estimated total service charge revenue derived from BEO actuals — a significant ancillary revenue stream in catering operations."
    - name: "avg_tax_rate_pct"
      expr: AVG(CAST(tax_percentage AS DOUBLE))
      comment: "Average tax rate applied across BEOs — used for tax liability forecasting and compliance review."
    - name: "avg_service_charge_rate_pct"
      expr: AVG(CAST(service_charge_percentage AS DOUBLE))
      comment: "Average service charge rate across BEOs — benchmarks service charge consistency and identifies outliers."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_beo_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-item level catering and event service metrics — tracks item revenue, quantity variances, service charges, and tax yield at the most granular level. Used by Catering Management and Finance for menu profitability and billing accuracy."
  source: "`vibe_travel_hospitality_v1`.`event`.`beo_item`"
  dimensions:
    - name: "item_category"
      expr: item_category
      comment: "Category of the BEO line item (e.g. Food, Beverage, AV, Décor) — enables category-level revenue and cost analysis."
    - name: "item_type"
      expr: item_type
      comment: "Specific type classification of the BEO item — supports granular menu and service mix analysis."
    - name: "revenue_category"
      expr: revenue_category
      comment: "Revenue classification of the item — aligns BEO items to the property revenue chart of accounts."
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of the line item — used to track unbilled items and collections risk."
    - name: "item_status"
      expr: item_status
      comment: "Operational status of the item (e.g. Confirmed, Cancelled, Delivered) — tracks execution completeness."
    - name: "dietary_restriction_flag"
      expr: dietary_restriction_flag
      comment: "Indicates whether the item has a dietary restriction — used to measure special dietary demand and menu planning."
    - name: "service_charge_applicable"
      expr: service_charge_applicable
      comment: "Whether a service charge applies to this item — used to validate service charge revenue completeness."
    - name: "tax_applicable"
      expr: tax_applicable
      comment: "Whether tax applies to this item — used for tax compliance and revenue reporting accuracy."
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the BEO item — enables property-level catering item performance analysis."
  measures:
    - name: "total_extended_amount"
      expr: SUM(CAST(extended_amount AS DOUBLE))
      comment: "Total extended line-item amount (unit price × quantity) — the primary catering item revenue KPI."
    - name: "total_service_charge_amount"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges on BEO items — measures ancillary service charge revenue at the item level."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on BEO items — required for tax remittance and compliance reporting."
    - name: "total_item_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total all-in item revenue including service charges and taxes — the gross billing amount per item."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across BEO items — benchmarks pricing consistency and identifies outliers."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of items ordered — measures catering volume and supports procurement planning."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual quantity delivered — compared against ordered quantity to measure fulfillment accuracy."
    - name: "avg_overage_percentage"
      expr: AVG(CAST(overage_percentage AS DOUBLE))
      comment: "Average overage percentage across items — measures waste and over-production, directly impacting food cost and margin."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_function_space`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Function space inventory and pricing metrics — tracks space capacity, rental rate yield, and operational readiness. Used by Revenue Management and Operations to optimize space utilization and pricing strategy."
  source: "`vibe_travel_hospitality_v1`.`event`.`function_space`"
  filter: operational_status = 'Active'
  dimensions:
    - name: "space_type"
      expr: space_type
      comment: "Classification of the function space (e.g. Ballroom, Boardroom, Breakout) — enables space-type level yield analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the space — used to track available vs. unavailable inventory."
    - name: "floor_level"
      expr: floor_level
      comment: "Floor level of the function space — used for operational logistics and guest experience analysis."
    - name: "divisible"
      expr: divisible
      comment: "Whether the space can be divided into smaller sections — impacts capacity planning and multi-event scheduling."
    - name: "outdoor_space"
      expr: outdoor_space
      comment: "Whether the space is outdoors — relevant for seasonal demand and weather-risk planning."
    - name: "accessibility_compliant"
      expr: accessibility_compliant
      comment: "Whether the space meets accessibility compliance standards — required for regulatory reporting and inclusive event planning."
    - name: "natural_light_available"
      expr: natural_light_available
      comment: "Whether the space has natural light — a key client preference factor influencing booking decisions."
    - name: "property_id"
      expr: property_id
      comment: "Property the function space belongs to — enables property-level space inventory and yield benchmarking."
  measures:
    - name: "total_function_spaces"
      expr: COUNT(1)
      comment: "Total number of function spaces in inventory — baseline capacity metric for event space portfolio management."
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total square footage of function space inventory — measures physical capacity available for event bookings."
    - name: "avg_square_footage_per_space"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average square footage per function space — benchmarks space size mix and informs portfolio optimization."
    - name: "avg_full_day_rental_rate"
      expr: AVG(CAST(rental_rate_full_day AS DOUBLE))
      comment: "Average full-day rental rate across function spaces — benchmarks space pricing and informs rate strategy."
    - name: "avg_half_day_rental_rate"
      expr: AVG(CAST(rental_rate_half_day AS DOUBLE))
      comment: "Average half-day rental rate — used to evaluate short-duration pricing yield vs. full-day rates."
    - name: "avg_hourly_rental_rate"
      expr: AVG(CAST(rental_rate_hourly AS DOUBLE))
      comment: "Average hourly rental rate — supports flexible pricing strategy for short-duration bookings."
    - name: "avg_ceiling_height_feet"
      expr: AVG(CAST(ceiling_height_feet AS DOUBLE))
      comment: "Average ceiling height across function spaces — relevant for AV and production event suitability assessment."
    - name: "avg_setup_time_hours"
      expr: AVG(CAST(setup_time_hours AS DOUBLE))
      comment: "Average setup time required per space — impacts scheduling efficiency and turnaround capacity between events."
    - name: "avg_teardown_time_hours"
      expr: AVG(CAST(teardown_time_hours AS DOUBLE))
      comment: "Average teardown time per space — combined with setup time determines minimum gap between consecutive bookings."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_space_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Space allocation utilization and revenue metrics — tracks rental charges, allocation status, and setup style mix. Used by Revenue Management and Operations to maximize space yield and minimize idle inventory."
  source: "`vibe_travel_hospitality_v1`.`event`.`space_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the space allocation (e.g. Tentative, Confirmed, Released) — primary utilization pipeline indicator."
    - name: "event_type"
      expr: event_type
      comment: "Type of event using the allocated space — enables event-type level space utilization analysis."
    - name: "setup_style"
      expr: setup_style
      comment: "Room setup configuration for the allocation — informs labor planning and turnaround scheduling."
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month of the space allocation — used for monthly utilization trending and capacity forecasting."
    - name: "allocation_year"
      expr: YEAR(allocation_date)
      comment: "Year of the space allocation — supports annual space utilization benchmarking."
    - name: "is_complimentary"
      expr: is_complimentary
      comment: "Whether the space was allocated on a complimentary basis — used to track revenue displacement from comp space."
    - name: "space_block_type"
      expr: space_block_type
      comment: "Type of space block (e.g. Definite, Tentative, Wash) — used in demand forecasting and inventory management."
    - name: "booking_segment"
      expr: booking_segment
      comment: "Market segment of the booking using the space — enables segment-level space yield analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property where the space is allocated — enables property-level utilization benchmarking."
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total number of space allocations — measures space booking volume and operational throughput."
    - name: "confirmed_allocations"
      expr: COUNT(CASE WHEN allocation_status = 'Confirmed' THEN 1 END)
      comment: "Number of confirmed space allocations — measures definite demand and committed space utilization."
    - name: "complimentary_allocations"
      expr: COUNT(CASE WHEN is_complimentary = TRUE THEN 1 END)
      comment: "Number of complimentary space allocations — tracks revenue displacement from comp space grants."
    - name: "total_rental_charge_revenue"
      expr: SUM(CAST(rental_charge_amount AS DOUBLE))
      comment: "Total rental charges from space allocations — the primary space revenue KPI for function space yield management."
    - name: "avg_rental_charge_per_allocation"
      expr: AVG(CAST(rental_charge_amount AS DOUBLE))
      comment: "Average rental charge per space allocation — benchmarks space pricing yield and informs rate optimization."
    - name: "paid_vs_total_allocation_ratio"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_complimentary = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocations that are revenue-generating (non-complimentary) — measures the monetization rate of space inventory."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event contract financial and compliance metrics — tracks contracted revenue by category, attrition risk, deposit schedules, and legal review status. Used by Finance, Legal, and Sales leadership to manage contract risk and revenue commitment."
  source: "`vibe_travel_hospitality_v1`.`event`.`event_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the event contract (e.g. Draft, Executed, Expired, Cancelled) — primary contract lifecycle indicator."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of event contract (e.g. Corporate, Social, Government) — enables segment-level contract risk analysis."
    - name: "execution_month"
      expr: DATE_TRUNC('MONTH', execution_date)
      comment: "Month the contract was executed — tracks contract signing velocity and pipeline conversion timing."
    - name: "execution_year"
      expr: YEAR(execution_date)
      comment: "Year the contract was executed — supports annual contracted revenue trending."
    - name: "credit_approval_flag"
      expr: credit_approval_flag
      comment: "Whether credit was approved for the contract — used to assess financial risk exposure in the contract portfolio."
    - name: "legal_review_flag"
      expr: legal_review_flag
      comment: "Whether the contract underwent legal review — tracks compliance with contract governance policies."
    - name: "master_account_billing_flag"
      expr: master_account_billing_flag
      comment: "Whether billing is directed to a master account — used for corporate account billing consolidation analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract — required for multi-currency revenue commitment reporting."
    - name: "property_id"
      expr: property_id
      comment: "Property the contract is associated with — enables property-level contract portfolio analysis."
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of event contracts — measures contract portfolio size and sales execution volume."
    - name: "total_contracted_revenue"
      expr: SUM(CAST(total_contracted_revenue AS DOUBLE))
      comment: "Total revenue committed across all event contracts — the definitive contracted revenue pipeline figure for financial planning."
    - name: "total_room_revenue_contracted"
      expr: SUM(CAST(room_revenue AS DOUBLE))
      comment: "Total room revenue committed in event contracts — measures group room block revenue contribution."
    - name: "total_fb_revenue_contracted"
      expr: SUM(CAST(fb_revenue AS DOUBLE))
      comment: "Total F&B revenue committed in event contracts — measures catering revenue commitment from the contract portfolio."
    - name: "total_space_rental_revenue_contracted"
      expr: SUM(CAST(space_rental_revenue AS DOUBLE))
      comment: "Total space rental revenue committed in event contracts — measures function space revenue commitment."
    - name: "total_av_revenue_contracted"
      expr: SUM(CAST(av_equipment_revenue AS DOUBLE))
      comment: "Total AV equipment revenue committed in event contracts — measures ancillary AV revenue in the pipeline."
    - name: "total_initial_deposit_committed"
      expr: SUM(CAST(initial_deposit_amount AS DOUBLE))
      comment: "Total initial deposits committed across contracts — measures financial security and cash-flow from the contract portfolio."
    - name: "avg_attrition_threshold_pct"
      expr: AVG(CAST(attrition_threshold_percentage AS DOUBLE))
      comment: "Average attrition threshold percentage across contracts — benchmarks contract risk exposure and negotiation outcomes."
    - name: "contracts_with_legal_review"
      expr: COUNT(CASE WHEN legal_review_flag = TRUE THEN 1 END)
      comment: "Number of contracts that underwent legal review — measures governance compliance in the contract process."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event account portfolio and lifetime value metrics — tracks account spend, credit exposure, and VIP/national account mix. Used by Sales and Finance to manage key account relationships and credit risk."
  source: "`vibe_travel_hospitality_v1`.`event`.`account`"
  filter: account_status = 'Active'
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the event account (e.g. Active, Inactive, Closed) — primary account health indicator."
    - name: "account_type"
      expr: account_type
      comment: "Classification of the account (e.g. Corporate, Association, Social) — enables segment-level account portfolio analysis."
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical of the account — used to identify high-value industry segments and target prospecting."
    - name: "credit_status"
      expr: credit_status
      comment: "Credit standing of the account — used to manage financial risk and payment terms."
    - name: "is_national_account"
      expr: is_national_account
      comment: "Whether the account is a national account — national accounts typically represent the highest-value client relationships."
    - name: "is_vip_account"
      expr: is_vip_account
      comment: "Whether the account is classified as VIP — used to prioritize service levels and sales attention."
    - name: "preferred_event_type"
      expr: preferred_event_type
      comment: "The account's preferred event type — used for targeted sales outreach and package customization."
    - name: "property_id"
      expr: property_id
      comment: "Primary property associated with the account — enables property-level account portfolio analysis."
  measures:
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total number of event accounts — measures the size of the managed account portfolio."
    - name: "total_lifetime_event_spend"
      expr: SUM(CAST(lifetime_event_spend_amount AS DOUBLE))
      comment: "Total lifetime event spend across all accounts — the primary account portfolio value KPI for key account management."
    - name: "avg_lifetime_event_spend"
      expr: AVG(CAST(lifetime_event_spend_amount AS DOUBLE))
      comment: "Average lifetime event spend per account — benchmarks account value and identifies high-potential accounts."
    - name: "avg_event_spend_per_booking"
      expr: AVG(CAST(average_event_spend_amount AS DOUBLE))
      comment: "Average spend per event booking across accounts — measures per-event yield and informs pricing strategy."
    - name: "total_credit_limit_exposure"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended across accounts — measures aggregate credit risk exposure in the account portfolio."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per account — benchmarks credit policy consistency and identifies outliers."
    - name: "vip_account_count"
      expr: COUNT(CASE WHEN is_vip_account = TRUE THEN 1 END)
      comment: "Number of VIP accounts — measures the size of the highest-priority client segment requiring elevated service."
    - name: "national_account_count"
      expr: COUNT(CASE WHEN is_national_account = TRUE THEN 1 END)
      comment: "Number of national accounts — measures the scale of the enterprise-level client portfolio driving multi-property revenue."
$$;