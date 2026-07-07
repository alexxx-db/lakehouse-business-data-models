-- Metric views for domain: event | Business: Travel Hospitality | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event account portfolio metrics covering lifetime value, credit quality, and account activity. Drives key account management and credit risk decisions for the Events Sales team."
  source: "`vibe_travel_hospitality_v1`.`event`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the account (e.g. Active, Inactive, Closed) — primary dimension for portfolio health analysis."
    - name: "account_type"
      expr: account_type
      comment: "Type of account (e.g. Corporate, Association, Government) — enables segment-level portfolio analysis."
    - name: "credit_status"
      expr: credit_status
      comment: "Credit standing of the account — tracks credit risk exposure in the event account portfolio."
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical of the account — enables industry-level revenue concentration and risk analysis."
    - name: "is_national_account"
      expr: is_national_account
      comment: "Whether the account is a national account — differentiates strategic accounts from local accounts."
    - name: "is_vip_account"
      expr: is_vip_account
      comment: "Whether the account has VIP status — identifies high-priority accounts requiring elevated service."
    - name: "property_id"
      expr: property_id
      comment: "Primary property associated with the account — enables property-level account portfolio analysis."
    - name: "last_event_month"
      expr: DATE_TRUNC('MONTH', last_event_date)
      comment: "Month of the account's most recent event — used for recency analysis and churn risk identification."
  measures:
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total number of event accounts. Baseline portfolio size KPI."
    - name: "total_lifetime_event_spend"
      expr: SUM(CAST(lifetime_event_spend_amount AS DOUBLE))
      comment: "Total lifetime event spend across all accounts. Measures the cumulative revenue value of the account portfolio."
    - name: "avg_lifetime_event_spend"
      expr: AVG(CAST(lifetime_event_spend_amount AS DOUBLE))
      comment: "Average lifetime event spend per account. Indicates typical account value and informs key account investment decisions."
    - name: "total_average_event_spend"
      expr: SUM(CAST(average_event_spend_amount AS DOUBLE))
      comment: "Sum of average event spend amounts across accounts. Proxy for annualized revenue potential of the portfolio."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit across event accounts. Monitors credit exposure and informs credit policy decisions."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended across all event accounts. Measures aggregate credit risk exposure."
    - name: "vip_account_count"
      expr: COUNT(CASE WHEN is_vip_account = TRUE THEN 1 END)
      comment: "Number of VIP accounts. Tracks the size of the high-priority account segment requiring elevated service investment."
    - name: "national_account_count"
      expr: COUNT(CASE WHEN is_national_account = TRUE THEN 1 END)
      comment: "Number of national accounts. Measures strategic account portfolio size and associated revenue concentration."
    - name: "active_account_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN account_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accounts with active status. Measures portfolio health and account retention effectiveness."
    - name: "avg_spend_per_active_account"
      expr: AVG(CASE WHEN account_status = 'Active' THEN average_event_spend_amount END)
      comment: "Average event spend per active account. Benchmarks revenue productivity of the active account base."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_attendee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event attendee engagement and satisfaction metrics covering registration performance, satisfaction scores, and attendance quality. Drives event experience optimization and attendee retention strategy."
  source: "`vibe_travel_hospitality_v1`.`event`.`attendee`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current registration status of the attendee (e.g. Registered, Cancelled, Waitlisted) — primary dimension for attendance pipeline analysis."
    - name: "registration_type"
      expr: registration_type
      comment: "Type of registration (e.g. Full, Day Pass, Virtual) — enables revenue and attendance mix analysis."
    - name: "attendance_mode"
      expr: attendance_mode
      comment: "In-person vs virtual attendance mode — tracks hybrid event participation and associated revenue."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the registration fee — identifies unpaid registrations and collection risk."
    - name: "registration_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Month of registration — used for registration pacing and early-bird vs late registration analysis."
    - name: "check_in_status"
      expr: check_in_status
      comment: "Whether the attendee checked in — measures actual vs registered attendance and no-show rates."
    - name: "marketing_opt_in_flag"
      expr: marketing_opt_in_flag
      comment: "Whether the attendee opted into marketing communications — tracks consent and marketing list growth."
  measures:
    - name: "total_attendees"
      expr: COUNT(1)
      comment: "Total number of event attendees registered. Baseline attendance volume KPI."
    - name: "total_registration_fee_revenue"
      expr: SUM(CAST(registration_fee_amount AS DOUBLE))
      comment: "Total registration fee revenue collected. Measures direct attendee revenue contribution to event P&L."
    - name: "avg_registration_fee"
      expr: AVG(CAST(registration_fee_amount AS DOUBLE))
      comment: "Average registration fee per attendee. Benchmarks pricing strategy and yield per attendee."
    - name: "avg_satisfaction_score"
      expr: AVG(CAST(satisfaction_score AS DOUBLE))
      comment: "Average attendee satisfaction score. Primary event quality KPI — drives post-event improvement decisions and repeat booking likelihood."
    - name: "checked_in_attendee_count"
      expr: COUNT(CASE WHEN check_in_status = 'Checked In' THEN 1 END)
      comment: "Number of attendees who actually checked in. Measures actual attendance vs registered attendance."
    - name: "check_in_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN check_in_status = 'Checked In' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of registered attendees who checked in. Measures no-show rate — critical for F&B guarantee and space planning accuracy."
    - name: "marketing_opt_in_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN marketing_opt_in_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of attendees who opted into marketing. Measures event-driven marketing list growth effectiveness."
    - name: "virtual_attendee_count"
      expr: COUNT(CASE WHEN attendance_mode = 'Virtual' THEN 1 END)
      comment: "Number of virtual attendees. Tracks hybrid event participation and associated digital revenue stream."
    - name: "cancelled_attendee_count"
      expr: COUNT(CASE WHEN registration_status = 'Cancelled' THEN 1 END)
      comment: "Number of attendee cancellations. Monitors cancellation trends that impact F&B guarantees and revenue."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN registration_status = 'Cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of registrations that were cancelled. Measures attrition risk and informs cancellation policy design."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_beo`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Banquet Event Order (BEO) operational and financial metrics covering execution quality, revenue delivery, and service charge performance. Drives F&B operations management and event execution excellence."
  source: "`vibe_travel_hospitality_v1`.`event`.`beo`"
  dimensions:
    - name: "beo_status"
      expr: beo_status
      comment: "Current status of the BEO (e.g. Draft, Confirmed, Completed, Cancelled) — primary operational lifecycle dimension."
    - name: "function_type"
      expr: function_type
      comment: "Type of function covered by the BEO (e.g. Dinner, Meeting, Reception) — enables function-level revenue and cost analysis."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month the BEO event is scheduled — used for operational capacity planning and revenue pacing."
    - name: "property_id"
      expr: property_id
      comment: "Property where the BEO event takes place — enables property-level F&B operations comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the BEO revenue — required for multi-currency financial reporting."
    - name: "setup_style"
      expr: setup_style
      comment: "Room setup configuration — informs space utilization and setup labor planning."
  measures:
    - name: "total_beos"
      expr: COUNT(1)
      comment: "Total number of BEOs issued. Baseline operational volume KPI for F&B and events operations."
    - name: "total_actual_revenue"
      expr: SUM(CAST(actual_revenue AS DOUBLE))
      comment: "Total actual revenue delivered across all BEOs. Primary F&B event revenue KPI."
    - name: "total_estimated_revenue"
      expr: SUM(CAST(estimated_revenue AS DOUBLE))
      comment: "Total estimated revenue across all BEOs. Baseline for BEO revenue actualization analysis."
    - name: "total_service_charge_amount"
      expr: SUM(CAST(service_charge_percentage AS DOUBLE) * CAST(estimated_revenue AS DOUBLE) / 100.0)
      comment: "Estimated total service charge revenue based on service charge percentage and estimated revenue. Tracks service charge contribution to F&B revenue."
    - name: "beo_revenue_actualization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_revenue AS DOUBLE)) / NULLIF(SUM(CAST(estimated_revenue AS DOUBLE)), 0), 2)
      comment: "Actual BEO revenue as a percentage of estimated revenue. Measures F&B execution accuracy — low rates indicate over-promising or under-delivery."
    - name: "avg_actual_revenue_per_beo"
      expr: AVG(CAST(actual_revenue AS DOUBLE))
      comment: "Average actual revenue per BEO. Indicates typical event size and informs staffing and resource allocation."
    - name: "avg_service_charge_percentage"
      expr: AVG(CAST(service_charge_percentage AS DOUBLE))
      comment: "Average service charge rate across BEOs. Monitors service charge policy compliance and revenue contribution."
    - name: "avg_tax_percentage"
      expr: AVG(CAST(tax_percentage AS DOUBLE))
      comment: "Average tax rate applied across BEOs. Supports tax compliance monitoring and rate accuracy audits."
    - name: "completed_beo_count"
      expr: COUNT(CASE WHEN beo_status = 'Completed' THEN 1 END)
      comment: "Number of BEOs successfully completed. Measures operational throughput and execution success rate."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_beo_attendant_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "BEO attendant assignment metrics covering labor hours, cost, quality scores, and completion rates for catering service quality and workforce cost management."
  source: "`vibe_travel_hospitality_v1`.`event`.`beo_attendant_assignment`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "Completion status of the attendant assignment (e.g. Completed, Incomplete, Cancelled) for service delivery tracking."
    - name: "role"
      expr: role
      comment: "Role of the attendant in the BEO (e.g. Server, Captain, Setup) for labor mix and quality analysis."
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', assignment_timestamp)
      comment: "Month of the attendant assignment for trend analysis and labor cost forecasting."
  measures:
    - name: "total_attendant_assignments"
      expr: COUNT(1)
      comment: "Total number of BEO attendant assignments. Baseline labor volume metric for catering workforce management."
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total hours worked by BEO attendants. Primary labor utilization KPI for catering operations cost management."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost for BEO attendant assignments. Primary cost KPI for catering profitability and event cost control."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score for BEO attendant assignments. Measures catering service quality and informs training and performance management."
    - name: "completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN completion_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of BEO attendant assignments completed successfully. Measures catering service reliability and operational execution quality."
    - name: "labor_cost_per_hour"
      expr: ROUND(SUM(CAST(labor_cost AS DOUBLE)) / NULLIF(SUM(CAST(hours_worked AS DOUBLE)), 0), 2)
      comment: "Average labor cost per hour for BEO attendants. Benchmarks catering labor rate efficiency and informs staffing cost modeling."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_beo_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "BEO line-item metrics covering catering revenue, service charges, tax yield, and overage performance for detailed event cost and revenue management."
  source: "`vibe_travel_hospitality_v1`.`event`.`beo_item`"
  dimensions:
    - name: "item_type"
      expr: item_type
      comment: "Type of BEO line item (e.g. Food, Beverage, AV, Rental) for revenue category analysis."
    - name: "item_category"
      expr: item_category
      comment: "Category of the BEO item for detailed cost and revenue breakdown reporting."
    - name: "revenue_category"
      expr: revenue_category
      comment: "Revenue category for GL posting and financial reporting alignment."
    - name: "item_status"
      expr: item_status
      comment: "Current status of the BEO item (e.g. Confirmed, Cancelled, Delivered) for operational tracking."
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of the item (e.g. Billed, Pending, Disputed) for accounts receivable management."
    - name: "dietary_restriction_flag"
      expr: dietary_restriction_flag
      comment: "Whether the item has dietary restrictions, used for compliance and guest experience quality tracking."
    - name: "service_charge_applicable"
      expr: service_charge_applicable
      comment: "Whether service charge applies to this item, used for revenue yield and labor cost recovery analysis."
    - name: "tax_applicable"
      expr: tax_applicable
      comment: "Whether tax applies to this item, used for tax compliance and financial reporting."
  measures:
    - name: "total_beo_items"
      expr: COUNT(1)
      comment: "Total number of BEO line items. Baseline volume metric for catering operations complexity and workload management."
    - name: "total_extended_amount"
      expr: SUM(CAST(extended_amount AS DOUBLE))
      comment: "Total extended amount across all BEO items. Primary revenue KPI for detailed catering revenue reporting."
    - name: "total_service_charge_amount"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges on BEO items. Measures labor cost recovery and ancillary revenue from catering services."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on BEO items. Required for tax compliance reporting and regulatory filing accuracy."
    - name: "total_item_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total revenue including service charges and taxes across BEO items. Comprehensive catering revenue KPI for financial reporting."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across BEO items. Benchmarks catering pricing and informs menu pricing strategy."
    - name: "avg_overage_percentage"
      expr: AVG(CAST(overage_percentage AS DOUBLE))
      comment: "Average overage percentage on BEO items. Measures how often actual quantities exceed guaranteed quantities, informing guarantee policy."
    - name: "total_guaranteed_quantity"
      expr: SUM(CAST(guaranteed_quantity AS DOUBLE))
      comment: "Total guaranteed quantities across BEO items. Measures committed catering volume for procurement and kitchen planning."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual quantities delivered across BEO items. Measures actual catering throughput for operational performance tracking."
    - name: "quantity_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_quantity AS DOUBLE)) / NULLIF(SUM(CAST(guaranteed_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of guaranteed quantities actually delivered. Measures catering execution reliability and operational quality."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_catering_menu`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Catering menu portfolio metrics covering pricing, margin, cost efficiency, and dietary accommodation coverage for menu strategy and profitability management."
  source: "`vibe_travel_hospitality_v1`.`event`.`catering_menu`"
  filter: active_status = 'Active'
  dimensions:
    - name: "menu_type"
      expr: menu_type
      comment: "Type of catering menu (e.g. Breakfast, Lunch, Dinner, Reception) for menu mix and revenue analysis."
    - name: "menu_category"
      expr: menu_category
      comment: "Category of the catering menu for portfolio segmentation and pricing analysis."
    - name: "cuisine_style"
      expr: cuisine_style
      comment: "Cuisine style of the menu for demand analysis and culinary portfolio management."
    - name: "service_style"
      expr: service_style
      comment: "Service style (e.g. Buffet, Plated, Family Style) for labor intensity and cost analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property offering the catering menu for cross-property menu portfolio benchmarking."
    - name: "contains_alcohol"
      expr: contains_alcohol
      comment: "Whether the menu contains alcohol for beverage revenue mix and compliance analysis."
    - name: "sustainability_certified"
      expr: sustainability_certified
      comment: "Whether the menu is sustainability certified for ESG reporting and guest preference alignment."
    - name: "requires_specialty_equipment"
      expr: requires_specialty_equipment
      comment: "Whether the menu requires specialty equipment for operational feasibility and cost planning."
  measures:
    - name: "total_active_menus"
      expr: COUNT(1)
      comment: "Total number of active catering menus. Baseline portfolio size metric for menu management and sales enablement."
    - name: "avg_price_per_person"
      expr: AVG(CAST(price_per_person AS DOUBLE))
      comment: "Average price per person across catering menus. Benchmarks menu pricing and informs catering revenue yield strategy."
    - name: "avg_cost_per_person"
      expr: AVG(CAST(cost_per_person AS DOUBLE))
      comment: "Average cost per person across catering menus. Measures food cost efficiency and informs menu profitability analysis."
    - name: "avg_contribution_margin_pct"
      expr: AVG(CAST(contribution_margin_percent AS DOUBLE))
      comment: "Average contribution margin percentage across catering menus. Primary profitability KPI for menu portfolio management."
    - name: "sustainability_certified_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sustainability_certified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of catering menus that are sustainability certified. Measures ESG commitment in F&B offerings and supports green event marketing."
    - name: "alcohol_menu_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN contains_alcohol = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of catering menus containing alcohol. Measures beverage revenue opportunity in the menu portfolio."
    - name: "avg_price_to_cost_ratio"
      expr: ROUND(AVG(CAST(price_per_person AS DOUBLE)) / NULLIF(AVG(CAST(cost_per_person AS DOUBLE)), 0), 2)
      comment: "Average price-to-cost ratio across catering menus. Measures overall menu pricing efficiency and gross margin multiplier."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core event booking performance metrics covering pipeline value, conversion economics, attrition risk, and booking mix. Primary steering KPI surface for the Events Sales & Revenue team."
  source: "`vibe_travel_hospitality_v1`.`event`.`event_booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current lifecycle status of the event booking (e.g. Tentative, Definite, Cancelled) — primary segmentation for pipeline analysis."
    - name: "mice_category"
      expr: mice_category
      comment: "MICE segment classification (Meetings, Incentives, Conferences, Exhibitions) — drives revenue mix and resource planning."
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', event_start_date)
      comment: "Month the event is scheduled to begin — used for demand forecasting and pacing analysis."
    - name: "event_start_year"
      expr: YEAR(event_start_date)
      comment: "Year the event is scheduled to begin — supports year-over-year trend analysis."
    - name: "inquiry_month"
      expr: DATE_TRUNC('MONTH', inquiry_date)
      comment: "Month the booking inquiry was received — used to measure lead-to-book conversion pacing."
    - name: "property_id"
      expr: property_id
      comment: "Property where the event is hosted — enables property-level performance comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contracted booking value — required for multi-currency revenue reporting."
    - name: "deposit_received_flag"
      expr: deposit_received_flag
      comment: "Whether the deposit has been received — indicates booking commitment level and cash flow status."
  measures:
    - name: "total_bookings"
      expr: COUNT(1)
      comment: "Total number of event bookings. Baseline volume KPI for pipeline sizing and capacity planning."
    - name: "total_contracted_value"
      expr: SUM(CAST(contracted_value_amount AS DOUBLE))
      comment: "Sum of all contracted event values. Primary revenue pipeline measure used in quarterly forecasting and board reporting."
    - name: "avg_contracted_value"
      expr: AVG(CAST(contracted_value_amount AS DOUBLE))
      comment: "Average contracted value per event booking. Indicates deal size trends and mix shift between large and small events."
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission paid or accrued across event bookings. Drives channel cost analysis and net revenue calculations."
    - name: "avg_commission_percentage"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission rate across bookings. Monitors channel cost efficiency and negotiation outcomes."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposits collected or committed across event bookings. Key cash flow and commitment indicator for finance."
    - name: "total_concession_amount"
      expr: SUM(CAST(concession_amount AS DOUBLE))
      comment: "Total value of concessions granted to event clients. Tracks discounting discipline and margin leakage."
    - name: "avg_attrition_clause_percentage"
      expr: AVG(CAST(attrition_clause_percentage AS DOUBLE))
      comment: "Average attrition clause threshold across bookings. Indicates contractual risk exposure if attendance falls short."
    - name: "total_attrition_penalty_amount"
      expr: SUM(CAST(attrition_penalty_amount AS DOUBLE))
      comment: "Total attrition penalties incurred. Directly measures revenue recovery from underperforming group blocks."
    - name: "deposit_received_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN deposit_received_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings with deposit received. Measures booking commitment quality and cash collection effectiveness."
    - name: "net_contracted_value_after_concessions"
      expr: SUM(CAST(contracted_value_amount AS DOUBLE) - CAST(concession_amount AS DOUBLE))
      comment: "Contracted value net of concessions. Represents true committed revenue after discounting, used in net revenue forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event contract financial and compliance metrics covering contracted revenue, deposit schedules, and contract execution quality. Drives contract management and revenue assurance."
  source: "`vibe_travel_hospitality_v1`.`event`.`event_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the event contract (e.g. Draft, Executed, Expired, Cancelled) — primary contract lifecycle dimension."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of event contract — enables contract mix analysis and risk segmentation."
    - name: "execution_month"
      expr: DATE_TRUNC('MONTH', execution_date)
      comment: "Month the contract was executed — used for contract pipeline pacing and revenue recognition timing."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the contract becomes effective — used for forward revenue commitment analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract — required for multi-currency revenue commitment reporting."
    - name: "credit_approval_flag"
      expr: credit_approval_flag
      comment: "Whether credit was approved for the contract — tracks credit risk exposure in the contract portfolio."
    - name: "legal_review_flag"
      expr: legal_review_flag
      comment: "Whether the contract received legal review — monitors governance compliance in contract execution."
    - name: "master_account_billing_flag"
      expr: master_account_billing_flag
      comment: "Whether billing is to a master account — identifies corporate billing arrangements for AR management."
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of event contracts. Baseline contract volume KPI."
    - name: "total_contracted_revenue"
      expr: SUM(CAST(total_contracted_revenue AS DOUBLE))
      comment: "Total revenue committed across all event contracts. Primary revenue assurance KPI — represents legally committed future revenue."
    - name: "total_room_revenue_contracted"
      expr: SUM(CAST(room_revenue AS DOUBLE))
      comment: "Total room revenue committed in event contracts. Supports rooms revenue forecasting from group business."
    - name: "total_fb_revenue_contracted"
      expr: SUM(CAST(fb_revenue AS DOUBLE))
      comment: "Total F&B revenue committed in event contracts. Supports F&B revenue forecasting and minimum guarantee tracking."
    - name: "total_space_rental_contracted"
      expr: SUM(CAST(space_rental_revenue AS DOUBLE))
      comment: "Total space rental revenue committed in event contracts. Tracks function space revenue commitments."
    - name: "total_av_revenue_contracted"
      expr: SUM(CAST(av_equipment_revenue AS DOUBLE))
      comment: "Total AV equipment revenue committed in event contracts. Monitors ancillary revenue commitments."
    - name: "total_initial_deposit_amount"
      expr: SUM(CAST(initial_deposit_amount AS DOUBLE))
      comment: "Total initial deposits committed across event contracts. Measures cash flow commitment from the contract portfolio."
    - name: "avg_attrition_threshold_percentage"
      expr: AVG(CAST(attrition_threshold_percentage AS DOUBLE))
      comment: "Average attrition threshold across event contracts. Indicates contractual risk tolerance and exposure to attrition penalties."
    - name: "legal_reviewed_contract_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN legal_review_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts that received legal review. Measures governance compliance in contract execution — low rates indicate legal risk exposure."
    - name: "credit_approved_contract_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN credit_approval_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts with credit approval. Tracks credit risk management compliance in the event contract portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_group_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group room block performance metrics covering pickup rates, attrition risk, and revenue yield. Critical for rooms revenue management and group contract compliance monitoring."
  source: "`vibe_travel_hospitality_v1`.`event`.`event_group_block`"
  dimensions:
    - name: "block_status"
      expr: block_status
      comment: "Current status of the group block (e.g. Active, Released, Cancelled) — primary dimension for block lifecycle analysis."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment of the group — enables segment-level pickup and yield comparison."
    - name: "block_start_month"
      expr: DATE_TRUNC('MONTH', block_start_date)
      comment: "Month the group block begins — used for demand pacing and rooms revenue forecasting."
    - name: "block_start_year"
      expr: YEAR(block_start_date)
      comment: "Year the group block begins — supports year-over-year group business trend analysis."
    - name: "cutoff_month"
      expr: DATE_TRUNC('MONTH', cutoff_date)
      comment: "Month of the block cutoff date — used to monitor blocks approaching release deadlines."
    - name: "property_id"
      expr: property_id
      comment: "Property hosting the group block — enables property-level group performance comparison."
    - name: "rate_currency_code"
      expr: rate_currency_code
      comment: "Currency of the group rate — required for multi-currency revenue reporting."
    - name: "shoulder_dates_allowed_flag"
      expr: shoulder_dates_allowed_flag
      comment: "Whether shoulder dates are permitted — informs revenue management flexibility and displacement analysis."
  measures:
    - name: "total_group_blocks"
      expr: COUNT(1)
      comment: "Total number of group room blocks. Baseline volume KPI for group business pipeline sizing."
    - name: "total_estimated_revenue"
      expr: SUM(CAST(estimated_total_revenue AS DOUBLE))
      comment: "Total estimated revenue from group blocks. Primary group revenue pipeline measure for forecasting."
    - name: "total_actual_revenue"
      expr: SUM(CAST(actual_total_revenue AS DOUBLE))
      comment: "Total realized revenue from group blocks. Measures group revenue delivery against estimates."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposits collected on group blocks. Tracks cash commitment and financial risk mitigation."
    - name: "total_attrition_amount"
      expr: SUM(CAST(attrition_amount AS DOUBLE))
      comment: "Total attrition penalties incurred on group blocks. Directly measures revenue recovery from underperforming groups."
    - name: "avg_group_rate"
      expr: AVG(CAST(group_rate_amount AS DOUBLE))
      comment: "Average group room rate. Benchmarks group pricing against transient rates and budget targets."
    - name: "avg_pickup_to_block_ratio"
      expr: AVG(CAST(pickup_to_block_ratio AS DOUBLE))
      comment: "Average ratio of rooms picked up to rooms contracted. Core group performance KPI — low ratios trigger attrition clause enforcement."
    - name: "avg_attrition_percentage"
      expr: AVG(CAST(attrition_percentage AS DOUBLE))
      comment: "Average attrition percentage across group blocks. Monitors contractual shortfall trends and informs future contract terms."
    - name: "avg_commission_percentage"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission rate on group blocks. Tracks channel cost for group business."
    - name: "revenue_actualization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_total_revenue AS DOUBLE)) / NULLIF(SUM(CAST(estimated_total_revenue AS DOUBLE)), 0), 2)
      comment: "Actual revenue as a percentage of estimated revenue for group blocks. Measures forecast accuracy and group delivery performance — a key metric in post-event reviews."
    - name: "deposit_required_block_count"
      expr: COUNT(CASE WHEN deposit_required_flag = TRUE THEN 1 END)
      comment: "Number of group blocks requiring a deposit. Tracks financial risk exposure from uncommitted blocks."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_revenue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Realized event revenue performance metrics covering actuals vs budget, revenue mix by category, and per-attendee yield. Core financial reporting surface for the Events P&L."
  source: "`vibe_travel_hospitality_v1`.`event`.`event_revenue`"
  dimensions:
    - name: "revenue_category"
      expr: revenue_category
      comment: "Revenue category (e.g. Room, F&B, AV, Space Rental) — drives revenue mix analysis and departmental P&L."
    - name: "event_type"
      expr: event_type
      comment: "Type of event generating the revenue — enables segment-level yield comparison."
    - name: "revenue_month"
      expr: DATE_TRUNC('MONTH', revenue_date)
      comment: "Month revenue was recognized — primary time dimension for period-over-period financial reporting."
    - name: "revenue_year"
      expr: YEAR(revenue_date)
      comment: "Year revenue was recognized — supports annual budget vs actual analysis."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month the revenue was posted to the GL — used for accounting period reconciliation."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment collection status — identifies outstanding receivables and collection risk."
    - name: "is_voided"
      expr: is_voided
      comment: "Whether the revenue record has been voided — used to filter clean revenue from adjustments."
    - name: "property_id"
      expr: property_id
      comment: "Property where the event revenue was generated — enables property-level P&L comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the revenue record — required for multi-currency financial consolidation."
  measures:
    - name: "total_actual_revenue"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total realized event revenue. Primary top-line KPI for the Events P&L and executive reporting."
    - name: "total_budgeted_revenue"
      expr: SUM(CAST(budgeted_amount AS DOUBLE))
      comment: "Total budgeted event revenue. Baseline for variance analysis against actuals."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after adjustments. Represents clean revenue used in margin and yield calculations."
    - name: "total_revenue_variance"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between actual and budgeted revenue. Drives budget review conversations and forecast corrections."
    - name: "total_service_charge_revenue"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges collected. Tracks ancillary revenue contribution and service charge policy compliance."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on event revenue. Required for tax compliance reporting and remittance."
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commissions paid on event revenue. Measures channel cost and net revenue impact."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total revenue adjustments posted. Monitors correction activity and revenue integrity."
    - name: "avg_per_attendee_revenue"
      expr: AVG(CAST(per_attendee AS DOUBLE))
      comment: "Average revenue generated per attendee. Key yield metric for pricing strategy and event format optimization."
    - name: "avg_group_adr"
      expr: AVG(CAST(group_adr AS DOUBLE))
      comment: "Average daily rate for group room blocks associated with events. Benchmarks group pricing against transient and budget."
    - name: "total_trevpar_contribution"
      expr: SUM(CAST(trevpar_contribution AS DOUBLE))
      comment: "Total TRevPAR contribution from events. Measures events' share of total revenue per available room for hotel-wide yield management."
    - name: "total_revpar_contribution"
      expr: SUM(CAST(revpar_contribution AS DOUBLE))
      comment: "Total RevPAR contribution from event-driven room revenue. Quantifies events' impact on rooms revenue yield."
    - name: "budget_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_amount AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_amount AS DOUBLE)), 0), 2)
      comment: "Actual revenue as a percentage of budgeted revenue. Primary budget performance KPI reviewed in monthly financial steering meetings."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_space_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event space allocation utilization and revenue metrics covering space yield, rental revenue, and allocation efficiency. Drives function space revenue management and scheduling optimization."
  source: "`vibe_travel_hospitality_v1`.`event`.`event_space_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the space allocation (e.g. Confirmed, Tentative, Released) — primary dimension for space pipeline analysis."
    - name: "event_type"
      expr: event_type
      comment: "Type of event using the space — enables event-type-level space utilization analysis."
    - name: "setup_style"
      expr: setup_style
      comment: "Room setup configuration — informs setup labor planning and space configuration mix."
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month of the space allocation — used for space demand pacing and revenue forecasting."
    - name: "property_id"
      expr: property_id
      comment: "Property where the space is allocated — enables property-level space utilization comparison."
    - name: "is_complimentary"
      expr: is_complimentary
      comment: "Whether the space was provided complimentary — tracks concession value and space monetization gaps."
    - name: "space_block_type"
      expr: space_block_type
      comment: "Type of space block (e.g. Meeting, Exhibit, Pre-Function) — enables space type utilization analysis."
    - name: "booking_segment"
      expr: booking_segment
      comment: "Market segment of the booking using the space — drives segment-level space yield analysis."
  measures:
    - name: "total_space_allocations"
      expr: COUNT(1)
      comment: "Total number of space allocations. Baseline space utilization volume KPI."
    - name: "total_rental_charge_revenue"
      expr: SUM(CAST(rental_charge_amount AS DOUBLE))
      comment: "Total rental charge revenue from space allocations. Primary space revenue KPI for function space P&L."
    - name: "avg_rental_charge_per_allocation"
      expr: AVG(CAST(rental_charge_amount AS DOUBLE))
      comment: "Average rental charge per space allocation. Benchmarks space pricing yield and informs rate strategy."
    - name: "complimentary_allocation_count"
      expr: COUNT(CASE WHEN is_complimentary = TRUE THEN 1 END)
      comment: "Number of complimentary space allocations. Tracks concession volume and associated revenue displacement."
    - name: "complimentary_allocation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_complimentary = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of space allocations provided complimentary. Measures discounting discipline in space revenue management."
    - name: "confirmed_allocation_count"
      expr: COUNT(CASE WHEN allocation_status = 'Confirmed' THEN 1 END)
      comment: "Number of confirmed space allocations. Measures committed space pipeline for operational planning."
    - name: "paid_space_revenue"
      expr: SUM(CASE WHEN is_complimentary = FALSE THEN rental_charge_amount ELSE 0 END)
      comment: "Total rental revenue from non-complimentary space allocations. Represents true monetized space revenue."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_function_space`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Function space inventory and pricing metrics covering capacity, rental rate yield, and operational availability. Drives space revenue management and capital investment decisions."
  source: "`vibe_travel_hospitality_v1`.`event`.`function_space`"
  dimensions:
    - name: "space_type"
      expr: space_type
      comment: "Type of function space (e.g. Ballroom, Boardroom, Breakout) — primary dimension for space mix and pricing analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the space (e.g. Active, Under Renovation, Inactive) — tracks available inventory."
    - name: "property_id"
      expr: property_id
      comment: "Property where the function space is located — enables property-level space inventory comparison."
    - name: "floor_level"
      expr: floor_level
      comment: "Floor level of the function space — informs space planning and accessibility analysis."
    - name: "divisible"
      expr: divisible
      comment: "Whether the space can be divided — impacts capacity flexibility and multi-event scheduling."
    - name: "outdoor_space"
      expr: outdoor_space
      comment: "Whether the space is outdoors — differentiates indoor vs outdoor event inventory."
    - name: "accessibility_compliant"
      expr: accessibility_compliant
      comment: "Whether the space meets ADA/accessibility requirements — tracks compliance and inclusive event capability."
  measures:
    - name: "total_function_spaces"
      expr: COUNT(1)
      comment: "Total number of function spaces in inventory. Baseline capacity KPI for space portfolio management."
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total square footage of function space inventory. Measures physical capacity and informs capital investment decisions."
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average size of function spaces. Informs space mix strategy and event format suitability."
    - name: "avg_rental_rate_full_day"
      expr: AVG(CAST(rental_rate_full_day AS DOUBLE))
      comment: "Average full-day rental rate across function spaces. Benchmarks space pricing and informs rate strategy."
    - name: "avg_rental_rate_half_day"
      expr: AVG(CAST(rental_rate_half_day AS DOUBLE))
      comment: "Average half-day rental rate across function spaces. Supports flexible pricing strategy for shorter events."
    - name: "avg_rental_rate_hourly"
      expr: AVG(CAST(rental_rate_hourly AS DOUBLE))
      comment: "Average hourly rental rate across function spaces. Enables yield comparison across booking duration types."
    - name: "total_active_spaces"
      expr: COUNT(CASE WHEN operational_status = 'Active' THEN 1 END)
      comment: "Number of function spaces currently active and available. Tracks sellable inventory for capacity planning."
    - name: "avg_ceiling_height_feet"
      expr: AVG(CAST(ceiling_height_feet AS DOUBLE))
      comment: "Average ceiling height across function spaces. Informs suitability for large-format events and AV setups."
    - name: "avg_setup_time_hours"
      expr: AVG(CAST(setup_time_hours AS DOUBLE))
      comment: "Average setup time required per function space. Drives operational scheduling and turnaround capacity planning."
    - name: "avg_teardown_time_hours"
      expr: AVG(CAST(teardown_time_hours AS DOUBLE))
      comment: "Average teardown time per function space. Combined with setup time, determines minimum turnaround between events."
    - name: "revenue_per_sqft_full_day"
      expr: ROUND(SUM(CAST(rental_rate_full_day AS DOUBLE)) / NULLIF(SUM(CAST(square_footage AS DOUBLE)), 0), 2)
      comment: "Full-day rental revenue per square foot across the space portfolio. Measures space monetization efficiency — a key metric for space investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_inquiry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event sales inquiry and lead funnel metrics covering lead volume, budget qualification, and conversion pipeline. Drives top-of-funnel sales management and lead scoring effectiveness."
  source: "`vibe_travel_hospitality_v1`.`event`.`inquiry`"
  dimensions:
    - name: "inquiry_status"
      expr: inquiry_status
      comment: "Current status of the inquiry (e.g. New, Qualified, Converted, Lost) — primary funnel stage dimension."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Lead qualification status — separates qualified opportunities from unqualified inquiries for pipeline accuracy."
    - name: "event_type"
      expr: event_type
      comment: "Type of event inquired about — enables segment-level lead volume and conversion analysis."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment of the inquiring organization — drives segment-level pipeline and yield analysis."
    - name: "inquiry_month"
      expr: DATE_TRUNC('MONTH', inquiry_date)
      comment: "Month the inquiry was received — primary time dimension for lead volume pacing and trend analysis."
    - name: "preferred_start_month"
      expr: DATE_TRUNC('MONTH', preferred_start_date)
      comment: "Month the client prefers the event to start — used for future demand forecasting."
    - name: "property_id"
      expr: property_id
      comment: "Property the inquiry is directed to — enables property-level lead funnel comparison."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the inquiry arrived — informs marketing channel ROI and lead source effectiveness."
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency of the client budget — required for multi-currency pipeline qualification."
  measures:
    - name: "total_inquiries"
      expr: COUNT(1)
      comment: "Total number of event inquiries received. Top-of-funnel volume KPI for sales capacity planning."
    - name: "avg_budget_range_max"
      expr: AVG(CAST(budget_range_max AS DOUBLE))
      comment: "Average maximum budget stated by inquiring clients. Indicates deal size potential in the lead pipeline."
    - name: "avg_budget_range_min"
      expr: AVG(CAST(budget_range_min AS DOUBLE))
      comment: "Average minimum budget stated by inquiring clients. Sets floor expectations for pipeline qualification."
    - name: "total_budget_range_max"
      expr: SUM(CAST(budget_range_max AS DOUBLE))
      comment: "Total maximum budget potential across all inquiries. Represents the upper bound of the addressable pipeline."
    - name: "converted_inquiry_count"
      expr: COUNT(CASE WHEN inquiry_status = 'Converted' THEN 1 END)
      comment: "Number of inquiries converted to bookings or proposals. Measures top-of-funnel conversion effectiveness."
    - name: "inquiry_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN inquiry_status = 'Converted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inquiries that converted to a booking or proposal. Core lead funnel efficiency KPI — drives sales process improvement decisions."
    - name: "qualified_inquiry_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN qualification_status = 'Qualified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inquiries that passed qualification. Measures lead quality from different channels and segments."
    - name: "catering_required_inquiry_count"
      expr: COUNT(CASE WHEN catering_required_flag = TRUE THEN 1 END)
      comment: "Number of inquiries requiring catering. Informs F&B capacity planning and catering revenue pipeline."
    - name: "av_required_inquiry_count"
      expr: COUNT(CASE WHEN av_equipment_required_flag = TRUE THEN 1 END)
      comment: "Number of inquiries requiring AV equipment. Drives AV resource planning and ancillary revenue forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event invoice and accounts receivable metrics covering billing completeness, outstanding balances, and collection performance. Drives cash flow management and AR aging analysis."
  source: "`vibe_travel_hospitality_v1`.`event`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g. Draft, Sent, Paid, Disputed, Overdue) — primary dimension for AR aging and collection tracking."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment used — informs treasury and payment processing optimization."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month the invoice was issued — used for billing cycle and revenue recognition period analysis."
    - name: "payment_due_month"
      expr: DATE_TRUNC('MONTH', payment_due_date)
      comment: "Month payment is due — drives cash flow forecasting and collection prioritization."
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Country of the billing address — supports geographic revenue and tax reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency — required for multi-currency AR reporting and FX exposure analysis."
  measures:
    - name: "total_invoiced_amount"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Total amount invoiced to event clients. Primary AR volume KPI for finance and collections teams."
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total amount collected against invoices. Measures cash collection effectiveness."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total unpaid balance across all invoices. Core AR aging KPI — directly informs collection prioritization and bad debt provisioning."
    - name: "total_room_revenue_invoiced"
      expr: SUM(CAST(room_revenue_amount AS DOUBLE))
      comment: "Total room revenue component billed on event invoices. Supports rooms revenue reconciliation."
    - name: "total_fb_revenue_invoiced"
      expr: SUM(CAST(fb_revenue_amount AS DOUBLE))
      comment: "Total F&B revenue component billed on event invoices. Supports F&B revenue reconciliation."
    - name: "total_space_rental_invoiced"
      expr: SUM(CAST(space_rental_amount AS DOUBLE))
      comment: "Total space rental revenue billed. Tracks function space monetization."
    - name: "total_av_equipment_invoiced"
      expr: SUM(CAST(av_equipment_amount AS DOUBLE))
      comment: "Total AV equipment charges billed. Monitors ancillary revenue from AV services."
    - name: "total_service_charge_invoiced"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges billed. Tracks service charge revenue and compliance with policy."
    - name: "total_tax_invoiced"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax billed on event invoices. Required for tax remittance reconciliation."
    - name: "collection_rate"
      expr: ROUND(100.0 * SUM(CAST(amount_paid AS DOUBLE)) / NULLIF(SUM(CAST(total_amount_due AS DOUBLE)), 0), 2)
      comment: "Percentage of invoiced amount collected. Primary cash collection efficiency KPI — low rates trigger escalation to collections."
    - name: "avg_outstanding_balance_per_invoice"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average outstanding balance per invoice. Indicates typical collection gap and informs credit policy decisions."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN invoice_status = 'Disputed' THEN 1 END)
      comment: "Number of invoices in dispute status. Tracks billing quality and client satisfaction issues that delay cash collection."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_lost_business`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lost business analysis metrics covering revenue displacement, competitive loss patterns, and win-back opportunity sizing. Drives competitive strategy and sales recovery planning."
  source: "`vibe_travel_hospitality_v1`.`event`.`lost_business`"
  dimensions:
    - name: "loss_reason_category"
      expr: loss_reason_category
      comment: "High-level category of why the business was lost (e.g. Price, Availability, Competitor) — primary dimension for root cause analysis."
    - name: "event_type"
      expr: event_type
      comment: "Type of event lost — enables segment-level competitive loss analysis."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment of the lost business — identifies which segments are most vulnerable to competitive displacement."
    - name: "loss_month"
      expr: DATE_TRUNC('MONTH', loss_date)
      comment: "Month the business was confirmed lost — used for trend analysis and competitive pressure monitoring."
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', event_start_date)
      comment: "Month the lost event was scheduled — used for demand displacement analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property that lost the business — enables property-level competitive performance comparison."
    - name: "loss_status"
      expr: loss_status
      comment: "Current status of the lost business record (e.g. Final, Win-Back Pending) — tracks recovery pipeline."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the lost revenue estimates — required for multi-currency displacement reporting."
  measures:
    - name: "total_lost_events"
      expr: COUNT(1)
      comment: "Total number of lost business events. Baseline competitive loss volume KPI."
    - name: "total_estimated_lost_revenue"
      expr: SUM(CAST(estimated_total_revenue AS DOUBLE))
      comment: "Total estimated revenue displaced by lost business. Primary competitive loss KPI — reviewed in sales strategy meetings to size the opportunity cost."
    - name: "total_estimated_lost_room_revenue"
      expr: SUM(CAST(estimated_room_revenue AS DOUBLE))
      comment: "Total estimated room revenue lost. Quantifies competitive displacement impact on rooms revenue."
    - name: "total_estimated_lost_fb_revenue"
      expr: SUM(CAST(estimated_fb_revenue AS DOUBLE))
      comment: "Total estimated F&B revenue lost. Quantifies competitive displacement impact on F&B revenue."
    - name: "total_estimated_lost_meeting_space_revenue"
      expr: SUM(CAST(estimated_meeting_space_revenue AS DOUBLE))
      comment: "Total estimated meeting space revenue lost. Quantifies function space displacement."
    - name: "avg_competitor_quoted_rate"
      expr: AVG(CAST(competitor_quoted_rate AS DOUBLE))
      comment: "Average rate quoted by the winning competitor. Benchmarks competitive pricing and informs rate strategy adjustments."
    - name: "avg_quoted_group_adr"
      expr: AVG(CAST(quoted_group_adr AS DOUBLE))
      comment: "Average group ADR quoted in lost proposals. Identifies pricing gaps that contributed to losses."
    - name: "price_loss_count"
      expr: COUNT(CASE WHEN loss_reason_category = 'Price' THEN 1 END)
      comment: "Number of events lost due to price. Measures pricing competitiveness — high counts trigger rate strategy review."
    - name: "avg_estimated_lost_revenue_per_event"
      expr: AVG(CAST(estimated_total_revenue AS DOUBLE))
      comment: "Average revenue per lost event. Indicates the typical deal size being displaced and informs win-back prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event sales proposal pipeline metrics covering conversion rates, deal size, and proposal cycle times. Drives sales effectiveness measurement and pipeline management for the Events Sales team."
  source: "`vibe_travel_hospitality_v1`.`event`.`proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current status of the proposal (e.g. Draft, Sent, Won, Lost) — primary dimension for pipeline stage analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Internal approval status of the proposal — tracks governance compliance in the sales process."
    - name: "event_type"
      expr: event_type
      comment: "Type of event the proposal covers — enables segment-level win rate and deal size analysis."
    - name: "issued_month"
      expr: DATE_TRUNC('MONTH', issued_date)
      comment: "Month the proposal was issued — used for sales activity pacing and pipeline velocity analysis."
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', event_start_date)
      comment: "Month the proposed event would begin — used for future demand forecasting."
    - name: "property_id"
      expr: property_id
      comment: "Property the proposal is for — enables property-level sales performance comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the proposal value — required for multi-currency pipeline reporting."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the proposal originated — informs channel effectiveness and lead source ROI."
  measures:
    - name: "total_proposals"
      expr: COUNT(1)
      comment: "Total number of proposals issued. Baseline sales activity volume KPI."
    - name: "total_estimated_revenue_pipeline"
      expr: SUM(CAST(total_estimated_revenue AS DOUBLE))
      comment: "Total estimated revenue across all proposals. Primary sales pipeline value KPI for revenue forecasting."
    - name: "avg_estimated_revenue_per_proposal"
      expr: AVG(CAST(total_estimated_revenue AS DOUBLE))
      comment: "Average estimated revenue per proposal. Indicates deal size trends and mix shift in the pipeline."
    - name: "total_fb_minimum_amount"
      expr: SUM(CAST(fb_minimum_amount AS DOUBLE))
      comment: "Total F&B minimum commitments across proposals. Tracks F&B revenue pipeline and minimum guarantee exposure."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposits proposed across all proposals. Indicates committed cash flow potential from the pipeline."
    - name: "avg_commission_percentage"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission rate across proposals. Monitors channel cost discipline in the sales process."
    - name: "won_proposal_count"
      expr: COUNT(CASE WHEN proposal_status = 'Won' THEN 1 END)
      comment: "Number of proposals converted to bookings. Numerator for win rate calculation — core sales effectiveness KPI."
    - name: "lost_proposal_count"
      expr: COUNT(CASE WHEN proposal_status = 'Lost' THEN 1 END)
      comment: "Number of proposals lost to competitors or cancelled. Drives lost business analysis and competitive intelligence."
    - name: "proposal_win_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN proposal_status = 'Won' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of proposals that converted to bookings. Primary sales conversion KPI — reviewed in every sales performance meeting."
    - name: "avg_room_block_rate"
      expr: AVG(CAST(room_block_rate AS DOUBLE))
      comment: "Average proposed room block rate. Benchmarks group pricing strategy against market and budget targets."
    - name: "approved_proposal_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of proposals that received internal approval. Tracks governance compliance and approval cycle throughput."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_staffing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event staffing labor cost and efficiency metrics covering hours worked, labor cost, and overtime exposure. Drives workforce cost management for event operations."
  source: "`vibe_travel_hospitality_v1`.`event`.`staffing_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the staffing assignment (e.g. Scheduled, Completed, Cancelled) — primary operational dimension."
    - name: "role_type"
      expr: role_type
      comment: "Role type of the assigned staff member — enables labor cost analysis by function and skill category."
    - name: "shift"
      expr: shift
      comment: "Shift assigned (e.g. Morning, Evening, Night) — informs shift mix and premium labor cost analysis."
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', assignment_date)
      comment: "Month of the staffing assignment — used for labor cost pacing and workforce planning."
    - name: "overtime_flag"
      expr: overtime_flag
      comment: "Whether the assignment involved overtime — identifies overtime cost exposure."
  measures:
    - name: "total_staffing_assignments"
      expr: COUNT(1)
      comment: "Total number of staffing assignments. Baseline labor deployment volume KPI."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost across all event staffing assignments. Primary workforce cost KPI for event P&L management."
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total hours worked across all event staffing assignments. Measures labor input and informs productivity analysis."
    - name: "avg_labor_cost_per_assignment"
      expr: AVG(CAST(labor_cost_amount AS DOUBLE))
      comment: "Average labor cost per staffing assignment. Benchmarks staffing cost efficiency across event types and roles."
    - name: "avg_hours_per_assignment"
      expr: AVG(CAST(hours_worked AS DOUBLE))
      comment: "Average hours worked per staffing assignment. Informs shift planning and labor utilization efficiency."
    - name: "overtime_assignment_count"
      expr: COUNT(CASE WHEN overtime_flag = TRUE THEN 1 END)
      comment: "Number of assignments with overtime. Tracks overtime exposure and associated premium labor cost."
    - name: "overtime_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN overtime_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of staffing assignments involving overtime. Measures scheduling efficiency — high rates indicate understaffing or poor shift planning."
    - name: "labor_cost_per_hour"
      expr: ROUND(SUM(CAST(labor_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(hours_worked AS DOUBLE)), 0), 2)
      comment: "Average labor cost per hour across event staffing. Benchmarks labor rate efficiency and informs vendor vs in-house staffing decisions."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`event_staffing_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event staffing metrics covering labor hours, cost efficiency, overtime rates, and assignment performance for event workforce management and cost control."
  source: "`vibe_travel_hospitality_v1`.`event`.`staffing_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the staffing assignment (e.g. Scheduled, Completed, Cancelled) for workforce planning."
    - name: "role_type"
      expr: role_type
      comment: "Role type of the staff assignment (e.g. Captain, Server, Setup) for labor mix and cost analysis."
    - name: "shift"
      expr: shift
      comment: "Shift assigned (e.g. Morning, Evening, Split) for labor scheduling and cost analysis."
    - name: "overtime_flag"
      expr: overtime_flag
      comment: "Whether the assignment involved overtime, used for labor cost management and scheduling optimization."
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', assignment_date)
      comment: "Month of the staffing assignment for trend analysis and labor cost forecasting."
  measures:
    - name: "total_staffing_assignments"
      expr: COUNT(1)
      comment: "Total number of event staffing assignments. Baseline labor volume metric for workforce planning and event operations management."
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total labor hours worked across event staffing assignments. Primary workforce utilization KPI for event operations."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost across event staffing assignments. Primary cost KPI for event profitability and budget management."
    - name: "avg_labor_cost_per_assignment"
      expr: AVG(CAST(labor_cost_amount AS DOUBLE))
      comment: "Average labor cost per staffing assignment. Benchmarks staffing efficiency and informs event cost estimation."
    - name: "avg_hours_per_assignment"
      expr: AVG(CAST(hours_worked AS DOUBLE))
      comment: "Average hours worked per staffing assignment. Measures labor intensity per event role for scheduling optimization."
    - name: "overtime_assignment_count"
      expr: COUNT(CASE WHEN overtime_flag = TRUE THEN 1 END)
      comment: "Number of assignments with overtime. Tracks overtime incidence for labor cost control and scheduling improvement."
    - name: "overtime_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN overtime_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of staffing assignments with overtime. Measures scheduling efficiency and overtime cost exposure."
    - name: "labor_cost_per_hour"
      expr: ROUND(SUM(CAST(labor_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(hours_worked AS DOUBLE)), 0), 2)
      comment: "Average labor cost per hour across event staffing. Benchmarks labor rate efficiency and informs staffing cost modeling."
$$;
