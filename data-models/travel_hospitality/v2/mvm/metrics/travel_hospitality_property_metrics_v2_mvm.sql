-- Metric views for domain: property | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-07-10 22:17:24

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the property master entity. Tracks portfolio composition, operational status, brand distribution, and physical capacity attributes used by asset management, development, and executive leadership."
  source: "`vibe_travel_hospitality_v1`.`property`.`property`"
  dimensions:
    - name: "property_type"
      expr: property_type
      comment: "Classification of the property (e.g. full-service hotel, resort, select-service) used to segment portfolio performance."
    - name: "brand_name"
      expr: brand_name
      comment: "Brand under which the property operates, enabling brand-level portfolio and performance analysis."
    - name: "brand_tier"
      expr: brand_tier
      comment: "Tier classification of the brand (e.g. luxury, upper-upscale, midscale) for strategic segmentation."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational state of the property (e.g. open, closed, under renovation) for active portfolio tracking."
    - name: "country_code"
      expr: country_code
      comment: "Country where the property is located, enabling geographic portfolio analysis."
    - name: "segment_classification"
      expr: segment_classification
      comment: "Market segment classification assigned to the property for revenue strategy segmentation."
    - name: "is_franchised"
      expr: is_franchised
      comment: "Indicates whether the property operates under a franchise agreement, distinguishing managed vs. franchised portfolio."
    - name: "pip_status"
      expr: pip_status
      comment: "Property Improvement Plan status, indicating capital investment pipeline stage."
    - name: "opening_date_month"
      expr: DATE_TRUNC('month', opening_date)
      comment: "Month the property opened, used for cohort and vintage analysis of portfolio growth."
    - name: "last_renovation_date_year"
      expr: YEAR(last_renovation_date)
      comment: "Year of last renovation, used to assess asset age and capital reinvestment cycles."
  measures:
    - name: "total_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Total number of distinct properties in the portfolio. Core portfolio size KPI used in executive dashboards and investor reporting."
    - name: "total_room_inventory"
      expr: SUM(CAST(total_room_count AS BIGINT))
      comment: "Total room inventory across all properties. Fundamental capacity metric used for RevPAR denominator calculations and portfolio scale assessment."
    - name: "total_suite_inventory"
      expr: SUM(CAST(total_suite_count AS BIGINT))
      comment: "Total suite inventory across the portfolio. Tracks premium room mix, which drives ADR and revenue quality."
    - name: "avg_star_rating"
      expr: AVG(CAST(star_rating AS DOUBLE))
      comment: "Average star rating across properties. Indicates overall portfolio quality positioning and brand standard compliance."
    - name: "total_meeting_space_sqft"
      expr: SUM(CAST(total_meeting_space_sqft AS DOUBLE))
      comment: "Total meeting and event space square footage across the portfolio. Drives group and MICE revenue capacity planning."
    - name: "franchised_property_count"
      expr: COUNT(DISTINCT CASE WHEN is_franchised = TRUE THEN property_id END)
      comment: "Number of franchised properties. Used to track franchise vs. managed split for fee income and brand governance reporting."
    - name: "active_property_count"
      expr: COUNT(DISTINCT CASE WHEN operational_status = 'open' THEN property_id END)
      comment: "Number of currently open and operational properties. Baseline for all operational KPI denominators."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_seasonal_calendar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue strategy and demand planning KPI layer over the seasonal calendar. Tracks estimated performance, demand classification, blackout periods, and year-over-year trends used by revenue management and commercial leadership."
  source: "`vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`"
  dimensions:
    - name: "season_name"
      expr: season_name
      comment: "Named season (e.g. Peak Summer, Holiday, Shoulder) for demand pattern segmentation."
    - name: "season_year"
      expr: season_year
      comment: "Calendar year of the season, enabling year-over-year comparison of demand and revenue estimates."
    - name: "demand_classification"
      expr: demand_classification
      comment: "Demand tier assigned to the period (e.g. high, medium, low) used for pricing strategy and staffing decisions."
    - name: "operating_status"
      expr: operating_status
      comment: "Operational status of the property during this calendar period (e.g. open, reduced, closed)."
    - name: "is_blackout_date"
      expr: is_blackout_date
      comment: "Flags periods where rate restrictions or blackout rules apply, critical for distribution and channel management."
    - name: "is_holiday_period"
      expr: is_holiday_period
      comment: "Identifies holiday periods which typically exhibit distinct demand and pricing behavior."
    - name: "competitive_set_position"
      expr: competitive_set_position
      comment: "Property's competitive positioning within its STR comp set during this period, used for market share strategy."
    - name: "start_date_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the seasonal period begins, used for time-series demand and revenue trend analysis."
    - name: "yoy_demand_trend"
      expr: yoy_demand_trend
      comment: "Year-over-year demand trend direction (e.g. up, flat, down) for forward-looking revenue strategy."
    - name: "seasonal_hiring_required"
      expr: seasonal_hiring_required
      comment: "Indicates whether additional seasonal staffing is required, linking revenue planning to workforce management."
  measures:
    - name: "avg_estimated_adr"
      expr: AVG(CAST(estimated_adr AS DOUBLE))
      comment: "Average estimated Average Daily Rate across seasonal calendar periods. Core revenue strategy KPI used to validate pricing assumptions and set rate floors/ceilings."
    - name: "avg_estimated_occupancy_pct"
      expr: AVG(CAST(estimated_occupancy_pct AS DOUBLE))
      comment: "Average estimated occupancy percentage across periods. Fundamental demand planning metric used to size staffing, F&B, and operational resources."
    - name: "avg_estimated_revpar"
      expr: AVG(CAST(estimated_revpar AS DOUBLE))
      comment: "Average estimated RevPAR (Revenue Per Available Room) across seasonal periods. The primary hotel revenue efficiency KPI used in executive and investor reporting."
    - name: "avg_rgi_target"
      expr: AVG(CAST(rgi_target AS DOUBLE))
      comment: "Average Revenue Generation Index target across periods. Measures competitive revenue performance ambition relative to the comp set."
    - name: "avg_cancellation_rate_pct"
      expr: AVG(CAST(cancellation_rate_pct AS DOUBLE))
      comment: "Average expected cancellation rate across seasonal periods. Drives overbooking strategy and net revenue forecasting accuracy."
    - name: "avg_no_show_rate_pct"
      expr: AVG(CAST(no_show_rate_pct AS DOUBLE))
      comment: "Average expected no-show rate across seasonal periods. Used alongside cancellation rate to calibrate overbooking policies and protect revenue."
    - name: "avg_yoy_demand_variance_pct"
      expr: AVG(CAST(yoy_demand_variance_pct AS DOUBLE))
      comment: "Average year-over-year demand variance percentage. Quantifies demand momentum and informs forward pricing and capacity decisions."
    - name: "blackout_period_count"
      expr: COUNT(DISTINCT CASE WHEN is_blackout_date = TRUE THEN seasonal_calendar_id END)
      comment: "Number of blackout date periods defined. Tracks distribution restriction coverage and revenue protection strategy deployment."
    - name: "total_seasonal_periods"
      expr: COUNT(DISTINCT seasonal_calendar_id)
      comment: "Total number of seasonal calendar periods defined. Baseline measure for coverage completeness of the revenue planning calendar."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and revenue KPI layer over property facilities. Tracks facility capacity utilization, fee-based revenue potential, compliance status, and operational readiness used by asset management and operations leadership."
  source: "`vibe_travel_hospitality_v1`.`property`.`facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (e.g. pool, gym, spa, parking) for category-level operational and revenue analysis."
    - name: "property_facility_status"
      expr: property_facility_status
      comment: "Current operational status of the facility (e.g. open, closed, under renovation) for active asset tracking."
    - name: "is_fee_based"
      expr: is_fee_based
      comment: "Indicates whether the facility charges a usage fee, distinguishing revenue-generating from complimentary amenities."
    - name: "is_ada_compliant"
      expr: is_ada_compliant
      comment: "ADA compliance flag for regulatory reporting and risk management."
    - name: "renovation_status"
      expr: renovation_status
      comment: "Current renovation status of the facility, used for capital project tracking and operational impact assessment."
    - name: "outdoor_indoor"
      expr: outdoor_indoor
      comment: "Indicates whether the facility is indoor or outdoor, relevant for seasonal operations planning."
    - name: "is_seasonal"
      expr: is_seasonal
      comment: "Flags facilities with seasonal operating windows, impacting staffing and revenue availability planning."
    - name: "category"
      expr: facility_category
      comment: "Broader category grouping of the facility for portfolio-level amenity analysis."
  measures:
    - name: "total_facilities"
      expr: COUNT(DISTINCT facility_id)
      comment: "Total number of distinct facilities across the portfolio. Baseline amenity inventory metric for asset and brand standard compliance."
    - name: "total_facility_area_sqft"
      expr: SUM(CAST(area_sqft AS DOUBLE))
      comment: "Total physical area of all facilities in square feet. Drives asset valuation, maintenance cost planning, and capacity benchmarking."
    - name: "avg_max_occupancy_pct"
      expr: AVG(CAST(max_occupancy_pct AS DOUBLE))
      comment: "Average maximum occupancy percentage across facilities. Indicates design utilization ceiling and informs capacity management decisions."
    - name: "total_usage_fee_revenue_potential"
      expr: SUM(CAST(usage_fee_amount AS DOUBLE))
      comment: "Sum of usage fee amounts across fee-based facilities. Represents ancillary revenue potential from facility monetization."
    - name: "fee_based_facility_count"
      expr: COUNT(DISTINCT CASE WHEN is_fee_based = TRUE THEN facility_id END)
      comment: "Number of facilities that charge a usage fee. Tracks ancillary revenue asset count and monetization strategy coverage."
    - name: "ada_compliant_facility_count"
      expr: COUNT(DISTINCT CASE WHEN is_ada_compliant = TRUE THEN facility_id END)
      comment: "Number of ADA-compliant facilities. Used for regulatory compliance reporting and risk exposure quantification."
    - name: "facilities_under_renovation_count"
      expr: COUNT(DISTINCT CASE WHEN renovation_status = 'in_progress' THEN facility_id END)
      comment: "Number of facilities currently under renovation. Tracks operational disruption and capital deployment progress."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_meeting_space`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group and MICE (Meetings, Incentives, Conferences, Exhibitions) revenue capacity KPI layer over meeting spaces. Tracks space inventory, capacity configurations, revenue minimums, and compliance used by group sales and revenue management."
  source: "`vibe_travel_hospitality_v1`.`property`.`meeting_space`"
  dimensions:
    - name: "space_type"
      expr: space_type
      comment: "Type of meeting space (e.g. ballroom, boardroom, breakout) for segment-level group revenue analysis."
    - name: "meeting_space_status"
      expr: meeting_space_status
      comment: "Current operational status of the meeting space (e.g. active, closed, under renovation)."
    - name: "divisible"
      expr: divisible
      comment: "Indicates whether the space can be divided into sections, affecting flexible capacity and multi-event booking potential."
    - name: "accessibility_compliant"
      expr: accessibility_compliant
      comment: "ADA/accessibility compliance flag for regulatory reporting and inclusive event capability."
    - name: "wifi_available"
      expr: wifi_available
      comment: "Indicates WiFi availability, a key qualifier for corporate and technology-driven event bookings."
    - name: "natural_light_available"
      expr: natural_light_available
      comment: "Indicates natural light availability, a premium feature that influences group booking preference and pricing."
    - name: "floor_level"
      expr: floor_level
      comment: "Floor level of the meeting space, relevant for accessibility and prestige positioning in group sales."
  measures:
    - name: "total_meeting_spaces"
      expr: COUNT(DISTINCT meeting_space_id)
      comment: "Total number of distinct meeting spaces in the portfolio. Core group sales capacity inventory metric."
    - name: "total_meeting_space_sqft"
      expr: SUM(CAST(total_square_footage AS DOUBLE))
      comment: "Total square footage of all meeting spaces. Primary capacity metric for group revenue potential and competitive positioning."
    - name: "avg_ceiling_height_feet"
      expr: AVG(CAST(ceiling_height_feet AS DOUBLE))
      comment: "Average ceiling height across meeting spaces. Influences suitability for large-format events and production setups, affecting group revenue mix."
    - name: "total_minimum_catering_spend"
      expr: SUM(CAST(minimum_catering_spend AS DOUBLE))
      comment: "Sum of minimum catering spend requirements across all meeting spaces. Represents the guaranteed F&B revenue floor from group bookings."
    - name: "avg_minimum_rental_hours"
      expr: AVG(CAST(minimum_rental_hours AS DOUBLE))
      comment: "Average minimum rental hour requirement across meeting spaces. Informs group booking policy and revenue yield per event."
    - name: "avg_entrance_width_inches"
      expr: AVG(CAST(entrance_width_inches AS DOUBLE))
      comment: "Average entrance width across meeting spaces. Operational metric for load-in logistics and accessibility compliance assessment."
    - name: "divisible_space_count"
      expr: COUNT(DISTINCT CASE WHEN divisible = TRUE THEN meeting_space_id END)
      comment: "Number of divisible meeting spaces. Tracks flexible inventory that can accommodate simultaneous multi-group bookings, maximizing revenue density."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_outlet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "F&B and ancillary outlet performance KPI layer over property outlets. Tracks outlet inventory, revenue potential, service capabilities, and operational status used by F&B leadership and commercial strategy teams."
  source: "`vibe_travel_hospitality_v1`.`property`.`property_outlet`"
  dimensions:
    - name: "outlet_type"
      expr: outlet_type
      comment: "Type of outlet (e.g. restaurant, bar, cafe, room service) for category-level F&B revenue analysis."
    - name: "outlet_status"
      expr: outlet_status
      comment: "Current operational status of the outlet (e.g. open, closed, seasonal) for active revenue asset tracking."
    - name: "cuisine_type"
      expr: cuisine_type
      comment: "Cuisine category of the outlet, used for F&B portfolio diversity and guest experience analysis."
    - name: "alcohol_service_flag"
      expr: alcohol_service_flag
      comment: "Indicates whether the outlet serves alcohol, a key driver of average check and revenue per cover."
    - name: "loyalty_points_eligible_flag"
      expr: loyalty_points_eligible_flag
      comment: "Indicates whether purchases at this outlet earn loyalty points, affecting guest engagement and repeat visit behavior."
    - name: "seasonal_operation_flag"
      expr: seasonal_operation_flag
      comment: "Flags outlets with seasonal operating windows, impacting annual revenue availability and staffing plans."
    - name: "mobile_ordering_enabled_flag"
      expr: mobile_ordering_enabled_flag
      comment: "Indicates mobile ordering capability, a digital revenue channel enablement metric."
    - name: "opening_date_year"
      expr: YEAR(opening_date)
      comment: "Year the outlet opened, used for vintage analysis of F&B portfolio performance and investment returns."
  measures:
    - name: "total_outlets"
      expr: COUNT(DISTINCT property_outlet_id)
      comment: "Total number of distinct F&B and ancillary outlets across the portfolio. Core F&B inventory metric for capacity and revenue potential assessment."
    - name: "avg_average_check_amount"
      expr: AVG(CAST(average_check_amount AS DOUBLE))
      comment: "Average check amount across outlets. Key F&B revenue efficiency metric used to benchmark outlet performance and pricing strategy."
    - name: "avg_service_charge_percentage"
      expr: AVG(CAST(service_charge_percentage AS DOUBLE))
      comment: "Average service charge percentage across outlets. Impacts total revenue capture and guest price perception."
    - name: "alcohol_serving_outlet_count"
      expr: COUNT(DISTINCT CASE WHEN alcohol_service_flag = TRUE THEN property_outlet_id END)
      comment: "Number of outlets licensed to serve alcohol. Tracks high-margin beverage revenue asset count across the portfolio."
    - name: "mobile_ordering_outlet_count"
      expr: COUNT(DISTINCT CASE WHEN mobile_ordering_enabled_flag = TRUE THEN property_outlet_id END)
      comment: "Number of outlets with mobile ordering enabled. Measures digital channel penetration in F&B, a key operational efficiency and revenue growth lever."
    - name: "loyalty_eligible_outlet_count"
      expr: COUNT(DISTINCT CASE WHEN loyalty_points_eligible_flag = TRUE THEN property_outlet_id END)
      comment: "Number of outlets where purchases earn loyalty points. Tracks loyalty program integration depth in F&B, driving guest retention and incremental spend."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_gds_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Global Distribution System (GDS) and channel presence KPI layer over GDS profiles. Tracks distribution reach, profile quality, amenity flags, and star rating used by distribution strategy and revenue management leadership."
  source: "`vibe_travel_hospitality_v1`.`property`.`gds_profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the GDS profile (e.g. active, inactive, pending) for distribution channel health monitoring."
    - name: "distribution_channel_type"
      expr: distribution_channel_type
      comment: "Type of distribution channel (e.g. GDS, OTA, direct) for channel mix and cost-of-acquisition analysis."
    - name: "property_category"
      expr: property_category
      comment: "Property category as represented in the GDS profile, used for channel-level portfolio segmentation."
    - name: "country_code"
      expr: country_code
      comment: "Country of the property as listed in the GDS profile, enabling geographic distribution analysis."
    - name: "has_pool"
      expr: has_pool
      comment: "Pool amenity flag in GDS profile. Amenity completeness affects search ranking and booking conversion on GDS platforms."
    - name: "has_fitness_center"
      expr: has_fitness_center
      comment: "Fitness center amenity flag in GDS profile. Impacts corporate traveler booking preference and GDS search visibility."
    - name: "has_meeting_facilities"
      expr: has_meeting_facilities
      comment: "Meeting facilities flag in GDS profile. Critical for group and corporate segment distribution and RFP eligibility."
    - name: "is_pet_friendly"
      expr: is_pet_friendly
      comment: "Pet-friendly flag in GDS profile. Increasingly important for leisure segment targeting and booking conversion."
    - name: "profile_effective_date_month"
      expr: DATE_TRUNC('month', profile_effective_date)
      comment: "Month the GDS profile became effective, used for distribution activation timeline analysis."
  measures:
    - name: "total_gds_profiles"
      expr: COUNT(DISTINCT gds_profile_id)
      comment: "Total number of active GDS profiles. Measures distribution channel breadth and reach across the portfolio."
    - name: "avg_star_rating"
      expr: AVG(CAST(star_rating AS DOUBLE))
      comment: "Average star rating as published in GDS profiles. Indicates quality positioning in global distribution channels, directly affecting booking conversion and ADR."
    - name: "properties_with_meeting_facilities_count"
      expr: COUNT(DISTINCT CASE WHEN has_meeting_facilities = TRUE THEN gds_profile_id END)
      comment: "Number of GDS profiles flagging meeting facilities. Tracks group and corporate segment distribution eligibility across the portfolio."
    - name: "pet_friendly_profile_count"
      expr: COUNT(DISTINCT CASE WHEN is_pet_friendly = TRUE THEN gds_profile_id END)
      comment: "Number of GDS profiles flagged as pet-friendly. Measures leisure segment targeting capability and incremental booking opportunity."
    - name: "avg_latitude"
      expr: AVG(CAST(latitude AS DOUBLE))
      comment: "Average geographic latitude of GDS-listed properties. Used for geographic clustering and market coverage analysis in distribution strategy."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Organizational hierarchy and portfolio structure KPI layer. Tracks reporting node coverage, management type distribution, geographic segmentation, and STR market alignment used by corporate strategy and finance leadership."
  source: "`vibe_travel_hospitality_v1`.`property`.`hierarchy`"
  dimensions:
    - name: "node_type"
      expr: node_type
      comment: "Type of hierarchy node (e.g. region, brand, cluster, property) for organizational structure analysis."
    - name: "node_status"
      expr: node_status
      comment: "Current status of the hierarchy node (e.g. active, inactive) for governance and reporting integrity."
    - name: "management_type"
      expr: management_type
      comment: "Management model for the node (e.g. managed, franchised, owned) for portfolio governance and fee income analysis."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the hierarchy node, enabling regional performance rollup and resource allocation decisions."
    - name: "chain_scale"
      expr: chain_scale
      comment: "Chain scale classification (e.g. luxury, upper-upscale, economy) for competitive positioning and brand portfolio analysis."
    - name: "brand_portfolio"
      expr: brand_portfolio
      comment: "Brand portfolio grouping within the hierarchy, used for brand family performance consolidation."
    - name: "is_reporting_node"
      expr: is_reporting_node
      comment: "Flags nodes that are designated reporting entities, ensuring correct KPI rollup and financial consolidation."
    - name: "is_str_market_node"
      expr: is_str_market_node
      comment: "Flags nodes aligned to STR market definitions, enabling competitive benchmarking and market share analysis."
    - name: "effective_from_year"
      expr: YEAR(effective_from)
      comment: "Year the hierarchy node became effective, used for organizational change and restructuring timeline analysis."
  measures:
    - name: "total_hierarchy_nodes"
      expr: COUNT(DISTINCT hierarchy_id)
      comment: "Total number of distinct hierarchy nodes. Measures organizational structure complexity and reporting coverage."
    - name: "reporting_node_count"
      expr: COUNT(DISTINCT CASE WHEN is_reporting_node = TRUE THEN hierarchy_id END)
      comment: "Number of designated reporting nodes. Ensures financial consolidation coverage and identifies gaps in the reporting structure."
    - name: "str_market_node_count"
      expr: COUNT(DISTINCT CASE WHEN is_str_market_node = TRUE THEN hierarchy_id END)
      comment: "Number of nodes aligned to STR market definitions. Tracks competitive benchmarking coverage across the portfolio."
    - name: "total_room_count_rollup"
      expr: SUM(CAST(total_room_count AS BIGINT))
      comment: "Sum of room counts across hierarchy nodes. Enables portfolio-level capacity rollup by region, brand, or management type for executive reporting."
$$;
