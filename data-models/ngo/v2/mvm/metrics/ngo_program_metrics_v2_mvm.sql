-- Metric views for domain: program | Business: Ngo | Version: 2 | Generated on: 2026-07-10 20:18:10

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic program portfolio metrics providing executive visibility into program health, budget scale, multi-year and emergency footprint, and lifecycle status distribution across the NGO program portfolio."
  source: "`vibe_ngo_v1`.`program`.`program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Lifecycle status of the program (e.g., Active, Closed, Pipeline) — primary filter for portfolio health dashboards."
    - name: "program_type"
      expr: program_type
      comment: "Classification of the program type (e.g., Humanitarian, Development, Resilience) for portfolio segmentation."
    - name: "sector_name"
      expr: sector_name
      comment: "Sector under which the program operates (e.g., Health, WASH, Education) for sector-level portfolio analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the program for regional portfolio breakdown."
    - name: "country_code"
      expr: country_code
      comment: "ISO country code for country-level program distribution analysis."
    - name: "is_emergency"
      expr: is_emergency
      comment: "Flag indicating whether the program is an emergency response program — critical for humanitarian vs. development split."
    - name: "is_multi_year"
      expr: is_multi_year
      comment: "Flag indicating multi-year programs, relevant for long-term funding and planning analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the program (e.g., Low, Medium, High) for risk-weighted portfolio views."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG goal(s) the program is aligned to, enabling SDG contribution reporting."
    - name: "program_start_year"
      expr: YEAR(start_date)
      comment: "Year the program started, used for cohort and vintage analysis of the program portfolio."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the program, used for regulatory and donor reporting oversight."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the program (e.g., National, Sub-national, Regional) for coverage analysis."
  measures:
    - name: "total_programs"
      expr: COUNT(DISTINCT program_id)
      comment: "Total number of distinct programs in the portfolio. Baseline KPI for portfolio size and growth tracking."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total approved budget across all programs. Primary financial scale indicator for the program portfolio."
    - name: "avg_program_budget"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per program. Indicates typical program investment size and helps identify outliers."
    - name: "active_program_count"
      expr: COUNT(DISTINCT CASE WHEN program_status = 'Active' THEN program_id END)
      comment: "Number of currently active programs. Core operational KPI for portfolio health monitoring."
    - name: "emergency_program_count"
      expr: COUNT(DISTINCT CASE WHEN is_emergency = TRUE THEN program_id END)
      comment: "Number of emergency response programs. Critical for humanitarian portfolio tracking and surge capacity planning."
    - name: "multi_year_program_count"
      expr: COUNT(DISTINCT CASE WHEN is_multi_year = TRUE THEN program_id END)
      comment: "Number of multi-year programs. Indicates long-term funding commitments and strategic program depth."
    - name: "high_risk_program_count"
      expr: COUNT(DISTINCT CASE WHEN risk_rating = 'High' THEN program_id END)
      comment: "Number of programs rated high risk. Triggers executive attention and risk mitigation resource allocation."
    - name: "total_budget_emergency_programs"
      expr: SUM(CASE WHEN is_emergency = TRUE THEN CAST(budget_amount AS DOUBLE) ELSE 0 END)
      comment: "Total budget allocated to emergency programs. Measures humanitarian financial exposure vs. development investment."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_intervention`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intervention-level metrics tracking the operational and financial performance of program interventions, including budget scale, compliance with humanitarian standards, and lifecycle status distribution."
  source: "`vibe_ngo_v1`.`program`.`intervention`"
  dimensions:
    - name: "intervention_status"
      expr: intervention_status
      comment: "Current lifecycle status of the intervention (e.g., Active, Completed, Cancelled)."
    - name: "intervention_type"
      expr: intervention_type
      comment: "Type of intervention (e.g., Direct Service, Capacity Building, Advocacy) for portfolio segmentation."
    - name: "sector"
      expr: sector
      comment: "Sector of the intervention (e.g., Health, Nutrition, Protection) for sector-level analysis."
    - name: "sub_sector"
      expr: sub_sector
      comment: "Sub-sector classification for granular sector performance analysis."
    - name: "phase"
      expr: phase
      comment: "Implementation phase of the intervention (e.g., Design, Implementation, Closeout)."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the intervention for coverage and reach analysis."
    - name: "gender_marker_score"
      expr: gender_marker_score
      comment: "Gender marker score assigned to the intervention — key for gender-responsive programming compliance reporting."
    - name: "sdg_goal_primary"
      expr: sdg_goal_primary
      comment: "Primary SDG goal the intervention contributes to, for SDG portfolio reporting."
    - name: "chs_compliant"
      expr: chs_compliant
      comment: "Whether the intervention is compliant with Core Humanitarian Standards — critical for quality assurance reporting."
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year the intervention was planned to start, for cohort and pipeline analysis."
    - name: "disability_inclusion_marker_score"
      expr: disability_inclusion_marker_score
      comment: "Disability inclusion marker score for inclusion-mainstreaming compliance tracking."
  measures:
    - name: "total_interventions"
      expr: COUNT(DISTINCT intervention_id)
      comment: "Total number of distinct interventions. Baseline measure for operational portfolio breadth."
    - name: "total_intervention_budget"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total budget committed across all interventions. Primary financial scale KPI for intervention portfolio."
    - name: "avg_intervention_budget"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average budget per intervention. Benchmarks typical intervention investment and flags outliers."
    - name: "active_intervention_count"
      expr: COUNT(DISTINCT CASE WHEN intervention_status = 'Active' THEN intervention_id END)
      comment: "Number of currently active interventions. Core operational health KPI."
    - name: "chs_compliant_intervention_count"
      expr: COUNT(DISTINCT CASE WHEN chs_compliant = TRUE THEN intervention_id END)
      comment: "Number of interventions meeting Core Humanitarian Standards. Drives quality assurance and donor confidence."
    - name: "do_no_harm_assessed_count"
      expr: COUNT(DISTINCT CASE WHEN do_no_harm_assessment_completed = TRUE THEN intervention_id END)
      comment: "Number of interventions with completed Do No Harm assessments. Critical safeguarding compliance KPI."
    - name: "safeguarding_applied_count"
      expr: COUNT(DISTINCT CASE WHEN safeguarding_policy_applied = TRUE THEN intervention_id END)
      comment: "Number of interventions with safeguarding policy applied. Regulatory and donor compliance indicator."
    - name: "total_budget_active_interventions"
      expr: SUM(CASE WHEN intervention_status = 'Active' THEN CAST(total_budget_amount AS DOUBLE) ELSE 0 END)
      comment: "Total budget committed to currently active interventions. Measures live financial exposure."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_budget_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget plan metrics providing financial governance visibility into approved budgets, cost structure breakdown, indirect cost rates, and cost-sharing across programs and interventions."
  source: "`vibe_ngo_v1`.`program`.`budget_plan`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Approval and lifecycle status of the budget plan (e.g., Draft, Approved, Revised)."
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget plan (e.g., Original, Revised, Supplemental) for version and amendment tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget plan for multi-currency portfolio analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code for donor-aligned sector reporting."
    - name: "budget_period_start_year"
      expr: YEAR(budget_period_start_date)
      comment: "Year the budget period starts, for annual budget cycle analysis."
    - name: "budget_owner"
      expr: budget_owner
      comment: "Owner responsible for the budget plan, for accountability and governance reporting."
    - name: "sector_classification"
      expr: sector_classification
      comment: "Sector classification of the budget plan for cross-sector financial analysis."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the budget plan for SDG-tagged financial reporting."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_budget_amount AS DOUBLE))
      comment: "Total approved budget across all budget plans. Primary financial governance KPI for resource allocation oversight."
    - name: "total_direct_costs"
      expr: SUM(CAST(total_direct_costs AS DOUBLE))
      comment: "Total direct costs across budget plans. Measures programmatic spend directly attributable to activities."
    - name: "total_indirect_costs"
      expr: SUM(CAST(indirect_costs AS DOUBLE))
      comment: "Total indirect/overhead costs. Tracks organizational overhead burden against direct program spend."
    - name: "total_personnel_costs"
      expr: SUM(CAST(personnel_costs AS DOUBLE))
      comment: "Total personnel costs across budget plans. Largest cost driver in most NGO budgets — critical for workforce planning."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-sharing contributions. Measures leverage of donor funds through co-financing arrangements."
    - name: "total_travel_costs"
      expr: SUM(CAST(travel_costs AS DOUBLE))
      comment: "Total travel costs across budget plans. Monitored for efficiency and donor compliance on allowable costs."
    - name: "total_equipment_costs"
      expr: SUM(CAST(equipment_costs AS DOUBLE))
      comment: "Total equipment costs. Tracked for asset management and donor prior-approval compliance."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate across budget plans. Benchmarks overhead efficiency against negotiated rates."
    - name: "budget_plan_count"
      expr: COUNT(DISTINCT budget_plan_id)
      comment: "Total number of budget plans. Baseline measure for budget governance workload and amendment frequency."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_budget_plan_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget line-level metrics enabling granular cost category analysis, cost-sharing tracking, and unit cost benchmarking to support financial management and donor compliance reporting."
  source: "`vibe_ngo_v1`.`program`.`budget_plan_line`"
  dimensions:
    - name: "cost_category"
      expr: cost_category
      comment: "High-level cost category (e.g., Personnel, Travel, Supplies) for cost structure analysis."
    - name: "cost_subcategory"
      expr: cost_subcategory
      comment: "Granular cost sub-category for detailed budget line analysis."
    - name: "budget_plan_line_status"
      expr: budget_plan_line_status
      comment: "Status of the budget line (e.g., Active, Cancelled, Revised) for budget governance tracking."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget line for annual financial planning and reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget line for multi-currency financial analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code for donor-aligned sector-level cost reporting."
    - name: "direct_cost_flag"
      expr: direct_cost_flag
      comment: "Indicates whether the line item is a direct cost — critical for direct vs. indirect cost ratio analysis."
    - name: "allowable_cost_flag"
      expr: allowable_cost_flag
      comment: "Indicates whether the cost is allowable under the grant — key for donor compliance monitoring."
    - name: "cost_sharing_flag"
      expr: cost_sharing_flag
      comment: "Indicates whether the line item involves cost sharing — for co-financing leverage analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the budget line item, enabling unit cost benchmarking."
  measures:
    - name: "total_planned_amount"
      expr: SUM(CAST(total_planned_amount AS DOUBLE))
      comment: "Total planned budget amount across all budget lines. Primary financial planning KPI at line-item granularity."
    - name: "total_cost_sharing_amount"
      expr: SUM(CAST(cost_sharing_amount AS DOUBLE))
      comment: "Total cost-sharing contributions at line level. Measures co-financing leverage per cost category."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across budget lines. Enables cost benchmarking and efficiency analysis by activity type."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of units planned across budget lines. Supports output volume planning and unit cost validation."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate at line level. Monitors overhead application consistency across budget lines."
    - name: "direct_cost_line_count"
      expr: COUNT(DISTINCT CASE WHEN direct_cost_flag = TRUE THEN budget_plan_line_id END)
      comment: "Number of direct cost budget lines. Baseline for direct cost portfolio breadth and donor reporting."
    - name: "cost_sharing_line_count"
      expr: COUNT(DISTINCT CASE WHEN cost_sharing_flag = TRUE THEN budget_plan_line_id END)
      comment: "Number of budget lines with cost-sharing arrangements. Tracks co-financing depth across the budget."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_implementation_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Implementation plan metrics tracking operational planning quality, budget allocation, risk exposure, and planning coverage across programs and interventions."
  source: "`vibe_ngo_v1`.`program`.`implementation_plan`"
  dimensions:
    - name: "implementation_plan_status"
      expr: implementation_plan_status
      comment: "Lifecycle status of the implementation plan (e.g., Draft, Approved, Active, Closed)."
    - name: "implementation_plan_type"
      expr: implementation_plan_type
      comment: "Type of implementation plan (e.g., Annual, Multi-Year, Emergency) for planning cycle analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the implementation plan for risk-weighted operational oversight."
    - name: "sector_classification"
      expr: sector_classification
      comment: "Sector classification of the implementation plan for sector-level operational analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code for donor-aligned implementation reporting."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the implementation plan for coverage analysis."
    - name: "planning_period_start_year"
      expr: YEAR(planning_period_start_date)
      comment: "Year the planning period starts, for annual operational planning cycle analysis."
    - name: "responsible_unit"
      expr: responsible_unit
      comment: "Organizational unit responsible for the implementation plan — for accountability and workload analysis."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of reporting for the implementation plan (e.g., Monthly, Quarterly) for reporting burden analysis."
  measures:
    - name: "total_implementation_plans"
      expr: COUNT(DISTINCT implementation_plan_id)
      comment: "Total number of implementation plans. Baseline KPI for operational planning coverage."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated across implementation plans. Measures financial commitment to operational delivery."
    - name: "avg_budget_allocated"
      expr: AVG(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Average budget allocated per implementation plan. Benchmarks operational investment per planning unit."
    - name: "high_risk_plan_count"
      expr: COUNT(DISTINCT CASE WHEN risk_level = 'High' THEN implementation_plan_id END)
      comment: "Number of high-risk implementation plans. Triggers executive escalation and risk mitigation resource allocation."
    - name: "approved_plan_count"
      expr: COUNT(DISTINCT CASE WHEN implementation_plan_status = 'Approved' THEN implementation_plan_id END)
      comment: "Number of approved implementation plans. Measures operational readiness and planning governance compliance."
    - name: "grant_requirement_plan_count"
      expr: COUNT(DISTINCT CASE WHEN grant_requirement_flag = TRUE THEN implementation_plan_id END)
      comment: "Number of implementation plans with grant requirements. Tracks donor-mandated planning compliance."
    - name: "total_budget_high_risk_plans"
      expr: SUM(CASE WHEN risk_level = 'High' THEN CAST(budget_allocated_amount AS DOUBLE) ELSE 0 END)
      comment: "Total budget allocated to high-risk implementation plans. Quantifies financial exposure from high-risk operations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk register metrics providing executive visibility into the risk landscape across programs, including risk severity distribution, escalation requirements, and open vs. closed risk profiles."
  source: "`vibe_ngo_v1`.`program`.`risk_register`"
  dimensions:
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk (e.g., Open, Mitigated, Closed, Escalated)."
    - name: "risk_level"
      expr: risk_level
      comment: "Overall risk level (e.g., Low, Medium, High, Critical) for risk severity distribution analysis."
    - name: "risk_category"
      expr: risk_category
      comment: "Category of risk (e.g., Financial, Operational, Reputational, Security) for risk type analysis."
    - name: "risk_subcategory"
      expr: risk_subcategory
      comment: "Sub-category of risk for granular risk landscape analysis."
    - name: "impact_rating"
      expr: impact_rating
      comment: "Impact rating of the risk (e.g., Low, Medium, High) for risk prioritization."
    - name: "likelihood_rating"
      expr: likelihood_rating
      comment: "Likelihood rating of the risk occurring for risk matrix analysis."
    - name: "affected_sector"
      expr: affected_sector
      comment: "Sector affected by the risk for sector-level risk exposure analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the risk for regional risk concentration analysis."
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Whether the risk requires escalation to senior management — critical for governance and oversight."
    - name: "identification_year"
      expr: YEAR(identification_date)
      comment: "Year the risk was identified, for risk trend and aging analysis."
  measures:
    - name: "total_risks"
      expr: COUNT(DISTINCT risk_register_id)
      comment: "Total number of risks in the register. Baseline KPI for organizational risk exposure breadth."
    - name: "open_risk_count"
      expr: COUNT(DISTINCT CASE WHEN risk_status = 'Open' THEN risk_register_id END)
      comment: "Number of currently open risks. Primary operational risk monitoring KPI for leadership dashboards."
    - name: "high_critical_risk_count"
      expr: COUNT(DISTINCT CASE WHEN risk_level IN ('High', 'Critical') THEN risk_register_id END)
      comment: "Number of high or critical risks. Triggers board-level attention and risk mitigation investment decisions."
    - name: "escalation_required_count"
      expr: COUNT(DISTINCT CASE WHEN escalation_required_flag = TRUE THEN risk_register_id END)
      comment: "Number of risks requiring escalation. Directly drives senior management action and governance response."
    - name: "risks_with_mitigation_count"
      expr: COUNT(DISTINCT CASE WHEN mitigation_strategy IS NOT NULL THEN risk_register_id END)
      comment: "Number of risks with a documented mitigation strategy. Measures risk management maturity and coverage."
    - name: "donor_visible_risk_count"
      expr: COUNT(DISTINCT CASE WHEN donor_visibility_flag = TRUE THEN risk_register_id END)
      comment: "Number of risks visible to donors. Critical for donor relationship management and transparency compliance."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_logframe_row`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Logframe row metrics enabling results-based management (RBM) performance tracking, including target vs. baseline analysis, budget allocation to results, and results chain coverage across programs."
  source: "`vibe_ngo_v1`.`program`.`logframe_row`"
  dimensions:
    - name: "result_level"
      expr: result_level
      comment: "Results chain level (e.g., Output, Outcome, Impact, Activity) for results hierarchy analysis."
    - name: "logframe_row_status"
      expr: logframe_row_status
      comment: "Status of the logframe row (e.g., Active, Completed, Cancelled) for results monitoring coverage."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of reporting for the logframe row (e.g., Monthly, Quarterly, Annual)."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Method used to collect data for the indicator (e.g., Survey, Administrative Records, Observation)."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the logframe row for SDG contribution tracking."
    - name: "sector_classification"
      expr: sector_classification
      comment: "Sector classification of the logframe row for sector-level results analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the logframe row for coverage analysis."
    - name: "is_active"
      expr: is_active
      comment: "Whether the logframe row is currently active — filters for live results monitoring."
    - name: "target_year"
      expr: YEAR(target_date)
      comment: "Year the target is due, for results timeline and milestone tracking."
  measures:
    - name: "total_logframe_rows"
      expr: COUNT(DISTINCT logframe_row_id)
      comment: "Total number of logframe rows. Baseline measure for results framework coverage and complexity."
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Sum of all target values across logframe rows. Measures aggregate results ambition in the program portfolio."
    - name: "total_baseline_value"
      expr: SUM(CAST(baseline_value AS DOUBLE))
      comment: "Sum of all baseline values. Provides the starting point for measuring results achievement."
    - name: "total_budget_allocated_to_results"
      expr: SUM(CAST(budget_allocated AS DOUBLE))
      comment: "Total budget allocated to logframe rows. Measures financial investment linked to specific results — critical for results-based financing."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value per logframe row. Benchmarks ambition level per result indicator."
    - name: "active_result_count"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN logframe_row_id END)
      comment: "Number of active logframe rows. Measures live results monitoring coverage."
    - name: "outcome_row_count"
      expr: COUNT(DISTINCT CASE WHEN result_level = 'Outcome' THEN logframe_row_id END)
      comment: "Number of outcome-level logframe rows. Tracks depth of outcome-level results measurement — key for impact reporting."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_component`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program component metrics providing visibility into the structural breakdown of programs, budget envelope allocation, approval status, and risk distribution across program components."
  source: "`vibe_ngo_v1`.`program`.`component`"
  dimensions:
    - name: "component_status"
      expr: component_status
      comment: "Lifecycle status of the component (e.g., Active, Completed, Suspended) for portfolio health monitoring."
    - name: "component_type"
      expr: component_type
      comment: "Type of program component (e.g., Technical, Administrative, Cross-Cutting) for structural analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the component for governance and compliance tracking."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the component for risk-weighted portfolio analysis."
    - name: "sector"
      expr: sector
      comment: "Sector of the component for sector-level portfolio breakdown."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Hierarchy level of the component within the program structure."
    - name: "implementation_modality"
      expr: implementation_modality
      comment: "Implementation modality (e.g., Direct, Partner-Led, Government) for delivery mechanism analysis."
    - name: "monitoring_frequency"
      expr: monitoring_frequency
      comment: "Frequency of monitoring for the component for oversight burden analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code for donor-aligned component reporting."
    - name: "component_start_year"
      expr: YEAR(start_date)
      comment: "Year the component started for cohort and vintage analysis."
  measures:
    - name: "total_components"
      expr: COUNT(DISTINCT component_id)
      comment: "Total number of program components. Baseline measure for program structural complexity."
    - name: "total_budget_envelope"
      expr: SUM(CAST(budget_envelope_amount AS DOUBLE))
      comment: "Total budget envelope across all components. Primary financial allocation KPI at component level."
    - name: "avg_budget_envelope"
      expr: AVG(CAST(budget_envelope_amount AS DOUBLE))
      comment: "Average budget envelope per component. Benchmarks typical component investment size."
    - name: "approved_component_count"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN component_id END)
      comment: "Number of approved components. Measures governance compliance and operational readiness."
    - name: "high_risk_component_count"
      expr: COUNT(DISTINCT CASE WHEN risk_level = 'High' THEN component_id END)
      comment: "Number of high-risk components. Triggers targeted oversight and risk mitigation resource allocation."
    - name: "grant_requirement_component_count"
      expr: COUNT(DISTINCT CASE WHEN grant_requirement_flag = TRUE THEN component_id END)
      comment: "Number of components with grant requirements. Tracks donor-mandated compliance obligations at component level."
    - name: "total_budget_high_risk_components"
      expr: SUM(CASE WHEN risk_level = 'High' THEN CAST(budget_envelope_amount AS DOUBLE) ELSE 0 END)
      comment: "Total budget envelope in high-risk components. Quantifies financial exposure from high-risk program structures."
$$;