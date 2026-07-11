-- Metric views for domain: treatment | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-10 19:05:00

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_finished_water_production`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for finished water production volume, efficiency, and regulatory compliance. Used by plant managers and executives to monitor daily output, treatment efficiency, and CT/turbidity compliance trends."
  source: "`vibe_water_utilities_v1`.`treatment`.`finished_water_production`"
  dimensions:
    - name: "production_date"
      expr: production_date
      comment: "Date of finished water production record, used for daily/monthly trend analysis."
    - name: "production_status"
      expr: production_status
      comment: "Operational status of the production record (e.g., approved, pending, rejected)."
    - name: "disinfection_method"
      expr: disinfection_method
      comment: "Primary disinfection method applied (e.g., chlorination, UV, ozone) for process benchmarking."
    - name: "treatment_process_type"
      expr: treatment_process_type
      comment: "Type of treatment process used, enabling comparison across process configurations."
    - name: "shift_code"
      expr: shift_code
      comment: "Operational shift code for shift-level performance analysis."
    - name: "regulatory_exceedance_flag"
      expr: regulatory_exceedance
      comment: "Indicates whether a regulatory exceedance occurred during this production period."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Flags records with data quality issues for exclusion from reporting if needed."
  measures:
    - name: "total_finished_water_volume_mg"
      expr: SUM(CAST(finished_water_volume_mg AS DOUBLE))
      comment: "Total finished water produced in million gallons. Core throughput KPI for capacity planning and regulatory reporting."
    - name: "total_source_water_volume_mg"
      expr: SUM(CAST(source_water_volume_mg AS DOUBLE))
      comment: "Total raw source water withdrawn in million gallons. Used to compute plant efficiency ratio."
    - name: "total_volume_pumped_to_distribution_mg"
      expr: SUM(CAST(volume_pumped_to_distribution_mg AS DOUBLE))
      comment: "Total volume delivered to the distribution system in million gallons. Tracks actual delivery vs. production."
    - name: "total_backwash_volume_mg"
      expr: SUM(CAST(backwash_volume_mg AS DOUBLE))
      comment: "Total water consumed in backwash operations in million gallons. Drives water loss and efficiency analysis."
    - name: "total_plant_ops_water_volume_mg"
      expr: SUM(CAST(plant_ops_water_volume_mg AS DOUBLE))
      comment: "Total water used for plant operations (non-product use) in million gallons."
    - name: "avg_plant_efficiency_ratio"
      expr: AVG(CAST(plant_efficiency_ratio AS DOUBLE))
      comment: "Average plant efficiency ratio (finished water / source water). Key operational efficiency KPI; lower values indicate higher water loss."
    - name: "avg_turbidity_ntu"
      expr: AVG(CAST(turbidity_avg_ntu AS DOUBLE))
      comment: "Average finished water turbidity in NTU across production records. Regulatory compliance indicator (must be <0.3 NTU for 95% of readings under SWTR)."
    - name: "max_turbidity_ntu"
      expr: MAX(turbidity_max_ntu)
      comment: "Maximum turbidity recorded in NTU. Identifies worst-case compliance risk events."
    - name: "avg_cl2_residual_mg_l"
      expr: AVG(CAST(cl2_residual_avg_mg_l AS DOUBLE))
      comment: "Average chlorine residual in mg/L. Tracks disinfection effectiveness and regulatory minimum residual compliance."
    - name: "min_cl2_residual_mg_l"
      expr: MIN(cl2_residual_min_mg_l)
      comment: "Minimum chlorine residual recorded in mg/L. Critical for identifying periods of inadequate disinfection."
    - name: "avg_ct_achieved_mg_min_l"
      expr: AVG(CAST(ct_achieved_mg_min_l AS DOUBLE))
      comment: "Average CT value achieved (concentration × time) in mg·min/L. Measures disinfection efficacy against Giardia/Cryptosporidium."
    - name: "avg_ct_required_mg_min_l"
      expr: AVG(CAST(ct_required_mg_min_l AS DOUBLE))
      comment: "Average CT value required by regulation in mg·min/L. Used alongside achieved CT to compute compliance margin."
    - name: "avg_production_rate_gpm"
      expr: AVG(CAST(avg_production_rate_gpm AS DOUBLE))
      comment: "Average production flow rate in gallons per minute. Tracks operational throughput against design capacity."
    - name: "peak_production_rate_gpm"
      expr: MAX(peak_production_rate_gpm)
      comment: "Maximum peak production rate observed in gallons per minute. Used for capacity headroom analysis."
    - name: "avg_ph"
      expr: AVG(CAST(ph_avg AS DOUBLE))
      comment: "Average finished water pH. Regulatory and corrosion control compliance indicator."
    - name: "avg_toc_mg_l"
      expr: AVG(CAST(toc_avg_mg_l AS DOUBLE))
      comment: "Average total organic carbon in mg/L. Drives DBP formation risk and enhanced coagulation compliance."
    - name: "regulatory_exceedance_count"
      expr: SUM(CASE WHEN regulatory_exceedance = TRUE THEN 1 ELSE 0 END)
      comment: "Count of production records with regulatory exceedances. Tracks compliance failures requiring corrective action and public notification."
    - name: "production_record_count"
      expr: COUNT(1)
      comment: "Total number of finished water production records. Baseline count for rate calculations."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_ct_compliance_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CT (disinfectant contact time) compliance KPIs for Surface Water Treatment Rule and GWUDI compliance. Used by compliance officers and plant managers to track inactivation credit achievement and corrective action rates."
  source: "`vibe_water_utilities_v1`.`treatment`.`ct_compliance_record`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "CT compliance status (e.g., compliant, non-compliant, pending review)."
    - name: "disinfectant_type"
      expr: disinfectant_type
      comment: "Type of disinfectant used (e.g., free chlorine, chloramine, ozone, UV) for process-level benchmarking."
    - name: "target_organism"
      expr: target_organism
      comment: "Target pathogen for CT calculation (e.g., Giardia, Cryptosporidium, virus)."
    - name: "source_water_type"
      expr: source_water_type
      comment: "Source water classification (surface water, GWUDI) affecting CT requirements."
    - name: "reporting_period_start"
      expr: reporting_period_start
      comment: "Start date of the reporting period for trend analysis."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required
      comment: "Indicates whether a corrective action was required for this CT record."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate CT (e.g., SCADA-automated, manual, T10-based)."
  measures:
    - name: "avg_ct_ratio"
      expr: AVG(CAST(ct_ratio AS DOUBLE))
      comment: "Average ratio of CT achieved to CT required. Values ≥1.0 indicate compliance; trending below 1.0 signals regulatory risk."
    - name: "min_ct_ratio"
      expr: MIN(ct_ratio)
      comment: "Minimum CT ratio observed. Identifies worst-case compliance events requiring immediate investigation."
    - name: "avg_log_inactivation_achieved"
      expr: AVG(CAST(log_inactivation_achieved AS DOUBLE))
      comment: "Average log inactivation credit achieved. Regulatory benchmark for pathogen reduction efficacy."
    - name: "avg_log_inactivation_required"
      expr: AVG(CAST(log_inactivation_required AS DOUBLE))
      comment: "Average log inactivation credit required by permit. Used to compute compliance margin."
    - name: "avg_ct_calculated"
      expr: AVG(CAST(ct_calculated AS DOUBLE))
      comment: "Average calculated CT value in mg·min/L across all records."
    - name: "avg_ct_required"
      expr: AVG(CAST(ct_required AS DOUBLE))
      comment: "Average required CT value in mg·min/L. Baseline for compliance gap analysis."
    - name: "non_compliant_record_count"
      expr: SUM(CASE WHEN compliance_status = 'non-compliant' THEN 1 ELSE 0 END)
      comment: "Count of CT records with non-compliant status. Drives regulatory reporting and enforcement risk assessment."
    - name: "corrective_action_required_count"
      expr: SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of CT records requiring corrective action. Tracks operational response burden from compliance failures."
    - name: "avg_contact_time_min"
      expr: AVG(CAST(contact_time_min AS DOUBLE))
      comment: "Average hydraulic contact time in minutes. Operational parameter for disinfection system design and optimization."
    - name: "avg_disinfectant_concentration"
      expr: AVG(CAST(disinfectant_concentration AS DOUBLE))
      comment: "Average disinfectant concentration in mg/L at the point of CT measurement."
    - name: "avg_temperature_c"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average water temperature in °C. Temperature directly affects CT requirements under SWTR tables."
    - name: "ct_record_count"
      expr: COUNT(1)
      comment: "Total CT compliance records. Baseline for compliance rate calculations."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Treatment compliance violation KPIs for regulatory risk management. Used by compliance officers, plant managers, and executives to track violation frequency, severity, penalty exposure, and resolution performance."
  source: "`vibe_water_utilities_v1`.`treatment`.`treatment_violation`"
  dimensions:
    - name: "violation_type"
      expr: violation_type
      comment: "Category of violation (e.g., MCL, TT, monitoring, reporting) for regulatory classification."
    - name: "violation_status"
      expr: violation_status
      comment: "Current status of the violation (e.g., open, resolved, under review)."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the violation for prioritization and escalation."
    - name: "contaminant_name"
      expr: contaminant_name
      comment: "Name of the contaminant involved in the violation for contaminant-level trend analysis."
    - name: "violation_date"
      expr: violation_date
      comment: "Date the violation was detected, used for temporal trend analysis."
    - name: "public_notification_required_flag"
      expr: public_notification_required
      comment: "Indicates whether public notification is required, driving community impact assessment."
    - name: "enforcement_action_taken_flag"
      expr: enforcement_action_taken
      comment: "Indicates whether a regulatory enforcement action was taken."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification for systemic failure analysis and prevention."
    - name: "is_repeat_violation_flag"
      expr: is_repeat_violation
      comment: "Flags repeat violations, which carry higher regulatory and reputational risk."
    - name: "public_notification_tier"
      expr: public_notification_tier
      comment: "Tier of public notification required (Tier 1/2/3) per SDWA, indicating urgency."
  measures:
    - name: "total_violation_count"
      expr: COUNT(1)
      comment: "Total number of treatment violations. Primary regulatory risk KPI tracked by compliance officers and regulators."
    - name: "open_violation_count"
      expr: SUM(CASE WHEN violation_status = 'open' THEN 1 ELSE 0 END)
      comment: "Count of currently open (unresolved) violations. Drives immediate compliance action prioritization."
    - name: "repeat_violation_count"
      expr: SUM(CASE WHEN is_repeat_violation = TRUE THEN 1 ELSE 0 END)
      comment: "Count of repeat violations. Repeat violations trigger escalated enforcement and higher penalties under SDWA."
    - name: "total_penalty_amount_usd"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalties assessed for treatment violations in USD. Direct financial risk KPI for executive reporting."
    - name: "avg_penalty_amount_usd"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per violation in USD. Benchmarks penalty severity and informs compliance investment decisions."
    - name: "avg_exceedance_magnitude"
      expr: AVG(CAST(exceedance_magnitude AS DOUBLE))
      comment: "Average magnitude of regulatory limit exceedance. Measures how far violations deviate from limits, indicating severity of treatment failures."
    - name: "max_exceedance_magnitude"
      expr: MAX(exceedance_magnitude)
      comment: "Maximum exceedance magnitude observed. Identifies worst-case treatment failures for root cause investigation."
    - name: "public_notification_required_count"
      expr: SUM(CASE WHEN public_notification_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of violations requiring public notification. Tracks community impact and reputational risk exposure."
    - name: "enforcement_action_count"
      expr: SUM(CASE WHEN enforcement_action_taken = TRUE THEN 1 ELSE 0 END)
      comment: "Count of violations that resulted in regulatory enforcement actions. Tracks escalation rate and regulatory relationship health."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_chemical_dose_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chemical dosing efficiency and cost KPIs for treatment operations. Used by plant managers and finance to optimize chemical spend, ensure CT compliance, and manage DBP formation risk."
  source: "`vibe_water_utilities_v1`.`treatment`.`chemical_dose_event`"
  dimensions:
    - name: "chemical_type"
      expr: chemical_type
      comment: "Type of chemical applied (e.g., chlorine, alum, polymer) for chemical-level cost and compliance analysis."
    - name: "dose_event_status"
      expr: dose_event_status
      comment: "Status of the dosing event (e.g., completed, aborted, in-progress)."
    - name: "treatment_process_stage"
      expr: treatment_process_stage
      comment: "Stage of treatment where chemical was applied (e.g., pre-treatment, primary, secondary disinfection)."
    - name: "dose_trigger_type"
      expr: dose_trigger_type
      comment: "What triggered the dosing event (e.g., scheduled, SCADA alarm, manual operator decision)."
    - name: "ct_compliance_flag"
      expr: ct_compliance_flag
      comment: "Indicates whether CT compliance was achieved during this dosing event."
    - name: "dbp_formation_risk_flag"
      expr: dbp_formation_risk_flag
      comment: "Flags events with elevated disinfection byproduct formation risk."
    - name: "regulatory_event_flag"
      expr: regulatory_event_flag
      comment: "Indicates whether this dosing event has regulatory reporting significance."
    - name: "target_parameter"
      expr: target_parameter
      comment: "Water quality parameter targeted by the dosing event (e.g., turbidity, pH, residual)."
    - name: "dosing_method"
      expr: dosing_method
      comment: "Method of chemical application (e.g., continuous feed, batch, slug dose)."
  measures:
    - name: "total_event_dose_cost_usd"
      expr: SUM(CAST(event_dose_cost_usd AS DOUBLE))
      comment: "Total chemical dosing cost in USD across all events. Primary chemical operations cost KPI for budget management."
    - name: "avg_event_dose_cost_usd"
      expr: AVG(CAST(event_dose_cost_usd AS DOUBLE))
      comment: "Average cost per dosing event in USD. Benchmarks dosing efficiency and identifies cost outliers."
    - name: "total_chemical_mass_applied_kg"
      expr: SUM(CAST(chemical_mass_applied_kg AS DOUBLE))
      comment: "Total mass of chemical applied in kilograms. Tracks chemical consumption for inventory and procurement planning."
    - name: "total_volume_applied_l"
      expr: SUM(CAST(volume_applied_l AS DOUBLE))
      comment: "Total volume of chemical solution applied in liters. Supports dosing pump calibration and chemical usage audits."
    - name: "avg_dose_rate_mg_per_l"
      expr: AVG(CAST(dose_rate_mg_per_l AS DOUBLE))
      comment: "Average chemical dose rate in mg/L. Operational benchmark for treatment optimization and regulatory compliance."
    - name: "avg_ct_value_mg_min_per_l"
      expr: AVG(CAST(ct_value_mg_min_per_l AS DOUBLE))
      comment: "Average CT value achieved during dosing events in mg·min/L. Tracks disinfection efficacy at the event level."
    - name: "avg_post_dose_residual_mg_l"
      expr: AVG(CAST(post_dose_residual_mg_per_l AS DOUBLE))
      comment: "Average post-dose disinfectant residual in mg/L. Measures dosing effectiveness and regulatory residual compliance."
    - name: "avg_unit_cost_per_kg"
      expr: AVG(CAST(unit_cost_per_kg AS DOUBLE))
      comment: "Average unit cost of chemical per kilogram. Tracks procurement efficiency and vendor pricing trends."
    - name: "ct_non_compliant_event_count"
      expr: SUM(CASE WHEN ct_compliance_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Count of dosing events where CT compliance was not achieved. Drives corrective action and process optimization."
    - name: "dbp_risk_event_count"
      expr: SUM(CASE WHEN dbp_formation_risk_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of dosing events with elevated DBP formation risk. Tracks TTHM/HAA5 regulatory risk exposure."
    - name: "dose_event_count"
      expr: COUNT(1)
      comment: "Total number of chemical dosing events. Baseline for rate and cost-per-event calculations."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_backwash_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Filter backwash performance and water loss KPIs. Used by plant operations managers to optimize backwash frequency, minimize water waste, and ensure post-backwash turbidity compliance."
  source: "`vibe_water_utilities_v1`.`treatment`.`backwash_event`"
  dimensions:
    - name: "event_status"
      expr: event_status
      comment: "Status of the backwash event (e.g., completed, aborted, in-progress)."
    - name: "initiation_type"
      expr: initiation_type
      comment: "How the backwash was initiated (e.g., scheduled, headloss-triggered, turbidity-triggered, manual)."
    - name: "trigger_reason"
      expr: trigger_reason
      comment: "Specific reason the backwash was triggered, for root cause and optimization analysis."
    - name: "filter_media_type"
      expr: filter_media_type
      comment: "Type of filter media (e.g., sand, anthracite, GAC) for media-specific performance benchmarking."
    - name: "backwash_water_source"
      expr: backwash_water_source
      comment: "Source of backwash water (e.g., finished water, recycle) affecting water loss calculations."
    - name: "turbidity_compliance_met_flag"
      expr: turbidity_compliance_met
      comment: "Indicates whether post-backwash turbidity compliance was achieved."
    - name: "air_scour_used_flag"
      expr: air_scour_used
      comment: "Indicates whether air scour was used, for process optimization analysis."
    - name: "abnormal_event_flag"
      expr: abnormal_event_flag
      comment: "Flags abnormal backwash events requiring investigation."
  measures:
    - name: "total_backwash_water_volume_gal"
      expr: SUM(CAST(backwash_water_volume_gal AS DOUBLE))
      comment: "Total water consumed in backwash operations in gallons. Key water loss KPI for non-revenue water and efficiency reporting."
    - name: "total_backwash_recycle_volume_gal"
      expr: SUM(CAST(backwash_recycle_volume_gal AS DOUBLE))
      comment: "Total backwash water recycled in gallons. Tracks water recovery efficiency and recycle system utilization."
    - name: "avg_backwash_flow_rate_gpm"
      expr: AVG(CAST(backwash_flow_rate_gpm AS DOUBLE))
      comment: "Average backwash flow rate in gallons per minute. Operational benchmark for backwash intensity optimization."
    - name: "avg_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average backwash event duration in minutes. Longer durations increase water loss and reduce filter availability."
    - name: "avg_pre_backwash_turbidity_ntu"
      expr: AVG(CAST(pre_backwash_turbidity_ntu AS DOUBLE))
      comment: "Average pre-backwash turbidity in NTU. Indicates filter loading level at time of backwash initiation."
    - name: "avg_post_backwash_turbidity_ntu"
      expr: AVG(CAST(post_backwash_turbidity_ntu AS DOUBLE))
      comment: "Average post-backwash turbidity in NTU. Measures backwash effectiveness and compliance with turbidity limits."
    - name: "avg_filter_run_time_prior_hrs"
      expr: AVG(CAST(filter_run_time_prior_hrs AS DOUBLE))
      comment: "Average filter run time before backwash in hours. Longer run times indicate better filter efficiency."
    - name: "turbidity_non_compliant_count"
      expr: SUM(CASE WHEN turbidity_compliance_met = FALSE THEN 1 ELSE 0 END)
      comment: "Count of backwash events where post-backwash turbidity compliance was not met. Regulatory risk indicator."
    - name: "abnormal_event_count"
      expr: SUM(CASE WHEN abnormal_event_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of abnormal backwash events. Tracks operational anomalies requiring investigation."
    - name: "backwash_event_count"
      expr: COUNT(1)
      comment: "Total number of backwash events. Baseline for frequency analysis and filter performance benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_filter_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Filter run performance KPIs for treatment plant operations. Used by plant managers to optimize filter run length, turbidity compliance, and media performance under Surface Water Treatment Rule requirements."
  source: "`vibe_water_utilities_v1`.`treatment`.`filter_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of the filter run (e.g., completed, terminated, in-progress)."
    - name: "backwash_trigger_reason"
      expr: backwash_trigger_reason
      comment: "Reason the filter run ended and backwash was triggered (e.g., headloss, turbidity, scheduled)."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether the filter run met all regulatory turbidity requirements."
    - name: "turbidity_mcl_exceedance_flag"
      expr: turbidity_mcl_exceedance
      comment: "Flags filter runs where turbidity MCL was exceeded, requiring immediate corrective action."
    - name: "filter_to_waste_flag"
      expr: filter_to_waste_flag
      comment: "Indicates whether filter-to-waste was used during ripening, affecting water loss calculations."
    - name: "run_start_date"
      expr: DATE(run_start_timestamp)
      comment: "Date the filter run started, for daily and monthly trend analysis."
  measures:
    - name: "avg_run_duration_hours"
      expr: AVG(CAST(run_duration_hours AS DOUBLE))
      comment: "Average filter run duration in hours. Longer runs indicate better filter performance and lower backwash frequency."
    - name: "total_volume_filtered_mg"
      expr: SUM(CAST(volume_filtered_mg AS DOUBLE))
      comment: "Total volume of water filtered in million gallons. Tracks filter throughput and capacity utilization."
    - name: "avg_influent_turbidity_ntu"
      expr: AVG(CAST(influent_turbidity_ntu AS DOUBLE))
      comment: "Average influent turbidity in NTU. Tracks raw water quality variability affecting filter performance."
    - name: "avg_terminal_effluent_turbidity_ntu"
      expr: AVG(CAST(terminal_effluent_turbidity_ntu AS DOUBLE))
      comment: "Average terminal effluent turbidity at end of run in NTU. Key compliance indicator under SWTR."
    - name: "avg_terminal_head_loss_ft"
      expr: AVG(CAST(terminal_head_loss_ft AS DOUBLE))
      comment: "Average terminal head loss in feet at end of filter run. Indicates filter loading and media condition."
    - name: "avg_hydraulic_loading_rate_gpm_sqft"
      expr: AVG(CAST(hydraulic_loading_rate_gpm_sqft AS DOUBLE))
      comment: "Average hydraulic loading rate in gpm/sqft. Operational benchmark for filter design and optimization."
    - name: "turbidity_mcl_exceedance_count"
      expr: SUM(CASE WHEN turbidity_mcl_exceedance = TRUE THEN 1 ELSE 0 END)
      comment: "Count of filter runs with turbidity MCL exceedances. Regulatory compliance KPI requiring immediate response."
    - name: "non_compliant_run_count"
      expr: SUM(CASE WHEN regulatory_compliance_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Count of filter runs that did not meet regulatory compliance requirements."
    - name: "filter_run_count"
      expr: COUNT(1)
      comment: "Total number of filter runs. Baseline for compliance rate and performance benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_mor_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monthly Operating Report (MOR) submission compliance and water quality KPIs. Used by compliance officers and plant managers to track regulatory reporting timeliness, MCL exceedances, and treatment performance trends."
  source: "`vibe_water_utilities_v1`.`treatment`.`mor_submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Status of the MOR submission (e.g., submitted, accepted, rejected, pending)."
    - name: "reporting_month"
      expr: reporting_month
      comment: "Reporting month for temporal trend analysis of treatment performance."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year for annual compliance trend analysis."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of treatment facility (e.g., surface water, groundwater, GWUDI) for facility-class benchmarking."
    - name: "is_late_submission_flag"
      expr: is_late_submission
      comment: "Indicates whether the MOR was submitted after the regulatory due date."
    - name: "has_mcl_exceedance_flag"
      expr: has_mcl_exceedance
      comment: "Indicates whether the reporting period had an MCL exceedance."
    - name: "turbidity_compliance_met_flag"
      expr: turbidity_compliance_met
      comment: "Indicates whether turbidity compliance was met for the reporting period."
    - name: "ct_compliance_met_flag"
      expr: ct_compliance_met
      comment: "Indicates whether CT compliance was met for the reporting period."
    - name: "submission_method"
      expr: submission_method
      comment: "Method of MOR submission (e.g., electronic, paper, portal) for process improvement analysis."
  measures:
    - name: "total_production_volume_mg"
      expr: SUM(CAST(total_production_volume_mg AS DOUBLE))
      comment: "Total water production volume in million gallons reported in MOR submissions. Regulatory production reporting KPI."
    - name: "avg_daily_flow_mgd"
      expr: AVG(CAST(avg_daily_flow_mgd AS DOUBLE))
      comment: "Average daily flow in million gallons per day across reporting periods. Tracks production trends and capacity utilization."
    - name: "max_daily_flow_mgd"
      expr: MAX(max_daily_flow_mgd)
      comment: "Maximum daily flow recorded in million gallons per day. Used for peak demand and capacity planning."
    - name: "avg_chlorine_residual_mg_l"
      expr: AVG(CAST(chlorine_residual_avg_mg_l AS DOUBLE))
      comment: "Average chlorine residual in mg/L across MOR reporting periods. Tracks disinfection compliance trend."
    - name: "avg_turbidity_ntu"
      expr: AVG(CAST(avg_turbidity_ntu AS DOUBLE))
      comment: "Average turbidity in NTU across MOR reporting periods. Regulatory compliance trend indicator."
    - name: "avg_ct_compliance_pct"
      expr: AVG(CAST(ct_compliance_pct AS DOUBLE))
      comment: "Average percentage of CT compliance achieved across reporting periods. Tracks disinfection compliance rate."
    - name: "avg_turbidity_compliance_pct"
      expr: AVG(CAST(turbidity_compliance_pct AS DOUBLE))
      comment: "Average percentage of turbidity compliance achieved. Regulatory performance KPI for SWTR compliance."
    - name: "late_submission_count"
      expr: SUM(CASE WHEN is_late_submission = TRUE THEN 1 ELSE 0 END)
      comment: "Count of MOR submissions filed after the regulatory due date. Tracks reporting compliance and regulatory relationship risk."
    - name: "mcl_exceedance_period_count"
      expr: SUM(CASE WHEN has_mcl_exceedance = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reporting periods with MCL exceedances. Primary regulatory compliance risk KPI."
    - name: "rejected_submission_count"
      expr: SUM(CASE WHEN submission_status = 'rejected' THEN 1 ELSE 0 END)
      comment: "Count of MOR submissions rejected by the regulatory agency. Tracks data quality and reporting accuracy issues."
    - name: "mor_submission_count"
      expr: COUNT(1)
      comment: "Total number of MOR submissions. Baseline for compliance rate calculations."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_chemical_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chemical inventory management KPIs for treatment operations. Used by plant managers and procurement to ensure adequate chemical supply, manage costs, and maintain regulatory compliance for chemical storage."
  source: "`vibe_water_utilities_v1`.`treatment`.`chemical_inventory`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current inventory status (e.g., adequate, low, critical, overstocked) for supply risk management."
    - name: "dosing_point"
      expr: dosing_point
      comment: "Point in the treatment process where the chemical is applied, for process-level inventory analysis."
    - name: "hazmat_class"
      expr: hazmat_class
      comment: "Hazardous materials classification for safety compliance and EPCRA/RMP reporting."
    - name: "is_rmp_regulated_flag"
      expr: is_rmp_regulated
      comment: "Indicates whether the chemical is regulated under EPA Risk Management Program."
    - name: "is_epcra_reportable_flag"
      expr: is_epcra_reportable
      comment: "Indicates whether the chemical requires EPCRA Tier II reporting."
    - name: "storage_container_type"
      expr: storage_container_type
      comment: "Type of storage container (e.g., cylinder, tote, bulk tank) for safety and logistics planning."
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total chemical quantity currently on hand across all inventory records. Primary supply availability KPI."
    - name: "avg_days_of_supply"
      expr: AVG(CAST(days_of_supply AS DOUBLE))
      comment: "Average days of chemical supply remaining. Critical operational KPI — values below safety threshold trigger emergency procurement."
    - name: "min_days_of_supply"
      expr: MIN(days_of_supply)
      comment: "Minimum days of supply across all chemical inventory records. Identifies most critical supply risk."
    - name: "total_inventory_value_usd"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE) * CAST(unit_cost AS DOUBLE))
      comment: "Total estimated value of chemical inventory in USD (quantity × unit cost). Financial asset tracking KPI."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of chemicals in inventory. Tracks procurement pricing trends."
    - name: "avg_average_daily_usage"
      expr: AVG(CAST(average_daily_usage AS DOUBLE))
      comment: "Average daily chemical usage rate. Used for demand forecasting and reorder point optimization."
    - name: "below_reorder_point_count"
      expr: SUM(CASE WHEN quantity_on_hand < reorder_point THEN 1 ELSE 0 END)
      comment: "Count of chemical inventory records where quantity on hand is below the reorder point. Triggers procurement action."
    - name: "inventory_record_count"
      expr: COUNT(1)
      comment: "Total number of chemical inventory records. Baseline for inventory coverage analysis."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_uv_disinfection_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "UV disinfection performance and compliance KPIs. Used by plant managers and compliance officers to track UV dose delivery, lamp performance, and LT2ESWTR compliance for Cryptosporidium inactivation."
  source: "`vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event`"
  dimensions:
    - name: "event_status"
      expr: event_status
      comment: "Status of the UV disinfection event (e.g., normal, alarm, shutdown)."
    - name: "event_type"
      expr: event_type
      comment: "Type of UV event (e.g., normal operation, lamp failure, maintenance bypass)."
    - name: "dose_compliance_flag"
      expr: dose_compliance_flag
      comment: "Indicates whether the required UV dose was delivered for regulatory compliance."
    - name: "lamp_status"
      expr: lamp_status
      comment: "Status of UV lamps (e.g., operational, degraded, failed) for maintenance planning."
    - name: "target_pathogen"
      expr: target_pathogen
      comment: "Target pathogen for UV inactivation (e.g., Cryptosporidium, Giardia, virus)."
    - name: "mor_included_flag"
      expr: mor_included_flag
      comment: "Indicates whether this event is included in MOR regulatory reporting."
    - name: "event_date"
      expr: DATE(event_timestamp)
      comment: "Date of the UV disinfection event for daily trend analysis."
  measures:
    - name: "avg_uv_dose_delivered_mj_cm2"
      expr: AVG(CAST(uv_dose_delivered_mj_cm2 AS DOUBLE))
      comment: "Average UV dose delivered in mJ/cm². Core LT2ESWTR compliance KPI — must meet minimum dose for log inactivation credit."
    - name: "min_uv_dose_delivered_mj_cm2"
      expr: MIN(uv_dose_delivered_mj_cm2)
      comment: "Minimum UV dose delivered in mJ/cm². Identifies worst-case compliance events requiring investigation."
    - name: "avg_uv_dose_required_mj_cm2"
      expr: AVG(CAST(uv_dose_required_mj_cm2 AS DOUBLE))
      comment: "Average required UV dose in mJ/cm². Baseline for compliance gap analysis."
    - name: "avg_uv_transmittance_pct"
      expr: AVG(CAST(uv_transmittance_pct AS DOUBLE))
      comment: "Average UV transmittance percentage. Lower UVT reduces effective dose delivery and increases energy consumption."
    - name: "avg_uv_intensity_mw_cm2"
      expr: AVG(CAST(uv_intensity_mw_cm2 AS DOUBLE))
      comment: "Average UV intensity in mW/cm². Tracks lamp degradation over time and informs replacement scheduling."
    - name: "avg_lamp_power_pct"
      expr: AVG(CAST(lamp_power_pct AS DOUBLE))
      comment: "Average lamp power output as percentage of rated capacity. Tracks lamp aging and efficiency."
    - name: "avg_sleeve_fouling_factor"
      expr: AVG(CAST(sleeve_fouling_factor AS DOUBLE))
      comment: "Average sleeve fouling factor. Higher fouling reduces UV transmittance and dose delivery, triggering cleaning."
    - name: "avg_log_inactivation_target"
      expr: AVG(CAST(log_inactivation_target AS DOUBLE))
      comment: "Average log inactivation target for the UV system. Regulatory benchmark for LT2ESWTR compliance."
    - name: "dose_non_compliant_event_count"
      expr: SUM(CASE WHEN dose_compliance_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Count of UV events where required dose was not delivered. Regulatory compliance failure count requiring corrective action."
    - name: "uv_event_count"
      expr: COUNT(1)
      comment: "Total number of UV disinfection events. Baseline for compliance rate calculations."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_sludge_production`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sludge/biosolids production, disposal cost, and regulatory compliance KPIs. Used by plant managers and environmental compliance officers to manage biosolids program costs, disposal logistics, and Part 503 compliance."
  source: "`vibe_water_utilities_v1`.`treatment`.`sludge_production`"
  dimensions:
    - name: "production_status"
      expr: production_status
      comment: "Status of the sludge production record (e.g., completed, pending, rejected)."
    - name: "sludge_type"
      expr: sludge_type
      comment: "Type of sludge produced (e.g., primary, secondary, mixed, biosolids) for process-level analysis."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method of sludge disposal (e.g., land application, landfill, incineration) for cost and compliance analysis."
    - name: "dewatering_method"
      expr: dewatering_method
      comment: "Dewatering method used (e.g., centrifuge, belt press, drying beds) for process efficiency benchmarking."
    - name: "biosolids_class"
      expr: biosolids_class
      comment: "Biosolids classification (Class A or Class B) per 40 CFR Part 503 for regulatory compliance tracking."
    - name: "is_biosolids_reportable_flag"
      expr: is_biosolids_reportable
      comment: "Indicates whether this production record requires regulatory biosolids reporting."
    - name: "metals_compliance_flag"
      expr: metals_compliance
      comment: "Indicates whether metals concentrations meet Part 503 pollutant limits."
    - name: "production_date"
      expr: production_date
      comment: "Date of sludge production for temporal trend analysis."
  measures:
    - name: "total_dry_weight_tons"
      expr: SUM(CAST(dry_weight_tons AS DOUBLE))
      comment: "Total sludge dry weight in tons. Primary biosolids production volume KPI for regulatory reporting and disposal planning."
    - name: "total_volume_gallons"
      expr: SUM(CAST(volume_gallons AS DOUBLE))
      comment: "Total sludge volume in gallons. Tracks liquid sludge generation for hauling and storage capacity planning."
    - name: "total_disposal_cost_usd"
      expr: SUM(CAST(disposal_cost_usd AS DOUBLE))
      comment: "Total sludge disposal cost in USD. Key operational cost KPI for biosolids program budget management."
    - name: "avg_disposal_cost_usd"
      expr: AVG(CAST(disposal_cost_usd AS DOUBLE))
      comment: "Average disposal cost per sludge production event in USD. Benchmarks disposal efficiency across methods and vendors."
    - name: "avg_cake_solids_pct"
      expr: AVG(CAST(cake_solids_pct AS DOUBLE))
      comment: "Average dewatered cake solids percentage. Higher solids content reduces disposal volume and cost."
    - name: "avg_volatile_solids_pct"
      expr: AVG(CAST(volatile_solids_pct AS DOUBLE))
      comment: "Average volatile solids percentage. Indicator of organic content and vector attraction reduction compliance."
    - name: "avg_total_solids_pct"
      expr: AVG(CAST(total_solids_pct AS DOUBLE))
      comment: "Average total solids percentage in dewatered sludge. Operational efficiency metric for dewatering performance."
    - name: "metals_non_compliant_count"
      expr: SUM(CASE WHEN metals_compliance = FALSE THEN 1 ELSE 0 END)
      comment: "Count of sludge production records with metals non-compliance. Regulatory risk KPI under 40 CFR Part 503."
    - name: "sludge_production_record_count"
      expr: COUNT(1)
      comment: "Total number of sludge production records. Baseline for production rate and compliance rate calculations."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_membrane_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Membrane filtration performance and integrity KPIs. Used by plant engineers and managers to track flux decline, salt rejection, energy efficiency, and integrity test compliance for membrane treatment systems."
  source: "`vibe_water_utilities_v1`.`treatment`.`membrane_performance`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the membrane unit (e.g., online, offline, maintenance)."
    - name: "membrane_technology_type"
      expr: membrane_technology_type
      comment: "Type of membrane technology (e.g., MF, UF, NF, RO) for technology-level performance benchmarking."
    - name: "membrane_configuration"
      expr: membrane_configuration
      comment: "Membrane module configuration (e.g., hollow fiber, spiral wound) for design-level analysis."
    - name: "integrity_test_result"
      expr: integrity_test_result
      comment: "Result of the most recent integrity test (e.g., pass, fail, inconclusive). Regulatory compliance indicator."
    - name: "replacement_recommended_flag"
      expr: replacement_recommended
      comment: "Indicates whether membrane replacement has been recommended based on performance degradation."
    - name: "mor_reportable_flag"
      expr: mor_reportable
      comment: "Indicates whether this performance record is included in MOR regulatory reporting."
    - name: "observation_date"
      expr: DATE(observation_timestamp)
      comment: "Date of membrane performance observation for trend analysis."
  measures:
    - name: "avg_recovery_rate_pct"
      expr: AVG(CAST(recovery_rate_pct AS DOUBLE))
      comment: "Average membrane system recovery rate percentage (permeate/feed). Higher recovery reduces water waste and operating cost."
    - name: "avg_salt_rejection_rate_pct"
      expr: AVG(CAST(salt_rejection_rate_pct AS DOUBLE))
      comment: "Average salt rejection rate percentage. Primary RO/NF performance KPI — declining rejection indicates membrane fouling or damage."
    - name: "avg_flux_decline_pct"
      expr: AVG(CAST(flux_decline_pct AS DOUBLE))
      comment: "Average normalized flux decline percentage. Tracks membrane fouling progression and cleaning effectiveness."
    - name: "avg_normalized_permeate_flux"
      expr: AVG(CAST(normalized_permeate_flux AS DOUBLE))
      comment: "Average normalized permeate flux. Temperature-corrected flux for fair performance comparison across operating conditions."
    - name: "avg_transmembrane_pressure_psi"
      expr: AVG(CAST(transmembrane_pressure_psi AS DOUBLE))
      comment: "Average transmembrane pressure in PSI. Rising TMP indicates fouling and drives cleaning or replacement decisions."
    - name: "avg_specific_energy_consumption_kwh_m3"
      expr: AVG(CAST(specific_energy_consumption_kwh_m3 AS DOUBLE))
      comment: "Average specific energy consumption in kWh/m³. Key operational cost KPI for membrane system energy efficiency."
    - name: "avg_turbidity_removal_efficiency_pct"
      expr: AVG(CAST(turbidity_removal_efficiency_pct AS DOUBLE))
      comment: "Average turbidity removal efficiency percentage. Tracks membrane filtration effectiveness for regulatory compliance."
    - name: "avg_log_removal_value"
      expr: AVG(CAST(log_removal_value AS DOUBLE))
      comment: "Average log removal value (LRV) achieved. Regulatory credit for pathogen removal under LT2ESWTR."
    - name: "integrity_test_failure_count"
      expr: SUM(CASE WHEN integrity_test_result = 'fail' THEN 1 ELSE 0 END)
      comment: "Count of failed integrity tests. Regulatory compliance KPI — failures require immediate investigation and corrective action."
    - name: "replacement_recommended_count"
      expr: SUM(CASE WHEN replacement_recommended = TRUE THEN 1 ELSE 0 END)
      comment: "Count of membrane units recommended for replacement. Drives capital planning and procurement decisions."
    - name: "membrane_performance_record_count"
      expr: COUNT(1)
      comment: "Total number of membrane performance records. Baseline for trend and compliance rate calculations."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_source_water_intake`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Source water intake quality and volume KPIs. Used by plant managers and water resource planners to monitor raw water quality trends, permit compliance, and intake operations for treatment optimization."
  source: "`vibe_water_utilities_v1`.`treatment`.`source_water_intake`"
  dimensions:
    - name: "intake_status"
      expr: intake_status
      comment: "Operational status of the intake event (e.g., active, suspended, emergency)."
    - name: "source_type"
      expr: source_type
      comment: "Type of source water (e.g., river, reservoir, groundwater, lake) for source-level quality analysis."
    - name: "intake_method"
      expr: intake_method
      comment: "Method of water intake (e.g., gravity, pumped) for operational analysis."
    - name: "permit_compliance_status"
      expr: permit_compliance_status
      comment: "Compliance status with intake permit conditions (e.g., compliant, non-compliant, waiver)."
    - name: "source_water_alert_active_flag"
      expr: source_water_alert_active
      comment: "Indicates whether a source water quality alert is active, triggering enhanced treatment protocols."
    - name: "source_water_protection_zone"
      expr: source_water_protection_zone
      comment: "Source water protection zone classification for watershed management analysis."
    - name: "intake_date"
      expr: DATE(intake_timestamp)
      comment: "Date of the intake event for daily and seasonal trend analysis."
  measures:
    - name: "total_volume_withdrawn_mg"
      expr: SUM(CAST(volume_withdrawn_mg AS DOUBLE))
      comment: "Total source water withdrawn in million gallons. Tracks water rights utilization and permit compliance."
    - name: "avg_turbidity_ntu"
      expr: AVG(CAST(turbidity_ntu AS DOUBLE))
      comment: "Average raw water turbidity in NTU. Drives treatment chemical demand and filter run performance."
    - name: "max_turbidity_ntu"
      expr: MAX(turbidity_ntu)
      comment: "Maximum raw water turbidity observed in NTU. Identifies high-turbidity events requiring enhanced treatment."
    - name: "avg_toc_mg_per_l"
      expr: AVG(CAST(toc_mg_per_l AS DOUBLE))
      comment: "Average total organic carbon in mg/L. Drives DBP precursor management and enhanced coagulation requirements."
    - name: "avg_temperature_c"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average source water temperature in °C. Affects CT requirements, chemical dosing, and biological activity."
    - name: "avg_ph_level"
      expr: AVG(CAST(ph_level AS DOUBLE))
      comment: "Average source water pH. Affects coagulation efficiency and disinfection byproduct formation."
    - name: "avg_flow_rate_gpm"
      expr: AVG(CAST(flow_rate_gpm AS DOUBLE))
      comment: "Average intake flow rate in gallons per minute. Tracks intake capacity utilization."
    - name: "source_water_alert_event_count"
      expr: SUM(CASE WHEN source_water_alert_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of intake events with active source water quality alerts. Tracks raw water quality risk events."
    - name: "intake_event_count"
      expr: COUNT(1)
      comment: "Total number of source water intake events. Baseline for operational frequency analysis."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`treatment_process_compliance_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process-level permit compliance monitoring KPIs. Used by compliance officers to track exceedance frequency, compliance status, and monitoring obligations across treatment process units."
  source: "`vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status for the process unit monitoring obligation (e.g., compliant, non-compliant, pending)."
    - name: "monitoring_frequency"
      expr: monitoring_frequency
      comment: "Required monitoring frequency (e.g., daily, weekly, monthly) for scheduling and audit purposes."
    - name: "effective_date"
      expr: effective_date
      comment: "Date the monitoring obligation became effective for temporal compliance tracking."
  measures:
    - name: "total_exceedance_count"
      expr: SUM(CAST(exceedance_count AS DOUBLE))
      comment: "Total number of permit condition exceedances across all monitored process units. Primary regulatory risk KPI."
    - name: "avg_exceedance_count"
      expr: AVG(CAST(exceedance_count AS DOUBLE))
      comment: "Average exceedance count per process monitoring obligation. Identifies chronically non-compliant process units."
    - name: "non_compliant_obligation_count"
      expr: SUM(CASE WHEN compliance_status = 'non-compliant' THEN 1 ELSE 0 END)
      comment: "Count of process monitoring obligations currently in non-compliant status. Drives corrective action prioritization."
    - name: "monitoring_obligation_count"
      expr: COUNT(1)
      comment: "Total number of active process compliance monitoring obligations. Tracks regulatory monitoring burden."
$$;