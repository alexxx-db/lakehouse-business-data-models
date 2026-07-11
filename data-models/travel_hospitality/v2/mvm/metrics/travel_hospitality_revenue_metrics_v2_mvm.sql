-- Metric views for domain: revenue | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-07-10 22:17:24

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_performance_actuals`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core hospitality revenue performance KPIs tracking actual ADR, RevPAR, TRevPAR, occupancy, GOP, and ancillary revenue streams by property, channel, date, and segment. Primary steering dashboard for revenue management and executive leadership."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`performance_actuals`"
  dimensions:
    - name: "performance_date"
      expr: performance_date
      comment: "Calendar date of the performance record, used for daily, weekly, and monthly trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for all monetary measures, enabling multi-currency reporting."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Originating PMS or source system identifier, used to reconcile data across systems."
    - name: "record_status"
      expr: record_status
      comment: "Status of the performance record (e.g. final, provisional, adjusted), used to filter to reconciled data."
    - name: "is_reconciled"
      expr: is_reconciled
      comment: "Boolean flag indicating whether the performance record has been reconciled against the general ledger."
    - name: "performance_month"
      expr: DATE_TRUNC('MONTH', performance_date)
      comment: "Month bucket derived from performance_date for monthly trend and YoY comparison."
    - name: "performance_year"
      expr: YEAR(performance_date)
      comment: "Calendar year derived from performance_date for annual performance reporting."
  measures:
    - name: "total_room_revenue"
      expr: SUM(CAST(total_room_revenue AS DOUBLE))
      comment: "Total rooms revenue across all room types and channels. Primary top-line revenue KPI for hotel operations."
    - name: "total_property_revenue"
      expr: SUM(CAST(total_property_revenue AS DOUBLE))
      comment: "Total property-wide revenue including rooms, F&B, spa, parking, and ancillary. Drives TRevPAR and overall P&L."
    - name: "fb_revenue"
      expr: SUM(CAST(fb_revenue AS DOUBLE))
      comment: "Total food and beverage revenue. Key ancillary revenue stream tracked separately for outlet performance."
    - name: "ancillary_revenue"
      expr: SUM(CAST(ancillary_revenue AS DOUBLE))
      comment: "Total ancillary revenue (spa, parking, miscellaneous). Measures success of upsell and non-room revenue strategy."
    - name: "spa_revenue"
      expr: SUM(CAST(spa_revenue AS DOUBLE))
      comment: "Total spa revenue. Tracked as a strategic ancillary revenue line for wellness-focused properties."
    - name: "parking_revenue"
      expr: SUM(CAST(parking_revenue AS DOUBLE))
      comment: "Total parking revenue. Ancillary revenue stream relevant for urban and resort properties."
    - name: "avg_adr"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average Daily Rate across all performance records. Core pricing KPI used in revenue management and competitive benchmarking."
    - name: "avg_revpar"
      expr: AVG(CAST(revpar AS DOUBLE))
      comment: "Average Revenue Per Available Room. The primary hotel industry yield metric combining occupancy and rate."
    - name: "avg_trevpar"
      expr: AVG(CAST(trevpar AS DOUBLE))
      comment: "Average Total Revenue Per Available Room. Extends RevPAR to include all revenue streams; used for total asset performance evaluation."
    - name: "avg_goppar"
      expr: AVG(CAST(goppar AS DOUBLE))
      comment: "Average Gross Operating Profit Per Available Room. Bridges revenue performance to profitability; key metric for ownership and asset management."
    - name: "avg_occupancy_rate"
      expr: AVG(CAST(occupancy_rate AS DOUBLE))
      comment: "Average occupancy rate (rooms sold / rooms available). Fundamental demand indicator used alongside ADR to manage yield."
    - name: "total_gop"
      expr: SUM(CAST(gop AS DOUBLE))
      comment: "Total Gross Operating Profit. Measures operational profitability before fixed charges; used in owner and management company reporting."
    - name: "total_ebitda_contribution"
      expr: SUM(CAST(ebitda_contribution AS DOUBLE))
      comment: "Total EBITDA contribution from the property. Used by finance and ownership for investment performance and covenant compliance."
    - name: "avg_ari"
      expr: AVG(CAST(ari AS DOUBLE))
      comment: "Average Accommodation Revenue Index (ARI). Competitive benchmarking metric measuring revenue share relative to comp set."
    - name: "avg_mpi"
      expr: AVG(CAST(mpi AS DOUBLE))
      comment: "Average Market Penetration Index. Measures occupancy performance relative to competitive set; triggers pricing strategy review when below 100."
    - name: "avg_rgi"
      expr: AVG(CAST(rgi AS DOUBLE))
      comment: "Average Revenue Generation Index. Composite competitive performance metric (RevPAR vs comp set); primary STR benchmarking KPI."
    - name: "avg_cpor"
      expr: AVG(CAST(cpor AS DOUBLE))
      comment: "Average Cost Per Occupied Room. Measures operational efficiency; rising CPOR against flat ADR signals margin compression."
    - name: "revpar_vs_prior_year_variance"
      expr: AVG(CAST(revpar AS DOUBLE)) - AVG(CAST(prior_year_revpar AS DOUBLE))
      comment: "RevPAR variance versus prior year (current avg RevPAR minus prior year avg RevPAR). Year-over-year growth indicator used in QBRs and board reporting."
    - name: "avg_budget_adr"
      expr: AVG(CAST(budget_adr AS DOUBLE))
      comment: "Average budgeted ADR. Used as the baseline for ADR variance analysis against actuals."
    - name: "total_budget_room_revenue"
      expr: SUM(CAST(budget_room_revenue AS DOUBLE))
      comment: "Total budgeted room revenue. Used for budget vs actual variance reporting and forecast accuracy assessment."
    - name: "total_budget_total_revenue"
      expr: SUM(CAST(budget_total_revenue AS DOUBLE))
      comment: "Total budgeted property revenue. Used for total revenue budget vs actual variance analysis."
    - name: "room_revenue_vs_budget_variance"
      expr: SUM((CAST(total_room_revenue AS DOUBLE)) - (CAST(budget_room_revenue AS DOUBLE)))
      comment: "Room revenue variance against budget (actual minus budget). Negative values trigger revenue recovery actions; positive values confirm outperformance."
    - name: "avg_budget_occupancy_rate"
      expr: AVG(CAST(budget_occupancy_rate AS DOUBLE))
      comment: "Average budgeted occupancy rate. Baseline for occupancy variance analysis against actuals."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_demand_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue management demand forecasting KPIs covering projected occupancy, ADR, RevPAR, room revenue, and forecast accuracy. Used by revenue managers to validate model performance and adjust pricing strategy."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`demand_forecast`"
  dimensions:
    - name: "forecast_date"
      expr: forecast_date
      comment: "The stay date being forecasted. Primary time dimension for demand forecast analysis."
    - name: "forecast_month"
      expr: DATE_TRUNC('MONTH', forecast_date)
      comment: "Month bucket of the forecast date for monthly demand planning."
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g. unconstrained, constrained, pickup). Determines which forecast stream is being evaluated."
    - name: "forecast_model_type"
      expr: forecast_model_type
      comment: "Algorithm or model type used to generate the forecast (e.g. ARIMA, ML ensemble). Used to compare model performance."
    - name: "forecast_granularity"
      expr: forecast_granularity
      comment: "Granularity level of the forecast (e.g. property, room type, segment). Determines the scope of the forecast record."
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast record (e.g. active, superseded, override). Used to filter to the current active forecast."
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week for the forecast date. Enables day-of-week demand pattern analysis."
    - name: "is_holiday"
      expr: is_holiday
      comment: "Boolean flag indicating whether the forecast date falls on a public holiday. Used to segment holiday vs non-holiday demand."
    - name: "is_special_event"
      expr: is_special_event
      comment: "Boolean flag indicating whether a special event is driving demand on the forecast date."
    - name: "is_override"
      expr: is_override
      comment: "Boolean flag indicating whether the forecast has been manually overridden by a revenue manager."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for all monetary forecast measures."
    - name: "forecast_horizon_days"
      expr: forecast_horizon_days
      comment: "Number of days ahead the forecast covers. Used to segment short-term vs long-term forecast accuracy analysis."
  measures:
    - name: "avg_projected_occupancy_pct"
      expr: AVG(CAST(projected_occupancy_pct AS DOUBLE))
      comment: "Average projected occupancy percentage across forecast records. Primary demand signal used to set pricing and inventory controls."
    - name: "avg_projected_adr"
      expr: AVG(CAST(projected_adr AS DOUBLE))
      comment: "Average projected Average Daily Rate. Used by revenue managers to validate pricing strategy against demand forecasts."
    - name: "avg_projected_revpar"
      expr: AVG(CAST(projected_revpar AS DOUBLE))
      comment: "Average projected RevPAR. Forward-looking yield KPI used in revenue strategy meetings and owner reporting."
    - name: "total_projected_room_revenue"
      expr: SUM(CAST(projected_room_revenue AS DOUBLE))
      comment: "Total projected room revenue across all forecast records. Used for forward revenue planning and budget gap analysis."
    - name: "avg_unconstrained_demand"
      expr: AVG(CAST(unconstrained_demand AS DOUBLE))
      comment: "Average unconstrained demand (demand before inventory limits). Measures true market demand; gap vs constrained demand reveals lost revenue opportunity."
    - name: "avg_constrained_demand"
      expr: AVG(CAST(constrained_demand AS DOUBLE))
      comment: "Average constrained demand (demand after applying inventory limits). Actual expected rooms sold used for operational planning."
    - name: "avg_forecast_accuracy_mape"
      expr: AVG(CAST(forecast_accuracy_mape AS DOUBLE))
      comment: "Average Mean Absolute Percentage Error of the forecast model. Core model quality KPI; high MAPE triggers model recalibration."
    - name: "avg_projected_pickup"
      expr: AVG(CAST(projected_pickup AS DOUBLE))
      comment: "Average projected booking pickup (incremental rooms expected to be booked). Used to set overbooking levels and inventory release strategies."
    - name: "avg_projected_cancellations"
      expr: AVG(CAST(projected_cancellations AS DOUBLE))
      comment: "Average projected cancellations. Used to calibrate overbooking policy and net demand estimates."
    - name: "avg_projected_no_shows"
      expr: AVG(CAST(projected_no_shows AS DOUBLE))
      comment: "Average projected no-shows. Informs overbooking strategy and walk risk management."
    - name: "avg_ari_forecast"
      expr: AVG(CAST(ari_forecast AS DOUBLE))
      comment: "Average forecasted Accommodation Revenue Index. Forward-looking competitive benchmarking metric."
    - name: "avg_rgi_forecast"
      expr: AVG(CAST(rgi_forecast AS DOUBLE))
      comment: "Average forecasted Revenue Generation Index. Predicts competitive RevPAR position; used to proactively adjust pricing."
    - name: "avg_mpi_forecast"
      expr: AVG(CAST(mpi_forecast AS DOUBLE))
      comment: "Average forecasted Market Penetration Index. Forward-looking occupancy share vs comp set; triggers rate strategy adjustments."
    - name: "demand_override_count"
      expr: COUNT(CASE WHEN is_override = TRUE THEN 1 END)
      comment: "Count of forecast records where a revenue manager manually overrode the system forecast. High override rates signal model drift or market disruption."
    - name: "avg_confidence_level_pct"
      expr: AVG(CAST(confidence_level_pct AS DOUBLE))
      comment: "Average statistical confidence level of the forecast. Low confidence triggers review of forecast inputs and model assumptions."
    - name: "avg_booking_pace_index"
      expr: AVG(CAST(booking_pace_index AS DOUBLE))
      comment: "Average booking pace index relative to historical baseline. Deviations from 100 signal accelerating or decelerating demand requiring pricing response."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_inventory_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory control and yield management KPIs covering overbooking levels, hurdle rates, BAR pricing, and availability controls. Used by revenue managers to optimize room inventory deployment and protect yield."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`inventory_control`"
  dimensions:
    - name: "stay_date"
      expr: stay_date
      comment: "The stay date to which the inventory control record applies. Primary time dimension for inventory analysis."
    - name: "stay_month"
      expr: DATE_TRUNC('MONTH', stay_date)
      comment: "Month bucket of the stay date for monthly inventory planning."
    - name: "control_type"
      expr: control_type
      comment: "Type of inventory control applied (e.g. stop sell, min stay, overbooking). Categorizes the nature of the restriction."
    - name: "control_status"
      expr: control_status
      comment: "Current status of the inventory control record (e.g. active, expired, overridden)."
    - name: "is_closed_to_arrival"
      expr: is_closed_to_arrival
      comment: "Boolean flag indicating whether arrivals are blocked for this stay date and room type."
    - name: "is_closed_to_departure"
      expr: is_closed_to_departure
      comment: "Boolean flag indicating whether departures are blocked for this stay date and room type."
    - name: "is_override"
      expr: is_override
      comment: "Boolean flag indicating whether the control was manually overridden by a revenue manager."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for monetary control values."
    - name: "walk_policy"
      expr: walk_policy
      comment: "Walk policy applied when the property is overbooked. Used to assess walk risk and compensation exposure."
  measures:
    - name: "avg_overbooking_pct"
      expr: AVG(CAST(overbooking_pct AS DOUBLE))
      comment: "Average overbooking percentage applied across inventory control records. Directly impacts walk risk and guest satisfaction; monitored daily by revenue management."
    - name: "avg_hurdle_rate"
      expr: AVG(CAST(hurdle_rate AS DOUBLE))
      comment: "Average hurdle rate (minimum acceptable rate for a booking to displace another). Core yield management lever; low hurdle rates signal under-optimized inventory."
    - name: "avg_current_bar"
      expr: AVG(CAST(current_bar AS DOUBLE))
      comment: "Average current Best Available Rate across inventory control records. Reflects the live pricing position being offered to the market."
    - name: "avg_min_rate"
      expr: AVG(CAST(min_rate AS DOUBLE))
      comment: "Average minimum rate floor applied. Ensures rate integrity and prevents below-floor pricing across channels."
    - name: "avg_max_rate"
      expr: AVG(CAST(max_rate AS DOUBLE))
      comment: "Average maximum rate ceiling applied. Prevents rate spikes that could damage brand perception and rate parity."
    - name: "avg_occupancy_on_books"
      expr: AVG(CAST(occupancy_on_books AS DOUBLE))
      comment: "Average occupancy on books at the time of the inventory control snapshot. Key pace indicator used to calibrate overbooking and pricing decisions."
    - name: "avg_demand_forecast_rooms"
      expr: AVG(CAST(demand_forecast_rooms AS DOUBLE))
      comment: "Average demand forecast rooms used as input to inventory control decisions. Measures alignment between forecast and control actions."
    - name: "avg_system_recommended_value"
      expr: AVG(CAST(system_recommended_value AS DOUBLE))
      comment: "Average system-recommended control value (e.g. RMS-recommended overbooking or hurdle rate). Compared against actual control_value to measure revenue manager override behavior."
    - name: "avg_control_value"
      expr: AVG(CAST(control_value AS DOUBLE))
      comment: "Average actual control value applied (e.g. overbooking cap, sell limit). Compared against system recommendation to measure human override impact."
    - name: "override_count"
      expr: COUNT(CASE WHEN is_override = TRUE THEN 1 END)
      comment: "Count of inventory control records where the revenue manager overrode the system recommendation. High override rates may indicate model distrust or market disruption."
    - name: "closed_to_arrival_count"
      expr: COUNT(CASE WHEN is_closed_to_arrival = TRUE THEN 1 END)
      comment: "Count of stay dates with closed-to-arrival restrictions active. Elevated counts signal aggressive yield management or capacity constraints."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_rate_availability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate availability and pricing distribution KPIs tracking BAR rates, rack rates, rate parity, stop-sell conditions, and occupancy forecasts by channel, room type, and rate plan. Used by revenue management and distribution teams to optimize rate deployment."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`rate_availability`"
  dimensions:
    - name: "snapshot_date"
      expr: snapshot_date
      comment: "Date of the rate availability snapshot. Used to track rate changes over time and analyze pricing decisions."
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_date)
      comment: "Month bucket of the snapshot date for monthly rate strategy analysis."
    - name: "availability_status"
      expr: availability_status
      comment: "Current availability status of the rate (e.g. open, closed, stop sell). Primary filter for distribution analysis."
    - name: "rate_plan_type"
      expr: rate_plan_type
      comment: "Type of rate plan (e.g. BAR, negotiated, package, group). Used to segment pricing analysis by rate strategy."
    - name: "rate_plan_code"
      expr: rate_plan_code
      comment: "Rate plan code as loaded in the distribution system. Used for rate plan performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for all rate measures."
    - name: "stop_sell"
      expr: stop_sell
      comment: "Boolean flag indicating whether the rate is currently stop-sold. Used to monitor distribution restrictions."
    - name: "closed_to_arrival"
      expr: closed_to_arrival
      comment: "Boolean flag indicating whether arrivals are blocked for this rate and date combination."
    - name: "rate_parity_flag"
      expr: rate_parity_flag
      comment: "Boolean flag indicating whether rate parity is maintained across channels. Parity violations trigger immediate distribution team action."
    - name: "is_package_rate"
      expr: is_package_rate
      comment: "Boolean flag indicating whether the rate is a package (includes non-room components). Used to segment package vs room-only revenue."
    - name: "pricing_override_flag"
      expr: pricing_override_flag
      comment: "Boolean flag indicating whether the rate was manually overridden from the system recommendation."
    - name: "demand_forecast_level"
      expr: demand_forecast_level
      comment: "Demand forecast level used to set this rate availability record (e.g. high, medium, low). Links pricing decisions to demand signals."
    - name: "meal_plan_code"
      expr: meal_plan_code
      comment: "Meal plan included with the rate (e.g. BB, HB, AI). Used to segment rate analysis by meal plan type."
  measures:
    - name: "avg_bar_rate"
      expr: AVG(CAST(bar_rate AS DOUBLE))
      comment: "Average Best Available Rate across all rate availability records. Primary pricing KPI; tracks the live rate position being offered to the market."
    - name: "avg_rack_rate"
      expr: AVG(CAST(rack_rate AS DOUBLE))
      comment: "Average rack rate. Used as the ceiling reference for discount and negotiated rate analysis."
    - name: "avg_min_rate"
      expr: AVG(CAST(min_rate AS DOUBLE))
      comment: "Average minimum rate floor across rate availability records. Ensures rate integrity and prevents below-floor distribution."
    - name: "avg_max_rate"
      expr: AVG(CAST(max_rate AS DOUBLE))
      comment: "Average maximum rate ceiling. Monitors the upper bound of pricing being offered across channels."
    - name: "avg_occupancy_forecast_pct"
      expr: AVG(CAST(occupancy_forecast_pct AS DOUBLE))
      comment: "Average occupancy forecast percentage at the time of rate availability snapshot. Links pricing decisions to demand outlook."
    - name: "bar_to_rack_rate_discount_pct"
      expr: ROUND(100.0 * (1.0 - AVG(CAST(bar_rate AS DOUBLE)) / NULLIF(AVG(CAST(rack_rate AS DOUBLE)), 0)), 2)
      comment: "Average BAR rate as a percentage discount to rack rate. Measures how aggressively the property is discounting from rack; high discounts signal demand weakness."
    - name: "stop_sell_count"
      expr: COUNT(CASE WHEN stop_sell = TRUE THEN 1 END)
      comment: "Count of rate availability records with stop-sell active. Elevated counts indicate aggressive inventory restriction; used to monitor distribution strategy."
    - name: "rate_parity_violation_count"
      expr: COUNT(CASE WHEN rate_parity_flag = FALSE THEN 1 END)
      comment: "Count of rate availability records where rate parity is violated. Parity violations risk OTA contract penalties and brand damage; zero tolerance KPI."
    - name: "pricing_override_count"
      expr: COUNT(CASE WHEN pricing_override_flag = TRUE THEN 1 END)
      comment: "Count of rate availability records with manual pricing overrides. Tracks revenue manager intervention frequency against system recommendations."
    - name: "total_rate_availability_records"
      expr: COUNT(1)
      comment: "Total count of rate availability records in the snapshot. Used as the denominator for rate parity and stop-sell rate calculations."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_dynamic_rate_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dynamic pricing rule performance KPIs tracking rate adjustment values, trigger frequency, rule approval status, and pricing floor/ceiling compliance. Used by revenue management to govern automated pricing decisions."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule`"
  dimensions:
    - name: "rule_type"
      expr: rule_type
      comment: "Type of dynamic rate rule (e.g. demand-based, pickup-based, competitive). Categorizes the pricing automation strategy."
    - name: "rule_status"
      expr: rule_status
      comment: "Current status of the rule (e.g. active, inactive, pending approval). Used to filter to live pricing rules."
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of rate adjustment (e.g. percentage, absolute amount). Determines how the adjustment_value is applied."
    - name: "adjustment_direction"
      expr: adjustment_direction
      comment: "Direction of the rate adjustment (e.g. increase, decrease). Used to segment rate-up vs rate-down rule performance."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the rule (e.g. approved, pending, rejected). Governance KPI for pricing rule management."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for all monetary rule parameters."
    - name: "is_stackable"
      expr: is_stackable
      comment: "Boolean flag indicating whether this rule can be combined with other rules. Non-stackable rules require careful sequencing to avoid pricing conflicts."
    - name: "effective_from"
      expr: effective_from
      comment: "Date from which the dynamic rate rule is effective. Used to track rule lifecycle and pricing strategy changes over time."
    - name: "effective_until"
      expr: effective_until
      comment: "Date until which the dynamic rate rule is effective. Used to identify expiring rules requiring renewal."
  measures:
    - name: "avg_adjustment_value"
      expr: AVG(CAST(adjustment_value AS DOUBLE))
      comment: "Average rate adjustment value applied by dynamic pricing rules. Measures the magnitude of automated pricing changes; large values signal aggressive dynamic pricing."
    - name: "avg_min_rate_floor"
      expr: AVG(CAST(min_rate_floor AS DOUBLE))
      comment: "Average minimum rate floor configured across dynamic rate rules. Ensures automated pricing never drops below acceptable yield thresholds."
    - name: "avg_max_rate_ceiling"
      expr: AVG(CAST(max_rate_ceiling AS DOUBLE))
      comment: "Average maximum rate ceiling configured across dynamic rate rules. Prevents automated pricing from exceeding brand-appropriate rate levels."
    - name: "avg_trigger_threshold_value"
      expr: AVG(CAST(trigger_threshold_value AS DOUBLE))
      comment: "Average trigger threshold value across dynamic rate rules. Measures the demand or pickup sensitivity level at which automated pricing activates."
    - name: "active_rule_count"
      expr: COUNT(CASE WHEN rule_status = 'active' THEN 1 END)
      comment: "Count of currently active dynamic rate rules. Tracks the breadth of automated pricing coverage across the property."
    - name: "pending_approval_rule_count"
      expr: COUNT(CASE WHEN approval_status = 'pending' THEN 1 END)
      comment: "Count of dynamic rate rules pending approval. Governance KPI; high pending counts indicate bottlenecks in the pricing rule approval workflow."
    - name: "rate_increase_rule_count"
      expr: COUNT(CASE WHEN adjustment_direction = 'increase' THEN 1 END)
      comment: "Count of rules configured to increase rates. Measures the balance of rate-up vs rate-down automation in the pricing strategy."
    - name: "rate_decrease_rule_count"
      expr: COUNT(CASE WHEN adjustment_direction = 'decrease' THEN 1 END)
      comment: "Count of rules configured to decrease rates. Elevated rate-decrease rule counts may signal over-reliance on discounting automation."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_negotiated_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Negotiated rate portfolio KPIs tracking contracted rate amounts, commission levels, LRA compliance, and contract lifecycle. Used by sales, revenue management, and finance to manage corporate and consortia rate agreements."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate`"
  dimensions:
    - name: "rate_type"
      expr: rate_type
      comment: "Type of negotiated rate (e.g. corporate, consortia, government, wholesale). Segments the rate portfolio by agreement category."
    - name: "rate_status"
      expr: rate_status
      comment: "Current status of the negotiated rate (e.g. active, expired, pending). Used to filter to live contracted rates."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the negotiated rate (e.g. approved, pending, rejected). Governance KPI for rate contract management."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for all negotiated rate monetary measures."
    - name: "is_lra"
      expr: is_lra
      comment: "Boolean flag indicating whether the rate is a Last Room Available (LRA) rate. LRA rates have significant revenue management implications as they cannot be closed."
    - name: "is_non_refundable"
      expr: is_non_refundable
      comment: "Boolean flag indicating whether the negotiated rate is non-refundable. Non-refundable rates improve revenue certainty and reduce cancellation exposure."
    - name: "breakfast_included"
      expr: breakfast_included
      comment: "Boolean flag indicating whether breakfast is included in the negotiated rate. Affects F&B revenue attribution and rate value comparison."
    - name: "contract_start_date"
      expr: contract_start_date
      comment: "Start date of the negotiated rate contract. Used for contract lifecycle and renewal pipeline analysis."
    - name: "contract_end_date"
      expr: contract_end_date
      comment: "End date of the negotiated rate contract. Used to identify contracts expiring within the planning horizon requiring renegotiation."
    - name: "rate_loading_status"
      expr: rate_loading_status
      comment: "Status of rate loading into distribution systems (e.g. loaded, pending, failed). Operational KPI for distribution readiness."
  measures:
    - name: "avg_negotiated_rate_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average negotiated rate amount across all active contracts. Measures the average contracted rate level; used to assess portfolio pricing relative to BAR."
    - name: "avg_commission_pct"
      expr: AVG(CAST(commission_pct AS DOUBLE))
      comment: "Average commission percentage across negotiated rate contracts. Directly impacts net revenue; high average commission signals need for contract renegotiation."
    - name: "avg_rate_bar_variance_pct"
      expr: AVG(CAST(rate_bar_variance_pct AS DOUBLE))
      comment: "Average variance between negotiated rate and BAR as a percentage. Measures how deeply negotiated rates are discounted from the best available rate; large negative variance signals over-discounting."
    - name: "total_active_contracts"
      expr: COUNT(CASE WHEN rate_status = 'active' THEN 1 END)
      comment: "Total count of active negotiated rate contracts. Measures the breadth of the contracted rate portfolio."
    - name: "lra_contract_count"
      expr: COUNT(CASE WHEN is_lra = TRUE THEN 1 END)
      comment: "Count of Last Room Available (LRA) negotiated rate contracts. LRA contracts constrain inventory control; high LRA counts limit revenue management flexibility."
    - name: "pending_approval_contract_count"
      expr: COUNT(CASE WHEN approval_status = 'pending' THEN 1 END)
      comment: "Count of negotiated rate contracts pending approval. Governance KPI; delays in approval prevent rate loading and lost bookings."
    - name: "non_refundable_contract_count"
      expr: COUNT(CASE WHEN is_non_refundable = TRUE THEN 1 END)
      comment: "Count of non-refundable negotiated rate contracts. Higher non-refundable share improves revenue certainty and reduces cancellation risk."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_market_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Market segment portfolio KPIs tracking commission rates, length of stay, and segment eligibility characteristics. Used by revenue management and sales to evaluate segment mix strategy and profitability."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`market_segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "High-level type of market segment (e.g. transient, group, contract). Primary segmentation dimension for revenue mix analysis."
    - name: "segment_category"
      expr: segment_category
      comment: "Category of the market segment (e.g. corporate, leisure, government). Used for segment mix and contribution analysis."
    - name: "market_segment_status"
      expr: market_segment_status
      comment: "Current status of the market segment definition (e.g. active, inactive). Used to filter to active segments."
    - name: "contribution_margin_tier"
      expr: contribution_margin_tier
      comment: "Contribution margin tier assigned to the segment (e.g. high, medium, low). Used to prioritize high-margin segment mix."
    - name: "price_sensitivity"
      expr: price_sensitivity
      comment: "Price sensitivity classification of the segment (e.g. high, medium, low). Informs dynamic pricing strategy and discount depth decisions."
    - name: "demand_pattern"
      expr: demand_pattern
      comment: "Demand pattern of the segment (e.g. advance purchase, last minute, seasonal). Used to calibrate booking pace and pickup forecasts."
    - name: "loyalty_eligible"
      expr: loyalty_eligible
      comment: "Boolean flag indicating whether the segment is eligible for loyalty program points. Affects loyalty cost allocation and member acquisition strategy."
    - name: "commission_eligible"
      expr: commission_eligible
      comment: "Boolean flag indicating whether the segment is commission-eligible. Directly impacts net revenue calculations for the segment."
    - name: "ota_eligible"
      expr: ota_eligible
      comment: "Boolean flag indicating whether the segment can be distributed via OTA channels. Affects distribution cost and rate parity obligations."
    - name: "revenue_bucket"
      expr: revenue_bucket
      comment: "Revenue bucket classification of the segment. Used for high-level revenue mix reporting and segment prioritization."
  measures:
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate percentage across market segments. High commission rates reduce net revenue; used to evaluate segment profitability and channel mix strategy."
    - name: "avg_length_of_stay_nights"
      expr: AVG(CAST(avg_length_of_stay_nights AS DOUBLE))
      comment: "Average length of stay in nights across market segments. Longer stays improve operational efficiency and reduce per-stay costs; used in segment mix optimization."
    - name: "active_segment_count"
      expr: COUNT(CASE WHEN market_segment_status = 'active' THEN 1 END)
      comment: "Count of active market segments. Measures the breadth of the segment portfolio; used to assess segmentation strategy complexity."
    - name: "commission_eligible_segment_count"
      expr: COUNT(CASE WHEN commission_eligible = TRUE THEN 1 END)
      comment: "Count of commission-eligible market segments. Used to quantify the portion of the segment portfolio carrying distribution commission costs."
    - name: "lra_eligible_segment_count"
      expr: COUNT(CASE WHEN min_rate_override_allowed = TRUE THEN 1 END)
      comment: "Count of segments where minimum rate override is allowed. Segments with rate override permissions require tighter revenue management governance."
$$;