-- Metric views for domain: property | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-07-10 20:24:18

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core property performance metrics including operational status, room inventory, and geographic distribution for portfolio management and strategic planning."
  source: "`vibe_travel_hospitality_v1`.`property`.`property`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Unique identifier for the property"
    - name: "property_name"
      expr: property_name
      comment: "Name of the property"
    - name: "brand_name"
      expr: brand_name
      comment: "Brand affiliation of the property"
    - name: "brand_tier"
      expr: brand_tier
      comment: "Brand tier classification (luxury, upscale, midscale, economy)"
    - name: "property_type"
      expr: property_type
      comment: "Type of property (hotel, resort, extended stay, etc.)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status (active, closed, under renovation)"
    - name: "country_code"
      expr: country_code
      comment: "ISO country code for property location"
    - name: "state_province"
      expr: state_province
      comment: "State or province of property location"
    - name: "city"
      expr: city
      comment: "City where property is located"
    - name: "is_franchised"
      expr: is_franchised
      comment: "Whether the property operates under a franchise agreement"
    - name: "segment_classification"
      expr: segment_classification
      comment: "Market segment classification of the property"
    - name: "pip_status"
      expr: pip_status
      comment: "Property Improvement Plan status"
    - name: "opening_year"
      expr: YEAR(opening_date)
      comment: "Year the property opened"
    - name: "star_rating_tier"
      expr: CASE WHEN star_rating >= 4.5 THEN '4.5+ Stars' WHEN star_rating >= 4.0 THEN '4.0-4.4 Stars' WHEN star_rating >= 3.0 THEN '3.0-3.9 Stars' ELSE 'Below 3 Stars' END
      comment: "Star rating tier for quality segmentation"
  measures:
    - name: "property_count"
      expr: COUNT(DISTINCT property_id)
      comment: "Total number of distinct properties in the portfolio"
    - name: "total_room_inventory"
      expr: SUM(CAST(total_room_count AS DOUBLE))
      comment: "Total room inventory across all properties"
    - name: "total_suite_inventory"
      expr: SUM(CAST(total_suite_count AS DOUBLE))
      comment: "Total suite inventory across all properties"
    - name: "avg_rooms_per_property"
      expr: AVG(CAST(total_room_count AS DOUBLE))
      comment: "Average number of rooms per property"
    - name: "avg_star_rating"
      expr: AVG(CAST(star_rating AS DOUBLE))
      comment: "Average star rating across properties"
    - name: "total_meeting_space_sqft"
      expr: SUM(CAST(total_meeting_space_sqft AS DOUBLE))
      comment: "Total meeting space square footage across all properties"
    - name: "avg_meeting_space_per_property"
      expr: AVG(CAST(total_meeting_space_sqft AS DOUBLE))
      comment: "Average meeting space square footage per property"
    - name: "franchised_property_count"
      expr: COUNT(DISTINCT CASE WHEN is_franchised = TRUE THEN property_id END)
      comment: "Number of franchised properties"
    - name: "franchise_penetration_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_franchised = TRUE THEN property_id END) / NULLIF(COUNT(DISTINCT property_id), 0), 2)
      comment: "Percentage of properties operating under franchise agreements"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_franchise_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise agreement economics and compliance metrics including royalty rates, fee structures, and brand standard adherence for franchise portfolio management."
  source: "`vibe_travel_hospitality_v1`.`property`.`franchise_agreement`"
  dimensions:
    - name: "franchise_agreement_id"
      expr: franchise_agreement_id
      comment: "Unique identifier for the franchise agreement"
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the franchise agreement"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of franchise agreement"
    - name: "brand_code"
      expr: brand_code
      comment: "Brand code associated with the franchise"
    - name: "brand_segment"
      expr: brand_segment
      comment: "Brand segment classification"
    - name: "pip_required"
      expr: pip_required
      comment: "Whether Property Improvement Plan is required"
    - name: "governing_law_country"
      expr: governing_law_country
      comment: "Country whose laws govern the agreement"
    - name: "agreement_year"
      expr: YEAR(effective_date)
      comment: "Year the agreement became effective"
    - name: "term_length_tier"
      expr: CASE WHEN CAST(initial_term_years AS INT) >= 20 THEN '20+ Years' WHEN CAST(initial_term_years AS INT) >= 10 THEN '10-19 Years' WHEN CAST(initial_term_years AS INT) >= 5 THEN '5-9 Years' ELSE 'Under 5 Years' END
      comment: "Initial term length tier for agreement duration analysis"
  measures:
    - name: "agreement_count"
      expr: COUNT(DISTINCT franchise_agreement_id)
      comment: "Total number of franchise agreements"
    - name: "active_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN agreement_status = 'Active' THEN franchise_agreement_id END)
      comment: "Number of active franchise agreements"
    - name: "avg_royalty_fee_pct"
      expr: AVG(CAST(royalty_fee_pct AS DOUBLE))
      comment: "Average royalty fee percentage across agreements"
    - name: "avg_marketing_fee_pct"
      expr: AVG(CAST(marketing_fee_pct AS DOUBLE))
      comment: "Average marketing fee percentage across agreements"
    - name: "avg_loyalty_fee_pct"
      expr: AVG(CAST(loyalty_fee_pct AS DOUBLE))
      comment: "Average loyalty program fee percentage across agreements"
    - name: "avg_total_fee_pct"
      expr: AVG(CAST(royalty_fee_pct AS DOUBLE) + CAST(marketing_fee_pct AS DOUBLE) + CAST(loyalty_fee_pct AS DOUBLE))
      comment: "Average total fee percentage (royalty + marketing + loyalty)"
    - name: "avg_management_fee_base_pct"
      expr: AVG(CAST(management_fee_base_pct AS DOUBLE))
      comment: "Average base management fee percentage"
    - name: "avg_pip_budget"
      expr: AVG(CAST(pip_budget_amount AS DOUBLE))
      comment: "Average Property Improvement Plan budget amount"
    - name: "total_pip_budget"
      expr: SUM(CAST(pip_budget_amount AS DOUBLE))
      comment: "Total Property Improvement Plan budget across all agreements"
    - name: "pip_required_count"
      expr: COUNT(DISTINCT CASE WHEN pip_required = TRUE THEN franchise_agreement_id END)
      comment: "Number of agreements requiring Property Improvement Plans"
    - name: "pip_penetration_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN pip_required = TRUE THEN franchise_agreement_id END) / NULLIF(COUNT(DISTINCT franchise_agreement_id), 0), 2)
      comment: "Percentage of agreements requiring Property Improvement Plans"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_pip_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property Improvement Plan execution metrics including budget performance, completion rates, and ROI tracking for capital investment management."
  source: "`vibe_travel_hospitality_v1`.`property`.`pip_plan`"
  dimensions:
    - name: "pip_plan_id"
      expr: pip_plan_id
      comment: "Unique identifier for the PIP plan"
    - name: "project_status"
      expr: project_status
      comment: "Current status of the PIP project"
    - name: "project_type"
      expr: project_type
      comment: "Type of PIP project"
    - name: "brand_compliance_status"
      expr: brand_compliance_status
      comment: "Brand standard compliance status"
    - name: "ada_compliance_included"
      expr: ada_compliance_included
      comment: "Whether ADA compliance upgrades are included"
    - name: "fire_safety_upgrade_included"
      expr: fire_safety_upgrade_included
      comment: "Whether fire safety upgrades are included"
    - name: "sustainability_certification_target"
      expr: sustainability_certification_target
      comment: "Target sustainability certification (LEED, etc.)"
    - name: "project_year"
      expr: YEAR(scheduled_start_date)
      comment: "Year the project is scheduled to start"
    - name: "completion_tier"
      expr: CASE WHEN completion_percentage >= 90 THEN '90-100% Complete' WHEN completion_percentage >= 75 THEN '75-89% Complete' WHEN completion_percentage >= 50 THEN '50-74% Complete' WHEN completion_percentage >= 25 THEN '25-49% Complete' ELSE '0-24% Complete' END
      comment: "Project completion percentage tier"
  measures:
    - name: "pip_plan_count"
      expr: COUNT(DISTINCT pip_plan_id)
      comment: "Total number of PIP plans"
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget AS DOUBLE))
      comment: "Total approved budget across all PIP plans"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_to_date AS DOUBLE))
      comment: "Total actual spend to date across all PIP plans"
    - name: "total_estimated_capex"
      expr: SUM(CAST(total_estimated_capex AS DOUBLE))
      comment: "Total estimated capital expenditure across all PIP plans"
    - name: "avg_completion_pct"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across all PIP plans"
    - name: "budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_to_date AS DOUBLE)) / NULLIF(SUM(CAST(approved_budget AS DOUBLE)), 0), 2)
      comment: "Percentage of approved budget spent to date"
    - name: "avg_expected_roi_pct"
      expr: AVG(CAST(expected_roi_percentage AS DOUBLE))
      comment: "Average expected return on investment percentage"
    - name: "total_ffe_budget"
      expr: SUM(CAST(ffe_budget AS DOUBLE))
      comment: "Total furniture, fixtures, and equipment budget"
    - name: "total_ffe_actual_spend"
      expr: SUM(CAST(ffe_actual_spend AS DOUBLE))
      comment: "Total actual FF&E spend to date"
    - name: "ffe_budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(ffe_actual_spend AS DOUBLE)) / NULLIF(SUM(CAST(ffe_budget AS DOUBLE)), 0), 2)
      comment: "Percentage of FF&E budget spent to date"
    - name: "total_revenue_displacement"
      expr: SUM(CAST(revenue_displacement_estimate AS DOUBLE))
      comment: "Total estimated revenue displacement during renovation"
    - name: "completed_plan_count"
      expr: COUNT(DISTINCT CASE WHEN project_status = 'Completed' THEN pip_plan_id END)
      comment: "Number of completed PIP plans"
    - name: "on_time_completion_count"
      expr: COUNT(DISTINCT CASE WHEN actual_completion_date <= projected_completion_date THEN pip_plan_id END)
      comment: "Number of PIP plans completed on or before projected completion date"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_meeting_space`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Meeting and event space inventory metrics including capacity utilization, configuration flexibility, and amenity availability for group sales and event planning."
  source: "`vibe_travel_hospitality_v1`.`property`.`meeting_space`"
  dimensions:
    - name: "meeting_space_id"
      expr: meeting_space_id
      comment: "Unique identifier for the meeting space"
    - name: "space_name"
      expr: space_name
      comment: "Name of the meeting space"
    - name: "space_type"
      expr: space_type
      comment: "Type of meeting space (ballroom, boardroom, etc.)"
    - name: "meeting_space_status"
      expr: meeting_space_status
      comment: "Current operational status of the meeting space"
    - name: "divisible"
      expr: divisible
      comment: "Whether the space can be divided into sections"
    - name: "accessibility_compliant"
      expr: accessibility_compliant
      comment: "Whether the space is ADA/accessibility compliant"
    - name: "natural_light_available"
      expr: natural_light_available
      comment: "Whether natural light is available in the space"
    - name: "wifi_available"
      expr: wifi_available
      comment: "Whether WiFi is available in the space"
    - name: "floor_level"
      expr: floor_level
      comment: "Floor level where the meeting space is located"
    - name: "sqft_tier"
      expr: CASE WHEN total_square_footage >= 5000 THEN '5000+ sqft' WHEN total_square_footage >= 2500 THEN '2500-4999 sqft' WHEN total_square_footage >= 1000 THEN '1000-2499 sqft' ELSE 'Under 1000 sqft' END
      comment: "Meeting space size tier"
  measures:
    - name: "meeting_space_count"
      expr: COUNT(DISTINCT meeting_space_id)
      comment: "Total number of meeting spaces"
    - name: "total_meeting_sqft"
      expr: SUM(CAST(total_square_footage AS DOUBLE))
      comment: "Total meeting space square footage"
    - name: "avg_meeting_space_sqft"
      expr: AVG(CAST(total_square_footage AS DOUBLE))
      comment: "Average meeting space square footage"
    - name: "total_theater_capacity"
      expr: SUM(CAST(capacity_theater AS DOUBLE))
      comment: "Total theater-style seating capacity across all spaces"
    - name: "total_banquet_capacity"
      expr: SUM(CAST(capacity_banquet AS DOUBLE))
      comment: "Total banquet-style seating capacity across all spaces"
    - name: "total_classroom_capacity"
      expr: SUM(CAST(capacity_classroom AS DOUBLE))
      comment: "Total classroom-style seating capacity across all spaces"
    - name: "total_reception_capacity"
      expr: SUM(CAST(capacity_reception AS DOUBLE))
      comment: "Total reception-style capacity across all spaces"
    - name: "avg_ceiling_height_ft"
      expr: AVG(CAST(ceiling_height_feet AS DOUBLE))
      comment: "Average ceiling height in feet across meeting spaces"
    - name: "divisible_space_count"
      expr: COUNT(DISTINCT CASE WHEN divisible = TRUE THEN meeting_space_id END)
      comment: "Number of divisible meeting spaces"
    - name: "divisible_space_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN divisible = TRUE THEN meeting_space_id END) / NULLIF(COUNT(DISTINCT meeting_space_id), 0), 2)
      comment: "Percentage of meeting spaces that are divisible"
    - name: "ada_compliant_space_count"
      expr: COUNT(DISTINCT CASE WHEN accessibility_compliant = TRUE THEN meeting_space_id END)
      comment: "Number of ADA-compliant meeting spaces"
    - name: "natural_light_space_count"
      expr: COUNT(DISTINCT CASE WHEN natural_light_available = TRUE THEN meeting_space_id END)
      comment: "Number of meeting spaces with natural light"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_legal_entity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Legal entity structure and ownership metrics for corporate governance, regulatory compliance, and financial consolidation reporting."
  source: "`vibe_travel_hospitality_v1`.`property`.`legal_entity`"
  dimensions:
    - name: "legal_entity_id"
      expr: legal_entity_id
      comment: "Unique identifier for the legal entity"
    - name: "legal_name"
      expr: legal_name
      comment: "Legal name of the entity"
    - name: "entity_type"
      expr: entity_type
      comment: "Type of legal entity (LLC, Corporation, Partnership, etc.)"
    - name: "entity_subtype"
      expr: entity_subtype
      comment: "Subtype classification of the legal entity"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the legal entity"
    - name: "incorporation_jurisdiction"
      expr: incorporation_jurisdiction
      comment: "Jurisdiction where the entity is incorporated"
    - name: "is_franchise_entity"
      expr: is_franchise_entity
      comment: "Whether this is a franchise entity"
    - name: "is_publicly_traded"
      expr: is_publicly_traded
      comment: "Whether the entity is publicly traded"
    - name: "primary_business_country_code"
      expr: primary_business_country_code
      comment: "Country code for primary business operations"
    - name: "incorporation_year"
      expr: YEAR(incorporation_date)
      comment: "Year the entity was incorporated"
  measures:
    - name: "legal_entity_count"
      expr: COUNT(DISTINCT legal_entity_id)
      comment: "Total number of legal entities"
    - name: "franchise_entity_count"
      expr: COUNT(DISTINCT CASE WHEN is_franchise_entity = TRUE THEN legal_entity_id END)
      comment: "Number of franchise legal entities"
    - name: "publicly_traded_entity_count"
      expr: COUNT(DISTINCT CASE WHEN is_publicly_traded = TRUE THEN legal_entity_id END)
      comment: "Number of publicly traded legal entities"
    - name: "avg_ownership_pct"
      expr: AVG(CAST(ownership_percentage AS DOUBLE))
      comment: "Average ownership percentage across entities"
    - name: "active_entity_count"
      expr: COUNT(DISTINCT CASE WHEN operational_status = 'Active' THEN legal_entity_id END)
      comment: "Number of active legal entities"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_seasonal_calendar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Seasonal demand and pricing strategy metrics including occupancy forecasts, rate positioning, and market segment focus for revenue management optimization."
  source: "`vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`"
  dimensions:
    - name: "seasonal_calendar_id"
      expr: seasonal_calendar_id
      comment: "Unique identifier for the seasonal calendar entry"
    - name: "season_name"
      expr: season_name
      comment: "Name of the season"
    - name: "season_code"
      expr: season_code
      comment: "Code identifying the season"
    - name: "demand_classification"
      expr: demand_classification
      comment: "Demand level classification (high, medium, low)"
    - name: "seasonal_calendar_status"
      expr: seasonal_calendar_status
      comment: "Status of the seasonal calendar entry"
    - name: "is_holiday_period"
      expr: is_holiday_period
      comment: "Whether this period includes holidays"
    - name: "is_blackout_date"
      expr: is_blackout_date
      comment: "Whether this is a blackout date for promotions"
    - name: "market_segment_focus"
      expr: market_segment_focus
      comment: "Primary market segment focus for the season"
    - name: "operating_status"
      expr: operating_status
      comment: "Operating status during the season"
    - name: "season_year"
      expr: season_year
      comment: "Year of the season"
    - name: "yoy_demand_trend"
      expr: yoy_demand_trend
      comment: "Year-over-year demand trend direction"
  measures:
    - name: "seasonal_period_count"
      expr: COUNT(DISTINCT seasonal_calendar_id)
      comment: "Total number of seasonal calendar periods"
    - name: "avg_estimated_occupancy_pct"
      expr: AVG(CAST(estimated_occupancy_pct AS DOUBLE))
      comment: "Average estimated occupancy percentage across seasons"
    - name: "avg_estimated_adr"
      expr: AVG(CAST(estimated_adr AS DOUBLE))
      comment: "Average estimated Average Daily Rate across seasons"
    - name: "avg_estimated_revpar"
      expr: AVG(CAST(estimated_revpar AS DOUBLE))
      comment: "Average estimated Revenue Per Available Room across seasons"
    - name: "avg_rgi_target"
      expr: AVG(CAST(rgi_target AS DOUBLE))
      comment: "Average Revenue Generation Index target"
    - name: "avg_cancellation_rate_pct"
      expr: AVG(CAST(cancellation_rate_pct AS DOUBLE))
      comment: "Average cancellation rate percentage"
    - name: "avg_no_show_rate_pct"
      expr: AVG(CAST(no_show_rate_pct AS DOUBLE))
      comment: "Average no-show rate percentage"
    - name: "avg_yoy_demand_variance_pct"
      expr: AVG(CAST(yoy_demand_variance_pct AS DOUBLE))
      comment: "Average year-over-year demand variance percentage"
    - name: "holiday_period_count"
      expr: COUNT(DISTINCT CASE WHEN is_holiday_period = TRUE THEN seasonal_calendar_id END)
      comment: "Number of holiday periods"
    - name: "blackout_date_count"
      expr: COUNT(DISTINCT CASE WHEN is_blackout_date = TRUE THEN seasonal_calendar_id END)
      comment: "Number of blackout date periods"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property facility and amenity metrics including capacity, compliance status, and operational hours for guest experience and facility management."
  source: "`vibe_travel_hospitality_v1`.`property`.`property_facility`"
  dimensions:
    - name: "property_facility_id"
      expr: property_facility_id
      comment: "Unique identifier for the property facility"
    - name: "facility_name"
      expr: facility_name
      comment: "Name of the facility"
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (pool, gym, spa, etc.)"
    - name: "facility_category"
      expr: facility_category
      comment: "Category classification of the facility"
    - name: "property_facility_status"
      expr: property_facility_status
      comment: "Current operational status of the facility"
    - name: "is_ada_compliant"
      expr: is_ada_compliant
      comment: "Whether the facility is ADA compliant"
    - name: "is_fee_based"
      expr: is_fee_based
      comment: "Whether the facility requires a usage fee"
    - name: "is_24_hour"
      expr: is_24_hour
      comment: "Whether the facility operates 24 hours"
    - name: "is_seasonal"
      expr: is_seasonal
      comment: "Whether the facility operates seasonally"
    - name: "is_reservation_required"
      expr: is_reservation_required
      comment: "Whether reservations are required"
    - name: "outdoor_indoor"
      expr: outdoor_indoor
      comment: "Whether the facility is outdoor or indoor"
    - name: "renovation_status"
      expr: renovation_status
      comment: "Current renovation status"
  measures:
    - name: "facility_count"
      expr: COUNT(DISTINCT property_facility_id)
      comment: "Total number of property facilities"
    - name: "total_facility_area_sqft"
      expr: SUM(CAST(area_sqft AS DOUBLE))
      comment: "Total facility area in square feet"
    - name: "avg_facility_area_sqft"
      expr: AVG(CAST(area_sqft AS DOUBLE))
      comment: "Average facility area in square feet"
    - name: "total_capacity"
      expr: SUM(CAST(capacity AS DOUBLE))
      comment: "Total capacity across all facilities"
    - name: "avg_usage_fee"
      expr: AVG(CAST(usage_fee_amount AS DOUBLE))
      comment: "Average usage fee amount for fee-based facilities"
    - name: "ada_compliant_facility_count"
      expr: COUNT(DISTINCT CASE WHEN is_ada_compliant = TRUE THEN property_facility_id END)
      comment: "Number of ADA-compliant facilities"
    - name: "ada_compliance_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_ada_compliant = TRUE THEN property_facility_id END) / NULLIF(COUNT(DISTINCT property_facility_id), 0), 2)
      comment: "Percentage of facilities that are ADA compliant"
    - name: "fee_based_facility_count"
      expr: COUNT(DISTINCT CASE WHEN is_fee_based = TRUE THEN property_facility_id END)
      comment: "Number of fee-based facilities"
    - name: "twentyfour_hour_facility_count"
      expr: COUNT(DISTINCT CASE WHEN is_24_hour = TRUE THEN property_facility_id END)
      comment: "Number of 24-hour facilities"
    - name: "seasonal_facility_count"
      expr: COUNT(DISTINCT CASE WHEN is_seasonal = TRUE THEN property_facility_id END)
      comment: "Number of seasonal facilities"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property certification and compliance metrics including audit scores, deficiency tracking, and renewal status for regulatory and brand standard adherence."
  source: "`vibe_travel_hospitality_v1`.`property`.`certification`"
  dimensions:
    - name: "certification_id"
      expr: certification_id
      comment: "Unique identifier for the certification"
    - name: "certification_name"
      expr: certification_name
      comment: "Name of the certification"
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification"
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification"
    - name: "accreditation_body"
      expr: accreditation_body
      comment: "Body that issued the accreditation"
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the certification"
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction for the certification"
    - name: "certification_level"
      expr: certification_level
      comment: "Level or tier of the certification"
    - name: "renewal_status"
      expr: renewal_status
      comment: "Renewal status of the certification"
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the certification was issued"
    - name: "compliance_score_tier"
      expr: CASE WHEN compliance_score >= 90 THEN '90-100 (Excellent)' WHEN compliance_score >= 80 THEN '80-89 (Good)' WHEN compliance_score >= 70 THEN '70-79 (Satisfactory)' ELSE 'Below 70 (Needs Improvement)' END
      comment: "Compliance score tier"
  measures:
    - name: "certification_count"
      expr: COUNT(DISTINCT certification_id)
      comment: "Total number of certifications"
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across certifications"
    - name: "avg_critical_deficiency_count"
      expr: AVG(CAST(critical_deficiency_count AS DOUBLE))
      comment: "Average number of critical deficiencies per certification"
    - name: "avg_minor_deficiency_count"
      expr: AVG(CAST(minor_deficiency_count AS DOUBLE))
      comment: "Average number of minor deficiencies per certification"
    - name: "total_permit_fees"
      expr: SUM(CAST(permit_fee_amount AS DOUBLE))
      comment: "Total permit fee amounts across all certifications"
    - name: "avg_permit_fee"
      expr: AVG(CAST(permit_fee_amount AS DOUBLE))
      comment: "Average permit fee amount per certification"
    - name: "active_certification_count"
      expr: COUNT(DISTINCT CASE WHEN certification_status = 'Active' THEN certification_id END)
      comment: "Number of active certifications"
    - name: "expired_certification_count"
      expr: COUNT(DISTINCT CASE WHEN certification_status = 'Expired' THEN certification_id END)
      comment: "Number of expired certifications"
    - name: "pending_renewal_count"
      expr: COUNT(DISTINCT CASE WHEN renewal_status = 'Pending' THEN certification_id END)
      comment: "Number of certifications pending renewal"
$$;