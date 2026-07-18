-- Metric views for domain: landfill | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 19:57:14

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`landfill_airspace_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic airspace utilization and capacity metrics for landfill cells, tracking consumption rates, remaining capacity, and projected closure timelines"
  source: "`waste_management_ecm`.`landfill`.`airspace_consumption`"
  dimensions:
    - name: "measurement_year"
      expr: YEAR(measurement_date)
      comment: "Year of airspace measurement for trend analysis"
    - name: "measurement_quarter"
      expr: CONCAT('Q', QUARTER(measurement_date), '-', YEAR(measurement_date))
      comment: "Quarter of measurement for seasonal capacity planning"
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the airspace measurement (e.g., preliminary, final, certified)"
    - name: "survey_method"
      expr: survey_method
      comment: "Method used for airspace survey (e.g., GPS, drone, traditional survey)"
    - name: "regulatory_reporting_period"
      expr: regulatory_reporting_period
      comment: "Regulatory reporting period for compliance tracking"
    - name: "submitted_to_regulator"
      expr: submitted_to_regulator_flag
      comment: "Whether measurement has been submitted to regulatory authority"
    - name: "capacity_utilization_tier"
      expr: CASE WHEN (cumulative_volume_consumed_cubic_yards / NULLIF(total_permitted_capacity_cubic_yards, 0)) >= 0.9 THEN 'Critical (90%+)' WHEN (cumulative_volume_consumed_cubic_yards / NULLIF(total_permitted_capacity_cubic_yards, 0)) >= 0.75 THEN 'High (75-90%)' WHEN (cumulative_volume_consumed_cubic_yards / NULLIF(total_permitted_capacity_cubic_yards, 0)) >= 0.5 THEN 'Moderate (50-75%)' ELSE 'Low (<50%)' END
      comment: "Capacity utilization tier for strategic planning and expansion prioritization"
  measures:
    - name: "total_volume_consumed_cy"
      expr: SUM(CAST(volume_consumed_cubic_yards AS DOUBLE))
      comment: "Total airspace volume consumed in cubic yards during the period"
    - name: "total_waste_tonnage_placed"
      expr: SUM(CAST(waste_tonnage_placed_tons AS DOUBLE))
      comment: "Total waste tonnage placed in landfill during the period"
    - name: "avg_compaction_ratio"
      expr: AVG(CAST(compaction_ratio AS DOUBLE))
      comment: "Average compaction ratio achieved, indicating operational efficiency"
    - name: "avg_in_place_density"
      expr: AVG(CAST(in_place_density_lbs_per_cubic_yard AS DOUBLE))
      comment: "Average in-place density in lbs per cubic yard, key efficiency metric"
    - name: "avg_consumption_rate_cy_per_day"
      expr: AVG(CAST(rate_cubic_yards_per_day AS DOUBLE))
      comment: "Average daily airspace consumption rate for capacity forecasting"
    - name: "avg_remaining_capacity_cy"
      expr: AVG(CAST(remaining_permitted_airspace_cubic_yards AS DOUBLE))
      comment: "Average remaining permitted airspace capacity in cubic yards"
    - name: "avg_years_remaining_capacity"
      expr: AVG(CAST(years_remaining_capacity AS DOUBLE))
      comment: "Average projected years of remaining capacity, critical for strategic planning"
    - name: "capacity_utilization_pct"
      expr: ROUND(100.0 * AVG(CAST(cumulative_volume_consumed_cubic_yards AS DOUBLE) / NULLIF(CAST(total_permitted_capacity_cubic_yards AS DOUBLE), 0)), 2)
      comment: "Average capacity utilization percentage, key strategic KPI for expansion planning"
    - name: "total_cover_material_volume_cy"
      expr: SUM(CAST(cover_material_volume_cubic_yards AS DOUBLE))
      comment: "Total cover material volume used, impacts operational costs"
    - name: "measurement_count"
      expr: COUNT(1)
      comment: "Number of airspace measurements recorded"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`landfill_capacity_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic capacity planning metrics tracking permitted capacity, projected site life, expansion plans, and financial requirements"
  source: "`waste_management_ecm`.`landfill`.`capacity_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of capacity plan (e.g., draft, approved, active, expired)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of capacity plan (e.g., baseline, expansion, renewal)"
    - name: "planning_horizon_years"
      expr: planning_horizon_years
      comment: "Planning horizon in years for long-term strategic planning"
    - name: "expansion_planned"
      expr: CASE WHEN lateral_expansion_planned = TRUE OR vertical_expansion_planned = TRUE THEN 'Expansion Planned' ELSE 'No Expansion' END
      comment: "Whether any expansion (lateral or vertical) is planned"
    - name: "permit_renewal_required"
      expr: permit_renewal_required
      comment: "Whether permit renewal is required for the plan"
    - name: "expansion_permit_status"
      expr: expansion_permit_status
      comment: "Status of expansion permit application or approval"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the capacity plan became effective"
  measures:
    - name: "total_permitted_capacity_cy"
      expr: SUM(CAST(total_permitted_capacity_cy AS DOUBLE))
      comment: "Total permitted capacity in cubic yards across all plans"
    - name: "total_permitted_capacity_tons"
      expr: SUM(CAST(total_permitted_capacity_tons AS DOUBLE))
      comment: "Total permitted capacity in tons across all plans"
    - name: "total_remaining_capacity_cy"
      expr: SUM(CAST(remaining_airspace_cy AS DOUBLE))
      comment: "Total remaining airspace capacity in cubic yards"
    - name: "total_remaining_capacity_tons"
      expr: SUM(CAST(remaining_capacity_tons AS DOUBLE))
      comment: "Total remaining capacity in tons"
    - name: "avg_projected_site_life_years"
      expr: AVG(CAST(projected_site_life_years AS DOUBLE))
      comment: "Average projected site life in years, critical for strategic asset planning"
    - name: "total_capital_investment_required"
      expr: SUM(CAST(capital_investment_required AS DOUBLE))
      comment: "Total capital investment required for capacity plans, key financial planning metric"
    - name: "avg_annual_waste_acceptance_rate_tons"
      expr: AVG(CAST(annual_waste_acceptance_rate_tons AS DOUBLE))
      comment: "Average annual waste acceptance rate in tons for throughput planning"
    - name: "total_lateral_expansion_capacity_cy"
      expr: SUM(CAST(lateral_expansion_capacity_cy AS DOUBLE))
      comment: "Total lateral expansion capacity in cubic yards"
    - name: "total_vertical_expansion_capacity_cy"
      expr: SUM(CAST(vertical_expansion_capacity_cy AS DOUBLE))
      comment: "Total vertical expansion capacity in cubic yards"
    - name: "capacity_consumed_pct"
      expr: ROUND(100.0 * AVG(CAST(capacity_consumed_to_date_cy AS DOUBLE) / NULLIF(CAST(total_permitted_capacity_cy AS DOUBLE), 0)), 2)
      comment: "Average percentage of capacity consumed to date, key utilization KPI"
    - name: "plan_count"
      expr: COUNT(1)
      comment: "Number of capacity plans"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`landfill_cell`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational metrics for landfill cells tracking capacity, tonnage, status, and gas collection system deployment"
  source: "`waste_management_ecm`.`landfill`.`cell`"
  dimensions:
    - name: "cell_status"
      expr: cell_status
      comment: "Current operational status of the cell (e.g., active, closed, under construction)"
    - name: "phase_number"
      expr: phase_number
      comment: "Phase number for multi-phase landfill development tracking"
    - name: "liner_system_type"
      expr: liner_system_type
      comment: "Type of liner system installed (e.g., single, double, composite)"
    - name: "gas_collection_installed"
      expr: gas_collection_system_installed
      comment: "Whether gas collection system is installed"
    - name: "daily_cover_material_type"
      expr: daily_cover_material_type
      comment: "Type of daily cover material used"
    - name: "opening_year"
      expr: YEAR(opening_date)
      comment: "Year the cell was opened for waste acceptance"
    - name: "closure_year"
      expr: YEAR(closure_date)
      comment: "Year the cell was closed"
    - name: "capacity_utilization_tier"
      expr: CASE WHEN (remaining_capacity_cubic_yards / NULLIF(design_capacity_cubic_yards, 0)) <= 0.1 THEN 'Critical (<10% remaining)' WHEN (remaining_capacity_cubic_yards / NULLIF(design_capacity_cubic_yards, 0)) <= 0.25 THEN 'Low (10-25% remaining)' WHEN (remaining_capacity_cubic_yards / NULLIF(design_capacity_cubic_yards, 0)) <= 0.5 THEN 'Moderate (25-50% remaining)' ELSE 'High (>50% remaining)' END
      comment: "Remaining capacity tier for operational prioritization"
  measures:
    - name: "total_design_capacity_cy"
      expr: SUM(CAST(design_capacity_cubic_yards AS DOUBLE))
      comment: "Total design capacity in cubic yards across all cells"
    - name: "total_design_capacity_tons"
      expr: SUM(CAST(design_capacity_tons AS DOUBLE))
      comment: "Total design capacity in tons across all cells"
    - name: "total_remaining_capacity_cy"
      expr: SUM(CAST(remaining_capacity_cubic_yards AS DOUBLE))
      comment: "Total remaining capacity in cubic yards, critical for operational planning"
    - name: "total_tonnage_received"
      expr: SUM(CAST(total_tonnage_received AS DOUBLE))
      comment: "Total tonnage received across all cells"
    - name: "avg_daily_tonnage"
      expr: AVG(CAST(average_daily_tonnage AS DOUBLE))
      comment: "Average daily tonnage across cells for throughput planning"
    - name: "avg_area_acres"
      expr: AVG(CAST(area_acres AS DOUBLE))
      comment: "Average cell area in acres"
    - name: "capacity_utilization_pct"
      expr: ROUND(100.0 * (1.0 - AVG(CAST(remaining_capacity_cubic_yards AS DOUBLE) / NULLIF(CAST(design_capacity_cubic_yards AS DOUBLE), 0))), 2)
      comment: "Average capacity utilization percentage across cells, key operational KPI"
    - name: "avg_tipping_fee_per_ton"
      expr: AVG(CAST(tipping_fee_per_ton AS DOUBLE))
      comment: "Average tipping fee per ton, key revenue metric"
    - name: "cell_count"
      expr: COUNT(1)
      comment: "Number of landfill cells"
    - name: "active_cell_count"
      expr: COUNT(CASE WHEN cell_status = 'active' THEN 1 END)
      comment: "Number of active cells currently accepting waste"
    - name: "gas_collection_cell_count"
      expr: COUNT(CASE WHEN gas_collection_system_installed = TRUE THEN 1 END)
      comment: "Number of cells with gas collection systems installed"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`landfill_compaction_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational efficiency metrics for waste compaction tracking achieved ratios, equipment utilization, and fuel consumption"
  source: "`waste_management_ecm`.`landfill`.`compaction_record`"
  dimensions:
    - name: "compaction_date"
      expr: compaction_date
      comment: "Date of compaction operation"
    - name: "compaction_year"
      expr: YEAR(compaction_date)
      comment: "Year of compaction for trend analysis"
    - name: "compaction_month"
      expr: DATE_TRUNC('MONTH', compaction_date)
      comment: "Month of compaction for seasonal analysis"
    - name: "compaction_method"
      expr: compaction_method
      comment: "Method used for compaction (e.g., dozer, compactor)"
    - name: "shift_type"
      expr: shift_type
      comment: "Shift during which compaction occurred (e.g., day, night)"
    - name: "waste_type_compacted"
      expr: waste_type_compacted
      comment: "Type of waste being compacted"
    - name: "cover_material_type"
      expr: cover_material_type
      comment: "Type of cover material applied"
    - name: "daily_cover_applied"
      expr: daily_cover_applied_flag
      comment: "Whether daily cover was applied during operation"
    - name: "quality_control_passed"
      expr: quality_control_flag
      comment: "Whether quality control standards were met"
  measures:
    - name: "total_waste_tonnage_compacted"
      expr: SUM(CAST(waste_tonnage_compacted AS DOUBLE))
      comment: "Total waste tonnage compacted, key throughput metric"
    - name: "avg_achieved_compaction_ratio"
      expr: AVG(CAST(achieved_compaction_ratio AS DOUBLE))
      comment: "Average achieved compaction ratio, critical operational efficiency KPI"
    - name: "avg_target_compaction_ratio"
      expr: AVG(CAST(target_compaction_ratio AS DOUBLE))
      comment: "Average target compaction ratio for performance benchmarking"
    - name: "compaction_ratio_achievement_pct"
      expr: ROUND(100.0 * AVG(CAST(achieved_compaction_ratio AS DOUBLE) / NULLIF(CAST(target_compaction_ratio AS DOUBLE), 0)), 2)
      comment: "Percentage achievement of target compaction ratio, key quality KPI"
    - name: "total_equipment_hours"
      expr: SUM(CAST(equipment_hours_logged AS DOUBLE))
      comment: "Total equipment hours logged for utilization analysis"
    - name: "total_fuel_consumed_gallons"
      expr: SUM(CAST(fuel_consumed_gallons AS DOUBLE))
      comment: "Total fuel consumed in gallons, key cost driver"
    - name: "fuel_efficiency_gallons_per_ton"
      expr: ROUND(SUM(CAST(fuel_consumed_gallons AS DOUBLE)) / NULLIF(SUM(CAST(waste_tonnage_compacted AS DOUBLE)), 0), 3)
      comment: "Fuel efficiency in gallons per ton compacted, operational efficiency metric"
    - name: "total_cover_material_volume_cy"
      expr: SUM(CAST(cover_material_volume_cy AS DOUBLE))
      comment: "Total cover material volume used in cubic yards"
    - name: "avg_volume_reduction_pct"
      expr: ROUND(100.0 * AVG((CAST(volume_before_compaction_cy AS DOUBLE) - CAST(volume_after_compaction_cy AS DOUBLE)) / NULLIF(CAST(volume_before_compaction_cy AS DOUBLE), 0)), 2)
      comment: "Average volume reduction percentage achieved through compaction"
    - name: "compaction_record_count"
      expr: COUNT(1)
      comment: "Number of compaction records"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`landfill_tonnage_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and throughput metrics tracking waste receipts, tipping fees, load rejections, and contamination rates"
  source: "`waste_management_ecm`.`landfill`.`tonnage_receipt`"
  dimensions:
    - name: "receipt_date"
      expr: DATE(receipt_timestamp)
      comment: "Date of waste receipt"
    - name: "receipt_year"
      expr: YEAR(receipt_timestamp)
      comment: "Year of receipt for trend analysis"
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_timestamp)
      comment: "Month of receipt for seasonal analysis"
    - name: "waste_type"
      expr: waste_type
      comment: "Type of waste received (e.g., MSW, C&D, special waste)"
    - name: "waste_subtype"
      expr: waste_subtype
      comment: "Subtype of waste for detailed categorization"
    - name: "waste_origin_type"
      expr: waste_origin_type
      comment: "Origin type of waste (e.g., residential, commercial, industrial)"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the tonnage transaction (e.g., completed, pending, voided)"
    - name: "load_rejected"
      expr: load_rejected_flag
      comment: "Whether the load was rejected"
    - name: "contamination_detected"
      expr: contamination_flag
      comment: "Whether contamination was detected in the load"
    - name: "load_inspection_status"
      expr: load_inspection_status
      comment: "Status of load inspection (e.g., passed, failed, conditional)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment for tipping fees"
  measures:
    - name: "total_net_tonnage"
      expr: SUM(CAST(net_tonnage AS DOUBLE))
      comment: "Total net tonnage received, primary throughput KPI"
    - name: "total_gross_weight_tons"
      expr: SUM(CAST(gross_weight_tons AS DOUBLE))
      comment: "Total gross weight in tons"
    - name: "total_tare_weight_tons"
      expr: SUM(CAST(tare_weight_tons AS DOUBLE))
      comment: "Total tare weight in tons"
    - name: "total_tipping_fee_revenue"
      expr: SUM(CAST(tipping_fee_amount AS DOUBLE))
      comment: "Total tipping fee revenue, primary revenue KPI for landfill operations"
    - name: "avg_tipping_fee_rate"
      expr: AVG(CAST(tipping_fee_rate AS DOUBLE))
      comment: "Average tipping fee rate per ton"
    - name: "revenue_per_ton"
      expr: ROUND(SUM(CAST(tipping_fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_tonnage AS DOUBLE)), 0), 2)
      comment: "Average revenue per ton, key pricing effectiveness metric"
    - name: "load_rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN load_rejected_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Load rejection rate percentage, quality control KPI"
    - name: "contamination_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN contamination_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Contamination detection rate percentage, quality and compliance KPI"
    - name: "avg_moisture_content_pct"
      expr: AVG(CAST(moisture_content_percent AS DOUBLE))
      comment: "Average moisture content percentage of received waste"
    - name: "receipt_count"
      expr: COUNT(1)
      comment: "Number of tonnage receipts processed"
    - name: "unique_customer_count"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers delivering waste"
    - name: "unique_vehicle_count"
      expr: COUNT(DISTINCT vehicle_id)
      comment: "Number of unique vehicles delivering waste"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`landfill_leachate_collection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental compliance and cost metrics for leachate collection, disposal, and water quality monitoring"
  source: "`waste_management_ecm`.`landfill`.`leachate_collection`"
  dimensions:
    - name: "collection_date"
      expr: collection_date
      comment: "Date of leachate collection"
    - name: "collection_year"
      expr: YEAR(collection_date)
      comment: "Year of collection for trend analysis"
    - name: "collection_month"
      expr: DATE_TRUNC('MONTH', collection_date)
      comment: "Month of collection for seasonal analysis"
    - name: "collection_method"
      expr: collection_method
      comment: "Method used for leachate collection"
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method used for leachate disposal (e.g., POTW, on-site treatment)"
    - name: "collection_system_status"
      expr: collection_system_status
      comment: "Status of the collection system"
    - name: "permit_compliance"
      expr: permit_limit_compliance_flag
      comment: "Whether leachate quality is within permit limits"
    - name: "sample_collected"
      expr: sample_collected_flag
      comment: "Whether a sample was collected for analysis"
    - name: "regulatory_report_submitted"
      expr: regulatory_report_submitted_flag
      comment: "Whether regulatory report was submitted"
    - name: "liner_integrity_status"
      expr: liner_integrity_status
      comment: "Status of liner integrity at collection point"
  measures:
    - name: "total_volume_collected_gallons"
      expr: SUM(CAST(volume_collected_gallons AS DOUBLE))
      comment: "Total leachate volume collected in gallons, key operational metric"
    - name: "total_disposal_volume_gallons"
      expr: SUM(CAST(disposal_volume_gallons AS DOUBLE))
      comment: "Total leachate volume disposed in gallons"
    - name: "total_disposal_cost"
      expr: SUM(CAST(disposal_cost_usd AS DOUBLE))
      comment: "Total leachate disposal cost in USD, key cost driver for landfill operations"
    - name: "disposal_cost_per_gallon"
      expr: ROUND(SUM(CAST(disposal_cost_usd AS DOUBLE)) / NULLIF(SUM(CAST(disposal_volume_gallons AS DOUBLE)), 0), 3)
      comment: "Average disposal cost per gallon, cost efficiency metric"
    - name: "avg_bod_mg_l"
      expr: AVG(CAST(bod_mg_l AS DOUBLE))
      comment: "Average Biochemical Oxygen Demand in mg/L, water quality indicator"
    - name: "avg_cod_mg_l"
      expr: AVG(CAST(cod_mg_l AS DOUBLE))
      comment: "Average Chemical Oxygen Demand in mg/L, water quality indicator"
    - name: "avg_ph_level"
      expr: AVG(CAST(ph_level AS DOUBLE))
      comment: "Average pH level of leachate"
    - name: "avg_conductivity"
      expr: AVG(CAST(conductivity_umhos_cm AS DOUBLE))
      comment: "Average conductivity in umhos/cm"
    - name: "permit_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN permit_limit_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Permit compliance rate percentage, critical environmental compliance KPI"
    - name: "collection_event_count"
      expr: COUNT(1)
      comment: "Number of leachate collection events"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`landfill_lfg_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental compliance and safety metrics for landfill gas monitoring tracking methane concentration, flow rates, and exceedances"
  source: "`waste_management_ecm`.`landfill`.`lfg_monitoring`"
  dimensions:
    - name: "monitoring_date"
      expr: monitoring_date
      comment: "Date of LFG monitoring"
    - name: "monitoring_year"
      expr: YEAR(monitoring_date)
      comment: "Year of monitoring for trend analysis"
    - name: "monitoring_month"
      expr: DATE_TRUNC('MONTH', monitoring_date)
      comment: "Month of monitoring for seasonal analysis"
    - name: "monitoring_point_type"
      expr: monitoring_point_type
      comment: "Type of monitoring point (e.g., perimeter probe, extraction well)"
    - name: "monitoring_method"
      expr: monitoring_method
      comment: "Method used for monitoring"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the monitoring result"
    - name: "exceedance_detected"
      expr: exceedance_flag
      comment: "Whether an exceedance was detected"
    - name: "exceedance_type"
      expr: exceedance_type
      comment: "Type of exceedance detected (e.g., methane, LEL)"
    - name: "corrective_action_required"
      expr: corrective_action_required_flag
      comment: "Whether corrective action is required"
    - name: "regulatory_report_required"
      expr: regulatory_report_flag
      comment: "Whether regulatory reporting is required"
  measures:
    - name: "avg_methane_concentration_pct"
      expr: AVG(CAST(methane_concentration_pct AS DOUBLE))
      comment: "Average methane concentration percentage, key environmental and safety metric"
    - name: "avg_carbon_dioxide_concentration_pct"
      expr: AVG(CAST(carbon_dioxide_concentration_pct AS DOUBLE))
      comment: "Average carbon dioxide concentration percentage"
    - name: "avg_oxygen_concentration_pct"
      expr: AVG(CAST(oxygen_concentration_pct AS DOUBLE))
      comment: "Average oxygen concentration percentage"
    - name: "avg_lel_percentage"
      expr: AVG(CAST(lel_percentage AS DOUBLE))
      comment: "Average Lower Explosive Limit percentage, critical safety metric"
    - name: "avg_hydrogen_sulfide_ppm"
      expr: AVG(CAST(hydrogen_sulfide_ppm AS DOUBLE))
      comment: "Average hydrogen sulfide concentration in ppm, safety and odor metric"
    - name: "avg_lfg_flow_rate_scfm"
      expr: AVG(CAST(lfg_flow_rate_scfm AS DOUBLE))
      comment: "Average LFG flow rate in standard cubic feet per minute"
    - name: "avg_static_pressure_inches_wc"
      expr: AVG(CAST(static_pressure_inches_wc AS DOUBLE))
      comment: "Average static pressure in inches of water column"
    - name: "exceedance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exceedance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Exceedance rate percentage, critical compliance KPI"
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Corrective action requirement rate, operational response metric"
    - name: "monitoring_event_count"
      expr: COUNT(1)
      comment: "Number of LFG monitoring events"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`landfill_groundwater_sample`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental compliance metrics for groundwater monitoring tracking exceedances, regulatory notifications, and water quality parameters"
  source: "`waste_management_ecm`.`landfill`.`groundwater_sample`"
  dimensions:
    - name: "sample_date"
      expr: sample_date
      comment: "Date of groundwater sample collection"
    - name: "sample_year"
      expr: YEAR(sample_date)
      comment: "Year of sampling for trend analysis"
    - name: "sample_quarter"
      expr: CONCAT('Q', QUARTER(sample_date), '-', YEAR(sample_date))
      comment: "Quarter of sampling for regulatory reporting"
    - name: "sample_type"
      expr: sample_type
      comment: "Type of sample (e.g., routine, confirmation, assessment)"
    - name: "monitoring_program_type"
      expr: monitoring_program_type
      comment: "Type of monitoring program (e.g., detection, assessment, corrective action)"
    - name: "exceedance_detected"
      expr: exceedance_detected_flag
      comment: "Whether parameter exceedances were detected"
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required_flag
      comment: "Whether regulatory notification is required"
    - name: "cercla_reportable"
      expr: cercla_reportable_flag
      comment: "Whether sample results are CERCLA reportable"
    - name: "qa_qc_status"
      expr: qa_qc_flag
      comment: "Quality assurance/quality control status"
  measures:
    - name: "avg_field_ph"
      expr: AVG(CAST(field_ph AS DOUBLE))
      comment: "Average field pH measurement"
    - name: "avg_field_temperature_celsius"
      expr: AVG(CAST(field_temperature_celsius AS DOUBLE))
      comment: "Average field temperature in Celsius"
    - name: "avg_field_conductivity"
      expr: AVG(CAST(field_conductivity_umhos AS DOUBLE))
      comment: "Average field conductivity in umhos"
    - name: "avg_field_dissolved_oxygen"
      expr: AVG(CAST(field_dissolved_oxygen_mg_l AS DOUBLE))
      comment: "Average field dissolved oxygen in mg/L"
    - name: "avg_field_turbidity"
      expr: AVG(CAST(field_turbidity_ntu AS DOUBLE))
      comment: "Average field turbidity in NTU"
    - name: "exceedance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exceedance_detected_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Exceedance detection rate percentage, critical environmental compliance KPI"
    - name: "regulatory_notification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_notification_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Regulatory notification requirement rate, compliance metric"
    - name: "sample_count"
      expr: COUNT(1)
      comment: "Number of groundwater samples collected"
    - name: "unique_well_count"
      expr: COUNT(DISTINCT groundwater_monitoring_well_id)
      comment: "Number of unique monitoring wells sampled"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`landfill_special_waste_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue opportunity and risk management metrics for special waste approvals tracking approval rates, tonnage limits, and regulatory requirements"
  source: "`waste_management_ecm`.`landfill`.`special_waste_approval`"
  dimensions:
    - name: "request_year"
      expr: YEAR(request_date)
      comment: "Year of approval request"
    - name: "request_quarter"
      expr: CONCAT('Q', QUARTER(request_date), '-', YEAR(request_date))
      comment: "Quarter of approval request"
    - name: "approval_status"
      expr: approval_status
      comment: "Status of the approval request (e.g., approved, rejected, pending)"
    - name: "waste_classification"
      expr: waste_classification
      comment: "Classification of the special waste"
    - name: "environmental_review_required"
      expr: environmental_review_required
      comment: "Whether environmental review is required"
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Whether regulatory notification is required"
    - name: "tclp_results_available"
      expr: tclp_results_available
      comment: "Whether TCLP test results are available"
    - name: "decision_year"
      expr: YEAR(approval_decision_date)
      comment: "Year of approval decision"
  measures:
    - name: "total_approved_tonnage_limit"
      expr: SUM(CAST(approved_tonnage_limit AS DOUBLE))
      comment: "Total approved tonnage limit across all approvals, revenue opportunity metric"
    - name: "total_estimated_volume_tons"
      expr: SUM(CAST(estimated_volume_tons AS DOUBLE))
      comment: "Total estimated volume in tons requested"
    - name: "total_estimated_volume_cy"
      expr: SUM(CAST(estimated_volume_cubic_yards AS DOUBLE))
      comment: "Total estimated volume in cubic yards requested"
    - name: "avg_approved_tonnage_limit"
      expr: AVG(CAST(approved_tonnage_limit AS DOUBLE))
      comment: "Average approved tonnage limit per approval"
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Approval rate percentage, business development effectiveness KPI"
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'rejected' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rejection rate percentage, risk management metric"
    - name: "approval_request_count"
      expr: COUNT(1)
      comment: "Number of special waste approval requests"
    - name: "unique_customer_count"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers requesting special waste approvals"
    - name: "unique_generator_count"
      expr: COUNT(DISTINCT epa_id_registration_id)
      comment: "Number of unique waste generators"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`landfill_regulatory_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance and risk management metrics for regulatory inspections tracking violations, corrective actions, penalties, and enforcement"
  source: "`waste_management_ecm`.`landfill`.`regulatory_inspection`"
  dimensions:
    - name: "inspection_date"
      expr: inspection_date
      comment: "Date of regulatory inspection"
    - name: "inspection_year"
      expr: YEAR(inspection_date)
      comment: "Year of inspection for trend analysis"
    - name: "inspection_quarter"
      expr: CONCAT('Q', QUARTER(inspection_date), '-', YEAR(inspection_date))
      comment: "Quarter of inspection"
    - name: "inspecting_agency"
      expr: inspecting_agency
      comment: "Agency conducting the inspection (e.g., EPA, state DEP)"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (e.g., routine, complaint, follow-up)"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of the inspection (e.g., open, closed, pending)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of findings (e.g., minor, moderate, major)"
    - name: "enforcement_action_taken"
      expr: enforcement_action_taken
      comment: "Type of enforcement action taken, if any"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions"
    - name: "follow_up_required"
      expr: follow_up_inspection_required
      comment: "Whether follow-up inspection is required"
  measures:
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount assessed, key financial risk metric"
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per inspection with penalties"
    - name: "avg_inspection_duration_hours"
      expr: AVG(CAST(inspection_duration_hours AS DOUBLE))
      comment: "Average inspection duration in hours"
    - name: "inspection_count"
      expr: COUNT(1)
      comment: "Number of regulatory inspections"
    - name: "inspection_with_violations_count"
      expr: COUNT(CASE WHEN violation_count IS NOT NULL AND violation_count != '0' THEN 1 END)
      comment: "Number of inspections with violations cited"
    - name: "violation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN violation_count IS NOT NULL AND violation_count != '0' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Violation rate percentage, critical compliance KPI"
    - name: "enforcement_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN enforcement_action_taken IS NOT NULL AND enforcement_action_taken != '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Enforcement action rate percentage, regulatory risk metric"
    - name: "follow_up_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_inspection_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Follow-up inspection requirement rate, compliance effectiveness metric"
    - name: "unique_site_count"
      expr: COUNT(DISTINCT site_id)
      comment: "Number of unique sites inspected"
