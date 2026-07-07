-- Metric views for domain: treatment | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-02 04:05:05

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_backwash_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for backwash operations, supporting operational efficiency and reliability decisions"
  source: "`vibe_water_utilities_v1`.`treatment`.`backwash_event`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Identifier of the treatment facility where the backwash occurred"
    - name: "backwash_date"
      expr: DATE_TRUNC('day', backwash_start_timestamp)
      comment: "Date of the backwash event (derived from start timestamp)"
  measures:
    - name: "total_backwash_events"
      expr: COUNT(1)
      comment: "Total number of backwash events recorded"
    - name: "total_backwash_volume_gal"
      expr: SUM(CAST(backwash_water_volume_gal AS DOUBLE))
      comment: "Cumulative volume of water used in backwash operations (gallons)"
    - name: "avg_backwash_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration of backwash cycles (minutes)"
    - name: "avg_backwash_flow_rate_gpm"
      expr: AVG(CAST(backwash_flow_rate_gpm AS DOUBLE))
      comment: "Average flow rate during backwash (gallons per minute)"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_chemical_dose_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chemical dosing performance and cost metrics, supporting operational budgeting and compliance monitoring"
  source: "`vibe_water_utilities_v1`.`treatment`.`chemical_dose_event`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Facility where dosing occurred"
  measures:
    - name: "dose_event_count"
      expr: COUNT(1)
      comment: "Number of chemical dose events recorded"
    - name: "total_chemical_mass_applied_kg"
      expr: SUM(CAST(chemical_mass_applied_kg AS DOUBLE))
      comment: "Total mass of chemical applied across events (kilograms)"
    - name: "avg_dose_rate_mg_per_l"
      expr: AVG(CAST(dose_rate_mg_per_l AS DOUBLE))
      comment: "Average dose rate applied (mg/L)"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_finished_water_production`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production and compliance metrics for finished water, guiding capacity planning and regulatory oversight"
  source: "`vibe_water_utilities_v1`.`treatment`.`finished_water_production`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Treatment facility identifier"
    - name: "production_date"
      expr: DATE_TRUNC('day', production_date)
      comment: "Date of production record"
  measures:
    - name: "production_event_count"
      expr: COUNT(1)
      comment: "Number of finished water production records"
    - name: "total_production_volume_mg"
      expr: SUM(CAST(finished_water_volume_mg AS DOUBLE))
      comment: "Total volume of finished water produced (million gallons) for the period"
    - name: "avg_production_rate_gpm"
      expr: AVG(CAST(avg_production_rate_gpm AS DOUBLE))
      comment: "Average production rate (gallons per minute)"
    - name: "peak_production_rate_gpm"
      expr: MAX(peak_production_rate_gpm)
      comment: "Maximum production rate observed (gallons per minute)"
    - name: "avg_plant_efficiency_ratio"
      expr: AVG(CAST(plant_efficiency_ratio AS DOUBLE))
      comment: "Average plant efficiency ratio (dimensionless)"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_membrane_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics to monitor membrane health, efficiency, and cleaning activities for strategic asset management"
  source: "`vibe_water_utilities_v1`.`treatment`.`membrane_performance`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Facility where the membrane unit is installed"
    - name: "observation_date"
      expr: DATE_TRUNC('day', observation_timestamp)
      comment: "Date of the performance observation"
  measures:
    - name: "membrane_performance_event_count"
      expr: COUNT(1)
      comment: "Number of membrane performance records"
    - name: "avg_recovery_rate_pct"
      expr: AVG(CAST(recovery_rate_pct AS DOUBLE))
      comment: "Average water recovery rate percentage"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_source_water_intake`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intake water quality and volume metrics, essential for source protection and treatment planning"
  source: "`vibe_water_utilities_v1`.`treatment`.`source_water_intake`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Facility receiving the source water"
    - name: "intake_date"
      expr: DATE_TRUNC('day', intake_timestamp)
      comment: "Date of the intake event"
    - name: "source_type"
      expr: source_type
      comment: "Classification of the water source (e.g., river, reservoir)"
    - name: "water_source_id"
      expr: water_source_id
      comment: "Identifier of the specific water source"
  measures:
    - name: "intake_event_count"
      expr: COUNT(1)
      comment: "Number of source water intake events"
    - name: "total_volume_withdrawn_mg"
      expr: SUM(CAST(volume_withdrawn_mg AS DOUBLE))
      comment: "Total volume of raw water withdrawn (million gallons)"
    - name: "avg_turbidity_ntu"
      expr: AVG(CAST(turbidity_ntu AS DOUBLE))
      comment: "Average turbidity of intake water (NTU)"
    - name: "avg_conductivity_us_per_cm"
      expr: AVG(CAST(conductivity_us_per_cm AS DOUBLE))
      comment: "Average electrical conductivity of intake water (µS/cm)"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance and risk metrics for treatment violations, informing regulatory strategy and corrective action prioritization"
  source: "`vibe_water_utilities_v1`.`treatment`.`treatment_violation`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Facility where the violation occurred"
    - name: "violation_type"
      expr: violation_type
      comment: "Category or type of the violation"
  measures:
    - name: "violation_count"
      expr: COUNT(1)
      comment: "Total number of treatment violations recorded"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_finished_water_production_volume`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Total volume of finished potable water produced across facilities, the top-line operational throughput of the utility."
  source: "`vibe_water_utilities_v1`.`treatment`.`finished_water_production`"
  dimensions:
    - name: "Production Date"
      expr: production_date
      comment: "Date of production for time trending"
    - name: "Facility"
      expr: facility_id
      comment: "Producing facility"
    - name: "Data Quality"
      expr: data_quality_flag
      comment: "Quality flag of the production record"
  measures:
    - name: "Finished Water MG"
      expr: ROUND(SUM(CAST(finished_water_volume_mg AS DOUBLE)), 2)
      comment: "Total finished water volume in million gallons"
    - name: "Source Water MG"
      expr: ROUND(SUM(CAST(source_water_volume_mg AS DOUBLE)), 2)
      comment: "Total source water intake in million gallons"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_plant_production_efficiency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ratio of finished water produced to source water withdrawn, a core measure of treatment process loss and plant efficiency."
  source: "`vibe_water_utilities_v1`.`treatment`.`finished_water_production`"
  dimensions:
    - name: "Production Date"
      expr: production_date
      comment: "Date of production"
    - name: "Facility"
      expr: facility_id
      comment: "Producing facility"
  measures:
    - name: "Avg Plant Efficiency"
      expr: ROUND(AVG(CAST(plant_efficiency_ratio AS DOUBLE)), 4)
      comment: "Average plant efficiency ratio"
    - name: "Computed Efficiency %"
      expr: ROUND(100.0 * SUM(CAST(finished_water_volume_mg AS DOUBLE)) / NULLIF(SUM(CAST(source_water_volume_mg AS DOUBLE)), 0), 2)
      comment: "Finished over source water percentage"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_backwash_water_loss_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Percentage of source water lost to backwash and filter-to-waste, a driver of plant self-consumption and NRW."
  source: "`vibe_water_utilities_v1`.`treatment`.`finished_water_production`"
  dimensions:
    - name: "Production Date"
      expr: production_date
      comment: "Date of production"
    - name: "Facility"
      expr: facility_id
      comment: "Producing facility"
  measures:
    - name: "In-Plant Loss %"
      expr: ROUND(100.0 * (SUM(CAST(backwash_volume_mg AS DOUBLE)) + SUM(CAST(filter_to_waste_volume_mg AS DOUBLE))) / NULLIF(SUM(CAST(source_water_volume_mg AS DOUBLE)), 0), 2)
      comment: "Backwash plus filter-to-waste over source water"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_finished_water_turbidity_quality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Average and maximum finished water turbidity, a leading indicator of filtration compliance under EPA SWTR."
  source: "`vibe_water_utilities_v1`.`treatment`.`finished_water_production`"
  dimensions:
    - name: "Production Date"
      expr: production_date
      comment: "Date of production"
    - name: "Facility"
      expr: facility_id
      comment: "Producing facility"
  measures:
    - name: "Avg Turbidity NTU"
      expr: ROUND(AVG(CAST(turbidity_avg_ntu AS DOUBLE)), 3)
      comment: "Average turbidity in NTU"
    - name: "Max Turbidity NTU"
      expr: ROUND(MAX(turbidity_max_ntu), 3)
      comment: "Peak turbidity in NTU"
    - name: "Turbidity Exceedance %"
      expr: ROUND(100.0 * SUM(CASE WHEN turbidity_max_ntu > 0.3 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of records above 0.3 NTU"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_finished_water_chlorine_residual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Average disinfectant residual in finished water, ensuring adequate secondary disinfection per SDWA."
  source: "`vibe_water_utilities_v1`.`treatment`.`finished_water_production`"
  dimensions:
    - name: "Production Date"
      expr: production_date
      comment: "Date of production"
    - name: "Facility"
      expr: facility_id
      comment: "Producing facility"
  measures:
    - name: "Avg Cl2 Residual mg/L"
      expr: ROUND(AVG(CAST(cl2_residual_avg_mg_l AS DOUBLE)), 3)
      comment: "Average chlorine residual"
    - name: "Low Residual Events"
      expr: SUM(CASE WHEN cl2_residual_avg_mg_l < 0.2 THEN 1 ELSE 0 END)
      comment: "Count of records below 0.2 mg/L"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_ct_disinfection_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Percentage of CT compliance records meeting required log inactivation, a critical SWTR/LT2ESWTR pathogen-control KPI."
  source: "`vibe_water_utilities_v1`.`treatment`.`ct_compliance_record`"
  dimensions:
    - name: "Facility"
      expr: facility_id
      comment: "Facility"
    - name: "Disinfectant Type"
      expr: disinfectant_type
      comment: "Disinfectant applied"
    - name: "Target Organism"
      expr: target_organism
      comment: "Pathogen target"
  measures:
    - name: "CT Compliance %"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'COMPLIANT' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of compliant CT records"
    - name: "Avg CT Ratio"
      expr: ROUND(AVG(CAST(ct_ratio AS DOUBLE)), 3)
      comment: "Average CT achieved over required"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_log_inactivation_achieved`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Average pathogen log inactivation achieved through disinfection, showing safety margin above regulatory minimums."
  source: "`vibe_water_utilities_v1`.`treatment`.`ct_compliance_record`"
  dimensions:
    - name: "Facility"
      expr: facility_id
      comment: "Facility"
    - name: "Target Organism"
      expr: target_organism
      comment: "Pathogen target"
  measures:
    - name: "Avg Log Inactivation"
      expr: ROUND(AVG(CAST(log_inactivation_achieved AS DOUBLE)), 3)
      comment: "Mean log inactivation"
    - name: "Records Below Target"
      expr: SUM(CASE WHEN ct_ratio < 1 THEN 1 ELSE 0 END)
      comment: "Count where CT ratio below 1"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_filter_run_turbidity_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Average terminal effluent turbidity across filter runs and the share of runs compliant with regulatory limits."
  source: "`vibe_water_utilities_v1`.`treatment`.`filter_run`"
  dimensions:
    - name: "Facility"
      expr: facility_id
      comment: "Facility"
    - name: "Filter Unit"
      expr: filter_unit_id
      comment: "Filter unit"
    - name: "Backwash Trigger"
      expr: backwash_trigger_reason
      comment: "Reason backwash was triggered"
  measures:
    - name: "Avg Terminal Turbidity NTU"
      expr: ROUND(AVG(CAST(terminal_effluent_turbidity_ntu AS DOUBLE)), 3)
      comment: "Average terminal effluent turbidity"
    - name: "Compliant Runs %"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of runs flagged compliant"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_filter_run_duration_productivity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Average filter run duration and volume filtered between backwashes, an indicator of filter media health and hydraulic productivity."
  source: "`vibe_water_utilities_v1`.`treatment`.`filter_run`"
  dimensions:
    - name: "Facility"
      expr: facility_id
      comment: "Facility"
    - name: "Filter Unit"
      expr: filter_unit_id
      comment: "Filter unit"
  measures:
    - name: "Avg Run Hours"
      expr: ROUND(AVG(CAST(run_duration_hours AS DOUBLE)), 2)
      comment: "Average run duration"
    - name: "Total Volume Filtered MG"
      expr: ROUND(SUM(CAST(volume_filtered_mg AS DOUBLE)), 2)
      comment: "Total volume filtered"
    - name: "Avg Terminal Head Loss ft"
      expr: ROUND(AVG(CAST(terminal_head_loss_ft AS DOUBLE)), 2)
      comment: "Average terminal head loss"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_uv_dose_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Percentage of UV disinfection events delivering required dose, a key pathogen-inactivation KPI for UV facilities."
  source: "`vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event`"
  dimensions:
    - name: "Facility"
      expr: facility_id
      comment: "Facility"
    - name: "Target Pathogen"
      expr: target_pathogen
      comment: "Target pathogen"
    - name: "Lamp Status"
      expr: lamp_status
      comment: "UV lamp status"
  measures:
    - name: "UV Dose Compliance %"
      expr: ROUND(100.0 * SUM(CASE WHEN dose_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of compliant UV events"
    - name: "Avg UV Transmittance %"
      expr: ROUND(AVG(CAST(uv_transmittance_pct AS DOUBLE)), 2)
      comment: "Average UV transmittance"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_membrane_integrity_recovery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Average membrane recovery rate and transmembrane pressure, indicating membrane fouling and process efficiency."
  source: "`vibe_water_utilities_v1`.`treatment`.`membrane_performance`"
  dimensions:
    - name: "Facility"
      expr: facility_id
      comment: "Facility"
    - name: "Process Unit"
      expr: process_unit_id
      comment: "Membrane train"
    - name: "Integrity Test Result"
      expr: integrity_test_result
      comment: "Integrity test outcome"
  measures:
    - name: "Avg Recovery %"
      expr: ROUND(AVG(CAST(recovery_rate_pct AS DOUBLE)), 2)
      comment: "Average membrane recovery rate"
    - name: "Avg TMP psi"
      expr: ROUND(AVG(CAST(transmembrane_pressure_psi AS DOUBLE)), 2)
      comment: "Average transmembrane pressure"
    - name: "Avg Log Removal"
      expr: ROUND(AVG(CAST(log_removal_value AS DOUBLE)), 3)
      comment: "Average log removal value"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_chemical_dose_ct_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Share of chemical dosing events meeting CT compliance and average residual achievement versus target."
  source: "`vibe_water_utilities_v1`.`treatment`.`chemical_dose_event`"
  dimensions:
    - name: "Facility"
      expr: facility_id
      comment: "Facility"
    - name: "Chemical"
      expr: chemical_id
      comment: "Chemical applied"
    - name: "Process Unit"
      expr: process_unit_id
      comment: "Process unit"
  measures:
    - name: "CT Compliance %"
      expr: ROUND(100.0 * SUM(CASE WHEN ct_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of CT compliant dosing events"
    - name: "Avg Residual Attainment %"
      expr: ROUND(100.0 * AVG(post_dose_residual_mg_per_l / NULLIF(target_residual_mg_per_l, 0)), 2)
      comment: "Post-dose residual vs target"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_chemical_mass_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Total chemical mass applied and average dose rate, driving chemical cost and treatment intensity."
  source: "`vibe_water_utilities_v1`.`treatment`.`chemical_dose_event`"
  dimensions:
    - name: "Facility"
      expr: facility_id
      comment: "Facility"
    - name: "Chemical"
      expr: chemical_id
      comment: "Chemical applied"
  measures:
    - name: "Total Mass Applied kg"
      expr: ROUND(SUM(CAST(chemical_mass_applied_kg AS DOUBLE)), 1)
      comment: "Total chemical mass applied"
    - name: "Avg Dose Rate mg/L"
      expr: ROUND(AVG(CAST(dose_rate_mg_per_l AS DOUBLE)), 3)
      comment: "Average dose rate"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_chemical_inventory_reorder_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Share of chemical inventory lines at or below reorder point, a supply-continuity risk indicator for treatment."
  source: "`vibe_water_utilities_v1`.`treatment`.`chemical_inventory`"
  dimensions:
    - name: "Facility"
      expr: facility_id
      comment: "Facility"
    - name: "Chemical"
      expr: chemical_id
      comment: "Chemical"
    - name: "Storage Location"
      expr: storage_location
      comment: "Storage location"
  measures:
    - name: "Below Reorder %"
      expr: ROUND(100.0 * SUM(CASE WHEN on_hand_quantity <= reorder_point THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of lines at/below reorder point"
    - name: "Total On-Hand Value USD"
      expr: ROUND(SUM(CAST(on_hand_quantity AS DOUBLE) * CAST(unit_cost AS DOUBLE)), 2)
      comment: "Value of chemical on hand"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_source_water_quality_intake`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Total volume withdrawn and average raw water turbidity/TOC, framing source vulnerability and treatment challenge."
  source: "`vibe_water_utilities_v1`.`treatment`.`source_water_intake`"
  dimensions:
    - name: "Facility"
      expr: facility_id
      comment: "Facility"
    - name: "Water Source"
      expr: water_source_id
      comment: "Source water"
    - name: "Source Type"
      expr: source_type
      comment: "Surface/ground/purchased"
  measures:
    - name: "Volume Withdrawn MG"
      expr: ROUND(SUM(CAST(volume_withdrawn_mg AS DOUBLE)), 2)
      comment: "Total volume withdrawn"
    - name: "Avg Raw Turbidity NTU"
      expr: ROUND(AVG(CAST(turbidity_ntu AS DOUBLE)), 3)
      comment: "Average raw turbidity"
    - name: "Avg TOC mg/L"
      expr: ROUND(AVG(CAST(toc_mg_per_l AS DOUBLE)), 3)
      comment: "Average total organic carbon"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_sludge_disposal_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Total residuals/biosolids volume produced and disposal cost, a material operating expense and environmental KPI."
  source: "`vibe_water_utilities_v1`.`treatment`.`sludge_production`"
  dimensions:
    - name: "Facility"
      expr: facility_id
      comment: "Facility"
    - name: "Disposal Method"
      expr: disposal_method
      comment: "Disposal method"
    - name: "Biosolids Class"
      expr: biosolids_class
      comment: "Class A/B"
  measures:
    - name: "Sludge Volume Gallons"
      expr: ROUND(SUM(CAST(sludge_volume_gallons AS DOUBLE)), 0)
      comment: "Total sludge volume"
    - name: "Disposal Cost USD"
      expr: ROUND(SUM(CAST(disposal_cost_usd AS DOUBLE)), 2)
      comment: "Total disposal cost"
    - name: "Avg Solids Content %"
      expr: ROUND(AVG(CAST(solids_content_pct AS DOUBLE)), 2)
      comment: "Average solids content"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_violation_incidence`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Count of SDWA treatment violations and share requiring public notification, a top compliance risk metric."
  source: "`vibe_water_utilities_v1`.`treatment`.`treatment_violation`"
  dimensions:
    - name: "Facility"
      expr: facility_id
      comment: "Facility"
    - name: "Violation Type"
      expr: violation_type
      comment: "MCL/MRDL/TT/monitoring"
    - name: "Contaminant"
      expr: contaminant
      comment: "Contaminant involved"
  measures:
    - name: "Violation Count"
      expr: COUNT(1)
      comment: "Number of violations"
    - name: "Public Notification %"
      expr: ROUND(100.0 * SUM(CASE WHEN public_notification_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent requiring public notification"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_mor_submission_timeliness`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution of MOR submission status by facility, tracking regulatory reporting discipline."
  source: "`vibe_water_utilities_v1`.`treatment`.`mor_submission`"
  dimensions:
    - name: "Facility"
      expr: facility_id
      comment: "Facility"
    - name: "Submission Status"
      expr: submission_status
      comment: "MOR status"
  measures:
    - name: "Submitted On Time %"
      expr: ROUND(100.0 * SUM(CASE WHEN submission_status = 'SUBMITTED' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent submitted"
    - name: "Submission Count"
      expr: COUNT(1)
      comment: "Number of MOR submissions"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_process_reading_exceedance_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Share of process readings flagged as regulatory exceedances or in alarm state, an operational risk signal from SCADA/PI data."
  source: "`vibe_water_utilities_v1`.`treatment`.`process_reading`"
  dimensions:
    - name: "Facility"
      expr: facility_id
      comment: "Facility"
    - name: "Alarm State"
      expr: alarm_state
      comment: "Alarm state of reading"
    - name: "Manual Entry"
      expr: is_manual_entry
      comment: "Manual vs automated"
  measures:
    - name: "Exceedance %"
      expr: ROUND(100.0 * SUM(CASE WHEN is_regulatory_exceedance = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of readings flagged as exceedance"
    - name: "Reading Count"
      expr: COUNT(1)
      comment: "Number of process readings"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_process_compliance_monitoring_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Share of treatment monitoring obligations currently in compliance versus overdue, by regulatory basis."
  source: "`vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring`"
  dimensions:
    - name: "Facility"
      expr: facility_id
      comment: "Facility"
    - name: "Regulatory Basis"
      expr: regulatory_basis
      comment: "SDWA basis"
    - name: "Monitoring Parameter"
      expr: monitoring_parameter
      comment: "Parameter monitored"
  measures:
    - name: "In Compliance %"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'COMPLIANT' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent compliant"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_operator_qualification_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Share of operator qualifications in active status, ensuring certified-operator staffing per state requirements."
  source: "`vibe_water_utilities_v1`.`treatment`.`operator_qualification`"
  dimensions:
    - name: "Facility"
      expr: facility_id
      comment: "Facility"
    - name: "Certification Grade"
      expr: certification_grade
      comment: "Operator grade"
    - name: "Qualification Status"
      expr: qualification_status
      comment: "Status"
  measures:
    - name: "Active Qualification %"
      expr: ROUND(100.0 * SUM(CASE WHEN qualification_status = 'ACTIVE' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent active qualifications"
    - name: "Qualified Operators"
      expr: COUNT(DISTINCT employee_id)
      comment: "Distinct qualified operators"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_permit_expiry_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Permitted capacity by permit type and count of permits, framing regulatory operating authority."
  source: "`vibe_water_utilities_v1`.`treatment`.`treatment_permit`"
  dimensions:
    - name: "Facility"
      expr: facility_id
      comment: "Facility"
    - name: "Permit Type"
      expr: permit_type
      comment: "Permit type"
    - name: "Issuing Agency"
      expr: issuing_agency
      comment: "Agency"
  measures:
    - name: "Permitted Capacity MGD"
      expr: ROUND(SUM(CAST(permitted_capacity_mgd AS DOUBLE)), 2)
      comment: "Total permitted capacity"
    - name: "Permit Count"
      expr: COUNT(1)
      comment: "Number of permits"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_facility_capacity_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Average daily production against average daily flow, indicating headroom and expansion needs across the treatment fleet."
  source: "`vibe_water_utilities_v1`.`treatment`.`facility`"
  dimensions:
    - name: "Facility"
      expr: facility_id
      comment: "Facility"
    - name: "Asset Condition Rating"
      expr: asset_condition_rating
      comment: "Condition of facility"
  measures:
    - name: "Avg Daily Production MGD"
      expr: ROUND(AVG(CAST(average_daily_production_mgd AS DOUBLE)), 3)
      comment: "Average daily production"
    - name: "Avg Daily Flow MGD"
      expr: ROUND(AVG(CAST(average_daily_flow_mgd AS DOUBLE)), 3)
      comment: "Average daily flow"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_facility_energy_intensity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Annual energy consumption and operating cost per facility, key sustainability and OpEx KPIs."
  source: "`vibe_water_utilities_v1`.`treatment`.`facility`"
  dimensions:
    - name: "Facility"
      expr: facility_id
      comment: "Facility"
  measures:
    - name: "Annual Energy kWh"
      expr: ROUND(SUM(CAST(annual_energy_consumption_kwh AS DOUBLE)), 0)
      comment: "Total annual energy consumption"
    - name: "Annual Operating Cost USD"
      expr: ROUND(SUM(CAST(annual_operating_cost_usd AS DOUBLE)), 2)
      comment: "Total annual operating cost"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_facility_capacity_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allocated treatment capacity to service territories by priority tier, supporting wholesale and demand planning."
  source: "`vibe_water_utilities_v1`.`treatment`.`facility_service_allocation`"
  dimensions:
    - name: "Facility"
      expr: facility_id
      comment: "Facility"
    - name: "Territory"
      expr: territory_id
      comment: "Service territory"
    - name: "Priority Tier"
      expr: priority_tier
      comment: "Allocation priority"
  measures:
    - name: "Allocated Capacity MGD"
      expr: ROUND(SUM(CAST(allocated_capacity_mgd AS DOUBLE)), 2)
      comment: "Total allocated capacity"
$$;