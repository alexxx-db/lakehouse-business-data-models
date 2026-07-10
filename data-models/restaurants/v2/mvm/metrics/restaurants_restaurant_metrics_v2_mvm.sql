-- Metric views for domain: restaurant | Business: Restaurants | Version: 2 | Generated on: 2026-07-10 19:59:49

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_brand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand-level strategic KPIs including market share, franchise economics, and brand portfolio performance metrics that drive investment and expansion decisions."
  source: "`vibe_restaurants_v1`.`restaurant`.`brand`"
  dimensions:
    - name: "brand_name"
      expr: name
      comment: "Brand name for segmentation and reporting"
    - name: "brand_category"
      expr: category
      comment: "Brand category (e.g., QSR, Fast Casual, Fine Dining) for competitive analysis"
    - name: "brand_segment"
      expr: segment
      comment: "Brand segment for market positioning analysis"
    - name: "brand_type"
      expr: brand_type
      comment: "Brand type classification for portfolio management"
    - name: "primary_market_region"
      expr: primary_market_region
      comment: "Primary market region for geographic performance analysis"
    - name: "headquarters_country"
      expr: headquarters_country_code
      comment: "Headquarters country for international operations analysis"
    - name: "franchise_allowed_flag"
      expr: franchise_allowed
      comment: "Whether franchise model is enabled for growth strategy analysis"
    - name: "brand_status"
      expr: brand_status
      comment: "Current brand operational status for portfolio health monitoring"
    - name: "established_year"
      expr: YEAR(established_date)
      comment: "Year brand was established for maturity analysis"
  measures:
    - name: "brand_count"
      expr: COUNT(DISTINCT brand_id)
      comment: "Number of distinct brands in portfolio for portfolio size tracking"
    - name: "total_market_share_pct"
      expr: SUM(CAST(market_share_percent AS DOUBLE))
      comment: "Aggregate market share percentage across brands for competitive positioning"
    - name: "avg_market_share_pct"
      expr: AVG(CAST(market_share_percent AS DOUBLE))
      comment: "Average market share per brand for portfolio strength assessment"
    - name: "total_annual_sales_usd"
      expr: SUM(CAST(average_annual_sales_usd AS DOUBLE))
      comment: "Total annual sales across all brands for revenue performance"
    - name: "avg_annual_sales_per_brand_usd"
      expr: AVG(CAST(average_annual_sales_usd AS DOUBLE))
      comment: "Average annual sales per brand for brand performance benchmarking"
    - name: "avg_check_amount_usd"
      expr: AVG(CAST(average_check_amount_usd AS DOUBLE))
      comment: "Average check amount across brands for pricing strategy analysis"
    - name: "avg_store_size_sqft"
      expr: AVG(CAST(average_store_size_sqft AS DOUBLE))
      comment: "Average store footprint for real estate and format strategy"
    - name: "avg_franchise_fee_pct"
      expr: AVG(CAST(franchise_fee_percent AS DOUBLE))
      comment: "Average franchise fee percentage for franchise economics analysis"
    - name: "avg_royalty_fee_pct"
      expr: AVG(CAST(royalty_fee_percent AS DOUBLE))
      comment: "Average royalty fee percentage for ongoing franchise revenue modeling"
    - name: "franchise_enabled_brand_count"
      expr: COUNT(DISTINCT CASE WHEN franchise_allowed = TRUE THEN brand_id END)
      comment: "Count of franchise-enabled brands for growth model assessment"
    - name: "franchise_penetration_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN franchise_allowed = TRUE THEN brand_id END) / NULLIF(COUNT(DISTINCT brand_id), 0), 2)
      comment: "Percentage of brands offering franchise model for portfolio expansion strategy"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Restaurant unit-level operational KPIs including sales performance, throughput efficiency, speed of service, and same-store sales growth that drive operational excellence and site-level P&L decisions."
  source: "`vibe_restaurants_v1`.`restaurant`.`unit`"
  dimensions:
    - name: "unit_number"
      expr: unit_number
      comment: "Unique unit identifier for site-level analysis"
    - name: "trade_name"
      expr: trade_name
      comment: "Trade name of the unit for brand variant analysis"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status for fleet health monitoring"
    - name: "ownership_model"
      expr: ownership_model
      comment: "Ownership model (corporate vs franchise) for performance comparison"
    - name: "concept_type"
      expr: concept_type
      comment: "Concept type for format performance analysis"
    - name: "country_code"
      expr: country_code
      comment: "Country code for geographic performance segmentation"
    - name: "state_province"
      expr: state_province
      comment: "State or province for regional performance analysis"
    - name: "city"
      expr: city
      comment: "City for local market analysis"
    - name: "has_drive_thru"
      expr: CASE WHEN drive_thru_lanes IS NOT NULL AND drive_thru_lanes != '0' THEN TRUE ELSE FALSE END
      comment: "Drive-thru presence flag for format mix analysis"
    - name: "has_online_ordering"
      expr: has_online_ordering
      comment: "Online ordering capability for digital channel analysis"
    - name: "has_third_party_delivery"
      expr: has_third_party_delivery
      comment: "Third-party delivery integration for omnichannel strategy"
    - name: "opening_year"
      expr: YEAR(opening_date)
      comment: "Year unit opened for vintage cohort analysis"
    - name: "unit_age_years"
      expr: CAST(DATEDIFF(CURRENT_DATE(), opening_date) / 365.25 AS INT)
      comment: "Unit age in years for maturity and remodel planning"
  measures:
    - name: "unit_count"
      expr: COUNT(DISTINCT unit_id)
      comment: "Total number of restaurant units for fleet size tracking"
    - name: "active_unit_count"
      expr: COUNT(DISTINCT CASE WHEN operational_status = 'Active' THEN unit_id END)
      comment: "Count of active units for operational capacity assessment"
    - name: "total_unit_volume_usd"
      expr: SUM(CAST(average_unit_volume_usd AS DOUBLE))
      comment: "Total sales volume across all units for top-line revenue performance"
    - name: "avg_unit_volume_usd"
      expr: AVG(CAST(average_unit_volume_usd AS DOUBLE))
      comment: "Average unit volume (AUV) for site productivity benchmarking and investment decisions"
    - name: "avg_same_store_sales_pct"
      expr: AVG(CAST(same_store_sales_pct AS DOUBLE))
      comment: "Average same-store sales growth percentage for organic growth measurement"
    - name: "avg_speed_of_service_seconds"
      expr: AVG(CAST(speed_of_service_seconds AS DOUBLE))
      comment: "Average speed of service in seconds for customer experience and throughput optimization"
    - name: "avg_table_turn_rate"
      expr: AVG(CAST(table_turn_rate AS DOUBLE))
      comment: "Average table turn rate for dine-in capacity utilization"
    - name: "avg_seating_capacity"
      expr: AVG(CAST(seating_capacity AS DOUBLE))
      comment: "Average seating capacity per unit for format sizing strategy"
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average unit square footage for real estate efficiency analysis"
    - name: "sales_per_sqft_usd"
      expr: ROUND(SUM(CAST(average_unit_volume_usd AS DOUBLE)) / NULLIF(SUM(CAST(square_footage AS DOUBLE)), 0), 2)
      comment: "Sales per square foot for real estate productivity and site selection ROI"
    - name: "drive_thru_penetration_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN drive_thru_lanes IS NOT NULL AND drive_thru_lanes != '0' THEN unit_id END) / NULLIF(COUNT(DISTINCT unit_id), 0), 2)
      comment: "Percentage of units with drive-thru for format mix strategy"
    - name: "digital_enabled_unit_count"
      expr: COUNT(DISTINCT CASE WHEN has_online_ordering = TRUE OR has_third_party_delivery = TRUE THEN unit_id END)
      comment: "Count of digitally-enabled units for omnichannel transformation tracking"
    - name: "digital_penetration_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN has_online_ordering = TRUE OR has_third_party_delivery = TRUE THEN unit_id END) / NULLIF(COUNT(DISTINCT unit_id), 0), 2)
      comment: "Percentage of units with digital ordering for digital strategy progress"
    - name: "haccp_certified_unit_count"
      expr: COUNT(DISTINCT CASE WHEN haccp_certified = TRUE THEN unit_id END)
      comment: "Count of HACCP-certified units for food safety compliance tracking"
    - name: "haccp_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN haccp_certified = TRUE THEN unit_id END) / NULLIF(COUNT(DISTINCT unit_id), 0), 2)
      comment: "Percentage of units HACCP-certified for regulatory compliance and risk management"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_equipment_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment asset management KPIs including acquisition costs, depreciation, maintenance efficiency, and asset utilization that drive capital planning and operational reliability decisions."
  source: "`vibe_restaurants_v1`.`restaurant`.`equipment_asset`"
  dimensions:
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment for asset class analysis"
    - name: "equipment_category"
      expr: equipment_category
      comment: "Equipment category for portfolio segmentation"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status for asset availability tracking"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (owned vs leased) for capital structure analysis"
    - name: "asset_condition_rating"
      expr: asset_condition_rating
      comment: "Asset condition rating for replacement planning"
    - name: "manufacturer_name"
      expr: manufacturer_name
      comment: "Manufacturer name for vendor performance and warranty analysis"
    - name: "energy_rating"
      expr: energy_rating
      comment: "Energy efficiency rating for sustainability and cost optimization"
    - name: "temperature_critical_flag"
      expr: temperature_critical_flag
      comment: "Temperature-critical equipment flag for food safety risk management"
    - name: "installation_year"
      expr: YEAR(installation_date)
      comment: "Year equipment was installed for age cohort analysis"
    - name: "asset_age_years"
      expr: CAST(DATEDIFF(CURRENT_DATE(), installation_date) / 365.25 AS INT)
      comment: "Equipment age in years for lifecycle and replacement planning"
  measures:
    - name: "equipment_asset_count"
      expr: COUNT(DISTINCT equipment_asset_id)
      comment: "Total number of equipment assets for fleet size tracking"
    - name: "operational_asset_count"
      expr: COUNT(DISTINCT CASE WHEN operational_status = 'Operational' THEN equipment_asset_id END)
      comment: "Count of operational assets for availability and uptime analysis"
    - name: "total_acquisition_cost_usd"
      expr: SUM(CAST(acquisition_cost_usd AS DOUBLE))
      comment: "Total acquisition cost of equipment for capital investment tracking"
    - name: "avg_acquisition_cost_usd"
      expr: AVG(CAST(acquisition_cost_usd AS DOUBLE))
      comment: "Average acquisition cost per asset for budgeting and procurement strategy"
    - name: "total_replacement_cost_usd"
      expr: SUM(CAST(replacement_cost_usd AS DOUBLE))
      comment: "Total replacement cost for capital reserve planning"
    - name: "avg_replacement_cost_usd"
      expr: AVG(CAST(replacement_cost_usd AS DOUBLE))
      comment: "Average replacement cost per asset for lifecycle budgeting"
    - name: "avg_maintenance_frequency_days"
      expr: AVG(CAST(maintenance_frequency_days AS DOUBLE))
      comment: "Average maintenance frequency in days for preventive maintenance scheduling"
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life in years for depreciation and replacement planning"
    - name: "temperature_critical_asset_count"
      expr: COUNT(DISTINCT CASE WHEN temperature_critical_flag = TRUE THEN equipment_asset_id END)
      comment: "Count of temperature-critical assets for food safety risk prioritization"
    - name: "temperature_critical_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN temperature_critical_flag = TRUE THEN equipment_asset_id END) / NULLIF(COUNT(DISTINCT equipment_asset_id), 0), 2)
      comment: "Percentage of temperature-critical assets for food safety compliance focus"
    - name: "leased_asset_count"
      expr: COUNT(DISTINCT CASE WHEN ownership_type = 'Leased' THEN equipment_asset_id END)
      comment: "Count of leased assets for capital structure analysis"
    - name: "lease_penetration_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN ownership_type = 'Leased' THEN equipment_asset_id END) / NULLIF(COUNT(DISTINCT equipment_asset_id), 0), 2)
      comment: "Percentage of leased assets for financing strategy and balance sheet optimization"
    - name: "avg_power_consumption_watts"
      expr: AVG(CAST(power_consumption_watts AS DOUBLE))
      comment: "Average power consumption in watts for energy cost modeling and sustainability"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_kitchen_station`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Kitchen station operational KPIs including throughput capacity, speed of service, ticket time, and station utilization that drive labor scheduling, layout optimization, and service quality decisions."
  source: "`vibe_restaurants_v1`.`restaurant`.`kitchen_station`"
  dimensions:
    - name: "station_name"
      expr: station_name
      comment: "Kitchen station name for station-level performance analysis"
    - name: "station_type"
      expr: station_type
      comment: "Station type for functional area analysis"
    - name: "station_code"
      expr: station_code
      comment: "Station code for standardized reporting"
    - name: "kitchen_station_status"
      expr: kitchen_station_status
      comment: "Current station status for operational availability tracking"
    - name: "is_automated"
      expr: is_automated
      comment: "Automation flag for technology adoption and labor efficiency analysis"
    - name: "temperature_control_flag"
      expr: temperature_control
      comment: "Temperature control requirement for food safety compliance"
    - name: "health_inspection_status"
      expr: health_inspection_status
      comment: "Health inspection status for compliance and risk management"
  measures:
    - name: "kitchen_station_count"
      expr: COUNT(DISTINCT kitchen_station_id)
      comment: "Total number of kitchen stations for capacity planning"
    - name: "active_station_count"
      expr: COUNT(DISTINCT CASE WHEN kitchen_station_status = 'Active' THEN kitchen_station_id END)
      comment: "Count of active stations for operational capacity assessment"
    - name: "total_station_area_sqft"
      expr: SUM(CAST(area_sqft AS DOUBLE))
      comment: "Total kitchen station area for space utilization analysis"
    - name: "avg_station_area_sqft"
      expr: AVG(CAST(area_sqft AS DOUBLE))
      comment: "Average station area for layout design and efficiency benchmarking"
    - name: "avg_ticket_time_seconds"
      expr: AVG(CAST(average_ticket_time_seconds AS DOUBLE))
      comment: "Average ticket time in seconds for kitchen throughput and customer wait time optimization"
    - name: "avg_speed_of_service_seconds"
      expr: AVG(CAST(speed_of_service_sos_seconds AS DOUBLE))
      comment: "Average speed of service in seconds for operational efficiency and customer satisfaction"
    - name: "avg_throughput_per_hour"
      expr: AVG(CAST(throughput_per_hour AS DOUBLE))
      comment: "Average throughput per hour for capacity planning and labor scheduling"
    - name: "avg_capacity_dishes"
      expr: AVG(CAST(capacity_dishes AS DOUBLE))
      comment: "Average dish capacity per station for volume planning and peak demand management"
    - name: "avg_power_rating_kw"
      expr: AVG(CAST(power_rating_kw AS DOUBLE))
      comment: "Average power rating in kilowatts for energy cost modeling and infrastructure planning"
    - name: "automated_station_count"
      expr: COUNT(DISTINCT CASE WHEN is_automated = TRUE THEN kitchen_station_id END)
      comment: "Count of automated stations for technology adoption tracking"
    - name: "automation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_automated = TRUE THEN kitchen_station_id END) / NULLIF(COUNT(DISTINCT kitchen_station_id), 0), 2)
      comment: "Percentage of automated stations for labor efficiency and technology ROI analysis"
    - name: "temperature_controlled_station_count"
      expr: COUNT(DISTINCT CASE WHEN temperature_control = TRUE THEN kitchen_station_id END)
      comment: "Count of temperature-controlled stations for food safety compliance"
    - name: "avg_maintenance_interval_days"
      expr: AVG(CAST(maintenance_interval_days AS DOUBLE))
      comment: "Average maintenance interval in days for preventive maintenance scheduling and downtime minimization"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_pos_terminal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "POS terminal operational and compliance KPIs including terminal availability, payment capability mix, PCI compliance, and maintenance efficiency that drive payment processing reliability and security decisions."
  source: "`vibe_restaurants_v1`.`restaurant`.`pos_terminal`"
  dimensions:
    - name: "terminal_name"
      expr: terminal_name
      comment: "POS terminal name for device-level tracking"
    - name: "terminal_type"
      expr: terminal_type
      comment: "Terminal type for device class analysis"
    - name: "station_type"
      expr: station_type
      comment: "Station type for location-based performance analysis"
    - name: "service_channel"
      expr: service_channel
      comment: "Service channel (dine-in, drive-thru, etc.) for channel mix analysis"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status for uptime and availability tracking"
    - name: "pos_terminal_status"
      expr: pos_terminal_status
      comment: "POS terminal status for fleet health monitoring"
    - name: "pci_compliance_status"
      expr: pci_compliance_status
      comment: "PCI compliance status for security and regulatory risk management"
    - name: "is_active"
      expr: is_active
      comment: "Active flag for operational capacity assessment"
    - name: "manufacturer"
      expr: manufacturer
      comment: "Manufacturer for vendor performance and support analysis"
    - name: "payment_processing_vendor"
      expr: payment_processing_vendor
      comment: "Payment processor for vendor relationship and cost analysis"
    - name: "supports_mobile_wallet"
      expr: supports_mobile_wallet
      comment: "Mobile wallet support for digital payment adoption"
    - name: "supports_contactless"
      expr: supports_contactless
      comment: "Contactless payment support for customer convenience and transaction speed"
  measures:
    - name: "pos_terminal_count"
      expr: COUNT(DISTINCT pos_terminal_id)
      comment: "Total number of POS terminals for fleet size and capacity planning"
    - name: "active_terminal_count"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN pos_terminal_id END)
      comment: "Count of active terminals for operational capacity and uptime tracking"
    - name: "operational_terminal_count"
      expr: COUNT(DISTINCT CASE WHEN operational_status = 'Operational' THEN pos_terminal_id END)
      comment: "Count of operational terminals for service availability assessment"
    - name: "terminal_availability_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN operational_status = 'Operational' THEN pos_terminal_id END) / NULLIF(COUNT(DISTINCT pos_terminal_id), 0), 2)
      comment: "Percentage of operational terminals for uptime and reliability measurement"
    - name: "pci_compliant_terminal_count"
      expr: COUNT(DISTINCT CASE WHEN pci_compliance_status = 'Compliant' THEN pos_terminal_id END)
      comment: "Count of PCI-compliant terminals for security compliance tracking"
    - name: "pci_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN pci_compliance_status = 'Compliant' THEN pos_terminal_id END) / NULLIF(COUNT(DISTINCT pos_terminal_id), 0), 2)
      comment: "Percentage of PCI-compliant terminals for regulatory risk management and audit readiness"
    - name: "mobile_wallet_enabled_count"
      expr: COUNT(DISTINCT CASE WHEN supports_mobile_wallet = TRUE THEN pos_terminal_id END)
      comment: "Count of mobile wallet-enabled terminals for digital payment adoption"
    - name: "mobile_wallet_penetration_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN supports_mobile_wallet = TRUE THEN pos_terminal_id END) / NULLIF(COUNT(DISTINCT pos_terminal_id), 0), 2)
      comment: "Percentage of terminals supporting mobile wallets for customer experience and transaction speed optimization"
    - name: "contactless_enabled_count"
      expr: COUNT(DISTINCT CASE WHEN supports_contactless = TRUE THEN pos_terminal_id END)
      comment: "Count of contactless-enabled terminals for payment innovation tracking"
    - name: "contactless_penetration_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN supports_contactless = TRUE THEN pos_terminal_id END) / NULLIF(COUNT(DISTINCT pos_terminal_id), 0), 2)
      comment: "Percentage of contactless-enabled terminals for customer convenience and throughput improvement"
    - name: "chip_enabled_count"
      expr: COUNT(DISTINCT CASE WHEN supports_chip = TRUE THEN pos_terminal_id END)
      comment: "Count of chip-enabled terminals for EMV compliance and fraud reduction"
    - name: "nfc_enabled_count"
      expr: COUNT(DISTINCT CASE WHEN supports_nfc = TRUE THEN pos_terminal_id END)
      comment: "Count of NFC-enabled terminals for tap-to-pay capability"
    - name: "olo_enabled_count"
      expr: COUNT(DISTINCT CASE WHEN supports_olo = TRUE THEN pos_terminal_id END)
      comment: "Count of online ordering-enabled terminals for omnichannel integration"
    - name: "avg_maintenance_frequency_days"
      expr: AVG(CAST(maintenance_frequency_days AS DOUBLE))
      comment: "Average maintenance frequency in days for preventive maintenance planning and downtime reduction"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_operating_hours`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operating hours and daypart performance KPIs including coverage capacity, throughput targets, speed of service benchmarks, and schedule optimization metrics that drive labor planning and revenue maximization decisions."
  source: "`vibe_restaurants_v1`.`restaurant`.`operating_hours`"
  dimensions:
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week for weekly pattern analysis"
    - name: "daypart"
      expr: daypart
      comment: "Daypart (breakfast, lunch, dinner, late night) for time-of-day performance analysis"
    - name: "schedule_type"
      expr: schedule_type
      comment: "Schedule type for operational planning segmentation"
    - name: "schedule_status"
      expr: schedule_status
      comment: "Schedule status for active schedule tracking"
    - name: "is_24_hour_operation"
      expr: is_24_hour_operation
      comment: "24-hour operation flag for extended hours strategy analysis"
    - name: "is_closed"
      expr: is_closed
      comment: "Closed flag for closure pattern analysis"
    - name: "holiday_schedule_override_flag"
      expr: holiday_schedule_override_flag
      comment: "Holiday override flag for special event planning"
    - name: "seasonal_adjustment_flag"
      expr: seasonal_adjustment_flag
      comment: "Seasonal adjustment flag for demand variability management"
    - name: "holiday_name"
      expr: holiday_name
      comment: "Holiday name for holiday performance analysis"
    - name: "seasonal_period_name"
      expr: seasonal_period_name
      comment: "Seasonal period for seasonal demand planning"
  measures:
    - name: "operating_schedule_count"
      expr: COUNT(DISTINCT operating_hours_id)
      comment: "Total number of operating schedules for schedule complexity tracking"
    - name: "active_schedule_count"
      expr: COUNT(DISTINCT CASE WHEN schedule_status = 'Active' THEN operating_hours_id END)
      comment: "Count of active schedules for current operational coverage"
    - name: "avg_expected_cover_count"
      expr: AVG(CAST(expected_cover_count AS DOUBLE))
      comment: "Average expected cover count per schedule for demand forecasting and capacity planning"
    - name: "total_expected_cover_count"
      expr: SUM(CAST(expected_cover_count AS DOUBLE))
      comment: "Total expected cover count for aggregate demand planning"
    - name: "avg_expected_table_turn_count"
      expr: AVG(CAST(expected_table_turn_count AS DOUBLE))
      comment: "Average expected table turns for dine-in capacity utilization and revenue optimization"
    - name: "avg_throughput_capacity_per_hour"
      expr: AVG(CAST(throughput_capacity_per_hour AS DOUBLE))
      comment: "Average throughput capacity per hour for labor scheduling and peak demand management"
    - name: "avg_target_speed_of_service_seconds"
      expr: AVG(CAST(target_speed_of_service_seconds AS DOUBLE))
      comment: "Average target speed of service in seconds for service quality benchmarking and operational standards"
    - name: "avg_target_ticket_time_seconds"
      expr: AVG(CAST(target_ticket_time_seconds AS DOUBLE))
      comment: "Average target ticket time in seconds for kitchen efficiency and customer satisfaction targets"
    - name: "twenty_four_hour_schedule_count"
      expr: COUNT(DISTINCT CASE WHEN is_24_hour_operation = TRUE THEN operating_hours_id END)
      comment: "Count of 24-hour schedules for extended hours strategy tracking"
    - name: "twenty_four_hour_penetration_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_24_hour_operation = TRUE THEN operating_hours_id END) / NULLIF(COUNT(DISTINCT operating_hours_id), 0), 2)
      comment: "Percentage of 24-hour schedules for late-night revenue opportunity assessment"
    - name: "holiday_override_schedule_count"
      expr: COUNT(DISTINCT CASE WHEN holiday_schedule_override_flag = TRUE THEN operating_hours_id END)
      comment: "Count of holiday override schedules for special event planning"
    - name: "seasonal_adjustment_schedule_count"
      expr: COUNT(DISTINCT CASE WHEN seasonal_adjustment_flag = TRUE THEN operating_hours_id END)
      comment: "Count of seasonally-adjusted schedules for demand variability management"
$$;