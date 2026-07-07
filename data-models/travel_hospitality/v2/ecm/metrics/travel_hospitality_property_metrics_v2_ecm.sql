-- Metric views for domain: property | Business: Travel Hospitality | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property certification and compliance audit metrics — used by compliance, operations, and brand leadership to track certification health, audit scores, deficiency rates, and renewal risk across the portfolio."
  source: "`vibe_travel_hospitality_v1`.`property`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g., Food Safety, Brand Quality, Fire Safety, Sustainability) — primary grouping for compliance portfolio analysis."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (e.g., Active, Expired, Pending Renewal) — used to identify at-risk certifications requiring immediate action."
    - name: "certification_level"
      expr: certification_level
      comment: "Level or grade of the certification — used to benchmark quality standards across properties."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Renewal status of the certification — used to track upcoming renewals and prevent lapses."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the certification — used for regulatory jurisdiction analysis."
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction governing the certification — used for geographic compliance risk analysis."
    - name: "accreditation_body"
      expr: accreditation_body
      comment: "Accreditation body that conducted the audit — used to track auditor performance and consistency."
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the certification expires — used for renewal pipeline planning."
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the certification was issued — used to analyze certification vintage and renewal cycle patterns."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of certification records — baseline count for compliance portfolio tracking."
    - name: "active_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN 1 END)
      comment: "Number of currently active certifications — used by compliance to confirm portfolio-wide certification coverage."
    - name: "expired_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Expired' THEN 1 END)
      comment: "Number of expired certifications — critical compliance risk KPI; any non-zero value triggers immediate remediation action."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across all audited certifications — used by brand and compliance leadership to benchmark audit performance."
    - name: "total_permit_fee_amount"
      expr: SUM(CAST(permit_fee_amount AS DOUBLE))
      comment: "Total permit fees paid across all certifications — used by finance to budget regulatory compliance costs."
    - name: "certifications_pending_renewal"
      expr: COUNT(CASE WHEN renewal_status IN ('Pending', 'Due', 'Overdue') THEN 1 END)
      comment: "Number of certifications pending renewal — used by compliance teams to prioritize renewal workload and avoid lapses."
    - name: "certifications_with_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_plan_reference IS NOT NULL THEN 1 END)
      comment: "Number of certifications with an open corrective action plan — used to track remediation workload and compliance risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_channel_connection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution channel connectivity metrics — used by revenue management and channel strategy teams to track channel activation, commission structures, rate parity exceptions, and content freshness across the property's distribution footprint."
  source: "`vibe_travel_hospitality_v1`.`property`.`channel_connection`"
  dimensions:
    - name: "connectivity_status"
      expr: connectivity_status
      comment: "Current connectivity status of the channel connection (e.g., Active, Inactive, Pending) — primary filter for live distribution channel analysis."
    - name: "inventory_allocation_method"
      expr: inventory_allocation_method
      comment: "Method used to allocate inventory to this channel — used by revenue management to analyze inventory control strategy by channel."
    - name: "rate_loading_protocol"
      expr: rate_loading_protocol
      comment: "Protocol used to load rates to this channel — used by channel management to identify integration complexity and maintenance burden."
    - name: "rate_parity_exception"
      expr: rate_parity_exception
      comment: "Flag indicating whether a rate parity exception exists for this channel — used by revenue management to identify parity violations requiring remediation."
    - name: "activation_year"
      expr: YEAR(activation_date)
      comment: "Year the channel connection was activated — used to analyze channel portfolio maturity."
  measures:
    - name: "total_channel_connections"
      expr: COUNT(1)
      comment: "Total number of channel connections — baseline count for distribution footprint tracking."
    - name: "active_channel_connections"
      expr: COUNT(CASE WHEN connectivity_status = 'Active' THEN 1 END)
      comment: "Number of active channel connections — used by revenue management to confirm live distribution coverage."
    - name: "avg_commission_rate_override"
      expr: AVG(CAST(commission_rate_override AS DOUBLE))
      comment: "Average commission rate override across channel connections — used by finance and revenue management to monitor distribution cost and negotiate channel economics."
    - name: "rate_parity_exception_count"
      expr: COUNT(CASE WHEN rate_parity_exception = TRUE THEN 1 END)
      comment: "Number of channel connections with rate parity exceptions — used by revenue management to identify and remediate parity violations that risk brand and OTA relationship penalties."
    - name: "distinct_channels_connected"
      expr: COUNT(DISTINCT distribution_channel_id)
      comment: "Number of distinct distribution channels connected — used by channel strategy to assess breadth of distribution footprint."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_currency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Currency business metrics"
  source: "`travel_hospitality_ecm`.`property`.`currency`"
  dimensions:
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Currency Name"
      expr: currency_name
    - name: "Currency Status"
      expr: currency_status
    - name: "Decimal Places"
      expr: decimal_places
    - name: "Display Format"
      expr: display_format
    - name: "Effective Date"
      expr: effective_date
    - name: "Erp Currency Code"
      expr: erp_currency_code
    - name: "Exchange Rate Source"
      expr: exchange_rate_source
    - name: "Exchange Rate Update Frequency"
      expr: exchange_rate_update_frequency
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Is Active"
      expr: is_active
    - name: "Is Base Currency"
      expr: is_base_currency
    - name: "Is Crypto Currency"
      expr: is_crypto_currency
    - name: "Minor Unit"
      expr: minor_unit
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Currency"
      expr: COUNT(DISTINCT currency_id)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_franchise_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise agreement financial and compliance metrics — used by brand leadership, legal, and finance to track franchise fee structures, agreement health, brand-standard compliance, and PIP obligations across the franchised portfolio."
  source: "`vibe_travel_hospitality_v1`.`property`.`franchise_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the franchise agreement (e.g., Active, Terminated, Expired) — primary filter for active franchise portfolio analysis."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of franchise agreement — used to differentiate standard franchise from license or management agreements."
    - name: "brand_code"
      expr: brand_code
      comment: "Brand code associated with the franchise agreement — used to analyze fee structures and compliance by brand."
    - name: "brand_segment"
      expr: brand_segment
      comment: "Brand segment (e.g., Luxury, Full-Service, Select-Service) — used for segment-level franchise economics analysis."
    - name: "pip_required"
      expr: pip_required
      comment: "Flag indicating whether a PIP is required under the agreement — used to quantify CapEx obligations in the franchise portfolio."
    - name: "governing_law_country"
      expr: governing_law_country
      comment: "Country whose law governs the agreement — used for legal jurisdiction risk analysis."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the franchise agreement became effective — used to analyze agreement vintage and renewal pipeline."
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the franchise agreement expires — used for renewal pipeline planning and revenue risk assessment."
  measures:
    - name: "total_franchise_agreements"
      expr: COUNT(1)
      comment: "Total number of franchise agreements — baseline count for franchised portfolio tracking."
    - name: "active_franchise_agreements"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN 1 END)
      comment: "Number of currently active franchise agreements — used by brand leadership to size the active franchised portfolio."
    - name: "avg_royalty_fee_pct"
      expr: AVG(CAST(royalty_fee_pct AS DOUBLE))
      comment: "Average royalty fee percentage across franchise agreements — used by finance to model royalty revenue and benchmark fee structures."
    - name: "avg_marketing_fee_pct"
      expr: AVG(CAST(marketing_fee_pct AS DOUBLE))
      comment: "Average marketing fee percentage — used by brand marketing to forecast marketing fund contributions from franchisees."
    - name: "avg_loyalty_fee_pct"
      expr: AVG(CAST(loyalty_fee_pct AS DOUBLE))
      comment: "Average loyalty program fee percentage — used by loyalty finance to project loyalty fund revenue from franchise agreements."
    - name: "total_pip_budget_amount"
      expr: SUM(CAST(pip_budget_amount AS DOUBLE))
      comment: "Total PIP budget committed across franchise agreements — used by asset management to size the CapEx obligation pipeline in the franchised portfolio."
    - name: "avg_management_fee_base_pct"
      expr: AVG(CAST(management_fee_base_pct AS DOUBLE))
      comment: "Average base management fee percentage — used by finance to model management fee revenue across the portfolio."
    - name: "avg_ff_and_e_reserve_pct"
      expr: AVG(CAST(ff_and_e_reserve_pct AS DOUBLE))
      comment: "Average FF&E reserve percentage — used by asset management to assess whether franchisees are adequately reserving for capital replacement."
    - name: "pip_required_agreement_count"
      expr: COUNT(CASE WHEN pip_required = TRUE THEN 1 END)
      comment: "Number of franchise agreements with a PIP requirement — used to quantify the scope of brand-compliance CapEx obligations."
    - name: "avg_liquidated_damages_amount"
      expr: AVG(CAST(liquidated_damages_amount AS DOUBLE))
      comment: "Average liquidated damages amount — used by legal and finance to assess termination risk exposure across the franchise portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_gds_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GDS distribution profile metrics — used by distribution, revenue management, and marketing teams to assess content quality, channel coverage, and property positioning across global distribution systems."
  source: "`vibe_travel_hospitality_v1`.`property`.`gds_profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the GDS profile (active, inactive, pending review)."
    - name: "distribution_channel_type"
      expr: distribution_channel_type
      comment: "Type of distribution channel (GDS, OTA, direct) for channel mix analysis."
    - name: "property_category"
      expr: property_category
      comment: "Property category as displayed in GDS — content consistency KPI."
    - name: "country_code"
      expr: country_code
      comment: "Country code for geographic distribution analysis."
    - name: "is_ada_compliant"
      expr: is_ada_compliant
      comment: "ADA compliance flag in GDS profile — regulatory and accessibility content accuracy indicator."
    - name: "is_pet_friendly"
      expr: is_pet_friendly
      comment: "Pet-friendly flag in GDS profile — content accuracy indicator for guest preference matching."
    - name: "has_meeting_facilities"
      expr: has_meeting_facilities
      comment: "Meeting facilities flag in GDS profile — group sales content accuracy indicator."
  measures:
    - name: "total_gds_profiles"
      expr: COUNT(DISTINCT gds_profile_id)
      comment: "Total number of GDS profiles — distribution content coverage KPI."
    - name: "active_profile_count"
      expr: COUNT(DISTINCT CASE WHEN profile_status = 'active' THEN gds_profile_id END)
      comment: "Count of active GDS profiles — live distribution presence KPI for revenue management."
    - name: "avg_star_rating"
      expr: AVG(CAST(star_rating AS DOUBLE))
      comment: "Average star rating as displayed in GDS — content quality and brand positioning KPI."
    - name: "avg_latitude"
      expr: AVG(CAST(latitude AS DOUBLE))
      comment: "Average latitude across GDS profiles — geographic distribution center of mass (used for portfolio geographic analysis)."
    - name: "profiles_with_meeting_facilities_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN has_meeting_facilities = TRUE THEN gds_profile_id END) / NULLIF(COUNT(DISTINCT gds_profile_id), 0), 2)
      comment: "Percentage of GDS profiles advertising meeting facilities — group sales content coverage KPI."
    - name: "ada_compliant_profile_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_ada_compliant = TRUE THEN gds_profile_id END) / NULLIF(COUNT(DISTINCT gds_profile_id), 0), 2)
      comment: "Percentage of GDS profiles marked ADA compliant — accessibility content accuracy KPI for regulatory and brand compliance."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Organizational hierarchy and portfolio structure metrics — used by corporate finance, brand leadership, and operations to understand reporting node structure, geographic distribution, and management type composition across the portfolio hierarchy."
  source: "`vibe_travel_hospitality_v1`.`property`.`hierarchy`"
  dimensions:
    - name: "node_type"
      expr: node_type
      comment: "Type of hierarchy node (e.g., Region, Division, Brand, Property) — primary grouping for organizational structure analysis."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level of the node within the hierarchy — used to filter analysis to specific organizational tiers."
    - name: "management_type"
      expr: management_type
      comment: "Management type at this hierarchy node (e.g., Managed, Franchised, Owned) — used for portfolio composition analysis."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the hierarchy node — used for regional performance roll-ups."
    - name: "node_status"
      expr: node_status
      comment: "Current status of the hierarchy node — used to filter active vs. inactive organizational units."
    - name: "is_reporting_node"
      expr: is_reporting_node
      comment: "Flag indicating whether this node is a financial reporting node — used to identify nodes included in consolidated financial reporting."
    - name: "is_str_market_node"
      expr: is_str_market_node
      comment: "Flag indicating whether this node maps to an STR market — used for competitive benchmarking alignment."
    - name: "kpi_rollup_method"
      expr: kpi_rollup_method
      comment: "Method used to roll up KPIs at this node — used by finance to validate aggregation logic in reporting."
    - name: "chain_scale"
      expr: chain_scale
      comment: "Chain scale classification at this hierarchy node — used for brand-tier performance benchmarking."
  measures:
    - name: "total_hierarchy_nodes"
      expr: COUNT(1)
      comment: "Total number of hierarchy nodes — baseline count for organizational structure tracking."
    - name: "reporting_node_count"
      expr: COUNT(CASE WHEN is_reporting_node = TRUE THEN 1 END)
      comment: "Number of financial reporting nodes — used by corporate finance to validate the reporting structure and ensure complete coverage."
    - name: "str_market_node_count"
      expr: COUNT(CASE WHEN is_str_market_node = TRUE THEN 1 END)
      comment: "Number of STR market nodes — used by revenue strategy to confirm competitive benchmarking coverage across the portfolio."
    - name: "distinct_geographic_regions"
      expr: COUNT(DISTINCT geographic_region)
      comment: "Number of distinct geographic regions represented in the hierarchy — used by corporate leadership to assess geographic diversification of the portfolio."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_legal_entity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Legal Entity business metrics"
  source: "`travel_hospitality_ecm`.`property`.`legal_entity`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dissolution Date"
      expr: dissolution_date
    - name: "Doing Business As Name"
      expr: doing_business_as_name
    - name: "Duns Number"
      expr: duns_number
    - name: "Entity Subtype"
      expr: entity_subtype
    - name: "Entity Type"
      expr: entity_type
    - name: "Fiscal Year End Day"
      expr: fiscal_year_end_day
    - name: "Fiscal Year End Month"
      expr: fiscal_year_end_month
    - name: "Franchisee Name"
      expr: franchisee_name
    - name: "Functional Currency Code"
      expr: functional_currency_code
    - name: "Incorporation Date"
      expr: incorporation_date
    - name: "Incorporation Jurisdiction"
      expr: incorporation_jurisdiction
    - name: "Is Franchise Entity"
      expr: is_franchise_entity
    - name: "Is Publicly Traded"
      expr: is_publicly_traded
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Legal Name"
      expr: legal_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Legal Entity"
      expr: COUNT(DISTINCT legal_entity_id)
    - name: "Total Ownership Percentage"
      expr: SUM(ownership_percentage)
    - name: "Average Ownership Percentage"
      expr: AVG(ownership_percentage)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_media`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media business metrics"
  source: "`travel_hospitality_ecm`.`property`.`media`"
  dimensions:
    - name: "Alt Text"
      expr: alt_text
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Aspect Ratio"
      expr: aspect_ratio
    - name: "Asset Code"
      expr: asset_code
    - name: "Brand Website Approved"
      expr: brand_website_approved
    - name: "Caption"
      expr: caption
    - name: "Capture Date"
      expr: capture_date
    - name: "Cdn Path"
      expr: cdn_path
    - name: "Copyright Holder"
      expr: copyright_holder
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Display Order"
      expr: display_order
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "File Format"
      expr: file_format
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Media"
      expr: COUNT(DISTINCT media_id)
    - name: "Total File Size Kb"
      expr: SUM(file_size_kb)
    - name: "Average File Size Kb"
      expr: AVG(file_size_kb)
    - name: "Total View Count"
      expr: SUM(view_count)
    - name: "Average View Count"
      expr: AVG(view_count)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_meeting_space`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Meeting space inventory and revenue capacity metrics — used by group sales, events, and revenue management to assess meeting space portfolio, capacity utilization potential, and pricing tier distribution."
  source: "`vibe_travel_hospitality_v1`.`property`.`meeting_space`"
  dimensions:
    - name: "space_type"
      expr: space_type
      comment: "Type of meeting space (e.g., Ballroom, Boardroom, Breakout Room) — primary grouping for group sales capacity analysis."
    - name: "meeting_space_status"
      expr: meeting_space_status
      comment: "Current operational status of the meeting space — used to identify available vs. offline inventory."
    - name: "rental_rate_tier"
      expr: rental_rate_tier
      comment: "Rental rate tier for the meeting space — used by group sales to segment pricing strategy."
    - name: "divisible"
      expr: divisible
      comment: "Flag indicating whether the space can be divided — used for flexible inventory planning in group sales."
    - name: "wifi_available"
      expr: wifi_available
      comment: "Flag indicating WiFi availability — used as a qualification criterion for technology-dependent events."
    - name: "catering_required"
      expr: catering_required
      comment: "Flag indicating whether catering is required when booking the space — used for F&B revenue attachment analysis."
    - name: "accessibility_compliant"
      expr: accessibility_compliant
      comment: "ADA/accessibility compliance flag — used for compliance tracking and inclusive event planning."
    - name: "floor_level"
      expr: floor_level
      comment: "Floor level of the meeting space — used for operational logistics and event planning."
  measures:
    - name: "total_meeting_spaces"
      expr: COUNT(1)
      comment: "Total number of meeting spaces — baseline count for group sales inventory tracking."
    - name: "total_meeting_space_sqft"
      expr: SUM(CAST(total_square_footage AS DOUBLE))
      comment: "Total meeting space square footage — primary group sales capacity KPI used in RFP responses and competitive positioning."
    - name: "avg_meeting_space_sqft"
      expr: AVG(CAST(total_square_footage AS DOUBLE))
      comment: "Average meeting space size in square feet — used to benchmark space sizing against competitive set."
    - name: "avg_minimum_rental_hours"
      expr: AVG(CAST(minimum_rental_hours AS DOUBLE))
      comment: "Average minimum rental hours across meeting spaces — used by group sales to understand booking constraints and optimize space utilization."
    - name: "avg_minimum_catering_spend"
      expr: AVG(CAST(minimum_catering_spend AS DOUBLE))
      comment: "Average minimum catering spend requirement — used by F&B and group sales to forecast catering revenue attachment from meeting space bookings."
    - name: "avg_ceiling_height_feet"
      expr: AVG(CAST(ceiling_height_feet AS DOUBLE))
      comment: "Average ceiling height in feet — used for event qualification (e.g., trade shows, productions requiring height clearance)."
    - name: "divisible_space_count"
      expr: COUNT(CASE WHEN divisible = TRUE THEN 1 END)
      comment: "Number of divisible meeting spaces — used by group sales to quantify flexible inventory for multi-session events."
    - name: "active_meeting_space_count"
      expr: COUNT(CASE WHEN meeting_space_status = 'Active' OR meeting_space_status = 'Available' THEN 1 END)
      comment: "Number of currently active/available meeting spaces — used by group sales to confirm bookable inventory."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_ownership_entity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ownership entity portfolio and compliance metrics — used by asset management, legal, and finance to track ownership structure, portfolio scale, regulatory compliance status, and investment vehicle composition."
  source: "`vibe_travel_hospitality_v1`.`property`.`ownership_entity`"
  dimensions:
    - name: "entity_type"
      expr: entity_type
      comment: "Legal entity type of the ownership entity (e.g., REIT, Private Equity, Individual) — used to analyze portfolio by ownership structure."
    - name: "ownership_status"
      expr: ownership_status
      comment: "Current status of the ownership entity — used to filter active vs. dissolved ownership entities."
    - name: "reit_compliance_flag"
      expr: reit_compliance_flag
      comment: "Flag indicating REIT compliance requirement — used by finance and legal to track REIT-regulated ownership entities."
    - name: "sox_compliance_required"
      expr: sox_compliance_required
      comment: "Flag indicating SOX compliance requirement — used by internal audit to identify entities subject to Sarbanes-Oxley controls."
    - name: "registered_country_code"
      expr: registered_country_code
      comment: "Country of registration for the ownership entity — used for jurisdictional compliance and tax analysis."
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year the ownership entity acquired its portfolio — used for investment vintage analysis."
  measures:
    - name: "total_ownership_entities"
      expr: COUNT(1)
      comment: "Total number of ownership entities — baseline count for ownership structure tracking."
    - name: "reit_compliant_entity_count"
      expr: COUNT(CASE WHEN reit_compliance_flag = TRUE THEN 1 END)
      comment: "Number of REIT-compliant ownership entities — used by finance and legal to track REIT portfolio exposure and compliance obligations."
    - name: "sox_required_entity_count"
      expr: COUNT(CASE WHEN sox_compliance_required = TRUE THEN 1 END)
      comment: "Number of entities subject to SOX compliance — used by internal audit to scope SOX control testing and reporting obligations."
    - name: "avg_portfolio_acquisition_value_usd"
      expr: AVG(CAST(portfolio_acquisition_value_usd AS DOUBLE))
      comment: "Average portfolio acquisition value in USD — used by asset management and investment committees to benchmark ownership entity scale."
    - name: "total_portfolio_acquisition_value_usd"
      expr: SUM(CAST(portfolio_acquisition_value_usd AS DOUBLE))
      comment: "Total portfolio acquisition value across all ownership entities — used by finance and ownership to report total invested capital in the portfolio."
    - name: "distinct_ownership_entity_types"
      expr: COUNT(DISTINCT entity_type)
      comment: "Number of distinct ownership entity types — used by legal and finance to assess ownership structure diversity and associated compliance complexity."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_party`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Party business metrics"
  source: "`travel_hospitality_ecm`.`property`.`party`"
  dimensions:
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "City"
      expr: city
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Rating"
      expr: credit_rating
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Employee Count"
      expr: employee_count
    - name: "Fax Number"
      expr: fax_number
    - name: "Incorporation Country Code"
      expr: incorporation_country_code
    - name: "Incorporation Date"
      expr: incorporation_date
    - name: "Industry Classification Code"
      expr: industry_classification_code
    - name: "Is Publicly Traded"
      expr: is_publicly_traded
    - name: "Is Tax Exempt"
      expr: is_tax_exempt
    - name: "Legal Name"
      expr: legal_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Party"
      expr: COUNT(DISTINCT party_id)
    - name: "Total Annual Revenue Amount"
      expr: SUM(annual_revenue_amount)
    - name: "Average Annual Revenue Amount"
      expr: AVG(annual_revenue_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_pip_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PIP line-item execution metrics — used by project managers, procurement, and asset management to track individual work-item cost, status, and compliance at the granular level."
  source: "`vibe_travel_hospitality_v1`.`property`.`pip_item`"
  dimensions:
    - name: "item_status"
      expr: item_status
      comment: "Execution status of the individual PIP line item (e.g., Pending, In Progress, Completed, Deferred) — primary filter for active work tracking."
    - name: "work_type"
      expr: work_type
      comment: "Type of work for the PIP item (e.g., Construction, FF&E, Technology) — used to categorize spend by work category."
    - name: "ffe_category"
      expr: ffe_category
      comment: "FF&E category of the item — used by procurement to aggregate sourcing requirements by category."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the PIP item — used to triage deferred items and manage brand-compliance risk."
    - name: "brand_requirement_flag"
      expr: brand_requirement_flag
      comment: "Flag indicating whether the item is a mandatory brand requirement — used to separate brand-compliance CapEx from discretionary spend."
    - name: "life_safety_flag"
      expr: life_safety_flag
      comment: "Flag indicating whether the item is a life-safety requirement — used for regulatory compliance tracking and risk management."
    - name: "sustainability_flag"
      expr: sustainability_flag
      comment: "Flag indicating whether the item supports sustainability goals — used for ESG reporting."
    - name: "property_area"
      expr: property_area
      comment: "Physical area of the property affected by the PIP item (e.g., Guestrooms, Lobby, F&B) — used to analyze spend distribution across property zones."
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Outcome of the most recent inspection for this item — used to track quality assurance pass/fail rates."
  measures:
    - name: "total_pip_items"
      expr: COUNT(1)
      comment: "Total number of PIP line items — baseline count for work-order volume tracking."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost across all PIP line items — used to validate bottom-up cost estimates against top-down approved budget."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all PIP line items — primary CapEx spend tracking KPI at the work-item level."
    - name: "cost_variance"
      expr: SUM((CAST(actual_cost AS DOUBLE)) - (CAST(estimated_cost AS DOUBLE)))
      comment: "Aggregate cost variance (actual minus estimated) at line-item level — used to identify cost-overrun patterns by work type or contractor."
    - name: "life_safety_item_count"
      expr: COUNT(CASE WHEN life_safety_flag = TRUE THEN 1 END)
      comment: "Count of life-safety PIP items — used by compliance and risk management to ensure critical safety work is prioritized and completed."
    - name: "brand_requirement_item_count"
      expr: COUNT(CASE WHEN brand_requirement_flag = TRUE THEN 1 END)
      comment: "Count of mandatory brand-requirement PIP items — used by franchise operations to track brand-standard compliance exposure."
    - name: "deferred_item_count"
      expr: COUNT(CASE WHEN item_status = 'Deferred' THEN 1 END)
      comment: "Number of deferred PIP items — used by asset management to quantify deferred maintenance risk and future CapEx liability."
    - name: "avg_estimated_cost_per_item"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per PIP line item — used for benchmarking unit costs across contractors and work types."
    - name: "inspection_required_item_count"
      expr: COUNT(CASE WHEN inspection_required_flag = TRUE THEN 1 END)
      comment: "Count of items requiring formal inspection — used by project management to schedule inspection resources and avoid compliance delays."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_pip_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property Improvement Plan financial and execution metrics — used by asset management, ownership, and brand compliance teams to track CapEx commitments, budget adherence, and brand-standard compliance across the portfolio."
  source: "`vibe_travel_hospitality_v1`.`property`.`pip_plan`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current execution status of the PIP project (e.g., In Progress, Completed, On Hold) — primary filter for active CapEx tracking."
    - name: "project_type"
      expr: project_type
      comment: "Type of PIP project (e.g., Brand Compliance, Life Safety, Revenue Enhancement) — used to categorize CapEx by strategic driver."
    - name: "brand_compliance_status"
      expr: brand_compliance_status
      comment: "Brand compliance status of the PIP — used by franchise operations to identify properties at risk of brand-standard violation."
    - name: "ada_compliance_included"
      expr: ada_compliance_included
      comment: "Flag indicating whether ADA compliance work is included in the PIP — used for regulatory risk tracking."
    - name: "fire_safety_upgrade_included"
      expr: fire_safety_upgrade_included
      comment: "Flag indicating whether fire safety upgrades are included — used for life-safety compliance reporting."
    - name: "scheduled_start_year"
      expr: YEAR(scheduled_start_date)
      comment: "Year the PIP is scheduled to start — used for CapEx pipeline planning by fiscal year."
    - name: "projected_completion_year"
      expr: YEAR(projected_completion_date)
      comment: "Year the PIP is projected to complete — used for CapEx cash-flow forecasting."
  measures:
    - name: "total_pip_plans"
      expr: COUNT(1)
      comment: "Total number of PIP plans — baseline count for portfolio-wide CapEx program tracking."
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget AS DOUBLE))
      comment: "Total approved CapEx budget across all PIP plans — primary CapEx commitment KPI used by ownership and finance in board-level reporting."
    - name: "total_actual_spend_to_date"
      expr: SUM(CAST(actual_spend_to_date AS DOUBLE))
      comment: "Total actual spend incurred to date across all PIP plans — used alongside approved budget to compute burn rate and forecast to-complete."
    - name: "total_ffe_budget"
      expr: SUM(CAST(ffe_budget AS DOUBLE))
      comment: "Total FF&E (Furniture, Fixtures & Equipment) budget — used by procurement and asset management to plan FF&E sourcing and vendor commitments."
    - name: "total_ffe_actual_spend"
      expr: SUM(CAST(ffe_actual_spend AS DOUBLE))
      comment: "Total FF&E actual spend — compared against FF&E budget to track procurement execution efficiency."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average PIP completion percentage across active plans — used by asset management to assess portfolio-wide renovation progress."
    - name: "total_revenue_displacement_estimate"
      expr: SUM(CAST(revenue_displacement_estimate AS DOUBLE))
      comment: "Total estimated revenue displaced by PIP construction activity — used by revenue management to quantify the opportunity cost of CapEx programs."
    - name: "avg_expected_roi_pct"
      expr: AVG(CAST(expected_roi_percentage AS DOUBLE))
      comment: "Average expected ROI percentage across PIP plans — used by ownership and investment committees to prioritize CapEx allocation."
    - name: "total_opex_impact_estimate"
      expr: SUM(CAST(opex_impact_estimate AS DOUBLE))
      comment: "Total estimated OpEx impact from PIP projects — used by finance to adjust operating expense forecasts post-renovation."
    - name: "budget_variance"
      expr: SUM((CAST(actual_spend_to_date AS DOUBLE)) - (CAST(approved_budget AS DOUBLE)))
      comment: "Aggregate budget variance (actual minus approved) — negative values indicate under-spend; positive values signal cost overruns requiring ownership escalation."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core property portfolio metrics covering operational status, brand distribution, physical inventory, and star-rating quality — used by asset management, brand leadership, and revenue strategy to steer portfolio decisions."
  source: "`vibe_travel_hospitality_v1`.`property`.`property`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the property (e.g., Open, Closed, Under Renovation) — primary filter for active-portfolio analysis."
    - name: "brand_code"
      expr: brand_code
      comment: "Brand code assigned to the property — used to slice portfolio KPIs by brand family."
    - name: "brand_tier"
      expr: brand_tier
      comment: "Brand tier classification (e.g., Luxury, Upper-Upscale, Select-Service) — drives segment-level benchmarking."
    - name: "property_type"
      expr: property_type
      comment: "Physical property type (e.g., Full-Service Hotel, Resort, Extended-Stay) — used for peer-group comparisons."
    - name: "country_code"
      expr: country_code
      comment: "ISO country code of the property — enables geographic portfolio roll-ups."
    - name: "state_province"
      expr: state_province
      comment: "State or province of the property — sub-national geographic dimension."
    - name: "city"
      expr: city
      comment: "City where the property is located — market-level grouping."
    - name: "is_franchised"
      expr: is_franchised
      comment: "Boolean flag indicating whether the property operates under a franchise agreement — differentiates managed vs. franchised portfolio."
    - name: "pip_status"
      expr: pip_status
      comment: "Current Property Improvement Plan status — used by asset management to track brand-compliance capital programs."
    - name: "segment_classification"
      expr: segment_classification
      comment: "Market segment classification of the property — used for competitive benchmarking and revenue strategy."
    - name: "opening_year"
      expr: YEAR(opening_date)
      comment: "Year the property opened — used to analyze portfolio age and renovation cycle timing."
    - name: "last_renovation_year"
      expr: YEAR(last_renovation_date)
      comment: "Year of the most recent renovation — used to identify properties approaching next renovation cycle."
  measures:
    - name: "total_properties"
      expr: COUNT(1)
      comment: "Total number of property records — baseline portfolio count used in every executive portfolio dashboard."
    - name: "active_properties"
      expr: COUNT(CASE WHEN operational_status = 'Open' THEN 1 END)
      comment: "Count of properties currently in Open/active operational status — the investable portfolio denominator for yield and performance KPIs."
    - name: "franchised_property_count"
      expr: COUNT(CASE WHEN is_franchised = TRUE THEN 1 END)
      comment: "Number of franchised properties — used by brand leadership to track franchise vs. managed split and royalty revenue exposure."
    - name: "avg_star_rating"
      expr: AVG(CAST(star_rating AS DOUBLE))
      comment: "Average star rating across the portfolio — quality signal used by brand and asset management to assess portfolio positioning."
    - name: "pip_required_properties"
      expr: COUNT(CASE WHEN pip_status IS NOT NULL AND pip_status != 'Completed' AND pip_status != 'Not Required' THEN 1 END)
      comment: "Number of properties with an active or pending PIP — capital planning KPI used by asset management and ownership to size CapEx exposure."
    - name: "properties_closed_or_under_renovation"
      expr: COUNT(CASE WHEN operational_status IN ('Closed', 'Under Renovation', 'Temporarily Closed') THEN 1 END)
      comment: "Properties currently offline — used by revenue leadership to quantify displaced inventory and plan recovery timelines."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_property`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property business metrics"
  source: "`travel_hospitality_ecm`.`property`.`property`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Brand Code"
      expr: brand_code
    - name: "Brand Name"
      expr: brand_name
    - name: "Brand Tier"
      expr: brand_tier
    - name: "City"
      expr: city
    - name: "Closure Date"
      expr: closure_date
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dos Email"
      expr: dos_email
    - name: "Dos Name"
      expr: dos_name
    - name: "Franchise Agreement Number"
      expr: franchise_agreement_number
    - name: "Gds Property Code"
      expr: gds_property_code
    - name: "Gm Email"
      expr: gm_email
    - name: "Gm Name"
      expr: gm_name
    - name: "Is Franchised"
      expr: is_franchised
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Property"
      expr: COUNT(DISTINCT property_id)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Star Rating"
      expr: SUM(star_rating)
    - name: "Average Star Rating"
      expr: AVG(star_rating)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property facility operational and financial metrics — used by operations, asset management, and revenue teams to track facility utilization, fee revenue, compliance status, and renovation pipeline."
  source: "`vibe_travel_hospitality_v1`.`property`.`property_facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (e.g., Pool, Fitness Center, Spa, Parking) — primary grouping for facility portfolio analysis."
    - name: "facility_category"
      expr: facility_category
      comment: "Category of the facility — used for sub-type grouping within facility types."
    - name: "property_facility_status"
      expr: property_facility_status
      comment: "Current operational status of the facility — used to identify offline facilities impacting guest experience."
    - name: "is_fee_based"
      expr: is_fee_based
      comment: "Flag indicating whether the facility charges a usage fee — used to segment revenue-generating vs. complimentary facilities."
    - name: "is_ada_compliant"
      expr: is_ada_compliant
      comment: "ADA compliance flag — used for regulatory compliance tracking and risk management."
    - name: "is_seasonal"
      expr: is_seasonal
      comment: "Flag indicating whether the facility operates seasonally — used for operational planning and staffing."
    - name: "renovation_status"
      expr: renovation_status
      comment: "Current renovation status of the facility — used by asset management to track renovation pipeline."
    - name: "outdoor_indoor"
      expr: outdoor_indoor
      comment: "Whether the facility is outdoor or indoor — used for operational planning and guest experience analysis."
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of property facilities — baseline count for facility portfolio tracking."
    - name: "active_facilities"
      expr: COUNT(CASE WHEN property_facility_status = 'Active' OR property_facility_status = 'Open' THEN 1 END)
      comment: "Number of currently active/open facilities — used by operations to confirm guest-facing amenity availability."
    - name: "fee_based_facility_count"
      expr: COUNT(CASE WHEN is_fee_based = TRUE THEN 1 END)
      comment: "Number of fee-based facilities — used by revenue management to identify ancillary revenue opportunities."
    - name: "total_usage_fee_revenue_potential"
      expr: SUM(CAST(usage_fee_amount AS DOUBLE))
      comment: "Sum of usage fee amounts across fee-based facilities — used as a proxy for ancillary revenue potential from facility charges."
    - name: "avg_area_sqft"
      expr: AVG(CAST(area_sqft AS DOUBLE))
      comment: "Average facility area in square feet — used by asset management to benchmark facility sizing and renovation scope."
    - name: "total_area_sqft"
      expr: SUM(CAST(area_sqft AS DOUBLE))
      comment: "Total facility area in square feet across the portfolio — used for asset valuation and insurance purposes."
    - name: "non_ada_compliant_facility_count"
      expr: COUNT(CASE WHEN is_ada_compliant = FALSE THEN 1 END)
      comment: "Number of facilities not ADA compliant — critical compliance risk KPI; drives remediation prioritization and legal risk management."
    - name: "facilities_under_renovation"
      expr: COUNT(CASE WHEN renovation_status IN ('In Progress', 'Planned', 'Active') THEN 1 END)
      comment: "Number of facilities currently under or planned for renovation — used by operations to manage guest experience impact and communicate amenity availability."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_property_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property Facility business metrics"
  source: "`travel_hospitality_ecm`.`property`.`property_facility`"
  dimensions:
    - name: "Ada Features"
      expr: ada_features
    - name: "Age Restriction"
      expr: age_restriction
    - name: "Av Equipment Available"
      expr: av_equipment_available
    - name: "Building Wing"
      expr: building_wing
    - name: "Capacity"
      expr: capacity
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dress Code"
      expr: dress_code
    - name: "Facility Category"
      expr: facility_category
    - name: "Facility Code"
      expr: facility_code
    - name: "Facility Name"
      expr: facility_name
    - name: "Facility Type"
      expr: facility_type
    - name: "Floor Number"
      expr: floor_number
    - name: "Inspection Result"
      expr: inspection_result
    - name: "Is 24 Hour"
      expr: is_24_hour
    - name: "Is Ada Compliant"
      expr: is_ada_compliant
    - name: "Is Fee Based"
      expr: is_fee_based
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Property Facility"
      expr: COUNT(DISTINCT property_facility_id)
    - name: "Total Area Sqft"
      expr: SUM(area_sqft)
    - name: "Average Area Sqft"
      expr: AVG(area_sqft)
    - name: "Total Max Occupancy Pct"
      expr: SUM(max_occupancy_pct)
    - name: "Average Max Occupancy Pct"
      expr: AVG(max_occupancy_pct)
    - name: "Total Usage Fee Amount"
      expr: SUM(usage_fee_amount)
    - name: "Average Usage Fee Amount"
      expr: AVG(usage_fee_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_outlet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property outlet (restaurant, bar, retail) operational and revenue metrics — used by F&B leadership, revenue management, and operations to assess outlet performance, pricing, and capacity."
  source: "`vibe_travel_hospitality_v1`.`property`.`property_outlet`"
  dimensions:
    - name: "outlet_type"
      expr: outlet_type
      comment: "Type of outlet (restaurant, bar, cafe, retail, spa) for F&B portfolio mix analysis."
    - name: "outlet_status"
      expr: outlet_status
      comment: "Current operational status of the outlet (open, closed, seasonal)."
    - name: "cuisine_type"
      expr: cuisine_type
      comment: "Cuisine type for restaurant outlets — used for competitive positioning and guest preference analysis."
    - name: "seasonal_operation_flag"
      expr: seasonal_operation_flag
      comment: "Whether the outlet operates seasonally — capacity and staffing planning indicator."
    - name: "loyalty_points_eligible_flag"
      expr: loyalty_points_eligible_flag
      comment: "Whether purchases at this outlet earn loyalty points — loyalty program integration KPI."
    - name: "mobile_ordering_enabled_flag"
      expr: mobile_ordering_enabled_flag
      comment: "Whether mobile ordering is enabled — digital capability indicator for guest experience and operational efficiency."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level outlet analysis."
    - name: "alcohol_service_flag"
      expr: alcohol_service_flag
      comment: "Whether the outlet serves alcohol — revenue mix and licensing compliance indicator."
  measures:
    - name: "total_outlets"
      expr: COUNT(DISTINCT property_outlet_id)
      comment: "Total number of property outlets — F&B and retail portfolio size KPI."
    - name: "avg_average_check_amount"
      expr: AVG(CAST(average_check_amount AS DOUBLE))
      comment: "Average check amount across outlets — revenue yield KPI for F&B pricing strategy and competitive benchmarking."
    - name: "avg_service_charge_percentage"
      expr: AVG(CAST(service_charge_percentage AS DOUBLE))
      comment: "Average service charge percentage — labor cost recovery KPI for F&B financial planning."
    - name: "active_outlet_count"
      expr: COUNT(DISTINCT CASE WHEN outlet_status = 'open' THEN property_outlet_id END)
      comment: "Count of currently open outlets — active revenue-generating F&B asset count."
    - name: "loyalty_eligible_outlet_count"
      expr: COUNT(DISTINCT CASE WHEN loyalty_points_eligible_flag = TRUE THEN property_outlet_id END)
      comment: "Count of outlets participating in the loyalty program — loyalty integration breadth KPI for member engagement strategy."
    - name: "mobile_ordering_outlet_count"
      expr: COUNT(DISTINCT CASE WHEN mobile_ordering_enabled_flag = TRUE THEN property_outlet_id END)
      comment: "Count of outlets with mobile ordering enabled — digital transformation KPI for guest experience and operational efficiency."
    - name: "mobile_ordering_adoption_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN mobile_ordering_enabled_flag = TRUE THEN property_outlet_id END) / NULLIF(COUNT(DISTINCT property_outlet_id), 0), 2)
      comment: "Percentage of outlets with mobile ordering — digital capability adoption rate for technology investment decisions."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_property_outlet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property Outlet business metrics"
  source: "`travel_hospitality_ecm`.`property`.`property_outlet`"
  dimensions:
    - name: "Alcohol Service Flag"
      expr: alcohol_service_flag
    - name: "Closure Date"
      expr: closure_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cuisine Type"
      expr: cuisine_type
    - name: "Delivery Service Available Flag"
      expr: delivery_service_available_flag
    - name: "Dress Code"
      expr: dress_code
    - name: "Floor Number"
      expr: floor_number
    - name: "Gratuity Policy"
      expr: gratuity_policy
    - name: "Health Permit Number"
      expr: health_permit_number
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Renovation Date"
      expr: last_renovation_date
    - name: "Liquor License Number"
      expr: liquor_license_number
    - name: "Location Description"
      expr: location_description
    - name: "Loyalty Points Eligible Flag"
      expr: loyalty_points_eligible_flag
    - name: "Menu Url"
      expr: menu_url
    - name: "Mobile Ordering Enabled Flag"
      expr: mobile_ordering_enabled_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Property Outlet"
      expr: COUNT(DISTINCT property_outlet_id)
    - name: "Total Average Check Amount"
      expr: SUM(average_check_amount)
    - name: "Average Average Check Amount"
      expr: AVG(average_check_amount)
    - name: "Total Service Charge Percentage"
      expr: SUM(service_charge_percentage)
    - name: "Average Service Charge Percentage"
      expr: AVG(service_charge_percentage)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_property_space_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property Space Allocation business metrics"
  source: "`travel_hospitality_ecm`.`property`.`property_space_allocation`"
  dimensions:
    - name: "Allocation Created Timestamp"
      expr: allocation_created_timestamp
    - name: "Allocation Date"
      expr: allocation_date
    - name: "Allocation Modified Timestamp"
      expr: allocation_modified_timestamp
    - name: "Allocation Status"
      expr: allocation_status
    - name: "End Time"
      expr: end_time
    - name: "Guaranteed Attendance"
      expr: guaranteed_attendance
    - name: "Setup Style"
      expr: setup_style
    - name: "Special Requirements"
      expr: special_requirements
    - name: "Start Time"
      expr: start_time
    - name: "Allocation Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', allocation_created_timestamp)
    - name: "Allocation Date Month"
      expr: DATE_TRUNC('MONTH', allocation_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Property Space Allocation"
      expr: COUNT(DISTINCT property_space_allocation_id)
    - name: "Total Rental Charge"
      expr: SUM(rental_charge)
    - name: "Average Rental Charge"
      expr: AVG(rental_charge)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_seasonal_calendar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Seasonal demand and performance forecast metrics — used by revenue management, sales, and operations to plan staffing, pricing strategy, and inventory allocation across seasonal demand cycles."
  source: "`vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`"
  dimensions:
    - name: "season_name"
      expr: season_name
      comment: "Name of the season (e.g., Peak Summer, Holiday, Shoulder) — primary grouping for seasonal performance analysis."
    - name: "season_year"
      expr: season_year
      comment: "Year of the seasonal calendar entry — used for year-over-year seasonal comparison."
    - name: "demand_classification"
      expr: demand_classification
      comment: "Demand classification for the period (e.g., High, Medium, Low) — used by revenue management to set pricing strategy."
    - name: "is_blackout_date"
      expr: is_blackout_date
      comment: "Flag indicating whether the period is a blackout date — used to exclude periods from promotional rate eligibility."
    - name: "is_holiday_period"
      expr: is_holiday_period
      comment: "Flag indicating whether the period is a holiday — used to plan staffing and special event programming."
    - name: "seasonal_hiring_required"
      expr: seasonal_hiring_required
      comment: "Flag indicating whether seasonal hiring is required — used by HR and operations to plan workforce ramp-up."
    - name: "market_segment_focus"
      expr: market_segment_focus
      comment: "Primary market segment targeted during this season — used by sales to align channel and segment strategy."
    - name: "operating_status"
      expr: operating_status
      comment: "Operating status during the seasonal period — used to identify reduced-operation periods affecting revenue capacity."
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the seasonal period starts — used for time-series analysis of seasonal patterns."
  measures:
    - name: "total_seasonal_periods"
      expr: COUNT(1)
      comment: "Total number of seasonal calendar entries — baseline count for calendar coverage analysis."
    - name: "avg_estimated_occupancy_pct"
      expr: AVG(CAST(estimated_occupancy_pct AS DOUBLE))
      comment: "Average estimated occupancy percentage across seasonal periods — used by revenue management to set inventory and pricing strategy for each season."
    - name: "avg_estimated_adr"
      expr: AVG(CAST(estimated_adr AS DOUBLE))
      comment: "Average estimated ADR (Average Daily Rate) across seasonal periods — used by revenue management to validate rate strategy against seasonal demand forecasts."
    - name: "avg_estimated_revpar"
      expr: AVG(CAST(estimated_revpar AS DOUBLE))
      comment: "Average estimated RevPAR across seasonal periods — the primary revenue performance forecast KPI used in revenue strategy and ownership reporting."
    - name: "avg_cancellation_rate_pct"
      expr: AVG(CAST(cancellation_rate_pct AS DOUBLE))
      comment: "Average estimated cancellation rate by season — used by revenue management to set overbooking levels and cancellation policy thresholds."
    - name: "avg_no_show_rate_pct"
      expr: AVG(CAST(no_show_rate_pct AS DOUBLE))
      comment: "Average estimated no-show rate by season — used alongside cancellation rate to calibrate overbooking strategy."
    - name: "avg_rgi_target"
      expr: AVG(CAST(rgi_target AS DOUBLE))
      comment: "Average Revenue Generation Index target — used by revenue management to set competitive performance benchmarks against the STR comp set."
    - name: "avg_yoy_demand_variance_pct"
      expr: AVG(CAST(yoy_demand_variance_pct AS DOUBLE))
      comment: "Average year-over-year demand variance percentage — used by revenue and sales leadership to identify demand trend shifts requiring strategy adjustment."
    - name: "blackout_period_count"
      expr: COUNT(CASE WHEN is_blackout_date = TRUE THEN 1 END)
      comment: "Number of blackout date periods — used by channel management to configure rate restrictions and loyalty redemption blackouts."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_vendor_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property-level vendor agreement performance and financial metrics — used by procurement, operations, and finance to track vendor relationship health, discount capture, and performance ratings at the property level."
  source: "`vibe_travel_hospitality_v1`.`property`.`vendor_agreement`"
  dimensions:
    - name: "relationship_status"
      expr: relationship_status
      comment: "Current status of the vendor relationship (e.g., Active, Terminated, On Hold) — primary filter for active vendor agreement analysis."
    - name: "preferred_vendor_tier"
      expr: preferred_vendor_tier
      comment: "Preferred vendor tier classification — used by procurement to prioritize vendor relationships and negotiate volume discounts."
    - name: "payment_terms_override"
      expr: payment_terms_override
      comment: "Property-specific payment terms override — used by finance to identify non-standard payment arrangements."
    - name: "relationship_start_year"
      expr: YEAR(relationship_start_date)
      comment: "Year the vendor relationship started — used to analyze vendor tenure and relationship longevity."
    - name: "last_performance_review_year"
      expr: YEAR(last_performance_review_date)
      comment: "Year of the most recent vendor performance review — used to identify vendors overdue for review."
  measures:
    - name: "total_vendor_agreements"
      expr: COUNT(1)
      comment: "Total number of property-vendor agreements — baseline count for vendor relationship portfolio tracking."
    - name: "active_vendor_agreements"
      expr: COUNT(CASE WHEN relationship_status = 'Active' THEN 1 END)
      comment: "Number of currently active vendor agreements — used by procurement to size the active vendor base per property."
    - name: "avg_performance_rating"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average vendor performance rating — used by procurement to identify underperforming vendors and drive contract renegotiation or replacement decisions."
    - name: "avg_property_specific_discount_pct"
      expr: AVG(CAST(property_specific_discount_pct AS DOUBLE))
      comment: "Average property-specific discount percentage negotiated with vendors — used by procurement to benchmark discount capture across properties."
    - name: "total_minimum_order_value"
      expr: SUM(CAST(minimum_order_value AS DOUBLE))
      comment: "Total minimum order value commitments across vendor agreements — used by finance to quantify committed procurement spend obligations."
    - name: "vendors_without_recent_review"
      expr: COUNT(CASE WHEN last_performance_review_date < DATE_ADD(CURRENT_DATE(), -365) OR last_performance_review_date IS NULL THEN 1 END)
      comment: "Number of vendor agreements without a performance review in the past 12 months — used by procurement to prioritize vendor review scheduling and manage relationship risk."
    - name: "avg_delivery_lead_time_days"
      expr: AVG(CAST(delivery_lead_time_days AS DOUBLE))
      comment: "Average delivery lead time in days across vendor agreements — used by operations and procurement to plan inventory replenishment and avoid stockouts."
$$;
