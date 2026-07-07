-- Metric views for domain: program | Business: Ngo | Version: 2 | Generated on: 2026-07-03 06:15:30

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic program portfolio metrics providing executives with budget, lifecycle, and risk visibility across all programs. Enables portfolio steering, resource allocation decisions, and compliance monitoring."
  source: "`vibe_ngo_v1`.`program`.`program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current lifecycle status of the program (e.g. Active, Closed, Pipeline) — primary filter for portfolio health views."
    - name: "program_type"
      expr: program_type
      comment: "Classification of the program (e.g. Emergency, Development, Humanitarian) — used to segment portfolio by strategic intent."
    - name: "region"
      expr: region
      comment: "Geographic region of the program — enables regional portfolio analysis and resource allocation decisions."
    - name: "country_code"
      expr: country_code
      comment: "ISO country code where the program operates — supports country-level portfolio drill-down."
    - name: "sector_code"
      expr: sector_code
      comment: "Sector classification code (e.g. Health, WASH, Education) — enables sector-level portfolio analysis."
    - name: "sector_name"
      expr: sector_name
      comment: "Human-readable sector name — used as a display label in dashboards alongside sector_code."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Assigned risk rating of the program — critical for risk-based portfolio management and escalation decisions."
    - name: "is_emergency"
      expr: is_emergency
      comment: "Flag indicating whether the program is an emergency response — used to separate humanitarian surge from development portfolio."
    - name: "is_multi_year"
      expr: is_multi_year
      comment: "Flag indicating multi-year programs — relevant for long-term budget commitment and pipeline planning."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG goal(s) the program contributes to — used for donor reporting and strategic alignment analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory and donor compliance status of the program — used for compliance monitoring dashboards."
    - name: "program_start_year"
      expr: YEAR(start_date)
      comment: "Year the program started — enables cohort analysis and vintage-based portfolio views."
    - name: "program_end_year"
      expr: YEAR(end_date)
      comment: "Year the program is scheduled to end — used for pipeline and closeout planning."
  measures:
    - name: "total_program_budget"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total approved budget across all programs. Core financial KPI for portfolio budget oversight and donor commitment tracking."
    - name: "avg_program_budget"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per program. Used to benchmark program sizing and identify outliers in resource allocation."
    - name: "active_program_count"
      expr: COUNT(CASE WHEN program_status = 'Active' THEN program_id END)
      comment: "Number of currently active programs. Key portfolio health indicator for executive dashboards and steering meetings."
    - name: "emergency_program_count"
      expr: COUNT(CASE WHEN is_emergency = TRUE THEN program_id END)
      comment: "Number of emergency response programs. Tracks humanitarian surge capacity and informs emergency resource mobilization decisions."
    - name: "high_risk_program_count"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN program_id END)
      comment: "Number of programs rated high risk. Triggers risk escalation and mitigation investment decisions at portfolio level."
    - name: "emergency_budget_share"
      expr: SUM(CASE WHEN is_emergency = TRUE THEN CAST(budget_amount AS DOUBLE) ELSE 0 END)
      comment: "Total budget allocated to emergency programs. Enables analysis of humanitarian vs. development budget split for strategic resource decisions."
    - name: "multi_year_program_count"
      expr: COUNT(CASE WHEN is_multi_year = TRUE THEN program_id END)
      comment: "Number of multi-year programs. Informs long-term financial commitment planning and pipeline sustainability analysis."
    - name: "non_compliant_program_count"
      expr: COUNT(CASE WHEN compliance_status != 'Compliant' AND compliance_status IS NOT NULL THEN program_id END)
      comment: "Number of programs with non-compliant status. Critical compliance KPI that triggers corrective action and donor reporting obligations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_intervention`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intervention-level operational and financial metrics enabling program managers and executives to track delivery performance, budget utilization, and safeguarding compliance across all interventions."
  source: "`vibe_ngo_v1`.`program`.`intervention`"
  dimensions:
    - name: "intervention_status"
      expr: intervention_status
      comment: "Current lifecycle status of the intervention (e.g. Active, Completed, Suspended) — primary operational health dimension."
    - name: "intervention_type"
      expr: intervention_type
      comment: "Type of intervention (e.g. Direct Service, Capacity Building, Advocacy) — used to segment delivery modality analysis."
    - name: "sector"
      expr: sector
      comment: "Sector the intervention operates in — enables sector-level performance and budget analysis."
    - name: "sub_sector"
      expr: sub_sector
      comment: "Sub-sector classification — provides granular sector drill-down for technical advisors and sector leads."
    - name: "phase"
      expr: phase
      comment: "Implementation phase of the intervention — used to track pipeline progression and phase-gate decisions."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic coverage of the intervention — used for geographic portfolio analysis and field resource planning."
    - name: "gender_marker_score"
      expr: gender_marker_score
      comment: "IASC gender marker score assigned to the intervention — used for gender mainstreaming compliance reporting."
    - name: "disability_inclusion_marker_score"
      expr: disability_inclusion_marker_score
      comment: "Disability inclusion marker score — used for inclusion compliance and donor reporting."
    - name: "sdg_goal_primary"
      expr: sdg_goal_primary
      comment: "Primary SDG goal the intervention contributes to — used for SDG portfolio alignment reporting."
    - name: "safeguarding_policy_applied"
      expr: safeguarding_policy_applied
      comment: "Flag indicating whether safeguarding policy has been applied — critical for safeguarding compliance monitoring."
    - name: "chs_compliant"
      expr: chs_compliant
      comment: "Flag indicating Core Humanitarian Standard compliance — used for humanitarian accountability reporting."
    - name: "ip_transfer_modality"
      expr: ip_transfer_modality
      comment: "Implementing partner transfer modality (e.g. Cash, In-Kind, Direct) — used for financial modality analysis."
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year the intervention is planned to start — used for pipeline and cohort analysis."
    - name: "planned_end_year"
      expr: YEAR(planned_end_date)
      comment: "Year the intervention is planned to end — used for closeout planning and multi-year pipeline views."
  measures:
    - name: "total_intervention_budget"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total budget allocated across all interventions. Primary financial KPI for intervention portfolio oversight and donor commitment tracking."
    - name: "avg_intervention_budget"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average budget per intervention. Used to benchmark intervention sizing and identify over- or under-resourced interventions."
    - name: "active_intervention_count"
      expr: COUNT(CASE WHEN intervention_status = 'Active' THEN intervention_id END)
      comment: "Number of currently active interventions. Core operational throughput KPI for program delivery dashboards."
    - name: "safeguarding_compliant_count"
      expr: COUNT(CASE WHEN safeguarding_policy_applied = TRUE THEN intervention_id END)
      comment: "Number of interventions with safeguarding policy applied. Critical accountability KPI — non-compliance triggers mandatory escalation."
    - name: "chs_compliant_count"
      expr: COUNT(CASE WHEN chs_compliant = TRUE THEN intervention_id END)
      comment: "Number of CHS-compliant interventions. Used for humanitarian accountability reporting and donor compliance verification."
    - name: "do_no_harm_assessed_count"
      expr: COUNT(CASE WHEN do_no_harm_assessment_completed = TRUE THEN intervention_id END)
      comment: "Number of interventions with completed Do No Harm assessments. Tracks risk management compliance across the portfolio."
    - name: "gender_mainstreamed_count"
      expr: COUNT(CASE WHEN gender_marker_score IN ('2a', '2b', '3') THEN intervention_id END)
      comment: "Number of interventions with meaningful gender integration (marker score 2a+). Used for gender portfolio compliance and donor reporting."
    - name: "total_budget_active_interventions"
      expr: SUM(CASE WHEN intervention_status = 'Active' THEN CAST(total_budget_amount AS DOUBLE) ELSE 0 END)
      comment: "Total budget committed to currently active interventions. Enables active portfolio financial exposure analysis for treasury and finance decisions."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_budget_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget plan financial metrics providing finance teams and program directors with visibility into budget composition, cost structure, and indirect cost rates across all budget plans."
  source: "`vibe_ngo_v1`.`program`.`budget_plan`"
  dimensions:
    - name: "budget_period_start_year"
      expr: YEAR(budget_period_start_date)
      comment: "Fiscal year the budget period starts — used for annual budget cycle analysis and year-over-year comparisons."
    - name: "budget_period_end_year"
      expr: YEAR(budget_period_end_date)
      comment: "Fiscal year the budget period ends — used for multi-year budget planning and closeout analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget plan — used for multi-currency portfolio analysis and FX exposure reporting."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code — used for donor-aligned sector reporting and ODA classification."
    - name: "sector_classification"
      expr: sector_classification
      comment: "Internal sector classification of the budget plan — used for sector-level budget allocation analysis."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the budget plan — used for SDG-tagged budget reporting to donors and governing bodies."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Flag indicating whether the budget plan is visible to donors — used to segment donor-facing vs. internal budget views."
    - name: "amendment_date_month"
      expr: DATE_TRUNC('MONTH', amendment_date)
      comment: "Month of the most recent budget amendment — used to track amendment frequency and budget volatility over time."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_budget_amount AS DOUBLE))
      comment: "Total approved budget across all budget plans. Primary financial KPI for budget oversight, donor commitment, and financial planning."
    - name: "total_direct_costs"
      expr: SUM(CAST(total_direct_costs AS DOUBLE))
      comment: "Total direct program costs. Used to assess programmatic spend efficiency and direct vs. indirect cost ratio."
    - name: "total_indirect_costs"
      expr: SUM(CAST(indirect_costs AS DOUBLE))
      comment: "Total indirect/overhead costs. Used to monitor overhead rates and ensure compliance with donor indirect cost caps."
    - name: "total_personnel_costs"
      expr: SUM(CAST(personnel_costs AS DOUBLE))
      comment: "Total personnel costs across budget plans. Largest cost driver — used for workforce cost management and budget reallocation decisions."
    - name: "total_travel_costs"
      expr: SUM(CAST(travel_costs AS DOUBLE))
      comment: "Total travel costs. Used to monitor field travel expenditure and identify cost reduction opportunities."
    - name: "total_equipment_costs"
      expr: SUM(CAST(equipment_costs AS DOUBLE))
      comment: "Total equipment costs. Used for capital expenditure planning and asset procurement oversight."
    - name: "total_contractual_costs"
      expr: SUM(CAST(contractual_costs AS DOUBLE))
      comment: "Total contractual/subcontractor costs. Used to monitor partner and vendor spend and manage contractual risk exposure."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-sharing contributions. Used to track co-financing commitments and demonstrate leverage to donors."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate across budget plans. Used to benchmark overhead efficiency and negotiate donor indirect cost agreements."
    - name: "total_supplies_costs"
      expr: SUM(CAST(supplies_costs AS DOUBLE))
      comment: "Total supplies and materials costs. Used for procurement planning and supply chain budget management."
    - name: "total_fringe_benefits_costs"
      expr: SUM(CAST(fringe_benefits_costs AS DOUBLE))
      comment: "Total fringe benefits costs. Used for total compensation cost analysis and HR budget planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_budget_plan_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget line-level financial metrics enabling finance teams to analyze cost category composition, cost-sharing, and budget utilization at the most granular level of the budget structure."
  source: "`vibe_ngo_v1`.`program`.`budget_plan_line`"
  dimensions:
    - name: "cost_category"
      expr: cost_category
      comment: "High-level cost category (e.g. Personnel, Travel, Equipment) — primary dimension for budget composition analysis."
    - name: "cost_subcategory"
      expr: cost_subcategory
      comment: "Granular cost sub-category — used for detailed cost breakdown and budget variance analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget line — used for annual budget cycle analysis and year-over-year comparisons."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget line — used for multi-currency budget analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code on the budget line — used for donor-aligned sector-level budget reporting."
    - name: "direct_cost_flag"
      expr: direct_cost_flag
      comment: "Flag indicating whether the line is a direct cost — used to split direct vs. indirect cost analysis."
    - name: "cost_sharing_flag"
      expr: cost_sharing_flag
      comment: "Flag indicating whether the line includes cost sharing — used to track co-financing contributions."
    - name: "allowable_cost_flag"
      expr: allowable_cost_flag
      comment: "Flag indicating donor-allowable costs — used for compliance monitoring and disallowed cost risk management."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the budget line — used for SDG-tagged expenditure reporting."
    - name: "budget_period_start_year"
      expr: YEAR(budget_period_start_date)
      comment: "Year the budget line period starts — used for annual budget cycle and multi-year planning analysis."
  measures:
    - name: "total_planned_amount"
      expr: SUM(CAST(total_planned_amount AS DOUBLE))
      comment: "Total planned budget amount across all lines. Core financial KPI for budget utilization and variance analysis."
    - name: "total_cost_sharing_amount"
      expr: SUM(CAST(cost_sharing_amount AS DOUBLE))
      comment: "Total cost-sharing contributions at line level. Used to track co-financing leverage and donor match requirements."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across budget lines. Used for cost benchmarking, procurement efficiency analysis, and value-for-money assessments."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of units budgeted. Used alongside unit cost to validate budget line calculations and procurement planning."
    - name: "direct_cost_total"
      expr: SUM(CASE WHEN direct_cost_flag = TRUE THEN CAST(total_planned_amount AS DOUBLE) ELSE 0 END)
      comment: "Total direct costs from budget lines. Used to compute direct cost ratio and ensure compliance with donor direct cost requirements."
    - name: "cost_sharing_total"
      expr: SUM(CASE WHEN cost_sharing_flag = TRUE THEN CAST(cost_sharing_amount AS DOUBLE) ELSE 0 END)
      comment: "Total cost-sharing amounts on flagged lines. Used to verify co-financing commitments are met per donor agreements."
    - name: "non_allowable_cost_total"
      expr: SUM(CASE WHEN allowable_cost_flag = FALSE THEN CAST(total_planned_amount AS DOUBLE) ELSE 0 END)
      comment: "Total budget on non-allowable cost lines. Critical compliance KPI — non-allowable costs risk donor disallowance and clawback."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate at line level. Used to monitor overhead application consistency and donor rate compliance."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_component`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program component metrics enabling program directors to track component portfolio health, budget envelope utilization, and risk distribution across the program structure."
  source: "`vibe_ngo_v1`.`program`.`component`"
  dimensions:
    - name: "component_status"
      expr: component_status
      comment: "Current lifecycle status of the component — primary health dimension for component portfolio views."
    - name: "component_type"
      expr: component_type
      comment: "Type of component (e.g. Technical, Administrative, Cross-cutting) — used to segment portfolio by component function."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the component — used to track governance pipeline and pending approvals."
    - name: "sector"
      expr: sector
      comment: "Sector of the component — used for sector-level portfolio analysis."
    - name: "sub_sector"
      expr: sub_sector
      comment: "Sub-sector of the component — provides granular sector drill-down."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the component — used for risk-based portfolio management."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Hierarchy level of the component within the program structure — used for structural analysis and reporting roll-ups."
    - name: "implementation_modality"
      expr: implementation_modality
      comment: "How the component is implemented (e.g. Direct, Partner, Government) — used for modality mix analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code — used for donor-aligned sector reporting."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the component — used for SDG portfolio reporting."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Flag indicating donor visibility — used to segment donor-facing vs. internal component views."
    - name: "component_start_year"
      expr: YEAR(start_date)
      comment: "Year the component starts — used for cohort and pipeline analysis."
  measures:
    - name: "total_budget_envelope"
      expr: SUM(CAST(budget_envelope_amount AS DOUBLE))
      comment: "Total budget envelope across all components. Primary financial KPI for component-level budget oversight and allocation decisions."
    - name: "avg_budget_envelope"
      expr: AVG(CAST(budget_envelope_amount AS DOUBLE))
      comment: "Average budget envelope per component. Used to benchmark component sizing and identify outliers in resource allocation."
    - name: "active_component_count"
      expr: COUNT(CASE WHEN component_status = 'Active' THEN component_id END)
      comment: "Number of active components. Core operational KPI for program delivery capacity monitoring."
    - name: "high_risk_component_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN component_id END)
      comment: "Number of high-risk components. Triggers risk escalation and mitigation investment decisions at program level."
    - name: "pending_approval_component_count"
      expr: COUNT(CASE WHEN approval_status NOT IN ('Approved', 'Completed') AND approval_status IS NOT NULL THEN component_id END)
      comment: "Number of components pending approval. Used to monitor governance bottlenecks and accelerate approval pipeline."
    - name: "donor_visible_budget_total"
      expr: SUM(CASE WHEN donor_visibility_flag = TRUE THEN CAST(budget_envelope_amount AS DOUBLE) ELSE 0 END)
      comment: "Total budget envelope on donor-visible components. Used for donor reporting and transparency compliance."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_logframe_row`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Logframe results metrics enabling MEL teams and program directors to track target achievement, baseline coverage, and results framework completeness across all logframe rows."
  source: "`vibe_ngo_v1`.`program`.`logframe_row`"
  dimensions:
    - name: "result_level"
      expr: result_level
      comment: "Results chain level (e.g. Input, Output, Outcome, Impact) — primary dimension for results framework analysis."
    - name: "logframe_row_status"
      expr: logframe_row_status
      comment: "Current status of the logframe row — used to track results monitoring progress."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of results reporting (e.g. Monthly, Quarterly, Annual) — used for MEL planning and reporting calendar management."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Method used to collect results data — used for MEL quality assurance and data reliability analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the logframe row — used for geographic results analysis."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the result — used for SDG contribution reporting."
    - name: "sector_classification"
      expr: sector_classification
      comment: "Sector classification of the result — used for sector-level results analysis."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the logframe row is currently active — used to filter active vs. archived results."
    - name: "target_year"
      expr: YEAR(target_date)
      comment: "Year the result target is due — used for annual results planning and target achievement tracking."
    - name: "implementation_start_year"
      expr: YEAR(implementation_start_date)
      comment: "Year implementation of this result starts — used for pipeline and cohort analysis."
  measures:
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Sum of all result targets across logframe rows. Primary results KPI — used to quantify total program ambition and track aggregate target achievement."
    - name: "total_baseline_value"
      expr: SUM(CAST(baseline_value AS DOUBLE))
      comment: "Sum of all baseline values. Used to contextualize target ambition and measure change from baseline."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value per logframe row. Used to benchmark indicator ambition and identify outlier targets."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated AS DOUBLE))
      comment: "Total budget allocated to logframe rows. Used to link financial resources to results and assess cost-per-result efficiency."
    - name: "active_result_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN logframe_row_id END)
      comment: "Number of active logframe rows. Used to track MEL framework completeness and active results monitoring coverage."
    - name: "output_level_count"
      expr: COUNT(CASE WHEN result_level = 'Output' THEN logframe_row_id END)
      comment: "Number of output-level results. Used to assess program delivery breadth and output monitoring coverage."
    - name: "outcome_level_count"
      expr: COUNT(CASE WHEN result_level = 'Outcome' THEN logframe_row_id END)
      comment: "Number of outcome-level results. Used to assess program theory of change depth and outcome monitoring coverage."
    - name: "avg_budget_per_result"
      expr: AVG(CAST(budget_allocated AS DOUBLE))
      comment: "Average budget allocated per logframe row. Used for cost-per-result benchmarking and value-for-money analysis."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_implementation_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Implementation plan metrics enabling program managers to track planning coverage, budget allocation, and operational readiness across all implementation plans."
  source: "`vibe_ngo_v1`.`program`.`implementation_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the implementation plan — primary health dimension for operational planning dashboards."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of implementation plan (e.g. Annual, Quarterly, Emergency) — used to segment planning cycle analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the implementation plan — used for risk-based planning oversight."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the plan — used for geographic planning coverage analysis."
    - name: "sector_classification"
      expr: sector_classification
      comment: "Sector classification of the plan — used for sector-level planning analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code — used for donor-aligned planning analysis."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Reporting frequency of the plan — used for MEL and reporting calendar planning."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Flag indicating donor visibility of the plan — used to segment donor-facing vs. internal planning views."
    - name: "planning_period_start_year"
      expr: YEAR(planning_period_start_date)
      comment: "Year the planning period starts — used for annual planning cycle analysis."
  measures:
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated across all implementation plans. Used to track financial resource commitment to operational delivery."
    - name: "avg_budget_allocated"
      expr: AVG(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Average budget allocated per implementation plan. Used to benchmark plan resourcing and identify under-resourced plans."
    - name: "active_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'Active' THEN implementation_plan_id END)
      comment: "Number of active implementation plans. Core operational KPI for delivery readiness monitoring."
    - name: "high_risk_plan_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN implementation_plan_id END)
      comment: "Number of high-risk implementation plans. Triggers risk mitigation and management attention for delivery assurance."
    - name: "grant_requirement_plan_count"
      expr: COUNT(CASE WHEN grant_requirement_flag = TRUE THEN implementation_plan_id END)
      comment: "Number of plans with grant requirements. Used to track donor-mandated planning obligations and compliance."
    - name: "donor_visible_budget_total"
      expr: SUM(CASE WHEN donor_visibility_flag = TRUE THEN CAST(budget_allocated_amount AS DOUBLE) ELSE 0 END)
      comment: "Total budget on donor-visible implementation plans. Used for donor transparency reporting and accountability."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_partnership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program partnership metrics enabling partnership managers and program directors to track partner portfolio health, budget allocation to partners, and partnership performance across the program."
  source: "`vibe_ngo_v1`.`program`.`program_partnership`"
  dimensions:
    - name: "partnership_status"
      expr: partnership_status
      comment: "Current status of the partnership — primary health dimension for partner portfolio management."
    - name: "partnership_type"
      expr: partnership_type
      comment: "Type of partnership (e.g. Implementing, Strategic, Referral) — used to segment partner portfolio by relationship type."
    - name: "partnership_role"
      expr: partnership_role
      comment: "Role of the partner in the program — used to analyze partner function distribution."
    - name: "performance_rating"
      expr: performance_rating
      comment: "Performance rating of the partnership — critical KPI dimension for partner performance management and renewal decisions."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the partnership — used for risk-based partner oversight and due diligence prioritization."
    - name: "capacity_assessment_status"
      expr: capacity_assessment_status
      comment: "Status of partner capacity assessment — used to track due diligence compliance and capacity building needs."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the partnership — used for partner compliance monitoring and corrective action tracking."
    - name: "ip_transfer_modality"
      expr: ip_transfer_modality
      comment: "Financial transfer modality to the partner — used for financial modality mix analysis."
    - name: "sector_focus"
      expr: sector_focus
      comment: "Sector focus of the partnership — used for sector-level partner portfolio analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the partnership — used for geographic partner coverage analysis."
    - name: "partnership_start_year"
      expr: YEAR(start_date)
      comment: "Year the partnership started — used for cohort analysis and partnership vintage reporting."
  measures:
    - name: "total_budget_allocated_to_partners"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated to implementing partners. Primary financial KPI for partner portfolio investment and IP transfer monitoring."
    - name: "avg_budget_per_partnership"
      expr: AVG(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Average budget allocated per partnership. Used to benchmark partner investment levels and identify concentration risk."
    - name: "active_partnership_count"
      expr: COUNT(CASE WHEN partnership_status = 'Active' THEN program_partnership_id END)
      comment: "Number of active partnerships. Core partner portfolio KPI for delivery capacity and partner network health monitoring."
    - name: "high_risk_partnership_count"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN program_partnership_id END)
      comment: "Number of high-risk partnerships. Triggers enhanced monitoring, capacity support, or partnership review decisions."
    - name: "non_compliant_partnership_count"
      expr: COUNT(CASE WHEN compliance_status != 'Compliant' AND compliance_status IS NOT NULL THEN program_partnership_id END)
      comment: "Number of non-compliant partnerships. Critical accountability KPI — non-compliance triggers corrective action and potential suspension."
    - name: "low_performance_partnership_count"
      expr: COUNT(CASE WHEN performance_rating IN ('Poor', 'Below Expectations', 'Unsatisfactory') THEN program_partnership_id END)
      comment: "Number of partnerships with low performance ratings. Used to trigger performance improvement plans or partnership termination decisions."
    - name: "capacity_assessed_budget_total"
      expr: SUM(CASE WHEN capacity_assessment_status = 'Completed' THEN CAST(budget_allocated_amount AS DOUBLE) ELSE 0 END)
      comment: "Total budget allocated to partners with completed capacity assessments. Used to track due diligence coverage of financial commitments."
$$;