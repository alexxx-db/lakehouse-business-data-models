-- Metric views for domain: generation | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-05 00:38:04

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`generation_dispatch_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational dispatch performance metrics per schedule"
  source: "`energy_utilities_ecm`.`generation`.`dispatch_schedule`"
  dimensions:
    - name: "control_area_id"
      expr: control_area_id
      comment: "Identifier of the control area"
    - name: "dispatch_schedule_number"
      expr: dispatch_schedule_number
      comment: "Business reference number for the dispatch schedule"
    - name: "dispatch_status"
      expr: dispatch_status
      comment: "Current status of the dispatch schedule"
    - name: "schedule_interval_start_timestamp"
      expr: schedule_interval_start_timestamp
      comment: "Start of the dispatch interval"
    - name: "schedule_interval_end_timestamp"
      expr: schedule_interval_end_timestamp
      comment: "End of the dispatch interval"
    - name: "generating_unit_id"
      expr: generating_unit_id
      comment: "Primary generating unit associated with the schedule"
  measures:
    - name: "total_actual_output_mw"
      expr: SUM(CAST(actual_output_mw AS DOUBLE))
      comment: "Total actual MW output across all dispatch schedules"
    - name: "total_dispatch_variance_mw"
      expr: SUM(CAST(dispatch_variance_mw AS DOUBLE))
      comment: "Sum of MW variance between scheduled and actual output"
    - name: "average_ramp_rate_mw_per_min"
      expr: AVG(CAST(ramp_rate_mw_per_minute AS DOUBLE))
      comment: "Average ramp rate in MW per minute"
    - name: "dispatch_count"
      expr: COUNT(1)
      comment: "Number of dispatch schedule records"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`generation_capacity_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic capacity planning KPIs"
  source: "`energy_utilities_ecm`.`generation`.`capacity_plan`"
  dimensions:
    - name: "planning_horizon_year"
      expr: planning_horizon_year
      comment: "Planning horizon year (e.g., 2025)"
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the capacity plan"
    - name: "control_area_id"
      expr: control_area_id
      comment: "Control area associated with the plan"
    - name: "power_plant_id"
      expr: power_plant_id
      comment: "Primary power plant for the capacity plan"
    - name: "plan_name"
      expr: plan_name
      comment: "Descriptive name of the capacity plan"
  measures:
    - name: "total_planned_capacity_additions_mw"
      expr: SUM(CAST(planned_capacity_additions_mw AS DOUBLE))
      comment: "Total MW of capacity planned to be added"
    - name: "total_existing_capacity_mw"
      expr: SUM(CAST(existing_capacity_mw AS DOUBLE))
      comment: "Total existing MW capacity at plan creation"
    - name: "net_capacity_change_mw"
      expr: SUM(CAST(net_capacity_change_mw AS DOUBLE))
      comment: "Net change in capacity (additions minus retirements)"
    - name: "total_renewable_capacity_additions_mw"
      expr: SUM(CAST(renewable_capacity_additions_mw AS DOUBLE))
      comment: "MW of renewable capacity additions"
    - name: "total_fossil_capacity_additions_mw"
      expr: SUM(CAST(fossil_capacity_additions_mw AS DOUBLE))
      comment: "MW of fossil fuel capacity additions"
    - name: "capacity_plan_count"
      expr: COUNT(1)
      comment: "Number of capacity plan records"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`generation_emissions_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental emissions reporting metrics"
  source: "`energy_utilities_ecm`.`generation`.`emissions_reading`"
  dimensions:
    - name: "control_area_id"
      expr: control_area_id
      comment: "Control area of the emission source"
    - name: "power_plant_id"
      expr: power_plant_id
      comment: "Power plant identifier"
    - name: "generating_unit_id"
      expr: generating_unit_id
      comment: "Generating unit linked to the reading"
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year"
    - name: "reporting_quarter"
      expr: reporting_quarter
      comment: "Reporting quarter"
    - name: "pollutant_type"
      expr: pollutant_type
      comment: "Type of pollutant measured"
  measures:
    - name: "total_emissions_mass"
      expr: SUM(CAST(total_mass_emissions AS DOUBLE))
      comment: "Total mass of emissions reported"
    - name: "avg_emission_rate"
      expr: AVG(CAST(emission_rate AS DOUBLE))
      comment: "Average emission rate across readings"
    - name: "co2_emissions_tons"
      expr: SUM(CASE WHEN pollutant_type = 'CO2' THEN total_mass_emissions ELSE 0 END)
      comment: "Total CO2 emissions in tons"
    - name: "emissions_reading_count"
      expr: COUNT(1)
      comment: "Number of emissions reading records"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`generation_fuel_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and contractual KPIs for fuel procurement"
  source: "`energy_utilities_ecm`.`generation`.`fuel_contract`"
  dimensions:
    - name: "fuel_type"
      expr: fuel_type
      comment: "Type of fuel (e.g., natural_gas, coal)"
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract"
    - name: "regulatory_approval_date"
      expr: regulatory_approval_date
      comment: "Date of regulatory approval"
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Contract effective start date"
  measures:
    - name: "total_contract_value_usd"
      expr: SUM(CAST(contract_value_total AS DOUBLE))
      comment: "Total monetary value of fuel contracts"
    - name: "avg_base_price_usd"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base price per unit of fuel"
    - name: "total_contracted_volume_annual"
      expr: SUM(CAST(contracted_volume_annual AS DOUBLE))
      comment: "Total annual contracted fuel volume"
    - name: "fuel_contract_count"
      expr: COUNT(1)
      comment: "Number of fuel contract records"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`generation_output_telemetry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real‑time generation telemetry performance metrics"
  source: "`energy_utilities_ecm`.`generation`.`output_telemetry`"
  dimensions:
    - name: "control_area_id"
      expr: control_area_id
      comment: "Control area identifier"
    - name: "primary_generating_unit_id"
      expr: primary_generating_unit_id
      comment: "Generating unit identifier"
    - name: "interval_timestamp"
      expr: interval_timestamp
      comment: "Timestamp of the telemetry interval"
    - name: "availability_status"
      expr: availability_status
      comment: "Operational availability status"
  measures:
    - name: "total_gross_generation_mwh"
      expr: SUM(CAST(gross_generation_mwh AS DOUBLE))
      comment: "Total gross generation in MWh"
    - name: "total_net_generation_mwh"
      expr: SUM(CAST(net_generation_mwh AS DOUBLE))
      comment: "Total net generation in MWh"
    - name: "avg_capacity_factor_percent"
      expr: AVG(CAST(capacity_factor_percent AS DOUBLE))
      comment: "Average capacity factor percentage"
    - name: "total_emissions_co2_tons"
      expr: SUM(CAST(emissions_co2_tons AS DOUBLE))
      comment: "Total CO2 emissions in tons"
    - name: "telemetry_record_count"
      expr: COUNT(1)
      comment: "Number of telemetry records"
$$;
