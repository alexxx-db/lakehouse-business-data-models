-- Metric views for domain: channel | Business: Travel Hospitality | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_booking_source`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Booking Source business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`booking_source`"
  dimensions:
    - name: "Activation Date"
      expr: activation_date
    - name: "Api Connectivity Type"
      expr: api_connectivity_type
    - name: "Attribution Hierarchy Level"
      expr: attribution_hierarchy_level
    - name: "Booking Source Status"
      expr: booking_source_status
    - name: "Booking Window Max Days"
      expr: booking_window_max_days
    - name: "Booking Window Min Days"
      expr: booking_window_min_days
    - name: "Cancellation Policy Code"
      expr: cancellation_policy_code
    - name: "Channel Type"
      expr: channel_type
    - name: "Commission Basis"
      expr: commission_basis
    - name: "Connectivity Fee Applicable"
      expr: connectivity_fee_applicable
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crs Source Code"
      expr: crs_source_code
    - name: "Currency Code"
      expr: currency_code
    - name: "Deactivation Date"
      expr: deactivation_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Booking Source"
      expr: COUNT(DISTINCT booking_source_id)
    - name: "Total Commission Rate"
      expr: SUM(commission_rate)
    - name: "Average Commission Rate"
      expr: AVG(commission_rate)
    - name: "Total Connectivity Fee Amount"
      expr: SUM(connectivity_fee_amount)
    - name: "Average Connectivity Fee Amount"
      expr: AVG(connectivity_fee_amount)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_channel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`channel`"
  dimensions:
    - name: "Activation Date"
      expr: activation_date
    - name: "Bar Eligible"
      expr: bar_eligible
    - name: "Cancellation Policy Code"
      expr: cancellation_policy_code
    - name: "Channel Category"
      expr: channel_category
    - name: "Channel Code"
      expr: channel_code
    - name: "Channel Description"
      expr: channel_description
    - name: "Channel Name"
      expr: channel_name
    - name: "Channel Status"
      expr: channel_status
    - name: "Channel Type"
      expr: channel_type
    - name: "Commission Basis"
      expr: commission_basis
    - name: "Connectivity Method"
      expr: connectivity_method
    - name: "Content Distribution Enabled"
      expr: content_distribution_enabled
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crs Channel Code"
      expr: crs_channel_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Channel"
      expr: COUNT(DISTINCT channel_id)
    - name: "Total Booking Fee Usd"
      expr: SUM(booking_fee_usd)
    - name: "Average Booking Fee Usd"
      expr: AVG(booking_fee_usd)
    - name: "Total Commission Rate Pct"
      expr: SUM(commission_rate_pct)
    - name: "Average Commission Rate Pct"
      expr: AVG(commission_rate_pct)
    - name: "Total Connectivity Fee Usd"
      expr: SUM(connectivity_fee_usd)
    - name: "Average Connectivity Fee Usd"
      expr: AVG(connectivity_fee_usd)
    - name: "Total Sla Uptime Pct"
      expr: SUM(sla_uptime_pct)
    - name: "Average Sla Uptime Pct"
      expr: AVG(sla_uptime_pct)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core channel booking performance metrics covering revenue, acquisition cost, cancellation, and rate parity compliance. Primary KPI surface for channel mix and distribution cost analysis."
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel_booking`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Distribution channel type (OTA, GDS, Direct, Wholesale) for channel mix analysis."
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the booking (confirmed, cancelled, modified) for funnel and cancellation analysis."
    - name: "rate_type"
      expr: rate_type
      comment: "Rate type applied to the booking (BAR, negotiated, package) for rate strategy analysis."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment code for segmented revenue and channel performance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency revenue reporting."
    - name: "check_in_month"
      expr: DATE_TRUNC('month', check_in_date)
      comment: "Check-in month for time-series trend analysis of booking volumes and revenue."
    - name: "booking_month"
      expr: DATE_TRUNC('month', booking_timestamp)
      comment: "Month the booking was made for lead-time and booking-window analysis."
    - name: "is_rate_parity_compliant"
      expr: is_rate_parity_compliant
      comment: "Flag indicating whether the booking was rate-parity compliant for compliance monitoring."
    - name: "is_cancelled"
      expr: is_cancelled
      comment: "Cancellation flag for cancellation rate segmentation."
    - name: "source_country"
      expr: source_country
      comment: "Country of booking origin for geographic demand analysis."
  measures:
    - name: "total_gross_booking_value"
      expr: SUM(CAST(gross_booking_value AS DOUBLE))
      comment: "Total gross booking value across all channel bookings. Primary revenue KPI for channel performance and distribution cost benchmarking."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after channel commissions and fees. Measures true revenue contribution per channel after distribution costs."
    - name: "total_channel_commission"
      expr: SUM(CAST(channel_commission_amount AS DOUBLE))
      comment: "Total commission paid to distribution channels. Critical cost-of-acquisition metric for channel profitability analysis."
    - name: "total_connectivity_fees"
      expr: SUM(CAST(connectivity_fee_amount AS DOUBLE))
      comment: "Total connectivity fees incurred across channel bookings. Contributes to total cost of distribution."
    - name: "avg_adr"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average Daily Rate across channel bookings. Key pricing KPI used to benchmark channel rate performance against property ADR targets."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate percentage across bookings. Drives channel cost-of-acquisition benchmarking and contract renegotiation decisions."
    - name: "total_bookings"
      expr: COUNT(1)
      comment: "Total number of channel bookings. Baseline volume metric for channel throughput and market share analysis."
    - name: "cancelled_bookings"
      expr: COUNT(CASE WHEN is_cancelled = TRUE THEN 1 END)
      comment: "Count of cancelled bookings. Used to compute cancellation rate and assess channel booking quality."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_cancelled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings that were cancelled. High cancellation rates signal channel quality issues or policy misalignment."
    - name: "rate_parity_violation_count"
      expr: COUNT(CASE WHEN is_rate_parity_compliant = FALSE THEN 1 END)
      comment: "Number of bookings where rate parity was violated. Directly triggers contract enforcement and channel audit actions."
    - name: "rate_parity_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_rate_parity_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings that are rate-parity compliant. Steers channel contract compliance monitoring and OTA relationship management."
    - name: "distinct_channels"
      expr: COUNT(DISTINCT channel_id)
      comment: "Number of distinct active channels generating bookings. Measures channel portfolio breadth and diversification."
    - name: "distinct_properties_booked"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties receiving channel bookings. Indicates channel reach across the property portfolio."
    - name: "avg_gross_booking_value"
      expr: AVG(CAST(gross_booking_value AS DOUBLE))
      comment: "Average gross booking value per channel booking. Measures booking quality and average transaction size by channel."
    - name: "net_revenue_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(net_revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_booking_value AS DOUBLE)), 0), 2)
      comment: "Net revenue as a percentage of gross booking value. Measures channel efficiency after distribution costs — key for channel profitability ranking."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_channel_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel Booking business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`channel_booking`"
  dimensions:
    - name: "Booking Status"
      expr: booking_status
    - name: "Booking Timestamp"
      expr: booking_timestamp
    - name: "Cancellation Policy Code"
      expr: cancellation_policy_code
    - name: "Cancellation Timestamp"
      expr: cancellation_timestamp
    - name: "Channel Type"
      expr: channel_type
    - name: "Check In Date"
      expr: check_in_date
    - name: "Check Out Date"
      expr: check_out_date
    - name: "Corporate Account Code"
      expr: corporate_account_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crs Booking Reference"
      expr: crs_booking_reference
    - name: "Currency Code"
      expr: currency_code
    - name: "Gds Segment Number"
      expr: gds_segment_number
    - name: "Is Cancelled"
      expr: is_cancelled
    - name: "Is Modified"
      expr: is_modified
    - name: "Is Rate Parity Compliant"
      expr: is_rate_parity_compliant
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Channel Booking"
      expr: COUNT(DISTINCT channel_booking_id)
    - name: "Total Adr"
      expr: SUM(adr)
    - name: "Average Adr"
      expr: AVG(adr)
    - name: "Total Channel Commission Amount"
      expr: SUM(channel_commission_amount)
    - name: "Average Channel Commission Amount"
      expr: AVG(channel_commission_amount)
    - name: "Total Commission Rate Pct"
      expr: SUM(commission_rate_pct)
    - name: "Average Commission Rate Pct"
      expr: AVG(commission_rate_pct)
    - name: "Total Connectivity Fee Amount"
      expr: SUM(connectivity_fee_amount)
    - name: "Average Connectivity Fee Amount"
      expr: AVG(connectivity_fee_amount)
    - name: "Total Gross Booking Value"
      expr: SUM(gross_booking_value)
    - name: "Average Gross Booking Value"
      expr: AVG(gross_booking_value)
    - name: "Total Net Revenue Amount"
      expr: SUM(net_revenue_amount)
    - name: "Average Net Revenue Amount"
      expr: AVG(net_revenue_amount)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_channel_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel Contract business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`channel_contract`"
  dimensions:
    - name: "Bar Access"
      expr: bar_access
    - name: "Cancellation Policy Code"
      expr: cancellation_policy_code
    - name: "Commission Basis"
      expr: commission_basis
    - name: "Connectivity Fee Type"
      expr: connectivity_fee_type
    - name: "Content Requirements"
      expr: content_requirements
    - name: "Contract Name"
      expr: contract_name
    - name: "Contract Number"
      expr: contract_number
    - name: "Contract Status"
      expr: contract_status
    - name: "Contract Type"
      expr: contract_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Sharing Agreement"
      expr: data_sharing_agreement
    - name: "Dispute Resolution Jurisdiction"
      expr: dispute_resolution_jurisdiction
    - name: "Dispute Resolution Mechanism"
      expr: dispute_resolution_mechanism
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Channel Contract"
      expr: COUNT(DISTINCT channel_contract_id)
    - name: "Total Commission Rate"
      expr: SUM(commission_rate)
    - name: "Average Commission Rate"
      expr: AVG(commission_rate)
    - name: "Total Connectivity Fee"
      expr: SUM(connectivity_fee)
    - name: "Average Connectivity Fee"
      expr: AVG(connectivity_fee)
    - name: "Total Marketing Coop Amount"
      expr: SUM(marketing_coop_amount)
    - name: "Average Marketing Coop Amount"
      expr: AVG(marketing_coop_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel contract governance metrics covering contract status, commission terms, and compliance obligations. Drives channel contract lifecycle management and renewal decisions."
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of channel contract (OTA, GDS, wholesale, direct) for contract portfolio analysis."
    - name: "contract_status"
      expr: contract_status
      comment: "Current contract status (active, expired, terminated, pending) for contract lifecycle management."
    - name: "commission_basis"
      expr: commission_basis
      comment: "Commission basis in the contract for cost structure analysis."
    - name: "payment_model"
      expr: payment_model
      comment: "Payment model (merchant, agency, net) for financial settlement analysis."
    - name: "preferred_partner_tier"
      expr: preferred_partner_tier
      comment: "Preferred partner tier for strategic partner segmentation."
    - name: "rate_parity_clause"
      expr: rate_parity_clause
      comment: "Rate parity clause flag for compliance obligation analysis."
    - name: "renewal_type"
      expr: renewal_type
      comment: "Contract renewal type (auto-renew, manual) for contract management planning."
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the contract becomes effective for contract calendar analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency contract analysis."
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of channel contracts. Baseline for channel contract portfolio size."
    - name: "active_contracts"
      expr: COUNT(CASE WHEN contract_status = 'active' THEN 1 END)
      comment: "Number of currently active channel contracts. Measures live channel contract coverage."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across channel contracts. Benchmarks contracted commission levels for renegotiation decisions."
    - name: "avg_connectivity_fee"
      expr: AVG(CAST(connectivity_fee AS DOUBLE))
      comment: "Average connectivity fee in channel contracts. Measures technology cost commitments in channel agreements."
    - name: "avg_marketing_coop_amount"
      expr: AVG(CAST(marketing_coop_amount AS DOUBLE))
      comment: "Average co-op marketing budget in channel contracts. Measures channel marketing investment commitments."
    - name: "rate_parity_clause_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rate_parity_clause = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of channel contracts with rate parity clauses. Measures rate parity contractual coverage across the channel portfolio."
    - name: "procurement_contract_linked_count"
      expr: COUNT(CASE WHEN procurement_contract_id IS NOT NULL THEN 1 END)
      comment: "Number of channel contracts linked to the master procurement contract SSOT. Tracks contract governance compliance and SSOT alignment."
    - name: "expiring_contracts_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Number of channel contracts expiring within 90 days. Triggers proactive contract renewal management to avoid distribution gaps."
    - name: "distinct_channels_under_contract"
      expr: COUNT(DISTINCT channel_id)
      comment: "Number of distinct channels with active contracts. Measures channel contract coverage breadth."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_channel_inventory_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel Inventory Allocation business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`channel_inventory_allocation`"
  dimensions:
    - name: "Action Type"
      expr: action_type
    - name: "Active Status"
      expr: active_status
    - name: "Allocated Units"
      expr: allocated_units
    - name: "Allocation Reference Number"
      expr: allocation_reference_number
    - name: "Allocation Status"
      expr: allocation_status
    - name: "Allocation Type"
      expr: allocation_type
    - name: "Allotment Type"
      expr: allotment_type
    - name: "Applied By User"
      expr: applied_by_user
    - name: "Available Units"
      expr: available_units
    - name: "Cancellation Count"
      expr: cancellation_count
    - name: "Channel Type"
      expr: channel_type
    - name: "Consumed Units"
      expr: consumed_units
    - name: "Created Date"
      expr: created_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Days Out"
      expr: days_out
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Channel Inventory Allocation"
      expr: COUNT(DISTINCT channel_inventory_allocation_id)
    - name: "Total Channel Allocation Pct"
      expr: SUM(channel_allocation_pct)
    - name: "Average Channel Allocation Pct"
      expr: AVG(channel_allocation_pct)
    - name: "Total Commission Rate"
      expr: SUM(commission_rate)
    - name: "Average Commission Rate"
      expr: AVG(commission_rate)
    - name: "Total Connectivity Fee"
      expr: SUM(connectivity_fee)
    - name: "Average Connectivity Fee"
      expr: AVG(connectivity_fee)
    - name: "Total Overbooking Limit Pct"
      expr: SUM(overbooking_limit_pct)
    - name: "Average Overbooking Limit Pct"
      expr: AVG(overbooking_limit_pct)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_inventory_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel inventory allocation performance metrics covering allocation utilization, pickup, overbooking, and restriction management. Drives inventory optimization and channel yield decisions."
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel_inventory_allocation`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Distribution channel type for allocation analysis by channel category."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (allotment, free-sell, on-request) for inventory strategy analysis."
    - name: "allotment_type"
      expr: allotment_type
      comment: "Allotment type for wholesale vs retail inventory segmentation."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current allocation status for operational inventory monitoring."
    - name: "active_status"
      expr: active_status
      comment: "Active/inactive status of the allocation record."
    - name: "is_stop_sell"
      expr: is_stop_sell
      comment: "Stop-sell flag for inventory restriction analysis."
    - name: "is_closed_to_arrival"
      expr: is_closed_to_arrival
      comment: "Closed-to-arrival restriction flag for arrival pattern analysis."
    - name: "stay_date_from_month"
      expr: DATE_TRUNC('month', stay_date_from)
      comment: "Stay period start month for seasonal allocation analysis."
    - name: "is_rms_generated"
      expr: is_rms_generated
      comment: "Flag indicating RMS-generated allocation for automation coverage analysis."
  measures:
    - name: "total_allocation_records"
      expr: COUNT(1)
      comment: "Total number of channel inventory allocation records. Baseline for allocation portfolio size and operational coverage."
    - name: "avg_channel_allocation_pct"
      expr: AVG(CAST(channel_allocation_pct AS DOUBLE))
      comment: "Average percentage of inventory allocated to channels. Measures channel inventory commitment level for yield optimization."
    - name: "avg_overbooking_limit_pct"
      expr: AVG(CAST(overbooking_limit_pct AS DOUBLE))
      comment: "Average overbooking limit percentage across allocations. Quantifies overbooking risk exposure for revenue and operations management."
    - name: "stop_sell_allocation_count"
      expr: COUNT(CASE WHEN is_stop_sell = TRUE THEN 1 END)
      comment: "Number of allocations currently under stop-sell restriction. Measures inventory restriction intensity — high counts signal demand-supply imbalance."
    - name: "stop_sell_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_stop_sell = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocations under stop-sell. Key yield management KPI — high rates indicate strong demand or inventory constraint."
    - name: "rms_generated_allocation_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_rms_generated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocations generated by the RMS. Measures automation adoption in inventory management — drives operational efficiency decisions."
    - name: "distinct_channels_with_allocation"
      expr: COUNT(DISTINCT primary_channel_id)
      comment: "Number of distinct channels with active inventory allocations. Measures channel inventory distribution breadth."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate on channel inventory allocations. Benchmarks allocation-level commission costs."
    - name: "rate_parity_enforced_count"
      expr: COUNT(CASE WHEN rate_parity_enforcement_flag = TRUE THEN 1 END)
      comment: "Number of allocations with rate parity enforcement active. Measures rate parity governance coverage across inventory allocations."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_channel_negotiated_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel Negotiated Rate business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`channel_negotiated_rate`"
  dimensions:
    - name: "Advance Purchase Days"
      expr: advance_purchase_days
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Approved By User"
      expr: approved_by_user
    - name: "Blackout Dates"
      expr: blackout_dates
    - name: "Cancellation Policy Code"
      expr: cancellation_policy_code
    - name: "Consortia Code"
      expr: consortia_code
    - name: "Consortia Name"
      expr: consortia_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crs Rate Code"
      expr: crs_rate_code
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Gds Chain Code"
      expr: gds_chain_code
    - name: "Gds Loading Status"
      expr: gds_loading_status
    - name: "Is Last Room Availability"
      expr: is_last_room_availability
    - name: "Is Rate Parity Required"
      expr: is_rate_parity_required
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Channel Negotiated Rate"
      expr: COUNT(DISTINCT channel_negotiated_rate_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Commission Rate Pct"
      expr: SUM(commission_rate_pct)
    - name: "Average Commission Rate Pct"
      expr: AVG(commission_rate_pct)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_negotiated_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel negotiated rate metrics covering corporate and TMC rate management, GDS loading status, and rate competitiveness. Drives corporate account rate strategy and GDS distribution governance."
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel_negotiated_rate`"
  dimensions:
    - name: "rate_type"
      expr: rate_type
      comment: "Type of negotiated rate (corporate, consortia, government) for rate category analysis."
    - name: "rate_category"
      expr: rate_category
      comment: "Rate category for negotiated rate segmentation."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current agreement status for rate contract lifecycle monitoring."
    - name: "gds_loading_status"
      expr: gds_loading_status
      comment: "GDS loading status for rate distribution operational monitoring."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment for negotiated rate segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the negotiated rate for multi-currency analysis."
    - name: "negotiation_year"
      expr: negotiation_year
      comment: "Year of rate negotiation for annual rate cycle analysis."
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the negotiated rate becomes effective for rate calendar analysis."
    - name: "is_rate_parity_required"
      expr: is_rate_parity_required
      comment: "Rate parity requirement flag for compliance segmentation."
  measures:
    - name: "total_negotiated_rates"
      expr: COUNT(1)
      comment: "Total number of channel negotiated rates. Baseline for corporate rate portfolio size."
    - name: "avg_negotiated_rate_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average negotiated rate amount. Benchmarks corporate rate levels against BAR and market rates."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate on negotiated rates. Measures distribution cost on corporate rate agreements."
    - name: "revenue_rate_plan_linked_count"
      expr: COUNT(CASE WHEN revenue_rate_plan_id IS NOT NULL THEN 1 END)
      comment: "Number of negotiated rates linked to the revenue master rate plan. Measures SSOT alignment for negotiated rate governance."
    - name: "revenue_negotiated_rate_linked_count"
      expr: COUNT(CASE WHEN revenue_negotiated_rate_id IS NOT NULL THEN 1 END)
      comment: "Number of channel negotiated rates linked to the revenue master negotiated rate SSOT. Tracks cross-domain rate governance compliance."
    - name: "gds_loaded_rate_count"
      expr: COUNT(CASE WHEN gds_loading_status = 'loaded' THEN 1 END)
      comment: "Number of negotiated rates successfully loaded in GDS. Measures GDS distribution readiness for corporate accounts."
    - name: "gds_loading_success_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gds_loading_status = 'loaded' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of negotiated rates successfully loaded in GDS. Operational KPI for GDS rate distribution completeness."
    - name: "distinct_corporate_accounts"
      expr: COUNT(DISTINCT channel_corporate_account_id)
      comment: "Number of distinct corporate accounts with negotiated rates. Measures corporate account rate coverage breadth."
    - name: "distinct_properties_with_negotiated_rates"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with channel negotiated rates. Measures corporate rate distribution across the property portfolio."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_channel_rate_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel Rate Plan business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`channel_rate_plan`"
  dimensions:
    - name: "Advance Purchase Days"
      expr: advance_purchase_days
    - name: "Approved By"
      expr: approved_by
    - name: "Booking Window End Date"
      expr: booking_window_end_date
    - name: "Booking Window Start Date"
      expr: booking_window_start_date
    - name: "Cancellation Policy Code"
      expr: cancellation_policy_code
    - name: "Channel Rate Plan Status"
      expr: channel_rate_plan_status
    - name: "Close Out Days"
      expr: close_out_days
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crs Rate Plan Code"
      expr: crs_rate_plan_code
    - name: "Currency Code"
      expr: currency_code
    - name: "Days Of Week Applicable"
      expr: days_of_week_applicable
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Is Package Rate"
      expr: is_package_rate
    - name: "Is Rate Parity Applicable"
      expr: is_rate_parity_applicable
    - name: "Is Refundable"
      expr: is_refundable
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Channel Rate Plan"
      expr: COUNT(DISTINCT channel_rate_plan_id)
    - name: "Total Base Rate Amount"
      expr: SUM(base_rate_amount)
    - name: "Average Base Rate Amount"
      expr: AVG(base_rate_amount)
    - name: "Total Channel Rate Amount"
      expr: SUM(channel_rate_amount)
    - name: "Average Channel Rate Amount"
      expr: AVG(channel_rate_amount)
    - name: "Total Commission Rate Pct"
      expr: SUM(commission_rate_pct)
    - name: "Average Commission Rate Pct"
      expr: AVG(commission_rate_pct)
    - name: "Total Connectivity Fee Amount"
      expr: SUM(connectivity_fee_amount)
    - name: "Average Connectivity Fee Amount"
      expr: AVG(connectivity_fee_amount)
    - name: "Total Rate Adjustment Value"
      expr: SUM(rate_adjustment_value)
    - name: "Average Rate Adjustment Value"
      expr: AVG(rate_adjustment_value)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_rate_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel rate plan coverage, pricing, and loading metrics. Supports rate strategy governance, channel rate parity management, and revenue rate plan alignment."
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel_rate_plan`"
  dimensions:
    - name: "rate_plan_type"
      expr: rate_plan_type
      comment: "Type of rate plan (BAR, negotiated, package, promotional) for rate strategy segmentation."
    - name: "rate_plan_status"
      expr: channel_rate_plan_status
      comment: "Current status of the channel rate plan (active, inactive, pending) for rate loading governance."
    - name: "rate_loading_status"
      expr: rate_loading_status
      comment: "Rate loading status in CRS/GDS for operational rate distribution monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rate plan for multi-currency rate management."
    - name: "is_rate_parity_applicable"
      expr: is_rate_parity_applicable
      comment: "Flag indicating whether rate parity rules apply to this rate plan."
    - name: "is_package_rate"
      expr: is_package_rate
      comment: "Flag indicating whether this is a package rate for package revenue analysis."
    - name: "is_refundable"
      expr: is_refundable
      comment: "Refundability flag for cancellation policy and revenue risk analysis."
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the rate plan becomes effective for rate calendar analysis."
    - name: "meal_plan_code"
      expr: meal_plan_code
      comment: "Meal plan included in the rate for ancillary revenue analysis."
    - name: "rate_derivation_method"
      expr: rate_derivation_method
      comment: "Method used to derive the channel rate from the base rate for pricing strategy analysis."
  measures:
    - name: "total_rate_plans"
      expr: COUNT(1)
      comment: "Total number of channel rate plans. Baseline for rate plan portfolio size and loading coverage."
    - name: "active_rate_plans"
      expr: COUNT(CASE WHEN channel_rate_plan_status = 'active' THEN 1 END)
      comment: "Number of currently active channel rate plans. Measures live rate plan coverage for distribution readiness."
    - name: "avg_base_rate_amount"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base rate amount across channel rate plans. Benchmarks channel pricing against revenue rate plan targets."
    - name: "avg_channel_rate_amount"
      expr: AVG(CAST(channel_rate_amount AS DOUBLE))
      comment: "Average channel-specific rate amount. Measures channel rate positioning relative to base rates."
    - name: "avg_rate_adjustment_value"
      expr: AVG(CAST(rate_adjustment_value AS DOUBLE))
      comment: "Average rate adjustment applied to channel rates. Quantifies channel rate deviation from base pricing strategy."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate across channel rate plans. Drives channel cost-of-distribution benchmarking."
    - name: "rate_parity_applicable_rate_plans"
      expr: COUNT(CASE WHEN is_rate_parity_applicable = TRUE THEN 1 END)
      comment: "Number of rate plans subject to rate parity rules. Measures rate parity compliance exposure across the rate plan portfolio."
    - name: "distinct_properties_with_rate_plans"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with active channel rate plans. Measures rate plan distribution coverage across the property portfolio."
    - name: "revenue_rate_plan_linkage_count"
      expr: COUNT(CASE WHEN revenue_rate_plan_id IS NOT NULL THEN 1 END)
      comment: "Number of channel rate plans linked to a revenue master rate plan. Measures SSOT alignment between channel and revenue rate plans — critical governance KPI."
    - name: "revenue_rate_plan_linkage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN revenue_rate_plan_id IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of channel rate plans linked to the revenue master rate plan SSOT. Tracks rate plan governance compliance — low scores indicate SSOT fragmentation risk."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_wholesale_inventory_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wholesale inventory allotment performance metrics covering allocated vs sold units, utilization, release management, and overbooking. Drives wholesale channel yield and allotment optimization decisions."
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel_wholesale_inventory_allocation`"
  dimensions:
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of wholesale allocation for allotment strategy segmentation."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the wholesale allocation for operational monitoring."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate wholesale inventory for strategy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the allocation for multi-currency wholesale reporting."
    - name: "is_active"
      expr: is_active
      comment: "Active flag for filtering live vs historical allocations."
    - name: "is_guaranteed"
      expr: is_guaranteed
      comment: "Guaranteed allotment flag for risk and liability analysis."
    - name: "stop_sell_flag"
      expr: stop_sell_flag
      comment: "Stop-sell flag for wholesale inventory restriction monitoring."
    - name: "stay_date_month"
      expr: DATE_TRUNC('month', stay_date)
      comment: "Stay date month for seasonal wholesale allotment analysis."
    - name: "overbooking_allowed"
      expr: overbooking_allowed
      comment: "Overbooking permission flag for risk exposure segmentation."
    - name: "auto_release_enabled"
      expr: auto_release_enabled
      comment: "Auto-release flag for inventory release automation coverage analysis."
  measures:
    - name: "total_allocated_rooms"
      expr: SUM(CAST(allocated_room_count AS DOUBLE))
      comment: "Total number of rooms allocated to wholesale channels. Primary wholesale inventory commitment KPI."
    - name: "total_sold_rooms"
      expr: SUM(CAST(sold_room_count AS DOUBLE))
      comment: "Total number of wholesale-allocated rooms sold. Measures wholesale channel pickup performance."
    - name: "total_remaining_rooms"
      expr: SUM(CAST(remaining_room_count AS DOUBLE))
      comment: "Total remaining unsold rooms in wholesale allocations. Measures inventory at risk of release or washout."
    - name: "wholesale_utilization_pct"
      expr: AVG(CAST(utilization_pct AS DOUBLE))
      comment: "Average utilization percentage across wholesale allocations. Core wholesale yield KPI — low utilization triggers release or reallocation decisions."
    - name: "avg_allocated_rate_amount"
      expr: AVG(CAST(allocated_rate_amount AS DOUBLE))
      comment: "Average rate amount for wholesale allocations. Benchmarks wholesale net rates against BAR and negotiated rates."
    - name: "avg_base_rate_amount"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base rate amount underlying wholesale allocations. Used to compute wholesale rate discount depth."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate on wholesale allocations. Drives wholesale cost-of-distribution benchmarking."
    - name: "total_sold_count"
      expr: SUM(CAST(sold_count AS DOUBLE))
      comment: "Total sold unit count across wholesale allocations. Measures wholesale channel throughput."
    - name: "total_remaining_count"
      expr: SUM(CAST(remaining_count AS DOUBLE))
      comment: "Total remaining unit count in wholesale allocations. Quantifies unsold wholesale inventory exposure."
    - name: "guaranteed_allocation_count"
      expr: COUNT(CASE WHEN is_guaranteed = TRUE THEN 1 END)
      comment: "Number of guaranteed wholesale allocations. Measures contractual inventory commitment and associated financial risk."
    - name: "auto_release_enabled_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_release_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of wholesale allocations with auto-release enabled. Measures automation adoption in wholesale inventory management."
    - name: "stop_sell_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN stop_sell_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of wholesale allocations under stop-sell. Indicates wholesale demand strength and inventory constraint levels."
    - name: "distinct_properties_with_wholesale"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with wholesale inventory allocations. Measures wholesale channel property coverage."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_commission_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission accrual and cost-of-acquisition metrics for distribution channel financial management. Tracks commission liability, payment status, and channel acquisition economics."
  source: "`vibe_travel_hospitality_v1`.`channel`.`commission_accrual`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Distribution channel type for commission cost segmentation."
    - name: "commission_type"
      expr: commission_type
      comment: "Type of commission (base, override, performance) for commission structure analysis."
    - name: "commission_basis"
      expr: commission_basis
      comment: "Basis on which commission is calculated (room revenue, total revenue, per-night) for cost modeling."
    - name: "accrual_status"
      expr: accrual_status
      comment: "Current accrual status (accrued, paid, disputed, reversed) for liability management."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment for commission cost analysis by segment."
    - name: "accrual_month"
      expr: DATE_TRUNC('month', accrual_date)
      comment: "Month of commission accrual for time-series liability tracking."
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Local currency of the commission accrual for multi-currency reporting."
  measures:
    - name: "total_commission_base_currency"
      expr: SUM(CAST(commission_amount_base AS DOUBLE))
      comment: "Total commission accrued in base currency. Primary financial liability metric for channel cost management and AP forecasting."
    - name: "total_commission_local_currency"
      expr: SUM(CAST(commission_amount_local AS DOUBLE))
      comment: "Total commission accrued in local currency. Used for multi-currency commission reconciliation."
    - name: "total_gross_booking_value"
      expr: SUM(CAST(gross_booking_value AS DOUBLE))
      comment: "Total gross booking value underlying commission accruals. Provides context for commission rate benchmarking."
    - name: "total_connectivity_fees"
      expr: SUM(CAST(connectivity_fee_amount AS DOUBLE))
      comment: "Total connectivity fees accrued alongside commissions. Part of total cost of distribution."
    - name: "total_cost_of_acquisition"
      expr: SUM(CAST(total_cost_of_acquisition AS DOUBLE))
      comment: "Total cost of acquisition including commission and fees. The definitive channel economics KPI for distribution strategy decisions."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across accruals. Benchmarks negotiated rates against market and drives contract renegotiation."
    - name: "avg_adr"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average Daily Rate on bookings generating commission accruals. Validates that high-commission channels are also delivering premium rates."
    - name: "commission_to_gbv_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(commission_amount_base AS DOUBLE)) / NULLIF(SUM(CAST(gross_booking_value AS DOUBLE)), 0), 2)
      comment: "Commission as a percentage of gross booking value. Core channel cost efficiency KPI — steers channel mix optimization and contract negotiations."
    - name: "total_accrual_records"
      expr: COUNT(1)
      comment: "Total number of commission accrual records. Baseline volume for accrual processing throughput monitoring."
    - name: "distinct_channels_with_commission"
      expr: COUNT(DISTINCT channel_id)
      comment: "Number of distinct channels generating commission accruals. Measures commission liability breadth across the channel portfolio."
    - name: "avg_fx_rate"
      expr: AVG(CAST(fx_rate AS DOUBLE))
      comment: "Average FX rate applied to commission conversions. Monitors currency exposure in commission settlements."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_commission_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission schedule governance metrics covering rate structures, tiering, and schedule coverage. Supports commission contract management and cost-of-distribution planning."
  source: "`vibe_travel_hospitality_v1`.`channel`.`commission_schedule`"
  dimensions:
    - name: "commission_basis"
      expr: commission_basis
      comment: "Basis for commission calculation (room revenue, total revenue, per-night) for cost structure analysis."
    - name: "fee_type"
      expr: fee_type
      comment: "Type of fee in the commission schedule for fee structure analysis."
    - name: "fee_structure"
      expr: fee_structure
      comment: "Fee structure (flat, tiered, percentage) for commission model analysis."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the commission schedule (active, expired, pending) for governance monitoring."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency for commission payments for cash flow planning."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment the commission schedule applies to for segment-level cost analysis."
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the commission schedule becomes effective for schedule lifecycle analysis."
    - name: "auto_accrual_enabled"
      expr: auto_accrual_enabled
      comment: "Flag indicating automated accrual for operational efficiency analysis."
  measures:
    - name: "total_schedules"
      expr: COUNT(1)
      comment: "Total number of commission schedules. Baseline for commission contract portfolio size."
    - name: "active_schedules"
      expr: COUNT(CASE WHEN schedule_status = 'active' THEN 1 END)
      comment: "Number of currently active commission schedules. Measures live commission contract coverage."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate across all schedules. Benchmarks portfolio-level commission costs for contract renegotiation decisions."
    - name: "avg_flat_fee_amount"
      expr: AVG(CAST(flat_fee_amount AS DOUBLE))
      comment: "Average flat fee amount in commission schedules. Quantifies fixed distribution cost components."
    - name: "avg_max_commission_amount"
      expr: AVG(CAST(max_commission_amount AS DOUBLE))
      comment: "Average maximum commission cap across schedules. Measures commission liability ceiling for financial planning."
    - name: "avg_min_commission_amount"
      expr: AVG(CAST(min_commission_amount AS DOUBLE))
      comment: "Average minimum commission floor across schedules. Measures guaranteed commission cost floor."
    - name: "auto_accrual_adoption_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_accrual_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of commission schedules with auto-accrual enabled. Measures automation adoption in commission processing — drives operational efficiency."
    - name: "distinct_channels_with_schedules"
      expr: COUNT(DISTINCT distribution_channel_id)
      comment: "Number of distinct channels with commission schedules. Measures commission contract coverage across the channel portfolio."
    - name: "distinct_properties_with_schedules"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with commission schedules. Measures property-level commission contract coverage."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_connectivity_fee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Connectivity fee cost management metrics covering fee amounts, waiver rates, and vendor cost analysis. Drives technology distribution cost optimization and vendor contract decisions."
  source: "`vibe_travel_hospitality_v1`.`channel`.`connectivity_fee`"
  dimensions:
    - name: "fee_type"
      expr: fee_type
      comment: "Type of connectivity fee (per-booking, monthly, annual) for fee structure analysis."
    - name: "fee_basis"
      expr: fee_basis
      comment: "Basis for fee calculation for cost modeling."
    - name: "fee_status"
      expr: fee_status
      comment: "Current fee status (active, waived, disputed) for fee management."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency for connectivity fees for cash flow planning."
    - name: "is_waived"
      expr: is_waived
      comment: "Waiver flag for fee waiver analysis and vendor negotiation."
    - name: "is_negotiated_rate"
      expr: is_negotiated_rate
      comment: "Flag indicating negotiated vs standard rate for contract analysis."
    - name: "tax_applicable"
      expr: tax_applicable
      comment: "Tax applicability flag for tax cost analysis."
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the connectivity fee becomes effective for fee lifecycle analysis."
  measures:
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total connectivity fee amount. Primary technology distribution cost KPI for vendor contract management."
    - name: "avg_fee_amount"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average connectivity fee amount. Benchmarks per-connection technology costs for vendor negotiation."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average tax rate applied to connectivity fees. Quantifies tax cost component of distribution technology."
    - name: "waived_fee_count"
      expr: COUNT(CASE WHEN is_waived = TRUE THEN 1 END)
      comment: "Number of connectivity fees that have been waived. Measures vendor concession value and negotiation outcomes."
    - name: "waiver_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_waived = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of connectivity fees waived. Measures vendor negotiation effectiveness and fee reduction achievement."
    - name: "negotiated_fee_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_negotiated_rate = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of connectivity fees on negotiated rates. Measures contract coverage for technology cost management."
    - name: "distinct_vendors_with_fees"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors charging connectivity fees. Measures technology vendor concentration and diversification."
    - name: "distinct_properties_with_fees"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties incurring connectivity fees. Measures technology cost distribution across the property portfolio."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_crs_channel_mapping`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crs Channel Mapping business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`crs_channel_mapping`"
  dimensions:
    - name: "Cancellation Policy Code"
      expr: cancellation_policy_code
    - name: "Channel Contract Reference"
      expr: channel_contract_reference
    - name: "Channel Property Code"
      expr: channel_property_code
    - name: "Channel Type"
      expr: channel_type
    - name: "Connectivity Protocol"
      expr: connectivity_protocol
    - name: "Content Sync Enabled"
      expr: content_sync_enabled
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crs Property Code"
      expr: crs_property_code
    - name: "Crs Rate Plan Code"
      expr: crs_rate_plan_code
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Guarantee Policy Code"
      expr: guarantee_policy_code
    - name: "Inventory Allocation Type"
      expr: inventory_allocation_type
    - name: "Is Mobile Optimized"
      expr: is_mobile_optimized
    - name: "Last Sync Timestamp"
      expr: last_sync_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Crs Channel Mapping"
      expr: COUNT(DISTINCT crs_channel_mapping_id)
    - name: "Total Commission Rate Pct"
      expr: SUM(commission_rate_pct)
    - name: "Average Commission Rate Pct"
      expr: AVG(commission_rate_pct)
    - name: "Total Connectivity Fee Usd"
      expr: SUM(connectivity_fee_usd)
    - name: "Average Connectivity Fee Usd"
      expr: AVG(connectivity_fee_usd)
    - name: "Total Rate Offset Value"
      expr: SUM(rate_offset_value)
    - name: "Average Rate Offset Value"
      expr: AVG(rate_offset_value)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_gds_connection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GDS (Global Distribution System) connection health and commercial performance metrics. Tracks uptime, commission rates, and connection coverage for corporate and travel agent channel management."
  source: "`vibe_travel_hospitality_v1`.`channel`.`gds_connection`"
  dimensions:
    - name: "gds_name"
      expr: gds_name
      comment: "Name of the GDS platform (Amadeus, Sabre, Travelport, Worldline) for platform-level performance comparison."
    - name: "connection_status"
      expr: connection_status
      comment: "Current connection status (active, inactive, suspended) for operational health monitoring."
    - name: "gds_tier"
      expr: gds_tier
      comment: "GDS tier designation for commercial prioritization and rate loading strategy."
    - name: "health_check_status"
      expr: health_check_status
      comment: "Latest health check status of the GDS connection for real-time operational monitoring."
    - name: "connectivity_type"
      expr: connectivity_type
      comment: "Type of GDS connectivity (direct connect, switch, aggregator) for technology cost analysis."
    - name: "lra_enabled"
      expr: lra_enabled
      comment: "Boolean flag indicating whether Last Room Availability is enabled on this GDS connection."
    - name: "nrr_supported"
      expr: nrr_supported
      comment: "Boolean flag indicating whether non-refundable rates are supported on this GDS connection."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Primary market segment served by this GDS connection (corporate, leisure, group)."
  measures:
    - name: "total_gds_connections"
      expr: COUNT(1)
      comment: "Total number of GDS connections. Baseline for GDS distribution footprint."
    - name: "active_connections"
      expr: COUNT(CASE WHEN connection_status = 'active' THEN 1 END)
      comment: "Count of active GDS connections. Measures live GDS distribution coverage."
    - name: "avg_uptime_sla_pct"
      expr: AVG(CAST(uptime_sla_pct AS DOUBLE))
      comment: "Average uptime SLA percentage across GDS connections. Measures distribution reliability; below-SLA connections trigger vendor escalation."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate across GDS connections. Benchmarks GDS distribution cost for renegotiation."
    - name: "avg_monthly_connectivity_fee"
      expr: AVG(CAST(connectivity_fee_monthly_usd AS DOUBLE))
      comment: "Average monthly connectivity fee per GDS connection. Tracks technology cost of GDS distribution."
    - name: "total_monthly_connectivity_cost"
      expr: SUM(CAST(connectivity_fee_monthly_usd AS DOUBLE))
      comment: "Total monthly GDS connectivity fees across all connections. Measures aggregate GDS technology cost."
    - name: "avg_segment_fee"
      expr: AVG(CAST(segment_fee_usd AS DOUBLE))
      comment: "Average per-segment fee charged by GDS. Tracks transaction-level distribution cost."
    - name: "lra_enabled_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN lra_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of GDS connections with Last Room Availability enabled. Measures inventory exposure and revenue optimization coverage."
    - name: "unique_properties_on_gds"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties connected to GDS. Measures GDS distribution reach across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_metasearch_listing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metasearch channel performance metrics covering spend efficiency, conversion, click-through, and return on ad spend. Drives metasearch bidding strategy and budget allocation decisions."
  source: "`vibe_travel_hospitality_v1`.`channel`.`metasearch_listing`"
  dimensions:
    - name: "platform_name"
      expr: platform_name
      comment: "Metasearch platform (Google Hotel Ads, TripAdvisor, Kayak) for platform-level performance comparison."
    - name: "listing_status"
      expr: listing_status
      comment: "Current listing status for active vs inactive listing analysis."
    - name: "listing_type"
      expr: listing_type
      comment: "Type of metasearch listing for format performance analysis."
    - name: "bid_strategy_type"
      expr: bid_strategy_type
      comment: "Bidding strategy type (CPC, CPA, commission) for bid strategy performance comparison."
    - name: "device_type"
      expr: device_type
      comment: "Device type (desktop, mobile, tablet) for device-level conversion analysis."
    - name: "target_market"
      expr: target_market
      comment: "Target market for geographic metasearch performance analysis."
    - name: "rate_parity_status"
      expr: rate_parity_status
      comment: "Rate parity status on the metasearch listing for compliance monitoring."
    - name: "reporting_period_month"
      expr: DATE_TRUNC('month', reporting_period_start)
      comment: "Reporting period month for time-series metasearch performance analysis."
  measures:
    - name: "total_spend"
      expr: SUM(CAST(total_spend AS DOUBLE))
      comment: "Total metasearch advertising spend. Primary cost metric for metasearch budget management and ROI analysis."
    - name: "total_booking_revenue"
      expr: SUM(CAST(booking_revenue AS DOUBLE))
      comment: "Total revenue generated from metasearch bookings. Measures metasearch channel revenue contribution."
    - name: "total_impressions"
      expr: SUM(CAST(impression_count AS DOUBLE))
      comment: "Total metasearch impressions. Measures brand visibility and reach on metasearch platforms."
    - name: "total_clicks"
      expr: SUM(CAST(click_count AS DOUBLE))
      comment: "Total clicks on metasearch listings. Measures traffic driven from metasearch to direct booking channels."
    - name: "avg_click_through_rate"
      expr: AVG(CAST(click_through_rate AS DOUBLE))
      comment: "Average click-through rate across metasearch listings. Measures listing relevance and creative effectiveness."
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average conversion rate from click to booking. Core metasearch efficiency KPI — low rates trigger bid strategy or landing page optimization."
    - name: "avg_return_on_ad_spend"
      expr: AVG(CAST(return_on_ad_spend AS DOUBLE))
      comment: "Average return on ad spend across metasearch listings. Primary metasearch investment efficiency KPI for budget allocation decisions."
    - name: "avg_cpc_actual"
      expr: AVG(CAST(cpc_actual AS DOUBLE))
      comment: "Average actual cost per click. Benchmarks metasearch bidding efficiency against target CPC thresholds."
    - name: "avg_cpa_actual"
      expr: AVG(CAST(cpa_actual AS DOUBLE))
      comment: "Average actual cost per acquisition. Measures metasearch cost efficiency per booking — drives bid strategy optimization."
    - name: "revenue_to_spend_ratio"
      expr: ROUND(SUM(CAST(booking_revenue AS DOUBLE)) / NULLIF(SUM(CAST(total_spend AS DOUBLE)), 0), 2)
      comment: "Ratio of booking revenue to total metasearch spend. Portfolio-level ROAS metric for metasearch investment justification."
    - name: "distinct_properties_listed"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with active metasearch listings. Measures metasearch channel property coverage."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_ota_campaign_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OTA co-marketing campaign performance metrics tracking investment, revenue outcomes, and ROI of OTA promotional participation. Drives OTA partnership investment decisions."
  source: "`vibe_travel_hospitality_v1`.`channel`.`ota_campaign_participation`"
  dimensions:
    - name: "participation_status"
      expr: participation_status
      comment: "Status of the OTA campaign participation (active, completed, withdrawn, pending) for portfolio monitoring."
    - name: "promotional_placement_type"
      expr: promotional_placement_type
      comment: "Type of promotional placement (featured listing, flash sale, loyalty deal, etc.) for campaign type analysis."
    - name: "campaign_start_date"
      expr: campaign_start_date
      comment: "Campaign start date for time-series campaign performance analysis."
    - name: "campaign_end_date"
      expr: campaign_end_date
      comment: "Campaign end date for campaign duration and timing analysis."
  measures:
    - name: "total_participations"
      expr: COUNT(1)
      comment: "Total number of OTA campaign participations. Baseline for OTA co-marketing activity volume."
    - name: "total_hotel_contribution"
      expr: SUM(CAST(hotel_contribution_amount AS DOUBLE))
      comment: "Total hotel co-op marketing investment in OTA campaigns. Measures marketing spend committed to OTA partnerships."
    - name: "total_ota_coop_budget"
      expr: SUM(CAST(ota_coop_budget_amount AS DOUBLE))
      comment: "Total OTA co-op budget committed across campaigns. Measures OTA marketing investment for ROI analysis."
    - name: "total_actual_revenue"
      expr: SUM(CAST(actual_revenue_amount AS DOUBLE))
      comment: "Total actual revenue generated from OTA campaign participations. Primary outcome KPI for campaign ROI."
    - name: "total_performance_bonus_earned"
      expr: SUM(CAST(performance_bonus_earned AS DOUBLE))
      comment: "Total performance bonuses earned from OTA campaigns. Measures incremental commercial benefit of preferred partner status."
    - name: "total_partner_contribution"
      expr: SUM(CAST(partner_contribution_amount AS DOUBLE))
      comment: "Total OTA partner contribution to co-marketing campaigns. Measures OTA investment in the partnership."
    - name: "revenue_per_hotel_investment"
      expr: ROUND(SUM(CAST(actual_revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(hotel_contribution_amount AS DOUBLE)), 0), 2)
      comment: "Revenue generated per dollar of hotel co-op investment. Measures ROI of OTA campaign participation; drives future investment decisions."
    - name: "unique_ota_partners"
      expr: COUNT(DISTINCT ota_partner_id)
      comment: "Number of distinct OTA partners with campaign participations. Measures breadth of OTA co-marketing relationships."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_ota_partner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ota Partner business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`ota_partner`"
  dimensions:
    - name: "Affiliate Network"
      expr: affiliate_network
    - name: "Cancellation Policy Type"
      expr: cancellation_policy_type
    - name: "Channel Manager Platform"
      expr: channel_manager_platform
    - name: "Commission Model"
      expr: commission_model
    - name: "Connectivity Fee Frequency"
      expr: connectivity_fee_frequency
    - name: "Connectivity Protocol"
      expr: connectivity_protocol
    - name: "Contract Effective Date"
      expr: contract_effective_date
    - name: "Contract Expiry Date"
      expr: contract_expiry_date
    - name: "Contract Reference"
      expr: contract_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Sharing Agreement"
      expr: data_sharing_agreement
    - name: "Gdpr Data Processor"
      expr: gdpr_data_processor
    - name: "Gds Chain Code"
      expr: gds_chain_code
    - name: "Hq Country Code"
      expr: hq_country_code
    - name: "Inventory Allocation Model"
      expr: inventory_allocation_model
    - name: "Last Room Availability"
      expr: last_room_availability
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ota Partner"
      expr: COUNT(DISTINCT ota_partner_id)
    - name: "Total Base Commission Rate Pct"
      expr: SUM(base_commission_rate_pct)
    - name: "Average Base Commission Rate Pct"
      expr: AVG(base_commission_rate_pct)
    - name: "Total Connectivity Fee Usd"
      expr: SUM(connectivity_fee_usd)
    - name: "Average Connectivity Fee Usd"
      expr: AVG(connectivity_fee_usd)
    - name: "Total Content Score"
      expr: SUM(content_score)
    - name: "Average Content Score"
      expr: AVG(content_score)
    - name: "Total Preferred Commission Rate Pct"
      expr: SUM(preferred_commission_rate_pct)
    - name: "Average Preferred Commission Rate Pct"
      expr: AVG(preferred_commission_rate_pct)
    - name: "Total Review Score"
      expr: SUM(review_score)
    - name: "Average Review Score"
      expr: AVG(review_score)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_package_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Package Rate business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`package_rate`"
  dimensions:
    - name: "Cancellation Policy Override"
      expr: cancellation_policy_override
    - name: "Created Date"
      expr: created_date
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Is Active"
      expr: is_active
    - name: "Last Rate Update Timestamp"
      expr: last_rate_update_timestamp
    - name: "Minimum Advance Booking"
      expr: minimum_advance_booking
    - name: "Modified Date"
      expr: modified_date
    - name: "Rate Loading Status"
      expr: rate_loading_status
    - name: "Created Date Month"
      expr: DATE_TRUNC('MONTH', created_date)
    - name: "Effective From Date Month"
      expr: DATE_TRUNC('MONTH', effective_from_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Package Rate"
      expr: COUNT(DISTINCT package_rate_id)
    - name: "Total Channel Package Price"
      expr: SUM(channel_package_price)
    - name: "Average Channel Package Price"
      expr: AVG(channel_package_price)
    - name: "Total Commission Rate"
      expr: SUM(commission_rate)
    - name: "Average Commission Rate"
      expr: AVG(commission_rate)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_rate_parity_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate parity compliance audit metrics tracking violations, variance severity, and dispute resolution. Directly steers channel contract enforcement and OTA relationship management."
  source: "`vibe_travel_hospitality_v1`.`channel`.`rate_parity_audit`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Distribution channel type for rate parity violation analysis by channel category."
    - name: "audit_status"
      expr: audit_status
      comment: "Current audit status (open, resolved, disputed) for compliance workflow management."
    - name: "violation_type"
      expr: violation_type
      comment: "Type of rate parity violation for root cause analysis."
    - name: "violation_severity"
      expr: violation_severity
      comment: "Severity level of the rate parity violation for prioritized remediation."
    - name: "is_parity_violation"
      expr: is_parity_violation
      comment: "Boolean flag for violation filtering and compliance rate calculation."
    - name: "monitoring_source"
      expr: monitoring_source
      comment: "Source of rate monitoring (internal tool, third-party shopper) for audit coverage analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the audited rates for multi-currency parity analysis."
    - name: "audit_month"
      expr: DATE_TRUNC('month', audit_timestamp)
      comment: "Month of the rate parity audit for trend analysis of violation frequency."
    - name: "stay_date_month"
      expr: DATE_TRUNC('month', stay_date)
      comment: "Stay date month for forward-looking parity violation analysis."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of rate parity audits conducted. Baseline for audit coverage and monitoring intensity."
    - name: "total_violations"
      expr: COUNT(CASE WHEN is_parity_violation = TRUE THEN 1 END)
      comment: "Total number of confirmed rate parity violations. Primary compliance KPI triggering channel contract enforcement actions."
    - name: "violation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_parity_violation = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits resulting in a rate parity violation. Core channel compliance KPI — high rates trigger contract renegotiation or channel suspension."
    - name: "avg_rate_variance"
      expr: AVG(CAST(rate_variance AS DOUBLE))
      comment: "Average absolute rate variance between observed and contracted parity rate. Quantifies the magnitude of rate parity breaches."
    - name: "avg_rate_variance_pct"
      expr: AVG(CAST(rate_variance_pct AS DOUBLE))
      comment: "Average percentage rate variance. Measures severity of rate parity violations relative to contracted rates."
    - name: "avg_direct_rate"
      expr: AVG(CAST(direct_rate AS DOUBLE))
      comment: "Average direct booking rate observed during audits. Benchmarks direct channel pricing against OTA rates."
    - name: "avg_observed_rate"
      expr: AVG(CAST(observed_rate AS DOUBLE))
      comment: "Average rate observed on the channel during audit. Used to compute rate gap between direct and channel pricing."
    - name: "avg_tolerance_threshold_pct"
      expr: AVG(CAST(tolerance_threshold_pct AS DOUBLE))
      comment: "Average tolerance threshold applied in parity audits. Contextualizes violation counts against contracted tolerance levels."
    - name: "open_disputes"
      expr: COUNT(CASE WHEN dispute_raised_date IS NOT NULL AND dispute_resolved_date IS NULL THEN 1 END)
      comment: "Number of open rate parity disputes. Measures unresolved compliance exposure requiring channel management intervention."
    - name: "distinct_channels_with_violations"
      expr: COUNT(DISTINCT CASE WHEN is_parity_violation = TRUE THEN channel_id END)
      comment: "Number of distinct channels with confirmed rate parity violations. Identifies which channels pose the highest compliance risk."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_stop_sell`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stop-sell restriction metrics tracking restriction frequency, duration, and channel impact. Drives inventory yield management and channel restriction strategy decisions."
  source: "`vibe_travel_hospitality_v1`.`channel`.`stop_sell`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Distribution channel type for stop-sell analysis by channel category."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of restriction (stop-sell, CTA, CTD, min-LOS) for restriction strategy analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the stop-sell for root cause analysis."
    - name: "restriction_status"
      expr: restriction_status
      comment: "Current restriction status (active, lifted) for operational monitoring."
    - name: "is_all_channels"
      expr: is_all_channels
      comment: "Flag indicating whether the stop-sell applies to all channels for scope analysis."
    - name: "is_system_generated"
      expr: is_system_generated
      comment: "Flag indicating RMS/system-generated vs manual stop-sell for automation analysis."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment affected by the stop-sell for segment-level restriction analysis."
    - name: "stay_date_from_month"
      expr: DATE_TRUNC('month', stay_date_from)
      comment: "Stay period start month for seasonal restriction pattern analysis."
  measures:
    - name: "total_stop_sell_events"
      expr: COUNT(1)
      comment: "Total number of stop-sell restriction events. Baseline for restriction frequency and inventory constraint intensity."
    - name: "active_stop_sells"
      expr: COUNT(CASE WHEN restriction_status = 'active' THEN 1 END)
      comment: "Number of currently active stop-sell restrictions. Measures live inventory constraint level across channels."
    - name: "system_generated_stop_sell_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_system_generated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stop-sells generated by the RMS/system. Measures yield management automation adoption."
    - name: "all_channel_stop_sell_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_all_channels = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stop-sells applied to all channels simultaneously. Indicates broad inventory constraint events vs targeted channel restrictions."
    - name: "avg_adr_at_apply"
      expr: AVG(CAST(adr_at_apply AS DOUBLE))
      comment: "Average ADR at the time stop-sell was applied. Contextualizes restriction decisions against prevailing rate levels."
    - name: "avg_occupancy_at_apply"
      expr: AVG(CAST(occupancy_at_apply AS DOUBLE))
      comment: "Average occupancy rate at the time stop-sell was applied. Validates that stop-sells are triggered at appropriate occupancy thresholds."
    - name: "avg_revpar_at_apply"
      expr: AVG(CAST(revpar_at_apply AS DOUBLE))
      comment: "Average RevPAR at the time stop-sell was applied. Measures revenue performance context for restriction decisions."
    - name: "distinct_properties_with_stop_sells"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with stop-sell restrictions. Measures restriction breadth across the property portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_wholesale_allotment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wholesale allotment contract performance metrics covering allotment size, pickup, wash, and rate management. Drives wholesale channel yield optimization and contract renewal decisions."
  source: "`vibe_travel_hospitality_v1`.`channel`.`wholesale_allotment`"
  dimensions:
    - name: "allotment_type"
      expr: allotment_type
      comment: "Type of wholesale allotment (guaranteed, free-sell, on-request) for allotment strategy analysis."
    - name: "allotment_status"
      expr: allotment_status
      comment: "Current allotment status for operational monitoring."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment for wholesale allotment segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the allotment for multi-currency wholesale reporting."
    - name: "connectivity_type"
      expr: connectivity_type
      comment: "Connectivity type for wholesale channel technology analysis."
    - name: "is_stop_sell"
      expr: is_stop_sell
      comment: "Stop-sell flag for wholesale inventory restriction monitoring."
    - name: "stay_date_from_month"
      expr: DATE_TRUNC('month', stay_date_from)
      comment: "Stay period start month for seasonal wholesale allotment analysis."
    - name: "contract_effective_month"
      expr: DATE_TRUNC('month', contract_effective_date)
      comment: "Contract effective month for allotment contract lifecycle analysis."
  measures:
    - name: "total_allotments"
      expr: COUNT(1)
      comment: "Total number of wholesale allotment records. Baseline for wholesale contract portfolio size."
    - name: "avg_contracted_net_rate"
      expr: AVG(CAST(contracted_net_rate AS DOUBLE))
      comment: "Average contracted net rate across wholesale allotments. Benchmarks wholesale pricing against rack and BAR rates."
    - name: "avg_rack_rate"
      expr: AVG(CAST(rack_rate AS DOUBLE))
      comment: "Average rack rate for allotted room types. Used to compute wholesale discount depth relative to rack."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate on wholesale allotments. Measures wholesale distribution cost."
    - name: "avg_wash_factor_pct"
      expr: AVG(CAST(wash_factor_pct AS DOUBLE))
      comment: "Average wash factor percentage applied to wholesale allotments. Measures expected allotment attrition for inventory planning."
    - name: "stop_sell_allotment_count"
      expr: COUNT(CASE WHEN is_stop_sell = TRUE THEN 1 END)
      comment: "Number of wholesale allotments under stop-sell. Indicates wholesale demand strength and inventory constraint."
    - name: "stop_sell_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_stop_sell = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of wholesale allotments under stop-sell. Key wholesale yield KPI — high rates indicate strong demand or inventory scarcity."
    - name: "distinct_ota_partners"
      expr: COUNT(DISTINCT ota_partner_id)
      comment: "Number of distinct OTA partners with wholesale allotments. Measures wholesale channel partner diversification."
    - name: "distinct_properties_with_allotments"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with wholesale allotments. Measures wholesale channel property coverage."
    - name: "wholesale_discount_depth_pct"
      expr: ROUND(100.0 * (1 - (SUM(CAST(contracted_net_rate AS DOUBLE)) / NULLIF(SUM(CAST(rack_rate AS DOUBLE)), 0))), 2)
      comment: "Average wholesale discount as a percentage of rack rate. Measures how deeply wholesale rates are discounted — drives pricing strategy and contract renegotiation."
$$;
