-- Metric views for domain: distribution | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-10 19:05:00

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_nrw_water_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Non-Revenue Water (NRW) audit metrics tracking water losses, apparent losses, real losses, and infrastructure leakage index across district metered areas. Core KPI set for executive water-loss reduction programs and regulatory reporting."
  source: "`vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area identifier — primary grouping for NRW analysis by zone."
    - name: "audit_period_type"
      expr: audit_period_type
      comment: "Type of audit period (annual, quarterly, monthly) — enables trend analysis at different temporal granularities."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the NRW audit (draft, approved, submitted) — filters to approved audits for reporting."
    - name: "audit_period_start_date"
      expr: DATE_TRUNC('month', audit_period_start_date)
      comment: "Audit period start month — enables time-series trending of NRW performance."
    - name: "audit_period_year"
      expr: YEAR(audit_period_start_date)
      comment: "Audit period year — supports annual NRW benchmarking and year-over-year comparison."
    - name: "data_grading"
      expr: data_grading
      comment: "IWA data validity grading (A, B, C, D) — indicates confidence level of the audit figures."
    - name: "audit_methodology"
      expr: audit_methodology
      comment: "Methodology used for the NRW audit (IWA Water Balance, AWWA, etc.) — ensures comparability across periods."
  measures:
    - name: "total_nrw_volume_mg"
      expr: SUM(CAST(nrw_volume_mg AS DOUBLE))
      comment: "Total Non-Revenue Water volume in million gallons. Primary executive KPI for water loss programs — directly tied to revenue recovery and operational cost."
    - name: "avg_nrw_percentage"
      expr: AVG(CAST(nrw_percentage AS DOUBLE))
      comment: "Average NRW percentage across audited DMAs. Benchmark KPI: utilities target <15% NRW; values above trigger capital investment decisions."
    - name: "total_real_losses_mg"
      expr: SUM(CAST(real_losses_mg AS DOUBLE))
      comment: "Total real (physical) losses in million gallons — leakage from mains, service connections, and storage. Drives pipe rehabilitation and leak detection investment."
    - name: "total_apparent_losses_mg"
      expr: SUM(CAST(apparent_losses_mg AS DOUBLE))
      comment: "Total apparent (commercial) losses in million gallons — meter inaccuracies, data errors, unauthorized consumption. Drives meter replacement and billing accuracy programs."
    - name: "total_system_input_volume_mg"
      expr: SUM(CAST(system_input_volume_mg AS DOUBLE))
      comment: "Total water input to the distribution system in million gallons. Denominator for NRW percentage calculations and system-wide water balance."
    - name: "total_authorized_consumption_mg"
      expr: SUM(CAST(authorized_consumption_mg AS DOUBLE))
      comment: "Total authorized consumption (billed + unbilled) in million gallons. Measures revenue-generating and sanctioned non-revenue use."
    - name: "total_water_losses_mg"
      expr: SUM(CAST(water_losses_mg AS DOUBLE))
      comment: "Total water losses (real + apparent) in million gallons. Combined loss figure used in regulatory submissions and board reporting."
    - name: "avg_infrastructure_leakage_index"
      expr: AVG(CAST(infrastructure_leakage_index AS DOUBLE))
      comment: "Average Infrastructure Leakage Index (ILI) — IWA standard ratio of current annual real losses to unavoidable annual real losses. ILI > 1 indicates excess leakage; drives capital prioritization."
    - name: "total_unavoidable_annual_real_losses_mg"
      expr: SUM(CAST(unavoidable_annual_real_losses_mg AS DOUBLE))
      comment: "Total technically unavoidable annual real losses in million gallons. Baseline for ILI calculation and realistic loss-reduction target setting."
    - name: "total_leakage_on_transmission_mains_mg"
      expr: SUM(CAST(leakage_on_transmission_mains_mg AS DOUBLE))
      comment: "Leakage volume on transmission mains in million gallons. Identifies highest-impact pipe segments for targeted rehabilitation investment."
    - name: "total_leakage_on_service_connections_mg"
      expr: SUM(CAST(leakage_on_service_connections_mg AS DOUBLE))
      comment: "Leakage volume on service connections in million gallons. Informs lead service line replacement and service connection renewal programs."
    - name: "total_unauthorized_consumption_mg"
      expr: SUM(CAST(unauthorized_consumption_mg AS DOUBLE))
      comment: "Total unauthorized consumption (theft, illegal connections) in million gallons. Revenue protection KPI — triggers enforcement and meter audit programs."
    - name: "avg_ufw_percentage"
      expr: AVG(CAST(ufw_percentage AS DOUBLE))
      comment: "Average Unaccounted-For Water (UFW) percentage. Regulatory reporting metric used in state annual reports and rate case filings."
    - name: "total_billed_metered_consumption_mg"
      expr: SUM(CAST(billed_metered_consumption_mg AS DOUBLE))
      comment: "Total billed metered consumption in million gallons. Revenue-linked volume — primary input to revenue forecasting and rate design."
    - name: "audit_count"
      expr: COUNT(1)
      comment: "Number of NRW audit records. Tracks audit program completeness and frequency across DMAs."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_main_break`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution main break event metrics tracking break frequency, repair performance, water loss, and operational impact. Critical KPIs for infrastructure reliability, capital planning, and regulatory compliance."
  source: "`vibe_water_utilities_v1`.`distribution`.`main_break`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area — enables break frequency analysis by zone for targeted rehabilitation planning."
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone — correlates break events with hydraulic conditions for root cause analysis."
    - name: "break_type"
      expr: break_type
      comment: "Type of main break (circumferential, longitudinal, joint failure, etc.) — informs material and installation failure mode analysis."
    - name: "pipe_material"
      expr: pipe_material
      comment: "Pipe material at break location — critical dimension for asset renewal prioritization by material class."
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause of break (corrosion, pressure surge, third-party damage, etc.) — drives preventive maintenance and capital investment decisions."
    - name: "break_month"
      expr: DATE_TRUNC('month', break_timestamp)
      comment: "Month of break event — enables seasonal trend analysis and break rate trending."
    - name: "break_year"
      expr: YEAR(break_timestamp)
      comment: "Year of break event — supports annual break rate benchmarking and year-over-year comparison."
    - name: "priority_level"
      expr: priority_level
      comment: "Response priority level — segments breaks by urgency for resource allocation analysis."
    - name: "boil_water_advisory_issued"
      expr: boil_water_advisory_issued
      comment: "Whether a boil water advisory was issued — flags high-impact events with public health consequences."
  measures:
    - name: "total_main_breaks"
      expr: COUNT(1)
      comment: "Total number of main break events. Primary infrastructure reliability KPI — industry benchmark is breaks per 100 miles of main per year."
    - name: "total_water_lost_gallons"
      expr: SUM(CAST(water_lost_gallons AS DOUBLE))
      comment: "Total water lost due to main breaks in gallons. Direct revenue loss and NRW contribution — key input to water loss reduction ROI calculations."
    - name: "avg_repair_duration_hours"
      expr: AVG(CAST(repair_duration_hours AS DOUBLE))
      comment: "Average repair duration in hours. Operational efficiency KPI — longer durations indicate crew capacity or parts availability issues."
    - name: "total_repair_duration_hours"
      expr: SUM(CAST(repair_duration_hours AS DOUBLE))
      comment: "Total crew hours spent on main break repairs. Workforce cost driver — used in cost-per-break analysis and budget forecasting."
    - name: "avg_operating_pressure_psi"
      expr: AVG(CAST(operating_pressure_psi AS DOUBLE))
      comment: "Average operating pressure at break locations in PSI. Hydraulic risk indicator — high pressure correlates with break frequency and informs pressure management strategy."
    - name: "avg_pipe_diameter_inches"
      expr: AVG(CAST(pipe_diameter_inches AS DOUBLE))
      comment: "Average pipe diameter at break locations in inches. Asset profile metric — identifies which pipe size classes are most failure-prone."
    - name: "boil_water_advisory_count"
      expr: SUM(CASE WHEN boil_water_advisory_issued = TRUE THEN 1 ELSE 0 END)
      comment: "Number of breaks that triggered boil water advisories. Public health risk KPI — high values indicate systemic pressure management or contamination vulnerability."
    - name: "regulatory_report_required_count"
      expr: SUM(CASE WHEN regulatory_report_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of breaks requiring regulatory reporting. Compliance exposure metric — tracks reportable events for state primacy agency submissions."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_pressure_zone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pressure zone performance metrics covering hydraulic capacity, NRW/UFW rates, demand, and storage adequacy. Strategic KPIs for system reliability, regulatory compliance, and capital planning."
  source: "`vibe_water_utilities_v1`.`distribution`.`pressure_zone`"
  dimensions:
    - name: "zone_type"
      expr: zone_type
      comment: "Type of pressure zone (booster, gravity, transmission) — enables performance comparison across hydraulic zone categories."
    - name: "zone_code"
      expr: zone_code
      comment: "Unique pressure zone code — primary identifier for zone-level operational dashboards."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the pressure zone (active, inactive, decommissioned) — filters to active zones for performance reporting."
    - name: "commissioning_year"
      expr: YEAR(commissioning_date)
      comment: "Year the pressure zone was commissioned — enables age-based infrastructure risk segmentation."
  measures:
    - name: "total_zones"
      expr: COUNT(1)
      comment: "Total number of pressure zones. System inventory baseline for capacity planning and regulatory reporting."
    - name: "avg_nrw_percentage"
      expr: AVG(CAST(nrw_percentage AS DOUBLE))
      comment: "Average NRW percentage across pressure zones. Zone-level water loss KPI — identifies highest-loss zones for targeted intervention."
    - name: "avg_ufw_percentage"
      expr: AVG(CAST(ufw_percentage AS DOUBLE))
      comment: "Average UFW percentage across pressure zones. Regulatory reporting metric used in annual water audit submissions."
    - name: "total_storage_capacity_mg"
      expr: SUM(CAST(storage_capacity_mg AS DOUBLE))
      comment: "Total storage capacity in million gallons across all pressure zones. System resilience KPI — ensures adequate emergency and fire flow reserves."
    - name: "total_average_daily_demand_mgd"
      expr: SUM(CAST(average_daily_demand_mgd AS DOUBLE))
      comment: "Total average daily demand in million gallons per day across all zones. Capacity planning input — compared against treatment and transmission capacity."
    - name: "total_peak_hour_demand_mgd"
      expr: SUM(CAST(peak_hour_demand_mgd AS DOUBLE))
      comment: "Total peak hour demand in million gallons per day. Critical sizing metric for pump stations, storage, and transmission mains."
    - name: "avg_design_pressure_psi"
      expr: AVG(CAST(design_pressure_psi AS DOUBLE))
      comment: "Average design pressure in PSI across zones. Hydraulic adequacy indicator — zones below minimum service pressure trigger capital investment."
    - name: "avg_residual_pressure_fire_psi"
      expr: AVG(CAST(residual_pressure_fire_psi AS DOUBLE))
      comment: "Average residual pressure during fire flow conditions in PSI. Fire protection compliance KPI — must meet ISO/NFPA minimum thresholds."
    - name: "total_service_area_sq_mi"
      expr: SUM(CAST(service_area_sq_mi AS DOUBLE))
      comment: "Total service area in square miles across all pressure zones. System footprint metric used in per-capita and per-mile infrastructure cost analysis."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_leak_detection_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leak detection survey program metrics tracking survey coverage, leak discovery rates, estimated loss volumes, and program effectiveness. Core KPIs for NRW reduction program management and capital prioritization."
  source: "`vibe_water_utilities_v1`.`distribution`.`leak_detection_survey`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area surveyed — enables leak detection effectiveness comparison across zones."
    - name: "survey_method"
      expr: survey_method
      comment: "Detection method used (acoustic, correlator, ground-penetrating radar, etc.) — informs technology effectiveness analysis."
    - name: "survey_status"
      expr: survey_status
      comment: "Current status of the survey (scheduled, in-progress, completed) — filters to completed surveys for outcome analysis."
    - name: "survey_priority"
      expr: survey_priority
      comment: "Priority level of the survey — enables analysis of whether high-priority zones receive timely coverage."
    - name: "survey_year"
      expr: YEAR(survey_date)
      comment: "Year of survey — supports annual program coverage tracking and year-over-year leak discovery trending."
    - name: "survey_outcome"
      expr: survey_outcome
      comment: "Outcome of the survey (leaks found, no leaks found, inconclusive) — primary effectiveness dimension."
    - name: "nrw_program_id"
      expr: nrw_program_id
      comment: "NRW program this survey belongs to — enables program-level ROI analysis across multiple surveys."
  measures:
    - name: "total_surveys"
      expr: COUNT(1)
      comment: "Total number of leak detection surveys conducted. Program activity KPI — tracks survey frequency against NRW program targets."
    - name: "total_survey_length_feet"
      expr: SUM(CAST(survey_length_feet AS DOUBLE))
      comment: "Total pipe length surveyed in feet. Coverage KPI — measures what percentage of the network has been inspected."
    - name: "total_estimated_leak_rate_gpm"
      expr: SUM(CAST(estimated_leak_rate_gpm AS DOUBLE))
      comment: "Total estimated leak rate in gallons per minute across all surveys. Water loss quantification KPI — directly informs NRW reduction potential and repair prioritization."
    - name: "avg_estimated_leak_rate_gpm"
      expr: AVG(CAST(estimated_leak_rate_gpm AS DOUBLE))
      comment: "Average estimated leak rate per survey in gallons per minute. Efficiency metric — higher averages indicate surveys are targeting the right high-loss zones."
    - name: "surveys_with_leaks_found"
      expr: SUM(CASE WHEN repair_work_order_generated = TRUE THEN 1 ELSE 0 END)
      comment: "Number of surveys that resulted in a repair work order being generated. Leak discovery rate numerator — measures program effectiveness at finding actionable leaks."
    - name: "repair_work_order_generation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN repair_work_order_generated = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of surveys that generated a repair work order. Program effectiveness KPI — low rates indicate surveys are not targeting high-probability leak zones."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_hydrant_flow_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fire hydrant flow test metrics tracking hydraulic performance, fire flow adequacy, and ISO compliance. Critical KPIs for fire protection certification, insurance rating, and regulatory compliance."
  source: "`vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of flow test (fire flow, acceptance, routine) — segments tests by purpose for targeted analysis."
    - name: "test_status"
      expr: test_status
      comment: "Status of the test (pass, fail, inconclusive) — primary compliance dimension for fire flow adequacy reporting."
    - name: "iso_fire_flow_adequacy"
      expr: iso_fire_flow_adequacy
      comment: "ISO fire flow adequacy classification — directly impacts community fire insurance ratings (ISO PPC score)."
    - name: "nfpa_color_classification"
      expr: nfpa_color_classification
      comment: "NFPA 291 color classification (blue, green, orange, red) indicating available fire flow — used by fire departments for suppression planning."
    - name: "test_year"
      expr: YEAR(test_date)
      comment: "Year of flow test — enables annual testing compliance tracking and trend analysis."
    - name: "pressure_zone_code"
      expr: pressure_zone_code
      comment: "Pressure zone where test was conducted — enables zone-level fire flow adequacy analysis."
  measures:
    - name: "total_flow_tests"
      expr: COUNT(1)
      comment: "Total number of hydrant flow tests conducted. Program completeness KPI — tracks testing frequency against regulatory and ISO requirements."
    - name: "avg_flow_rate_gpm"
      expr: AVG(CAST(flow_rate_gpm AS DOUBLE))
      comment: "Average measured flow rate in gallons per minute. Hydraulic performance KPI — compared against minimum fire flow requirements by land use type."
    - name: "avg_available_flow_at_20psi_gpm"
      expr: AVG(CAST(available_flow_at_20psi_gpm AS DOUBLE))
      comment: "Average available fire flow at 20 PSI residual in gallons per minute. ISO standard fire flow metric — directly used in PPC scoring and insurance rate determination."
    - name: "avg_static_pressure_psi"
      expr: AVG(CAST(static_pressure_psi AS DOUBLE))
      comment: "Average static pressure at test hydrants in PSI. Baseline hydraulic condition indicator — low static pressure signals system capacity constraints."
    - name: "avg_residual_pressure_psi"
      expr: AVG(CAST(residual_pressure_psi AS DOUBLE))
      comment: "Average residual pressure during flow test in PSI. Fire flow adequacy indicator — must remain above 20 PSI per NFPA 291 during fire flow conditions."
    - name: "iso_submission_count"
      expr: SUM(CASE WHEN iso_rating_submitted = TRUE THEN 1 ELSE 0 END)
      comment: "Number of tests submitted to ISO for rating purposes. Compliance tracking KPI — ensures fire flow data is reported to maintain community insurance ratings."
    - name: "hydraulic_model_updated_count"
      expr: SUM(CASE WHEN hydraulic_model_updated = TRUE THEN 1 ELSE 0 END)
      comment: "Number of tests that triggered a hydraulic model update. Model currency KPI — ensures the hydraulic model reflects current system conditions."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_pipe_condition_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pipe condition assessment metrics tracking structural integrity, defect rates, remaining useful life, and rehabilitation prioritization. Strategic KPIs for capital improvement planning and asset management."
  source: "`vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area — enables condition analysis by zone for targeted rehabilitation investment."
    - name: "assessment_method"
      expr: assessment_method
      comment: "Inspection method used (CCTV, acoustic, visual, etc.) — informs data quality and comparability across assessments."
    - name: "overall_condition_grade"
      expr: overall_condition_grade
      comment: "Overall pipe condition grade (1-5 or A-F scale) — primary asset health dimension for capital prioritization."
    - name: "structural_condition_grade"
      expr: structural_condition_grade
      comment: "Structural condition grade — identifies pipes at risk of failure requiring immediate rehabilitation."
    - name: "recommended_action"
      expr: recommended_action
      comment: "Recommended rehabilitation action (replace, reline, monitor, etc.) — drives CIP project scoping and budget allocation."
    - name: "recommended_action_priority"
      expr: recommended_action_priority
      comment: "Priority of recommended action (immediate, short-term, long-term) — enables urgency-based capital planning."
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of assessment — tracks program coverage over time and identifies gaps in inspection frequency."
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone — enables condition analysis by hydraulic zone for system-wide risk assessment."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of pipe condition assessments. Program coverage KPI — tracks inspection completeness against asset inventory."
    - name: "total_pipe_length_assessed_feet"
      expr: SUM(CAST(pipe_length_assessed_feet AS DOUBLE))
      comment: "Total pipe length assessed in feet. Coverage metric — measures what percentage of the network has been condition-assessed for CIP planning."
    - name: "avg_pipe_length_assessed_feet"
      expr: AVG(CAST(pipe_length_assessed_feet AS DOUBLE))
      comment: "Average pipe length per assessment in feet. Operational efficiency metric — informs crew productivity and assessment cost-per-foot calculations."
    - name: "poor_condition_pipe_count"
      expr: SUM(CASE WHEN overall_condition_grade IN ('4', '5', 'D', 'F') THEN 1 ELSE 0 END)
      comment: "Number of pipe segments assessed as poor or critical condition. Capital urgency KPI — directly drives CIP project prioritization and budget requests."
    - name: "data_quality_flagged_count"
      expr: SUM(CASE WHEN data_quality_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of assessments flagged for data quality issues. Data integrity KPI — high rates indicate equipment calibration or technician training issues."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_nrw_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NRW program portfolio metrics tracking program performance, NRW reduction achievements, budget utilization, and target attainment. Strategic KPIs for water loss program management and investment justification."
  source: "`vibe_water_utilities_v1`.`distribution`.`nrw_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current program status (active, completed, suspended) — filters to active programs for performance monitoring."
    - name: "program_type"
      expr: program_type
      comment: "Type of NRW program (leak detection, pressure management, meter replacement, etc.) — enables ROI comparison across intervention types."
    - name: "priority_level"
      expr: priority_level
      comment: "Program priority level — ensures high-priority programs receive adequate resource allocation."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the program — informs executive risk management decisions."
    - name: "territory_id"
      expr: territory_id
      comment: "Service territory — enables NRW program performance comparison across geographic service areas."
    - name: "finance_budget_id"
      expr: finance_budget_id
      comment: "Finance budget linked to this NRW program — enables budget vs. actual analysis at the program level."
    - name: "program_start_year"
      expr: YEAR(start_date)
      comment: "Year the program started — enables cohort analysis of program effectiveness by vintage."
  measures:
    - name: "total_programs"
      expr: COUNT(1)
      comment: "Total number of NRW programs in the portfolio. Program inventory KPI — tracks breadth of water loss reduction initiatives."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated across all NRW programs. Investment portfolio KPI — used in rate case filings to justify water loss reduction expenditures."
    - name: "avg_budget_amount"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per NRW program. Benchmarking metric — identifies under- or over-funded programs relative to scope."
    - name: "total_actual_nrw_reduction_volume_mgd"
      expr: SUM(CAST(actual_nrw_reduction_volume_mgd AS DOUBLE))
      comment: "Total actual NRW volume reduction achieved in million gallons per day. Outcome KPI — measures real-world impact of NRW investment portfolio."
    - name: "total_target_nrw_reduction_volume_mgd"
      expr: SUM(CAST(target_nrw_reduction_volume_mgd AS DOUBLE))
      comment: "Total targeted NRW volume reduction in million gallons per day. Target baseline for program performance gap analysis."
    - name: "avg_actual_nrw_reduction_percent"
      expr: AVG(CAST(actual_nrw_reduction_percent AS DOUBLE))
      comment: "Average actual NRW reduction percentage achieved across programs. Effectiveness KPI — compared against targets to assess program ROI."
    - name: "avg_target_nrw_reduction_percent"
      expr: AVG(CAST(target_nrw_reduction_percent AS DOUBLE))
      comment: "Average targeted NRW reduction percentage across programs. Target baseline for performance gap analysis and program re-scoping decisions."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_hydraulic_model_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hydraulic model run metrics tracking simulation performance, system demand, pressure compliance, and model calibration status. KPIs for engineering decision support, CIP planning, and regulatory submissions."
  source: "`vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run`"
  dimensions:
    - name: "scenario_type"
      expr: scenario_type
      comment: "Simulation scenario type (peak demand, fire flow, emergency, master plan) — segments runs by planning purpose."
    - name: "run_status"
      expr: run_status
      comment: "Status of the model run (completed, failed, in-progress) — filters to completed runs for analysis."
    - name: "calibration_status"
      expr: calibration_status
      comment: "Model calibration status — only calibrated models should inform capital investment decisions."
    - name: "run_purpose"
      expr: run_purpose
      comment: "Business purpose of the run (CIP evaluation, regulatory submission, master plan, etc.) — enables purpose-specific performance analysis."
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone modeled — enables zone-level hydraulic performance comparison."
    - name: "run_year"
      expr: YEAR(run_start_timestamp)
      comment: "Year of model run — tracks modeling activity and model currency over time."
    - name: "convergence_achieved"
      expr: convergence_achieved
      comment: "Whether the simulation achieved hydraulic convergence — non-converged runs are unreliable for decision-making."
  measures:
    - name: "total_model_runs"
      expr: COUNT(1)
      comment: "Total number of hydraulic model runs. Engineering activity KPI — tracks modeling program intensity and model maintenance frequency."
    - name: "avg_system_demand_mgd"
      expr: AVG(CAST(system_demand_mgd AS DOUBLE))
      comment: "Average simulated system demand in million gallons per day. Capacity planning KPI — compared against treatment and transmission capacity for adequacy assessment."
    - name: "avg_minimum_pressure_psi"
      expr: AVG(CAST(minimum_pressure_psi AS DOUBLE))
      comment: "Average minimum system pressure across model runs in PSI. Regulatory compliance KPI — must remain above 20 PSI (EPA/state minimum service pressure)."
    - name: "avg_maximum_pressure_psi"
      expr: AVG(CAST(maximum_pressure_psi AS DOUBLE))
      comment: "Average maximum system pressure across model runs in PSI. Infrastructure protection KPI — excessive pressure accelerates pipe breaks and increases NRW."
    - name: "avg_fire_flow_available_gpm"
      expr: AVG(CAST(fire_flow_available_gpm AS DOUBLE))
      comment: "Average available fire flow in gallons per minute from model simulations. Fire protection planning KPI — validates system capacity against ISO and NFPA requirements."
    - name: "total_pump_energy_kwh"
      expr: SUM(CAST(pump_energy_kwh AS DOUBLE))
      comment: "Total pump energy consumption modeled in kWh. Energy efficiency KPI — used to evaluate pump scheduling optimization and energy cost reduction opportunities."
    - name: "avg_pump_energy_kwh"
      expr: AVG(CAST(pump_energy_kwh AS DOUBLE))
      comment: "Average pump energy per model run in kWh. Baseline for energy optimization scenario comparison."
    - name: "converged_run_count"
      expr: SUM(CASE WHEN convergence_achieved = TRUE THEN 1 ELSE 0 END)
      comment: "Number of model runs that achieved hydraulic convergence. Model quality KPI — non-converged runs cannot be used for regulatory submissions or capital decisions."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_valve_exercise`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Valve exercising program metrics tracking operability rates, deficiency detection, and maintenance compliance. Critical KPIs for emergency response readiness and distribution system isolation capability."
  source: "`vibe_water_utilities_v1`.`distribution`.`valve_exercise`"
  dimensions:
    - name: "exercise_status"
      expr: exercise_status
      comment: "Status of the valve exercise (completed, failed, partial) — primary compliance dimension for exercising program reporting."
    - name: "operability_status"
      expr: operability_status
      comment: "Valve operability result (operable, inoperable, requires repair) — drives work order generation and emergency response planning."
    - name: "exercise_method"
      expr: exercise_method
      comment: "Method used to exercise the valve (manual, power operator, etc.) — informs equipment and crew resource planning."
    - name: "exercise_year"
      expr: YEAR(exercise_date)
      comment: "Year of valve exercise — tracks annual program compliance and identifies valves overdue for exercising."
    - name: "pressure_zone_code"
      expr: pressure_zone_code
      comment: "Pressure zone where valve is located — enables zone-level operability analysis for emergency isolation planning."
    - name: "deficiency_noted"
      expr: deficiency_noted
      comment: "Whether a deficiency was noted during exercising — primary flag for follow-up maintenance prioritization."
  measures:
    - name: "total_valve_exercises"
      expr: COUNT(1)
      comment: "Total number of valve exercise events. Program completeness KPI — tracks exercising frequency against AWWA M44 and state regulatory requirements."
    - name: "inoperable_valve_count"
      expr: SUM(CASE WHEN operability_status = 'inoperable' THEN 1 ELSE 0 END)
      comment: "Number of valves found inoperable during exercising. Emergency response risk KPI — inoperable valves compromise isolation capability during main breaks."
    - name: "deficiency_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN deficiency_noted = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of valve exercises that identified a deficiency. System health KPI — high deficiency rates indicate aging valve infrastructure requiring capital investment."
    - name: "leak_detected_count"
      expr: SUM(CASE WHEN leak_detected = TRUE THEN 1 ELSE 0 END)
      comment: "Number of valve exercises where a leak was detected. NRW contribution KPI — valve leaks are a component of real losses in the water balance."
    - name: "avg_torque_reading"
      expr: AVG(CAST(torque_reading AS DOUBLE))
      comment: "Average torque required to operate valves. Asset condition indicator — increasing torque trends indicate valve deterioration and predict future inoperability."
    - name: "follow_up_required_count"
      expr: SUM(CASE WHEN follow_up_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of valve exercises requiring follow-up maintenance. Work order backlog driver — used to plan maintenance crew capacity and prioritize repairs."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_dma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "District Metered Area (DMA) operational metrics tracking hydraulic performance, leakage detection readiness, and zone management. Foundation KPIs for NRW program targeting and pressure management."
  source: "`vibe_water_utilities_v1`.`distribution`.`dma`"
  dimensions:
    - name: "dma_status"
      expr: dma_status
      comment: "Operational status of the DMA (active, inactive, under review) — filters to active DMAs for performance reporting."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Criticality rating of the DMA — prioritizes high-criticality zones for enhanced monitoring and faster response."
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone containing this DMA — enables hierarchical analysis from pressure zone down to DMA level."
    - name: "scada_monitored_flag"
      expr: scada_monitored_flag
      comment: "Whether the DMA has SCADA monitoring — distinguishes real-time monitored zones from manually surveyed zones."
    - name: "established_year"
      expr: YEAR(established_date)
      comment: "Year the DMA was established — enables analysis of DMA program maturity and coverage expansion over time."
  measures:
    - name: "total_dmas"
      expr: COUNT(1)
      comment: "Total number of District Metered Areas. System coverage KPI — tracks DMA program completeness against total service area."
    - name: "avg_average_pressure_psi"
      expr: AVG(CAST(average_pressure_psi AS DOUBLE))
      comment: "Average operating pressure across DMAs in PSI. Pressure management KPI — high average pressures increase break frequency and real losses."
    - name: "total_main_length_miles"
      expr: SUM(CAST(main_length_miles AS DOUBLE))
      comment: "Total pipe main length across all DMAs in miles. Network coverage metric — denominator for break rate per 100 miles calculations."
    - name: "avg_design_flow_mgd"
      expr: AVG(CAST(design_flow_mgd AS DOUBLE))
      comment: "Average design flow capacity across DMAs in million gallons per day. Capacity adequacy KPI — identifies DMAs approaching design capacity limits."
    - name: "avg_minimum_night_flow_threshold_gpm"
      expr: AVG(CAST(minimum_night_flow_threshold_gpm AS DOUBLE))
      comment: "Average minimum night flow threshold in gallons per minute. Leakage detection sensitivity KPI — lower thresholds enable earlier detection of developing leaks."
    - name: "scada_monitored_dma_count"
      expr: SUM(CASE WHEN scada_monitored_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of DMAs with active SCADA monitoring. Real-time visibility KPI — SCADA-monitored DMAs enable continuous minimum night flow analysis for leak detection."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_service_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service line inventory and LCRR compliance metrics tracking material classification, lead line identification, and replacement program progress. Critical KPIs for EPA Lead and Copper Rule Revisions compliance and public health protection."
  source: "`vibe_water_utilities_v1`.`distribution`.`service_line`"
  dimensions:
    - name: "material_type"
      expr: material_type
      comment: "Service line material (lead, galvanized, copper, plastic, unknown) — primary dimension for LCRR inventory analysis and replacement prioritization."
    - name: "lcrr_classification"
      expr: lcrr_classification
      comment: "LCRR material classification (lead, galvanized requiring replacement, non-lead, unknown) — regulatory compliance dimension for EPA reporting."
    - name: "connection_status"
      expr: connection_status
      comment: "Service line connection status (active, inactive, replaced) — filters to active lines for current inventory reporting."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership of the service line (utility, customer, shared) — critical for LCRR replacement program scoping and cost allocation."
    - name: "service_type"
      expr: service_type
      comment: "Type of service (residential, commercial, industrial, fire) — enables demand and risk analysis by customer class."
    - name: "installation_year"
      expr: installation_year
      comment: "Year of installation — enables age-based risk segmentation and replacement prioritization."
    - name: "lcrr_inventory_verified"
      expr: lcrr_inventory_verified
      comment: "Whether the LCRR material classification has been field-verified — distinguishes confirmed from estimated classifications."
  measures:
    - name: "total_service_lines"
      expr: COUNT(1)
      comment: "Total number of service lines in inventory. LCRR compliance baseline — EPA requires complete service line inventory by October 2024."
    - name: "total_length_feet"
      expr: SUM(CAST(length_feet AS DOUBLE))
      comment: "Total service line length in feet. Asset inventory metric — used in replacement cost estimation and capital program sizing."
    - name: "lead_service_line_count"
      expr: SUM(CASE WHEN lcrr_classification IN ('lead', 'galvanized requiring replacement') THEN 1 ELSE 0 END)
      comment: "Number of lead or galvanized-requiring-replacement service lines. LCRR compliance KPI — EPA requires replacement of all lead service lines; this drives the replacement program scope and timeline."
    - name: "unknown_material_count"
      expr: SUM(CASE WHEN lcrr_classification = 'unknown' OR material_type = 'unknown' THEN 1 ELSE 0 END)
      comment: "Number of service lines with unknown material classification. LCRR inventory gap KPI — unknown lines must be investigated; high counts indicate compliance risk."
    - name: "lcrr_verified_count"
      expr: SUM(CASE WHEN lcrr_inventory_verified = TRUE THEN 1 ELSE 0 END)
      comment: "Number of service lines with verified LCRR classification. Inventory accuracy KPI — EPA requires verified inventory; tracks field verification program progress."
    - name: "lcrr_verification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN lcrr_inventory_verified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service lines with verified LCRR material classification. Regulatory compliance rate — must reach 100% to satisfy EPA LCRR inventory requirements."
    - name: "avg_tap_size_inches"
      expr: AVG(CAST(tap_size_inches AS DOUBLE))
      comment: "Average service line tap size in inches. Demand capacity metric — informs meter sizing adequacy and service upgrade planning."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_storage_tank`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution storage tank metrics tracking capacity adequacy, operational status, and inspection compliance. KPIs for system resilience, fire flow reserve management, and regulatory inspection compliance."
  source: "`vibe_water_utilities_v1`.`distribution`.`storage_tank`"
  dimensions:
    - name: "tank_type"
      expr: tank_type
      comment: "Type of storage tank (elevated, ground, standpipe, hydropneumatic) — enables capacity and performance analysis by tank category."
    - name: "tank_material"
      expr: tank_material
      comment: "Tank construction material (steel, concrete, composite) — informs inspection frequency and rehabilitation planning."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the tank (in service, out of service, under repair) — filters to active tanks for capacity reporting."
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone served by the tank — enables zone-level storage adequacy analysis."
    - name: "coating_condition"
      expr: coating_condition
      comment: "Condition of tank coating (good, fair, poor, failed) — drives inspection and rehabilitation prioritization."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type of the tank — distinguishes utility-owned from customer or third-party owned storage."
  measures:
    - name: "total_tanks"
      expr: COUNT(1)
      comment: "Total number of distribution storage tanks. System inventory KPI — baseline for storage capacity and redundancy analysis."
    - name: "total_capacity_million_gallons"
      expr: SUM(CAST(capacity_million_gallons AS DOUBLE))
      comment: "Total storage capacity in million gallons. System resilience KPI — compared against average daily demand to assess days of storage reserve."
    - name: "total_usable_capacity_gallons"
      expr: SUM(CAST(usable_capacity_gallons AS DOUBLE))
      comment: "Total usable storage capacity in gallons (excluding dead storage). Operational capacity KPI — actual available volume for demand equalization and emergency supply."
    - name: "total_fire_flow_reserve_gallons"
      expr: SUM(CAST(fire_flow_reserve_gallons AS DOUBLE))
      comment: "Total fire flow reserve storage in gallons. Fire protection compliance KPI — must meet ISO and local fire code minimum reserve requirements."
    - name: "total_emergency_storage_gallons"
      expr: SUM(CAST(emergency_storage_gallons AS DOUBLE))
      comment: "Total emergency storage reserve in gallons. System resilience KPI — ensures adequate supply during treatment plant outages or supply emergencies."
    - name: "mixing_system_installed_count"
      expr: SUM(CASE WHEN mixing_system_installed = TRUE THEN 1 ELSE 0 END)
      comment: "Number of tanks with active mixing systems. Water quality compliance KPI — mixing prevents stratification and disinfectant residual decay in storage."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_flushing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution system flushing event metrics tracking program execution, water quality outcomes, and resource utilization. KPIs for water quality compliance, operational efficiency, and customer communication."
  source: "`vibe_water_utilities_v1`.`distribution`.`flushing_event`"
  dimensions:
    - name: "flush_reason"
      expr: flush_reason
      comment: "Reason for flushing (routine, complaint response, main break, water quality, new main) — enables analysis of reactive vs. proactive flushing program balance."
    - name: "flushing_method"
      expr: flushing_method
      comment: "Flushing method used (conventional, unidirectional, blow-off) — informs effectiveness comparison and best practice adoption."
    - name: "flush_status"
      expr: flush_status
      comment: "Status of the flushing event (completed, in-progress, cancelled) — filters to completed events for outcome analysis."
    - name: "flush_year"
      expr: YEAR(flush_date)
      comment: "Year of flushing event — enables annual program coverage tracking and trend analysis."
    - name: "flush_effectiveness_rating"
      expr: flush_effectiveness_rating
      comment: "Effectiveness rating of the flush — measures whether flushing achieved target water quality improvement."
    - name: "public_notification_sent"
      expr: public_notification_sent
      comment: "Whether public notification was sent — tracks customer communication compliance for planned flushing events."
  measures:
    - name: "total_flushing_events"
      expr: COUNT(1)
      comment: "Total number of flushing events. Program activity KPI — tracks flushing frequency against annual program targets."
    - name: "total_volume_discharged_gallons"
      expr: SUM(CAST(volume_discharged_gallons AS DOUBLE))
      comment: "Total water volume discharged during flushing in gallons. Water loss and cost KPI — flushing water is a component of unbilled authorized consumption in the NRW balance."
    - name: "avg_flow_rate_gpm"
      expr: AVG(CAST(flow_rate_gpm AS DOUBLE))
      comment: "Average flushing flow rate in gallons per minute. Hydraulic effectiveness indicator — adequate flow rates are required to achieve target pipe velocity for sediment removal."
    - name: "avg_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average flushing duration in minutes. Operational efficiency metric — combined with flow rate determines volume discharged and crew time per event."
    - name: "avg_post_flush_chlorine_residual"
      expr: AVG(CAST(post_flush_chlorine_residual_mg_l AS DOUBLE))
      comment: "Average post-flush chlorine residual in mg/L. Water quality compliance KPI — must meet minimum residual requirements after flushing to ensure disinfection."
    - name: "follow_up_required_count"
      expr: SUM(CASE WHEN follow_up_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of flushing events requiring follow-up action. Quality assurance KPI — high rates indicate persistent water quality issues requiring investigation."
    - name: "water_quality_sample_collected_count"
      expr: SUM(CASE WHEN water_quality_sample_collected = TRUE THEN 1 ELSE 0 END)
      comment: "Number of flushing events where water quality samples were collected. Compliance documentation KPI — sample collection validates flushing effectiveness and supports regulatory reporting."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_flow_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational flow and pressure KPIs for distribution network."
  source: "`vibe_water_utilities_v1`.`distribution`.`flow_reading`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "Identifier of the DMA where the reading was taken."
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement (e.g., Instantaneous, Averaged)."
    - name: "reading_date"
      expr: DATE_TRUNC('day', reading_timestamp)
      comment: "Date of the flow reading (day granularity)."
  measures:
    - name: "total_flow_volume"
      expr: SUM(CAST(flow_value AS DOUBLE))
      comment: "Total flow volume recorded (MG) across all readings."
    - name: "avg_pressure_psi"
      expr: AVG(CAST(pressure_psi AS DOUBLE))
      comment: "Average pressure (psi) observed across readings."
    - name: "count_readings"
      expr: COUNT(1)
      comment: "Number of flow reading records."
$$;