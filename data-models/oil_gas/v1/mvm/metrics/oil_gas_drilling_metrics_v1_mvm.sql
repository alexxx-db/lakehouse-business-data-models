-- Metric views for domain: drilling | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 09:27:20

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`drilling_bit_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance and cost efficiency metrics for drilling bits"
  source: "`oil_gas_ecm`.`drilling`.`bit_run`"
  dimensions:
    - name: "run_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date of the bit run"
    - name: "drilling_well_id"
      expr: drilling_well_id
      comment: "Identifier of the well being drilled"
    - name: "equipment_id"
      expr: equipment_id
      comment: "Equipment used for the bit run"
    - name: "formation_id"
      expr: formation_id
      comment: "Geological formation targeted"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor supplying the bit"
    - name: "bit_type"
      expr: bit_type
      comment: "Type of drilling bit"
    - name: "bit_model"
      expr: bit_model
      comment: "Model of the drilling bit"
    - name: "bit_size_inches"
      expr: bit_size_inches
      comment: "Size of the bit in inches"
  measures:
    - name: "total_bit_runs"
      expr: COUNT(1)
      comment: "Count of bit runs recorded"
    - name: "total_bit_cost_usd"
      expr: SUM(CAST(bit_cost_usd AS DOUBLE))
      comment: "Total cost of bits used"
    - name: "avg_rop_ft_per_hr"
      expr: AVG(CAST(average_rop_ft_per_hr AS DOUBLE))
      comment: "Average rate of penetration across bit runs"
    - name: "avg_rpm"
      expr: AVG(CAST(average_rpm AS DOUBLE))
      comment: "Average rotary speed of bits"
    - name: "avg_torque_ft_lbs"
      expr: AVG(CAST(average_torque_ft_lbs AS DOUBLE))
      comment: "Average torque applied during drilling"
    - name: "avg_wob_klbs"
      expr: AVG(CAST(average_wob_klbs AS DOUBLE))
      comment: "Average weight on bit"
    - name: "avg_cost_per_foot_usd"
      expr: AVG(CAST(cost_per_foot_usd AS DOUBLE))
      comment: "Average cost per foot of drilled hole"
    - name: "avg_hours_on_bottom"
      expr: AVG(CAST(hours_on_bottom AS DOUBLE))
      comment: "Average hours the bit spent on bottom"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`drilling_daily_drilling_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key productivity and cost metrics from daily drilling reports"
  source: "`oil_gas_ecm`.`drilling`.`daily_drilling_report`"
  dimensions:
    - name: "report_date"
      expr: report_date
      comment: "Date of the report"
    - name: "drilling_well_id"
      expr: drilling_well_id
      comment: "Well identifier"
    - name: "rig_id"
      expr: rig_id
      comment: "Rig used for the day"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center responsible"
    - name: "operation_status"
      expr: operation_status
      comment: "Operational status of the day"
    - name: "npt_category"
      expr: npt_category
      comment: "Non‑productive time category"
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Number of daily drilling reports"
    - name: "total_daily_cost_usd"
      expr: SUM(CAST(daily_cost_usd AS DOUBLE))
      comment: "Sum of daily drilling costs"
    - name: "cumulative_cost_usd"
      expr: SUM(CAST(cumulative_cost_usd AS DOUBLE))
      comment: "Cumulative cost to date"
    - name: "total_feet_drilled"
      expr: SUM(CAST(depth_drilled_ft AS DOUBLE))
      comment: "Total feet drilled per day"
    - name: "avg_rop_ft_per_hr"
      expr: AVG(CAST(rate_of_penetration_ft_per_hr AS DOUBLE))
      comment: "Average rate of penetration"
    - name: "total_productive_time_hours"
      expr: SUM(CAST(productive_time_hours AS DOUBLE))
      comment: "Total productive time"
    - name: "total_non_productive_time_hours"
      expr: SUM(CAST(non_productive_time_hours AS DOUBLE))
      comment: "Total non‑productive time"
    - name: "avg_weight_on_bit_klbs"
      expr: AVG(CAST(weight_on_bit_klbs AS DOUBLE))
      comment: "Average weight on bit"
    - name: "avg_standpipe_pressure_psi"
      expr: AVG(CAST(standpipe_pressure_psi AS DOUBLE))
      comment: "Average standpipe pressure"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`drilling_casing_design`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Structural integrity and design metrics for casing"
  source: "`oil_gas_ecm`.`drilling`.`casing_design`"
  dimensions:
    - name: "design_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the design was created"
    - name: "formation_id"
      expr: formation_id
      comment: "Target formation for the casing"
    - name: "well_program_id"
      expr: well_program_id
      comment: "Associated well program"
    - name: "casing_grade"
      expr: casing_grade
      comment: "Grade of the casing material"
    - name: "casing_string_type"
      expr: casing_string_type
      comment: "String type of the casing"
    - name: "design_status"
      expr: design_status
      comment: "Current status of the design"
  measures:
    - name: "total_casing_designs"
      expr: COUNT(1)
      comment: "Number of casing designs created"
    - name: "avg_burst_rating_psi"
      expr: AVG(CAST(burst_rating_psi AS DOUBLE))
      comment: "Average burst rating"
    - name: "avg_collapse_rating_psi"
      expr: AVG(CAST(collapse_rating_psi AS DOUBLE))
      comment: "Average collapse rating"
    - name: "avg_tension_rating_lb"
      expr: AVG(CAST(tension_rating_lb AS DOUBLE))
      comment: "Average tension rating"
    - name: "avg_weight_per_foot_lb"
      expr: AVG(CAST(weight_per_foot_lb AS DOUBLE))
      comment: "Average weight per foot of casing"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`drilling_cementing_job`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost and quality metrics for cementing operations"
  source: "`oil_gas_ecm`.`drilling`.`cementing_job`"
  dimensions:
    - name: "job_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the cementing job was created"
    - name: "drilling_well_id"
      expr: drilling_well_id
      comment: "Well where cementing was performed"
    - name: "rig_id"
      expr: rig_id
      comment: "Rig used for cementing"
    - name: "cement_bond_quality"
      expr: cement_bond_quality
      comment: "Quality of the cement bond"
    - name: "job_status"
      expr: job_status
      comment: "Current status of the cementing job"
  measures:
    - name: "total_cementing_jobs"
      expr: COUNT(1)
      comment: "Count of cementing jobs executed"
    - name: "total_actual_cost_usd"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Total actual cost of cementing jobs"
    - name: "avg_cement_compressive_strength_psi"
      expr: AVG(CAST(cement_compressive_strength_psi AS DOUBLE))
      comment: "Average compressive strength of cement"
    - name: "avg_job_duration_hours"
      expr: AVG(CAST(job_duration_hours AS DOUBLE))
      comment: "Average duration of cementing jobs"
    - name: "avg_lead_slurry_density_ppg"
      expr: AVG(CAST(lead_slurry_density_ppg AS DOUBLE))
      comment: "Average density of lead slurry"
