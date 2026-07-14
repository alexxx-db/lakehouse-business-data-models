-- Metric views for domain: vehicle | Business: Automotive | Version: 2 | Generated on: 2026-07-14 01:46:32

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_vin_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core vehicle inventory and lifecycle metrics tracking VIN-level production, warranty, and market distribution"
  source: "`vibe_automotive_v1`.`vehicle`.`vin_registry`"
  dimensions:
    - name: "model_year"
      expr: model_year_decoded
      comment: "Model year of the vehicle decoded from VIN"
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant code where vehicle was produced"
    - name: "destination_market"
      expr: destination_market
      comment: "Target market or country for vehicle distribution"
    - name: "homologation_market"
      expr: homologation_market
      comment: "Market for which vehicle received regulatory homologation"
    - name: "lifecycle_status"
      expr: vehicle_lifecycle_status
      comment: "Current lifecycle stage of the vehicle (in production, delivered, in service, retired)"
    - name: "emission_standard"
      expr: emission_standard
      comment: "Emissions compliance standard (Euro 6, EPA Tier 3, etc.)"
    - name: "recall_flag"
      expr: recall_flag
      comment: "Indicator whether vehicle is subject to active recall"
    - name: "telematics_enabled"
      expr: telematics_enabled_flag
      comment: "Indicator whether vehicle has active telematics connectivity"
    - name: "build_year"
      expr: YEAR(build_date)
      comment: "Calendar year when vehicle was built"
    - name: "build_quarter"
      expr: CONCAT('Q', QUARTER(build_date), '-', YEAR(build_date))
      comment: "Calendar quarter when vehicle was built"
    - name: "warranty_status"
      expr: CASE WHEN warranty_end_date >= CURRENT_DATE() THEN 'Active' WHEN warranty_end_date < CURRENT_DATE() THEN 'Expired' ELSE 'Unknown' END
      comment: "Current warranty status based on warranty end date"
  measures:
    - name: "total_vehicles"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Total count of unique vehicles in registry"
    - name: "total_vins"
      expr: COUNT(DISTINCT vin)
      comment: "Total count of unique VINs (vehicle identification numbers)"
    - name: "avg_battery_capacity_kwh"
      expr: AVG(CAST(battery_capacity_kwh AS DOUBLE))
      comment: "Average battery capacity in kilowatt-hours for electric vehicles"
    - name: "avg_curb_weight_kg"
      expr: AVG(CAST(curb_weight_kg AS DOUBLE))
      comment: "Average curb weight in kilograms across vehicles"
    - name: "avg_gvwr_kg"
      expr: AVG(CAST(gvwr_kg AS DOUBLE))
      comment: "Average gross vehicle weight rating in kilograms"
    - name: "avg_fuel_tank_capacity_liters"
      expr: AVG(CAST(fuel_tank_capacity_liters AS DOUBLE))
      comment: "Average fuel tank capacity in liters for ICE vehicles"
    - name: "avg_epa_combined_mpg"
      expr: AVG(CAST(epa_combined_mpg AS DOUBLE))
      comment: "Average EPA combined fuel economy in miles per gallon"
    - name: "avg_wltp_combined_consumption"
      expr: AVG(CAST(wltp_combined_consumption AS DOUBLE))
      comment: "Average WLTP combined fuel consumption metric"
    - name: "recall_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN recall_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vehicles subject to active recalls"
    - name: "telematics_penetration_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN telematics_enabled_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vehicles with active telematics connectivity"
    - name: "warranty_active_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN warranty_end_date >= CURRENT_DATE() THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vehicles with active warranty coverage"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_configuration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle configuration and pricing metrics tracking buildable configurations, MSRP, and market feasibility"
  source: "`vibe_automotive_v1`.`vehicle`.`configuration`"
  dimensions:
    - name: "model_year"
      expr: model_year
      comment: "Model year for the vehicle configuration"
    - name: "market_region"
      expr: market_region
      comment: "Geographic market region for configuration availability"
    - name: "market_country"
      expr: market_country_code
      comment: "Country code for configuration market"
    - name: "body_style"
      expr: body_style
      comment: "Body style of the configuration (sedan, SUV, truck, etc.)"
    - name: "trim_level"
      expr: trim_level
      comment: "Trim level or grade of the configuration"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type (gasoline, diesel, electric, hybrid, etc.)"
    - name: "drivetrain"
      expr: drivetrain
      comment: "Drivetrain configuration (FWD, RWD, AWD, 4WD)"
    - name: "transmission_type"
      expr: transmission_type
      comment: "Transmission type (manual, automatic, CVT, etc.)"
    - name: "build_feasibility_status"
      expr: build_feasibility_status
      comment: "Feasibility status indicating whether configuration can be built"
    - name: "emissions_cert_status"
      expr: emissions_cert_status
      comment: "Emissions certification status for regulatory compliance"
    - name: "record_status"
      expr: record_status
      comment: "Active/inactive status of the configuration record"
    - name: "production_year"
      expr: YEAR(start_of_production_date)
      comment: "Calendar year when configuration entered production"
  measures:
    - name: "total_configurations"
      expr: COUNT(DISTINCT configuration_id)
      comment: "Total count of unique vehicle configurations"
    - name: "avg_msrp_amount"
      expr: AVG(CAST(msrp_amount AS DOUBLE))
      comment: "Average manufacturer suggested retail price across configurations"
    - name: "avg_total_price"
      expr: AVG(CAST(total_price AS DOUBLE))
      comment: "Average total price including options and destination charges"
    - name: "avg_destination_charge"
      expr: AVG(CAST(destination_charge AS DOUBLE))
      comment: "Average destination charge across configurations"
    - name: "avg_fuel_economy_city_mpg"
      expr: AVG(CAST(fuel_economy_city_mpg AS DOUBLE))
      comment: "Average city fuel economy in miles per gallon"
    - name: "avg_fuel_economy_hwy_mpg"
      expr: AVG(CAST(fuel_economy_hwy_mpg AS DOUBLE))
      comment: "Average highway fuel economy in miles per gallon"
    - name: "avg_co2_emissions_g_per_km"
      expr: AVG(CAST(REGEXP_EXTRACT(co2_emissions_g_per_km, '([0-9.]+)', 1) AS DOUBLE))
      comment: "Average CO2 emissions in grams per kilometer (extracted from string)"
    - name: "buildable_config_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN build_feasibility_status = 'Buildable' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of configurations that are currently buildable"
    - name: "emissions_certified_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN emissions_cert_status = 'Certified' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of configurations with completed emissions certification"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle model portfolio metrics tracking model lifecycle, performance specifications, and market positioning"
  source: "`vibe_automotive_v1`.`vehicle`.`model`"
  dimensions:
    - name: "brand_name"
      expr: brand_name
      comment: "Brand name of the vehicle model"
    - name: "model_name"
      expr: model_name
      comment: "Name of the vehicle model"
    - name: "segment"
      expr: segment
      comment: "Market segment classification (compact, midsize, luxury, etc.)"
    - name: "vehicle_class"
      expr: vehicle_class
      comment: "Vehicle class category"
    - name: "body_style"
      expr: body_style
      comment: "Body style of the model"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type (ICE, BEV, PHEV, HEV, FCEV)"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Primary fuel type for the model"
    - name: "transmission_type"
      expr: transmission_type
      comment: "Transmission type offered"
    - name: "drive_configuration"
      expr: drive_configuration
      comment: "Drive configuration (FWD, RWD, AWD, 4WD)"
    - name: "primary_market"
      expr: primary_market
      comment: "Primary target market for the model"
    - name: "model_status"
      expr: model_status
      comment: "Current lifecycle status of the model (active, discontinued, planned)"
    - name: "homologation_status"
      expr: homologation_status
      comment: "Regulatory homologation status"
    - name: "launch_model_year"
      expr: launch_model_year
      comment: "Model year when model was launched"
    - name: "sop_year"
      expr: YEAR(sop_date)
      comment: "Calendar year of start of production"
  measures:
    - name: "total_models"
      expr: COUNT(DISTINCT model_id)
      comment: "Total count of unique vehicle models in portfolio"
    - name: "avg_msrp_usd"
      expr: AVG(CAST(msrp_usd AS DOUBLE))
      comment: "Average manufacturer suggested retail price in USD"
    - name: "avg_curb_weight_kg"
      expr: AVG(CAST(curb_weight_kg AS DOUBLE))
      comment: "Average curb weight in kilograms"
    - name: "avg_wheelbase_mm"
      expr: AVG(CAST(wheelbase_mm AS DOUBLE))
      comment: "Average wheelbase in millimeters"
    - name: "avg_length_mm"
      expr: AVG(CAST(length_mm AS DOUBLE))
      comment: "Average vehicle length in millimeters"
    - name: "avg_width_mm"
      expr: AVG(CAST(width_mm AS DOUBLE))
      comment: "Average vehicle width in millimeters"
    - name: "avg_height_mm"
      expr: AVG(CAST(height_mm AS DOUBLE))
      comment: "Average vehicle height in millimeters"
    - name: "avg_cargo_capacity_liters"
      expr: AVG(CAST(cargo_capacity_liters AS DOUBLE))
      comment: "Average cargo capacity in liters"
    - name: "avg_battery_capacity_kwh"
      expr: AVG(CAST(battery_capacity_kwh AS DOUBLE))
      comment: "Average battery capacity in kilowatt-hours for electric models"
    - name: "avg_electric_range_miles"
      expr: AVG(CAST(electric_range_miles AS DOUBLE))
      comment: "Average electric driving range in miles for EVs and PHEVs"
    - name: "avg_fuel_economy_city_mpg"
      expr: AVG(CAST(fuel_economy_city_mpg AS DOUBLE))
      comment: "Average city fuel economy in miles per gallon"
    - name: "avg_fuel_economy_hwy_mpg"
      expr: AVG(CAST(fuel_economy_hwy_mpg AS DOUBLE))
      comment: "Average highway fuel economy in miles per gallon"
    - name: "avg_co2_emissions_g_per_km"
      expr: AVG(CAST(co2_emissions_g_per_km AS DOUBLE))
      comment: "Average CO2 emissions in grams per kilometer"
    - name: "active_model_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN model_status = 'Active' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of models with active production status"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_powertrain_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Powertrain configuration metrics tracking performance, efficiency, emissions, and regulatory compliance across powertrain variants"
  source: "`vibe_automotive_v1`.`vehicle`.`powertrain_config`"
  dimensions:
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Type of powertrain (ICE, BEV, PHEV, HEV, FCEV)"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type for the powertrain"
    - name: "transmission_type"
      expr: transmission_type
      comment: "Transmission type paired with powertrain"
    - name: "drivetrain_layout"
      expr: drivetrain_layout
      comment: "Drivetrain layout (FWD, RWD, AWD, 4WD)"
    - name: "engine_configuration"
      expr: engine_configuration
      comment: "Engine configuration (inline, V, flat, rotary, etc.)"
    - name: "aspiration_type"
      expr: aspiration_type
      comment: "Engine aspiration type (naturally aspirated, turbocharged, supercharged)"
    - name: "battery_chemistry"
      expr: battery_chemistry
      comment: "Battery chemistry type for electric powertrains (NMC, LFP, etc.)"
    - name: "emissions_standard"
      expr: emissions_standard
      comment: "Emissions compliance standard (Euro 6, EPA Tier 3, etc.)"
    - name: "homologation_status"
      expr: homologation_status
      comment: "Regulatory homologation status"
    - name: "powertrain_config_status"
      expr: powertrain_config_status
      comment: "Current status of powertrain configuration"
    - name: "model_year"
      expr: model_year
      comment: "Model year for the powertrain configuration"
    - name: "sop_year"
      expr: YEAR(start_of_production_date)
      comment: "Calendar year of start of production"
  measures:
    - name: "total_powertrain_configs"
      expr: COUNT(DISTINCT powertrain_config_id)
      comment: "Total count of unique powertrain configurations"
    - name: "avg_msrp_base_usd"
      expr: AVG(CAST(msrp_base_usd AS DOUBLE))
      comment: "Average base MSRP in USD for powertrain configuration"
    - name: "avg_manufacturing_cost_usd"
      expr: AVG(CAST(manufacturing_cost_usd AS DOUBLE))
      comment: "Average manufacturing cost in USD"
    - name: "avg_dealer_invoice_cost_usd"
      expr: AVG(CAST(dealer_invoice_cost_usd AS DOUBLE))
      comment: "Average dealer invoice cost in USD"
    - name: "avg_engine_displacement_liters"
      expr: AVG(CAST(engine_displacement_liters AS DOUBLE))
      comment: "Average engine displacement in liters for ICE powertrains"
    - name: "avg_battery_capacity_kwh"
      expr: AVG(CAST(battery_capacity_kwh AS DOUBLE))
      comment: "Average battery capacity in kilowatt-hours for electric powertrains"
    - name: "avg_max_charging_power_kw"
      expr: AVG(CAST(REGEXP_EXTRACT(max_charging_power_kw, '([0-9.]+)', 1) AS DOUBLE))
      comment: "Average maximum charging power in kilowatts for EVs"
    - name: "avg_zero_to_sixty_seconds"
      expr: AVG(CAST(zero_to_sixty_seconds AS DOUBLE))
      comment: "Average 0-60 mph acceleration time in seconds"
    - name: "avg_cafe_credit_value"
      expr: AVG(CAST(cafe_credit_value AS DOUBLE))
      comment: "Average CAFE (Corporate Average Fuel Economy) credit value"
    - name: "avg_co2_emissions_g_km"
      expr: AVG(CAST(REGEXP_EXTRACT(co2_emissions_g_km, '([0-9.]+)', 1) AS DOUBLE))
      comment: "Average CO2 emissions in grams per kilometer"
    - name: "homologation_certified_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN homologation_status = 'Certified' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of powertrain configurations with completed homologation"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_build_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Build specification metrics tracking as-built vehicle configurations, quality ratings, and production performance"
  source: "`vibe_automotive_v1`.`vehicle`.`build_spec`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant code where vehicle was built"
    - name: "production_line"
      expr: production_line
      comment: "Production line identifier"
    - name: "build_spec_status"
      expr: build_spec_status
      comment: "Status of the build specification"
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status for the build"
    - name: "emissions_rating"
      expr: emissions_rating
      comment: "Emissions rating classification"
    - name: "ncap_rating"
      expr: ncap_rating
      comment: "NCAP safety rating"
    - name: "fleet_spec_flag"
      expr: fleet_spec_flag
      comment: "Indicator whether build is for fleet customer"
    - name: "special_order_flag"
      expr: special_order_flag
      comment: "Indicator whether build is a special order"
    - name: "ota_updatable_flag"
      expr: ota_updatable_flag
      comment: "Indicator whether vehicle supports over-the-air updates"
    - name: "v2x_enabled_flag"
      expr: v2x_enabled_flag
      comment: "Indicator whether vehicle has vehicle-to-everything communication enabled"
    - name: "build_year"
      expr: YEAR(build_date)
      comment: "Calendar year when vehicle was built"
    - name: "build_quarter"
      expr: CONCAT('Q', QUARTER(build_date), '-', YEAR(build_date))
      comment: "Calendar quarter when vehicle was built"
    - name: "warranty_active"
      expr: CASE WHEN warranty_end_date >= CURRENT_DATE() THEN 'Active' WHEN warranty_end_date < CURRENT_DATE() THEN 'Expired' ELSE 'Unknown' END
      comment: "Current warranty status"
  measures:
    - name: "total_builds"
      expr: COUNT(DISTINCT build_spec_id)
      comment: "Total count of unique build specifications"
    - name: "total_vins_built"
      expr: COUNT(DISTINCT vin)
      comment: "Total count of unique VINs built"
    - name: "avg_vehicle_weight_kg"
      expr: AVG(CAST(vehicle_weight_kg AS DOUBLE))
      comment: "Average vehicle weight in kilograms as-built"
    - name: "avg_fuel_efficiency_mpg"
      expr: AVG(CAST(fuel_efficiency_mpg AS DOUBLE))
      comment: "Average fuel efficiency in miles per gallon as-built"
    - name: "avg_co2_emissions_g_per_km"
      expr: AVG(CAST(REGEXP_EXTRACT(co2_emissions_g_per_km, '([0-9.]+)', 1) AS DOUBLE))
      comment: "Average CO2 emissions in grams per kilometer as-built"
    - name: "fleet_build_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN fleet_spec_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of builds for fleet customers"
    - name: "special_order_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN special_order_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of builds that are special orders"
    - name: "ota_capable_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN ota_updatable_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of builds with OTA update capability"
    - name: "v2x_enabled_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN v2x_enabled_flag = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of builds with V2X communication enabled"
    - name: "regulatory_approved_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN regulatory_approval_status = 'Approved' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of builds with completed regulatory approval"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_lifecycle_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle lifecycle event metrics tracking critical events, odometer progression, and event patterns across vehicle lifetime"
  source: "`vibe_automotive_v1`.`vehicle`.`lifecycle_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of lifecycle event (production, delivery, service, accident, etc.)"
    - name: "event_subtype"
      expr: event_subtype
      comment: "Subtype providing additional event classification"
    - name: "event_category"
      expr: event_category
      comment: "High-level category of the event"
    - name: "event_status"
      expr: event_status
      comment: "Status of the event (completed, pending, cancelled)"
    - name: "event_location_country"
      expr: event_location_country
      comment: "Country where event occurred"
    - name: "event_location_state"
      expr: event_location_state
      comment: "State or province where event occurred"
    - name: "event_location_city"
      expr: event_location_city
      comment: "City where event occurred"
    - name: "event_source_system"
      expr: event_source_system
      comment: "Source system that recorded the event"
    - name: "event_source_module"
      expr: event_source_module
      comment: "Source module within system that recorded the event"
    - name: "triggering_system"
      expr: triggering_system
      comment: "System that triggered the event"
    - name: "is_critical"
      expr: is_critical
      comment: "Indicator whether event is classified as critical"
    - name: "event_year"
      expr: YEAR(event_timestamp)
      comment: "Calendar year when event occurred"
    - name: "event_quarter"
      expr: CONCAT('Q', QUARTER(event_timestamp), '-', YEAR(event_timestamp))
      comment: "Calendar quarter when event occurred"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Calendar month when event occurred"
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total count of lifecycle events"
    - name: "unique_vehicles_with_events"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Count of unique vehicles with recorded lifecycle events"
    - name: "avg_odometer_reading_km"
      expr: AVG(CAST(odometer_reading_km AS DOUBLE))
      comment: "Average odometer reading in kilometers at time of event"
    - name: "critical_event_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events classified as critical"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_platform`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle platform metrics tracking platform portfolio, development investment, and architectural capabilities"
  source: "`vibe_automotive_v1`.`vehicle`.`platform`"
  dimensions:
    - name: "platform_name"
      expr: platform_name
      comment: "Name of the vehicle platform"
    - name: "platform_code"
      expr: platform_code
      comment: "Code identifier for the platform"
    - name: "platform_type"
      expr: platform_type
      comment: "Type of platform (unibody, body-on-frame, skateboard, etc.)"
    - name: "architecture"
      expr: architecture
      comment: "Platform architecture classification"
    - name: "family"
      expr: family
      comment: "Platform family grouping"
    - name: "generation"
      expr: generation
      comment: "Platform generation"
    - name: "platform_status"
      expr: platform_status
      comment: "Current status of the platform (active, planned, retired)"
    - name: "emissions_class"
      expr: emissions_class
      comment: "Emissions class supported by platform"
    - name: "ota_capability"
      expr: ota_capability
      comment: "Indicator whether platform supports over-the-air updates"
    - name: "adaptive_cruise_control"
      expr: adaptive_cruise_control
      comment: "Indicator whether platform supports adaptive cruise control"
    - name: "owner_business_unit"
      expr: owner_business_unit
      comment: "Business unit that owns the platform"
    - name: "release_year"
      expr: release_year
      comment: "Year when platform was released"
  measures:
    - name: "total_platforms"
      expr: COUNT(DISTINCT platform_id)
      comment: "Total count of unique vehicle platforms"
    - name: "avg_development_cost_usd"
      expr: AVG(CAST(development_cost_usd AS DOUBLE))
      comment: "Average platform development cost in USD"
    - name: "total_development_investment_usd"
      expr: SUM(CAST(development_cost_usd AS DOUBLE))
      comment: "Total platform development investment in USD"
    - name: "ota_capable_platform_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN ota_capability = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of platforms with OTA capability"
    - name: "active_platform_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN platform_status = 'Active' THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of platforms with active production status"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_campaign_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service campaign enrollment and remedy metrics tracking campaign completion rates, costs, and labor efficiency"
  source: "`vibe_automotive_v1`.`vehicle`.`campaign_enrollment`"
  dimensions:
    - name: "notification_status"
      expr: notification_status
      comment: "Status of customer notification for campaign"
    - name: "warranty_covered"
      expr: warranty_covered
      comment: "Indicator whether campaign remedy is covered under warranty"
    - name: "notification_year"
      expr: YEAR(notification_date)
      comment: "Calendar year when customer was notified"
    - name: "scheduled_service_year"
      expr: YEAR(scheduled_service_date)
      comment: "Calendar year when service is scheduled"
    - name: "remedy_completion_year"
      expr: YEAR(remedy_completion_date)
      comment: "Calendar year when remedy was completed"
    - name: "remedy_completed"
      expr: CASE WHEN remedy_completion_date IS NOT NULL THEN 'Completed' ELSE 'Pending' END
      comment: "Indicator whether remedy has been completed"
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total count of campaign enrollments"
    - name: "unique_vehicles_enrolled"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Count of unique vehicles enrolled in campaigns"
    - name: "avg_labor_time_hours"
      expr: AVG(CAST(labor_time_hours AS DOUBLE))
      comment: "Average labor time in hours per campaign remedy"
    - name: "total_labor_time_hours"
      expr: SUM(CAST(labor_time_hours AS DOUBLE))
      comment: "Total labor time in hours across all campaign remedies"
    - name: "avg_parts_consumed"
      expr: AVG(CAST(parts_consumed AS DOUBLE))
      comment: "Average number of parts consumed per campaign remedy"
    - name: "total_parts_consumed"
      expr: SUM(CAST(parts_consumed AS DOUBLE))
      comment: "Total parts consumed across all campaign remedies"
    - name: "avg_total_remedy_cost_usd"
      expr: AVG(CAST(total_remedy_cost_usd AS DOUBLE))
      comment: "Average total remedy cost in USD per enrollment"
    - name: "total_remedy_cost_usd"
      expr: SUM(CAST(total_remedy_cost_usd AS DOUBLE))
      comment: "Total remedy cost in USD across all enrollments"
    - name: "avg_labor_cost_usd"
      expr: AVG(CAST(total_labor_cost_usd AS DOUBLE))
      comment: "Average labor cost in USD per enrollment"
    - name: "total_labor_cost_usd"
      expr: SUM(CAST(total_labor_cost_usd AS DOUBLE))
      comment: "Total labor cost in USD across all enrollments"
    - name: "avg_parts_cost_usd"
      expr: AVG(CAST(total_parts_cost_usd AS DOUBLE))
      comment: "Average parts cost in USD per enrollment"
    - name: "total_parts_cost_usd"
      expr: SUM(CAST(total_parts_cost_usd AS DOUBLE))
      comment: "Total parts cost in USD across all enrollments"
    - name: "remedy_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN remedy_completion_date IS NOT NULL THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments with completed remedies"
    - name: "warranty_coverage_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN warranty_covered = TRUE THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments covered under warranty"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_ownership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle ownership metrics tracking ownership transfers, tenure, and ownership type distribution"
  source: "`vibe_automotive_v1`.`vehicle`.`ownership`"
  dimensions:
    - name: "ownership_type"
      expr: ownership_type
      comment: "Type of ownership (retail, lease, fleet, rental, etc.)"
    - name: "ownership_number"
      expr: ownership_number
      comment: "Sequential ownership number for the vehicle"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Calendar year when ownership was acquired"
    - name: "disposition_year"
      expr: YEAR(disposition_date)
      comment: "Calendar year when ownership was disposed"
    - name: "ownership_active"
      expr: CASE WHEN disposition_date IS NULL THEN 'Active' ELSE 'Disposed' END
      comment: "Indicator whether ownership is currently active"
  measures:
    - name: "total_ownership_records"
      expr: COUNT(1)
      comment: "Total count of ownership records"
    - name: "unique_vehicles_owned"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Count of unique vehicles with ownership records"
    - name: "unique_owners"
      expr: COUNT(DISTINCT party_id)
      comment: "Count of unique owners (parties)"
    - name: "active_ownership_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN disposition_date IS NULL THEN 1 ELSE 0 END AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ownership records that are currently active"
$$;