-- Metric views for domain: metering | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-04 21:07:37

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`metering_ami_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key operational KPIs from AMI event data, useful for revenue protection and grid integrity monitoring"
  source: "`energy_utilities_ecm`.`metering`.`ami_event`"
  dimensions:
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the AMI event"
    - name: "event_type"
      expr: event_type_code
      comment: "Code describing the type of AMI event"
    - name: "event_severity"
      expr: event_severity
      comment: "Severity level of the AMI event"
  measures:
    - name: "total_estimated_unbilled_consumption_kwh"
      expr: SUM(CAST(estimated_unbilled_consumption_kwh AS DOUBLE))
      comment: "Total estimated unbilled consumption in kWh across all AMI events"
    - name: "total_revenue_recovery_amount"
      expr: SUM(CAST(revenue_recovery_amount AS DOUBLE))
      comment: "Total revenue recovery amount associated with AMI events"
    - name: "total_reverse_flow_kwh"
      expr: SUM(CAST(reverse_flow_kwh AS DOUBLE))
      comment: "Total reverse flow energy in kWh captured by AMI events"
    - name: "event_count"
      expr: COUNT(1)
      comment: "Number of AMI events recorded"
    - name: "theft_event_count"
      expr: SUM(CASE WHEN confirmed_theft_indicator THEN 1 ELSE 0 END)
      comment: "Count of AMI events flagged as confirmed theft"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`metering_mdm_usage_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated usage and demand metrics for billing and demand‑response analysis"
  source: "`energy_utilities_ecm`.`metering`.`mdm_usage_transaction`"
  dimensions:
    - name: "billing_month"
      expr: DATE_TRUNC('month', billing_period_start_date)
      comment: "Billing period month"
    - name: "rate_component"
      expr: rate_component_code
      comment: "Rate component associated with the transaction"
    - name: "usage_quality"
      expr: usage_quality_code
      comment: "Quality code of the usage measurement"
  measures:
    - name: "total_consumption_kwh"
      expr: SUM(CAST(consumption_kwh AS DOUBLE))
      comment: "Total energy consumption in kWh recorded in MDM usage transactions"
    - name: "total_on_peak_kwh"
      expr: SUM(CAST(on_peak_kwh AS DOUBLE))
      comment: "Total on‑peak consumption in kWh"
    - name: "total_off_peak_kwh"
      expr: SUM(CAST(off_peak_kwh AS DOUBLE))
      comment: "Total off‑peak consumption in kWh"
    - name: "total_peak_demand_kw"
      expr: SUM(CAST(peak_demand_kw AS DOUBLE))
      comment: "Aggregate peak demand in kW"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of MDM usage transaction records"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`metering_interval_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core interval reading KPIs for load profiling and temperature impact analysis"
  source: "`energy_utilities_ecm`.`metering`.`interval_reading`"
  dimensions:
    - name: "interval_day"
      expr: DATE_TRUNC('day', interval_start_timestamp)
      comment: "Day of the interval reading"
    - name: "meter_id"
      expr: meter_id
      comment: "Identifier of the meter that produced the reading"
    - name: "channel_number"
      expr: channel_number
      comment: "Channel number of the reading"
  measures:
    - name: "total_reading_value"
      expr: SUM(CAST(reading_value AS DOUBLE))
      comment: "Sum of interval reading values (kWh) across all intervals"
    - name: "average_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average temperature during interval readings"
    - name: "reading_count"
      expr: COUNT(1)
      comment: "Number of interval reading records"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`metering_net_energy_metering`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic metrics for evaluating net‑energy program scale and capacity"
  source: "`energy_utilities_ecm`.`metering`.`net_energy_metering`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status of the net‑energy account"
    - name: "application_month"
      expr: DATE_TRUNC('month', application_date)
      comment: "Month of net‑energy program application"
  measures:
    - name: "total_banking_balance_kwh"
      expr: SUM(CAST(banking_balance_kwh AS DOUBLE))
      comment: "Total banking balance energy in kWh for net energy metering accounts"
    - name: "total_nameplate_capacity_kw"
      expr: SUM(CAST(nameplate_capacity_kw AS DOUBLE))
      comment: "Aggregate nameplate capacity in kW of net‑metered assets"
    - name: "total_storage_capacity_kwh"
      expr: SUM(CAST(storage_capacity_kwh AS DOUBLE))
      comment: "Combined storage capacity in kWh"
    - name: "net_energy_metering_count"
      expr: COUNT(1)
      comment: "Number of net energy metering records"
$$;


CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`metering_tou_rate_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High‑level KPIs for time‑of‑use rate programs to assess financial and energy impact"
  source: "`energy_utilities_ecm`.`metering`.`tou_rate_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current status of the TOU program"
    - name: "program_type"
      expr: program_type
      comment: "Classification of the TOU program"
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month when the program became effective"
  measures:
    - name: "total_estimated_annual_savings_kwh"
      expr: SUM(CAST(estimated_annual_savings_kwh AS DOUBLE))
      comment: "Estimated annual energy savings in kWh across TOU programs"
    - name: "total_estimated_annual_cost_savings_usd"
      expr: SUM(CAST(estimated_annual_cost_savings_usd AS DOUBLE))
      comment: "Estimated annual cost savings in USD"
    - name: "program_count"
      expr: COUNT(1)
      comment: "Number of TOU rate program records"
$$;
