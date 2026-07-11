-- Metric views for domain: channel | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-07-10 22:17:24

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core channel booking performance metrics tracking revenue, commission costs, booking volumes, and channel efficiency. Primary KPI layer for distribution channel P&L and revenue management decisions."
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel_booking`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Distribution channel type (e.g. OTA, GDS, Direct, Voice) used to segment booking performance by channel category."
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the booking (e.g. confirmed, cancelled, modified) for filtering active vs. cancelled revenue."
    - name: "rate_type"
      expr: rate_type
      comment: "Rate type applied to the booking (e.g. BAR, corporate, package) for yield and rate strategy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the booking was transacted, enabling multi-currency revenue reporting."
    - name: "source_country"
      expr: source_country
      comment: "Country of origin for the booking, supporting geographic demand and channel mix analysis."
    - name: "is_cancelled"
      expr: is_cancelled
      comment: "Boolean flag indicating whether the booking was cancelled, used to separate active from cancelled booking KPIs."
    - name: "is_rate_parity_compliant"
      expr: is_rate_parity_compliant
      comment: "Boolean flag indicating rate parity compliance for the booking, critical for OTA contract adherence monitoring."
    - name: "cancellation_policy_code"
      expr: cancellation_policy_code
      comment: "Cancellation policy applied to the booking, used to assess risk exposure and policy mix."
    - name: "check_in_date"
      expr: DATE_TRUNC('month', check_in_date)
      comment: "Check-in month bucket for time-series analysis of booking demand and revenue by arrival period."
    - name: "booking_timestamp_month"
      expr: DATE_TRUNC('month', booking_timestamp)
      comment: "Month in which the booking was made, enabling booking pace and lead-time trend analysis."
  measures:
    - name: "total_gross_booking_value"
      expr: SUM(CAST(gross_booking_value AS DOUBLE))
      comment: "Total gross booking value across all channel bookings. Primary top-line revenue KPI for channel distribution performance and investment decisions."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after channel commissions and fees. Core profitability KPI used in channel P&L and margin analysis."
    - name: "total_channel_commission_cost"
      expr: SUM(CAST(channel_commission_amount AS DOUBLE))
      comment: "Total commission paid to distribution channels. Directly informs cost-of-acquisition and channel profitability decisions."
    - name: "total_connectivity_fee_cost"
      expr: SUM(CAST(connectivity_fee_amount AS DOUBLE))
      comment: "Total connectivity fees incurred across channel bookings. Contributes to total cost of distribution and technology investment decisions."
    - name: "avg_daily_rate"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average Daily Rate across channel bookings. Key yield management KPI used to benchmark channel pricing performance."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate percentage across bookings. Used to monitor channel cost trends and negotiate contract terms."
    - name: "total_bookings"
      expr: COUNT(1)
      comment: "Total number of channel bookings. Baseline volume KPI for channel throughput and demand tracking."
    - name: "cancelled_bookings"
      expr: COUNT(CASE WHEN is_cancelled = TRUE THEN 1 END)
      comment: "Count of cancelled bookings. Used to monitor cancellation exposure by channel and inform cancellation policy strategy."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_cancelled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings that were cancelled. Critical channel quality KPI — high cancellation rates signal channel mix or policy issues requiring executive intervention."
    - name: "rate_parity_non_compliant_bookings"
      expr: COUNT(CASE WHEN is_rate_parity_compliant = FALSE THEN 1 END)
      comment: "Count of bookings where rate parity was not maintained. Directly tied to OTA contract compliance risk and potential penalty exposure."
    - name: "rate_parity_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_rate_parity_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings that are rate parity compliant. Regulatory and contractual KPI — non-compliance triggers OTA penalties and contract renegotiation."
    - name: "avg_gross_booking_value"
      expr: AVG(CAST(gross_booking_value AS DOUBLE))
      comment: "Average gross booking value per transaction. Used to assess channel booking quality and compare high-value vs. low-value channel segments."
    - name: "net_revenue_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(net_revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_booking_value AS DOUBLE)), 0), 2)
      comment: "Net revenue as a percentage of gross booking value. Core channel profitability ratio used in distribution strategy and channel mix optimization."
    - name: "commission_cost_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(channel_commission_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_booking_value AS DOUBLE)), 0), 2)
      comment: "Channel commission cost as a percentage of gross booking value. Key cost-of-distribution KPI used to benchmark and optimize channel mix."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_commission_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission accrual and payables metrics tracking total commission liability, payment status, cost of acquisition, and FX exposure across distribution channels. Supports finance, treasury, and channel management decisions."
  source: "`vibe_travel_hospitality_v1`.`channel`.`commission_accrual`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Distribution channel type for segmenting commission liability and cost by channel category."
    - name: "accrual_status"
      expr: accrual_status
      comment: "Current status of the commission accrual (e.g. accrued, paid, disputed, reversed) for payables management."
    - name: "commission_type"
      expr: commission_type
      comment: "Type of commission (e.g. base, override, bonus) for granular cost-of-distribution analysis."
    - name: "commission_basis"
      expr: commission_basis
      comment: "Basis on which commission is calculated (e.g. net rate, gross rate) for contract compliance and cost modeling."
    - name: "is_commissionable"
      expr: is_commissionable
      comment: "Boolean flag indicating whether the booking is commissionable, used to separate commissionable from non-commissionable revenue."
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Local currency of the commission accrual for multi-currency payables and FX exposure reporting."
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account code for commission postings, enabling finance reconciliation and cost center reporting."
    - name: "accrual_date_month"
      expr: DATE_TRUNC('month', accrual_date)
      comment: "Month of commission accrual for time-series payables trend and cash flow forecasting."
    - name: "payment_due_date_month"
      expr: DATE_TRUNC('month', payment_due_date)
      comment: "Month when commission payment is due, used for cash flow planning and payables aging analysis."
  measures:
    - name: "total_commission_accrued_base"
      expr: SUM(CAST(commission_amount_base AS DOUBLE))
      comment: "Total commission accrued in base (USD) currency. Primary payables KPI for finance and treasury — drives cash flow planning and channel cost reporting."
    - name: "total_commission_accrued_local"
      expr: SUM(CAST(commission_amount_local AS DOUBLE))
      comment: "Total commission accrued in local currency. Used alongside base currency for FX exposure and multi-currency payables management."
    - name: "total_gross_booking_value"
      expr: SUM(CAST(gross_booking_value AS DOUBLE))
      comment: "Total gross booking value associated with commission accruals. Provides the revenue base for commission cost ratio calculations."
    - name: "total_cost_of_acquisition"
      expr: SUM(CAST(total_cost_of_acquisition AS DOUBLE))
      comment: "Total cost of acquisition including commission and connectivity fees. Strategic KPI for channel ROI and distribution investment decisions."
    - name: "total_connectivity_fee_cost"
      expr: SUM(CAST(connectivity_fee_amount AS DOUBLE))
      comment: "Total connectivity fees accrued. Contributes to full cost-of-distribution and technology cost management."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across accruals. Used to benchmark channel cost trends and support contract renegotiation decisions."
    - name: "avg_fx_rate"
      expr: AVG(CAST(fx_rate AS DOUBLE))
      comment: "Average FX rate applied to commission accruals. Supports treasury FX exposure monitoring and hedging strategy."
    - name: "total_accrual_records"
      expr: COUNT(1)
      comment: "Total number of commission accrual records. Baseline volume metric for accrual processing throughput and audit completeness."
    - name: "commissionable_bookings"
      expr: COUNT(CASE WHEN is_commissionable = TRUE THEN 1 END)
      comment: "Count of commissionable bookings. Used to assess the proportion of revenue subject to commission cost."
    - name: "commission_cost_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(commission_amount_base AS DOUBLE)) / NULLIF(SUM(CAST(gross_booking_value AS DOUBLE)), 0), 2)
      comment: "Commission cost as a percentage of gross booking value. Core channel profitability KPI used in distribution strategy and budget planning."
    - name: "cost_of_acquisition_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(total_cost_of_acquisition AS DOUBLE)) / NULLIF(SUM(CAST(gross_booking_value AS DOUBLE)), 0), 2)
      comment: "Total cost of acquisition as a percentage of gross booking value. Strategic KPI for evaluating channel efficiency and ROI — directly informs channel mix optimization."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel portfolio health and configuration metrics tracking active channel count, commission economics, SLA performance, and channel capability coverage. Supports channel strategy, vendor management, and technology investment decisions."
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Type of distribution channel (e.g. OTA, GDS, Direct, Voice) for portfolio segmentation."
    - name: "channel_status"
      expr: channel_status
      comment: "Operational status of the channel (e.g. active, inactive, suspended) for portfolio health monitoring."
    - name: "category"
      expr: category
      comment: "Channel category classification for strategic grouping and portfolio analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the channel (e.g. global, regional, domestic) for market coverage analysis."
    - name: "payment_model"
      expr: payment_model
      comment: "Payment model used by the channel (e.g. merchant, agency) for financial flow and reconciliation analysis."
    - name: "commission_basis"
      expr: commission_basis
      comment: "Basis on which channel commission is calculated for cost modeling and contract benchmarking."
    - name: "loyalty_bookings_eligible"
      expr: loyalty_bookings_eligible
      comment: "Boolean flag indicating whether the channel supports loyalty bookings, used for loyalty program distribution strategy."
    - name: "rate_parity_required"
      expr: rate_parity_required
      comment: "Boolean flag indicating whether rate parity is contractually required for this channel."
    - name: "pci_compliant"
      expr: pci_compliant
      comment: "Boolean flag indicating PCI compliance status of the channel, critical for payment security governance."
    - name: "activation_date_month"
      expr: DATE_TRUNC('month', activation_date)
      comment: "Month of channel activation for tracking channel onboarding pace and portfolio growth trends."
  measures:
    - name: "total_active_channels"
      expr: COUNT(CASE WHEN channel_status = 'active' THEN 1 END)
      comment: "Count of currently active distribution channels. Core portfolio KPI — directly informs distribution reach and channel investment decisions."
    - name: "total_channels"
      expr: COUNT(1)
      comment: "Total number of channels in the portfolio including all statuses. Baseline for portfolio size and coverage analysis."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate percentage across all channels. Used to benchmark channel cost levels and support contract negotiation strategy."
    - name: "total_booking_fee_usd"
      expr: SUM(CAST(booking_fee_usd AS DOUBLE))
      comment: "Total booking fees across all channels. Contributes to total cost-of-distribution and technology cost management."
    - name: "total_connectivity_fee_usd"
      expr: SUM(CAST(connectivity_fee_usd AS DOUBLE))
      comment: "Total connectivity fees across all channels. Key technology cost KPI for channel infrastructure investment decisions."
    - name: "avg_sla_uptime_pct"
      expr: AVG(CAST(sla_uptime_pct AS DOUBLE))
      comment: "Average SLA uptime percentage across channels. Operational reliability KPI — below-threshold uptime triggers vendor escalation and contract review."
    - name: "pci_compliant_channel_count"
      expr: COUNT(CASE WHEN pci_compliant = TRUE THEN 1 END)
      comment: "Count of PCI-compliant channels. Regulatory compliance KPI — non-compliant channels represent payment security risk requiring executive action."
    - name: "loyalty_eligible_channel_count"
      expr: COUNT(CASE WHEN loyalty_bookings_eligible = TRUE THEN 1 END)
      comment: "Count of channels eligible for loyalty bookings. Supports loyalty program distribution strategy and member acquisition decisions."
    - name: "rate_parity_required_channel_count"
      expr: COUNT(CASE WHEN rate_parity_required = TRUE THEN 1 END)
      comment: "Count of channels with contractual rate parity requirements. Informs revenue management constraints and OTA contract compliance risk."
    - name: "channel_activation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN channel_status = 'active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of channels that are currently active. Portfolio health KPI — low activation rates signal distribution gaps or onboarding issues."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_ota_partner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OTA partner portfolio metrics tracking partner quality, commission economics, content performance, and contract coverage. Supports OTA relationship management, contract negotiation, and distribution strategy decisions."
  source: "`vibe_travel_hospitality_v1`.`channel`.`ota_partner`"
  dimensions:
    - name: "partner_type"
      expr: partner_type
      comment: "Type of OTA partner (e.g. global OTA, regional OTA, metasearch) for portfolio segmentation."
    - name: "partner_status"
      expr: partner_status
      comment: "Operational status of the OTA partner (e.g. active, inactive, suspended) for portfolio health monitoring."
    - name: "commission_model"
      expr: commission_model
      comment: "Commission model used by the OTA partner (e.g. merchant, agency, net rate) for cost structure analysis."
    - name: "primary_market_country_code"
      expr: primary_market_country_code
      comment: "Primary market country of the OTA partner for geographic distribution strategy analysis."
    - name: "preferred_partner"
      expr: preferred_partner
      comment: "Boolean flag indicating preferred partner status, used to segment strategic vs. standard OTA relationships."
    - name: "rate_parity_clause"
      expr: rate_parity_clause
      comment: "Boolean flag indicating whether the OTA contract includes a rate parity clause, critical for revenue management constraints."
    - name: "payment_collection_party"
      expr: payment_collection_party
      comment: "Party responsible for payment collection (e.g. hotel, OTA) for financial flow and reconciliation analysis."
    - name: "connectivity_protocol"
      expr: connectivity_protocol
      comment: "Technical connectivity protocol used by the OTA partner for technology stack and integration management."
    - name: "contract_effective_date_month"
      expr: DATE_TRUNC('month', contract_effective_date)
      comment: "Month of contract effective date for contract lifecycle and renewal pipeline analysis."
  measures:
    - name: "total_ota_partners"
      expr: COUNT(1)
      comment: "Total number of OTA partners in the portfolio. Baseline distribution reach KPI for channel strategy decisions."
    - name: "active_ota_partners"
      expr: COUNT(CASE WHEN partner_status = 'active' THEN 1 END)
      comment: "Count of currently active OTA partners. Core portfolio health KPI — directly informs distribution reach and partner investment decisions."
    - name: "preferred_partner_count"
      expr: COUNT(CASE WHEN preferred_partner = TRUE THEN 1 END)
      comment: "Count of preferred OTA partners. Supports strategic partner tier management and preferential investment allocation."
    - name: "avg_base_commission_rate_pct"
      expr: AVG(CAST(base_commission_rate_pct AS DOUBLE))
      comment: "Average base commission rate across OTA partners. Key cost-of-distribution benchmark used in contract negotiation and channel mix optimization."
    - name: "avg_preferred_commission_rate_pct"
      expr: AVG(CAST(preferred_commission_rate_pct AS DOUBLE))
      comment: "Average preferred/negotiated commission rate across OTA partners. Used to measure the value of preferred partner programs and negotiate better terms."
    - name: "avg_content_score"
      expr: AVG(CAST(content_score AS DOUBLE))
      comment: "Average content score across OTA partners. Content quality directly impacts conversion rates and booking volumes — low scores trigger content improvement actions."
    - name: "avg_review_score"
      expr: AVG(CAST(review_score AS DOUBLE))
      comment: "Average guest review score across OTA partners. Reputation KPI — low scores on key OTA channels trigger service quality and reputation management actions."
    - name: "total_connectivity_fee_usd"
      expr: SUM(CAST(connectivity_fee_usd AS DOUBLE))
      comment: "Total connectivity fees across OTA partners. Technology cost KPI for distribution infrastructure investment decisions."
    - name: "rate_parity_clause_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rate_parity_clause = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OTA partners with rate parity clauses. Informs revenue management constraints and the scope of rate parity compliance obligations."
    - name: "commission_rate_savings_pct"
      expr: ROUND(100.0 * (AVG(CAST(base_commission_rate_pct AS DOUBLE)) - AVG(CAST(preferred_commission_rate_pct AS DOUBLE))) / NULLIF(AVG(CAST(base_commission_rate_pct AS DOUBLE)), 0), 2)
      comment: "Percentage reduction from base to preferred commission rate. Measures the financial value of preferred partner negotiations — directly informs partner tier investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel contract portfolio metrics tracking contract coverage, commission economics, compliance obligations, and contract lifecycle health. Supports legal, finance, and channel management decisions."
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of channel contract (e.g. OTA, GDS, direct) for portfolio segmentation and compliance analysis."
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract (e.g. active, expired, terminated, pending) for contract lifecycle management."
    - name: "commission_basis"
      expr: commission_basis
      comment: "Basis on which contract commission is calculated for cost modeling and benchmarking."
    - name: "payment_model"
      expr: payment_model
      comment: "Payment model specified in the contract for financial flow and reconciliation analysis."
    - name: "rate_parity_clause"
      expr: rate_parity_clause
      comment: "Boolean flag indicating whether the contract includes a rate parity clause, critical for revenue management constraints."
    - name: "preferred_partner_tier"
      expr: preferred_partner_tier
      comment: "Preferred partner tier specified in the contract for strategic relationship management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract for multi-currency financial reporting and FX exposure analysis."
    - name: "renewal_type"
      expr: renewal_type
      comment: "Contract renewal type (e.g. auto-renew, manual) for contract lifecycle and risk management."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of contract effective date for contract pipeline and lifecycle trend analysis."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month of contract expiration for renewal pipeline management and risk exposure tracking."
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of channel contracts in the portfolio. Baseline KPI for contract coverage and distribution governance."
    - name: "active_contracts"
      expr: COUNT(CASE WHEN contract_status = 'active' THEN 1 END)
      comment: "Count of currently active channel contracts. Core governance KPI — active contract coverage directly impacts distribution legality and commission liability."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across all channel contracts. Used to benchmark contract economics and support renegotiation decisions."
    - name: "total_connectivity_fee"
      expr: SUM(CAST(connectivity_fee AS DOUBLE))
      comment: "Total connectivity fees committed across all contracts. Technology cost KPI for distribution infrastructure budget planning."
    - name: "total_marketing_coop_amount"
      expr: SUM(CAST(marketing_coop_amount AS DOUBLE))
      comment: "Total marketing co-op investment committed across channel contracts. Directly informs marketing budget allocation and channel partnership ROI."
    - name: "rate_parity_clause_count"
      expr: COUNT(CASE WHEN rate_parity_clause = TRUE THEN 1 END)
      comment: "Count of contracts with rate parity clauses. Informs the scope of rate parity compliance obligations and revenue management constraints."
    - name: "pci_compliance_confirmed_count"
      expr: COUNT(CASE WHEN pci_compliance_confirmed = TRUE THEN 1 END)
      comment: "Count of contracts with confirmed PCI compliance. Regulatory KPI — unconfirmed PCI compliance represents payment security and legal risk."
    - name: "active_contract_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN contract_status = 'active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts that are currently active. Portfolio health KPI — low active rates signal contract expiry risk and distribution gaps."
    - name: "nrr_allowed_contract_count"
      expr: COUNT(CASE WHEN nrr_allowed = TRUE THEN 1 END)
      comment: "Count of contracts permitting non-refundable rates. Supports revenue management strategy for NRR rate plan distribution."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_stop_sell`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stop-sell and channel restriction metrics tracking restriction frequency, duration, revenue impact context, and operational patterns. Supports revenue management, channel operations, and inventory strategy decisions."
  source: "`vibe_travel_hospitality_v1`.`channel`.`stop_sell`"
  dimensions:
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of restriction applied (e.g. stop-sell, minimum stay, closed to arrival) for operational pattern analysis."
    - name: "restriction_status"
      expr: restriction_status
      comment: "Current status of the restriction (e.g. active, lifted, expired) for monitoring active inventory constraints."
    - name: "channel_type"
      expr: channel_type
      comment: "Channel type affected by the restriction for channel-specific inventory management analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the stop-sell restriction (e.g. overbooking, renovation, event) for root cause and pattern analysis."
    - name: "action_type"
      expr: action_type
      comment: "Action type of the restriction (e.g. apply, lift, modify) for operational workflow analysis."
    - name: "is_all_channels"
      expr: is_all_channels
      comment: "Boolean flag indicating whether the restriction applies to all channels, used to assess broad vs. targeted restriction impact."
    - name: "is_system_generated"
      expr: is_system_generated
      comment: "Boolean flag indicating whether the restriction was system-generated vs. manually applied, for automation and override analysis."
    - name: "transmission_status"
      expr: transmission_status
      comment: "Status of restriction transmission to channel systems (e.g. transmitted, pending, failed) for operational reliability monitoring."
    - name: "stay_date_from_month"
      expr: DATE_TRUNC('month', stay_date_from)
      comment: "Month of restriction start date for time-series analysis of restriction patterns and seasonal inventory management."
  measures:
    - name: "total_stop_sell_events"
      expr: COUNT(1)
      comment: "Total number of stop-sell and restriction events. Baseline operational KPI for inventory constraint frequency and channel management workload."
    - name: "active_restrictions"
      expr: COUNT(CASE WHEN restriction_status = 'active' THEN 1 END)
      comment: "Count of currently active channel restrictions. Real-time inventory availability KPI — high active restriction counts signal revenue risk and require immediate revenue management action."
    - name: "system_generated_restrictions"
      expr: COUNT(CASE WHEN is_system_generated = TRUE THEN 1 END)
      comment: "Count of system-generated restrictions. Measures automation effectiveness in revenue management — high manual override rates signal system calibration issues."
    - name: "all_channel_restrictions"
      expr: COUNT(CASE WHEN is_all_channels = TRUE THEN 1 END)
      comment: "Count of restrictions applied across all channels simultaneously. High-impact operational KPI — all-channel stops represent maximum revenue risk and require executive visibility."
    - name: "avg_adr_at_apply"
      expr: AVG(CAST(adr_at_apply AS DOUBLE))
      comment: "Average ADR at the time restrictions were applied. Contextualizes the revenue impact of stop-sell decisions and informs pricing strategy during constrained periods."
    - name: "avg_occupancy_at_apply"
      expr: AVG(CAST(occupancy_at_apply AS DOUBLE))
      comment: "Average occupancy rate at the time restrictions were applied. Used to validate whether stop-sell decisions were triggered at appropriate occupancy thresholds."
    - name: "avg_revpar_at_apply"
      expr: AVG(CAST(revpar_at_apply AS DOUBLE))
      comment: "Average RevPAR at the time restrictions were applied. Key revenue management KPI — contextualizes the yield impact of channel restriction decisions."
    - name: "transmission_failure_count"
      expr: COUNT(CASE WHEN transmission_status = 'failed' THEN 1 END)
      comment: "Count of restrictions that failed to transmit to channel systems. Operational reliability KPI — transmission failures mean restrictions are not enforced, creating overbooking and rate parity risk."
    - name: "transmission_failure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN transmission_status = 'failed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of restrictions that failed transmission. Technology reliability KPI — high failure rates trigger channel manager escalation and system remediation."
    - name: "system_automation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_system_generated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of restrictions that were system-generated. Revenue management automation KPI — tracks progress toward automated yield management and reduces manual operational burden."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_rate_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel rate plan portfolio metrics tracking rate economics, parity compliance, refundability mix, and rate loading health. Supports revenue management, distribution strategy, and rate governance decisions."
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel_rate_plan`"
  dimensions:
    - name: "rate_plan_type"
      expr: rate_plan_type
      comment: "Type of rate plan (e.g. BAR, corporate, package, promotional) for rate portfolio segmentation."
    - name: "channel_rate_plan_status"
      expr: channel_rate_plan_status
      comment: "Current status of the channel rate plan (e.g. active, inactive, pending) for rate portfolio health monitoring."
    - name: "rate_loading_status"
      expr: rate_loading_status
      comment: "Status of rate loading to channel systems (e.g. loaded, pending, failed) for distribution operations monitoring."
    - name: "rate_derivation_method"
      expr: rate_derivation_method
      comment: "Method used to derive the channel rate (e.g. flat, percentage, derived) for rate strategy analysis."
    - name: "is_rate_parity_applicable"
      expr: is_rate_parity_applicable
      comment: "Boolean flag indicating whether rate parity applies to this rate plan, for compliance scope analysis."
    - name: "is_refundable"
      expr: is_refundable
      comment: "Boolean flag indicating whether the rate plan is refundable, for cancellation risk and NRR strategy analysis."
    - name: "is_package_rate"
      expr: is_package_rate
      comment: "Boolean flag indicating whether the rate plan is a package rate, for ancillary revenue and packaging strategy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rate plan for multi-currency rate management and FX analysis."
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month from which the rate plan is effective for rate lifecycle and seasonal pricing analysis."
  measures:
    - name: "total_rate_plans"
      expr: COUNT(1)
      comment: "Total number of channel rate plans. Baseline KPI for rate portfolio size and distribution complexity management."
    - name: "active_rate_plans"
      expr: COUNT(CASE WHEN channel_rate_plan_status = 'active' THEN 1 END)
      comment: "Count of currently active channel rate plans. Core distribution KPI — active rate plan coverage directly impacts booking availability and revenue capture."
    - name: "avg_channel_rate_amount"
      expr: AVG(CAST(channel_rate_amount AS DOUBLE))
      comment: "Average channel rate amount across all rate plans. Key pricing KPI used to benchmark channel rate levels and monitor rate strategy execution."
    - name: "avg_base_rate_amount"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base rate amount across all rate plans. Used alongside channel rate to measure rate adjustment magnitude and channel pricing strategy."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate percentage across channel rate plans. Used to monitor cost-of-distribution at the rate plan level and optimize rate plan mix."
    - name: "avg_rate_adjustment_value"
      expr: AVG(CAST(rate_adjustment_value AS DOUBLE))
      comment: "Average rate adjustment value applied to channel rates. Measures the magnitude of channel-specific pricing adjustments for rate strategy governance."
    - name: "rate_parity_applicable_count"
      expr: COUNT(CASE WHEN is_rate_parity_applicable = TRUE THEN 1 END)
      comment: "Count of rate plans subject to rate parity requirements. Informs the scope of rate parity compliance obligations across the distribution portfolio."
    - name: "non_refundable_rate_plan_count"
      expr: COUNT(CASE WHEN is_refundable = FALSE THEN 1 END)
      comment: "Count of non-refundable rate plans. Supports NRR strategy analysis and cancellation risk management decisions."
    - name: "rate_loading_failure_count"
      expr: COUNT(CASE WHEN rate_loading_status = 'failed' THEN 1 END)
      comment: "Count of rate plans with failed loading status. Operational KPI — loading failures mean rates are not available on channels, directly causing lost revenue."
    - name: "channel_rate_vs_base_rate_variance"
      expr: ROUND(AVG(CAST(channel_rate_amount AS DOUBLE)) - AVG(CAST(base_rate_amount AS DOUBLE)), 2)
      comment: "Average difference between channel rate and base rate. Measures the net pricing adjustment applied through channel distribution — informs rate strategy and parity compliance."
$$;