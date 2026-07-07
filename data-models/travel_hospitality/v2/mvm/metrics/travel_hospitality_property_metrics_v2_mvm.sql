-- Metric views for domain: property | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-27 02:47:23

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core property portfolio metrics covering operational status, brand distribution, physical capacity, and strategic classification. Used by portfolio management, asset strategy, and executive leadership to evaluate the health and composition of the property estate."
  source: "`vibe_travel_hospitality_v1`.`property`.`property`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the property (e.g., Open, Closed, Under Renovation). Primary filter for active portfolio analysis."
    - name: "brand_code"
      expr: brand_code
      comment: "Brand identifier for the property. Used to segment portfolio performance by brand."
    - name: "brand_name"
      expr: brand_name
      comment: "Full brand name for the property. Human-readable brand segmentation dimension."
    - name: "brand_tier"
      expr: brand_tier
      comment: "Brand tier classification (e.g., Luxury, Upper Upscale, Midscale). Drives strategic investment and pricing decisions."
    - name: "property_type"
      expr: property_type
      comment: "Type of property (e.g., Full Service, Select Service, Resort). Used for peer benchmarking and portfolio mix analysis."
    - name: "segment_classification"
      expr: segment_classification
      comment: "Market segment classification for the property. Aligns with STR and competitive set reporting."
    - name: "country_code"
      expr: country_code
      comment: "ISO country code where the property is located. Enables geographic portfolio analysis."
    - name: "state_province"
      expr: state_province
      comment: "State or province of the property. Supports regional performance grouping."
    - name: "city"
      expr: city
      comment: "City where the property is located. Enables market-level portfolio analysis."
    - name: "is_franchised"
      expr: is_franchised
      comment: "Indicates whether the property operates under a franchise agreement. Distinguishes managed vs. franchised portfolio composition."
    - name: "pip_status"
      expr: pip_status
      comment: "Property Improvement Plan (PIP) status. Tracks capital reinvestment compliance across the portfolio."
    - name: "parent_brand_group"
      expr: parent_brand_group
      comment: "Parent brand group or family. Enables roll-up analysis across brand families."
    - name: "opening_date_month"
      expr: DATE_TRUNC('MONTH', opening_date)
      comment: "Month the property opened. Used for cohort analysis of new property ramp-up performance."
    - name: "opening_date_year"
      expr: YEAR(opening_date)
      comment: "Year the property opened. Supports vintage analysis of portfolio age and reinvestment cycles."
    - name: "last_renovation_date_year"
      expr: YEAR(last_renovation_date)
      comment: "Year of last renovation. Identifies properties due for capital reinvestment."
  measures:
    - name: "total_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Total number of distinct properties in the portfolio. Baseline KPI for portfolio scale and growth tracking."
    - name: "total_room_inventory"
      expr: SUM(CAST(total_room_count AS BIGINT))
      comment: "Total room inventory across all properties. Drives capacity planning, RevPAR denominator calculations, and portfolio scale assessment."
    - name: "total_suite_inventory"
      expr: SUM(CAST(total_suite_count AS BIGINT))
      comment: "Total suite inventory across the portfolio. Tracks premium room mix and luxury segment capacity."
    - name: "avg_star_rating"
      expr: AVG(CAST(star_rating AS DOUBLE))
      comment: "Average star rating across properties. Indicates overall portfolio quality positioning and brand standard compliance."
    - name: "total_meeting_space_sqft"
      expr: SUM(CAST(total_meeting_space_sqft AS DOUBLE))
      comment: "Total meeting and event space square footage across the portfolio. Drives group and MICE (Meetings, Incentives, Conferences, Exhibitions) revenue capacity planning."
    - name: "franchised_property_count"
      expr: COUNT(DISTINCT CASE WHEN is_franchised = TRUE THEN property_id END)
      comment: "Number of franchised properties. Tracks franchise vs. managed portfolio split for fee revenue and brand governance analysis."
    - name: "managed_property_count"
      expr: COUNT(DISTINCT CASE WHEN is_franchised = FALSE THEN property_id END)
      comment: "Number of managed (non-franchised) properties. Supports management fee revenue forecasting and operational oversight scope."
    - name: "franchise_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_franchised = TRUE THEN property_id END) / NULLIF(COUNT(DISTINCT property_id), 0), 2)
      comment: "Percentage of portfolio that is franchised. Strategic KPI for asset-light vs. managed growth strategy evaluation."
    - name: "avg_rooms_per_property"
      expr: AVG(CAST(total_room_count AS DOUBLE))
      comment: "Average number of rooms per property. Indicates typical property scale and informs staffing and operational benchmarks."
    - name: "properties_with_pip"
      expr: COUNT(DISTINCT CASE WHEN pip_status IS NOT NULL AND pip_status != 'Completed' THEN property_id END)
      comment: "Number of properties with an active or pending Property Improvement Plan. Tracks capital reinvestment obligations and brand standard compliance risk."
    - name: "avg_total_floor_count"
      expr: AVG(CAST(total_floor_count AS DOUBLE))
      comment: "Average number of floors per property. Proxy for property scale and vertical capacity, relevant for elevator, staffing, and energy benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_franchise_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise agreement financial and compliance metrics. Used by franchise development, legal, and finance teams to monitor fee structures, agreement health, renewal pipelines, and brand standard compliance across the franchised portfolio."
  source: "`vibe_travel_hospitality_v1`.`property`.`franchise_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the franchise agreement (e.g., Active, Terminated, Expired). Primary filter for active franchise portfolio analysis."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of franchise agreement. Differentiates standard franchise, license, and other agreement structures."
    - name: "brand_code"
      expr: brand_code
      comment: "Brand code associated with the franchise agreement. Enables fee and compliance analysis by brand."
    - name: "brand_segment"
      expr: brand_segment
      comment: "Brand segment (e.g., Luxury, Upper Upscale) for the franchise. Supports segment-level fee benchmarking."
    - name: "governing_law_country"
      expr: governing_law_country
      comment: "Country whose law governs the franchise agreement. Relevant for legal and regulatory compliance reporting."
    - name: "governing_law_state"
      expr: governing_law_state
      comment: "State whose law governs the franchise agreement. Supports US-specific FDD and state franchise law compliance."
    - name: "pip_required"
      expr: pip_required
      comment: "Indicates whether a Property Improvement Plan is required under the agreement. Tracks capital reinvestment obligations."
    - name: "exclusive_territory"
      expr: exclusive_territory
      comment: "Indicates whether the agreement grants an exclusive territory. Relevant for market development and competitive positioning decisions."
    - name: "effective_date_year"
      expr: YEAR(effective_date)
      comment: "Year the franchise agreement became effective. Supports vintage cohort analysis of agreement terms and fee evolution."
    - name: "expiration_date_year"
      expr: YEAR(expiration_date)
      comment: "Year the franchise agreement expires. Critical for renewal pipeline management and revenue continuity planning."
    - name: "pip_completion_date_year"
      expr: YEAR(pip_completion_date)
      comment: "Year the PIP is scheduled for completion. Tracks capital reinvestment timelines across the franchise portfolio."
    - name: "brand_standard_version"
      expr: brand_standard_version
      comment: "Version of brand standards the agreement is governed by. Identifies agreements requiring upgrade to current standards."
  measures:
    - name: "total_active_agreements"
      expr: COUNT(DISTINCT CASE WHEN agreement_status = 'Active' THEN franchise_agreement_id END)
      comment: "Total number of active franchise agreements. Baseline KPI for franchise portfolio scale and fee revenue base."
    - name: "avg_royalty_fee_pct"
      expr: AVG(CAST(royalty_fee_pct AS DOUBLE))
      comment: "Average royalty fee percentage across franchise agreements. Benchmarks fee competitiveness and revenue yield from the franchise portfolio."
    - name: "avg_marketing_fee_pct"
      expr: AVG(CAST(marketing_fee_pct AS DOUBLE))
      comment: "Average marketing fee percentage. Tracks brand fund contribution rates and marketing investment levels across franchisees."
    - name: "avg_loyalty_fee_pct"
      expr: AVG(CAST(loyalty_fee_pct AS DOUBLE))
      comment: "Average loyalty program fee percentage. Monitors loyalty program cost burden on franchisees and brand fund adequacy."
    - name: "avg_reservation_fee_pct"
      expr: AVG(CAST(reservation_fee_pct AS DOUBLE))
      comment: "Average reservation fee percentage. Tracks CRS/distribution cost recovery rates across the franchise portfolio."
    - name: "avg_ff_and_e_reserve_pct"
      expr: AVG(CAST(ff_and_e_reserve_pct AS DOUBLE))
      comment: "Average FF&E (Furniture, Fixtures & Equipment) reserve percentage. Monitors capital reinvestment reserve adequacy across franchised properties."
    - name: "total_pip_budget"
      expr: SUM(CAST(pip_budget_amount AS DOUBLE))
      comment: "Total Property Improvement Plan budget committed across all franchise agreements. Tracks capital reinvestment obligations and brand standard upgrade investment."
    - name: "avg_pip_budget"
      expr: AVG(CAST(pip_budget_amount AS DOUBLE))
      comment: "Average PIP budget per franchise agreement. Benchmarks reinvestment intensity and identifies outlier capital requirements."
    - name: "total_liquidated_damages_exposure"
      expr: SUM(CAST(liquidated_damages_amount AS DOUBLE))
      comment: "Total liquidated damages exposure across all franchise agreements. Quantifies financial risk from early termination scenarios."
    - name: "avg_management_fee_base_pct"
      expr: AVG(CAST(management_fee_base_pct AS DOUBLE))
      comment: "Average base management fee percentage. Tracks management fee revenue yield for managed franchise agreements."
    - name: "avg_quality_assurance_score_min"
      expr: AVG(CAST(quality_assurance_score_min AS DOUBLE))
      comment: "Average minimum quality assurance score threshold required by franchise agreements. Monitors brand standard floor across the portfolio."
    - name: "pip_required_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN pip_required = TRUE THEN franchise_agreement_id END)
      comment: "Number of franchise agreements requiring a Property Improvement Plan. Tracks capital reinvestment compliance obligations across the portfolio."
    - name: "agreements_expiring_within_2_years"
      expr: COUNT(DISTINCT CASE WHEN expiration_date <= DATE_ADD(CURRENT_DATE(), 730) AND agreement_status = 'Active' THEN franchise_agreement_id END)
      comment: "Number of active franchise agreements expiring within 2 years. Critical renewal pipeline KPI for franchise development and revenue continuity planning."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_meeting_space`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Meeting and event space capacity, configuration, and revenue potential metrics. Used by group sales, revenue management, and asset management teams to optimize MICE (Meetings, Incentives, Conferences, Exhibitions) revenue and space utilization."
  source: "`vibe_travel_hospitality_v1`.`property`.`meeting_space`"
  dimensions:
    - name: "space_type"
      expr: space_type
      comment: "Type of meeting space (e.g., Ballroom, Boardroom, Breakout). Drives pricing tier and demand segmentation."
    - name: "meeting_space_status"
      expr: meeting_space_status
      comment: "Current operational status of the meeting space. Filters active vs. inactive inventory for capacity planning."
    - name: "rental_rate_tier"
      expr: rental_rate_tier
      comment: "Pricing tier for the meeting space. Enables revenue yield analysis by rate category."
    - name: "divisible"
      expr: divisible
      comment: "Indicates whether the space can be divided into sections. Affects flexible capacity and multi-event booking potential."
    - name: "accessibility_compliant"
      expr: accessibility_compliant
      comment: "Indicates ADA/accessibility compliance. Required for compliance reporting and inclusive event planning."
    - name: "wifi_available"
      expr: wifi_available
      comment: "Indicates whether WiFi is available in the space. Key amenity driver for corporate meeting demand."
    - name: "natural_light_available"
      expr: natural_light_available
      comment: "Indicates whether the space has natural light. Premium amenity that influences pricing and demand."
    - name: "catering_required"
      expr: catering_required
      comment: "Indicates whether catering is mandatory for the space. Affects total event revenue and F&B attachment rates."
    - name: "climate_control_type"
      expr: climate_control_type
      comment: "Type of climate control system. Relevant for event comfort standards and energy cost benchmarking."
    - name: "floor_level"
      expr: floor_level
      comment: "Floor level of the meeting space. Influences demand for view-premium and accessibility considerations."
    - name: "last_renovation_date_year"
      expr: YEAR(last_renovation_date)
      comment: "Year of last renovation. Identifies spaces due for capital reinvestment to maintain competitive standards."
  measures:
    - name: "total_meeting_spaces"
      expr: COUNT(DISTINCT meeting_space_id)
      comment: "Total number of distinct meeting spaces. Baseline inventory KPI for group sales capacity planning."
    - name: "total_meeting_space_sqft"
      expr: SUM(CAST(total_square_footage AS DOUBLE))
      comment: "Total square footage of meeting space inventory. Primary capacity metric for group and MICE revenue potential assessment."
    - name: "avg_meeting_space_sqft"
      expr: AVG(CAST(total_square_footage AS DOUBLE))
      comment: "Average square footage per meeting space. Benchmarks typical space size for demand matching and pricing strategy."
    - name: "avg_ceiling_height_feet"
      expr: AVG(CAST(ceiling_height_feet AS DOUBLE))
      comment: "Average ceiling height across meeting spaces. Relevant for production event suitability and premium space classification."
    - name: "total_minimum_catering_spend"
      expr: SUM(CAST(minimum_catering_spend AS DOUBLE))
      comment: "Total minimum catering spend commitments across all meeting spaces. Quantifies guaranteed F&B revenue floor from group bookings."
    - name: "avg_minimum_catering_spend"
      expr: AVG(CAST(minimum_catering_spend AS DOUBLE))
      comment: "Average minimum catering spend per meeting space. Benchmarks F&B revenue attachment rates and pricing competitiveness."
    - name: "avg_minimum_rental_hours"
      expr: AVG(CAST(minimum_rental_hours AS DOUBLE))
      comment: "Average minimum rental hours required per meeting space. Informs booking policy and revenue yield per event."
    - name: "divisible_space_count"
      expr: COUNT(DISTINCT CASE WHEN divisible = TRUE THEN meeting_space_id END)
      comment: "Number of divisible meeting spaces. Tracks flexible inventory that can accommodate simultaneous multi-group bookings."
    - name: "divisible_space_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN divisible = TRUE THEN meeting_space_id END) / NULLIF(COUNT(DISTINCT meeting_space_id), 0), 2)
      comment: "Percentage of meeting spaces that are divisible. Measures portfolio flexibility for concurrent group event hosting."
    - name: "accessible_space_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN accessibility_compliant = TRUE THEN meeting_space_id END) / NULLIF(COUNT(DISTINCT meeting_space_id), 0), 2)
      comment: "Percentage of meeting spaces that are ADA/accessibility compliant. Tracks compliance posture and inclusive event hosting capability."
    - name: "avg_entrance_width_inches"
      expr: AVG(CAST(entrance_width_inches AS DOUBLE))
      comment: "Average entrance width in inches. Relevant for load-in logistics, ADA compliance, and large equipment event suitability."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property facility operational metrics covering amenity availability, compliance, fee structures, and capacity. Used by operations, asset management, and guest experience teams to monitor facility health, compliance risk, and revenue-generating amenity performance."
  source: "`vibe_travel_hospitality_v1`.`property`.`property_facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (e.g., Pool, Fitness Center, Spa). Primary segmentation for amenity performance analysis."
    - name: "facility_category"
      expr: facility_category
      comment: "Category grouping for the facility. Enables roll-up analysis across facility types."
    - name: "property_facility_status"
      expr: property_facility_status
      comment: "Current operational status of the facility. Filters active vs. closed/under renovation inventory."
    - name: "is_fee_based"
      expr: is_fee_based
      comment: "Indicates whether the facility charges a usage fee. Distinguishes revenue-generating amenities from complimentary offerings."
    - name: "is_ada_compliant"
      expr: is_ada_compliant
      comment: "Indicates ADA compliance status. Tracks regulatory compliance posture across the facility portfolio."
    - name: "is_seasonal"
      expr: is_seasonal
      comment: "Indicates whether the facility operates seasonally. Relevant for capacity planning and seasonal revenue forecasting."
    - name: "is_24_hour"
      expr: is_24_hour
      comment: "Indicates whether the facility operates 24 hours. Affects guest satisfaction scoring and operational staffing requirements."
    - name: "outdoor_indoor"
      expr: outdoor_indoor
      comment: "Indicates whether the facility is outdoor or indoor. Relevant for weather-dependent demand and seasonal closure planning."
    - name: "renovation_status"
      expr: renovation_status
      comment: "Current renovation status of the facility. Tracks capital reinvestment pipeline and temporary capacity reductions."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Result of the most recent facility inspection. Critical compliance KPI for health, safety, and brand standard adherence."
    - name: "last_inspection_date_year"
      expr: YEAR(last_inspection_date)
      comment: "Year of last facility inspection. Identifies facilities overdue for compliance inspection."
    - name: "license_expiry_date_month"
      expr: DATE_TRUNC('MONTH', license_expiry_date)
      comment: "Month of license expiry. Enables proactive license renewal management to avoid compliance violations."
  measures:
    - name: "total_facilities"
      expr: COUNT(DISTINCT property_facility_id)
      comment: "Total number of distinct property facilities. Baseline amenity inventory KPI for portfolio benchmarking."
    - name: "total_facility_area_sqft"
      expr: SUM(CAST(area_sqft AS DOUBLE))
      comment: "Total square footage of all property facilities. Tracks physical amenity footprint for asset valuation and operational cost benchmarking."
    - name: "avg_facility_area_sqft"
      expr: AVG(CAST(area_sqft AS DOUBLE))
      comment: "Average facility area in square feet. Benchmarks typical facility scale for peer comparison and investment planning."
    - name: "total_usage_fee_revenue_potential"
      expr: SUM(CAST(usage_fee_amount AS DOUBLE))
      comment: "Total usage fee amounts across all fee-based facilities. Quantifies ancillary revenue potential from facility charges."
    - name: "avg_usage_fee_amount"
      expr: AVG(CAST(usage_fee_amount AS DOUBLE))
      comment: "Average usage fee per facility. Benchmarks fee pricing competitiveness and ancillary revenue yield."
    - name: "avg_max_occupancy_pct"
      expr: AVG(CAST(max_occupancy_pct AS DOUBLE))
      comment: "Average maximum occupancy percentage threshold across facilities. Monitors capacity utilization limits for safety and regulatory compliance."
    - name: "fee_based_facility_count"
      expr: COUNT(DISTINCT CASE WHEN is_fee_based = TRUE THEN property_facility_id END)
      comment: "Number of fee-generating facilities. Tracks ancillary revenue source count across the property portfolio."
    - name: "fee_based_facility_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_fee_based = TRUE THEN property_facility_id END) / NULLIF(COUNT(DISTINCT property_facility_id), 0), 2)
      comment: "Percentage of facilities that are fee-based. Measures ancillary revenue monetization rate of the amenity portfolio."
    - name: "ada_compliant_facility_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_ada_compliant = TRUE THEN property_facility_id END) / NULLIF(COUNT(DISTINCT property_facility_id), 0), 2)
      comment: "Percentage of facilities that are ADA compliant. Critical compliance KPI for regulatory risk management and inclusive hospitality standards."
    - name: "facilities_with_failed_inspection"
      expr: COUNT(DISTINCT CASE WHEN inspection_result = 'Failed' THEN property_facility_id END)
      comment: "Number of facilities with a failed inspection result. High-priority operational risk KPI requiring immediate remediation action."
    - name: "facilities_under_renovation"
      expr: COUNT(DISTINCT CASE WHEN renovation_status = 'In Progress' THEN property_facility_id END)
      comment: "Number of facilities currently under renovation. Tracks temporary capacity reduction and capital reinvestment activity."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_outlet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property food and beverage outlet operational and revenue metrics. Used by F&B operations, revenue management, and asset management teams to monitor outlet performance, service capability, and ancillary revenue contribution."
  source: "`vibe_travel_hospitality_v1`.`property`.`property_outlet`"
  dimensions:
    - name: "outlet_type"
      expr: outlet_type
      comment: "Type of outlet (e.g., Restaurant, Bar, Café, Room Service). Primary segmentation for F&B revenue and demand analysis."
    - name: "outlet_status"
      expr: outlet_status
      comment: "Current operational status of the outlet. Filters active vs. closed inventory for performance analysis."
    - name: "cuisine_type"
      expr: cuisine_type
      comment: "Cuisine type offered by the outlet. Enables demand and competitive positioning analysis by food category."
    - name: "alcohol_service_flag"
      expr: alcohol_service_flag
      comment: "Indicates whether the outlet serves alcohol. Relevant for liquor license compliance and beverage revenue mix analysis."
    - name: "loyalty_points_eligible_flag"
      expr: loyalty_points_eligible_flag
      comment: "Indicates whether purchases at the outlet earn loyalty points. Tracks loyalty program integration and member engagement in F&B."
    - name: "mobile_ordering_enabled_flag"
      expr: mobile_ordering_enabled_flag
      comment: "Indicates whether mobile ordering is enabled. Tracks digital F&B capability adoption across the portfolio."
    - name: "seasonal_operation_flag"
      expr: seasonal_operation_flag
      comment: "Indicates whether the outlet operates seasonally. Relevant for seasonal revenue forecasting and staffing planning."
    - name: "outdoor_seating_flag"
      expr: outdoor_seating_flag
      comment: "Indicates whether outdoor seating is available. Premium amenity driver for demand and pricing in favorable climates."
    - name: "private_dining_available_flag"
      expr: private_dining_available_flag
      comment: "Indicates whether private dining is available. Tracks premium F&B revenue capability for group and VIP segments."
    - name: "opening_date_year"
      expr: YEAR(opening_date)
      comment: "Year the outlet opened. Supports vintage analysis of outlet performance and reinvestment cycles."
    - name: "last_renovation_date_year"
      expr: YEAR(last_renovation_date)
      comment: "Year of last outlet renovation. Identifies outlets due for capital reinvestment to maintain competitive standards."
  measures:
    - name: "total_outlets"
      expr: COUNT(DISTINCT property_outlet_id)
      comment: "Total number of distinct F&B outlets across the portfolio. Baseline KPI for ancillary revenue source inventory."
    - name: "avg_check_amount"
      expr: AVG(CAST(average_check_amount AS DOUBLE))
      comment: "Average check amount per outlet. Key F&B revenue yield KPI used to benchmark pricing and guest spend performance."
    - name: "total_average_check_portfolio"
      expr: SUM(CAST(average_check_amount AS DOUBLE))
      comment: "Sum of average check amounts across all outlets. Proxy for total F&B revenue potential across the portfolio."
    - name: "avg_service_charge_percentage"
      expr: AVG(CAST(service_charge_percentage AS DOUBLE))
      comment: "Average service charge percentage across outlets. Tracks service charge revenue contribution and competitive positioning."
    - name: "outlets_with_alcohol_service"
      expr: COUNT(DISTINCT CASE WHEN alcohol_service_flag = TRUE THEN property_outlet_id END)
      comment: "Number of outlets with alcohol service. Tracks beverage revenue capability and liquor license compliance scope."
    - name: "alcohol_service_outlet_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN alcohol_service_flag = TRUE THEN property_outlet_id END) / NULLIF(COUNT(DISTINCT property_outlet_id), 0), 2)
      comment: "Percentage of outlets offering alcohol service. Measures beverage revenue mix and compliance exposure across the portfolio."
    - name: "mobile_ordering_adoption_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN mobile_ordering_enabled_flag = TRUE THEN property_outlet_id END) / NULLIF(COUNT(DISTINCT property_outlet_id), 0), 2)
      comment: "Percentage of outlets with mobile ordering enabled. Tracks digital F&B transformation progress and guest convenience capability."
    - name: "loyalty_eligible_outlet_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN loyalty_points_eligible_flag = TRUE THEN property_outlet_id END) / NULLIF(COUNT(DISTINCT property_outlet_id), 0), 2)
      comment: "Percentage of outlets where purchases earn loyalty points. Measures loyalty program integration depth in F&B and member engagement opportunity."
    - name: "private_dining_outlet_count"
      expr: COUNT(DISTINCT CASE WHEN private_dining_available_flag = TRUE THEN property_outlet_id END)
      comment: "Number of outlets offering private dining. Tracks premium F&B revenue capability for group, VIP, and corporate segments."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_gds_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GDS (Global Distribution System) profile quality, completeness, and amenity representation metrics. Used by distribution, revenue management, and e-commerce teams to ensure accurate property representation across GDS channels and maximize booking conversion."
  source: "`vibe_travel_hospitality_v1`.`property`.`gds_profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the GDS profile (e.g., Active, Inactive, Pending). Primary filter for live distribution inventory."
    - name: "property_category"
      expr: property_category
      comment: "Property category as represented in GDS. Affects search ranking and demand segmentation in GDS channels."
    - name: "brand_code"
      expr: brand_code
      comment: "Brand code in the GDS profile. Enables brand-level distribution quality analysis."
    - name: "chain_code"
      expr: chain_code
      comment: "Chain code in the GDS profile. Used for chain-level distribution reporting and GDS connectivity audits."
    - name: "country_code"
      expr: country_code
      comment: "Country code in the GDS profile. Enables geographic distribution quality analysis."
    - name: "city_code"
      expr: city_code
      comment: "GDS city code. Used for market-level distribution analysis and competitive set benchmarking."
    - name: "has_pool"
      expr: has_pool
      comment: "Indicates whether pool amenity is flagged in the GDS profile. Tracks amenity representation accuracy."
    - name: "has_fitness_center"
      expr: has_fitness_center
      comment: "Indicates whether fitness center amenity is flagged in the GDS profile. Tracks amenity representation accuracy."
    - name: "has_meeting_facilities"
      expr: has_meeting_facilities
      comment: "Indicates whether meeting facilities are flagged in the GDS profile. Critical for group and corporate demand capture."
    - name: "has_parking"
      expr: has_parking
      comment: "Indicates whether parking is flagged in the GDS profile. Affects demand from drive-market and corporate segments."
    - name: "is_pet_friendly"
      expr: is_pet_friendly
      comment: "Indicates whether pet-friendly status is flagged in the GDS profile. Tracks niche demand segment representation."
    - name: "is_ada_compliant"
      expr: is_ada_compliant
      comment: "Indicates whether ADA compliance is flagged in the GDS profile. Required for accessibility demand capture and regulatory representation."
    - name: "profile_effective_date_year"
      expr: YEAR(profile_effective_date)
      comment: "Year the GDS profile became effective. Supports profile freshness and update cycle analysis."
    - name: "last_sync_date_month"
      expr: DATE_TRUNC('MONTH', last_sync_timestamp)
      comment: "Month of last GDS profile synchronization. Identifies stale profiles requiring refresh to maintain distribution accuracy."
  measures:
    - name: "total_gds_profiles"
      expr: COUNT(DISTINCT gds_profile_id)
      comment: "Total number of GDS profiles. Baseline KPI for distribution channel coverage across the portfolio."
    - name: "active_gds_profiles"
      expr: COUNT(DISTINCT CASE WHEN profile_status = 'Active' THEN gds_profile_id END)
      comment: "Number of active GDS profiles. Tracks live distribution inventory available for booking through GDS channels."
    - name: "avg_star_rating"
      expr: AVG(CAST(star_rating AS DOUBLE))
      comment: "Average star rating as represented in GDS profiles. Monitors quality positioning consistency across distribution channels."
    - name: "profiles_with_meeting_facilities_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN has_meeting_facilities = TRUE THEN gds_profile_id END) / NULLIF(COUNT(DISTINCT gds_profile_id), 0), 2)
      comment: "Percentage of GDS profiles flagged with meeting facilities. Tracks group demand capture capability representation in GDS."
    - name: "profiles_with_pool_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN has_pool = TRUE THEN gds_profile_id END) / NULLIF(COUNT(DISTINCT gds_profile_id), 0), 2)
      comment: "Percentage of GDS profiles flagged with pool amenity. Monitors amenity representation completeness for leisure demand capture."
    - name: "ada_compliant_profile_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_ada_compliant = TRUE THEN gds_profile_id END) / NULLIF(COUNT(DISTINCT gds_profile_id), 0), 2)
      comment: "Percentage of GDS profiles flagged as ADA compliant. Tracks accessibility representation accuracy for compliance and inclusive demand capture."
    - name: "pet_friendly_profile_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_pet_friendly = TRUE THEN gds_profile_id END) / NULLIF(COUNT(DISTINCT gds_profile_id), 0), 2)
      comment: "Percentage of GDS profiles flagged as pet-friendly. Tracks niche demand segment representation in distribution channels."
    - name: "avg_total_room_count"
      expr: AVG(CAST(total_room_count AS DOUBLE))
      comment: "Average total room count as represented in GDS profiles. Monitors inventory accuracy in distribution channels."
    - name: "profiles_with_airport_shuttle_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN has_airport_shuttle = TRUE THEN gds_profile_id END) / NULLIF(COUNT(DISTINCT gds_profile_id), 0), 2)
      comment: "Percentage of GDS profiles flagged with airport shuttle service. Tracks transportation amenity representation for airport-adjacent demand capture."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Organizational hierarchy and portfolio structure metrics. Used by corporate strategy, finance, and operations teams to understand portfolio composition by management structure, geographic region, brand portfolio, and reporting hierarchy for KPI roll-up and governance."
  source: "`vibe_travel_hospitality_v1`.`property`.`hierarchy`"
  dimensions:
    - name: "node_type"
      expr: node_type
      comment: "Type of hierarchy node (e.g., Region, Division, Brand, Property). Defines the level of organizational aggregation."
    - name: "node_status"
      expr: node_status
      comment: "Current status of the hierarchy node. Filters active vs. inactive organizational units."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region associated with the hierarchy node. Enables regional performance roll-up and benchmarking."
    - name: "brand_portfolio"
      expr: brand_portfolio
      comment: "Brand portfolio grouping for the hierarchy node. Supports brand family-level strategic analysis."
    - name: "chain_scale"
      expr: chain_scale
      comment: "Chain scale classification (e.g., Luxury, Upper Upscale, Economy). Aligns with STR chain scale benchmarking."
    - name: "management_type"
      expr: management_type
      comment: "Management type for the hierarchy node (e.g., Managed, Franchised, Owned). Drives fee revenue and operational oversight segmentation."
    - name: "country_code"
      expr: country_code
      comment: "Country code for the hierarchy node. Enables country-level portfolio and compliance analysis."
    - name: "is_reporting_node"
      expr: is_reporting_node
      comment: "Indicates whether the node is a designated reporting node. Filters hierarchy to official reporting structure."
    - name: "is_str_market_node"
      expr: is_str_market_node
      comment: "Indicates whether the node maps to an STR market. Enables competitive benchmarking alignment with STR data."
    - name: "kpi_rollup_method"
      expr: kpi_rollup_method
      comment: "Method used to roll up KPIs at this hierarchy node. Ensures correct aggregation logic for financial and operational reporting."
    - name: "effective_from_year"
      expr: YEAR(effective_from)
      comment: "Year the hierarchy node became effective. Supports historical organizational structure analysis."
    - name: "reporting_segment_code"
      expr: reporting_segment_code
      comment: "Reporting segment code for the hierarchy node. Aligns with financial segment reporting and investor disclosure."
  measures:
    - name: "total_hierarchy_nodes"
      expr: COUNT(DISTINCT hierarchy_id)
      comment: "Total number of hierarchy nodes. Baseline KPI for organizational structure complexity and governance scope."
    - name: "total_properties_in_hierarchy"
      expr: COUNT(DISTINCT property_id)
      comment: "Total number of distinct properties represented in the hierarchy. Tracks portfolio coverage and hierarchy completeness."
    - name: "total_room_count_in_hierarchy"
      expr: SUM(CAST(total_room_count AS BIGINT))
      comment: "Total room count as represented in hierarchy nodes. Enables capacity roll-up analysis by organizational unit for RevPAR and occupancy benchmarking."
    - name: "reporting_node_count"
      expr: COUNT(DISTINCT CASE WHEN is_reporting_node = TRUE THEN hierarchy_id END)
      comment: "Number of designated reporting nodes. Tracks official reporting structure coverage for financial and operational governance."
    - name: "str_market_node_count"
      expr: COUNT(DISTINCT CASE WHEN is_str_market_node = TRUE THEN hierarchy_id END)
      comment: "Number of STR market-aligned hierarchy nodes. Tracks competitive benchmarking coverage and STR data integration scope."
    - name: "avg_property_count_per_node"
      expr: AVG(CAST(property_count AS DOUBLE))
      comment: "Average number of properties per hierarchy node. Measures organizational span of control and management complexity."
    - name: "active_node_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN node_status = 'Active' THEN hierarchy_id END) / NULLIF(COUNT(DISTINCT hierarchy_id), 0), 2)
      comment: "Percentage of hierarchy nodes that are active. Monitors organizational structure health and identifies stale or obsolete nodes."
$$;