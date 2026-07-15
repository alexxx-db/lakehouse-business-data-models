-- Metric views for domain: exploration | Business: Mining | Version: 1 | Generated on: 2026-05-05 14:14:10

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`exploration_drill_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for exploration drill programs covering budget performance, drilling progress, metreage efficiency, and program execution status. Used by exploration managers and CFOs to govern capital allocation and program delivery."
  source: "`mining_ecm`.`exploration`.`drill_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current lifecycle status of the drill program (e.g. Active, Completed, Suspended) — primary filter for operational dashboards."
    - name: "program_type"
      expr: program_type
      comment: "Classification of the drill program (e.g. Greenfields, Brownfields, Infill) — used to segment capital spend by exploration strategy."
    - name: "drilling_method"
      expr: drilling_method
      comment: "Drilling technique employed (e.g. RC, Diamond, RAB) — drives cost-per-metre benchmarking."
    - name: "expenditure_classification"
      expr: expenditure_classification
      comment: "Financial classification of program spend (e.g. CAPEX, OPEX) — required for statutory and board reporting."
    - name: "target_resource_category"
      expr: target_resource_category
      comment: "JORC/NI 43-101 resource category being targeted (e.g. Inferred, Indicated, Measured) — links drilling effort to resource confidence uplift."
    - name: "program_start_date"
      expr: DATE_TRUNC('month', program_start_date)
      comment: "Month the drill program commenced — enables trend analysis of exploration activity over time."
    - name: "program_end_date"
      expr: DATE_TRUNC('month', program_end_date)
      comment: "Month the drill program was completed or is scheduled to complete — used for portfolio timeline planning."
    - name: "sign_off_status"
      expr: sign_off_status
      comment: "Competent person sign-off status for the program — governance and regulatory compliance dimension."
    - name: "qaqc_protocol_applied"
      expr: qaqc_protocol_applied
      comment: "Boolean flag indicating whether a QAQC protocol was applied — data quality governance dimension."
    - name: "rehabilitation_completed"
      expr: rehabilitation_completed
      comment: "Boolean flag indicating whether site rehabilitation has been completed — environmental compliance dimension."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the program is currently active — used to filter live vs. historical programs."
  measures:
    - name: "total_drill_programs"
      expr: COUNT(1)
      comment: "Total number of drill programs in scope — baseline volume metric for portfolio sizing."
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved budget across all drill programs in the selected period — primary capital commitment KPI for CFO and exploration VP."
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Total actual spend incurred across drill programs — compared against approved budget to assess cost performance."
    - name: "total_planned_metreage"
      expr: SUM(CAST(planned_metreage AS DOUBLE))
      comment: "Total planned drilling metres across all programs — used to assess exploration scope and contractor capacity planning."
    - name: "total_actual_metreage"
      expr: SUM(CAST(actual_metreage AS DOUBLE))
      comment: "Total actual metres drilled across all programs — primary physical delivery KPI for exploration execution."
    - name: "avg_budget_per_program"
      expr: AVG(CAST(approved_budget_amount AS DOUBLE))
      comment: "Average approved budget per drill program — benchmarking metric for program sizing and capital efficiency."
    - name: "avg_actual_expenditure_per_program"
      expr: AVG(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Average actual expenditure per drill program — used alongside avg_budget_per_program to identify systematic over/under-spend patterns."
    - name: "avg_planned_metreage_per_program"
      expr: AVG(CAST(planned_metreage AS DOUBLE))
      comment: "Average planned metres per drill program — used to normalise program scope for cross-program comparison."
    - name: "avg_actual_metreage_per_program"
      expr: AVG(CAST(actual_metreage AS DOUBLE))
      comment: "Average actual metres drilled per program — delivery efficiency benchmark."
    - name: "programs_with_qaqc"
      expr: COUNT(CASE WHEN qaqc_protocol_applied = TRUE THEN 1 END)
      comment: "Number of drill programs where a QAQC protocol was applied — data quality governance KPI; low values signal resource estimate risk."
    - name: "programs_rehabilitation_complete"
      expr: COUNT(CASE WHEN rehabilitation_completed = TRUE THEN 1 END)
      comment: "Number of programs where site rehabilitation is confirmed complete — environmental compliance KPI tracked by HSE and regulators."
    - name: "programs_signed_off"
      expr: COUNT(CASE WHEN sign_off_status = 'Signed Off' THEN 1 END)
      comment: "Number of programs that have received competent person sign-off — governance completeness KPI for JORC/NI 43-101 compliance."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`exploration_drill_hole`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and quality KPIs for individual drill holes covering depth achievement, deviation from plan, recovery rates, and QAQC status. Used by exploration geologists and program managers to assess drilling execution quality."
  source: "`mining_ecm`.`exploration`.`drill_hole`"
  dimensions:
    - name: "hole_status"
      expr: hole_status
      comment: "Current status of the drill hole (e.g. Completed, Abandoned, In Progress) — primary operational filter."
    - name: "hole_purpose"
      expr: hole_purpose
      comment: "Purpose of the drill hole (e.g. Resource Definition, Geotechnical, Hydrogeological) — links drilling effort to exploration objective."
    - name: "drill_type"
      expr: drill_type
      comment: "Drilling technique used for the hole (e.g. RC, Diamond, RAB) — cost and quality driver."
    - name: "qaqc_status"
      expr: qaqc_status
      comment: "QAQC validation status of the drill hole data — data integrity dimension critical for resource estimation."
    - name: "target_geology"
      expr: target_geology
      comment: "Target geological unit or formation — used to segment drilling success by geological domain."
    - name: "core_diameter"
      expr: core_diameter
      comment: "Core diameter specification (e.g. HQ, NQ, PQ) — affects sample quality and metallurgical test suitability."
    - name: "survey_method"
      expr: survey_method
      comment: "Downhole survey method used — affects positional accuracy of the drill hole trace."
    - name: "start_date_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the drill hole was started — enables time-series analysis of drilling activity."
    - name: "completion_date_month"
      expr: DATE_TRUNC('month', completion_date)
      comment: "Month the drill hole was completed — used for production rate and throughput trending."
  measures:
    - name: "total_drill_holes"
      expr: COUNT(1)
      comment: "Total number of drill holes — baseline volume metric for program delivery tracking."
    - name: "total_actual_depth_m"
      expr: SUM(CAST(actual_depth AS DOUBLE))
      comment: "Total metres drilled across all holes — primary physical delivery KPI; directly linked to exploration expenditure and program progress."
    - name: "total_planned_depth_m"
      expr: SUM(CAST(planned_depth AS DOUBLE))
      comment: "Total planned metres across all holes — used as denominator for metreage achievement rate."
    - name: "avg_actual_depth_m"
      expr: AVG(CAST(actual_depth AS DOUBLE))
      comment: "Average actual depth per drill hole — used to benchmark hole depth against program design and geological targets."
    - name: "avg_planned_depth_m"
      expr: AVG(CAST(planned_depth AS DOUBLE))
      comment: "Average planned depth per drill hole — baseline for depth achievement comparison."
    - name: "avg_recovery_percentage"
      expr: AVG(CAST(recovery_percentage AS DOUBLE))
      comment: "Average core/sample recovery percentage across drill holes — critical data quality KPI; low recovery undermines resource estimation confidence."
    - name: "holes_with_full_recovery"
      expr: COUNT(CASE WHEN recovery_percentage >= 95.0 THEN 1 END)
      comment: "Number of holes achieving ≥95% recovery — high-quality sample threshold used by competent persons to validate resource estimation inputs."
    - name: "holes_abandoned"
      expr: COUNT(CASE WHEN hole_status = 'Abandoned' THEN 1 END)
      comment: "Number of abandoned drill holes — operational risk KPI; high abandonment rates signal ground conditions, equipment, or planning issues."
    - name: "holes_qaqc_passed"
      expr: COUNT(CASE WHEN qaqc_status = 'Passed' THEN 1 END)
      comment: "Number of drill holes that passed QAQC validation — data integrity KPI underpinning resource estimate reliability."
    - name: "avg_azimuth_deviation"
      expr: AVG(ABS(CAST(actual_azimuth AS DOUBLE) - CAST(planned_azimuth AS DOUBLE)))
      comment: "Average absolute deviation between actual and planned azimuth in degrees — directional drilling accuracy KPI; large deviations affect resource model geometry."
    - name: "avg_depth_deviation"
      expr: AVG(ABS(CAST(actual_depth AS DOUBLE) - CAST(planned_depth AS DOUBLE)))
      comment: "Average absolute deviation between actual and planned depth in metres — program execution accuracy KPI; persistent deviations indicate contractor performance issues."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`exploration_expenditure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial KPIs for exploration expenditure covering actual spend, commitment tracking, variance analysis, and statutory compliance. Used by CFOs, exploration finance teams, and regulatory reporting functions."
  source: "`mining_ecm`.`exploration`.`expenditure`"
  dimensions:
    - name: "expenditure_category"
      expr: expenditure_category
      comment: "Category of exploration expenditure (e.g. Drilling, Geophysics, Assaying, G&A) — primary cost breakdown dimension for budget management."
    - name: "financial_year"
      expr: financial_year
      comment: "Financial year of the expenditure — mandatory dimension for annual budget vs. actual reporting."
    - name: "financial_period"
      expr: financial_period
      comment: "Financial period (month/quarter) of the expenditure — enables intra-year spend tracking against phased budgets."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the expenditure was recorded — required for multi-currency portfolio consolidation."
    - name: "record_type"
      expr: record_type
      comment: "Type of financial record (e.g. Actual, Commitment, Accrual) — distinguishes cash spend from committed but unpaid obligations."
    - name: "statutory_expenditure_compliance_flag"
      expr: statutory_expenditure_compliance_flag
      comment: "Boolean flag indicating whether the expenditure satisfies statutory minimum spend obligations on the exploration licence — regulatory compliance dimension."
    - name: "expenditure_date_month"
      expr: DATE_TRUNC('month', expenditure_date)
      comment: "Month of expenditure — enables monthly spend run-rate analysis and cash flow forecasting."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month the expenditure was posted to the general ledger — used to reconcile accrual vs. cash timing differences."
    - name: "budget_version"
      expr: budget_version
      comment: "Budget version against which the expenditure is tracked (e.g. Original, Revised, Forecast) — enables budget revision impact analysis."
  measures:
    - name: "total_expenditure_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total actual exploration expenditure — primary financial KPI for exploration cost management and statutory reporting."
    - name: "total_commitment_amount"
      expr: SUM(CAST(commitment_amount AS DOUBLE))
      comment: "Total committed but not yet invoiced expenditure — cash flow and budget exposure KPI; critical for managing exploration programme financial risk."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between budgeted and actual expenditure — budget performance KPI; persistent positive variance triggers budget revision or programme scope change."
    - name: "avg_expenditure_per_transaction"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average expenditure per transaction — used to identify anomalous transactions and benchmark vendor invoice sizes."
    - name: "statutory_compliant_expenditure"
      expr: SUM(CASE WHEN statutory_expenditure_compliance_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total expenditure that qualifies as statutory minimum spend on exploration licences — directly used in regulatory reporting to demonstrate licence condition compliance."
    - name: "non_compliant_expenditure_count"
      expr: COUNT(CASE WHEN statutory_expenditure_compliance_flag = FALSE THEN 1 END)
      comment: "Number of expenditure records not meeting statutory compliance criteria — regulatory risk KPI; high counts may trigger licence forfeiture proceedings."
    - name: "distinct_drill_programs_with_spend"
      expr: COUNT(DISTINCT drill_program_id)
      comment: "Number of distinct drill programs with recorded expenditure — portfolio breadth KPI used to assess capital deployment across the exploration pipeline."
    - name: "distinct_licences_with_spend"
      expr: COUNT(DISTINCT licence_id)
      comment: "Number of distinct exploration licences with recorded expenditure — used to verify statutory spend obligations are being met across the licence portfolio."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`exploration_resource_estimate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for mineral resource estimates covering tonnage, grade, contained metal, and estimation confidence. Used by executives, competent persons, and investors to assess the value and quality of the exploration pipeline."
  source: "`mining_ecm`.`exploration`.`resource_estimate`"
  dimensions:
    - name: "resource_classification"
      expr: resource_classification
      comment: "JORC/NI 43-101 resource classification (Inferred, Indicated, Measured) — primary dimension for resource confidence and value hierarchy reporting."
    - name: "estimate_status"
      expr: estimate_status
      comment: "Current status of the resource estimate (e.g. Current, Superseded, Under Review) — filters active vs. historical estimates."
    - name: "estimate_type"
      expr: estimate_type
      comment: "Type of resource estimate (e.g. Global, Domain, Incremental) — used to segment estimates by scope."
    - name: "reporting_standard"
      expr: reporting_standard
      comment: "Reporting code under which the estimate was prepared (e.g. JORC 2012, NI 43-101, SAMREC) — regulatory and investor disclosure dimension."
    - name: "estimation_method"
      expr: estimation_method
      comment: "Geostatistical or estimation method used (e.g. Ordinary Kriging, Inverse Distance, Nearest Neighbour) — data quality and confidence dimension."
    - name: "estimate_confidence_level"
      expr: estimate_confidence_level
      comment: "Confidence level assigned to the estimate — used to weight resource estimates in portfolio valuation models."
    - name: "tonnage_unit"
      expr: tonnage_unit
      comment: "Unit of tonnage measurement (e.g. Mt, kt) — required for unit-consistent aggregation and reporting."
    - name: "average_grade_unit"
      expr: average_grade_unit
      comment: "Unit of grade measurement (e.g. %, g/t, ppm) — required for commodity-specific grade reporting."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the resource estimate became effective — enables time-series tracking of resource base growth."
    - name: "public_disclosure_date_month"
      expr: DATE_TRUNC('month', public_disclosure_date)
      comment: "Month the resource estimate was publicly disclosed — used for investor relations and regulatory disclosure timeline tracking."
    - name: "mining_method_assumption"
      expr: mining_method_assumption
      comment: "Mining method assumed in the resource estimate (e.g. Open Pit, Underground) — affects economic viability and modifying factors."
  measures:
    - name: "total_resource_estimates"
      expr: COUNT(1)
      comment: "Total number of resource estimates — baseline count for portfolio pipeline sizing."
    - name: "total_tonnage"
      expr: SUM(CAST(tonnage AS DOUBLE))
      comment: "Total resource tonnage across all estimates — primary volume KPI for the mineral resource inventory; directly informs mine life and project valuation."
    - name: "total_contained_metal"
      expr: SUM(CAST(contained_metal AS DOUBLE))
      comment: "Total contained metal across all resource estimates — highest-value strategic KPI; drives project NPV, reserve conversion targets, and investor reporting."
    - name: "avg_grade"
      expr: AVG(CAST(average_grade AS DOUBLE))
      comment: "Average resource grade across estimates — quality KPI; declining average grade signals ore body depletion or dilution risk."
    - name: "avg_cut_off_grade"
      expr: AVG(CAST(cut_off_grade AS DOUBLE))
      comment: "Average cut-off grade applied across resource estimates — economic sensitivity KPI; rising cut-off grades reduce mineable tonnage."
    - name: "avg_metallurgical_recovery_assumption"
      expr: AVG(CAST(metallurgical_recovery_assumption AS DOUBLE))
      comment: "Average metallurgical recovery assumption used in resource estimates — process efficiency input KPI; lower recovery reduces contained metal value."
    - name: "avg_total_metres_drilled"
      expr: AVG(CAST(total_metres_drilled AS DOUBLE))
      comment: "Average metres drilled per resource estimate — data density KPI; higher metres per estimate indicates greater geological confidence."
    - name: "total_metres_drilled"
      expr: SUM(CAST(total_metres_drilled AS DOUBLE))
      comment: "Total metres drilled supporting resource estimates — cumulative exploration investment KPI linking drilling effort to resource base growth."
    - name: "estimates_publicly_disclosed"
      expr: COUNT(CASE WHEN public_disclosure_date IS NOT NULL THEN 1 END)
      comment: "Number of resource estimates that have been publicly disclosed — investor relations and regulatory compliance KPI."
    - name: "distinct_prospects_with_estimates"
      expr: COUNT(DISTINCT prospect_id)
      comment: "Number of distinct prospects with at least one resource estimate — exploration pipeline breadth KPI used in portfolio reviews."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`exploration_ore_reserve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Board-level KPIs for ore reserves covering reserve tonnage, grade, contained metal, mine life, and modifying factors. Used by executives, boards, and investors for strategic mine planning, asset valuation, and JORC/NI 43-101 public reporting."
  source: "`mining_ecm`.`exploration`.`ore_reserve`"
  dimensions:
    - name: "reserve_classification"
      expr: reserve_classification
      comment: "JORC/NI 43-101 reserve classification (Proved, Probable) — primary dimension for reserve confidence and regulatory disclosure."
    - name: "reserve_status"
      expr: reserve_status
      comment: "Current status of the ore reserve (e.g. Current, Superseded, Under Review) — filters active vs. historical reserve declarations."
    - name: "mining_method"
      expr: mining_method
      comment: "Mining method applied in the reserve estimate (e.g. Open Pit, Underground) — drives strip ratio, cost, and mine design assumptions."
    - name: "reporting_standard"
      expr: reporting_standard
      comment: "Reporting code under which the reserve was declared (e.g. JORC 2012, NI 43-101) — regulatory and investor disclosure dimension."
    - name: "reserve_tonnage_unit"
      expr: reserve_tonnage_unit
      comment: "Unit of reserve tonnage (e.g. Mt, kt) — required for unit-consistent aggregation."
    - name: "average_grade_unit"
      expr: average_grade_unit
      comment: "Unit of grade measurement (e.g. %, g/t, ppm) — required for commodity-specific grade reporting."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the ore reserve became effective — enables time-series tracking of reserve base changes."
    - name: "disclosure_date_month"
      expr: DATE_TRUNC('month', disclosure_date)
      comment: "Month the ore reserve was publicly disclosed — investor relations and regulatory timeline dimension."
    - name: "modifying_factors_applied"
      expr: modifying_factors_applied
      comment: "Description of modifying factors applied to convert resources to reserves — governance and competent person sign-off dimension."
  measures:
    - name: "total_reserve_tonnage"
      expr: SUM(CAST(reserve_tonnage AS DOUBLE))
      comment: "Total ore reserve tonnage — the single most important strategic KPI for a mining company; directly determines mine life, production planning, and asset valuation."
    - name: "total_contained_metal"
      expr: SUM(CAST(contained_metal AS DOUBLE))
      comment: "Total contained metal in ore reserves — primary value KPI for investor reporting, project financing, and M&A valuation."
    - name: "avg_reserve_grade"
      expr: AVG(CAST(average_grade AS DOUBLE))
      comment: "Average ore reserve grade — quality KPI; declining grade signals ore body depletion and rising processing costs per unit of metal."
    - name: "avg_cut_off_grade"
      expr: AVG(CAST(cut_off_grade AS DOUBLE))
      comment: "Average cut-off grade applied across reserve estimates — economic sensitivity KPI; rising cut-off grades reduce mineable tonnage and mine life."
    - name: "avg_strip_ratio"
      expr: AVG(CAST(strip_ratio AS DOUBLE))
      comment: "Average strip ratio across open pit reserves — mining cost efficiency KPI; higher strip ratios increase waste movement costs and reduce project economics."
    - name: "avg_lom_years"
      expr: AVG(CAST(lom_years AS DOUBLE))
      comment: "Average life-of-mine years across reserve estimates — strategic longevity KPI used by boards and investors to assess asset sustainability."
    - name: "avg_metallurgical_recovery_factor"
      expr: AVG(CAST(metallurgical_recovery_factor AS DOUBLE))
      comment: "Average metallurgical recovery factor applied in reserve estimates — process efficiency KPI; lower recovery reduces payable metal and project revenue."
    - name: "avg_mining_recovery_factor"
      expr: AVG(CAST(mining_recovery_factor AS DOUBLE))
      comment: "Average mining recovery factor — operational efficiency KPI; lower mining recovery increases ore loss and reduces reserve utilisation."
    - name: "avg_dilution_factor"
      expr: AVG(CAST(dilution_factor AS DOUBLE))
      comment: "Average dilution factor applied in reserve estimates — ore quality KPI; high dilution degrades head grade and increases processing costs."
    - name: "distinct_prospects_with_reserves"
      expr: COUNT(DISTINCT prospect_id)
      comment: "Number of distinct prospects with declared ore reserves — portfolio maturity KPI; indicates how many exploration targets have been converted to economic reserves."
    - name: "total_reserve_declarations"
      expr: COUNT(1)
      comment: "Total number of ore reserve declarations — portfolio breadth KPI for board and investor reporting."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`exploration_prospect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Portfolio-level KPIs for exploration prospects covering area, estimated tonnage, grade, drilling intensity, and stage progression. Used by exploration VPs and portfolio managers to prioritise capital allocation across the exploration pipeline."
  source: "`mining_ecm`.`exploration`.`prospect`"
  dimensions:
    - name: "prospect_status"
      expr: prospect_status
      comment: "Current status of the prospect (e.g. Active, Dormant, Closed) — primary filter for active portfolio management."
    - name: "exploration_stage"
      expr: exploration_stage
      comment: "Stage of exploration maturity (e.g. Grassroots, Advanced, Pre-Feasibility) — pipeline stage dimension for capital allocation decisions."
    - name: "resource_classification"
      expr: resource_classification
      comment: "Highest resource classification achieved at the prospect (e.g. Inferred, Indicated, Measured) — value maturity dimension."
    - name: "reserve_classification"
      expr: reserve_classification
      comment: "Highest reserve classification achieved at the prospect (e.g. Proved, Probable) — economic conversion dimension."
    - name: "geological_confidence"
      expr: geological_confidence
      comment: "Geological confidence level assigned to the prospect — risk dimension for capital prioritisation."
    - name: "mineralization_style"
      expr: mineralization_style
      comment: "Style of mineralisation at the prospect (e.g. Porphyry, IOCG, Skarn) — geological targeting dimension."
    - name: "geological_province"
      expr: geological_province
      comment: "Geological province or terrane in which the prospect is located — regional exploration strategy dimension."
    - name: "environmental_clearance_status"
      expr: environmental_clearance_status
      comment: "Environmental clearance status — regulatory risk dimension; prospects without clearance cannot proceed to drilling."
    - name: "discovery_date_year"
      expr: DATE_TRUNC('year', discovery_date)
      comment: "Year of prospect discovery — enables vintage analysis of the exploration portfolio."
    - name: "last_drill_date_month"
      expr: DATE_TRUNC('month', last_drill_date)
      comment: "Month of most recent drilling activity — used to identify stale prospects requiring re-evaluation."
  measures:
    - name: "total_prospects"
      expr: COUNT(1)
      comment: "Total number of prospects in the portfolio — pipeline size KPI for exploration strategy reviews."
    - name: "total_area_hectares"
      expr: SUM(CAST(area_hectares AS DOUBLE))
      comment: "Total land area covered by exploration prospects in hectares — portfolio footprint KPI used in licence and land access planning."
    - name: "total_estimated_tonnage_mt"
      expr: SUM(CAST(estimated_tonnage_mt AS DOUBLE))
      comment: "Total estimated resource tonnage across all prospects in Mt — strategic pipeline value KPI used in portfolio reviews and investor presentations."
    - name: "avg_estimated_grade_percent"
      expr: AVG(CAST(estimated_grade_percent AS DOUBLE))
      comment: "Average estimated grade across prospects — portfolio quality KPI; declining average grade signals need for higher-grade target generation."
    - name: "total_metres_drilled"
      expr: SUM(CAST(total_meters_drilled AS DOUBLE))
      comment: "Total metres drilled across all prospects — cumulative exploration investment KPI linking drilling effort to prospect advancement."
    - name: "avg_metres_drilled_per_prospect"
      expr: AVG(CAST(total_meters_drilled AS DOUBLE))
      comment: "Average metres drilled per prospect — exploration intensity KPI; low values on advanced-stage prospects may indicate under-investment."
    - name: "avg_target_depth_max_m"
      expr: AVG(CAST(target_depth_max_m AS DOUBLE))
      comment: "Average maximum target depth across prospects — exploration risk and cost driver; deeper targets require more expensive drilling programmes."
    - name: "prospects_with_environmental_clearance"
      expr: COUNT(CASE WHEN environmental_clearance_status = 'Approved' THEN 1 END)
      comment: "Number of prospects with approved environmental clearance — regulatory readiness KPI; directly determines which prospects can proceed to active drilling."
    - name: "avg_cutoff_grade_percent"
      expr: AVG(CAST(cutoff_grade_percent AS DOUBLE))
      comment: "Average cut-off grade applied across prospects — economic threshold KPI; rising cut-off grades reduce the economic resource base."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`exploration_sample`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sample quality and throughput KPIs for exploration samples covering recovery, weight, depth intervals, and QAQC status. Used by exploration geologists and laboratory managers to ensure sample data integrity underpinning resource estimates."
  source: "`mining_ecm`.`exploration`.`exploration_sample`"
  dimensions:
    - name: "sample_type"
      expr: sample_type
      comment: "Type of exploration sample (e.g. Core, RC Chips, Soil, Rock Chip) — primary dimension for sample quality and analytical method selection."
    - name: "sample_status"
      expr: sample_status
      comment: "Current status of the sample (e.g. Dispatched, Received, Analysed, Rejected) — workflow tracking dimension for laboratory turnaround management."
    - name: "qaqc_type"
      expr: qaqc_type
      comment: "Type of QAQC material (e.g. Standard, Blank, Duplicate, Field Duplicate) — data quality governance dimension for resource estimation compliance."
    - name: "collection_method"
      expr: collection_method
      comment: "Method used to collect the sample (e.g. Spear, Riffle Split, Whole Core) — affects sample representativeness and analytical bias."
    - name: "lithology_code"
      expr: lithology_code
      comment: "Lithological unit from which the sample was collected — geological domain dimension for grade distribution analysis."
    - name: "chain_of_custody_status"
      expr: chain_of_custody_status
      comment: "Chain of custody status of the sample — regulatory and data integrity dimension; broken chain of custody invalidates analytical results."
    - name: "is_composite"
      expr: is_composite
      comment: "Boolean flag indicating whether the sample is a composite — affects analytical representativeness and resource estimation weighting."
    - name: "collection_date_month"
      expr: DATE_TRUNC('month', collection_date)
      comment: "Month of sample collection — enables time-series analysis of sampling activity and laboratory throughput."
    - name: "dispatch_date_month"
      expr: DATE_TRUNC('month', dispatch_date)
      comment: "Month samples were dispatched to the laboratory — used to track laboratory turnaround time and identify backlogs."
  measures:
    - name: "total_samples"
      expr: COUNT(1)
      comment: "Total number of exploration samples — baseline throughput KPI for laboratory and field operations management."
    - name: "total_sample_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of samples collected in kilograms — laboratory capacity planning KPI; large total weights may indicate preparation bottlenecks."
    - name: "avg_sample_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average sample weight in kilograms — sample representativeness KPI; very low average weights may indicate insufficient material for reliable analysis."
    - name: "avg_recovery_percent"
      expr: AVG(CAST(recovery_percent AS DOUBLE))
      comment: "Average sample recovery percentage — critical data quality KPI; low recovery rates compromise grade estimation and resource model reliability."
    - name: "total_interval_length_m"
      expr: SUM(CAST(length_m AS DOUBLE))
      comment: "Total sampled interval length in metres — exploration coverage KPI linking sample density to geological model confidence."
    - name: "avg_interval_length_m"
      expr: AVG(CAST(length_m AS DOUBLE))
      comment: "Average sample interval length in metres — compositing and resolution KPI; very long intervals may mask high-grade zones."
    - name: "samples_with_full_recovery"
      expr: COUNT(CASE WHEN recovery_percent >= 95.0 THEN 1 END)
      comment: "Number of samples with ≥95% recovery — high-quality sample count KPI used by competent persons to assess resource estimation data sufficiency."
    - name: "distinct_drill_holes_sampled"
      expr: COUNT(DISTINCT drill_hole_id)
      comment: "Number of distinct drill holes with samples collected — spatial coverage KPI for resource model data density assessment."
    - name: "qaqc_sample_count"
      expr: COUNT(CASE WHEN qaqc_type IS NOT NULL THEN 1 END)
      comment: "Number of QAQC samples (standards, blanks, duplicates) submitted — data quality governance KPI; JORC requires minimum QAQC insertion rates."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`exploration_licence`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Licence portfolio KPIs covering area, financial obligations, renewal status, and compliance flags. Used by exploration managers, legal teams, and regulatory affairs to manage the exploration licence portfolio and avoid forfeiture."
  source: "`mining_ecm`.`exploration`.`licence`"
  dimensions:
    - name: "commodity_rights"
      expr: commodity_rights
      comment: "Commodities covered by the exploration licence — used to segment the licence portfolio by target commodity."
    - name: "joint_venture_flag"
      expr: joint_venture_flag
      comment: "Boolean flag indicating whether the licence is held under a joint venture — ownership structure dimension for portfolio management."
    - name: "renewal_eligibility_flag"
      expr: renewal_eligibility_flag
      comment: "Boolean flag indicating whether the licence is eligible for renewal — regulatory risk dimension; ineligible licences face imminent expiry."
    - name: "environmental_approval_required_flag"
      expr: environmental_approval_required_flag
      comment: "Boolean flag indicating whether environmental approval is required before exploration can commence — regulatory readiness dimension."
    - name: "heritage_site_flag"
      expr: heritage_site_flag
      comment: "Boolean flag indicating whether the licence area contains a heritage site — access restriction and compliance risk dimension."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of statutory reporting required for the licence (e.g. Annual, Quarterly) — compliance workload dimension."
    - name: "next_reporting_due_date_month"
      expr: DATE_TRUNC('month', next_reporting_due_date)
      comment: "Month the next statutory report is due — compliance deadline dimension used to prioritise regulatory submissions."
    - name: "last_renewal_date_year"
      expr: DATE_TRUNC('year', last_renewal_date)
      comment: "Year of last licence renewal — used to identify licences approaching maximum renewal limits."
  measures:
    - name: "total_licences"
      expr: COUNT(1)
      comment: "Total number of exploration licences in the portfolio — baseline portfolio size KPI."
    - name: "total_licence_area_km2"
      expr: SUM(CAST(area_square_km AS DOUBLE))
      comment: "Total area covered by exploration licences in square kilometres — portfolio footprint KPI used in strategic land position reporting."
    - name: "total_annual_rent_fee"
      expr: SUM(CAST(annual_rent_fee AS DOUBLE))
      comment: "Total annual rent fees payable across the licence portfolio — recurring financial obligation KPI for budget planning."
    - name: "total_security_bond_amount"
      expr: SUM(CAST(security_bond_amount AS DOUBLE))
      comment: "Total security bonds lodged across the licence portfolio — financial exposure KPI; large bond totals represent locked capital."
    - name: "total_min_expenditure_commitment_year_1"
      expr: SUM(CAST(minimum_expenditure_commitment_year_1 AS DOUBLE))
      comment: "Total minimum statutory expenditure commitment for Year 1 across all licences — regulatory obligation KPI used to validate exploration budget adequacy."
    - name: "total_min_expenditure_commitment_year_2"
      expr: SUM(CAST(minimum_expenditure_commitment_year_2 AS DOUBLE))
      comment: "Total minimum statutory expenditure commitment for Year 2 across all licences — forward regulatory obligation KPI for multi-year budget planning."
    - name: "licences_eligible_for_renewal"
      expr: COUNT(CASE WHEN renewal_eligibility_flag = TRUE THEN 1 END)
      comment: "Number of licences eligible for renewal — portfolio continuity KPI; declining count signals increasing licence attrition risk."
    - name: "licences_with_heritage_constraints"
      expr: COUNT(CASE WHEN heritage_site_flag = TRUE THEN 1 END)
      comment: "Number of licences with heritage site constraints — access risk KPI; heritage constraints can delay or prevent exploration activities."
    - name: "avg_licence_area_km2"
      expr: AVG(CAST(area_square_km AS DOUBLE))
      comment: "Average licence area in square kilometres — portfolio composition KPI used to benchmark licence sizes against industry norms."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`exploration_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Geophysical and geochemical survey KPIs covering coverage area, anomaly detection, line kilometres, and processing status. Used by exploration geologists and program managers to assess survey quality and target generation effectiveness."
  source: "`mining_ecm`.`exploration`.`survey`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Type of exploration survey (e.g. Airborne Magnetics, IP, Soil Geochemistry, Seismic) — primary dimension for survey method benchmarking."
    - name: "survey_method"
      expr: survey_method
      comment: "Specific survey method or technique used — detailed technical dimension for data quality and cost benchmarking."
    - name: "processing_status"
      expr: processing_status
      comment: "Data processing status of the survey (e.g. Raw, Processed, Interpreted) — workflow tracking dimension for exploration data readiness."
    - name: "interpretation_status"
      expr: interpretation_status
      comment: "Geological interpretation status of the survey (e.g. Pending, In Progress, Complete) — target generation readiness dimension."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the survey is currently active — filters live vs. historical surveys."
    - name: "acquisition_start_date_month"
      expr: DATE_TRUNC('month', acquisition_start_date)
      comment: "Month survey data acquisition commenced — enables time-series analysis of exploration survey activity."
    - name: "acquisition_end_date_month"
      expr: DATE_TRUNC('month', acquisition_end_date)
      comment: "Month survey data acquisition was completed — used for survey duration and throughput analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which survey costs are denominated — required for multi-currency portfolio cost consolidation."
  measures:
    - name: "total_surveys"
      expr: COUNT(1)
      comment: "Total number of exploration surveys — baseline portfolio activity KPI."
    - name: "total_survey_area_km2"
      expr: SUM(CAST(area_km2 AS DOUBLE))
      comment: "Total area covered by exploration surveys in square kilometres — exploration coverage KPI used to assess geological knowledge density across the licence portfolio."
    - name: "total_line_km"
      expr: SUM(CAST(total_line_km AS DOUBLE))
      comment: "Total survey line kilometres acquired — primary physical delivery KPI for geophysical survey programmes; directly linked to survey cost and coverage."
    - name: "avg_line_spacing_m"
      expr: AVG(CAST(line_spacing_m AS DOUBLE))
      comment: "Average line spacing in metres across surveys — resolution KPI; tighter line spacing improves anomaly detection but increases cost."
    - name: "avg_grid_spacing_m"
      expr: AVG(CAST(grid_spacing_m AS DOUBLE))
      comment: "Average grid spacing in metres — data density KPI for geochemical surveys; finer grids improve target definition."
    - name: "avg_sample_interval_m"
      expr: AVG(CAST(sample_interval_m AS DOUBLE))
      comment: "Average sample interval in metres — data resolution KPI; shorter intervals improve anomaly detection sensitivity."
    - name: "surveys_fully_interpreted"
      expr: COUNT(CASE WHEN interpretation_status = 'Complete' THEN 1 END)
      comment: "Number of surveys with completed geological interpretation — target generation readiness KPI; uninterpreted surveys represent latent exploration value."
    - name: "distinct_prospects_surveyed"
      expr: COUNT(DISTINCT prospect_id)
      comment: "Number of distinct prospects covered by surveys — exploration coverage KPI used to identify prospects lacking geophysical data."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`exploration_drill_hole_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Downhole survey quality KPIs covering positional accuracy, deviation from planned trajectory, and survey instrument performance. Used by exploration geologists and surveyors to validate drill hole geometry for resource model inputs."
  source: "`mining_ecm`.`exploration`.`drill_hole_survey`"
  dimensions:
    - name: "survey_status"
      expr: survey_status
      comment: "Status of the downhole survey (e.g. Validated, Pending, Rejected) — data quality governance dimension."
    - name: "survey_instrument_type"
      expr: survey_instrument_type
      comment: "Type of downhole survey instrument used (e.g. Gyroscope, Magnetic, Accelerometer) — instrument accuracy dimension affecting positional confidence."
    - name: "survey_method"
      expr: survey_method
      comment: "Survey method employed (e.g. Single Shot, Multi Shot, Continuous) — data density and accuracy dimension."
    - name: "survey_quality_code"
      expr: survey_quality_code
      comment: "Quality code assigned to the survey run — data integrity dimension used to filter high-confidence survey data for resource modelling."
    - name: "coordinate_system"
      expr: coordinate_system
      comment: "Coordinate reference system used for survey calculations — spatial data governance dimension."
    - name: "survey_date_month"
      expr: DATE_TRUNC('month', survey_date)
      comment: "Month the downhole survey was conducted — enables time-series analysis of survey activity and instrument utilisation."
    - name: "data_source"
      expr: data_source
      comment: "Source of the survey data (e.g. Contractor, In-House) — data provenance dimension for audit and quality management."
  measures:
    - name: "total_survey_runs"
      expr: COUNT(1)
      comment: "Total number of downhole survey runs — baseline activity KPI for survey programme management."
    - name: "avg_deviation_from_planned"
      expr: AVG(CAST(deviation_from_planned AS DOUBLE))
      comment: "Average deviation from planned drill hole trajectory — directional drilling accuracy KPI; large deviations compromise resource model geometry and require re-survey."
    - name: "max_deviation_from_planned"
      expr: MAX(CAST(deviation_from_planned AS DOUBLE))
      comment: "Maximum deviation from planned trajectory across all survey runs — worst-case positional error KPI used to flag holes requiring re-drilling or model adjustment."
    - name: "avg_survey_depth_m"
      expr: AVG(CAST(survey_depth AS DOUBLE))
      comment: "Average depth at which downhole surveys were conducted — coverage depth KPI; surveys should extend to the full depth of mineralisation."
    - name: "avg_temperature_at_survey"
      expr: AVG(CAST(temperature_at_survey AS DOUBLE))
      comment: "Average temperature recorded at survey depth — instrument calibration KPI; extreme temperatures affect magnetic instrument accuracy."
    - name: "distinct_holes_surveyed"
      expr: COUNT(DISTINCT drill_hole_id)
      comment: "Number of distinct drill holes with downhole surveys — survey coverage KPI; holes without surveys cannot be reliably used in resource models."
    - name: "surveys_validated"
      expr: COUNT(CASE WHEN survey_status = 'Validated' THEN 1 END)
      comment: "Number of survey runs that have been validated — data readiness KPI for resource model input; unvalidated surveys block resource estimation workflows."
$$;
