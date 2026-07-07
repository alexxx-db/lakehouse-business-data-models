-- Metric views for domain: channel | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-27 02:47:23

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core channel booking performance metrics tracking revenue, commission costs, cancellations, and rate parity compliance across all distribution channels. Primary KPI surface for channel mix, cost-of-acquisition, and booking quality analysis."
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel_booking`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Distribution channel type (OTA, GDS, Direct, Voice, etc.) — primary segmentation axis for channel mix analysis."
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the booking (confirmed, cancelled, modified) — used to filter active vs. cancelled bookings."
    - name: "cancellation_policy_code"
      expr: cancellation_policy_code
      comment: "Cancellation policy applied to the booking — used to assess risk exposure by policy type."
    - name: "rate_type"
      expr: rate_type
      comment: "Rate type applied to the booking (BAR, negotiated, package, etc.) — key dimension for yield and pricing analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the booking was transacted — used for multi-currency revenue reporting."
    - name: "source_country"
      expr: source_country
      comment: "Country of origin for the booking — supports geographic demand analysis and source market reporting."
    - name: "is_rate_parity_compliant"
      expr: is_rate_parity_compliant
      comment: "Flag indicating whether the booking rate was parity-compliant — critical for OTA contract compliance monitoring."
    - name: "is_cancelled"
      expr: is_cancelled
      comment: "Boolean flag indicating the booking was cancelled — used to segment active vs. cancelled bookings."
    - name: "check_in_month"
      expr: DATE_TRUNC('MONTH', check_in_date)
      comment: "Month of guest check-in — used for demand forecasting and seasonal channel performance analysis."
    - name: "booking_month"
      expr: DATE_TRUNC('MONTH', booking_timestamp)
      comment: "Month the booking was made — used for booking pace and lead-time trend analysis."
  measures:
    - name: "total_gross_booking_value"
      expr: SUM(CAST(gross_booking_value AS DOUBLE))
      comment: "Total gross booking value (GBV) across all channel bookings. Primary top-line revenue KPI for channel performance — directly informs channel investment and mix decisions."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after channel commissions and fees. Represents the actual revenue retained by the property — the key profitability metric for channel evaluation."
    - name: "total_channel_commission_cost"
      expr: SUM(CAST(channel_commission_amount AS DOUBLE))
      comment: "Total commission paid to distribution channels. Directly measures cost-of-acquisition by channel — used to assess channel profitability and negotiate contract terms."
    - name: "total_connectivity_fee_cost"
      expr: SUM(CAST(connectivity_fee_amount AS DOUBLE))
      comment: "Total connectivity fees incurred across all channel bookings. Represents a fixed cost-of-distribution that impacts net channel margin."
    - name: "avg_daily_rate"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average Daily Rate (ADR) across channel bookings. Core hospitality KPI — used to benchmark pricing performance by channel and identify rate dilution."
    - name: "avg_gross_booking_value"
      expr: AVG(CAST(gross_booking_value AS DOUBLE))
      comment: "Average gross booking value per transaction. Measures booking quality by channel — higher values indicate premium channel mix or longer stays."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate percentage across bookings. Used to benchmark channel cost efficiency and identify channels with above-average commission drag."
    - name: "total_bookings"
      expr: COUNT(1)
      comment: "Total number of channel bookings. Baseline volume KPI used to compute conversion rates, cancellation rates, and per-booking cost metrics."
    - name: "cancelled_bookings"
      expr: COUNT(CASE WHEN is_cancelled = TRUE THEN 1 END)
      comment: "Count of cancelled bookings. Used to compute cancellation rate by channel — high cancellation rates signal channel quality issues or policy misalignment."
    - name: "rate_parity_non_compliant_bookings"
      expr: COUNT(CASE WHEN is_rate_parity_compliant = FALSE THEN 1 END)
      comment: "Count of bookings where rate parity was violated. Directly measures OTA contract compliance risk — parity violations can trigger penalties or delisting."
    - name: "distinct_properties_booked"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties receiving bookings through channels. Measures channel reach and distribution breadth across the portfolio."
    - name: "distinct_channels_active"
      expr: COUNT(DISTINCT channel_id)
      comment: "Number of distinct channels generating bookings. Measures active channel utilization — used to identify underperforming or dormant channels."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_commission_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission accrual and cost-of-acquisition metrics tracking total commission liability, payment status, dispute exposure, and channel acquisition cost efficiency. Essential for finance, revenue management, and channel contract governance."
  source: "`vibe_travel_hospitality_v1`.`channel`.`commission_accrual`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Distribution channel type — primary segmentation for commission cost analysis by channel category."
    - name: "accrual_status"
      expr: accrual_status
      comment: "Status of the commission accrual (accrued, paid, disputed, reversed) — used to track liability and payment pipeline."
    - name: "commission_type"
      expr: commission_type
      comment: "Type of commission (base, override, tiered, flat fee) — used to analyze commission structure complexity and cost drivers."
    - name: "commission_basis"
      expr: commission_basis
      comment: "Basis on which commission is calculated (room revenue, total revenue, per-segment) — informs contract structure analysis."
    - name: "is_commissionable"
      expr: is_commissionable
      comment: "Flag indicating whether the booking is subject to commission — used to separate commissionable from non-commissionable revenue."
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Local currency of the commission accrual — used for multi-currency commission liability reporting."
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account code for the commission accrual — used for financial reporting and cost center allocation."
    - name: "accrual_month"
      expr: DATE_TRUNC('MONTH', accrual_date)
      comment: "Month of commission accrual — used for monthly commission liability trending and budget vs. actual analysis."
    - name: "payment_due_month"
      expr: DATE_TRUNC('MONTH', payment_due_date)
      comment: "Month commission payment is due — used for cash flow forecasting and accounts payable planning."
  measures:
    - name: "total_commission_accrued_base"
      expr: SUM(CAST(commission_amount_base AS DOUBLE))
      comment: "Total commission accrued in base (USD) currency. Primary cost-of-acquisition KPI — used by finance to track channel commission liability and budget adherence."
    - name: "total_commission_accrued_local"
      expr: SUM(CAST(commission_amount_local AS DOUBLE))
      comment: "Total commission accrued in local currency. Used for regional P&L reporting and multi-currency commission liability management."
    - name: "total_gross_booking_value"
      expr: SUM(CAST(gross_booking_value AS DOUBLE))
      comment: "Total gross booking value associated with commission accruals. Used as the denominator base for computing effective commission rate on commissionable revenue."
    - name: "total_connectivity_fee_cost"
      expr: SUM(CAST(connectivity_fee_amount AS DOUBLE))
      comment: "Total connectivity fees accrued alongside commissions. Represents the full cost-of-distribution beyond base commission — critical for true channel cost analysis."
    - name: "total_cost_of_acquisition"
      expr: SUM(CAST(total_cost_of_acquisition AS DOUBLE))
      comment: "Total cost of acquisition (commission + connectivity fees + other costs) per channel. The definitive channel profitability KPI — used to rank channels by net contribution."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average effective commission rate across accruals. Used to benchmark actual vs. contracted commission rates and identify rate creep or schedule misapplication."
    - name: "avg_adr_on_commissionable_bookings"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average Daily Rate on bookings generating commission accruals. Used to assess whether high-commission channels are also delivering premium rate bookings."
    - name: "total_accrual_records"
      expr: COUNT(1)
      comment: "Total number of commission accrual records. Baseline volume metric used to compute per-accrual averages and identify processing anomalies."
    - name: "disputed_accruals"
      expr: COUNT(CASE WHEN accrual_status = 'disputed' THEN 1 END)
      comment: "Count of commission accruals in disputed status. Measures contract dispute exposure — high dispute counts signal systemic billing or rate-loading issues."
    - name: "distinct_channels_with_accruals"
      expr: COUNT(DISTINCT channel_id)
      comment: "Number of distinct channels generating commission accruals. Used to measure active commission-generating channel footprint."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel contract portfolio metrics tracking contract status, commission terms, financial exposure, and compliance posture across all distribution agreements. Used by commercial and legal teams to govern channel relationships."
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the channel contract (active, expired, terminated, pending) — primary filter for active contract portfolio analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of channel contract (OTA, GDS, direct connect, wholesale) — used to segment contract portfolio by distribution model."
    - name: "commission_basis"
      expr: commission_basis
      comment: "Basis for commission calculation under the contract — used to analyze commission structure distribution across the portfolio."
    - name: "payment_model"
      expr: payment_model
      comment: "Payment model specified in the contract (merchant, agency, net rate) — used to assess cash flow and revenue recognition implications."
    - name: "rate_parity_clause"
      expr: rate_parity_clause
      comment: "Boolean indicating whether the contract includes a rate parity clause — used to track parity obligation exposure across the portfolio."
    - name: "preferred_partner_tier"
      expr: preferred_partner_tier
      comment: "Preferred partner tier designation in the contract — used to segment contracts by strategic importance and preferential terms."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract — used for multi-currency financial exposure reporting."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the contract became effective — used for contract vintage analysis and renewal pipeline planning."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month the contract expires — used to identify upcoming renewals and manage contract expiry risk."
  measures:
    - name: "total_active_contracts"
      expr: COUNT(CASE WHEN contract_status = 'active' THEN 1 END)
      comment: "Count of currently active channel contracts. Measures the active distribution footprint — used to track portfolio growth and channel relationship health."
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of channel contracts across all statuses. Baseline portfolio size metric used for renewal rate and attrition analysis."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average contracted commission rate across the portfolio. Used by commercial teams to benchmark negotiated rates and identify above-market commission obligations."
    - name: "total_marketing_coop_committed"
      expr: SUM(CAST(marketing_coop_amount AS DOUBLE))
      comment: "Total marketing co-op investment committed across channel contracts. Measures total marketing spend obligation to distribution partners — used for budget planning and ROI assessment."
    - name: "avg_connectivity_fee"
      expr: AVG(CAST(connectivity_fee AS DOUBLE))
      comment: "Average connectivity fee per contract. Used to benchmark technology distribution costs and identify contracts with above-average connectivity overhead."
    - name: "contracts_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Count of contracts expiring within the next 90 days. Critical renewal pipeline KPI — used by commercial teams to prioritize renegotiation and avoid unplanned channel disruptions."
    - name: "contracts_with_rate_parity_clause"
      expr: COUNT(CASE WHEN rate_parity_clause = TRUE THEN 1 END)
      comment: "Count of contracts containing a rate parity clause. Measures parity obligation exposure across the portfolio — used to assess compliance risk and negotiation leverage."
    - name: "distinct_properties_under_contract"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties covered by channel contracts. Measures distribution coverage breadth across the property portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_rate_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel rate plan metrics tracking rate loading coverage, rate adjustment economics, parity applicability, and rate plan portfolio health. Used by revenue management and distribution teams to govern rate strategy across channels."
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel_rate_plan`"
  dimensions:
    - name: "channel_rate_plan_status"
      expr: channel_rate_plan_status
      comment: "Current status of the channel rate plan (active, inactive, pending, expired) — primary filter for active rate plan portfolio."
    - name: "rate_plan_type"
      expr: rate_plan_type
      comment: "Type of rate plan (BAR, corporate, package, promotional) — used to segment rate plan portfolio by pricing strategy."
    - name: "rate_loading_status"
      expr: rate_loading_status
      comment: "Status of rate loading to the channel (loaded, pending, failed) — used to identify rate distribution gaps and loading failures."
    - name: "rate_derivation_method"
      expr: rate_derivation_method
      comment: "Method used to derive the channel rate (flat, percentage off BAR, yield-managed) — used to analyze rate strategy complexity."
    - name: "is_rate_parity_applicable"
      expr: is_rate_parity_applicable
      comment: "Flag indicating whether rate parity rules apply to this rate plan — used to segment parity-obligated vs. exempt rate plans."
    - name: "is_package_rate"
      expr: is_package_rate
      comment: "Flag indicating whether the rate plan is a package rate — used to analyze package vs. room-only rate distribution."
    - name: "is_refundable"
      expr: is_refundable
      comment: "Flag indicating whether the rate plan is refundable — used to analyze refundable vs. non-refundable rate mix by channel."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rate plan — used for multi-currency rate portfolio analysis."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the rate plan becomes effective — used for rate plan activation timeline analysis."
  measures:
    - name: "total_rate_plans"
      expr: COUNT(1)
      comment: "Total number of channel rate plans. Baseline portfolio size metric — used to assess rate plan proliferation and distribution complexity."
    - name: "active_rate_plans"
      expr: COUNT(CASE WHEN channel_rate_plan_status = 'active' THEN 1 END)
      comment: "Count of currently active channel rate plans. Measures live rate distribution footprint — used to ensure adequate rate coverage across channels."
    - name: "avg_channel_rate_amount"
      expr: AVG(CAST(channel_rate_amount AS DOUBLE))
      comment: "Average channel rate amount across all rate plans. Used to benchmark channel rate levels against BAR and identify rate dilution or premium positioning by channel."
    - name: "avg_base_rate_amount"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base rate amount across rate plans. Used as the reference benchmark for computing channel rate adjustments and parity gap analysis."
    - name: "avg_rate_adjustment_value"
      expr: AVG(CAST(rate_adjustment_value AS DOUBLE))
      comment: "Average rate adjustment value applied to channel rates. Measures the average discount or premium applied to channel rates — used to assess channel rate strategy aggressiveness."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate percentage across channel rate plans. Used to benchmark commission cost embedded in rate plans and identify high-cost rate plan configurations."
    - name: "rate_plans_with_loading_failures"
      expr: COUNT(CASE WHEN rate_loading_status = 'failed' THEN 1 END)
      comment: "Count of rate plans with failed loading status. Measures rate distribution failure exposure — loading failures result in rate unavailability and lost bookings."
    - name: "parity_applicable_rate_plans"
      expr: COUNT(CASE WHEN is_rate_parity_applicable = TRUE THEN 1 END)
      comment: "Count of rate plans subject to rate parity obligations. Used to quantify parity compliance scope — informs the scale of parity monitoring required."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_ota_partner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OTA partner portfolio metrics tracking partner quality, commission economics, content performance, and contract health. Used by commercial and distribution teams to manage OTA relationships and optimize the partner mix."
  source: "`vibe_travel_hospitality_v1`.`channel`.`ota_partner`"
  dimensions:
    - name: "partner_status"
      expr: partner_status
      comment: "Current status of the OTA partner relationship (active, inactive, suspended) — primary filter for active partner portfolio analysis."
    - name: "partner_type"
      expr: partner_type
      comment: "Type of OTA partner (global OTA, regional OTA, metasearch, flash sale) — used to segment partner portfolio by business model."
    - name: "commission_model"
      expr: commission_model
      comment: "Commission model used by the OTA (agency, merchant, net rate) — used to analyze revenue recognition and cash flow implications by partner type."
    - name: "preferred_partner"
      expr: preferred_partner
      comment: "Flag indicating preferred partner status — used to segment strategic vs. standard OTA relationships."
    - name: "rate_parity_clause"
      expr: rate_parity_clause
      comment: "Flag indicating whether the OTA contract includes a rate parity clause — used to track parity obligation exposure."
    - name: "primary_market_country_code"
      expr: primary_market_country_code
      comment: "Primary market country of the OTA partner — used for geographic distribution strategy analysis."
    - name: "hq_country_code"
      expr: hq_country_code
      comment: "Headquarters country of the OTA partner — used for regulatory and contractual jurisdiction analysis."
    - name: "connectivity_protocol"
      expr: connectivity_protocol
      comment: "Technical connectivity protocol used by the OTA (XML, API, channel manager) — used to assess integration complexity and maintenance cost."
    - name: "contract_expiry_month"
      expr: DATE_TRUNC('MONTH', contract_expiry_date)
      comment: "Month the OTA contract expires — used for renewal pipeline planning and commercial negotiation scheduling."
  measures:
    - name: "total_ota_partners"
      expr: COUNT(1)
      comment: "Total number of OTA partners in the portfolio. Baseline distribution breadth metric — used to assess channel diversification and dependency concentration."
    - name: "active_ota_partners"
      expr: COUNT(CASE WHEN partner_status = 'active' THEN 1 END)
      comment: "Count of currently active OTA partners. Measures live distribution footprint — used to track partner activation and churn."
    - name: "avg_base_commission_rate_pct"
      expr: AVG(CAST(base_commission_rate_pct AS DOUBLE))
      comment: "Average base commission rate across OTA partners. Used to benchmark the portfolio-level commission cost and identify above-market partner rates during renegotiation."
    - name: "avg_preferred_commission_rate_pct"
      expr: AVG(CAST(preferred_commission_rate_pct AS DOUBLE))
      comment: "Average preferred (negotiated) commission rate across OTA partners. Used to measure the discount achieved through preferred partner programs vs. standard rates."
    - name: "avg_content_score"
      expr: AVG(CAST(content_score AS DOUBLE))
      comment: "Average content quality score across OTA partners. Content score directly impacts search ranking and conversion on OTA platforms — a leading indicator of booking volume performance."
    - name: "avg_review_score"
      expr: AVG(CAST(review_score AS DOUBLE))
      comment: "Average guest review score across OTA partners. Measures guest satisfaction as reported through OTA channels — a key driver of OTA search ranking and conversion."
    - name: "total_connectivity_fee_usd"
      expr: SUM(CAST(connectivity_fee_usd AS DOUBLE))
      comment: "Total connectivity fees across all OTA partners. Measures the fixed technology cost of maintaining OTA integrations — used for distribution cost budgeting."
    - name: "partners_expiring_within_90_days"
      expr: COUNT(CASE WHEN contract_expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Count of OTA partner contracts expiring within 90 days. Critical commercial pipeline KPI — used to prioritize renegotiation and prevent unplanned distribution disruptions."
    - name: "preferred_partners_count"
      expr: COUNT(CASE WHEN preferred_partner = TRUE THEN 1 END)
      comment: "Count of OTA partners with preferred partner status. Measures the depth of strategic OTA relationships — preferred partners typically receive better placement and marketing support."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_inventory_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel inventory allocation metrics tracking allocation utilization, stop-sell exposure, overbooking risk, and channel pickup performance. Used by revenue management to optimize inventory distribution and channel yield."
  source: "`vibe_travel_hospitality_v1`.`channel`.`inventory_allocation`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Distribution channel type for the allocation — primary segmentation for channel-level inventory utilization analysis."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the inventory allocation (open, closed, stop-sell) — used to monitor live inventory availability by channel."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of inventory allocation (allotment, free-sell, on-request) — used to analyze allocation strategy by channel."
    - name: "is_stop_sell"
      expr: is_stop_sell
      comment: "Flag indicating stop-sell restriction is active — used to measure the extent of inventory closure across channels."
    - name: "is_closed_to_arrival"
      expr: is_closed_to_arrival
      comment: "Flag indicating closed-to-arrival restriction — used to track arrival restriction exposure by channel and stay date."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of inventory restriction applied (CTA, CTD, min LOS, max LOS) — used to analyze restriction mix and revenue management strategy."
    - name: "is_rms_generated"
      expr: is_rms_generated
      comment: "Flag indicating the allocation was generated by the Revenue Management System — used to measure RMS automation coverage vs. manual overrides."
    - name: "stay_date_month"
      expr: DATE_TRUNC('MONTH', stay_date_from)
      comment: "Month of the stay date for the allocation — used for forward-looking inventory availability and pickup trend analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the allocation became effective — used for allocation activity timeline analysis."
  measures:
    - name: "avg_channel_allocation_pct"
      expr: AVG(CAST(channel_allocation_pct AS DOUBLE))
      comment: "Average percentage of inventory allocated to each channel. Measures channel inventory share — used by revenue management to optimize allocation mix and prevent channel over-concentration."
    - name: "avg_overbooking_limit_pct"
      expr: AVG(CAST(overbooking_limit_pct AS DOUBLE))
      comment: "Average overbooking limit percentage across allocations. Measures overbooking risk exposure by channel — used to calibrate overbooking strategy and minimize walk risk."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate embedded in inventory allocations. Used to assess the commission cost associated with allocated inventory by channel."
    - name: "total_allocation_records"
      expr: COUNT(1)
      comment: "Total number of inventory allocation records. Baseline volume metric used to measure allocation activity and identify periods of high restriction activity."
    - name: "stop_sell_allocations"
      expr: COUNT(CASE WHEN is_stop_sell = TRUE THEN 1 END)
      comment: "Count of allocations with stop-sell restrictions active. Measures inventory closure exposure — high stop-sell counts indicate aggressive yield management or capacity constraints."
    - name: "rms_generated_allocations"
      expr: COUNT(CASE WHEN is_rms_generated = TRUE THEN 1 END)
      comment: "Count of allocations generated by the Revenue Management System. Measures RMS automation adoption — higher RMS coverage indicates more systematic, data-driven inventory management."
    - name: "distinct_properties_with_allocations"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with channel inventory allocations. Measures portfolio-wide channel distribution coverage — used to identify properties with gaps in channel inventory management."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_gds_connection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GDS (Global Distribution System) connection performance and cost metrics tracking uptime SLA compliance, connectivity fees, commission economics, and connection health across all GDS integrations. Used by distribution and technology teams to manage GDS channel performance."
  source: "`vibe_travel_hospitality_v1`.`channel`.`gds_connection`"
  dimensions:
    - name: "connection_status"
      expr: connection_status
      comment: "Current status of the GDS connection (active, inactive, suspended) — primary filter for live GDS connection monitoring."
    - name: "gds_name"
      expr: gds_name
      comment: "Name of the GDS platform (Amadeus, Sabre, Travelport, etc.) — primary segmentation for GDS-level performance comparison."
    - name: "gds_tier"
      expr: gds_tier
      comment: "Tier classification of the GDS connection — used to segment connections by strategic importance and service level."
    - name: "connectivity_type"
      expr: connectivity_type
      comment: "Type of GDS connectivity (direct connect, switch, channel manager) — used to analyze integration architecture and associated costs."
    - name: "health_check_status"
      expr: health_check_status
      comment: "Current health check status of the GDS connection — used for real-time connection monitoring and incident management."
    - name: "rate_parity_enforced"
      expr: rate_parity_enforced
      comment: "Flag indicating whether rate parity is enforced on this GDS connection — used to track parity compliance posture."
    - name: "lra_enabled"
      expr: lra_enabled
      comment: "Flag indicating Last Room Availability is enabled on the GDS connection — LRA obligations impact inventory management strategy."
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_date)
      comment: "Month the GDS connection was activated — used for connection vintage analysis and onboarding timeline tracking."
  measures:
    - name: "total_gds_connections"
      expr: COUNT(1)
      comment: "Total number of GDS connections across all properties and platforms. Baseline GDS distribution footprint metric."
    - name: "active_gds_connections"
      expr: COUNT(CASE WHEN connection_status = 'active' THEN 1 END)
      comment: "Count of currently active GDS connections. Measures live GDS distribution reach — used to track connection activation and identify inactive connections."
    - name: "avg_uptime_sla_pct"
      expr: AVG(CAST(uptime_sla_pct AS DOUBLE))
      comment: "Average uptime SLA percentage across GDS connections. Measures GDS connectivity reliability — below-SLA uptime directly impacts booking availability and revenue capture."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate across GDS connections. Used to benchmark GDS commission costs and identify above-market rates during contract renegotiation."
    - name: "total_monthly_connectivity_fee_usd"
      expr: SUM(CAST(connectivity_fee_monthly_usd AS DOUBLE))
      comment: "Total monthly connectivity fees across all GDS connections. Measures the fixed technology cost of GDS distribution — used for distribution cost budgeting and ROI analysis."
    - name: "avg_segment_fee_usd"
      expr: AVG(CAST(segment_fee_usd AS DOUBLE))
      comment: "Average per-segment fee across GDS connections. Measures the variable transaction cost of GDS bookings — used to compute total GDS cost-per-booking."
    - name: "connections_below_sla"
      expr: COUNT(CASE WHEN health_check_status != 'healthy' THEN 1 END)
      comment: "Count of GDS connections not in healthy status. Measures active connectivity risk — unhealthy connections result in rate/availability gaps and lost bookings."
    - name: "lra_enabled_connections"
      expr: COUNT(CASE WHEN lra_enabled = TRUE THEN 1 END)
      comment: "Count of GDS connections with Last Room Availability enabled. Measures LRA obligation exposure — LRA connections require full inventory disclosure and limit yield management flexibility."
    - name: "distinct_properties_on_gds"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties connected to GDS platforms. Measures GDS distribution coverage across the property portfolio — used to identify properties lacking GDS presence."
$$;