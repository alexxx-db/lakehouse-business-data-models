-- Metric views for domain: tariff | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 07:51:56

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_port_tariff`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic overview of port tariff schedules — base rate levels, revenue exposure, and tariff lifecycle status. Used by commercial and regulatory teams to monitor tariff competitiveness and compliance posture."
  source: "`vibe_shipping_ports_v1`.`tariff`.`port_tariff`"
  dimensions:
    - name: "tariff_status"
      expr: tariff_status
      comment: "Current lifecycle status of the port tariff (e.g. Active, Draft, Superseded, Withdrawn) — primary filter for operational vs. historical tariffs."
    - name: "charge_type"
      expr: charge_type
      comment: "Category of charge governed by this tariff (e.g. Port Dues, THC, Storage, Wharfage) — enables analysis by charge category."
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency for the tariff — supports multi-currency revenue analysis."
    - name: "public_tariff_flag"
      expr: public_tariff_flag
      comment: "Indicates whether the tariff is publicly published vs. confidential/negotiated — distinguishes open-market from contract rates."
    - name: "regulatory_filing_required_flag"
      expr: regulatory_filing_required_flag
      comment: "Flags tariffs requiring regulatory filing — critical for compliance monitoring."
    - name: "effective_from_date"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the tariff became effective — enables trend analysis of tariff introductions over time."
    - name: "trade_lane_scope"
      expr: applicable_trade_lanes
      comment: "Trade lanes covered by this tariff — supports lane-level commercial analysis."
    - name: "discount_eligible_flag"
      expr: discount_eligible_flag
      comment: "Whether the tariff allows discount application — used to segment negotiable vs. fixed tariffs."
  measures:
    - name: "active_tariff_count"
      expr: COUNT(CASE WHEN tariff_status = 'Active' THEN port_tariff_id END)
      comment: "Number of currently active port tariffs. Executives use this to gauge tariff portfolio breadth and identify gaps in coverage."
    - name: "avg_base_rate_amount"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base rate across all port tariffs. Benchmarks rate levels against market and informs pricing strategy reviews."
    - name: "max_base_rate_amount"
      expr: MAX(CAST(base_rate_amount AS DOUBLE))
      comment: "Highest base rate in the tariff portfolio. Identifies premium-tier tariffs and potential outliers requiring review."
    - name: "min_base_rate_amount"
      expr: MIN(CAST(base_rate_amount AS DOUBLE))
      comment: "Lowest base rate in the tariff portfolio. Identifies floor pricing and potential below-cost tariffs."
    - name: "avg_minimum_charge_amount"
      expr: AVG(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Average minimum charge floor across tariffs. Ensures revenue floor adequacy and informs minimum charge policy."
    - name: "avg_maximum_charge_amount"
      expr: AVG(CAST(maximum_charge_amount AS DOUBLE))
      comment: "Average maximum charge cap across tariffs. Monitors revenue ceiling constraints that may limit upside on high-volume calls."
    - name: "regulatory_filing_required_count"
      expr: COUNT(CASE WHEN regulatory_filing_required_flag = TRUE THEN port_tariff_id END)
      comment: "Number of tariffs requiring regulatory filing. Drives compliance workload planning and risk exposure tracking."
    - name: "public_tariff_count"
      expr: COUNT(CASE WHEN public_tariff_flag = TRUE THEN port_tariff_id END)
      comment: "Number of publicly published tariffs. Measures transparency posture and open-market rate availability."
    - name: "discount_eligible_tariff_count"
      expr: COUNT(CASE WHEN discount_eligible_flag = TRUE THEN port_tariff_id END)
      comment: "Number of tariffs eligible for discount application. Quantifies the negotiable portion of the tariff portfolio."
    - name: "superseded_tariff_count"
      expr: COUNT(CASE WHEN superseded_by_tariff_port_tariff_id IS NOT NULL THEN port_tariff_id END)
      comment: "Number of tariffs that have been superseded. Tracks tariff churn and version management health."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_rate_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commercial rate card performance metrics — committed volume, discount depth, premium levels, and SLA linkage. Central KPI view for commercial managers and account teams tracking customer rate agreements."
  source: "`vibe_shipping_ports_v1`.`tariff`.`rate_card`"
  dimensions:
    - name: "rate_card_type"
      expr: rate_card_type
      comment: "Classification of the rate card (e.g. Standard, Negotiated, Promotional, SLA-Linked) — segments commercial vs. standard pricing."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval lifecycle state of the rate card — filters approved vs. pending vs. rejected cards."
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency of the rate card — supports multi-currency commercial analysis."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment the rate card targets (e.g. Tier 1 Shipping Line, Freight Forwarder, NVO) — enables segment-level pricing analysis."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier associated with the rate card — links pricing to service level commitments."
    - name: "trade_lane"
      expr: trade_lane
      comment: "Trade lane scope of the rate card — enables lane-level commercial performance analysis."
    - name: "service_type"
      expr: service_type
      comment: "Service type covered by the rate card (e.g. FCL, LCL, RoRo, Reefer) — segments revenue by service category."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the rate card became effective — tracks rate card issuance cadence over time."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the rate card auto-renews — identifies contracts requiring proactive renegotiation."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing cycle for the rate card (e.g. Monthly, Per-Call, Annual) — supports cash flow forecasting."
  measures:
    - name: "total_committed_volume_teu"
      expr: SUM(CAST(committed_volume_teu AS DOUBLE))
      comment: "Total TEU volume committed across all rate cards. Primary commercial KPI — measures contracted throughput pipeline and revenue backlog."
    - name: "avg_committed_volume_teu"
      expr: AVG(CAST(committed_volume_teu AS DOUBLE))
      comment: "Average TEU commitment per rate card. Benchmarks deal size and identifies under-committed accounts."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount depth granted across rate cards. Monitors margin erosion from commercial concessions — triggers pricing policy review if trending up."
    - name: "avg_premium_percentage"
      expr: AVG(CAST(premium_percentage AS DOUBLE))
      comment: "Average premium uplift across rate cards. Measures ability to capture premium pricing for high-service or priority customers."
    - name: "total_minimum_commitment_amount"
      expr: SUM(CAST(minimum_commitment_amount AS DOUBLE))
      comment: "Total minimum revenue commitment across all active rate cards. Represents the guaranteed revenue floor from contracted customers."
    - name: "avg_minimum_commitment_amount"
      expr: AVG(CAST(minimum_commitment_amount AS DOUBLE))
      comment: "Average minimum revenue commitment per rate card. Benchmarks deal quality and identifies low-commitment accounts."
    - name: "avg_crane_productivity_target"
      expr: AVG(CAST(crane_productivity_target_moves_per_hour AS DOUBLE))
      comment: "Average crane productivity target (moves/hour) committed in rate cards. Links commercial commitments to operational SLA obligations."
    - name: "avg_vessel_turnaround_target_hours"
      expr: AVG(CAST(vessel_turnaround_time_target_hours AS DOUBLE))
      comment: "Average vessel turnaround time target committed in rate cards. Measures operational SLA stringency embedded in commercial agreements."
    - name: "avg_gate_processing_time_target_minutes"
      expr: AVG(CAST(gate_processing_time_target_minutes AS DOUBLE))
      comment: "Average gate processing time target committed in rate cards. Tracks gate SLA obligations embedded in commercial pricing."
    - name: "active_rate_card_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN rate_card_id END)
      comment: "Number of approved and active rate cards. Measures the breadth of the commercial rate portfolio."
    - name: "auto_renewal_rate_card_count"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN rate_card_id END)
      comment: "Number of rate cards set to auto-renew. Identifies contracts that may roll over without renegotiation — revenue retention risk indicator."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_rate_card_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level rate card metrics — unit rates, discount depth, surcharge applicability, and SLA targets per charge line. Enables granular pricing analysis by cargo type, service category, and vessel size."
  source: "`vibe_shipping_ports_v1`.`tariff`.`rate_card_line`"
  dimensions:
    - name: "cargo_type"
      expr: cargo_type
      comment: "Cargo type the rate line applies to (e.g. Dry, Reefer, DG, OOG) — primary segmentation for rate analysis."
    - name: "service_category"
      expr: service_category
      comment: "Service category of the charge line (e.g. Handling, Storage, Pilotage, Towage) — enables service-level revenue decomposition."
    - name: "vessel_size_category"
      expr: vessel_size_category
      comment: "Vessel size band the rate applies to — links pricing to vessel class for port dues and handling charge analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rate line — supports multi-currency rate analysis."
    - name: "line_status"
      expr: line_status
      comment: "Lifecycle status of the rate card line (Active, Expired, Superseded) — filters operational vs. historical lines."
    - name: "baf_applicable_flag"
      expr: baf_applicable_flag
      comment: "Whether BAF (Bunker Adjustment Factor) applies to this line — identifies fuel-cost-exposed revenue lines."
    - name: "caf_applicable_flag"
      expr: caf_applicable_flag
      comment: "Whether CAF (Currency Adjustment Factor) applies to this line — identifies FX-exposed revenue lines."
    - name: "surcharge_applicable_flag"
      expr: surcharge_applicable_flag
      comment: "Whether surcharges apply to this rate line — quantifies surcharge-exposed revenue."
    - name: "effective_from_date_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the rate line became effective — tracks rate change cadence."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing cycle for the rate line — supports cash flow and invoice frequency analysis."
  measures:
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate across rate card lines. Core pricing KPI — benchmarks rate levels by cargo type, service, and vessel size."
    - name: "max_unit_rate"
      expr: MAX(CAST(unit_rate AS DOUBLE))
      comment: "Maximum unit rate in the portfolio. Identifies premium pricing ceiling and potential outliers."
    - name: "min_unit_rate"
      expr: MIN(CAST(unit_rate AS DOUBLE))
      comment: "Minimum unit rate in the portfolio. Identifies floor pricing and potential below-cost lines."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount depth on rate card lines. Monitors margin erosion at the line level — more granular than card-level discount analysis."
    - name: "avg_tax_rate_percentage"
      expr: AVG(CAST(tax_rate_percentage AS DOUBLE))
      comment: "Average tax rate applied to rate lines. Supports tax liability estimation and compliance reporting."
    - name: "avg_penalty_rate"
      expr: AVG(CAST(penalty_rate AS DOUBLE))
      comment: "Average penalty rate on rate lines. Measures punitive charge exposure for SLA breaches or contract violations."
    - name: "avg_sla_target_hours"
      expr: AVG(CAST(sla_target_hours AS DOUBLE))
      comment: "Average SLA target hours embedded in rate lines. Links pricing to operational service commitments."
    - name: "baf_exposed_line_count"
      expr: COUNT(CASE WHEN baf_applicable_flag = TRUE THEN rate_card_line_id END)
      comment: "Number of rate lines exposed to BAF adjustments. Quantifies fuel-cost pass-through exposure in the rate portfolio."
    - name: "caf_exposed_line_count"
      expr: COUNT(CASE WHEN caf_applicable_flag = TRUE THEN rate_card_line_id END)
      comment: "Number of rate lines exposed to CAF adjustments. Quantifies FX pass-through exposure in the rate portfolio."
    - name: "avg_tier_threshold_lower"
      expr: AVG(CAST(tier_threshold_lower AS DOUBLE))
      comment: "Average lower tier threshold across tiered rate lines. Informs volume incentive structure design."
    - name: "avg_tier_threshold_upper"
      expr: AVG(CAST(tier_threshold_upper AS DOUBLE))
      comment: "Average upper tier threshold across tiered rate lines. Informs volume incentive ceiling and tier band width."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_thc_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Terminal Handling Charge (THC) schedule analytics — base rates, surcharges, and schedule coverage by container type, movement, and trade lane. THC is the primary revenue line for container terminals and a key competitive differentiator."
  source: "`vibe_shipping_ports_v1`.`tariff`.`thc_schedule`"
  dimensions:
    - name: "container_type"
      expr: container_type
      comment: "Container type the THC schedule applies to (e.g. 20GP, 40GP, 40HC, Reefer, OOG) — primary segmentation for THC analysis."
    - name: "movement_type"
      expr: movement_type
      comment: "Direction of container movement (Import, Export, Transhipment) — critical for THC revenue decomposition."
    - name: "trade_lane"
      expr: trade_lane
      comment: "Trade lane the THC schedule covers — enables lane-level THC competitiveness analysis."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment the THC applies to — segments standard vs. negotiated THC rates."
    - name: "cargo_category"
      expr: cargo_category
      comment: "Cargo category (Dry, Reefer, DG, Break-Bulk) — enables cargo-type THC analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the THC schedule — filters approved vs. pending schedules."
    - name: "effective_from_date_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the THC schedule became effective — tracks THC rate change history."
    - name: "service_level"
      expr: service_level
      comment: "Service level tier associated with the THC (e.g. Standard, Priority, Express) — links THC to service quality."
    - name: "discount_eligible_flag"
      expr: discount_eligible_flag
      comment: "Whether the THC schedule allows discounting — segments negotiable vs. fixed THC rates."
  measures:
    - name: "avg_base_thc_rate"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base THC rate across schedules. Primary pricing KPI — benchmarks THC competitiveness by container type and trade lane."
    - name: "max_base_thc_rate"
      expr: MAX(CAST(base_rate_amount AS DOUBLE))
      comment: "Maximum base THC rate in the portfolio. Identifies premium THC ceiling and potential outliers."
    - name: "min_base_thc_rate"
      expr: MIN(CAST(base_rate_amount AS DOUBLE))
      comment: "Minimum base THC rate in the portfolio. Identifies floor pricing and below-market rates."
    - name: "avg_reefer_surcharge"
      expr: AVG(CAST(reefer_surcharge AS DOUBLE))
      comment: "Average reefer surcharge on THC schedules. Reefer handling commands premium rates — monitors reefer revenue uplift."
    - name: "avg_dg_surcharge"
      expr: AVG(CAST(dangerous_goods_surcharge AS DOUBLE))
      comment: "Average dangerous goods surcharge on THC schedules. DG handling requires special resources — monitors DG revenue adequacy."
    - name: "avg_oversize_surcharge"
      expr: AVG(CAST(oversize_surcharge AS DOUBLE))
      comment: "Average oversize/OOG surcharge on THC schedules. OOG cargo requires special handling — monitors OOG revenue adequacy."
    - name: "avg_peak_season_surcharge"
      expr: AVG(CAST(peak_season_surcharge AS DOUBLE))
      comment: "Average peak season surcharge on THC schedules. Measures revenue uplift captured during high-demand periods."
    - name: "avg_minimum_charge_amount"
      expr: AVG(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Average minimum THC charge floor. Ensures revenue floor adequacy per container move."
    - name: "avg_maximum_charge_amount"
      expr: AVG(CAST(maximum_charge_amount AS DOUBLE))
      comment: "Average maximum THC charge cap. Monitors revenue ceiling constraints on large-volume moves."
    - name: "active_thc_schedule_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN thc_schedule_id END)
      comment: "Number of approved active THC schedules. Measures THC portfolio coverage across container types and trade lanes."
    - name: "avg_container_size_teu"
      expr: AVG(CAST(container_size_teu AS DOUBLE))
      comment: "Average container size (TEU) across THC schedules. Tracks the TEU mix of the THC portfolio — larger containers drive higher absolute revenue."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_demurrage_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demurrage schedule analytics — free time allowances, tiered rate structures, and maximum caps by container type, cargo type, and trade lane. Demurrage is a high-margin revenue line and a key customer satisfaction driver."
  source: "`vibe_shipping_ports_v1`.`tariff`.`demurrage_schedule`"
  dimensions:
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of demurrage schedule (Import, Export, Transhipment) — primary segmentation for demurrage analysis."
    - name: "cargo_type"
      expr: cargo_type
      comment: "Cargo type the demurrage schedule applies to — enables cargo-specific demurrage analysis."
    - name: "customer_tier"
      expr: customer_tier
      comment: "Customer tier the schedule applies to — segments standard vs. preferential demurrage terms."
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency for demurrage charges — supports multi-currency analysis."
    - name: "trade_lane"
      expr: trade_lane
      comment: "Trade lane scope of the demurrage schedule — enables lane-level demurrage benchmarking."
    - name: "demurrage_schedule_status"
      expr: demurrage_schedule_status
      comment: "Lifecycle status of the schedule (Active, Expired, Draft) — filters operational schedules."
    - name: "holiday_exclusion_flag"
      expr: holiday_exclusion_flag
      comment: "Whether public holidays are excluded from demurrage calculation — affects effective free time."
    - name: "weekend_exclusion_flag"
      expr: weekend_exclusion_flag
      comment: "Whether weekends are excluded from demurrage calculation — affects effective free time."
    - name: "effective_from_date_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the demurrage schedule became effective — tracks schedule change history."
  measures:
    - name: "avg_tier_1_demurrage_rate"
      expr: AVG(CAST(rate_tier_1_amount AS DOUBLE))
      comment: "Average Tier 1 (initial) demurrage daily rate. Benchmarks entry-level demurrage pricing — most frequently applied tier."
    - name: "avg_tier_2_demurrage_rate"
      expr: AVG(CAST(rate_tier_2_amount AS DOUBLE))
      comment: "Average Tier 2 (escalated) demurrage daily rate. Measures escalation step — higher tiers incentivize faster container return."
    - name: "avg_tier_3_demurrage_rate"
      expr: AVG(CAST(rate_tier_3_amount AS DOUBLE))
      comment: "Average Tier 3 (maximum escalation) demurrage daily rate. Represents the punitive ceiling rate for long-dwell containers."
    - name: "avg_maximum_demurrage_cap"
      expr: AVG(CAST(maximum_demurrage_cap AS DOUBLE))
      comment: "Average maximum demurrage cap across schedules. Monitors revenue ceiling constraints — caps limit upside on long-dwell containers."
    - name: "tier_2_to_tier_1_rate_escalation_ratio"
      expr: AVG(CAST(rate_tier_2_amount AS DOUBLE)) / NULLIF(AVG(CAST(rate_tier_1_amount AS DOUBLE)), 0)
      comment: "Ratio of average Tier 2 to Tier 1 demurrage rate. Measures escalation steepness — steeper escalation drives faster container return and higher revenue per dwell day."
    - name: "tier_3_to_tier_1_rate_escalation_ratio"
      expr: AVG(CAST(rate_tier_3_amount AS DOUBLE)) / NULLIF(AVG(CAST(rate_tier_1_amount AS DOUBLE)), 0)
      comment: "Ratio of average Tier 3 to Tier 1 demurrage rate. Measures full escalation range — indicates punitive pricing strength."
    - name: "active_demurrage_schedule_count"
      expr: COUNT(CASE WHEN demurrage_schedule_status = 'Active' THEN demurrage_schedule_id END)
      comment: "Number of active demurrage schedules. Measures coverage of the demurrage tariff portfolio."
    - name: "prorated_calculation_schedule_count"
      expr: COUNT(CASE WHEN prorated_calculation_flag = TRUE THEN demurrage_schedule_id END)
      comment: "Number of schedules using prorated demurrage calculation. Prorated schedules are more customer-friendly — tracks commercial flexibility posture."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_detention_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detention schedule analytics — free time, tiered rates, and caps for container detention (off-terminal). Detention revenue is a significant P&L line and a key lever in shipping line negotiations."
  source: "`vibe_shipping_ports_v1`.`tariff`.`detention_schedule`"
  dimensions:
    - name: "cargo_type"
      expr: cargo_type
      comment: "Cargo type the detention schedule applies to — enables cargo-specific detention analysis."
    - name: "customer_tier"
      expr: customer_tier
      comment: "Customer tier the schedule applies to — segments standard vs. preferential detention terms."
    - name: "trade_direction"
      expr: trade_direction
      comment: "Import or Export direction — detention dynamics differ significantly by direction."
    - name: "service_line"
      expr: service_line
      comment: "Shipping service line the detention schedule applies to — links detention terms to specific trade services."
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency for detention charges."
    - name: "detention_schedule_status"
      expr: detention_schedule_status
      comment: "Lifecycle status of the detention schedule — filters active vs. expired schedules."
    - name: "waiver_eligible"
      expr: waiver_eligible
      comment: "Whether detention charges can be waived — identifies schedules with commercial flexibility."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the detention schedule became effective — tracks schedule change history."
  measures:
    - name: "avg_tier_1_detention_rate"
      expr: AVG(CAST(rate_tier_1_amount AS DOUBLE))
      comment: "Average Tier 1 (initial) detention daily rate. Benchmarks entry-level detention pricing — most frequently applied tier."
    - name: "avg_tier_2_detention_rate"
      expr: AVG(CAST(rate_tier_2_amount AS DOUBLE))
      comment: "Average Tier 2 (escalated) detention daily rate. Measures escalation step in detention pricing."
    - name: "avg_tier_3_detention_rate"
      expr: AVG(CAST(rate_tier_3_amount AS DOUBLE))
      comment: "Average Tier 3 (maximum escalation) detention daily rate. Represents the punitive ceiling for long-detention containers."
    - name: "avg_maximum_detention_cap"
      expr: AVG(CAST(maximum_detention_cap AS DOUBLE))
      comment: "Average maximum detention cap across schedules. Monitors revenue ceiling constraints on detention charges."
    - name: "detention_tier_escalation_ratio"
      expr: AVG(CAST(rate_tier_2_amount AS DOUBLE)) / NULLIF(AVG(CAST(rate_tier_1_amount AS DOUBLE)), 0)
      comment: "Ratio of Tier 2 to Tier 1 detention rate. Measures escalation steepness — steeper escalation incentivizes faster equipment return."
    - name: "active_detention_schedule_count"
      expr: COUNT(CASE WHEN detention_schedule_status = 'Active' THEN detention_schedule_id END)
      comment: "Number of active detention schedules. Measures coverage of the detention tariff portfolio."
    - name: "waiver_eligible_schedule_count"
      expr: COUNT(CASE WHEN waiver_eligible = TRUE THEN detention_schedule_id END)
      comment: "Number of detention schedules eligible for waiver. Quantifies commercial flexibility exposure — high waiver eligibility may indicate revenue leakage risk."
    - name: "holiday_charge_applicable_count"
      expr: COUNT(CASE WHEN holiday_charge_applicable = TRUE THEN detention_schedule_id END)
      comment: "Number of detention schedules charging on public holidays. Measures revenue maximization posture on non-working days."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_bunker_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bunker Adjustment Factor (BAF) analytics — fuel surcharge rates, index references, and vessel/cargo applicability. BAF is a volatile revenue line directly tied to bunker fuel prices and a key cost pass-through mechanism."
  source: "`vibe_shipping_ports_v1`.`tariff`.`bunker_adjustment`"
  dimensions:
    - name: "baf_type"
      expr: baf_type
      comment: "Type of BAF (e.g. Fixed, Index-Linked, Floating) — determines how the surcharge is calculated and updated."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate BAF (e.g. Per TEU, Per GRT, Percentage of Base Rate) — affects revenue calculation."
    - name: "vessel_size_category"
      expr: vessel_size_category
      comment: "Vessel size band the BAF applies to — links fuel surcharge to vessel class."
    - name: "trade_lane_scope"
      expr: trade_lane_scope
      comment: "Trade lane scope of the BAF — enables lane-level fuel surcharge analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the BAF rate — supports multi-currency analysis."
    - name: "bunker_adjustment_status"
      expr: bunker_adjustment_status
      comment: "Lifecycle status of the BAF (Active, Expired, Superseded) — filters current vs. historical adjustments."
    - name: "regulatory_filing_required_flag"
      expr: regulatory_filing_required_flag
      comment: "Whether the BAF requires regulatory filing — compliance monitoring flag."
    - name: "effective_from_date_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the BAF became effective — tracks fuel surcharge change history and volatility."
  measures:
    - name: "avg_baf_rate_amount"
      expr: AVG(CAST(baf_rate_amount AS DOUBLE))
      comment: "Average BAF rate across active adjustments. Core fuel surcharge KPI — benchmarks BAF levels against bunker price movements."
    - name: "max_baf_rate_amount"
      expr: MAX(CAST(baf_rate_amount AS DOUBLE))
      comment: "Maximum BAF rate in the portfolio. Identifies peak fuel surcharge exposure for customers."
    - name: "avg_fuel_index_value"
      expr: AVG(CAST(fuel_index_value AS DOUBLE))
      comment: "Average fuel index value referenced by BAF schedules. Tracks the underlying fuel price benchmark driving BAF calculations."
    - name: "avg_minimum_charge_amount"
      expr: AVG(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Average minimum BAF charge floor. Ensures revenue floor adequacy even at low fuel index values."
    - name: "avg_maximum_charge_amount"
      expr: AVG(CAST(maximum_charge_amount AS DOUBLE))
      comment: "Average maximum BAF charge cap. Monitors revenue ceiling constraints that limit upside during fuel price spikes."
    - name: "active_baf_count"
      expr: COUNT(CASE WHEN bunker_adjustment_status = 'Active' THEN bunker_adjustment_id END)
      comment: "Number of currently active BAF schedules. Measures BAF portfolio coverage across trade lanes and vessel classes."
    - name: "superseded_baf_count"
      expr: COUNT(CASE WHEN superseded_by_baf_bunker_adjustment_id IS NOT NULL THEN bunker_adjustment_id END)
      comment: "Number of BAF schedules that have been superseded. Tracks BAF revision frequency — high churn indicates volatile fuel market response."
    - name: "regulatory_filing_required_baf_count"
      expr: COUNT(CASE WHEN regulatory_filing_required_flag = TRUE THEN bunker_adjustment_id END)
      comment: "Number of BAF schedules requiring regulatory filing. Drives compliance workload and filing deadline management."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_currency_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Currency Adjustment Factor (CAF) analytics — FX surcharge rates, exchange rate references, and applicability. CAF manages FX risk pass-through to customers and is a key revenue protection mechanism in multi-currency port operations."
  source: "`vibe_shipping_ports_v1`.`tariff`.`currency_adjustment`"
  dimensions:
    - name: "base_currency_code"
      expr: base_currency_code
      comment: "Base currency of the tariff — the reference currency for CAF calculation."
    - name: "adjustment_currency_code"
      expr: adjustment_currency_code
      comment: "Adjustment currency — the currency against which FX movement is measured."
    - name: "trade_lane_scope"
      expr: trade_lane_scope
      comment: "Trade lane scope of the CAF — enables lane-level FX exposure analysis."
    - name: "currency_adjustment_status"
      expr: currency_adjustment_status
      comment: "Lifecycle status of the CAF (Active, Expired, Superseded) — filters current vs. historical adjustments."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the CAF — filters approved vs. pending adjustments."
    - name: "auto_apply_flag"
      expr: auto_apply_flag
      comment: "Whether the CAF is automatically applied — distinguishes automated vs. manual FX adjustments."
    - name: "regulatory_filing_required_flag"
      expr: regulatory_filing_required_flag
      comment: "Whether the CAF requires regulatory filing — compliance monitoring flag."
    - name: "effective_from_date_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the CAF became effective — tracks FX adjustment change history."
  measures:
    - name: "avg_caf_percentage"
      expr: AVG(CAST(caf_percentage AS DOUBLE))
      comment: "Average CAF percentage across active adjustments. Core FX surcharge KPI — benchmarks FX pass-through levels."
    - name: "avg_current_exchange_rate"
      expr: AVG(CAST(current_exchange_rate AS DOUBLE))
      comment: "Average current exchange rate referenced by CAF schedules. Tracks the FX rate driving CAF calculations."
    - name: "avg_reference_exchange_rate"
      expr: AVG(CAST(reference_exchange_rate AS DOUBLE))
      comment: "Average reference (base) exchange rate for CAF calculation. Compared against current rate to determine CAF direction and magnitude."
    - name: "avg_exchange_rate_deviation"
      expr: AVG(CAST(current_exchange_rate AS DOUBLE) - CAST(reference_exchange_rate AS DOUBLE))
      comment: "Average deviation between current and reference exchange rates. Measures the FX movement driving CAF adjustments — positive = currency depreciation requiring surcharge."
    - name: "avg_minimum_caf_amount"
      expr: AVG(CAST(minimum_caf_amount AS DOUBLE))
      comment: "Average minimum CAF charge floor. Ensures revenue floor adequacy even at small FX movements."
    - name: "avg_maximum_caf_amount"
      expr: AVG(CAST(maximum_caf_amount AS DOUBLE))
      comment: "Average maximum CAF charge cap. Monitors revenue ceiling constraints on FX surcharges."
    - name: "active_caf_count"
      expr: COUNT(CASE WHEN currency_adjustment_status = 'Active' THEN currency_adjustment_id END)
      comment: "Number of currently active CAF schedules. Measures FX adjustment portfolio coverage."
    - name: "auto_apply_caf_count"
      expr: COUNT(CASE WHEN auto_apply_flag = TRUE THEN currency_adjustment_id END)
      comment: "Number of CAF schedules set to auto-apply. Measures automation level in FX pass-through — reduces manual billing errors."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_surcharge_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Surcharge rule analytics — rate levels, calculation methods, and applicability coverage. Surcharges are a significant revenue line and a key area of tariff complexity requiring governance oversight."
  source: "`vibe_shipping_ports_v1`.`tariff`.`surcharge_rule`"
  dimensions:
    - name: "surcharge_type"
      expr: surcharge_type
      comment: "Type of surcharge (e.g. Peak Season, Congestion, Security, Environmental) — primary segmentation for surcharge analysis."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate the surcharge (e.g. Fixed Amount, Percentage, Per TEU) — affects revenue calculation."
    - name: "trade_lane_scope"
      expr: trade_lane_scope
      comment: "Trade lane scope of the surcharge — enables lane-level surcharge analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the surcharge — supports multi-currency analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the surcharge rule — filters approved vs. pending rules."
    - name: "compounding_allowed"
      expr: compounding_allowed
      comment: "Whether the surcharge can compound with other surcharges — identifies complex multi-surcharge scenarios."
    - name: "effective_from_date_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the surcharge rule became effective — tracks surcharge introduction cadence."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing cycle for the surcharge — supports cash flow analysis."
  measures:
    - name: "avg_surcharge_rate_amount"
      expr: AVG(CAST(rate_amount AS DOUBLE))
      comment: "Average fixed surcharge rate amount. Benchmarks surcharge levels across types and trade lanes."
    - name: "avg_surcharge_rate_percentage"
      expr: AVG(CAST(rate_percentage AS DOUBLE))
      comment: "Average percentage-based surcharge rate. Measures the percentage uplift applied to base charges."
    - name: "avg_minimum_charge"
      expr: AVG(CAST(minimum_charge AS DOUBLE))
      comment: "Average minimum surcharge floor. Ensures revenue floor adequacy on surcharge application."
    - name: "avg_maximum_charge"
      expr: AVG(CAST(maximum_charge AS DOUBLE))
      comment: "Average maximum surcharge cap. Monitors revenue ceiling constraints on surcharge application."
    - name: "active_surcharge_rule_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN surcharge_rule_id END)
      comment: "Number of approved active surcharge rules. Measures surcharge portfolio breadth and complexity."
    - name: "compounding_surcharge_count"
      expr: COUNT(CASE WHEN compounding_allowed = TRUE THEN surcharge_rule_id END)
      comment: "Number of surcharge rules that allow compounding. High compounding exposure increases billing complexity and customer dispute risk."
    - name: "superseded_surcharge_count"
      expr: COUNT(CASE WHEN superseded_by_rule_surcharge_rule_id IS NOT NULL THEN surcharge_rule_id END)
      comment: "Number of surcharge rules that have been superseded. Tracks surcharge revision frequency and tariff governance activity."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_discount_scheme`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discount scheme analytics — discount depth, threshold structures, and eligibility coverage. Discount management is a key commercial lever and a primary driver of margin erosion requiring executive oversight."
  source: "`vibe_shipping_ports_v1`.`tariff`.`discount_scheme`"
  dimensions:
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount (e.g. Volume, Loyalty, Promotional, SLA-Linked) — primary segmentation for discount analysis."
    - name: "discount_category"
      expr: discount_category
      comment: "Category of discount (e.g. Commercial, Regulatory, Operational) — enables category-level discount governance."
    - name: "customer_tier_eligibility"
      expr: customer_tier_eligibility
      comment: "Customer tier eligible for the discount — segments discount exposure by customer value tier."
    - name: "scheme_status"
      expr: scheme_status
      comment: "Lifecycle status of the discount scheme (Active, Expired, Draft) — filters operational schemes."
    - name: "auto_apply_flag"
      expr: auto_apply_flag
      comment: "Whether the discount is automatically applied — distinguishes automated vs. manual discount application."
    - name: "combinable_with_other_discounts"
      expr: combinable_with_other_discounts
      comment: "Whether the discount can be combined with others — identifies stacking risk."
    - name: "sla_linked_flag"
      expr: sla_linked_flag
      comment: "Whether the discount is linked to SLA performance — identifies performance-contingent discounts."
    - name: "effective_from_date_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the discount scheme became effective — tracks discount introduction cadence."
  measures:
    - name: "avg_discount_value"
      expr: AVG(CAST(discount_value AS DOUBLE))
      comment: "Average discount value (amount or percentage) across schemes. Core margin erosion KPI — measures average commercial concession depth."
    - name: "max_discount_value"
      expr: MAX(CAST(discount_value AS DOUBLE))
      comment: "Maximum discount value in the portfolio. Identifies the most aggressive commercial concession — triggers pricing policy review."
    - name: "avg_maximum_discount_cap"
      expr: AVG(CAST(maximum_discount_cap AS DOUBLE))
      comment: "Average maximum discount cap across schemes. Monitors the ceiling on commercial concessions."
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average volume/revenue threshold required to trigger the discount. Measures the commercial commitment required to earn discounts."
    - name: "avg_minimum_charge_threshold"
      expr: AVG(CAST(minimum_charge_threshold AS DOUBLE))
      comment: "Average minimum charge threshold below which discounts do not apply. Ensures revenue floor protection on discounted charges."
    - name: "active_discount_scheme_count"
      expr: COUNT(CASE WHEN scheme_status = 'Active' THEN discount_scheme_id END)
      comment: "Number of active discount schemes. Measures the breadth of commercial discount exposure."
    - name: "combinable_discount_scheme_count"
      expr: COUNT(CASE WHEN combinable_with_other_discounts = TRUE THEN discount_scheme_id END)
      comment: "Number of discount schemes that can be combined. High combinability increases margin erosion risk from discount stacking."
    - name: "sla_linked_discount_count"
      expr: COUNT(CASE WHEN sla_linked_flag = TRUE THEN discount_scheme_id END)
      comment: "Number of discounts linked to SLA performance. Measures the portion of discounts contingent on service delivery — aligns commercial and operational incentives."
    - name: "auto_apply_discount_count"
      expr: COUNT(CASE WHEN auto_apply_flag = TRUE THEN discount_scheme_id END)
      comment: "Number of discount schemes set to auto-apply. High auto-apply count increases revenue leakage risk if eligibility rules are misconfigured."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tariff exception analytics — exception volumes, waiver amounts, discount depths, and revenue commitment deviations. Exceptions represent off-tariff commercial decisions and are a primary source of revenue leakage requiring governance oversight."
  source: "`vibe_shipping_ports_v1`.`tariff`.`exception`"
  dimensions:
    - name: "exception_type"
      expr: exception_type
      comment: "Type of tariff exception (e.g. Rate Override, Free Days Grant, Waiver, Discount) — primary segmentation for exception analysis."
    - name: "exception_status"
      expr: exception_status
      comment: "Lifecycle status of the exception (Active, Expired, Revoked) — filters current vs. historical exceptions."
    - name: "cargo_type"
      expr: cargo_type
      comment: "Cargo type the exception applies to — enables cargo-specific exception analysis."
    - name: "service_type"
      expr: service_type
      comment: "Service type the exception applies to — enables service-level exception analysis."
    - name: "trade_lane"
      expr: trade_lane
      comment: "Trade lane scope of the exception — enables lane-level exception governance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the exception — supports multi-currency analysis."
    - name: "approval_authority"
      expr: approval_authority
      comment: "Authority level that approved the exception — tracks delegation of authority compliance."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the exception became effective — tracks exception issuance cadence and seasonality."
  measures:
    - name: "total_waiver_amount"
      expr: SUM(CAST(waiver_amount AS DOUBLE))
      comment: "Total revenue waived through tariff exceptions. Primary revenue leakage KPI — directly measures off-tariff commercial concessions."
    - name: "avg_waiver_amount"
      expr: AVG(CAST(waiver_amount AS DOUBLE))
      comment: "Average waiver amount per exception. Benchmarks exception size and identifies outlier concessions."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage granted through exceptions. Measures margin erosion depth from off-tariff concessions."
    - name: "total_revenue_commitment_amount"
      expr: SUM(CAST(revenue_commitment_amount AS DOUBLE))
      comment: "Total revenue commitment secured in exchange for exceptions. Measures the commercial quid pro quo for concessions granted."
    - name: "total_volume_commitment_teu"
      expr: SUM(CAST(volume_commitment_teu AS DOUBLE))
      comment: "Total TEU volume committed in exchange for exceptions. Measures throughput secured through commercial concessions."
    - name: "avg_rate_amount"
      expr: AVG(CAST(rate_amount AS DOUBLE))
      comment: "Average exception rate amount. Benchmarks off-tariff rate levels against standard tariff rates."
    - name: "avg_standard_rate_amount"
      expr: AVG(CAST(standard_rate_amount AS DOUBLE))
      comment: "Average standard tariff rate for exceptions. Provides the baseline for measuring exception discount depth."
    - name: "exception_rate_vs_standard_ratio"
      expr: AVG(CAST(rate_amount AS DOUBLE)) / NULLIF(AVG(CAST(standard_rate_amount AS DOUBLE)), 0)
      comment: "Ratio of exception rate to standard rate. Values below 1.0 indicate below-tariff pricing — key revenue leakage indicator."
    - name: "active_exception_count"
      expr: COUNT(CASE WHEN exception_status = 'Active' THEN exception_id END)
      comment: "Number of currently active tariff exceptions. Measures the volume of off-tariff commercial arrangements requiring governance oversight."
    - name: "revoked_exception_count"
      expr: COUNT(CASE WHEN revocation_date IS NOT NULL THEN exception_id END)
      comment: "Number of exceptions that have been revoked. Tracks exception governance enforcement activity."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_negotiation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tariff negotiation analytics — proposed vs. final rates, discount depth, volume commitments, and negotiation outcomes. Enables commercial teams to track negotiation performance, win rates, and revenue impact of concluded deals."
  source: "`vibe_shipping_ports_v1`.`tariff`.`negotiation`"
  dimensions:
    - name: "negotiation_type"
      expr: negotiation_type
      comment: "Type of negotiation (e.g. New Rate, Renewal, Amendment, Dispute) — primary segmentation for negotiation analysis."
    - name: "negotiation_status"
      expr: negotiation_status
      comment: "Current status of the negotiation (e.g. In Progress, Concluded, Rejected, Withdrawn) — tracks pipeline and outcomes."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment involved in the negotiation — enables segment-level commercial performance analysis."
    - name: "trade_lane"
      expr: trade_lane
      comment: "Trade lane scope of the negotiation — enables lane-level commercial analysis."
    - name: "service_type"
      expr: service_type
      comment: "Service type being negotiated — segments negotiations by service category."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier associated with the negotiation — links commercial terms to service level commitments."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the negotiation — supports multi-currency analysis."
    - name: "initiated_date_month"
      expr: DATE_TRUNC('month', initiated_date)
      comment: "Month the negotiation was initiated — tracks negotiation pipeline cadence."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Whether the negotiation requires formal approval — identifies high-value or sensitive deals."
  measures:
    - name: "avg_proposed_rate_amount"
      expr: AVG(CAST(proposed_rate_amount AS DOUBLE))
      comment: "Average initially proposed rate in negotiations. Establishes the opening position benchmark for commercial analysis."
    - name: "avg_final_agreed_rate_amount"
      expr: AVG(CAST(final_agreed_rate_amount AS DOUBLE))
      comment: "Average final agreed rate in concluded negotiations. Core commercial outcome KPI — measures achieved rate levels."
    - name: "avg_counter_offer_rate_amount"
      expr: AVG(CAST(counter_offer_rate_amount AS DOUBLE))
      comment: "Average counter-offer rate in negotiations. Measures customer pushback level and negotiation dynamics."
    - name: "avg_rate_concession_amount"
      expr: AVG(CAST(proposed_rate_amount AS DOUBLE) - CAST(final_agreed_rate_amount AS DOUBLE))
      comment: "Average rate concession from proposed to final agreed rate. Measures negotiation give-away — key commercial discipline KPI."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage granted in negotiations. Measures margin erosion from commercial concessions."
    - name: "avg_premium_percentage"
      expr: AVG(CAST(premium_percentage AS DOUBLE))
      comment: "Average premium percentage achieved in negotiations. Measures ability to capture premium pricing for high-value customers."
    - name: "total_volume_commitment_teu"
      expr: SUM(CAST(volume_commitment_teu AS DOUBLE))
      comment: "Total TEU volume committed in concluded negotiations. Measures contracted throughput pipeline secured through negotiations."
    - name: "total_revenue_commitment_amount"
      expr: SUM(CAST(revenue_commitment_amount AS DOUBLE))
      comment: "Total revenue commitment secured in negotiations. Measures contracted revenue backlog from negotiated agreements."
    - name: "avg_competitor_benchmark_rate"
      expr: AVG(CAST(competitor_benchmark_rate AS DOUBLE))
      comment: "Average competitor benchmark rate referenced in negotiations. Tracks market rate intelligence and competitive positioning."
    - name: "concluded_negotiation_count"
      expr: COUNT(CASE WHEN negotiation_status = 'Concluded' THEN negotiation_id END)
      comment: "Number of successfully concluded negotiations. Measures commercial team deal closure rate."
    - name: "active_negotiation_count"
      expr: COUNT(CASE WHEN negotiation_status = 'In Progress' THEN negotiation_id END)
      comment: "Number of negotiations currently in progress. Measures commercial pipeline activity and workload."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory tariff filing analytics — filing status, approval timelines, revenue impact, and compliance posture. Tariff filings are a regulatory obligation and a key compliance risk area for port operators."
  source: "`vibe_shipping_ports_v1`.`tariff`.`tariff_filing`"
  dimensions:
    - name: "filing_type"
      expr: filing_type
      comment: "Type of tariff filing (e.g. New Tariff, Amendment, Withdrawal, Emergency) — primary segmentation for filing analysis."
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the filing (e.g. Submitted, Approved, Rejected, Withdrawn) — tracks regulatory pipeline."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the filing — filters approved vs. pending vs. rejected filings."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority the filing is submitted to — enables authority-level compliance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the filing — supports multi-currency revenue impact analysis."
    - name: "public_consultation_required_flag"
      expr: public_consultation_required_flag
      comment: "Whether the filing requires public consultation — identifies high-complexity filings with longer lead times."
    - name: "submission_date_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month the filing was submitted — tracks filing cadence and regulatory workload."
    - name: "impact_assessment_completed_flag"
      expr: impact_assessment_completed_flag
      comment: "Whether impact assessment was completed — compliance quality indicator."
  measures:
    - name: "total_estimated_revenue_impact"
      expr: SUM(CAST(estimated_revenue_impact_amount AS DOUBLE))
      comment: "Total estimated revenue impact of all tariff filings. Measures the financial significance of the regulatory filing pipeline."
    - name: "avg_estimated_revenue_impact"
      expr: AVG(CAST(estimated_revenue_impact_amount AS DOUBLE))
      comment: "Average estimated revenue impact per tariff filing. Benchmarks the materiality of individual filings."
    - name: "approved_filing_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN tariff_filing_id END)
      comment: "Number of approved tariff filings. Measures regulatory approval success rate and compliance effectiveness."
    - name: "rejected_filing_count"
      expr: COUNT(CASE WHEN filing_status = 'Rejected' THEN tariff_filing_id END)
      comment: "Number of rejected tariff filings. High rejection rate indicates regulatory compliance gaps requiring process improvement."
    - name: "pending_filing_count"
      expr: COUNT(CASE WHEN filing_status = 'Submitted' THEN tariff_filing_id END)
      comment: "Number of tariff filings pending regulatory decision. Measures regulatory pipeline backlog and approval risk."
    - name: "public_consultation_filing_count"
      expr: COUNT(CASE WHEN public_consultation_required_flag = TRUE THEN tariff_filing_id END)
      comment: "Number of filings requiring public consultation. Identifies high-complexity filings with extended approval timelines."
    - name: "impact_assessment_completion_rate"
      expr: COUNT(CASE WHEN impact_assessment_completed_flag = TRUE THEN tariff_filing_id END) / NULLIF(COUNT(tariff_filing_id), 0)
      comment: "Proportion of filings with completed impact assessments. Measures regulatory compliance quality — incomplete assessments increase rejection risk."
    - name: "legal_review_completion_rate"
      expr: COUNT(CASE WHEN legal_review_completed_flag = TRUE THEN tariff_filing_id END) / NULLIF(COUNT(tariff_filing_id), 0)
      comment: "Proportion of filings with completed legal reviews. Measures legal due diligence compliance — incomplete reviews increase regulatory risk."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tariff version lifecycle analytics — version change cadence, revenue impact, regulatory filing compliance, and retroactive billing exposure. Tracks tariff governance health and change management effectiveness."
  source: "`vibe_shipping_ports_v1`.`tariff`.`tariff_version`"
  dimensions:
    - name: "version_status"
      expr: version_status
      comment: "Lifecycle status of the tariff version (Draft, Active, Superseded, Withdrawn) — primary filter for version analysis."
    - name: "version_type"
      expr: version_type
      comment: "Type of version change (e.g. Major, Minor, Emergency, Regulatory) — segments change significance."
    - name: "change_category"
      expr: change_category
      comment: "Category of change (e.g. Rate Change, New Service, Regulatory Compliance) — enables change-type analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the tariff version — supports multi-currency analysis."
    - name: "regulatory_filing_required"
      expr: regulatory_filing_required
      comment: "Whether the version requires regulatory filing — compliance monitoring flag."
    - name: "retroactive_billing_allowed"
      expr: retroactive_billing_allowed
      comment: "Whether retroactive billing is allowed for this version — identifies revenue recovery or risk exposure."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the tariff version became effective — tracks version introduction cadence."
    - name: "public_consultation_required"
      expr: public_consultation_required
      comment: "Whether public consultation was required — identifies high-complexity version changes."
  measures:
    - name: "total_estimated_revenue_impact"
      expr: SUM(CAST(estimated_revenue_impact_amount AS DOUBLE))
      comment: "Total estimated revenue impact across all tariff versions. Measures the cumulative financial significance of tariff changes."
    - name: "avg_estimated_revenue_impact"
      expr: AVG(CAST(estimated_revenue_impact_amount AS DOUBLE))
      comment: "Average estimated revenue impact per tariff version. Benchmarks the materiality of individual version changes."
    - name: "active_version_count"
      expr: COUNT(CASE WHEN version_status = 'Active' THEN tariff_version_id END)
      comment: "Number of currently active tariff versions. Measures the live tariff portfolio size."
    - name: "regulatory_filing_required_count"
      expr: COUNT(CASE WHEN regulatory_filing_required = TRUE THEN tariff_version_id END)
      comment: "Number of tariff versions requiring regulatory filing. Drives compliance workload planning."
    - name: "retroactive_billing_version_count"
      expr: COUNT(CASE WHEN retroactive_billing_allowed = TRUE THEN tariff_version_id END)
      comment: "Number of versions allowing retroactive billing. Measures retroactive revenue recovery opportunity and customer dispute risk."
    - name: "superseded_version_count"
      expr: COUNT(CASE WHEN primary_superseded_by_version_id IS NOT NULL THEN tariff_version_id END)
      comment: "Number of tariff versions that have been superseded. Tracks tariff churn rate and version management health."
    - name: "impact_assessment_completion_rate"
      expr: COUNT(CASE WHEN impact_assessment_completed = TRUE THEN tariff_version_id END) / NULLIF(COUNT(tariff_version_id), 0)
      comment: "Proportion of tariff versions with completed impact assessments. Measures change governance quality."
    - name: "legal_review_completion_rate"
      expr: COUNT(CASE WHEN legal_review_completed = TRUE THEN tariff_version_id END) / NULLIF(COUNT(tariff_version_id), 0)
      comment: "Proportion of tariff versions with completed legal reviews. Measures legal due diligence compliance in tariff change management."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_port_dues_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Port dues schedule analytics — base rates, environmental and security levies, call frequency discounts, and vessel size band coverage. Port dues are a primary revenue line from vessel calls and a key competitive factor for shipping lines."
  source: "`vibe_shipping_ports_v1`.`tariff`.`port_dues_schedule`"
  dimensions:
    - name: "dues_type"
      expr: dues_type
      comment: "Type of port dues (e.g. Port Dues, Light Dues, Conservancy Dues, Anchorage Dues) — primary segmentation for dues analysis."
    - name: "trade_type"
      expr: trade_type
      comment: "Trade type (Import, Export, Transhipment, Coastal) — enables trade-direction dues analysis."
    - name: "vessel_type"
      expr: vessel_type
      comment: "Vessel type the dues schedule applies to — enables vessel-class dues analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the dues schedule — supports multi-currency analysis."
    - name: "port_dues_schedule_status"
      expr: port_dues_schedule_status
      comment: "Lifecycle status of the dues schedule (Active, Expired, Draft) — filters operational schedules."
    - name: "exemption_flag"
      expr: exemption_flag
      comment: "Whether the schedule includes exemption provisions — identifies schedules with revenue leakage risk."
    - name: "effective_from_date_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the dues schedule became effective — tracks dues change history."
  measures:
    - name: "avg_base_rate_amount"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base port dues rate. Core pricing KPI — benchmarks port dues competitiveness by vessel type and trade."
    - name: "avg_environmental_levy_percentage"
      expr: AVG(CAST(environmental_levy_percentage AS DOUBLE))
      comment: "Average environmental levy percentage on port dues. Tracks green shipping incentive/penalty structure and sustainability revenue."
    - name: "avg_security_levy_percentage"
      expr: AVG(CAST(security_levy_percentage AS DOUBLE))
      comment: "Average ISPS security levy percentage on port dues. Measures security cost recovery through dues structure."
    - name: "avg_dangerous_goods_surcharge_pct"
      expr: AVG(CAST(dangerous_goods_surcharge_percentage AS DOUBLE))
      comment: "Average dangerous goods surcharge percentage on port dues. Measures DG risk premium embedded in dues structure."
    - name: "avg_call_frequency_discount_pct"
      expr: AVG(CAST(call_frequency_discount_percentage AS DOUBLE))
      comment: "Average call frequency discount percentage. Measures loyalty incentive depth for high-frequency callers — key shipping line retention tool."
    - name: "avg_late_payment_penalty_pct"
      expr: AVG(CAST(late_payment_penalty_percentage AS DOUBLE))
      comment: "Average late payment penalty percentage. Measures financial penalty for overdue dues — supports cash flow management."
    - name: "avg_minimum_charge_amount"
      expr: AVG(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Average minimum port dues charge floor. Ensures revenue floor adequacy per vessel call."
    - name: "avg_maximum_charge_amount"
      expr: AVG(CAST(maximum_charge_amount AS DOUBLE))
      comment: "Average maximum port dues charge cap. Monitors revenue ceiling constraints on large vessel calls."
    - name: "active_dues_schedule_count"
      expr: COUNT(CASE WHEN port_dues_schedule_status = 'Active' THEN port_dues_schedule_id END)
      comment: "Number of active port dues schedules. Measures dues portfolio coverage across vessel types and trade categories."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_storage_tariff`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage tariff analytics — tiered daily rates, free storage days, and maximum charge caps by container type and cargo category. Storage revenue is a significant P&L line and a key driver of yard utilization incentives."
  source: "`vibe_shipping_ports_v1`.`tariff`.`storage_tariff`"
  dimensions:
    - name: "cargo_type"
      expr: cargo_type
      comment: "Cargo type the storage tariff applies to (Dry, Reefer, DG, OOG) — primary segmentation for storage analysis."
    - name: "container_status"
      expr: container_status
      comment: "Container status (Full, Empty, Reefer) — enables status-specific storage rate analysis."
    - name: "customer_tier"
      expr: customer_tier
      comment: "Customer tier the storage tariff applies to — segments standard vs. preferential storage terms."
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG class for DG storage tariffs — enables hazmat-specific storage rate analysis."
    - name: "tariff_status"
      expr: tariff_status
      comment: "Lifecycle status of the storage tariff (Active, Expired, Draft) — filters operational tariffs."
    - name: "demurrage_linkage_flag"
      expr: demurrage_linkage_flag
      comment: "Whether storage converts to demurrage after free days — identifies tariffs with demurrage escalation."
    - name: "tax_applicable_flag"
      expr: tax_applicable_flag
      comment: "Whether tax applies to storage charges — supports tax liability analysis."
    - name: "effective_from_date_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the storage tariff became effective — tracks storage rate change history."
  measures:
    - name: "avg_rate_band_1_daily_rate"
      expr: AVG(CAST(rate_band_1_daily_rate AS DOUBLE))
      comment: "Average Band 1 (initial free-period-end) daily storage rate. Benchmarks entry-level storage pricing — most frequently applied band."
    - name: "avg_rate_band_2_daily_rate"
      expr: AVG(CAST(rate_band_2_daily_rate AS DOUBLE))
      comment: "Average Band 2 (escalated) daily storage rate. Measures escalation step — higher bands incentivize faster container pickup."
    - name: "avg_rate_band_3_daily_rate"
      expr: AVG(CAST(rate_band_3_daily_rate AS DOUBLE))
      comment: "Average Band 3 (maximum escalation) daily storage rate. Represents the punitive ceiling for long-dwell containers."
    - name: "storage_rate_escalation_ratio"
      expr: AVG(CAST(rate_band_2_daily_rate AS DOUBLE)) / NULLIF(AVG(CAST(rate_band_1_daily_rate AS DOUBLE)), 0)
      comment: "Ratio of Band 2 to Band 1 daily storage rate. Measures escalation steepness — steeper escalation drives faster yard clearance."
    - name: "avg_minimum_charge_amount"
      expr: AVG(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Average minimum storage charge floor. Ensures revenue floor adequacy per container storage event."
    - name: "avg_maximum_charge_amount"
      expr: AVG(CAST(maximum_charge_amount AS DOUBLE))
      comment: "Average maximum storage charge cap. Monitors revenue ceiling constraints on long-dwell containers."
    - name: "active_storage_tariff_count"
      expr: COUNT(CASE WHEN tariff_status = 'Active' THEN storage_tariff_id END)
      comment: "Number of active storage tariffs. Measures storage tariff portfolio coverage."
    - name: "demurrage_linked_tariff_count"
      expr: COUNT(CASE WHEN demurrage_linkage_flag = TRUE THEN storage_tariff_id END)
      comment: "Number of storage tariffs linked to demurrage escalation. Measures the portion of storage revenue that escalates to demurrage — key revenue maximization indicator."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_wharfage_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wharfage schedule analytics — per-unit rates, volume/weight break structures, surcharges, and discount levels. Wharfage is a tonnage-based revenue line and a key component of port dues for break-bulk and bulk cargo."
  source: "`vibe_shipping_ports_v1`.`tariff`.`wharfage_schedule`"
  dimensions:
    - name: "trade_direction"
      expr: trade_direction
      comment: "Import or Export direction — wharfage rates often differ by direction."
    - name: "vessel_type"
      expr: vessel_type
      comment: "Vessel type the wharfage schedule applies to — enables vessel-class wharfage analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for wharfage (e.g. Per Tonne, Per CBM, Per TEU) — primary segmentation for rate comparison."
    - name: "tariff_status"
      expr: tariff_status
      comment: "Lifecycle status of the wharfage schedule (Active, Expired, Draft) — filters operational schedules."
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Whether the schedule applies to dangerous goods — enables DG-specific wharfage analysis."
    - name: "refrigerated_cargo_flag"
      expr: refrigerated_cargo_flag
      comment: "Whether the schedule applies to refrigerated cargo — enables reefer-specific wharfage analysis."
    - name: "baf_applicable_flag"
      expr: baf_applicable_flag
      comment: "Whether BAF applies to wharfage — identifies fuel-cost-exposed wharfage revenue."
    - name: "effective_from_date_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the wharfage schedule became effective — tracks rate change history."
  measures:
    - name: "avg_rate_per_unit"
      expr: AVG(CAST(rate_per_unit AS DOUBLE))
      comment: "Average wharfage rate per unit. Core pricing KPI — benchmarks wharfage competitiveness by cargo type and trade direction."
    - name: "max_rate_per_unit"
      expr: MAX(CAST(rate_per_unit AS DOUBLE))
      comment: "Maximum wharfage rate per unit. Identifies premium wharfage ceiling and potential outliers."
    - name: "avg_surcharge_percentage"
      expr: AVG(CAST(surcharge_percentage AS DOUBLE))
      comment: "Average surcharge percentage on wharfage. Measures surcharge uplift on base wharfage rates."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage on wharfage. Measures margin erosion from wharfage concessions."
    - name: "avg_minimum_charge"
      expr: AVG(CAST(minimum_charge AS DOUBLE))
      comment: "Average minimum wharfage charge floor. Ensures revenue floor adequacy per cargo movement."
    - name: "avg_volume_break_lower_limit"
      expr: AVG(CAST(volume_break_lower_limit AS DOUBLE))
      comment: "Average lower volume break threshold. Informs volume incentive structure design for wharfage."
    - name: "avg_volume_break_upper_limit"
      expr: AVG(CAST(volume_break_upper_limit AS DOUBLE))
      comment: "Average upper volume break threshold. Informs volume incentive ceiling for wharfage rate bands."
    - name: "avg_weight_break_lower_limit"
      expr: AVG(CAST(weight_break_lower_limit AS DOUBLE))
      comment: "Average lower weight break threshold. Informs weight-based pricing structure for wharfage."
    - name: "active_wharfage_schedule_count"
      expr: COUNT(CASE WHEN tariff_status = 'Active' THEN wharfage_schedule_id END)
      comment: "Number of active wharfage schedules. Measures wharfage tariff portfolio coverage."
    - name: "dg_wharfage_schedule_count"
      expr: COUNT(CASE WHEN dangerous_goods_flag = TRUE THEN wharfage_schedule_id END)
      comment: "Number of wharfage schedules covering dangerous goods. Measures DG cargo wharfage coverage — DG handling requires premium rates."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_pilotage_tariff`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pilotage tariff analytics — base fees, waiting time surcharges, DG premiums, and vessel size band coverage. Pilotage is a mandatory marine service and a regulated revenue line requiring careful rate governance."
  source: "`vibe_shipping_ports_v1`.`tariff`.`pilotage_tariff`"
  dimensions:
    - name: "pilotage_type"
      expr: pilotage_type
      comment: "Type of pilotage service (e.g. Inbound, Outbound, Shifting, Compulsory) — primary segmentation for pilotage analysis."
    - name: "service_category"
      expr: service_category
      comment: "Service category of the pilotage (e.g. Standard, Emergency, Night) — enables service-level rate analysis."
    - name: "time_of_day_category"
      expr: time_of_day_category
      comment: "Time of day category (Day, Night, Weekend, Holiday) — pilotage rates often vary by time — enables time-of-day premium analysis."
    - name: "pilotage_tariff_status"
      expr: pilotage_tariff_status
      comment: "Lifecycle status of the pilotage tariff (Active, Expired, Draft) — filters operational tariffs."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the pilotage tariff — supports multi-currency analysis."
    - name: "distance_based_flag"
      expr: distance_based_flag
      comment: "Whether the tariff is distance-based — distinguishes fixed vs. variable pilotage pricing."
    - name: "tax_applicable_flag"
      expr: tax_applicable_flag
      comment: "Whether tax applies to pilotage charges — supports tax liability analysis."
    - name: "effective_from_date_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the pilotage tariff became effective — tracks rate change history."
  measures:
    - name: "avg_base_pilotage_fee"
      expr: AVG(CAST(base_pilotage_fee AS DOUBLE))
      comment: "Average base pilotage fee. Core pricing KPI — benchmarks pilotage rate competitiveness and regulatory adequacy."
    - name: "avg_waiting_time_surcharge_per_hour"
      expr: AVG(CAST(waiting_time_surcharge_per_hour AS DOUBLE))
      comment: "Average waiting time surcharge per hour. Measures revenue recovery for pilot waiting time — key operational cost recovery metric."
    - name: "avg_dangerous_goods_surcharge"
      expr: AVG(CAST(dangerous_goods_surcharge AS DOUBLE))
      comment: "Average DG surcharge on pilotage. Measures risk premium for piloting vessels carrying dangerous goods."
    - name: "avg_extraordinary_conditions_surcharge"
      expr: AVG(CAST(extraordinary_conditions_surcharge AS DOUBLE))
      comment: "Average extraordinary conditions surcharge (e.g. adverse weather, emergency). Measures revenue recovery for non-standard pilotage conditions."
    - name: "avg_minimum_charge"
      expr: AVG(CAST(minimum_charge AS DOUBLE))
      comment: "Average minimum pilotage charge floor. Ensures revenue floor adequacy per pilotage assignment."
    - name: "avg_maximum_charge"
      expr: AVG(CAST(maximum_charge AS DOUBLE))
      comment: "Average maximum pilotage charge cap. Monitors revenue ceiling constraints on large vessel pilotage."
    - name: "avg_rate_per_nautical_mile"
      expr: AVG(CAST(rate_per_nautical_mile AS DOUBLE))
      comment: "Average distance-based pilotage rate per nautical mile. Benchmarks distance-based pilotage pricing for longer approach channels."
    - name: "active_pilotage_tariff_count"
      expr: COUNT(CASE WHEN pilotage_tariff_status = 'Active' THEN pilotage_tariff_id END)
      comment: "Number of active pilotage tariffs. Measures pilotage tariff portfolio coverage across vessel types and service categories."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_mooring_tariff`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mooring tariff analytics — base fees, waiting time surcharges, gang counts, and vessel size band coverage. Mooring is a mandatory marine service and a key revenue line from vessel calls."
  source: "`vibe_shipping_ports_v1`.`tariff`.`mooring_tariff`"
  dimensions:
    - name: "mooring_type"
      expr: mooring_type
      comment: "Type of mooring service (e.g. Conventional, Single Buoy, Alongside) — primary segmentation for mooring analysis."
    - name: "service_type"
      expr: service_type
      comment: "Service type of the mooring (e.g. Arrival, Departure, Shifting) — enables service-level rate analysis."
    - name: "time_of_day_category"
      expr: time_of_day_category
      comment: "Time of day category (Day, Night, Weekend, Holiday) — mooring rates often vary by time."
    - name: "tariff_status"
      expr: tariff_status
      comment: "Lifecycle status of the mooring tariff (Active, Expired, Draft) — filters operational tariffs."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the mooring tariff — supports multi-currency analysis."
    - name: "customer_tier"
      expr: customer_tier
      comment: "Customer tier the mooring tariff applies to — segments standard vs. preferential mooring terms."
    - name: "sla_linked_flag"
      expr: sla_linked_flag
      comment: "Whether the mooring tariff is linked to SLA performance — identifies performance-contingent mooring rates."
    - name: "effective_from_date_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the mooring tariff became effective — tracks rate change history."
  measures:
    - name: "avg_base_mooring_fee"
      expr: AVG(CAST(base_mooring_fee AS DOUBLE))
      comment: "Average base mooring fee. Core pricing KPI — benchmarks mooring rate competitiveness by vessel size and service type."
    - name: "avg_waiting_time_surcharge_per_hour"
      expr: AVG(CAST(waiting_time_surcharge_per_hour AS DOUBLE))
      comment: "Average waiting time surcharge per hour. Measures revenue recovery for mooring gang waiting time — key operational cost recovery metric."
    - name: "avg_cancellation_fee"
      expr: AVG(CAST(cancellation_fee AS DOUBLE))
      comment: "Average cancellation fee for mooring services. Measures revenue protection against last-minute cancellations."
    - name: "avg_minimum_charge_amount"
      expr: AVG(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Average minimum mooring charge floor. Ensures revenue floor adequacy per mooring operation."
    - name: "avg_maximum_charge_cap"
      expr: AVG(CAST(maximum_charge_cap AS DOUBLE))
      comment: "Average maximum mooring charge cap. Monitors revenue ceiling constraints on large vessel mooring."
    - name: "active_mooring_tariff_count"
      expr: COUNT(CASE WHEN tariff_status = 'Active' THEN mooring_tariff_id END)
      comment: "Number of active mooring tariffs. Measures mooring tariff portfolio coverage."
    - name: "sla_linked_mooring_tariff_count"
      expr: COUNT(CASE WHEN sla_linked_flag = TRUE THEN mooring_tariff_id END)
      comment: "Number of mooring tariffs linked to SLA performance. Measures the portion of mooring revenue contingent on service delivery."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_towage_tariff`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Towage tariff analytics — base fees, standby rates, extraordinary surcharges, and tug requirements by vessel size. Towage is a mandatory marine service for large vessels and a significant revenue line for port operators."
  source: "`vibe_shipping_ports_v1`.`tariff`.`towage_tariff`"
  dimensions:
    - name: "operation_type"
      expr: operation_type
      comment: "Type of towage operation (e.g. Arrival, Departure, Shifting, Emergency) — primary segmentation for towage analysis."
    - name: "vessel_type_category"
      expr: vessel_type_category
      comment: "Vessel type category the towage tariff applies to — enables vessel-class towage analysis."
    - name: "time_of_day_category"
      expr: time_of_day_category
      comment: "Time of day category (Day, Night, Weekend, Holiday) — towage rates often vary by time."
    - name: "tariff_status"
      expr: tariff_status
      comment: "Lifecycle status of the towage tariff (Active, Expired, Draft) — filters operational tariffs."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the towage tariff — supports multi-currency analysis."
    - name: "sla_linked_flag"
      expr: sla_linked_flag
      comment: "Whether the towage tariff is linked to SLA performance — identifies performance-contingent towage rates."
    - name: "effective_from_date_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the towage tariff became effective — tracks rate change history."
  measures:
    - name: "avg_base_towage_fee_amount"
      expr: AVG(CAST(base_towage_fee_amount AS DOUBLE))
      comment: "Average base towage fee. Core pricing KPI — benchmarks towage rate competitiveness by vessel size and operation type."
    - name: "avg_standby_time_rate_per_hour"
      expr: AVG(CAST(standby_time_rate_per_hour AS DOUBLE))
      comment: "Average standby time rate per hour. Measures revenue recovery for tug standby time — key operational cost recovery metric."
    - name: "avg_extraordinary_conditions_surcharge_pct"
      expr: AVG(CAST(extraordinary_conditions_surcharge_pct AS DOUBLE))
      comment: "Average extraordinary conditions surcharge percentage. Measures revenue recovery for adverse weather or emergency towage."
    - name: "avg_cancellation_fee_amount"
      expr: AVG(CAST(cancellation_fee_amount AS DOUBLE))
      comment: "Average cancellation fee for towage services. Measures revenue protection against last-minute cancellations."
    - name: "avg_minimum_charge_amount"
      expr: AVG(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Average minimum towage charge floor. Ensures revenue floor adequacy per towage operation."
    - name: "avg_maximum_charge_amount"
      expr: AVG(CAST(maximum_charge_amount AS DOUBLE))
      comment: "Average maximum towage charge cap. Monitors revenue ceiling constraints on large vessel towage."
    - name: "avg_tug_bollard_pull_min_tonnes"
      expr: AVG(CAST(tug_bollard_pull_min_tonnes AS DOUBLE))
      comment: "Average minimum tug bollard pull requirement. Measures the operational capability standard embedded in towage tariffs — links pricing to tug fleet capability."
    - name: "active_towage_tariff_count"
      expr: COUNT(CASE WHEN tariff_status = 'Active' THEN towage_tariff_id END)
      comment: "Number of active towage tariffs. Measures towage tariff portfolio coverage."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_free_time_allowance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Free time allowance analytics — free day grants, auto-apply coverage, and DG/reefer applicability. Free time is a key commercial lever in container logistics and a primary driver of demurrage/detention revenue timing."
  source: "`vibe_shipping_ports_v1`.`tariff`.`free_time_allowance`"
  dimensions:
    - name: "free_time_type"
      expr: free_time_type
      comment: "Type of free time (e.g. Demurrage Free Time, Detention Free Time, Storage Free Time) — primary segmentation for free time analysis."
    - name: "applicable_charge_type"
      expr: applicable_charge_type
      comment: "Charge type the free time applies to — links free time to specific revenue lines."
    - name: "cargo_type"
      expr: cargo_type
      comment: "Cargo type the free time applies to — enables cargo-specific free time analysis."
    - name: "customer_tier"
      expr: customer_tier
      comment: "Customer tier the free time applies to — segments standard vs. preferential free time terms."
    - name: "trade_lane"
      expr: trade_lane
      comment: "Trade lane scope of the free time allowance — enables lane-level free time analysis."
    - name: "free_time_allowance_status"
      expr: free_time_allowance_status
      comment: "Lifecycle status of the allowance (Active, Expired, Draft) — filters operational allowances."
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Whether the allowance applies to dangerous goods — DG free time is typically restricted."
    - name: "reefer_cargo_flag"
      expr: reefer_cargo_flag
      comment: "Whether the allowance applies to reefer cargo — reefer free time is typically shorter due to power costs."
    - name: "auto_apply_flag"
      expr: auto_apply_flag
      comment: "Whether the free time is automatically applied — distinguishes automated vs. manual free time grants."
  measures:
    - name: "avg_maximum_volume_teu"
      expr: AVG(CAST(maximum_volume_teu AS DOUBLE))
      comment: "Average maximum volume (TEU) cap for free time allowances. Measures the volume ceiling on free time grants — limits revenue exposure from large-volume free time."
    - name: "avg_minimum_volume_teu"
      expr: AVG(CAST(minimum_volume_teu AS DOUBLE))
      comment: "Average minimum volume (TEU) threshold for free time eligibility. Measures the volume commitment required to earn free time — links free time to commercial value."
    - name: "active_allowance_count"
      expr: COUNT(CASE WHEN free_time_allowance_status = 'Active' THEN free_time_allowance_id END)
      comment: "Number of active free time allowances. Measures the breadth of free time commercial exposure."
    - name: "auto_apply_allowance_count"
      expr: COUNT(CASE WHEN auto_apply_flag = TRUE THEN free_time_allowance_id END)
      comment: "Number of free time allowances set to auto-apply. High auto-apply count increases revenue deferral risk if eligibility rules are misconfigured."
    - name: "dg_restricted_allowance_count"
      expr: COUNT(CASE WHEN dangerous_goods_flag = TRUE THEN free_time_allowance_id END)
      comment: "Number of free time allowances covering dangerous goods. DG free time is a risk-sensitive commercial concession."
    - name: "reefer_allowance_count"
      expr: COUNT(CASE WHEN reefer_cargo_flag = TRUE THEN free_time_allowance_id END)
      comment: "Number of free time allowances covering reefer cargo. Reefer free time has direct power cost implications — measures reefer free time exposure."
    - name: "holiday_exclusion_allowance_count"
      expr: COUNT(CASE WHEN holiday_exclusion_flag = TRUE THEN free_time_allowance_id END)
      comment: "Number of free time allowances excluding public holidays. Holiday exclusions extend effective free time — measures customer-favorable free time terms."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_pricing_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing rule analytics — rule coverage, discount/surcharge levels, volume triggers, and conflict resolution posture. Pricing rules are the automated decision engine for tariff application and a key governance area."
  source: "`vibe_shipping_ports_v1`.`tariff`.`pricing_rule`"
  dimensions:
    - name: "rule_type"
      expr: rule_type
      comment: "Type of pricing rule (e.g. Volume Discount, Surcharge, Override, Promotional) — primary segmentation for rule analysis."
    - name: "rule_status"
      expr: rule_status
      comment: "Lifecycle status of the pricing rule (Active, Inactive, Draft) — filters operational rules."
    - name: "trigger_cargo_type"
      expr: trigger_cargo_type
      comment: "Cargo type that triggers the pricing rule — enables cargo-specific rule analysis."
    - name: "trigger_trade_direction"
      expr: trigger_trade_direction
      comment: "Trade direction (Import/Export) that triggers the rule — enables directional pricing analysis."
    - name: "trigger_trade_lane"
      expr: trigger_trade_lane
      comment: "Trade lane that triggers the rule — enables lane-level pricing rule analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the pricing rule — supports multi-currency analysis."
    - name: "auto_apply_flag"
      expr: auto_apply_flag
      comment: "Whether the rule is automatically applied — distinguishes automated vs. manual pricing rules."
    - name: "sla_linked_flag"
      expr: sla_linked_flag
      comment: "Whether the rule is linked to SLA performance — identifies performance-contingent pricing rules."
    - name: "effective_from_date_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the pricing rule became effective — tracks rule introduction cadence."
  measures:
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across pricing rules. Measures automated discount depth — key margin erosion monitoring KPI."
    - name: "avg_surcharge_percentage"
      expr: AVG(CAST(surcharge_percentage AS DOUBLE))
      comment: "Average surcharge percentage across pricing rules. Measures automated surcharge uplift — key revenue enhancement monitoring KPI."
    - name: "avg_minimum_charge_amount"
      expr: AVG(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Average minimum charge floor across pricing rules. Ensures revenue floor adequacy in automated pricing."
    - name: "avg_maximum_charge_amount"
      expr: AVG(CAST(maximum_charge_amount AS DOUBLE))
      comment: "Average maximum charge cap across pricing rules. Monitors revenue ceiling constraints in automated pricing."
    - name: "avg_trigger_volume_min_teu"
      expr: AVG(CAST(trigger_volume_min_teu AS DOUBLE))
      comment: "Average minimum TEU volume trigger for pricing rules. Measures the volume threshold required to activate pricing rules."
    - name: "avg_trigger_volume_max_teu"
      expr: AVG(CAST(trigger_volume_max_teu AS DOUBLE))
      comment: "Average maximum TEU volume trigger for pricing rules. Measures the volume ceiling for pricing rule applicability."
    - name: "active_pricing_rule_count"
      expr: COUNT(CASE WHEN rule_status = 'Active' THEN pricing_rule_id END)
      comment: "Number of active pricing rules. Measures the breadth of automated pricing coverage."
    - name: "auto_apply_rule_count"
      expr: COUNT(CASE WHEN auto_apply_flag = TRUE THEN pricing_rule_id END)
      comment: "Number of pricing rules set to auto-apply. High auto-apply count increases revenue impact of misconfigured rules — governance risk indicator."
    - name: "approval_required_rule_count"
      expr: COUNT(CASE WHEN approval_required_flag = TRUE THEN pricing_rule_id END)
      comment: "Number of pricing rules requiring approval before application. Measures governance oversight level in automated pricing."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_sla_rate_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA rate card analytics — performance targets, penalty/premium structures, and volume commitments. SLA rate cards link commercial pricing to operational service delivery and are a key tool for aligning terminal and customer incentives."
  source: "`vibe_shipping_ports_v1`.`tariff`.`rate_card`"
  dimensions:
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier of the rate card (e.g. Gold, Silver, Bronze) — primary segmentation for SLA performance analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the SLA rate card auto-renews — identifies cards requiring proactive renegotiation."
  measures:
    - name: "avg_premium_percentage"
      expr: AVG(CAST(premium_percentage AS DOUBLE))
      comment: "Average premium percentage for SLA outperformance. Measures revenue upside from exceeding service commitments."
    - name: "avg_crane_productivity_target"
      expr: AVG(CAST(crane_productivity_target_moves_per_hour AS DOUBLE))
      comment: "Average crane productivity target (moves/hour) in SLA rate cards. Measures operational performance standard embedded in commercial agreements."
    - name: "avg_vessel_turnaround_target_hours"
      expr: AVG(CAST(vessel_turnaround_time_target_hours AS DOUBLE))
      comment: "Average vessel turnaround time target in SLA rate cards. Measures turnaround SLA stringency — directly impacts shipping line schedule reliability."
    - name: "avg_gate_processing_time_target_minutes"
      expr: AVG(CAST(gate_processing_time_target_minutes AS DOUBLE))
      comment: "Average gate processing time target in SLA rate cards. Measures gate SLA stringency embedded in commercial pricing."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`tariff_applicability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tariff applicability rule analytics — rule coverage, conflict resolution posture, and auto-apply exposure. Applicability rules govern which tariff applies to which customer/cargo/vessel combination and are a key governance area for billing accuracy."
  source: "`vibe_shipping_ports_v1`.`tariff`.`applicability`"
  dimensions:
    - name: "applicability_status"
      expr: applicability_status
      comment: "Lifecycle status of the applicability rule (Active, Inactive, Superseded) — filters operational rules."
    - name: "movement_type"
      expr: movement_type
      comment: "Container movement type the rule applies to (Import, Export, Transhipment) — primary segmentation for applicability analysis."
    - name: "service_type"
      expr: service_type
      comment: "Service type the rule applies to — enables service-level applicability analysis."
    - name: "load_status"
      expr: load_status
      comment: "Container load status (Full/Empty) the rule applies to — enables load-status-specific applicability analysis."
    - name: "trade_lane"
      expr: trade_lane
      comment: "Trade lane scope of the applicability rule — enables lane-level rule analysis."
    - name: "auto_apply_flag"
      expr: auto_apply_flag
      comment: "Whether the rule is automatically applied — distinguishes automated vs. manual applicability."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Whether the rule requires approval — identifies high-sensitivity applicability rules."
    - name: "exclusion_flag"
      expr: exclusion_flag
      comment: "Whether the rule is an exclusion (negative applicability) — identifies rules that explicitly exclude certain scenarios."
    - name: "effective_from_date_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the applicability rule became effective — tracks rule introduction cadence."
  measures:
    - name: "avg_container_size_teu"
      expr: AVG(CAST(container_size_teu AS DOUBLE))
      comment: "Average container size (TEU) covered by applicability rules. Tracks the TEU mix of the applicability rule portfolio."
    - name: "avg_minimum_volume_teu"
      expr: AVG(CAST(minimum_volume_teu AS DOUBLE))
      comment: "Average minimum volume (TEU) threshold in applicability rules. Measures the volume floor required for rule activation."
    - name: "avg_maximum_volume_teu"
      expr: AVG(CAST(maximum_volume_teu AS DOUBLE))
      comment: "Average maximum volume (TEU) ceiling in applicability rules. Measures the volume cap for rule applicability."
    - name: "active_rule_count"
      expr: COUNT(CASE WHEN applicability_status = 'Active' THEN applicability_id END)
      comment: "Number of active applicability rules. Measures the breadth of automated tariff applicability coverage."
    - name: "auto_apply_rule_count"
      expr: COUNT(CASE WHEN auto_apply_flag = TRUE THEN applicability_id END)
      comment: "Number of applicability rules set to auto-apply. High auto-apply count increases billing accuracy risk if rules are misconfigured."
    - name: "exclusion_rule_count"
      expr: COUNT(CASE WHEN exclusion_flag = TRUE THEN applicability_id END)
      comment: "Number of exclusion applicability rules. Measures the complexity of negative applicability logic — high exclusion count increases billing error risk."
    - name: "approval_required_rule_count"
      expr: COUNT(CASE WHEN approval_required_flag = TRUE THEN applicability_id END)
      comment: "Number of applicability rules requiring approval. Measures governance oversight level in tariff applicability."
    - name: "superseded_rule_count"
      expr: COUNT(CASE WHEN superseded_by_rule_applicability_id IS NOT NULL THEN applicability_id END)
      comment: "Number of applicability rules that have been superseded. Tracks rule churn rate and governance activity."
$$;