$$;


CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`landfill_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic site-level metrics tracking operational status, capacity, permit status, and environmental systems deployment"
  source: "`waste_management_ecm`.`landfill`.`site`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the site (e.g., active, closed, post-closure)"
    - name: "classification"
      expr: classification
      comment: "Classification of the landfill site"
    - name: "state_code"
      expr: state_code
      comment: "State where the site is located"
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction governing the site"
    - name: "liner_system_type"
      expr: liner_system_type
      comment: "Type of liner system installed"
    - name: "lfg_collection_system_installed"
      expr: lfg_collection_system
      comment: "Whether LFG collection system is installed"
    - name: "lfg_utilization_type"
      expr: lfg_utilization_type
      comment: "Type of LFG utilization (e.g., flare, energy recovery)"
    - name: "ghg_reporting_required"
      expr: ghg_reporting_required
      comment: "Whether GHG reporting is required"
    - name: "groundwater_monitoring_required"
      expr: groundwater_monitoring_required
      comment: "Whether groundwater monitoring is required"
    - name: "cercla_status"
      expr: cercla_status
      comment: "CERCLA status of the site"
  measures:
    - name: "total_design_capacity_cy"
      expr: SUM(CAST(total_design_capacity_cy AS DOUBLE))
      comment: "Total design capacity in cubic yards across all sites"
    - name: "total_design_capacity_tons"
      expr: SUM(CAST(total_design_capacity_tons AS DOUBLE))
      comment: "Total design capacity in tons across all sites"
    - name: "total_remaining_airspace_cy"
      expr: SUM(CAST(remaining_airspace_cy AS DOUBLE))
      comment: "Total remaining airspace in cubic yards, critical capacity planning metric"
    - name: "total_permitted_acreage"
      expr: SUM(CAST(permitted_acreage AS DOUBLE))
      comment: "Total permitted acreage across all sites"
    - name: "total_permitted_daily_receipt_tons"
      expr: SUM(CAST(permitted_daily_receipt_tons AS DOUBLE))
      comment: "Total permitted daily receipt capacity in tons"
    - name: "avg_standard_tipping_fee"
      expr: AVG(CAST(standard_tipping_fee AS DOUBLE))
      comment: "Average standard tipping fee across sites, pricing benchmark metric"
    - name: "capacity_utilization_pct"
      expr: ROUND(100.0 * (1.0 - AVG(CAST(remaining_airspace_cy AS DOUBLE) / NULLIF(CAST(total_design_capacity_cy AS DOUBLE), 0))), 2)
      comment: "Average capacity utilization percentage across sites, strategic planning KPI"
    - name: "site_count"
      expr: COUNT(1)
      comment: "Number of landfill sites"
    - name: "active_site_count"
      expr: COUNT(CASE WHEN operational_status = 'active' THEN 1 END)
      comment: "Number of active landfill sites"
    - name: "lfg_collection_site_count"
      expr: COUNT(CASE WHEN lfg_collection_system = TRUE THEN 1 END)
      comment: "Number of sites with LFG collection systems"
    - name: "ghg_reporting_site_count"
      expr: COUNT(CASE WHEN ghg_reporting_required = TRUE THEN 1 END)
      comment: "Number of sites requiring GHG reporting"
$$;