$$;


CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`drilling_stimulation_job`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance and resource metrics for hydraulic stimulation"
  source: "`oil_gas_ecm`.`drilling`.`stimulation_job`"
  dimensions:
    - name: "job_date"
      expr: job_date
      comment: "Date of the stimulation job"
    - name: "drilling_well_id"
      expr: drilling_well_id
      comment: "Well being stimulated"
    - name: "completion_design_id"
      expr: completion_design_id
      comment: "Associated completion design"
    - name: "stimulation_type"
      expr: stimulation_type
      comment: "Type of stimulation technique"
    - name: "job_status"
      expr: job_status
      comment: "Current status of the stimulation job"
  measures:
    - name: "total_stimulation_jobs"
      expr: COUNT(1)
      comment: "Number of stimulation jobs performed"
    - name: "total_proppant_mass_lbs"
      expr: SUM(CAST(total_proppant_mass_lbs AS DOUBLE))
      comment: "Total proppant mass used"
    - name: "total_fluid_volume_bbl"
      expr: SUM(CAST(total_fluid_volume_bbl AS DOUBLE))
      comment: "Total fluid volume pumped"
    - name: "avg_max_treating_pressure_psi"
      expr: AVG(CAST(maximum_treating_pressure_psi AS DOUBLE))
      comment: "Average maximum treating pressure"
    - name: "avg_estimated_fracture_height_ft"
      expr: AVG(CAST(estimated_fracture_height_ft AS DOUBLE))
      comment: "Average estimated fracture height"
$$;
