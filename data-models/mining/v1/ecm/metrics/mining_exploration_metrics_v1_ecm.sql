-- Metric views for domain: exploration | Business: Mining | Version: 1 | Generated on: 2026-05-05 10:43:42

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`exploration_drill_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic drilling program performance metrics tracking budget efficiency, execution progress, and safety outcomes for exploration campaigns"
  source: "`mining_ecm`.`exploration`.`drill_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current status of the drilling program (active, completed, suspended)"
    - name: "program_type"
      expr: program_type
      comment: "Type of drilling program (exploration, infill, resource definition)"
    - name: "drilling_method"
      expr: drilling_method
      comment: "Primary drilling method employed (RC, diamond, air-core)"
    - name: "target_resource_category"
      expr: target_resource_category
      comment: "Target resource classification being pursued (measured, indicated, inferred)"
    - name: "program_year"
      expr: YEAR(program_start_date)
      comment: "Calendar year when the drilling program commenced"
    - name: "program_quarter"
      expr: CONCAT('Q', QUARTER(program_start_date), '-', YEAR(program_start_date))
      comment: "Fiscal quarter of program start for trend analysis"
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the program is currently active"
    - name: "qaqc_protocol_applied"
      expr: qaqc_protocol_applied
      comment: "Whether quality assurance and quality control protocols were applied"
    - name: "rehabilitation_completed"
      expr: rehabilitation_completed
      comment: "Whether site rehabilitation has been completed post-drilling"
  measures:
    - name: "total_programs"
      expr: COUNT(1)
      comment: "Total number of drilling programs in the portfolio"
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved budget across all drilling programs"
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Total actual expenditure incurred across drilling programs"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_expenditure_amount AS DOUBLE)) / NULLIF(SUM(CAST(approved_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of approved budget actually spent - key efficiency indicator for capital allocation"
    - name: "total_planned_metreage"
      expr: SUM(CAST(planned_metreage AS DOUBLE))
      comment: "Total planned drilling metres across all programs"
    - name: "total_actual_metreage"
      expr: SUM(CAST(actual_metreage AS DOUBLE))
      comment: "Total actual metres drilled across all programs"
    - name: "metreage_achievement_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_metreage AS DOUBLE)) / NULLIF(SUM(CAST(planned_metreage AS DOUBLE)), 0), 2)
      comment: "Percentage of planned drilling metres achieved - critical execution KPI for program delivery"
    - name: "cost_per_metre"
      expr: ROUND(SUM(CAST(actual_expenditure_amount AS DOUBLE)) / NULLIF(SUM(CAST(actual_metreage AS DOUBLE)), 0), 2)
      comment: "Average cost per metre drilled - key unit economics metric for drilling efficiency"
    - name: "total_hse_incidents"
      expr: COUNT(DISTINCT incident_id)
      comment: "Count of distinct HSE incidents associated with drilling programs - critical safety performance indicator"
    - name: "programs_with_qaqc"
      expr: COUNT(DISTINCT CASE WHEN qaqc_protocol_applied = TRUE THEN drill_program_id END)
      comment: "Number of programs with quality protocols applied - data quality governance metric"
    - name: "programs_rehabilitation_complete"
      expr: COUNT(DISTINCT CASE WHEN rehabilitation_completed = TRUE THEN drill_program_id END)
      comment: "Number of programs with completed site rehabilitation - environmental compliance metric"
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`exploration_drill_hole`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational drilling execution metrics tracking hole completion, recovery rates, and drilling quality for resource definition"
  source: "`mining_ecm`.`exploration`.`drill_hole`"
  dimensions:
    - name: "hole_status"
      expr: hole_status
      comment: "Current status of the drill hole (completed, in-progress, abandoned)"
    - name: "drill_type"
      expr: drill_type
      comment: "Type of drilling method used (RC, diamond, air-core, RAB)"
    - name: "hole_purpose"
      expr: hole_purpose
      comment: "Purpose of the drill hole (exploration, resource definition, geotechnical)"
    - name: "qaqc_status"
      expr: qaqc_status
      comment: "Quality assurance status of the drill hole data"
    - name: "abandonment_reason"
      expr: abandonment_reason
      comment: "Reason for hole abandonment if applicable"
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year when the drill hole was completed"
    - name: "completion_quarter"
      expr: CONCAT('Q', QUARTER(completion_date), '-', YEAR(completion_date))
      comment: "Quarter when the drill hole was completed"
    - name: "core_diameter"
      expr: core_diameter
      comment: "Diameter of the drill core (e.g., NQ, HQ, PQ)"
    - name: "target_geology"
      expr: target_geology
      comment: "Target geological formation or unit"
  measures:
    - name: "total_drill_holes"
      expr: COUNT(1)
      comment: "Total number of drill holes executed"
    - name: "total_actual_depth"
      expr: SUM(CAST(actual_depth AS DOUBLE))
      comment: "Total metres drilled across all holes"
    - name: "total_planned_depth"
      expr: SUM(CAST(planned_depth AS DOUBLE))
      comment: "Total planned drilling metres"
    - name: "depth_achievement_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_depth AS DOUBLE)) / NULLIF(SUM(CAST(planned_depth AS DOUBLE)), 0), 2)
      comment: "Percentage of planned depth achieved - operational execution efficiency metric"
    - name: "avg_recovery_percentage"
      expr: AVG(CAST(recovery_percentage AS DOUBLE))
      comment: "Average core recovery percentage - critical data quality indicator for resource estimation"
    - name: "avg_actual_depth"
      expr: AVG(CAST(actual_depth AS DOUBLE))
      comment: "Average depth per drill hole"
    - name: "holes_completed"
      expr: COUNT(DISTINCT CASE WHEN hole_status = 'completed' THEN drill_hole_id END)
      comment: "Number of successfully completed drill holes"
    - name: "holes_abandoned"
      expr: COUNT(DISTINCT CASE WHEN hole_status = 'abandoned' THEN drill_hole_id END)
      comment: "Number of abandoned drill holes - indicator of drilling challenges or geological complexity"
    - name: "abandonment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN hole_status = 'abandoned' THEN drill_hole_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of drill holes abandoned - key risk and efficiency metric"
    - name: "total_hse_incidents"
      expr: COUNT(DISTINCT incident_id)
      comment: "Count of HSE incidents associated with drill holes - safety performance indicator"
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`exploration_sample`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sample collection and assay pipeline metrics tracking sample volumes, turnaround times, and quality control for resource estimation"
  source: "`mining_ecm`.`exploration`.`exploration_sample`"
  dimensions:
    - name: "sample_type"
      expr: sample_type
      comment: "Type of sample collected (core, chip, soil, rock)"
    - name: "sample_status"
      expr: sample_status
      comment: "Current status in the sample workflow (collected, dispatched, assayed, validated)"
    - name: "qaqc_type"
      expr: qaqc_type
      comment: "Type of quality control sample (blank, duplicate, standard, field sample)"
    - name: "chain_of_custody_status"
      expr: chain_of_custody_status
      comment: "Chain of custody status for sample integrity"
    - name: "collection_method"
      expr: collection_method
      comment: "Method used to collect the sample"
    - name: "lithology_code"
      expr: lithology_code
      comment: "Lithology code of the sampled material"
    - name: "mineralization_code"
      expr: mineralization_code
      comment: "Mineralization type observed in the sample"
    - name: "is_composite"
      expr: is_composite
      comment: "Flag indicating whether the sample is a composite of multiple intervals"
    - name: "collection_year"
      expr: YEAR(collection_date)
      comment: "Year when the sample was collected"
    - name: "collection_quarter"
      expr: CONCAT('Q', QUARTER(collection_date), '-', YEAR(collection_date))
      comment: "Quarter when the sample was collected"
  measures:
    - name: "total_samples"
      expr: COUNT(1)
      comment: "Total number of exploration samples collected"
    - name: "total_sample_weight"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of samples collected in kilograms"
    - name: "avg_sample_weight"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average sample weight in kilograms"
    - name: "total_sample_length"
      expr: SUM(CAST(length_m AS DOUBLE))
      comment: "Total length of samples collected in metres"
    - name: "avg_sample_length"
      expr: AVG(CAST(length_m AS DOUBLE))
      comment: "Average sample length in metres"
    - name: "avg_recovery_percent"
      expr: AVG(CAST(recovery_percent AS DOUBLE))
      comment: "Average sample recovery percentage - critical data quality metric"
    - name: "qaqc_sample_count"
      expr: COUNT(DISTINCT CASE WHEN qaqc_type IS NOT NULL AND qaqc_type != 'field sample' THEN exploration_sample_id END)
      comment: "Number of quality control samples - data quality governance indicator"
    - name: "qaqc_sample_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN qaqc_type IS NOT NULL AND qaqc_type != 'field sample' THEN exploration_sample_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of samples that are QA/QC samples - quality assurance coverage metric"
    - name: "samples_dispatched"
      expr: COUNT(DISTINCT CASE WHEN dispatch_date IS NOT NULL THEN exploration_sample_id END)
      comment: "Number of samples dispatched to laboratory"
    - name: "composite_sample_count"
      expr: COUNT(DISTINCT CASE WHEN is_composite = TRUE THEN exploration_sample_id END)
      comment: "Number of composite samples created"
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`exploration_resource_estimate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mineral resource estimation metrics tracking tonnage, grade, and contained metal across resource classifications for investment decisions"
  source: "`mining_ecm`.`exploration`.`resource_estimate`"
  dimensions:
    - name: "resource_classification"
      expr: resource_classification
      comment: "Resource classification category (measured, indicated, inferred)"
    - name: "estimate_status"
      expr: estimate_status
      comment: "Current status of the resource estimate (draft, approved, superseded)"
    - name: "estimate_type"
      expr: estimate_type
      comment: "Type of resource estimate (maiden, updated, revised)"
    - name: "estimation_method"
      expr: estimation_method
      comment: "Method used for resource estimation (ordinary kriging, inverse distance, etc.)"
    - name: "reporting_standard"
      expr: reporting_standard
      comment: "Reporting code standard applied (JORC, NI 43-101, SAMREC)"
    - name: "mining_method_assumption"
      expr: mining_method_assumption
      comment: "Assumed mining method for the resource (open pit, underground)"
    - name: "estimate_confidence_level"
      expr: estimate_confidence_level
      comment: "Confidence level of the estimate (high, medium, low)"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year when the resource estimate became effective"
    - name: "effective_quarter"
      expr: CONCAT('Q', QUARTER(effective_date), '-', YEAR(effective_date))
      comment: "Quarter when the resource estimate became effective"
  measures:
    - name: "total_estimates"
      expr: COUNT(1)
      comment: "Total number of resource estimates in the portfolio"
    - name: "total_resource_tonnage"
      expr: SUM(CAST(tonnage AS DOUBLE))
      comment: "Total resource tonnage across all estimates - primary asset value metric"
    - name: "avg_resource_grade"
      expr: AVG(CAST(average_grade AS DOUBLE))
      comment: "Average grade across all resource estimates"
    - name: "total_contained_metal"
      expr: SUM(CAST(contained_metal AS DOUBLE))
      comment: "Total contained metal across all resources - key value driver for project economics"
    - name: "avg_metallurgical_recovery"
      expr: AVG(CAST(metallurgical_recovery_assumption AS DOUBLE))
      comment: "Average assumed metallurgical recovery percentage - critical for economic viability assessment"
    - name: "total_drill_metres"
      expr: SUM(CAST(total_metres_drilled AS DOUBLE))
      comment: "Total metres drilled supporting resource estimates"
    - name: "avg_cutoff_grade"
      expr: AVG(CAST(cut_off_grade AS DOUBLE))
      comment: "Average cut-off grade applied across estimates"
    - name: "estimates_publicly_disclosed"
      expr: COUNT(DISTINCT CASE WHEN public_disclosure_date IS NOT NULL THEN resource_estimate_id END)
      comment: "Number of resource estimates that have been publicly disclosed - regulatory compliance metric"
    - name: "estimates_signed_off"
      expr: COUNT(DISTINCT CASE WHEN sign_off_date IS NOT NULL THEN resource_estimate_id END)
      comment: "Number of resource estimates with competent person sign-off"
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`exploration_ore_reserve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ore reserve metrics tracking economically extractable resources, mine life, and modifying factors for production planning and investment decisions"
  source: "`mining_ecm`.`exploration`.`ore_reserve`"
  dimensions:
    - name: "reserve_classification"
      expr: reserve_classification
      comment: "Reserve classification (proved, probable)"
    - name: "reserve_status"
      expr: reserve_status
      comment: "Current status of the ore reserve (active, depleted, suspended)"
    - name: "mining_method"
      expr: mining_method
      comment: "Mining method to be employed (open pit, underground, mixed)"
    - name: "reporting_standard"
      expr: reporting_standard
      comment: "Reporting code standard applied (JORC, NI 43-101, SAMREC)"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year when the ore reserve became effective"
    - name: "disclosure_year"
      expr: YEAR(disclosure_date)
      comment: "Year when the ore reserve was publicly disclosed"
    - name: "board_approval_year"
      expr: YEAR(board_sign_off_date)
      comment: "Year when the ore reserve received board approval"
  measures:
    - name: "total_reserves"
      expr: COUNT(1)
      comment: "Total number of ore reserves in the portfolio"
    - name: "total_reserve_tonnage"
      expr: SUM(CAST(reserve_tonnage AS DOUBLE))
      comment: "Total ore reserve tonnage - primary production inventory metric"
    - name: "avg_reserve_grade"
      expr: AVG(CAST(average_grade AS DOUBLE))
      comment: "Average grade across all ore reserves"
    - name: "total_contained_metal"
      expr: SUM(CAST(contained_metal AS DOUBLE))
      comment: "Total contained metal in ore reserves - key production potential metric"
    - name: "avg_life_of_mine_years"
      expr: AVG(CAST(lom_years AS DOUBLE))
      comment: "Average life of mine in years - critical for production planning and investment horizon"
    - name: "avg_strip_ratio"
      expr: AVG(CAST(strip_ratio AS DOUBLE))
      comment: "Average strip ratio for open pit reserves - key mining cost driver"
    - name: "avg_mining_recovery"
      expr: AVG(CAST(mining_recovery_factor AS DOUBLE))
      comment: "Average mining recovery factor - operational efficiency assumption"
    - name: "avg_metallurgical_recovery"
      expr: AVG(CAST(metallurgical_recovery_factor AS DOUBLE))
      comment: "Average metallurgical recovery factor - processing efficiency assumption critical for economics"
    - name: "avg_dilution_factor"
      expr: AVG(CAST(dilution_factor AS DOUBLE))
      comment: "Average dilution factor applied - mining selectivity metric"
    - name: "avg_cutoff_grade"
      expr: AVG(CAST(cut_off_grade AS DOUBLE))
      comment: "Average cut-off grade for economic extraction"
    - name: "reserves_board_approved"
      expr: COUNT(DISTINCT CASE WHEN board_sign_off_date IS NOT NULL THEN ore_reserve_id END)
      comment: "Number of reserves with board approval - governance compliance metric"
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`exploration_expenditure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Exploration expenditure tracking metrics for budget management, statutory compliance, and capital allocation decisions"
  source: "`mining_ecm`.`exploration`.`expenditure`"
  dimensions:
    - name: "expenditure_category"
      expr: expenditure_category
      comment: "Category of exploration expenditure (drilling, assay, geophysics, personnel)"
    - name: "record_type"
      expr: record_type
      comment: "Type of expenditure record (actual, accrual, commitment)"
    - name: "financial_year"
      expr: financial_year
      comment: "Financial year of the expenditure"
    - name: "financial_period"
      expr: financial_period
      comment: "Financial period (month) of the expenditure"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code of the expenditure amount"
    - name: "statutory_compliance_flag"
      expr: statutory_expenditure_compliance_flag
      comment: "Flag indicating whether expenditure meets statutory compliance requirements"
    - name: "expenditure_year"
      expr: YEAR(expenditure_date)
      comment: "Calendar year of the expenditure"
    - name: "expenditure_quarter"
      expr: CONCAT('Q', QUARTER(expenditure_date), '-', YEAR(expenditure_date))
      comment: "Quarter of the expenditure"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year when the expenditure was approved"
  measures:
    - name: "total_expenditure_records"
      expr: COUNT(1)
      comment: "Total number of expenditure records"
    - name: "total_expenditure_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total exploration expenditure amount - primary cost tracking metric"
    - name: "total_commitment_amount"
      expr: SUM(CAST(commitment_amount AS DOUBLE))
      comment: "Total committed expenditure amount - forward-looking cost obligation metric"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between planned and actual expenditure - budget control metric"
    - name: "avg_expenditure_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average expenditure amount per transaction"
    - name: "statutory_compliant_expenditure"
      expr: SUM(CASE WHEN statutory_expenditure_compliance_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total expenditure meeting statutory compliance requirements - regulatory obligation metric"
    - name: "statutory_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN statutory_expenditure_compliance_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Percentage of expenditure meeting statutory compliance - critical for licence retention"
    - name: "expenditure_with_hse_incidents"
      expr: SUM(CASE WHEN incident_id IS NOT NULL THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total expenditure associated with HSE incidents - safety cost impact metric"
    - name: "approved_expenditure_count"
      expr: COUNT(DISTINCT CASE WHEN approval_date IS NOT NULL THEN expenditure_id END)
      comment: "Number of approved expenditure records - governance compliance metric"
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`exploration_prospect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prospect portfolio metrics tracking exploration targets, resource potential, and advancement through exploration stages for investment prioritization"
  source: "`mining_ecm`.`exploration`.`prospect`"
  dimensions:
    - name: "prospect_status"
      expr: prospect_status
      comment: "Current status of the prospect (active, on-hold, relinquished, advanced)"
    - name: "exploration_stage"
      expr: exploration_stage
      comment: "Current exploration stage (grassroots, target generation, resource definition, pre-feasibility)"
    - name: "resource_classification"
      expr: resource_classification
      comment: "Resource classification if estimated (measured, indicated, inferred)"
    - name: "reserve_classification"
      expr: reserve_classification
      comment: "Reserve classification if declared (proved, probable)"
    - name: "mineralization_style"
      expr: mineralization_style
      comment: "Style of mineralization (vein, disseminated, massive sulfide, etc.)"
    - name: "geological_confidence"
      expr: geological_confidence
      comment: "Level of geological confidence (high, medium, low)"
    - name: "environmental_clearance_status"
      expr: environmental_clearance_status
      comment: "Status of environmental clearance (approved, pending, not required)"
    - name: "heritage_clearance_status"
      expr: heritage_clearance_status
      comment: "Status of heritage clearance (approved, pending, not required)"
    - name: "geological_province"
      expr: geological_province
      comment: "Geological province or terrain"
    - name: "discovery_year"
      expr: YEAR(discovery_date)
      comment: "Year when the prospect was discovered"
  measures:
    - name: "total_prospects"
      expr: COUNT(1)
      comment: "Total number of prospects in the portfolio"
    - name: "total_prospect_area"
      expr: SUM(CAST(area_hectares AS DOUBLE))
      comment: "Total area of all prospects in hectares"
    - name: "avg_prospect_area"
      expr: AVG(CAST(area_hectares AS DOUBLE))
      comment: "Average prospect area in hectares"
    - name: "total_estimated_tonnage"
      expr: SUM(CAST(estimated_tonnage_mt AS DOUBLE))
      comment: "Total estimated tonnage across all prospects in million tonnes - portfolio resource potential"
    - name: "avg_estimated_grade"
      expr: AVG(CAST(estimated_grade_percent AS DOUBLE))
      comment: "Average estimated grade across prospects - portfolio quality indicator"
    - name: "total_drill_holes"
      expr: SUM(CAST(drill_hole_count AS DOUBLE))
      comment: "Total number of drill holes across all prospects"
    - name: "total_metres_drilled"
      expr: SUM(CAST(total_meters_drilled AS DOUBLE))
      comment: "Total metres drilled across all prospects - exploration intensity metric"
    - name: "avg_metres_per_prospect"
      expr: AVG(CAST(total_meters_drilled AS DOUBLE))
      comment: "Average metres drilled per prospect - exploration effort indicator"
    - name: "prospects_with_resource_estimate"
      expr: COUNT(DISTINCT CASE WHEN last_resource_estimate_date IS NOT NULL THEN prospect_id END)
      comment: "Number of prospects with resource estimates - portfolio maturity metric"
    - name: "prospects_environmentally_cleared"
      expr: COUNT(DISTINCT CASE WHEN environmental_clearance_status = 'approved' THEN prospect_id END)
      comment: "Number of prospects with environmental clearance - permitting progress metric"
    - name: "prospects_heritage_cleared"
      expr: COUNT(DISTINCT CASE WHEN heritage_clearance_status = 'approved' THEN prospect_id END)
      comment: "Number of prospects with heritage clearance - social licence progress metric"
    - name: "avg_target_depth_range"
      expr: AVG(CAST(target_depth_max_m AS DOUBLE) - CAST(target_depth_min_m AS DOUBLE))
      comment: "Average target depth range in metres - exploration complexity indicator"
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`exploration_mineralisation_intercept`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Significant mineralisation intercept metrics tracking high-grade intersections and exploration success for prospect evaluation and market disclosure"
  source: "`mining_ecm`.`exploration`.`mineralisation_intercept`"
  dimensions:
    - name: "commodity"
      expr: commodity
      comment: "Commodity intersected (gold, copper, iron ore, lithium, etc.)"
    - name: "intercept_status"
      expr: intercept_status
      comment: "Status of the intercept (validated, pending, superseded)"
    - name: "reporting_standard"
      expr: reporting_standard
      comment: "Reporting standard applied (JORC, NI 43-101, SAMREC)"
    - name: "oxidation_state"
      expr: oxidation_state
      comment: "Oxidation state of the mineralisation (oxide, transitional, fresh)"
    - name: "geological_domain"
      expr: geological_domain
      comment: "Geological domain of the intercept"
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate the intercept (length-weighted, capped, etc.)"
    - name: "grade_unit"
      expr: grade_unit
      comment: "Unit of grade measurement (g/t, %, ppm)"
    - name: "announcement_year"
      expr: YEAR(announcement_date)
      comment: "Year when the intercept was announced"
    - name: "calculation_year"
      expr: YEAR(calculation_date)
      comment: "Year when the intercept was calculated"
  measures:
    - name: "total_intercepts"
      expr: COUNT(1)
      comment: "Total number of significant mineralisation intercepts"
    - name: "avg_composite_grade"
      expr: AVG(CAST(composite_grade AS DOUBLE))
      comment: "Average composite grade across all intercepts - exploration success quality metric"
    - name: "avg_downhole_width"
      expr: AVG(CAST(downhole_width AS DOUBLE))
      comment: "Average downhole width of intercepts in metres"
    - name: "avg_true_width"
      expr: AVG(CAST(true_width AS DOUBLE))
      comment: "Average true width of intercepts in metres - geological thickness metric"
    - name: "total_downhole_width"
      expr: SUM(CAST(downhole_width AS DOUBLE))
      comment: "Total downhole width of all intercepts - cumulative intersection metric"
    - name: "avg_cutoff_grade"
      expr: AVG(CAST(cutoff_grade AS DOUBLE))
      comment: "Average cut-off grade applied for intercept reporting"
    - name: "avg_internal_dilution"
      expr: AVG(CAST(internal_dilution AS DOUBLE))
      comment: "Average internal dilution within intercepts - mineralisation continuity metric"
    - name: "validated_intercepts"
      expr: COUNT(DISTINCT CASE WHEN validation_date IS NOT NULL THEN mineralisation_intercept_id END)
      comment: "Number of validated intercepts - data quality assurance metric"
    - name: "announced_intercepts"
      expr: COUNT(DISTINCT CASE WHEN announcement_date IS NOT NULL THEN mineralisation_intercept_id END)
      comment: "Number of publicly announced intercepts - market disclosure metric"
    - name: "grade_thickness_product"
      expr: AVG(CAST(composite_grade AS DOUBLE) * CAST(true_width AS DOUBLE))
      comment: "Average grade-thickness product - key exploration success indicator combining grade and width"
$$;
