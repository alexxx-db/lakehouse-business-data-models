-- Metric views for domain: processing | Business: Mining | Version: 1 | Generated on: 2026-05-05 10:43:42

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`processing_shift_production_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core production performance metrics tracking throughput, recovery, availability, and OEE by shift for processing plants"
  source: "`mining_ecm`.`processing`.`shift_production_run`"
  dimensions:
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the production shift"
    - name: "shift_type"
      expr: shift_number
      comment: "Shift identifier (day/night/swing)"
    - name: "run_status"
      expr: run_status
      comment: "Status of the production run"
    - name: "primary_ore_type"
      expr: primary_ore_type
      comment: "Type of ore processed during shift"
    - name: "processing_circuit_type"
      expr: processing_circuit_type
      comment: "Type of processing circuit used"
    - name: "shift_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Month of production for monthly aggregation"
    - name: "shift_quarter"
      expr: DATE_TRUNC('QUARTER', shift_date)
      comment: "Quarter of production for quarterly reporting"
    - name: "weather_impact_flag"
      expr: weather_impact_flag
      comment: "Flag indicating if weather impacted production"
  measures:
    - name: "total_tonnes_processed"
      expr: SUM(CAST(tonnes_processed AS DOUBLE))
      comment: "Total dry tonnes processed through the plant"
    - name: "total_concentrate_produced"
      expr: SUM(CAST(concentrate_produced_tonnes AS DOUBLE))
      comment: "Total tonnes of concentrate produced"
    - name: "avg_metallurgical_recovery"
      expr: AVG(CAST(metallurgical_recovery_pct AS DOUBLE))
      comment: "Average metallurgical recovery percentage across shifts"
    - name: "avg_circuit_availability"
      expr: AVG(CAST(circuit_availability_pct AS DOUBLE))
      comment: "Average circuit availability percentage"
    - name: "avg_plant_utilisation"
      expr: AVG(CAST(plant_utilisation_pct AS DOUBLE))
      comment: "Average plant utilisation percentage"
    - name: "avg_oee"
      expr: AVG(CAST(oee_pct AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness percentage"
    - name: "total_operating_hours"
      expr: SUM(CAST(operating_hours AS DOUBLE))
      comment: "Total operating hours across all shifts"
    - name: "total_unplanned_downtime_hours"
      expr: SUM(CAST(unplanned_downtime_hours AS DOUBLE))
      comment: "Total unplanned downtime hours"
    - name: "total_planned_downtime_hours"
      expr: SUM(CAST(planned_downtime_hours AS DOUBLE))
      comment: "Total planned downtime hours"
    - name: "avg_actual_throughput_rate"
      expr: AVG(CAST(actual_throughput_rate_tph AS DOUBLE))
      comment: "Average actual throughput rate in tonnes per hour"
    - name: "avg_feed_head_grade"
      expr: AVG(CAST(feed_head_grade_pct AS DOUBLE))
      comment: "Average feed head grade percentage"
    - name: "avg_product_grade"
      expr: AVG(CAST(product_grade_pct AS DOUBLE))
      comment: "Average product grade percentage"
    - name: "shift_count"
      expr: COUNT(1)
      comment: "Number of production shifts"
    - name: "throughput_achievement_rate"
      expr: ROUND(100.0 * AVG(CAST(actual_throughput_rate_tph AS DOUBLE)) / NULLIF(AVG(CAST(design_throughput_rate_tph AS DOUBLE)), 0), 2)
      comment: "Percentage of design throughput achieved"
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`processing_metallurgical_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metallurgical accounting metrics tracking mass balance closure, recovery variance, and metal units for reconciliation and reporting"
  source: "`mining_ecm`.`processing`.`metallurgical_balance`"
  dimensions:
    - name: "accounting_period_start"
      expr: accounting_period_start
      comment: "Start date of accounting period"
    - name: "accounting_period_end"
      expr: accounting_period_end
      comment: "End date of accounting period"
    - name: "period_type"
      expr: period_type
      comment: "Type of accounting period (daily, weekly, monthly)"
    - name: "balance_status"
      expr: balance_status
      comment: "Status of the metallurgical balance"
    - name: "ore_type"
      expr: ore_type
      comment: "Type of ore processed"
    - name: "feed_grade_unit"
      expr: feed_grade_unit
      comment: "Unit of measure for feed grade"
    - name: "is_current_version"
      expr: is_current_version
      comment: "Flag indicating if this is the current version of the balance"
    - name: "accounting_month"
      expr: DATE_TRUNC('MONTH', accounting_period_start)
      comment: "Month of accounting period for aggregation"
  measures:
    - name: "total_feed_tonnes_dry"
      expr: SUM(CAST(feed_tonnes_dry AS DOUBLE))
      comment: "Total dry tonnes of feed material"
    - name: "total_concentrate_tonnes_dry"
      expr: SUM(CAST(concentrate_tonnes_dry AS DOUBLE))
      comment: "Total dry tonnes of concentrate produced"
    - name: "total_tailings_tonnes_dry"
      expr: SUM(CAST(tailings_tonnes_dry AS DOUBLE))
      comment: "Total dry tonnes of tailings"
    - name: "avg_mass_balance_closure"
      expr: AVG(CAST(mass_balance_closure_pct AS DOUBLE))
      comment: "Average mass balance closure percentage"
    - name: "avg_measured_recovery"
      expr: AVG(CAST(measured_recovery_pct AS DOUBLE))
      comment: "Average measured recovery percentage"
    - name: "avg_theoretical_recovery"
      expr: AVG(CAST(theoretical_recovery_pct AS DOUBLE))
      comment: "Average theoretical recovery percentage"
    - name: "avg_recovery_variance"
      expr: AVG(CAST(recovery_variance_pct AS DOUBLE))
      comment: "Average variance between measured and theoretical recovery"
    - name: "total_metal_units_feed"
      expr: SUM(CAST(metal_units_feed AS DOUBLE))
      comment: "Total metal units in feed"
    - name: "total_metal_units_recovered"
      expr: SUM(CAST(metal_units_recovered AS DOUBLE))
      comment: "Total metal units recovered in concentrate"
    - name: "avg_feed_grade"
      expr: AVG(CAST(feed_grade AS DOUBLE))
      comment: "Average feed grade"
    - name: "avg_concentrate_grade"
      expr: AVG(CAST(concentrate_grade AS DOUBLE))
      comment: "Average concentrate grade"
    - name: "avg_tailings_grade"
      expr: AVG(CAST(tailings_grade AS DOUBLE))
      comment: "Average tailings grade"
    - name: "total_energy_consumption_kwh"
      expr: SUM(CAST(energy_consumption_kwh AS DOUBLE))
      comment: "Total energy consumption in kilowatt-hours"
    - name: "total_water_consumption_m3"
      expr: SUM(CAST(water_consumption_m3 AS DOUBLE))
      comment: "Total water consumption in cubic meters"
    - name: "balance_count"
      expr: COUNT(1)
      comment: "Number of metallurgical balance records"
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`processing_plant_utility_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Utility consumption and sustainability metrics tracking energy, water, emissions, and specific consumption rates for environmental and cost management"
  source: "`mining_ecm`.`processing`.`plant_utility_consumption`"
  dimensions:
    - name: "period_start"
      expr: period_start_timestamp
      comment: "Start timestamp of consumption period"
    - name: "period_end"
      expr: period_end_timestamp
      comment: "End timestamp of consumption period"
    - name: "period_type"
      expr: period_type
      comment: "Type of consumption period (shift, daily, monthly)"
    - name: "record_status"
      expr: record_status
      comment: "Status of the consumption record"
    - name: "data_source"
      expr: data_source
      comment: "Source system for consumption data"
    - name: "water_licence_compliance_flag"
      expr: water_licence_compliance_flag
      comment: "Flag indicating compliance with water licence limits"
    - name: "consumption_month"
      expr: DATE_TRUNC('MONTH', period_start_timestamp)
      comment: "Month of consumption for aggregation"
  measures:
    - name: "total_electricity_consumption_kwh"
      expr: SUM(CAST(electricity_consumption_kwh AS DOUBLE))
      comment: "Total electricity consumption in kilowatt-hours"
    - name: "total_electricity_cost"
      expr: SUM(CAST(electricity_cost_total AS DOUBLE))
      comment: "Total electricity cost"
    - name: "total_fresh_water_intake_m3"
      expr: SUM(CAST(fresh_water_intake_m3 AS DOUBLE))
      comment: "Total fresh water intake in cubic meters"
    - name: "total_recycled_water_m3"
      expr: SUM(CAST(recycled_water_m3 AS DOUBLE))
      comment: "Total recycled water in cubic meters"
    - name: "total_process_water_consumption_m3"
      expr: SUM(CAST(process_water_consumption_m3 AS DOUBLE))
      comment: "Total process water consumption in cubic meters"
    - name: "total_water_cost"
      expr: SUM(CAST(water_cost_total AS DOUBLE))
      comment: "Total water cost"
    - name: "total_scope1_emissions_co2e"
      expr: SUM(CAST(scope1_emissions_co2e_t AS DOUBLE))
      comment: "Total Scope 1 emissions in tonnes CO2 equivalent"
    - name: "total_scope2_emissions_co2e"
      expr: SUM(CAST(scope2_emissions_co2e_t AS DOUBLE))
      comment: "Total Scope 2 emissions in tonnes CO2 equivalent"
    - name: "total_tonnes_processed"
      expr: SUM(CAST(tonnes_processed AS DOUBLE))
      comment: "Total tonnes processed during period"
    - name: "avg_specific_energy_kwh_per_t"
      expr: AVG(CAST(specific_energy_kwh_per_t AS DOUBLE))
      comment: "Average specific energy consumption per tonne"
    - name: "avg_specific_water_m3_per_t"
      expr: AVG(CAST(specific_water_m3_per_t AS DOUBLE))
      comment: "Average specific water consumption per tonne"
    - name: "avg_peak_demand_kw"
      expr: AVG(CAST(peak_demand_kw AS DOUBLE))
      comment: "Average peak electricity demand in kilowatts"
    - name: "total_natural_gas_consumption_gj"
      expr: SUM(CAST(natural_gas_consumption_gj AS DOUBLE))
      comment: "Total natural gas consumption in gigajoules"
    - name: "total_compressed_air_consumption_m3"
      expr: SUM(CAST(compressed_air_consumption_m3 AS DOUBLE))
      comment: "Total compressed air consumption in cubic meters"
    - name: "consumption_record_count"
      expr: COUNT(1)
      comment: "Number of utility consumption records"
    - name: "water_recycling_rate"
      expr: ROUND(100.0 * SUM(CAST(recycled_water_m3 AS DOUBLE)) / NULLIF(SUM(CAST(recycled_water_m3 AS DOUBLE)) + SUM(CAST(fresh_water_intake_m3 AS DOUBLE)), 0), 2)
      comment: "Percentage of water recycled vs total water used"
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`processing_concentrate_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Concentrate production and quality metrics tracking batch-level grade, recovery, yield, and quality compliance for sales and metallurgical accounting"
  source: "`mining_ecm`.`processing`.`concentrate_batch`"
  dimensions:
    - name: "production_date"
      expr: production_date
      comment: "Date of concentrate production"
    - name: "batch_status"
      expr: batch_status
      comment: "Status of the concentrate batch"
    - name: "commodity_type"
      expr: commodity_type
      comment: "Type of commodity in concentrate"
    - name: "quality_grade"
      expr: quality_grade
      comment: "Quality grade classification of concentrate"
    - name: "is_quality_approved"
      expr: is_quality_approved
      comment: "Flag indicating if batch passed quality approval"
    - name: "process_route"
      expr: process_route
      comment: "Processing route used to produce concentrate"
    - name: "dispatch_mode"
      expr: dispatch_mode
      comment: "Mode of dispatch for concentrate"
    - name: "production_month"
      expr: DATE_TRUNC('MONTH', production_date)
      comment: "Month of production for aggregation"
  measures:
    - name: "total_dry_weight_dmt"
      expr: SUM(CAST(dry_weight_dmt AS DOUBLE))
      comment: "Total dry metric tonnes of concentrate produced"
    - name: "total_wet_weight_t"
      expr: SUM(CAST(wet_weight_t AS DOUBLE))
      comment: "Total wet tonnes of concentrate"
    - name: "total_feed_tonnes"
      expr: SUM(CAST(feed_tonnes AS DOUBLE))
      comment: "Total feed tonnes processed"
    - name: "avg_concentrate_grade"
      expr: AVG(CAST(concentrate_grade_pct AS DOUBLE))
      comment: "Average concentrate grade percentage"
    - name: "avg_head_grade"
      expr: AVG(CAST(head_grade_pct AS DOUBLE))
      comment: "Average head grade percentage"
    - name: "avg_recovery_rate"
      expr: AVG(CAST(recovery_rate_pct AS DOUBLE))
      comment: "Average recovery rate percentage"
    - name: "avg_yield"
      expr: AVG(CAST(yield_pct AS DOUBLE))
      comment: "Average yield percentage"
    - name: "avg_moisture"
      expr: AVG(CAST(moisture_pct AS DOUBLE))
      comment: "Average moisture content percentage"
    - name: "avg_impurity_silica"
      expr: AVG(CAST(impurity_silica_pct AS DOUBLE))
      comment: "Average silica impurity percentage"
    - name: "avg_impurity_sulfur"
      expr: AVG(CAST(impurity_sulfur_pct AS DOUBLE))
      comment: "Average sulfur impurity percentage"
    - name: "total_energy_consumption_kwh"
      expr: SUM(CAST(energy_consumption_kwh_t AS DOUBLE) * CAST(feed_tonnes AS DOUBLE))
      comment: "Total energy consumption in kilowatt-hours"
    - name: "total_water_consumption_m3"
      expr: SUM(CAST(water_consumption_m3_t AS DOUBLE) * CAST(feed_tonnes AS DOUBLE))
      comment: "Total water consumption in cubic meters"
    - name: "avg_throughput_tph"
      expr: AVG(CAST(throughput_tph AS DOUBLE))
      comment: "Average throughput in tonnes per hour"
    - name: "batch_count"
      expr: COUNT(1)
      comment: "Number of concentrate batches"
    - name: "quality_approved_batch_count"
      expr: COUNT(CASE WHEN is_quality_approved = TRUE THEN 1 END)
      comment: "Number of quality-approved batches"
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`processing_reagent_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reagent consumption and cost metrics tracking dosage rates, specific consumption, and total cost by reagent type for process optimization and cost control"
  source: "`mining_ecm`.`processing`.`reagent_consumption`"
  dimensions:
    - name: "shift_date"
      expr: shift_date
      comment: "Date of reagent consumption"
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift during consumption"
    - name: "consumption_status"
      expr: consumption_status
      comment: "Status of consumption record"
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag indicating if reagent is hazardous"
    - name: "environmental_report_required"
      expr: environmental_report_required
      comment: "Flag indicating if environmental reporting is required"
    - name: "data_source"
      expr: data_source
      comment: "Source system for consumption data"
    - name: "dosage_rate_unit"
      expr: dosage_rate_unit
      comment: "Unit of measure for dosage rate"
    - name: "consumption_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Month of consumption for aggregation"
  measures:
    - name: "total_quantity_consumed_kg"
      expr: SUM(CAST(quantity_consumed_kg AS DOUBLE))
      comment: "Total quantity of reagent consumed in kilograms"
    - name: "total_reagent_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of reagent consumption"
    - name: "total_ore_throughput_t"
      expr: SUM(CAST(ore_throughput_t AS DOUBLE))
      comment: "Total ore throughput in tonnes"
    - name: "avg_dosage_rate"
      expr: AVG(CAST(dosage_rate AS DOUBLE))
      comment: "Average dosage rate"
    - name: "avg_specific_consumption_g_per_t"
      expr: AVG(CAST(specific_consumption_g_per_t AS DOUBLE))
      comment: "Average specific consumption in grams per tonne"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of reagent"
    - name: "avg_recovery_rate"
      expr: AVG(CAST(recovery_rate_percent AS DOUBLE))
      comment: "Average recovery rate percentage during reagent use"
    - name: "avg_feed_grade"
      expr: AVG(CAST(feed_grade_percent AS DOUBLE))
      comment: "Average feed grade percentage"
    - name: "avg_slurry_ph"
      expr: AVG(CAST(slurry_ph AS DOUBLE))
      comment: "Average slurry pH during reagent addition"
    - name: "consumption_record_count"
      expr: COUNT(1)
      comment: "Number of reagent consumption records"
    - name: "distinct_reagent_count"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct reagents consumed"
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`processing_operational_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process deviation and exception metrics tracking downtime, production loss, and root cause analysis for operational improvement and reliability"
  source: "`mining_ecm`.`processing`.`operational_exception`"
  dimensions:
    - name: "shift_date"
      expr: shift_date
      comment: "Date of operational exception"
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift during exception"
    - name: "event_status"
      expr: event_status
      comment: "Status of the exception event"
    - name: "event_type"
      expr: event_type
      comment: "Type of operational exception"
    - name: "event_category"
      expr: event_category
      comment: "Category of exception event"
    - name: "severity"
      expr: severity
      comment: "Severity level of exception"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause code for exception"
    - name: "oee_loss_category"
      expr: oee_loss_category
      comment: "OEE loss category classification"
    - name: "is_planned"
      expr: is_planned
      comment: "Flag indicating if exception was planned"
    - name: "hse_incident_raised"
      expr: hse_incident_raised
      comment: "Flag indicating if HSE incident was raised"
    - name: "detection_method"
      expr: detection_method
      comment: "Method used to detect exception"
    - name: "exception_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Month of exception for aggregation"
  measures:
    - name: "total_duration_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total duration of exceptions in minutes"
    - name: "total_production_loss_tonnes"
      expr: SUM(CAST(production_loss_tonnes AS DOUBLE))
      comment: "Total production loss in tonnes"
    - name: "total_throughput_loss_tph"
      expr: SUM(CAST(throughput_loss_tph AS DOUBLE))
      comment: "Total throughput loss in tonnes per hour"
    - name: "avg_deviation_magnitude"
      expr: AVG(CAST(deviation_magnitude AS DOUBLE))
      comment: "Average magnitude of deviation from setpoint"
    - name: "exception_count"
      expr: COUNT(1)
      comment: "Number of operational exceptions"
    - name: "unplanned_exception_count"
      expr: COUNT(CASE WHEN is_planned = FALSE THEN 1 END)
      comment: "Number of unplanned exceptions"
    - name: "hse_incident_exception_count"
      expr: COUNT(CASE WHEN hse_incident_raised = TRUE THEN 1 END)
      comment: "Number of exceptions that raised HSE incidents"
    - name: "distinct_root_cause_count"
      expr: COUNT(DISTINCT root_cause_code)
      comment: "Number of distinct root causes"
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`processing_flotation_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Flotation circuit performance metrics tracking recovery, grade, mass pull, and reagent dosage for process control and optimization"
  source: "`mining_ecm`.`processing`.`flotation_event`"
  dimensions:
    - name: "production_date"
      expr: DATE(event_start_timestamp)
      comment: "Date of flotation event"
    - name: "event_status"
      expr: event_status
      comment: "Status of flotation event"
    - name: "circuit_stage"
      expr: circuit_stage
      comment: "Stage of flotation circuit"
    - name: "mineral_type"
      expr: mineral_type
      comment: "Type of mineral being floated"
    - name: "ore_type"
      expr: ore_type
      comment: "Type of ore being processed"
    - name: "downtime_reason"
      expr: downtime_reason
      comment: "Reason for circuit downtime"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_start_timestamp)
      comment: "Month of flotation event for aggregation"
  measures:
    - name: "total_feed_rate_tph"
      expr: SUM(CAST(feed_rate_tph AS DOUBLE))
      comment: "Total feed rate in tonnes per hour"
    - name: "total_concentrate_mass_t"
      expr: SUM(CAST(concentrate_mass_t AS DOUBLE))
      comment: "Total concentrate mass in tonnes"
    - name: "total_tailings_mass_t"
      expr: SUM(CAST(tailings_mass_t AS DOUBLE))
      comment: "Total tailings mass in tonnes"
    - name: "avg_circuit_recovery"
      expr: AVG(CAST(circuit_recovery_pct AS DOUBLE))
      comment: "Average circuit recovery percentage"
    - name: "avg_circuit_availability"
      expr: AVG(CAST(circuit_availability_pct AS DOUBLE))
      comment: "Average circuit availability percentage"
    - name: "avg_feed_grade"
      expr: AVG(CAST(feed_grade_pct AS DOUBLE))
      comment: "Average feed grade percentage"
    - name: "avg_concentrate_grade"
      expr: AVG(CAST(concentrate_grade_pct AS DOUBLE))
      comment: "Average concentrate grade percentage"
    - name: "avg_tailings_grade"
      expr: AVG(CAST(tailings_grade_pct AS DOUBLE))
      comment: "Average tailings grade percentage"
    - name: "avg_mass_pull"
      expr: AVG(CAST(mass_pull_pct AS DOUBLE))
      comment: "Average mass pull percentage"
    - name: "avg_pulp_density"
      expr: AVG(CAST(pulp_density_pct_solids AS DOUBLE))
      comment: "Average pulp density as percent solids"
    - name: "avg_pulp_ph"
      expr: AVG(CAST(pulp_ph AS DOUBLE))
      comment: "Average pulp pH"
    - name: "avg_collector_dosage"
      expr: AVG(CAST(collector_dosage_g_per_t AS DOUBLE))
      comment: "Average collector dosage in grams per tonne"
    - name: "avg_frother_dosage"
      expr: AVG(CAST(frother_dosage_g_per_t AS DOUBLE))
      comment: "Average frother dosage in grams per tonne"
    - name: "avg_depressant_dosage"
      expr: AVG(CAST(depressant_dosage_g_per_t AS DOUBLE))
      comment: "Average depressant dosage in grams per tonne"
    - name: "flotation_event_count"
      expr: COUNT(1)
      comment: "Number of flotation events"
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`processing_process_water_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Water balance and recycling metrics tracking fresh water intake, recycled water, specific consumption, and licence compliance for sustainability reporting"
  source: "`mining_ecm`.`processing`.`process_water_balance`"
  dimensions:
    - name: "balance_period_start"
      expr: balance_period_start
      comment: "Start timestamp of water balance period"
    - name: "balance_period_end"
      expr: balance_period_end
      comment: "End timestamp of water balance period"
    - name: "period_type"
      expr: period_type
      comment: "Type of balance period"
    - name: "balance_status"
      expr: balance_status
      comment: "Status of water balance"
    - name: "water_source_type"
      expr: water_source_type
      comment: "Type of water source"
    - name: "water_stress_zone"
      expr: water_stress_zone
      comment: "Water stress zone classification"
    - name: "is_licence_limit_exceeded"
      expr: is_licence_limit_exceeded
      comment: "Flag indicating if water licence limit was exceeded"
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality flag for balance"
    - name: "balance_month"
      expr: DATE_TRUNC('MONTH', balance_period_start)
      comment: "Month of water balance for aggregation"
  measures:
    - name: "total_fresh_water_intake_m3"
      expr: SUM(CAST(fresh_water_intake_m3 AS DOUBLE))
      comment: "Total fresh water intake in cubic meters"
    - name: "total_recycled_water_intake_m3"
      expr: SUM(CAST(recycled_water_intake_m3 AS DOUBLE))
      comment: "Total recycled water intake in cubic meters"
    - name: "total_process_water_intake_m3"
      expr: SUM(CAST(process_water_intake_m3 AS DOUBLE))
      comment: "Total process water intake in cubic meters"
    - name: "total_water_input_m3"
      expr: SUM(CAST(total_water_input_m3 AS DOUBLE))
      comment: "Total water input in cubic meters"
    - name: "total_water_output_m3"
      expr: SUM(CAST(total_water_output_m3 AS DOUBLE))
      comment: "Total water output in cubic meters"
    - name: "total_net_water_consumption_m3"
      expr: SUM(CAST(net_water_consumption_m3 AS DOUBLE))
      comment: "Total net water consumption in cubic meters"
    - name: "total_evaporation_loss_m3"
      expr: SUM(CAST(evaporation_loss_m3 AS DOUBLE))
      comment: "Total evaporation loss in cubic meters"
    - name: "total_seepage_loss_m3"
      expr: SUM(CAST(seepage_loss_m3 AS DOUBLE))
      comment: "Total seepage loss in cubic meters"
    - name: "total_ore_processed_t"
      expr: SUM(CAST(ore_processed_t AS DOUBLE))
      comment: "Total ore processed in tonnes"
    - name: "avg_balance_closure"
      expr: AVG(CAST(balance_closure_pct AS DOUBLE))
      comment: "Average water balance closure percentage"
    - name: "avg_recycled_water_ratio"
      expr: AVG(CAST(recycled_water_ratio_pct AS DOUBLE))
      comment: "Average recycled water ratio percentage"
    - name: "avg_specific_water_consumption"
      expr: AVG(CAST(specific_water_consumption_m3_per_t AS DOUBLE))
      comment: "Average specific water consumption per tonne"
    - name: "avg_licence_utilisation"
      expr: AVG(CAST(licence_utilisation_pct AS DOUBLE))
      comment: "Average water licence utilisation percentage"
    - name: "water_balance_count"
      expr: COUNT(1)
      comment: "Number of water balance records"
    - name: "licence_breach_count"
      expr: COUNT(CASE WHEN is_licence_limit_exceeded = TRUE THEN 1 END)
      comment: "Number of water licence breaches"
$$;
