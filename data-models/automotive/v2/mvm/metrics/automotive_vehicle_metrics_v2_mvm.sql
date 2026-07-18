-- Metric views for domain: vehicle | Business: Automotive | Version: 2 | Generated on: 2026-07-14 04:28:06

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_build_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production build specifications tracking vehicle manufacturing quality, compliance, and configuration metrics"
  source: "`vibe_automotive_v1`.`vehicle`.`build_spec`"
  dimensions:
    - name: "build_year"
      expr: YEAR(build_date)
      comment: "Year the vehicle was built"
    - name: "build_month"
      expr: DATE_TRUNC('MONTH', build_date)
      comment: "Month the vehicle was built"
    - name: "build_spec_status"
      expr: build_spec_status
      comment: "Current status of the build specification (e.g., completed, in-progress, failed)"
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant code where vehicle was built"
    - name: "production_line"
      expr: production_line
      comment: "Specific production line within the plant"
    - name: "emissions_rating"
      expr: emissions_rating
      comment: "Emissions compliance rating"
    - name: "ncap_rating"
      expr: ncap_rating
      comment: "NCAP safety rating"
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status for the build"
    - name: "fleet_spec_flag"
      expr: fleet_spec_flag
      comment: "Whether this is a fleet specification vehicle"
    - name: "special_order_flag"
      expr: special_order_flag
      comment: "Whether this is a special order build"
    - name: "ota_updatable_flag"
      expr: ota_updatable_flag
      comment: "Whether the vehicle supports over-the-air software updates"
    - name: "v2x_enabled_flag"
      expr: v2x_enabled_flag
      comment: "Whether vehicle-to-everything communication is enabled"
  measures:
    - name: "total_vehicles_built"
      expr: COUNT(DISTINCT build_spec_id)
      comment: "Total number of unique vehicles built - key production volume metric"
    - name: "avg_fuel_efficiency_mpg"
      expr: AVG(CAST(fuel_efficiency_mpg AS DOUBLE))
      comment: "Average fuel efficiency across builds - critical for fleet CAFE compliance and environmental targets"
    - name: "avg_co2_emissions"
      expr: AVG(CAST(REGEXP_REPLACE(co2_emissions_g_per_km, '[^0-9.]', '') AS DOUBLE))
      comment: "Average CO2 emissions in g/km - regulatory compliance and sustainability KPI"
    - name: "avg_vehicle_weight_kg"
      expr: AVG(CAST(vehicle_weight_kg AS DOUBLE))
      comment: "Average vehicle weight - impacts fuel economy, safety ratings, and material costs"
    - name: "ota_capable_vehicle_count"
      expr: SUM(CAST(CASE WHEN ota_updatable_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of OTA-capable vehicles - strategic metric for connected vehicle services revenue potential"
    - name: "v2x_enabled_vehicle_count"
      expr: SUM(CAST(CASE WHEN v2x_enabled_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of V2X-enabled vehicles - future mobility and autonomous driving readiness indicator"
    - name: "fleet_vehicle_count"
      expr: SUM(CAST(CASE WHEN fleet_spec_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of fleet specification vehicles - B2B sales channel performance"
    - name: "special_order_count"
      expr: SUM(CAST(CASE WHEN special_order_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of special order builds - customization demand and premium revenue indicator"
    - name: "regulatory_approved_count"
      expr: SUM(CAST(CASE WHEN regulatory_approval_status = 'Approved' THEN 1 ELSE 0 END AS INT))
      comment: "Count of regulatory-approved builds - compliance and time-to-market quality metric"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_configuration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle configuration catalog metrics tracking pricing, market positioning, and product mix performance"
  source: "`vibe_automotive_v1`.`vehicle`.`configuration`"
  dimensions:
    - name: "model_year"
      expr: model_year
      comment: "Model year of the configuration"
    - name: "body_style"
      expr: body_style
      comment: "Body style (sedan, SUV, truck, etc.)"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type (gasoline, diesel, electric, hybrid)"
    - name: "drivetrain"
      expr: drivetrain
      comment: "Drivetrain configuration (FWD, RWD, AWD, 4WD)"
    - name: "transmission_type"
      expr: transmission_type
      comment: "Transmission type (automatic, manual, CVT)"
    - name: "market_region"
      expr: market_region
      comment: "Target market region"
    - name: "market_country_code"
      expr: market_country_code
      comment: "Target market country code"
    - name: "exterior_color"
      expr: exterior_color
      comment: "Exterior color option"
    - name: "interior_material"
      expr: interior_material
      comment: "Interior material type"
    - name: "build_feasibility_status"
      expr: build_feasibility_status
      comment: "Build feasibility status"
    - name: "emissions_cert_status"
      expr: emissions_cert_status
      comment: "Emissions certification status"
    - name: "record_status"
      expr: record_status
      comment: "Configuration record status (active, discontinued, etc.)"
  measures:
    - name: "total_configurations"
      expr: COUNT(DISTINCT configuration_id)
      comment: "Total number of unique vehicle configurations - product portfolio complexity metric"
    - name: "avg_msrp_amount"
      expr: AVG(CAST(msrp_amount AS DOUBLE))
      comment: "Average MSRP across configurations - pricing strategy and market positioning KPI"
    - name: "total_msrp_value"
      expr: SUM(CAST(msrp_amount AS DOUBLE))
      comment: "Total MSRP value of all configurations - portfolio value metric"
    - name: "avg_total_price"
      expr: AVG(CAST(total_price AS DOUBLE))
      comment: "Average total price including options and destination - actual transaction price indicator"
    - name: "avg_destination_charge"
      expr: AVG(CAST(destination_charge AS DOUBLE))
      comment: "Average destination charge - logistics cost component"
    - name: "avg_fuel_economy_city"
      expr: AVG(CAST(fuel_economy_city_mpg AS DOUBLE))
      comment: "Average city fuel economy - urban efficiency and regulatory compliance metric"
    - name: "avg_fuel_economy_highway"
      expr: AVG(CAST(fuel_economy_hwy_mpg AS DOUBLE))
      comment: "Average highway fuel economy - long-distance efficiency metric"
    - name: "avg_co2_emissions"
      expr: AVG(CAST(REGEXP_REPLACE(co2_emissions_g_per_km, '[^0-9.]', '') AS DOUBLE))
      comment: "Average CO2 emissions across configurations - environmental impact and compliance KPI"
    - name: "electric_range_avg_miles"
      expr: AVG(CAST(REGEXP_REPLACE(ev_range_miles, '[^0-9.]', '') AS DOUBLE))
      comment: "Average electric vehicle range - EV competitiveness and technology advancement metric"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_homologation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory homologation and certification tracking metrics for compliance management and market readiness"
  source: "`vibe_automotive_v1`.`vehicle`.`homologation`"
  dimensions:
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year of regulatory approval"
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month of regulatory approval"
    - name: "approval_type"
      expr: approval_type
      comment: "Type of regulatory approval"
    - name: "authority_name"
      expr: authority_name
      comment: "Regulatory authority granting approval"
    - name: "category"
      expr: homologation_category
      comment: "Homologation category"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework under which approval was granted"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the homologation"
    - name: "is_active"
      expr: is_active
      comment: "Whether the homologation is currently active"
    - name: "is_ota_updatable"
      expr: is_ota_updatable
      comment: "Whether the homologation supports OTA updates"
    - name: "scope"
      expr: scope
      comment: "Scope of the homologation"
  measures:
    - name: "total_homologations"
      expr: COUNT(DISTINCT homologation_id)
      comment: "Total number of homologation records - regulatory compliance coverage metric"
    - name: "active_homologations"
      expr: SUM(CAST(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of active homologations - current market access capability"
    - name: "expired_homologations"
      expr: SUM(CASE WHEN expiry_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of expired homologations - compliance risk and renewal workload indicator"
    - name: "ota_updatable_homologations"
      expr: SUM(CAST(CASE WHEN is_ota_updatable = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of OTA-updatable homologations - software-defined vehicle regulatory flexibility"
    - name: "avg_days_to_approval"
      expr: AVG(DATEDIFF(approval_date, certification_status_date))
      comment: "Average days from certification status to approval - regulatory process efficiency KPI"
    - name: "avg_validity_period_days"
      expr: AVG(DATEDIFF(expiry_date, approval_date))
      comment: "Average validity period of homologations - regulatory stability metric"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_lifecycle_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle lifecycle event tracking for operational visibility, quality monitoring, and supply chain performance"
  source: "`vibe_automotive_v1`.`vehicle`.`lifecycle_event`"
  dimensions:
    - name: "event_year"
      expr: YEAR(event_timestamp)
      comment: "Year the event occurred"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month the event occurred"
    - name: "event_date"
      expr: DATE_TRUNC('DAY', event_timestamp)
      comment: "Date the event occurred"
    - name: "event_type"
      expr: event_type
      comment: "Type of lifecycle event"
    - name: "event_subtype"
      expr: event_subtype
      comment: "Subtype of lifecycle event"
    - name: "event_category"
      expr: event_category
      comment: "Category of lifecycle event"
    - name: "event_status"
      expr: event_status
      comment: "Status of the event"
    - name: "event_location_country"
      expr: event_location_country
      comment: "Country where event occurred"
    - name: "event_location_state"
      expr: event_location_state
      comment: "State where event occurred"
    - name: "event_location_city"
      expr: event_location_city
      comment: "City where event occurred"
    - name: "event_source_system"
      expr: event_source_system
      comment: "Source system that generated the event"
    - name: "triggering_system"
      expr: triggering_system
      comment: "System that triggered the event"
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the event is flagged as critical"
  measures:
    - name: "total_lifecycle_events"
      expr: COUNT(DISTINCT lifecycle_event_id)
      comment: "Total number of lifecycle events - operational activity volume metric"
    - name: "unique_vehicles_tracked"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of unique vehicles with lifecycle events - tracking coverage metric"
    - name: "critical_events_count"
      expr: SUM(CAST(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of critical lifecycle events - quality and risk management KPI"
    - name: "avg_odometer_reading_km"
      expr: AVG(CAST(odometer_reading_km AS DOUBLE))
      comment: "Average odometer reading at event time - vehicle usage intensity metric"
    - name: "total_odometer_km"
      expr: SUM(CAST(odometer_reading_km AS DOUBLE))
      comment: "Total odometer kilometers across all events - fleet utilization metric"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle model catalog metrics for product portfolio management, pricing strategy, and market competitiveness"
  source: "`vibe_automotive_v1`.`vehicle`.`model`"
  dimensions:
    - name: "brand_name"
      expr: brand_name
      comment: "Brand name"
    - name: "model_name"
      expr: model_name
      comment: "Model name"
    - name: "body_style"
      expr: body_style
      comment: "Body style"
    - name: "segment"
      expr: segment
      comment: "Market segment"
    - name: "vehicle_class"
      expr: vehicle_class
      comment: "Vehicle class"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type (ICE, hybrid, electric)"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type"
    - name: "transmission_type"
      expr: transmission_type
      comment: "Transmission type"
    - name: "drive_configuration"
      expr: drive_configuration
      comment: "Drive configuration (FWD, RWD, AWD)"
    - name: "launch_model_year"
      expr: launch_model_year
      comment: "Model year of launch"
    - name: "model_status"
      expr: model_status
      comment: "Current model status (active, discontinued, etc.)"
    - name: "homologation_status"
      expr: homologation_status
      comment: "Homologation status"
    - name: "emissions_standard"
      expr: emissions_standard
      comment: "Emissions standard compliance"
    - name: "ncap_safety_rating"
      expr: ncap_safety_rating
      comment: "NCAP safety rating"
    - name: "primary_market"
      expr: primary_market
      comment: "Primary target market"
  measures:
    - name: "total_models"
      expr: COUNT(DISTINCT model_id)
      comment: "Total number of vehicle models - product portfolio breadth metric"
    - name: "avg_msrp_usd"
      expr: AVG(CAST(msrp_usd AS DOUBLE))
      comment: "Average MSRP across models - brand positioning and pricing strategy KPI"
    - name: "total_portfolio_msrp"
      expr: SUM(CAST(msrp_usd AS DOUBLE))
      comment: "Total MSRP value of model portfolio - portfolio value metric"
    - name: "avg_fuel_economy_city"
      expr: AVG(CAST(fuel_economy_city_mpg AS DOUBLE))
      comment: "Average city fuel economy - fleet CAFE compliance and efficiency metric"
    - name: "avg_fuel_economy_highway"
      expr: AVG(CAST(fuel_economy_hwy_mpg AS DOUBLE))
      comment: "Average highway fuel economy - efficiency and competitiveness metric"
    - name: "avg_co2_emissions"
      expr: AVG(CAST(co2_emissions_g_per_km AS DOUBLE))
      comment: "Average CO2 emissions - environmental compliance and sustainability KPI"
    - name: "avg_electric_range_miles"
      expr: AVG(CAST(electric_range_miles AS DOUBLE))
      comment: "Average electric range for EV/PHEV models - electrification competitiveness metric"
    - name: "avg_battery_capacity_kwh"
      expr: AVG(CAST(battery_capacity_kwh AS DOUBLE))
      comment: "Average battery capacity - EV technology advancement metric"
    - name: "avg_curb_weight_kg"
      expr: AVG(CAST(curb_weight_kg AS DOUBLE))
      comment: "Average curb weight - lightweighting and efficiency indicator"
    - name: "avg_cargo_capacity_liters"
      expr: AVG(CAST(cargo_capacity_liters AS DOUBLE))
      comment: "Average cargo capacity - utility and customer value metric"
    - name: "avg_wheelbase_mm"
      expr: AVG(CAST(wheelbase_mm AS DOUBLE))
      comment: "Average wheelbase - interior space and ride quality indicator"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_msrp_pricing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MSRP pricing analytics for revenue optimization, market strategy, and incentive program management"
  source: "`vibe_automotive_v1`.`vehicle`.`msrp_pricing`"
  dimensions:
    - name: "model_year"
      expr: model_year
      comment: "Model year for pricing"
    - name: "market_region"
      expr: market_region
      comment: "Market region"
    - name: "market_country_code"
      expr: market_country_code
      comment: "Market country code"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for pricing"
    - name: "price_type"
      expr: price_type
      comment: "Type of price (base, package, total, etc.)"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type"
    - name: "msrp_pricing_status"
      expr: msrp_pricing_status
      comment: "Pricing record status"
    - name: "ev_tax_credit_eligibility_flag"
      expr: ev_tax_credit_eligibility_flag
      comment: "Whether eligible for EV tax credit"
    - name: "gas_guzzler_tax_flag"
      expr: gas_guzzler_tax_flag
      comment: "Whether subject to gas guzzler tax"
    - name: "destination_charge_flag"
      expr: destination_charge_flag
      comment: "Whether destination charge applies"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year pricing became effective"
  measures:
    - name: "total_pricing_records"
      expr: COUNT(DISTINCT msrp_pricing_id)
      comment: "Total number of pricing records - pricing complexity and SKU count metric"
    - name: "avg_price_amount"
      expr: AVG(CAST(price_amount AS DOUBLE))
      comment: "Average price across all pricing records - portfolio pricing level KPI"
    - name: "total_price_value"
      expr: SUM(CAST(price_amount AS DOUBLE))
      comment: "Total price value of all records - portfolio revenue potential"
    - name: "avg_destination_charge"
      expr: AVG(CAST(destination_charge_amount AS DOUBLE))
      comment: "Average destination charge - logistics cost component"
    - name: "total_destination_charges"
      expr: SUM(CAST(destination_charge_amount AS DOUBLE))
      comment: "Total destination charges - logistics revenue stream"
    - name: "avg_ev_tax_credit"
      expr: AVG(CAST(ev_tax_credit_amount AS DOUBLE))
      comment: "Average EV tax credit - electrification incentive impact metric"
    - name: "total_ev_tax_credits"
      expr: SUM(CAST(ev_tax_credit_amount AS DOUBLE))
      comment: "Total EV tax credits - government incentive value for portfolio"
    - name: "avg_gas_guzzler_tax"
      expr: AVG(CAST(gas_guzzler_tax_amount AS DOUBLE))
      comment: "Average gas guzzler tax - regulatory penalty impact"
    - name: "total_gas_guzzler_tax"
      expr: SUM(CAST(gas_guzzler_tax_amount AS DOUBLE))
      comment: "Total gas guzzler tax exposure - regulatory cost burden"
    - name: "avg_price_uplift"
      expr: AVG(CAST(price_uplift_amount AS DOUBLE))
      comment: "Average price uplift - pricing adjustment and market response metric"
    - name: "ev_tax_credit_eligible_count"
      expr: SUM(CAST(CASE WHEN ev_tax_credit_eligibility_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of EV tax credit eligible SKUs - electrification incentive coverage"
    - name: "gas_guzzler_tax_count"
      expr: SUM(CAST(CASE WHEN gas_guzzler_tax_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of gas guzzler tax SKUs - regulatory penalty exposure"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_ownership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle ownership tracking for customer lifecycle management, retention analysis, and resale market insights"
  source: "`vibe_automotive_v1`.`vehicle`.`ownership`"
  dimensions:
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year of vehicle acquisition"
    - name: "acquisition_month"
      expr: DATE_TRUNC('MONTH', acquisition_date)
      comment: "Month of vehicle acquisition"
    - name: "disposition_year"
      expr: YEAR(disposition_date)
      comment: "Year of vehicle disposition"
    - name: "disposition_month"
      expr: DATE_TRUNC('MONTH', disposition_date)
      comment: "Month of vehicle disposition"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Type of ownership (retail, lease, fleet, etc.)"
    - name: "ownership_number"
      expr: ownership_number
      comment: "Sequential ownership number for the vehicle"
  measures:
    - name: "total_ownership_records"
      expr: COUNT(DISTINCT ownership_id)
      comment: "Total number of ownership records - ownership transfer volume metric"
    - name: "unique_vehicles_owned"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of unique vehicles with ownership records - fleet size metric"
    - name: "unique_owners"
      expr: COUNT(DISTINCT party_id)
      comment: "Number of unique owners - customer base size metric"
    - name: "avg_ownership_duration_days"
      expr: AVG(DATEDIFF(disposition_date, acquisition_date))
      comment: "Average ownership duration in days - customer retention and vehicle lifecycle KPI"
    - name: "active_ownerships"
      expr: SUM(CAST(CASE WHEN disposition_date IS NULL THEN 1 ELSE 0 END AS INT))
      comment: "Count of active ownerships (no disposition date) - current fleet size"
    - name: "disposed_ownerships"
      expr: SUM(CAST(CASE WHEN disposition_date IS NOT NULL THEN 1 ELSE 0 END AS INT))
      comment: "Count of disposed ownerships - resale and trade-in volume metric"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_platform`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle platform analytics for R&D investment tracking, platform strategy, and technology roadmap management"
  source: "`vibe_automotive_v1`.`vehicle`.`platform`"
  dimensions:
    - name: "platform_name"
      expr: platform_name
      comment: "Platform name"
    - name: "platform_code"
      expr: code
      comment: "Platform code"
    - name: "platform_type"
      expr: platform_type
      comment: "Type of platform"
    - name: "architecture"
      expr: architecture
      comment: "Platform architecture"
    - name: "family"
      expr: family
      comment: "Platform family"
    - name: "generation"
      expr: generation
      comment: "Platform generation"
    - name: "platform_status"
      expr: platform_status
      comment: "Current platform status"
    - name: "release_year"
      expr: release_year
      comment: "Year platform was released"
    - name: "owner_business_unit"
      expr: owner_business_unit
      comment: "Business unit owning the platform"
    - name: "ota_capability"
      expr: ota_capability
      comment: "Whether platform supports OTA updates"
    - name: "adaptive_cruise_control"
      expr: adaptive_cruise_control
      comment: "Whether platform supports adaptive cruise control"
    - name: "emissions_class"
      expr: emissions_class
      comment: "Emissions class of platform"
  measures:
    - name: "total_platforms"
      expr: COUNT(DISTINCT platform_id)
      comment: "Total number of vehicle platforms - platform portfolio complexity metric"
    - name: "avg_development_cost_usd"
      expr: AVG(CAST(development_cost_usd AS DOUBLE))
      comment: "Average platform development cost - R&D investment efficiency KPI"
    - name: "total_development_cost_usd"
      expr: SUM(CAST(development_cost_usd AS DOUBLE))
      comment: "Total platform development investment - R&D capital allocation metric"
    - name: "ota_capable_platforms"
      expr: SUM(CAST(CASE WHEN ota_capability = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of OTA-capable platforms - software-defined vehicle readiness"
    - name: "adaptive_cruise_platforms"
      expr: SUM(CAST(CASE WHEN adaptive_cruise_control = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of platforms with adaptive cruise control - ADAS technology penetration"
    - name: "avg_platform_age_years"
      expr: AVG(YEAR(CURRENT_DATE()) - CAST(release_year AS INT))
      comment: "Average platform age in years - platform refresh cycle and technology currency metric"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_powertrain_variant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Powertrain variant metrics for electrification strategy, fuel economy compliance, and technology competitiveness"
  source: "`vibe_automotive_v1`.`vehicle`.`powertrain_variant`"
  dimensions:
    - name: "variant_name"
      expr: variant_name
      comment: "Powertrain variant name"
    - name: "variant_code"
      expr: variant_code
      comment: "Powertrain variant code"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type (ICE, hybrid, electric)"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type"
    - name: "drive_type"
      expr: drive_type
      comment: "Drive type (FWD, RWD, AWD)"
    - name: "transmission_type"
      expr: transmission_type
      comment: "Transmission type"
    - name: "model_year"
      expr: model_year
      comment: "Model year"
    - name: "powertrain_variant_status"
      expr: powertrain_variant_status
      comment: "Variant status"
    - name: "charging_standard"
      expr: charging_standard
      comment: "EV charging standard"
    - name: "vehicle_platform"
      expr: vehicle_platform
      comment: "Vehicle platform"
  measures:
    - name: "total_powertrain_variants"
      expr: COUNT(DISTINCT powertrain_variant_id)
      comment: "Total number of powertrain variants - powertrain portfolio complexity metric"
    - name: "avg_battery_capacity_kwh"
      expr: AVG(CAST(battery_capacity_kwh AS DOUBLE))
      comment: "Average battery capacity - EV technology advancement and competitiveness KPI"
    - name: "avg_electric_motor_power_kw"
      expr: AVG(CAST(electric_motor_power_kw AS DOUBLE))
      comment: "Average electric motor power - electrification performance metric"
    - name: "avg_combined_system_power_kw"
      expr: AVG(CAST(combined_system_power_kw AS DOUBLE))
      comment: "Average combined system power - hybrid powertrain performance metric"
    - name: "avg_fuel_economy_city"
      expr: AVG(CAST(fuel_economy_city_mpg AS DOUBLE))
      comment: "Average city fuel economy - urban efficiency and CAFE compliance KPI"
    - name: "avg_fuel_economy_highway"
      expr: AVG(CAST(fuel_economy_highway_mpg AS DOUBLE))
      comment: "Average highway fuel economy - long-distance efficiency metric"
    - name: "avg_fuel_economy_combined"
      expr: AVG(CAST(fuel_economy_combined_mpg AS DOUBLE))
      comment: "Average combined fuel economy - overall efficiency and regulatory compliance KPI"
    - name: "avg_epa_fuel_economy_combined"
      expr: AVG(CAST(epa_fuel_economy_combined_mpg AS DOUBLE))
      comment: "Average EPA combined fuel economy - US regulatory compliance metric"
    - name: "avg_wltp_fuel_economy_combined"
      expr: AVG(CAST(wltp_fuel_economy_combined_mpg AS DOUBLE))
      comment: "Average WLTP combined fuel economy - European regulatory compliance metric"
    - name: "avg_co2_emissions"
      expr: AVG(CAST(REGEXP_REPLACE(co2_emissions_g_per_km, '[^0-9.]', '') AS DOUBLE))
      comment: "Average CO2 emissions - environmental compliance and carbon footprint KPI"
    - name: "avg_epa_range_miles"
      expr: AVG(CAST(REGEXP_REPLACE(epa_range_miles, '[^0-9.]', '') AS DOUBLE))
      comment: "Average EPA-rated electric range - EV competitiveness and customer value metric"
    - name: "avg_wltp_range_km"
      expr: AVG(CAST(REGEXP_REPLACE(wltp_range_km, '[^0-9.]', '') AS DOUBLE))
      comment: "Average WLTP-rated electric range - European market EV competitiveness metric"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_vin_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "VIN registry metrics for production tracking, recall management, warranty analytics, and vehicle lifecycle monitoring"
  source: "`vibe_automotive_v1`.`vehicle`.`vin_registry`"
  dimensions:
    - name: "build_year"
      expr: YEAR(build_date)
      comment: "Year vehicle was built"
    - name: "build_month"
      expr: DATE_TRUNC('MONTH', build_date)
      comment: "Month vehicle was built"
    - name: "model_year_decoded"
      expr: model_year_decoded
      comment: "Model year decoded from VIN"
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant code"
    - name: "destination_market"
      expr: destination_market
      comment: "Destination market"
    - name: "homologation_market"
      expr: homologation_market
      comment: "Homologation market"
    - name: "vehicle_lifecycle_status"
      expr: vehicle_lifecycle_status
      comment: "Current lifecycle status"
    - name: "emission_standard"
      expr: emission_standard
      comment: "Emission standard"
    - name: "safety_rating"
      expr: safety_rating
      comment: "Safety rating"
    - name: "recall_flag"
      expr: recall_flag
      comment: "Whether vehicle is subject to recall"
    - name: "telematics_enabled_flag"
      expr: telematics_enabled_flag
      comment: "Whether telematics is enabled"
    - name: "wmi"
      expr: wmi
      comment: "World Manufacturer Identifier from VIN"
    - name: "msrp_currency_code"
      expr: msrp_currency_code
      comment: "MSRP currency code"
  measures:
    - name: "total_vins_registered"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Total number of VINs registered - production volume and fleet size KPI"
    - name: "unique_vins"
      expr: COUNT(DISTINCT vin)
      comment: "Count of unique VIN strings - data quality and deduplication metric"
    - name: "recall_affected_vehicles"
      expr: SUM(CAST(CASE WHEN recall_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of vehicles subject to recall - quality and safety risk exposure KPI"
    - name: "telematics_enabled_vehicles"
      expr: SUM(CAST(CASE WHEN telematics_enabled_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of telematics-enabled vehicles - connected services revenue potential"
    - name: "avg_battery_capacity_kwh"
      expr: AVG(CAST(battery_capacity_kwh AS DOUBLE))
      comment: "Average battery capacity - EV fleet technology level"
    - name: "avg_curb_weight_kg"
      expr: AVG(CAST(curb_weight_kg AS DOUBLE))
      comment: "Average curb weight - fleet lightweighting and efficiency metric"
    - name: "avg_gvwr_kg"
      expr: AVG(CAST(gvwr_kg AS DOUBLE))
      comment: "Average gross vehicle weight rating - fleet capability and regulatory classification"
    - name: "avg_fuel_tank_capacity_liters"
      expr: AVG(CAST(fuel_tank_capacity_liters AS DOUBLE))
      comment: "Average fuel tank capacity - ICE vehicle range capability"
    - name: "avg_epa_combined_mpg"
      expr: AVG(CAST(epa_combined_mpg AS DOUBLE))
      comment: "Average EPA combined fuel economy - fleet CAFE compliance metric"
    - name: "avg_wltp_combined_consumption"
      expr: AVG(CAST(wltp_combined_consumption AS DOUBLE))
      comment: "Average WLTP combined consumption - European fleet efficiency metric"
    - name: "avg_warranty_duration_days"
      expr: AVG(DATEDIFF(warranty_end_date, warranty_start_date))
      comment: "Average warranty duration - warranty program coverage metric"
$$;
