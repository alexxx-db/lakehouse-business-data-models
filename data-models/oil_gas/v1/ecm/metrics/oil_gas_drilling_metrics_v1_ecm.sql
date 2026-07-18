-- Metric views for domain: drilling | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 05:05:28

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`drilling_afe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial performance indicators for Authorization for Expenditure (AFE) records"
  source: "`oil_gas_ecm`.`drilling`.`drilling_afe`"
  dimensions:
    - name: "afe_status"
      expr: afe_status
      comment: "Current status of the AFE (e.g., Approved, Pending, Closed)"
    - name: "afe_type"
      expr: afe_type
      comment: "Classification of the AFE (e.g., Capital, Operating)"
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category assigned to the AFE"
    - name: "rig_id"
      expr: rig_id
      comment: "Identifier of the rig associated with the AFE"
    - name: "operator_id"
      expr: operator_id
      comment: "Operator responsible for the AFE"
  measures:
    - name: "total_actual_cost_usd"
      expr: SUM(CAST(cumulative_actual_cost AS DOUBLE))
      comment: "Cumulative actual cost incurred for the AFE in USD"
    - name: "total_budget_variance_usd"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Sum of budget variance amounts (positive = under budget, negative = over budget) in USD"
    - name: "over_budget_afe_count"
      expr: SUM(CASE WHEN over_budget_flag THEN 1 ELSE 0 END)
      comment: "Count of AFEs that exceeded their budget"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`drilling_daily_drilling_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational efficiency and cost metrics from daily drilling reports"
  source: "`oil_gas_ecm`.`drilling`.`daily_drilling_report`"
  dimensions:
    - name: "report_date"
      expr: report_date
      comment: "Date of the daily drilling report"
    - name: "rig_id"
      expr: rig_id
      comment: "Rig used for the drilling operation"
    - name: "drilling_well_id"
      expr: drilling_well_id
      comment: "Well being drilled"
    - name: "operation_status"
      expr: operation_status
      comment: "Overall status of operations for the day (e.g., Active, Stopped)"
  measures:
    - name: "total_daily_cost_usd"
      expr: SUM(CAST(daily_cost_usd AS DOUBLE))
      comment: "Sum of daily drilling costs in USD"
    - name: "cumulative_cost_usd"
      expr: SUM(CAST(cumulative_cost_usd AS DOUBLE))
      comment: "Cumulative cost to date for the well in USD"
    - name: "total_non_productive_time_hours"
      expr: SUM(CAST(non_productive_time_hours AS DOUBLE))
      comment: "Total non‑productive time (NPT) recorded in hours"
    - name: "total_productive_time_hours"
      expr: SUM(CAST(productive_time_hours AS DOUBLE))
      comment: "Total productive drilling time in hours"
    - name: "average_rate_of_penetration_ft_per_hr"
      expr: AVG(CAST(rate_of_penetration_ft_per_hr AS DOUBLE))
      comment: "Average rate of penetration across the reporting period"
    - name: "average_weight_on_bit_klbs"
      expr: AVG(CAST(weight_on_bit_klbs AS DOUBLE))
      comment: "Average weight on bit in kilo‑pounds"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`drilling_bit_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance metrics for each bit run execution"
  source: "`oil_gas_ecm`.`drilling`.`bit_run`"
  dimensions:
    - name: "drilling_well_id"
      expr: drilling_well_id
      comment: "Well associated with the bit run"
    - name: "equipment_id"
      expr: equipment_id
      comment: "Equipment (e.g., top drive) used"
    - name: "zone_id"
      expr: zone_id
      comment: "Reservoir zone targeted"
    - name: "run_number"
      expr: run_number
      comment: "Identifier of the run within the well"
  measures:
    - name: "total_footage_drilled_ft"
      expr: SUM(CAST(footage_drilled_ft AS DOUBLE))
      comment: "Total footage drilled during the bit run"
    - name: "average_rpm"
      expr: AVG(CAST(average_rpm AS DOUBLE))
      comment: "Average revolutions per minute for the bit run"
    - name: "average_torque_ft_lbs"
      expr: AVG(CAST(average_torque_ft_lbs AS DOUBLE))
      comment: "Average torque applied during the bit run"
    - name: "average_wob_klbs"
      expr: AVG(CAST(average_wob_klbs AS DOUBLE))
      comment: "Average weight on bit during the bit run"
    - name: "average_flow_rate_gpm"
      expr: AVG(CAST(average_flow_rate_gpm AS DOUBLE))
      comment: "Average drilling fluid flow rate in gallons per minute"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`drilling_wellbore`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production and cost overview for individual wellbore segments"
  source: "`oil_gas_ecm`.`drilling`.`wellbore`"
  dimensions:
    - name: "wellbore_status"
      expr: wellbore_status
      comment: "Current status of the wellbore (e.g., Open, Closed)"
    - name: "wellbore_type"
      expr: wellbore_type
      comment: "Type of wellbore (e.g., Vertical, Horizontal)"
    - name: "drilling_well_id"
      expr: drilling_well_id
      comment: "Parent well identifier"
    - name: "rig_id"
      expr: rig_id
      comment: "Rig associated with the wellbore"
  measures:
    - name: "total_actual_production_bbl_per_day"
      expr: SUM(CAST(actual_production_rate_bbl_per_day AS DOUBLE))
      comment: "Total actual production rate summed across all records"
    - name: "average_actual_production_bbl_per_day"
      expr: AVG(CAST(actual_production_rate_bbl_per_day AS DOUBLE))
      comment: "Average daily production rate"
    - name: "total_cost_actual_usd"
      expr: SUM(CAST(cost_actual_usd AS DOUBLE))
      comment: "Total actual cost attributed to the wellbore"
    - name: "average_true_vertical_depth_m"
      expr: AVG(CAST(true_vertical_depth_m AS DOUBLE))
      comment: "Average true vertical depth in meters"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`drilling_stimulation_job`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key effectiveness and cost metrics for hydraulic fracturing stimulation jobs"
  source: "`oil_gas_ecm`.`drilling`.`stimulation_job`"
  dimensions:
    - name: "job_status"
      expr: job_status
      comment: "Current status of the stimulation job"
    - name: "stimulation_type"
      expr: stimulation_type
      comment: "Type of stimulation (e.g., Fracture, Acidizing)"
    - name: "zone_id"
      expr: zone_id
      comment: "Target reservoir zone"
    - name: "job_date"
      expr: job_date
      comment: "Date the stimulation job was performed"
  measures:
    - name: "total_proppant_mass_lbs"
      expr: SUM(CAST(total_proppant_mass_lbs AS DOUBLE))
      comment: "Total mass of proppant used in the stimulation job"
    - name: "average_proppant_concentration_ppa"
      expr: AVG(CAST(maximum_proppant_concentration_ppa AS DOUBLE))
      comment: "Average proppant concentration (pounds per acre)"
    - name: "average_treating_pressure_psi"
      expr: AVG(CAST(average_treating_pressure_psi AS DOUBLE))
      comment: "Average treating pressure applied during stimulation"
    - name: "total_fluid_volume_bbl"
      expr: SUM(CAST(total_fluid_volume_bbl AS DOUBLE))
      comment: "Total volume of fluid pumped in barrels"
$$;
