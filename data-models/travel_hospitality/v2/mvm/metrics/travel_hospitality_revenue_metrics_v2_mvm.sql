-- Metric views for domain: revenue | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-27 02:47:23

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_performance_actuals`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core hospitality revenue performance KPIs derived from daily actuals. Covers room revenue, total property revenue, GOP, RevPAR, ADR, occupancy, TRevPAR, CPOR, and competitive index metrics (ARI, MPI, RGI). Primary steering dashboard for revenue management and ownership reporting."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`performance_actuals`"
  dimensions:
    - name: "performance_date"
      expr: performance_date
      comment: "Date of the performance record (yyyy-MM-dd). Used for daily, weekly, monthly, and YTD trending."
    - name: "performance_month"
      expr: DATE_TRUNC('MONTH', performance_date)
      comment: "Calendar month bucket derived from performance_date. Supports month-over-month revenue trend analysis."
    - name: "performance_year"
      expr: YEAR(performance_date)
      comment: "Calendar year derived from performance_date. Supports year-over-year comparisons."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for all monetary measures on this record. Enables multi-currency filtering."
    - name: "record_status"
      expr: record_status
      comment: "Processing status of the actuals record (e.g. FINAL, PRELIMINARY, ADJUSTED). Allows filtering to reconciled data only."
    - name: "is_reconciled"
      expr: is_reconciled
      comment: "Boolean flag indicating whether the actuals record has been reconciled against the general ledger."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Originating system of record (e.g. PMS, POS, ERP). Supports data lineage and cross-system reconciliation."
    - name: "property_id"
      expr: property_id
      comment: "Foreign key to the property dimension. Primary grouping key for property-level performance reporting."
    - name: "promotion_id"
      expr: promotion_id
      comment: "Foreign key to the promotion dimension. Supports revenue attribution to specific promotional campaigns."
  measures:
    - name: "total_room_revenue"
      expr: SUM(CAST(total_room_revenue AS DOUBLE))
      comment: "Total rooms revenue across all selected records. Core top-line KPI for hotel revenue management and ownership reporting."
    - name: "total_property_revenue"
      expr: SUM(CAST(total_property_revenue AS DOUBLE))
      comment: "Total revenue across all property revenue streams (rooms, F&B, spa, ancillary, parking, misc). Represents full TRevPAR numerator and overall property P&L top line."
    - name: "fb_revenue"
      expr: SUM(CAST(fb_revenue AS DOUBLE))
      comment: "Total food and beverage revenue. Key non-rooms revenue stream for full-service and resort properties."
    - name: "ancillary_revenue"
      expr: SUM(CAST(ancillary_revenue AS DOUBLE))
      comment: "Total ancillary revenue (e.g. resort fees, amenity charges). Tracks incremental revenue beyond room rate."
    - name: "spa_revenue"
      expr: SUM(CAST(spa_revenue AS DOUBLE))
      comment: "Total spa revenue. Measures performance of the spa profit centre for resort and full-service properties."
    - name: "parking_revenue"
      expr: SUM(CAST(parking_revenue AS DOUBLE))
      comment: "Total parking revenue. Tracks ancillary parking income, relevant for urban and airport properties."
    - name: "gross_operating_profit"
      expr: SUM(CAST(gop AS DOUBLE))
      comment: "Total Gross Operating Profit (GOP) per USALI standards. Primary profitability KPI used in owner reports and management agreements."
    - name: "ebitda_contribution"
      expr: SUM(CAST(ebitda_contribution AS DOUBLE))
      comment: "Total EBITDA contribution from the property. Used by ownership and investment teams to assess asset-level returns."
    - name: "avg_adr"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average Daily Rate (ADR) — average room revenue per occupied room. Core pricing KPI for revenue managers and GMs."
    - name: "avg_revpar"
      expr: AVG(CAST(revpar AS DOUBLE))
      comment: "Average Revenue Per Available Room (RevPAR). The primary yield metric combining occupancy and rate; used in every revenue steering meeting."
    - name: "avg_trevpar"
      expr: AVG(CAST(trevpar AS DOUBLE))
      comment: "Average Total Revenue Per Available Room (TRevPAR). Measures total property revenue yield across all available rooms; key for full-service and resort properties."
    - name: "avg_goppar"
      expr: AVG(CAST(goppar AS DOUBLE))
      comment: "Average Gross Operating Profit Per Available Room (GOPPAR). Profitability yield metric used by asset managers and ownership groups."
    - name: "avg_occupancy_rate"
      expr: AVG(CAST(occupancy_rate AS DOUBLE))
      comment: "Average occupancy rate (percentage of available rooms sold). Fundamental demand indicator used in all revenue and operations reviews."
    - name: "avg_cpor"
      expr: AVG(CAST(cpor AS DOUBLE))
      comment: "Average Cost Per Occupied Room (CPOR). Measures operational efficiency; rising CPOR against flat ADR signals margin compression."
    - name: "avg_ari"
      expr: AVG(CAST(ari AS DOUBLE))
      comment: "Average Accommodation Revenue Index (ARI) — competitive set revenue share index. Values above 100 indicate outperformance vs comp set."
    - name: "avg_mpi"
      expr: AVG(CAST(mpi AS DOUBLE))
      comment: "Average Market Penetration Index (MPI) — occupancy share vs competitive set. Tracks demand capture relative to market."
    - name: "avg_rgi"
      expr: AVG(CAST(rgi AS DOUBLE))
      comment: "Average Revenue Generation Index (RGI) — RevPAR share vs competitive set. Composite competitive performance indicator used in STR reporting."
    - name: "avg_prior_year_revpar"
      expr: AVG(CAST(prior_year_revpar AS DOUBLE))
      comment: "Average prior-year RevPAR for the same period. Baseline for year-over-year RevPAR variance analysis."
    - name: "miscellaneous_income"
      expr: SUM(CAST(miscellaneous_income AS DOUBLE))
      comment: "Total miscellaneous income. Captures other operating revenue not classified in primary revenue streams."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Annual and period budget KPIs for revenue planning and variance analysis. Covers budgeted room revenue, total revenue, F&B, events, GOP, and key target metrics (ADR, RevPAR, occupancy, GOPPAR, TRevPAR). Used by finance, revenue management, and ownership for budget vs actual steering."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget record. Primary time dimension for annual budget planning and YTD tracking."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (e.g. month, quarter) within the fiscal year. Supports period-level budget vs actual analysis."
    - name: "planning_period_start_date"
      expr: planning_period_start_date
      comment: "Start date of the budget planning period. Used to align budget records to calendar periods."
    - name: "planning_period_end_date"
      expr: planning_period_end_date
      comment: "End date of the budget planning period."
    - name: "planning_horizon_type"
      expr: planning_horizon_type
      comment: "Type of planning horizon (e.g. ANNUAL, QUARTERLY, ROLLING_12). Distinguishes budget cycles."
    - name: "strategy_type"
      expr: strategy_type
      comment: "Revenue strategy type associated with the budget (e.g. GROWTH, STABILIZATION, REPOSITIONING). Supports strategic segmentation of budget targets."
    - name: "strategy_status"
      expr: strategy_status
      comment: "Current status of the budget strategy (e.g. DRAFT, APPROVED, REVISED). Filters to approved budgets for official reporting."
    - name: "is_owner_approved"
      expr: is_owner_approved
      comment: "Boolean flag indicating owner approval of the budget. Ensures only owner-approved budgets are used in official variance reporting."
    - name: "property_segment"
      expr: property_segment
      comment: "Property segment classification (e.g. LUXURY, SELECT_SERVICE, RESORT). Enables portfolio-level budget analysis by segment."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for all monetary budget measures."
    - name: "property_id"
      expr: property_id
      comment: "Foreign key to the property dimension. Primary grouping key for property-level budget reporting."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Foreign key to the market segment dimension. Enables budget analysis by market segment."
    - name: "approval_date"
      expr: approval_date
      comment: "Date the budget was formally approved. Used to track budget approval timelines."
  measures:
    - name: "total_budgeted_room_revenue"
      expr: SUM(CAST(budgeted_room_revenue AS DOUBLE))
      comment: "Total budgeted rooms revenue for the period. Primary budget baseline for revenue variance analysis."
    - name: "total_budgeted_total_revenue"
      expr: SUM(CAST(budgeted_total_revenue AS DOUBLE))
      comment: "Total budgeted revenue across all streams. Used as the denominator for budget attainment calculations."
    - name: "total_budgeted_fb_revenue"
      expr: SUM(CAST(budgeted_fb_revenue AS DOUBLE))
      comment: "Total budgeted food and beverage revenue. Tracks F&B budget targets for full-service properties."
    - name: "total_budgeted_events_revenue"
      expr: SUM(CAST(budgeted_events_revenue AS DOUBLE))
      comment: "Total budgeted events and meetings revenue. Key budget line for conference and convention properties."
    - name: "total_budgeted_gop"
      expr: SUM(CAST(budgeted_gop AS DOUBLE))
      comment: "Total budgeted Gross Operating Profit. Primary profitability budget target used in management agreements and owner reporting."
    - name: "total_budgeted_other_revenue"
      expr: SUM(CAST(budgeted_other_revenue AS DOUBLE))
      comment: "Total budgeted other/ancillary revenue. Captures non-rooms, non-F&B, non-events budget lines."
    - name: "avg_target_adr"
      expr: AVG(CAST(target_adr AS DOUBLE))
      comment: "Average budgeted target ADR. Pricing benchmark used to evaluate actual ADR performance against plan."
    - name: "avg_target_revpar"
      expr: AVG(CAST(target_revpar AS DOUBLE))
      comment: "Average budgeted target RevPAR. Primary yield benchmark for revenue management performance evaluation."
    - name: "avg_target_occupancy_rate"
      expr: AVG(CAST(target_occupancy_rate AS DOUBLE))
      comment: "Average budgeted target occupancy rate. Demand planning benchmark used in capacity and staffing decisions."
    - name: "avg_target_goppar"
      expr: AVG(CAST(target_goppar AS DOUBLE))
      comment: "Average budgeted target GOPPAR. Profitability yield benchmark for asset management and ownership reviews."
    - name: "avg_target_trevpar"
      expr: AVG(CAST(target_trevpar AS DOUBLE))
      comment: "Average budgeted target TRevPAR. Total revenue yield benchmark for full-service and resort properties."
    - name: "avg_target_alos"
      expr: AVG(CAST(target_alos AS DOUBLE))
      comment: "Average budgeted target Average Length of Stay (ALOS). Used in length-of-stay strategy and minimum stay restriction planning."
    - name: "avg_budgeted_cpor"
      expr: AVG(CAST(budgeted_cpor AS DOUBLE))
      comment: "Average budgeted Cost Per Occupied Room. Operational efficiency benchmark for cost management reviews."
    - name: "avg_target_mpi"
      expr: AVG(CAST(target_mpi AS DOUBLE))
      comment: "Average budgeted target Market Penetration Index. Competitive demand share target used in revenue strategy planning."
    - name: "avg_target_rgi"
      expr: AVG(CAST(target_rgi AS DOUBLE))
      comment: "Average budgeted target Revenue Generation Index. Composite competitive performance target for STR benchmarking."
    - name: "budget_record_count"
      expr: COUNT(1)
      comment: "Count of budget records. Used to validate budget completeness and track submission coverage across properties and periods."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_demand_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand forecasting KPIs covering projected occupancy, ADR, RevPAR, room revenue, pickup, cancellations, and forecast accuracy. Used by revenue managers to set pricing strategy, manage inventory, and evaluate forecast model performance."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`demand_forecast`"
  dimensions:
    - name: "forecast_date"
      expr: forecast_date
      comment: "The stay date being forecasted. Primary time dimension for demand forecast analysis."
    - name: "forecast_month"
      expr: DATE_TRUNC('MONTH', forecast_date)
      comment: "Month bucket of the forecast date. Supports monthly demand trend and pickup analysis."
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g. UNCONSTRAINED, CONSTRAINED, PICKUP). Distinguishes forecast methodologies for comparison."
    - name: "forecast_model_type"
      expr: forecast_model_type
      comment: "Algorithm or model type used to generate the forecast (e.g. EXPONENTIAL_SMOOTHING, ML_GRADIENT_BOOST). Enables model performance benchmarking."
    - name: "forecast_granularity"
      expr: forecast_granularity
      comment: "Granularity of the forecast (e.g. DAILY, WEEKLY, SEGMENT). Filters to the appropriate forecast resolution."
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast record (e.g. ACTIVE, SUPERSEDED, OVERRIDE). Filters to current active forecasts."
    - name: "is_override"
      expr: is_override
      comment: "Boolean flag indicating a manual revenue manager override of the system forecast. Tracks human intervention frequency."
    - name: "is_holiday"
      expr: is_holiday
      comment: "Boolean flag indicating the forecast date falls on a public holiday. Enables holiday demand pattern analysis."
    - name: "is_special_event"
      expr: is_special_event
      comment: "Boolean flag indicating a special event impacting demand on the forecast date. Supports event-driven demand segmentation."
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week for the forecast date. Enables day-of-week demand pattern analysis for pricing and restriction decisions."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for monetary forecast measures."
    - name: "property_id"
      expr: property_id
      comment: "Foreign key to the property dimension. Primary grouping key for property-level forecast reporting."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Foreign key to the market segment dimension. Enables demand forecast analysis by market segment."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Foreign key to the room type dimension. Supports room-type-level demand and pricing analysis."
  measures:
    - name: "avg_projected_occupancy_pct"
      expr: AVG(CAST(projected_occupancy_pct AS DOUBLE))
      comment: "Average projected occupancy percentage across forecast records. Primary demand KPI used to set pricing strategy and manage inventory restrictions."
    - name: "avg_projected_adr"
      expr: AVG(CAST(projected_adr AS DOUBLE))
      comment: "Average projected ADR from the demand forecast. Pricing benchmark used to evaluate rate strategy against expected demand."
    - name: "avg_projected_revpar"
      expr: AVG(CAST(projected_revpar AS DOUBLE))
      comment: "Average projected RevPAR from the demand forecast. Forward-looking yield KPI used in weekly revenue strategy meetings."
    - name: "total_projected_room_revenue"
      expr: SUM(CAST(projected_room_revenue AS DOUBLE))
      comment: "Total projected room revenue from the demand forecast. Used in rolling revenue projections and budget pacing analysis."
    - name: "total_projected_pickup"
      expr: SUM(CAST(projected_pickup AS DOUBLE))
      comment: "Total projected room pickup (incremental bookings expected). Key metric for pace analysis and last-minute pricing decisions."
    - name: "total_projected_cancellations"
      expr: SUM(CAST(projected_cancellations AS DOUBLE))
      comment: "Total projected cancellations. Used to set overbooking levels and manage net rooms available."
    - name: "total_projected_no_shows"
      expr: SUM(CAST(projected_no_shows AS DOUBLE))
      comment: "Total projected no-shows. Informs overbooking strategy and no-show policy calibration."
    - name: "avg_unconstrained_demand"
      expr: AVG(CAST(unconstrained_demand AS DOUBLE))
      comment: "Average unconstrained demand (demand before inventory limits). Reveals true market demand and informs capacity strategy."
    - name: "avg_constrained_demand"
      expr: AVG(CAST(constrained_demand AS DOUBLE))
      comment: "Average constrained demand (demand after applying inventory limits). Operational demand estimate used in staffing and procurement planning."
    - name: "avg_booking_pace_index"
      expr: AVG(CAST(booking_pace_index AS DOUBLE))
      comment: "Average booking pace index relative to historical baseline. Values above 1.0 indicate faster-than-normal pace; triggers early rate increases."
    - name: "avg_forecast_accuracy_mape"
      expr: AVG(CAST(forecast_accuracy_mape AS DOUBLE))
      comment: "Average Mean Absolute Percentage Error (MAPE) of the forecast model. Primary forecast quality KPI; high MAPE triggers model recalibration."
    - name: "avg_demand_segment_mix_pct"
      expr: AVG(CAST(demand_segment_mix_pct AS DOUBLE))
      comment: "Average demand segment mix percentage. Tracks the share of demand from each market segment; informs channel and segment strategy."
    - name: "avg_confidence_level_pct"
      expr: AVG(CAST(confidence_level_pct AS DOUBLE))
      comment: "Average statistical confidence level of the forecast. Low confidence triggers manual review and override by revenue managers."
    - name: "avg_mpi_forecast"
      expr: AVG(CAST(mpi_forecast AS DOUBLE))
      comment: "Average forecasted Market Penetration Index. Forward-looking competitive demand share indicator used in strategy planning."
    - name: "avg_ari_forecast"
      expr: AVG(CAST(ari_forecast AS DOUBLE))
      comment: "Average forecasted Accommodation Revenue Index. Forward-looking competitive revenue share indicator."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_rate_availability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate and inventory availability KPIs covering BAR rates, rack rates, occupancy forecasts, and availability controls (stop-sell, CTA, CTD). Used by revenue managers and distribution teams to monitor rate parity, pricing position, and channel availability."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`rate_availability`"
  dimensions:
    - name: "snapshot_date"
      expr: snapshot_date
      comment: "Date of the rate availability snapshot. Primary time dimension for rate calendar and availability analysis."
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_date)
      comment: "Month bucket of the snapshot date. Supports monthly rate strategy and availability trend analysis."
    - name: "rate_plan_type"
      expr: rate_plan_type
      comment: "Type of rate plan (e.g. BAR, NEGOTIATED, PACKAGE, GROUP). Enables rate strategy analysis by plan category."
    - name: "rate_plan_code"
      expr: rate_plan_code
      comment: "Rate plan code. Granular identifier for rate-level availability and pricing analysis."
    - name: "availability_status"
      expr: availability_status
      comment: "Current availability status of the rate (e.g. OPEN, CLOSED, STOP_SELL). Tracks inventory control decisions."
    - name: "stop_sell"
      expr: stop_sell
      comment: "Boolean flag indicating stop-sell is active for this rate/room type combination. Key inventory control indicator."
    - name: "closed_to_arrival"
      expr: closed_to_arrival
      comment: "Boolean flag indicating closed-to-arrival restriction is active. Tracks length-of-stay management controls."
    - name: "closed_to_departure"
      expr: closed_to_departure
      comment: "Boolean flag indicating closed-to-departure restriction is active."
    - name: "rate_parity_flag"
      expr: rate_parity_flag
      comment: "Boolean flag indicating rate parity compliance across channels. Rate parity violations trigger immediate revenue management action."
    - name: "is_package_rate"
      expr: is_package_rate
      comment: "Boolean flag indicating this is a package rate (room + inclusions). Enables package vs standalone rate analysis."
    - name: "pricing_override_flag"
      expr: pricing_override_flag
      comment: "Boolean flag indicating a manual pricing override was applied. Tracks frequency of human intervention in automated pricing."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for all monetary rate measures."
    - name: "property_id"
      expr: property_id
      comment: "Foreign key to the property dimension. Primary grouping key for property-level rate availability reporting."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Foreign key to the room type dimension. Enables rate availability analysis by room type."
    - name: "revenue_management_system"
      expr: revenue_management_system
      comment: "Name of the RMS that generated the rate recommendation. Enables RMS performance and adoption analysis."
  measures:
    - name: "avg_bar_rate"
      expr: AVG(CAST(bar_rate AS DOUBLE))
      comment: "Average Best Available Rate (BAR). Primary pricing KPI for rate strategy monitoring and competitive benchmarking."
    - name: "avg_rack_rate"
      expr: AVG(CAST(rack_rate AS DOUBLE))
      comment: "Average rack rate. Baseline published rate; used to calculate discount depth and rate integrity metrics."
    - name: "avg_min_rate"
      expr: AVG(CAST(min_rate AS DOUBLE))
      comment: "Average minimum rate floor across rate availability records. Monitors rate floor compliance and revenue protection."
    - name: "avg_max_rate"
      expr: AVG(CAST(max_rate AS DOUBLE))
      comment: "Average maximum rate ceiling across rate availability records. Monitors rate ceiling compliance and price cap adherence."
    - name: "avg_occupancy_forecast_pct"
      expr: AVG(CAST(occupancy_forecast_pct AS DOUBLE))
      comment: "Average forecasted occupancy percentage at the time of the rate snapshot. Contextualises pricing decisions against expected demand."
    - name: "stop_sell_record_count"
      expr: COUNT(CASE WHEN stop_sell = TRUE THEN 1 END)
      comment: "Count of rate availability records with stop-sell active. Tracks inventory closure frequency; high counts signal demand strength or overbooking risk."
    - name: "rate_parity_violation_count"
      expr: COUNT(CASE WHEN rate_parity_flag = FALSE THEN 1 END)
      comment: "Count of rate availability records with rate parity violations. Rate parity breaches risk brand damage and OTA contract penalties; zero is the target."
    - name: "pricing_override_count"
      expr: COUNT(CASE WHEN pricing_override_flag = TRUE THEN 1 END)
      comment: "Count of manual pricing overrides applied by revenue managers. High override rates indicate RMS recommendations are not trusted; triggers model review."
    - name: "total_rate_availability_records"
      expr: COUNT(1)
      comment: "Total count of rate availability records. Used to validate distribution coverage and identify gaps in rate loading across channels and room types."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_negotiated_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Negotiated rate portfolio KPIs covering contracted rate amounts, commission rates, and contract coverage. Used by sales, revenue management, and finance to manage corporate account rate agreements, GDS loading, and commission cost exposure."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`negotiated_rate`"
  dimensions:
    - name: "rate_type"
      expr: rate_type
      comment: "Type of negotiated rate (e.g. CORPORATE, CONSORTIA, GOVERNMENT, CREW). Enables rate portfolio analysis by contract category."
    - name: "rate_status"
      expr: rate_status
      comment: "Current status of the negotiated rate (e.g. ACTIVE, EXPIRED, PENDING_APPROVAL). Filters to active contracted rates."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the negotiated rate. Ensures only approved rates are included in official reporting."
    - name: "rate_loading_status"
      expr: rate_loading_status
      comment: "GDS/CRS loading status of the negotiated rate. Tracks whether contracted rates are live and bookable in distribution channels."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for all monetary negotiated rate measures."
    - name: "contract_start_date"
      expr: contract_start_date
      comment: "Start date of the negotiated rate contract. Used to track contract lifecycle and renewal pipeline."
    - name: "contract_end_date"
      expr: contract_end_date
      comment: "End date of the negotiated rate contract. Enables contract expiry monitoring and renewal forecasting."
    - name: "is_lra"
      expr: is_lra
      comment: "Boolean flag indicating a Last Room Available (LRA) rate. LRA rates have significant revenue management implications as they cannot be closed."
    - name: "is_non_refundable"
      expr: is_non_refundable
      comment: "Boolean flag indicating a non-refundable negotiated rate. Tracks non-refundable rate penetration in the contracted portfolio."
    - name: "breakfast_included"
      expr: breakfast_included
      comment: "Boolean flag indicating breakfast is included in the negotiated rate. Tracks inclusive rate penetration and F&B revenue implications."
    - name: "property_id"
      expr: property_id
      comment: "Foreign key to the property dimension. Primary grouping key for property-level negotiated rate portfolio reporting."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Foreign key to the market segment dimension. Enables negotiated rate analysis by market segment."
  measures:
    - name: "avg_negotiated_rate_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average negotiated rate amount across all active contracts. Benchmarks contracted rate levels against BAR and rack rate for rate integrity analysis."
    - name: "avg_commission_pct"
      expr: AVG(CAST(commission_pct AS DOUBLE))
      comment: "Average commission percentage across negotiated rate contracts. Tracks commission cost exposure in the contracted rate portfolio."
    - name: "avg_rate_bar_variance_pct"
      expr: AVG(CAST(rate_bar_variance_pct AS DOUBLE))
      comment: "Average variance between the negotiated rate and the Best Available Rate (BAR) as a percentage. Measures discount depth granted to corporate accounts."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN rate_status = 'ACTIVE' THEN 1 END)
      comment: "Count of active negotiated rate contracts. Tracks the size of the contracted rate portfolio; used in sales pipeline and account management reporting."
    - name: "lra_contract_count"
      expr: COUNT(CASE WHEN is_lra = TRUE THEN 1 END)
      comment: "Count of Last Room Available (LRA) negotiated rate contracts. LRA contracts constrain revenue management flexibility; high counts are a risk indicator."
    - name: "total_negotiated_rate_contracts"
      expr: COUNT(1)
      comment: "Total count of negotiated rate records. Used to assess contracted rate portfolio size and distribution coverage."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`revenue_dynamic_rate_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dynamic pricing rule KPIs covering rate adjustment values, rule trigger activity, and rate floor/ceiling compliance. Used by revenue managers and RMS administrators to monitor automated pricing rule performance, trigger frequency, and pricing guardrail adherence."
  source: "`vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule`"
  dimensions:
    - name: "rule_type"
      expr: rule_type
      comment: "Type of dynamic rate rule (e.g. DEMAND_BASED, PICKUP_BASED, COMPETITIVE). Enables analysis of pricing rule strategy mix."
    - name: "rule_status"
      expr: rule_status
      comment: "Current status of the dynamic rate rule (e.g. ACTIVE, INACTIVE, PENDING). Filters to active rules for operational monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the dynamic rate rule. Ensures only approved rules are included in production pricing analysis."
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of rate adjustment applied by the rule (e.g. PERCENTAGE, FIXED_AMOUNT). Distinguishes pricing rule mechanics."
    - name: "adjustment_direction"
      expr: adjustment_direction
      comment: "Direction of the rate adjustment (e.g. INCREASE, DECREASE). Tracks whether rules are predominantly driving rates up or down."
    - name: "is_stackable"
      expr: is_stackable
      comment: "Boolean flag indicating whether this rule can be combined with other rules. Non-stackable rules require careful priority management."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for monetary rule threshold and adjustment measures."
    - name: "effective_from"
      expr: effective_from
      comment: "Date from which the dynamic rate rule is effective. Used to track rule lifecycle and seasonal pricing strategy."
    - name: "effective_until"
      expr: effective_until
      comment: "Date until which the dynamic rate rule is effective."
    - name: "property_id"
      expr: property_id
      comment: "Foreign key to the property dimension. Primary grouping key for property-level dynamic pricing rule analysis."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Foreign key to the market segment dimension. Enables dynamic pricing rule analysis by market segment."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Foreign key to the room type dimension. Supports room-type-level dynamic pricing rule analysis."
  measures:
    - name: "avg_adjustment_value"
      expr: AVG(CAST(adjustment_value AS DOUBLE))
      comment: "Average rate adjustment value applied by dynamic pricing rules. Measures the typical magnitude of automated pricing changes; large values indicate aggressive dynamic pricing."
    - name: "avg_min_rate_floor"
      expr: AVG(CAST(min_rate_floor AS DOUBLE))
      comment: "Average minimum rate floor configured across dynamic rate rules. Monitors rate protection guardrails to prevent below-floor pricing."
    - name: "avg_max_rate_ceiling"
      expr: AVG(CAST(max_rate_ceiling AS DOUBLE))
      comment: "Average maximum rate ceiling configured across dynamic rate rules. Monitors rate cap guardrails to prevent price gouging and brand damage."
    - name: "avg_trigger_threshold_value"
      expr: AVG(CAST(trigger_threshold_value AS DOUBLE))
      comment: "Average trigger threshold value across dynamic rate rules. Benchmarks the demand/pickup sensitivity levels at which automated pricing activates."
    - name: "active_rule_count"
      expr: COUNT(CASE WHEN rule_status = 'ACTIVE' THEN 1 END)
      comment: "Count of active dynamic rate rules. Tracks the breadth of automated pricing coverage; used in RMS governance and audit reporting."
    - name: "total_dynamic_rate_rules"
      expr: COUNT(1)
      comment: "Total count of dynamic rate rule records. Used to assess the scale of the automated pricing rule library."
$$;