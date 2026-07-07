-- Metric views for domain: restaurant | Business: Restaurants | Version: 2 | Generated on: 2026-07-02 03:59:48

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_brand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic brand portfolio metrics covering market position, financial performance, and franchise economics. Used by brand leadership and executives to evaluate brand health, franchise attractiveness, and market penetration."
  source: "`vibe_restaurants_v1`.`restaurant`.`brand`"
  dimensions:
    - name: "brand_name"
      expr: name
      comment: "Brand display name for grouping and filtering brand-level KPIs."
    - name: "brand_segment"
      expr: segment
      comment: "Market segment (e.g., QSR, Fast Casual, Fine Dining) used to benchmark brand performance within competitive tiers."
    - name: "brand_category"
      expr: category
      comment: "Brand category classification (e.g., Burger, Pizza, Chicken) for cross-category performance comparison."
    - name: "brand_type"
      expr: brand_type
      comment: "Type of brand (e.g., corporate, franchise, licensed) to segment ownership model performance."
    - name: "brand_status"
      expr: brand_status
      comment: "Current lifecycle status of the brand (e.g., Active, Sunset, Pilot) for portfolio health monitoring."
    - name: "service_model"
      expr: service_model
      comment: "Service delivery model (e.g., dine-in, drive-thru, delivery-only) to analyze operational format performance."
    - name: "cuisine_type"
      expr: cuisine_type
      comment: "Cuisine classification for menu-driven segmentation and competitive benchmarking."
    - name: "positioning_segment"
      expr: positioning_segment
      comment: "Consumer positioning tier (e.g., value, premium, luxury) for strategic pricing and marketing analysis."
    - name: "headquarters_country_code"
      expr: headquarters_country_code
      comment: "Country of brand headquarters for geographic portfolio analysis."
    - name: "primary_market_region"
      expr: primary_market_region
      comment: "Primary geographic market region for regional brand performance comparison."
    - name: "franchise_allowed"
      expr: franchise_allowed
      comment: "Flag indicating whether the brand permits franchising, used to segment franchise vs. corporate-only brands."
    - name: "is_active"
      expr: is_active
      comment: "Active status flag to filter live brands from retired or archived entries."
    - name: "concept_type"
      expr: concept_type
      comment: "Concept classification (e.g., fast food, casual dining, ghost kitchen) for format-level strategic analysis."
    - name: "established_year"
      expr: YEAR(established_date)
      comment: "Year the brand was established, used for brand age cohort analysis and longevity benchmarking."
  measures:
    - name: "total_brands"
      expr: COUNT(1)
      comment: "Total number of brand records. Baseline measure for portfolio size tracking and brand count trend analysis."
    - name: "avg_annual_sales_usd"
      expr: AVG(CAST(average_annual_sales_usd AS DOUBLE))
      comment: "Average annual sales in USD across brands. Key revenue productivity indicator used by executives to benchmark brand financial performance."
    - name: "total_annual_sales_usd"
      expr: SUM(CAST(average_annual_sales_usd AS DOUBLE))
      comment: "Total aggregated annual sales across all brands in the portfolio. Used for portfolio-level revenue sizing and investment prioritization."
    - name: "avg_check_amount_usd"
      expr: AVG(CAST(average_check_amount_usd AS DOUBLE))
      comment: "Average customer check amount in USD. Critical pricing and consumer spending indicator used to evaluate brand value proposition and menu pricing strategy."
    - name: "avg_store_size_sqft"
      expr: AVG(CAST(average_store_size_sqft AS DOUBLE))
      comment: "Average store footprint in square feet. Used by real estate and operations teams to benchmark format size and inform new unit development standards."
    - name: "avg_market_share_pct"
      expr: AVG(CAST(market_share_percent AS DOUBLE))
      comment: "Average market share percentage across brands. Executive-level competitive positioning metric used in quarterly business reviews and strategic planning."
    - name: "avg_franchise_fee_pct"
      expr: AVG(CAST(franchise_fee_percent AS DOUBLE))
      comment: "Average franchise fee percentage. Used by franchise development teams to benchmark fee structures and evaluate franchise attractiveness vs. competitors."
    - name: "avg_royalty_fee_pct"
      expr: AVG(CAST(royalty_fee_percent AS DOUBLE))
      comment: "Average royalty fee percentage charged to franchisees. Key franchise economics metric used to assess ongoing revenue yield from franchise agreements."
    - name: "franchise_enabled_brand_count"
      expr: COUNT(CASE WHEN franchise_allowed = TRUE THEN 1 END)
      comment: "Count of brands that permit franchising. Used by franchise development leadership to size the franchisable portfolio and set expansion targets."
    - name: "active_brand_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active brands. Portfolio health KPI used to track live brand count vs. total portfolio size."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Restaurant unit operational and financial performance metrics. Core domain KPI view used by operations, real estate, and executive teams to evaluate unit-level health, throughput, quality, and growth."
  source: "`vibe_restaurants_v1`.`restaurant`.`unit`"
  dimensions:
    - name: "unit_city"
      expr: city
      comment: "City where the restaurant unit is located, used for geographic performance clustering and market analysis."
    - name: "unit_state_province"
      expr: state_province
      comment: "State or province of the unit for regional performance benchmarking and regulatory compliance tracking."
    - name: "unit_country_code"
      expr: country_code
      comment: "Country code for international portfolio segmentation and cross-market performance comparison."
    - name: "unit_ownership_model"
      expr: ownership_model
      comment: "Ownership model (e.g., corporate, franchise, licensed) to compare performance across operating structures."
    - name: "unit_concept_type"
      expr: concept_type
      comment: "Concept type (e.g., drive-thru only, dine-in, ghost kitchen) for format-level operational benchmarking."
    - name: "unit_daypart_schedule"
      expr: daypart_schedule
      comment: "Daypart operating schedule (e.g., breakfast, all-day) to analyze revenue and throughput by service window."
    - name: "has_online_ordering"
      expr: has_online_ordering
      comment: "Flag indicating digital ordering capability. Used to measure digital channel adoption and its impact on unit performance."
    - name: "has_third_party_delivery"
      expr: has_third_party_delivery
      comment: "Flag indicating third-party delivery integration. Used to assess delivery channel penetration and incremental revenue contribution."
    - name: "haccp_certified"
      expr: haccp_certified
      comment: "HACCP food safety certification status. Used by quality assurance teams to monitor compliance and food safety risk."
    - name: "opening_year"
      expr: YEAR(opening_date)
      comment: "Year the unit opened, used for unit vintage cohort analysis and new unit ramp performance tracking."
    - name: "last_inspection_year"
      expr: YEAR(last_inspection_date)
      comment: "Year of the most recent health inspection, used to identify units with stale inspection records."
    - name: "unit_postal_code"
      expr: postal_code
      comment: "Postal code for hyper-local trade area analysis and delivery radius optimization."
  measures:
    - name: "total_units"
      expr: COUNT(1)
      comment: "Total number of restaurant units. Baseline portfolio size metric used in executive dashboards and franchise development reporting."
    - name: "avg_unit_volume_usd"
      expr: AVG(CAST(average_unit_volume_usd AS DOUBLE))
      comment: "Average Unit Volume (AUV) in USD. Premier restaurant industry KPI used by executives to benchmark unit-level revenue productivity and set performance targets."
    - name: "total_unit_volume_usd"
      expr: SUM(CAST(average_unit_volume_usd AS DOUBLE))
      comment: "Total system-wide unit volume in USD. Portfolio-level revenue sizing metric used in investor reporting and strategic planning."
    - name: "avg_same_store_sales_pct"
      expr: AVG(CAST(same_store_sales_pct AS DOUBLE))
      comment: "Average same-store sales growth percentage. Critical comparable sales KPI used by executives and investors to measure organic growth excluding new unit openings."
    - name: "avg_health_inspection_score"
      expr: AVG(CAST(health_inspection_score AS DOUBLE))
      comment: "Average health inspection score across units. Food safety and brand protection KPI used by QA leadership to identify systemic compliance risks."
    - name: "avg_table_turn_rate"
      expr: AVG(CAST(table_turn_rate AS DOUBLE))
      comment: "Average table turn rate (covers per table per period). Throughput efficiency KPI used by operations to optimize seating utilization and revenue per seat."
    - name: "units_with_online_ordering"
      expr: COUNT(CASE WHEN has_online_ordering = TRUE THEN 1 END)
      comment: "Count of units with online ordering enabled. Digital channel adoption metric used to track digital transformation progress across the portfolio."
    - name: "units_with_third_party_delivery"
      expr: COUNT(CASE WHEN has_third_party_delivery = TRUE THEN 1 END)
      comment: "Count of units integrated with third-party delivery platforms. Delivery channel penetration metric used to assess off-premise revenue opportunity."
    - name: "haccp_certified_unit_count"
      expr: COUNT(CASE WHEN haccp_certified = TRUE THEN 1 END)
      comment: "Count of HACCP-certified units. Food safety compliance metric used by QA and regulatory teams to monitor certification coverage across the portfolio."
    - name: "avg_operational_status"
      expr: AVG(CAST(operational_status AS DOUBLE))
      comment: "Average operational status score across units. Operational readiness KPI used to identify underperforming or at-risk units requiring intervention."
    - name: "digital_channel_adoption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN has_online_ordering = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of units with online ordering enabled. Digital adoption rate KPI used by technology and marketing leadership to track digital channel rollout progress."
    - name: "delivery_channel_penetration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN has_third_party_delivery = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of units integrated with third-party delivery. Off-premise channel penetration rate used to evaluate delivery strategy execution and incremental revenue coverage."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_equipment_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Restaurant equipment asset lifecycle, cost, and compliance metrics. Used by facilities, operations, and finance teams to manage capital asset health, maintenance efficiency, and compliance risk."
  source: "`vibe_restaurants_v1`.`restaurant`.`equipment_asset`"
  dimensions:
    - name: "equipment_category"
      expr: equipment_category
      comment: "Category of equipment (e.g., refrigeration, cooking, POS) for asset class-level performance and cost analysis."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Specific equipment type for granular maintenance and replacement planning."
    - name: "equipment_name"
      expr: equipment_name
      comment: "Equipment name for asset-level identification and reporting."
    - name: "manufacturer_name"
      expr: manufacturer_name
      comment: "Equipment manufacturer for vendor performance analysis and procurement decision-making."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Asset ownership type (e.g., owned, leased) to segment capital vs. operating expense obligations."
    - name: "asset_condition_rating"
      expr: asset_condition_rating
      comment: "Current condition rating of the asset (e.g., Good, Fair, Poor) for prioritizing replacement and maintenance investment."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied to the asset for financial reporting and tax planning segmentation."
    - name: "energy_rating"
      expr: energy_rating
      comment: "Energy efficiency rating of the equipment for sustainability reporting and utility cost management."
    - name: "temperature_critical_flag"
      expr: temperature_critical_flag
      comment: "Flag for temperature-critical equipment (e.g., walk-in coolers, freezers). Used to prioritize maintenance and compliance monitoring for food safety risk."
    - name: "location_zone"
      expr: location_zone
      comment: "Physical zone within the restaurant where the asset is located, used for zone-level maintenance planning."
    - name: "installation_year"
      expr: YEAR(installation_date)
      comment: "Year of equipment installation for asset age cohort analysis and replacement cycle planning."
    - name: "last_service_year"
      expr: YEAR(last_service_date)
      comment: "Year of last service event to identify assets with overdue maintenance."
  measures:
    - name: "total_equipment_assets"
      expr: COUNT(1)
      comment: "Total count of equipment assets. Baseline asset inventory metric used by facilities and finance teams for capital planning."
    - name: "total_acquisition_cost_usd"
      expr: SUM(CAST(acquisition_cost_usd AS DOUBLE))
      comment: "Total capital invested in equipment assets. Core CapEx metric used by finance and operations leadership for asset investment tracking and budget planning."
    - name: "avg_acquisition_cost_usd"
      expr: AVG(CAST(acquisition_cost_usd AS DOUBLE))
      comment: "Average acquisition cost per equipment asset. Used by procurement teams to benchmark unit costs and negotiate vendor contracts."
    - name: "total_replacement_cost_usd"
      expr: SUM(CAST(replacement_cost_usd AS DOUBLE))
      comment: "Total current replacement value of the equipment portfolio. Critical for insurance coverage adequacy assessment and capital reserve planning."
    - name: "avg_replacement_cost_usd"
      expr: AVG(CAST(replacement_cost_usd AS DOUBLE))
      comment: "Average replacement cost per asset. Used to prioritize high-value asset maintenance and inform replacement vs. repair decisions."
    - name: "temperature_critical_asset_count"
      expr: COUNT(CASE WHEN temperature_critical_flag = TRUE THEN 1 END)
      comment: "Count of temperature-critical assets. Food safety risk metric used by QA and facilities teams to ensure adequate monitoring and maintenance coverage."
    - name: "avg_operational_status_score"
      expr: AVG(CAST(operational_status AS DOUBLE))
      comment: "Average operational status score across equipment assets. Fleet health KPI used by facilities management to identify systemic equipment degradation and plan proactive maintenance."
    - name: "replacement_cost_to_acquisition_ratio"
      expr: ROUND(SUM(CAST(replacement_cost_usd AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost_usd AS DOUBLE)), 0), 4)
      comment: "Ratio of total replacement cost to original acquisition cost. Asset inflation and aging indicator used by finance to assess capital reserve adequacy and replacement budget requirements."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_kitchen_station`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Kitchen station throughput, capacity, and operational efficiency metrics. Used by operations and culinary leadership to optimize kitchen layout, staffing, and speed-of-service performance."
  source: "`vibe_restaurants_v1`.`restaurant`.`kitchen_station`"
  dimensions:
    - name: "station_type"
      expr: station_type
      comment: "Type of kitchen station (e.g., grill, fry, prep, expo) for station-class performance benchmarking."
    - name: "station_name"
      expr: station_name
      comment: "Station name for granular operational reporting and station-level performance tracking."
    - name: "station_status"
      expr: station_status
      comment: "Current operational status of the station for real-time and trend-based availability monitoring."
    - name: "kitchen_station_status"
      expr: kitchen_station_status
      comment: "Lifecycle status of the kitchen station record for filtering active vs. decommissioned stations."
    - name: "is_active"
      expr: is_active
      comment: "Active flag to filter currently operational stations from historical or inactive records."
    - name: "is_automated"
      expr: is_automated
      comment: "Flag indicating automation level of the station. Used to compare throughput and labor efficiency between automated and manual stations."
    - name: "temperature_control"
      expr: temperature_control
      comment: "Flag indicating whether the station has temperature control. Used for food safety compliance and HACCP monitoring."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone classification (e.g., hot, cold, ambient) for food safety and energy management analysis."
    - name: "daypart_schedule"
      expr: daypart_schedule
      comment: "Daypart schedule assigned to the station for throughput analysis by service period."
    - name: "routing_priority"
      expr: routing_priority
      comment: "Order routing priority level for the station, used to analyze bottleneck risk and ticket flow optimization."
    - name: "health_inspection_status"
      expr: health_inspection_status
      comment: "Most recent health inspection outcome for the station. Food safety compliance KPI dimension."
    - name: "effective_from_year"
      expr: YEAR(effective_from)
      comment: "Year the station configuration became effective, used for vintage analysis of station setups."
  measures:
    - name: "total_kitchen_stations"
      expr: COUNT(1)
      comment: "Total number of kitchen stations. Baseline capacity metric used by operations to track kitchen infrastructure scale."
    - name: "active_station_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active kitchen stations. Operational capacity metric used to assess live kitchen throughput capacity."
    - name: "automated_station_count"
      expr: COUNT(CASE WHEN is_automated = TRUE THEN 1 END)
      comment: "Count of automated kitchen stations. Technology adoption metric used by operations leadership to track kitchen automation investment and its throughput impact."
    - name: "automation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_automated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of kitchen stations that are automated. Strategic KPI used by operations and technology leadership to benchmark automation adoption and labor efficiency gains."
    - name: "total_station_area_sqft"
      expr: SUM(CAST(area_sqft AS DOUBLE))
      comment: "Total kitchen station floor area in square feet. Capacity planning metric used by facilities and culinary design teams to optimize kitchen layout and space utilization."
    - name: "avg_station_area_sqft"
      expr: AVG(CAST(area_sqft AS DOUBLE))
      comment: "Average kitchen station area in square feet. Used to benchmark station sizing against throughput capacity and identify space optimization opportunities."
    - name: "avg_operational_hours"
      expr: AVG(CAST(operational_hours AS DOUBLE))
      comment: "Average operational hours per kitchen station. Utilization metric used to identify underutilized stations and optimize staffing schedules."
    - name: "avg_power_rating_kw"
      expr: AVG(CAST(power_rating_kw AS DOUBLE))
      comment: "Average power consumption rating in kilowatts per station. Energy management KPI used by facilities to benchmark energy intensity and identify efficiency improvement opportunities."
    - name: "total_power_consumption_kw"
      expr: SUM(CAST(power_rating_kw AS DOUBLE))
      comment: "Total power consumption across all kitchen stations in kilowatts. Used by facilities and sustainability teams to assess energy footprint and set reduction targets."
    - name: "temperature_controlled_station_count"
      expr: COUNT(CASE WHEN temperature_control = TRUE THEN 1 END)
      comment: "Count of stations with active temperature control. Food safety compliance metric used by QA teams to ensure adequate temperature-controlled capacity."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_pos_terminal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Point-of-sale terminal fleet metrics covering payment capability, compliance, and technology adoption. Used by IT, operations, and finance teams to manage PCI compliance risk, payment channel coverage, and terminal lifecycle."
  source: "`vibe_restaurants_v1`.`restaurant`.`pos_terminal`"
  dimensions:
    - name: "terminal_type"
      expr: terminal_type
      comment: "Type of POS terminal (e.g., counter, kiosk, handheld) for format-level technology analysis."
    - name: "station_type"
      expr: station_type
      comment: "Station assignment type for the terminal, used to analyze payment capability by service station."
    - name: "service_channel"
      expr: service_channel
      comment: "Service channel the terminal supports (e.g., dine-in, drive-thru, delivery) for channel-level payment analytics."
    - name: "pos_terminal_status"
      expr: pos_terminal_status
      comment: "Current lifecycle status of the terminal (e.g., Active, Decommissioned, Under Maintenance) for fleet health monitoring."
    - name: "pci_compliance_status"
      expr: pci_compliance_status
      comment: "PCI DSS compliance status of the terminal. Critical payment security dimension used by IT and compliance teams to manage regulatory risk."
    - name: "network_type"
      expr: network_type
      comment: "Network connectivity type (e.g., wired, WiFi, cellular) for infrastructure reliability analysis."
    - name: "payment_processing_vendor"
      expr: payment_processing_vendor
      comment: "Payment processor vendor for vendor concentration risk analysis and contract management."
    - name: "manufacturer"
      expr: manufacturer
      comment: "Terminal hardware manufacturer for vendor performance benchmarking and procurement decisions."
    - name: "is_active"
      expr: is_active
      comment: "Active status flag to filter live terminals from decommissioned or inactive records."
    - name: "supports_contactless"
      expr: supports_contactless
      comment: "Flag indicating contactless payment support. Digital payment adoption dimension used to track modern payment capability rollout."
    - name: "supports_mobile_wallet"
      expr: supports_mobile_wallet
      comment: "Flag indicating mobile wallet support (e.g., Apple Pay, Google Pay). Used to measure digital wallet adoption across the terminal fleet."
    - name: "installation_year"
      expr: YEAR(installation_date)
      comment: "Year of terminal installation for fleet age cohort analysis and refresh cycle planning."
  measures:
    - name: "total_pos_terminals"
      expr: COUNT(1)
      comment: "Total POS terminal count. Baseline fleet size metric used by IT and operations for infrastructure planning and coverage analysis."
    - name: "active_terminal_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active POS terminals. Operational fleet availability metric used to ensure adequate payment processing capacity."
    - name: "pci_compliant_terminal_count"
      expr: COUNT(CASE WHEN pci_compliance_status = 'Compliant' THEN 1 END)
      comment: "Count of PCI-compliant terminals. Payment security compliance metric used by IT and risk teams to monitor regulatory exposure and remediation progress."
    - name: "pci_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pci_compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminals meeting PCI DSS compliance. Critical payment security KPI used by CISO and compliance leadership to manage regulatory risk and avoid penalties."
    - name: "contactless_capable_terminal_count"
      expr: COUNT(CASE WHEN supports_contactless = TRUE THEN 1 END)
      comment: "Count of terminals supporting contactless payments. Digital payment readiness metric used by operations and marketing to assess modern payment channel coverage."
    - name: "contactless_adoption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN supports_contactless = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminals with contactless payment capability. Technology modernization KPI used to track payment innovation rollout and guest experience improvement."
    - name: "mobile_wallet_adoption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN supports_mobile_wallet = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminals supporting mobile wallet payments. Digital payment adoption KPI used by technology and marketing leadership to measure fintech readiness."
    - name: "avg_operational_status_score"
      expr: AVG(CAST(operational_status AS DOUBLE))
      comment: "Average operational status score across POS terminals. Fleet health KPI used by IT operations to identify degraded terminals requiring maintenance or replacement."
    - name: "third_party_delivery_capable_count"
      expr: COUNT(CASE WHEN supports_third_party_delivery = TRUE THEN 1 END)
      comment: "Count of terminals integrated with third-party delivery platforms. Off-premise channel readiness metric used to assess delivery technology coverage across the fleet."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_operating_hours`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Restaurant operating hours and scheduling metrics. Used by operations and revenue management teams to analyze service window coverage, throughput capacity, and scheduling efficiency across dayparts and days of week."
  source: "`vibe_restaurants_v1`.`restaurant`.`operating_hours`"
  dimensions:
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week for the schedule record. Used to analyze operating hour patterns and throughput capacity by day."
    - name: "daypart"
      expr: daypart
      comment: "Daypart classification (e.g., Breakfast, Lunch, Dinner, Late Night) for revenue and throughput analysis by service period."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of schedule (e.g., Regular, Holiday, Special Event) to segment standard vs. exception operating patterns."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the schedule record (e.g., Active, Expired, Pending) for filtering live schedules."
    - name: "is_closed"
      expr: is_closed
      comment: "Flag indicating the unit is closed during this schedule period. Used to measure closure frequency and its revenue impact."
    - name: "holiday_schedule_override_flag"
      expr: holiday_schedule_override_flag
      comment: "Flag for holiday schedule overrides. Used to analyze holiday operating patterns and their effect on throughput and revenue."
    - name: "seasonal_adjustment_flag"
      expr: seasonal_adjustment_flag
      comment: "Flag for seasonal schedule adjustments. Used to identify seasonal operating patterns and plan staffing and inventory accordingly."
    - name: "seasonal_period_name"
      expr: seasonal_period_name
      comment: "Name of the seasonal period (e.g., Summer, Holiday Season) for seasonal performance benchmarking."
    - name: "holiday_name"
      expr: holiday_name
      comment: "Name of the holiday associated with a schedule override. Used for holiday-specific performance analysis."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the schedule became effective for temporal trend analysis of operating hour changes."
  measures:
    - name: "total_schedule_records"
      expr: COUNT(1)
      comment: "Total operating schedule records. Baseline measure for schedule coverage analysis across units and time periods."
    - name: "closed_period_count"
      expr: COUNT(CASE WHEN is_closed = TRUE THEN 1 END)
      comment: "Count of scheduled closure periods. Revenue risk metric used by operations to monitor unplanned and planned closures and their impact on sales."
    - name: "holiday_override_count"
      expr: COUNT(CASE WHEN holiday_schedule_override_flag = TRUE THEN 1 END)
      comment: "Count of holiday schedule overrides. Used by operations to assess holiday scheduling complexity and ensure adequate staffing and inventory planning."
    - name: "avg_expected_table_turns"
      expr: AVG(CAST(expected_table_turn_count AS DOUBLE))
      comment: "Average expected table turn count per schedule period. Throughput planning KPI used by operations to set revenue targets and staffing levels by daypart."
    - name: "total_expected_table_turns"
      expr: SUM(CAST(expected_table_turn_count AS DOUBLE))
      comment: "Total expected table turns across all schedule periods. Aggregate throughput capacity metric used for revenue forecasting and capacity planning."
    - name: "closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_closed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scheduled periods where the unit is closed. Operational availability KPI used to identify units with high closure frequency and associated revenue loss risk."
    - name: "seasonal_schedule_count"
      expr: COUNT(CASE WHEN seasonal_adjustment_flag = TRUE THEN 1 END)
      comment: "Count of schedule records with seasonal adjustments. Used by operations and workforce planning teams to quantify seasonal scheduling complexity."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_brand_standard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand standard compliance and governance metrics. Used by quality assurance, operations, and brand leadership to monitor standard coverage, certification requirements, and compliance risk across the brand portfolio."
  source: "`vibe_restaurants_v1`.`restaurant`.`brand_standard`"
  dimensions:
    - name: "standard_category"
      expr: standard_category
      comment: "Category of the brand standard (e.g., Food Safety, Guest Experience, Operations) for compliance analysis by domain."
    - name: "brand_standard_status"
      expr: brand_standard_status
      comment: "Current status of the brand standard (e.g., Active, Superseded, Draft) for filtering live vs. retired standards."
    - name: "compliance_requirement_level"
      expr: compliance_requirement_level
      comment: "Compliance requirement level (e.g., Mandatory, Recommended, Optional) to prioritize enforcement and audit focus."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the standard for risk-based compliance monitoring and resource allocation."
    - name: "applicable_format"
      expr: applicable_format
      comment: "Restaurant format the standard applies to (e.g., Drive-Thru, Dine-In, Delivery) for format-specific compliance tracking."
    - name: "applicable_ownership_model"
      expr: applicable_ownership_model
      comment: "Ownership model the standard applies to (e.g., Corporate, Franchise) for ownership-specific compliance analysis."
    - name: "certification_required_flag"
      expr: certification_required_flag
      comment: "Flag indicating whether certification is required for this standard. Used to identify high-stakes compliance obligations."
    - name: "guest_facing_flag"
      expr: guest_facing_flag
      comment: "Flag indicating whether the standard directly impacts guest experience. Used to prioritize guest-facing compliance investments."
    - name: "training_required_flag"
      expr: training_required_flag
      comment: "Flag indicating whether training is required for this standard. Used by L&D teams to scope training program requirements."
    - name: "audit_frequency"
      expr: audit_frequency
      comment: "Frequency of audits for this standard (e.g., Monthly, Quarterly, Annual) for audit scheduling and resource planning."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure compliance (e.g., Observation, Audit, Self-Assessment) for methodology-level analysis."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the standard became effective for temporal analysis of standard evolution and compliance burden trends."
  measures:
    - name: "total_brand_standards"
      expr: COUNT(1)
      comment: "Total number of brand standards. Baseline compliance portfolio metric used by QA leadership to track the scope of brand governance obligations."
    - name: "certification_required_count"
      expr: COUNT(CASE WHEN certification_required_flag = TRUE THEN 1 END)
      comment: "Count of standards requiring formal certification. Compliance risk metric used by QA and legal teams to prioritize certification management and avoid regulatory penalties."
    - name: "guest_facing_standard_count"
      expr: COUNT(CASE WHEN guest_facing_flag = TRUE THEN 1 END)
      comment: "Count of guest-facing brand standards. Brand experience metric used by operations and marketing leadership to quantify the standards directly impacting customer satisfaction."
    - name: "training_required_standard_count"
      expr: COUNT(CASE WHEN training_required_flag = TRUE THEN 1 END)
      comment: "Count of standards requiring employee training. L&D investment sizing metric used to scope training program requirements and budget."
    - name: "avg_target_metric_value"
      expr: AVG(CAST(target_metric_value AS DOUBLE))
      comment: "Average target metric value across brand standards. Used by QA teams to benchmark performance targets and identify standards with outlier expectations."
    - name: "certification_requirement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of brand standards requiring formal certification. Compliance burden KPI used by QA leadership to assess regulatory complexity and prioritize certification resources."
    - name: "guest_facing_standard_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN guest_facing_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of brand standards that are guest-facing. Brand experience investment ratio used to evaluate how much of the compliance portfolio directly drives customer satisfaction."
$$;