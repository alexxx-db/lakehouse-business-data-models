-- Metric views for domain: mel | Business: Ngo | Version: 2 | Generated on: 2026-07-10 20:18:10

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_indicator_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core MEL performance metrics tracking indicator achievement, data quality, and variance against targets across programs, partners, and reporting periods. Primary KPI layer for monitoring and evaluation decision-making."
  source: "`vibe_ngo_v1`.`mel`.`indicator_result`"
  dimensions:
    - name: "reporting_period_id"
      expr: reporting_period_id
      comment: "Foreign key to reporting period — enables slicing KPIs by reporting cycle (quarterly, annual, etc.)."
    - name: "intervention_id"
      expr: intervention_id
      comment: "Foreign key to intervention — enables performance analysis by program intervention."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Foreign key to partner organisation — enables partner-level performance benchmarking."
    - name: "project_site_id"
      expr: project_site_id
      comment: "Foreign key to project site — enables geographic disaggregation of results."
    - name: "component_id"
      expr: component_id
      comment: "Foreign key to program component — enables component-level results tracking."
    - name: "indicator_result_status"
      expr: indicator_result_status
      comment: "Status of the indicator result (e.g. verified, pending, rejected) — used to filter quality-assured results."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the result — distinguishes verified vs unverified data for quality reporting."
    - name: "disaggregation_sex"
      expr: disaggregation_sex
      comment: "Sex disaggregation dimension — enables gender-responsive performance analysis."
    - name: "disaggregation_age_group"
      expr: disaggregation_age_group
      comment: "Age group disaggregation — enables age-sensitive results analysis."
    - name: "disaggregation_displacement_status"
      expr: disaggregation_displacement_status
      comment: "Displacement status disaggregation — enables analysis for displaced vs host community populations."
    - name: "geographic_level"
      expr: geographic_level
      comment: "Geographic level of the result (national, regional, district) — enables spatial performance analysis."
    - name: "indicator_level"
      expr: indicator_level
      comment: "Logframe level of the indicator (output, outcome, impact) — enables results-chain performance analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the result — ensures correct interpretation of aggregated values."
    - name: "collection_date_month"
      expr: DATE_TRUNC('MONTH', collection_date)
      comment: "Month of data collection — enables trend analysis of results over time."
    - name: "collection_date_year"
      expr: DATE_TRUNC('YEAR', collection_date)
      comment: "Year of data collection — enables annual performance trend analysis."
    - name: "is_milestone"
      expr: is_milestone
      comment: "Flag indicating whether this result is a milestone — enables milestone-specific performance tracking."
    - name: "reported_to_donor"
      expr: reported_to_donor
      comment: "Flag indicating whether the result has been reported to the donor — supports donor accountability tracking."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Method used to collect data — enables quality analysis by collection methodology."
    - name: "award_id"
      expr: award_id
      comment: "Foreign key to grant award — enables grant-level results aggregation."
  measures:
    - name: "total_results_reported"
      expr: COUNT(1)
      comment: "Total number of indicator results reported. Baseline volume metric for MEL pipeline throughput — used to assess reporting completeness across periods and partners."
    - name: "total_actual_value"
      expr: SUM(CAST(value AS DOUBLE))
      comment: "Sum of all reported indicator result values. Represents aggregate programme output/outcome achievement — core KPI for donor reporting and programme steering."
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Sum of all indicator target values against which results are measured. Used as denominator for achievement rate calculations and target-setting reviews."
    - name: "total_cumulative_result"
      expr: SUM(CAST(cumulative_result AS DOUBLE))
      comment: "Sum of cumulative results across all indicator results. Tracks programme-to-date achievement for multi-period indicators — critical for mid-term and endline reviews."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across all reported results. Measures MEL system data integrity — low scores trigger data quality improvement interventions."
    - name: "total_variance_from_target"
      expr: SUM(CAST(variance_from_target AS DOUBLE))
      comment: "Sum of variance from target across all results. Aggregate under/over-performance signal — used by programme managers to identify systemic delivery gaps."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance from target across results. Normalised performance gap metric — enables cross-indicator and cross-partner comparison of target achievement."
    - name: "verified_results_count"
      expr: COUNT(CASE WHEN verification_status = 'verified' THEN 1 END)
      comment: "Count of results with verified status. Measures data verification coverage — low verification rates signal accountability and quality assurance risks."
    - name: "donor_reported_results_count"
      expr: COUNT(CASE WHEN reported_to_donor = TRUE THEN 1 END)
      comment: "Count of results reported to donors. Tracks donor accountability compliance — gaps between total results and donor-reported results flag reporting obligations at risk."
    - name: "milestone_results_count"
      expr: COUNT(CASE WHEN is_milestone = TRUE THEN 1 END)
      comment: "Count of milestone indicator results. Tracks achievement of programme milestones — used in steering meetings to assess whether key programme checkpoints are met."
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline value across indicator results. Provides context for interpreting achievement — used in change-from-baseline analysis for outcome measurement."
    - name: "distinct_indicators_with_results"
      expr: COUNT(DISTINCT indicator_id)
      comment: "Count of distinct indicators with at least one result reported. Measures MEL framework coverage — low coverage signals indicators without data, a programme management risk."
    - name: "distinct_partners_reporting"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Count of distinct partner organisations that have submitted results. Tracks partner reporting compliance — used to identify non-reporting partners requiring follow-up."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_indicator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic metrics on the indicator framework — coverage, target-setting quality, and alignment to donor and SDG frameworks. Used by MEL managers and programme directors to govern the indicator portfolio."
  source: "`vibe_ngo_v1`.`mel`.`indicator`"
  dimensions:
    - name: "indicator_status"
      expr: indicator_status
      comment: "Current status of the indicator (active, inactive, archived) — enables filtering to live indicator portfolio."
    - name: "indicator_type"
      expr: indicator_type
      comment: "Type of indicator (output, outcome, impact, process) — enables results-chain level analysis."
    - name: "logframe_level"
      expr: logframe_level
      comment: "Logframe hierarchy level — enables analysis of indicator distribution across the results chain."
    - name: "sector"
      expr: sector
      comment: "Sector the indicator belongs to — enables sector-level portfolio analysis."
    - name: "theme"
      expr: theme
      comment: "Thematic area of the indicator — enables cross-cutting theme analysis (e.g. gender, protection)."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the indicator — enables SDG contribution reporting to donors and governing bodies."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "How frequently the indicator is reported — enables workload planning for MEL teams."
    - name: "data_collection_frequency"
      expr: data_collection_frequency
      comment: "Frequency of data collection for the indicator — used to assess MEL operational burden."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure — ensures correct interpretation of target and baseline values."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the indicator is mandatory (e.g. donor-required) — enables compliance tracking."
    - name: "is_custom"
      expr: is_custom
      comment: "Whether the indicator is custom-designed vs standard — enables portfolio standardisation analysis."
    - name: "program_id"
      expr: program_id
      comment: "Foreign key to program — enables program-level indicator portfolio analysis."
    - name: "intervention_id"
      expr: intervention_id
      comment: "Foreign key to intervention — enables intervention-level indicator coverage analysis."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Foreign key to partner organisation — enables partner-level indicator assignment analysis."
    - name: "effective_start_date_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the indicator became effective — enables cohort analysis of indicator introduction over time."
    - name: "dac_criteria_alignment"
      expr: dac_criteria_alignment
      comment: "DAC evaluation criteria alignment — enables analysis of indicator coverage against OECD DAC standards."
  measures:
    - name: "total_indicators"
      expr: COUNT(1)
      comment: "Total number of indicators in the framework. Baseline portfolio size metric — used to assess MEL framework scope and manageability."
    - name: "mandatory_indicators_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END)
      comment: "Count of mandatory (donor-required) indicators. Tracks compliance obligations — ensures all donor-required indicators are covered in the MEL framework."
    - name: "custom_indicators_count"
      expr: COUNT(CASE WHEN is_custom = TRUE THEN 1 END)
      comment: "Count of custom indicators. Measures programme-specific MEL investment — high custom indicator counts may signal framework complexity or duplication risks."
    - name: "active_indicators_count"
      expr: COUNT(CASE WHEN indicator_status = 'active' THEN 1 END)
      comment: "Count of currently active indicators. Tracks live MEL framework size — used in resource planning for data collection and reporting."
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Sum of all indicator target values. Aggregate programme ambition metric — used in programme design reviews and donor negotiations."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value per indicator. Benchmarks indicator ambition levels — outliers may indicate miscalibrated targets requiring review."
    - name: "total_baseline_value"
      expr: SUM(CAST(baseline_value AS DOUBLE))
      comment: "Sum of all indicator baseline values. Provides aggregate starting-point context for programme change measurement."
    - name: "distinct_programs_covered"
      expr: COUNT(DISTINCT program_id)
      comment: "Count of distinct programs with at least one indicator. Measures MEL framework coverage across the programme portfolio — gaps indicate programs without measurement frameworks."
    - name: "distinct_interventions_covered"
      expr: COUNT(DISTINCT intervention_id)
      comment: "Count of distinct interventions with at least one indicator. Tracks intervention-level MEL coverage — used to identify interventions lacking measurement frameworks."
    - name: "indicators_with_sdg_alignment_count"
      expr: COUNT(CASE WHEN sdg_alignment IS NOT NULL AND sdg_alignment <> '' THEN 1 END)
      comment: "Count of indicators aligned to SDGs. Measures SDG contribution reporting readiness — critical for UN and institutional donor accountability."
    - name: "indicators_with_baseline_count"
      expr: COUNT(CASE WHEN baseline_value IS NOT NULL THEN 1 END)
      comment: "Count of indicators with a baseline value set. Measures MEL framework maturity — indicators without baselines cannot demonstrate change, a quality risk."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Evaluation portfolio metrics tracking quality, cost-efficiency, and management response performance. Used by MEL directors and senior management to govern the evaluation function and ensure accountability."
  source: "`vibe_ngo_v1`.`mel`.`evaluation`"
  dimensions:
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current status of the evaluation (planned, in-progress, completed, cancelled) — enables pipeline and completion analysis."
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of evaluation (formative, summative, real-time, impact) — enables portfolio analysis by evaluation modality."
    - name: "evaluator_type"
      expr: evaluator_type
      comment: "Whether the evaluation is internal or external — enables independence and cost analysis."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall quality rating of the evaluation — enables portfolio-level quality benchmarking."
    - name: "relevance_rating"
      expr: relevance_rating
      comment: "DAC relevance rating — enables analysis of programme relevance performance."
    - name: "effectiveness_rating"
      expr: effectiveness_rating
      comment: "DAC effectiveness rating — key donor accountability metric for programme performance."
    - name: "efficiency_rating"
      expr: efficiency_rating
      comment: "DAC efficiency rating — measures value-for-money performance of evaluated programmes."
    - name: "impact_rating"
      expr: impact_rating
      comment: "DAC impact rating — highest-level accountability metric for programme contribution to change."
    - name: "sustainability_rating"
      expr: sustainability_rating
      comment: "DAC sustainability rating — measures long-term programme viability."
    - name: "management_response_status"
      expr: management_response_status
      comment: "Status of management response to evaluation findings — tracks accountability follow-through."
    - name: "geographic_coverage"
      expr: geographic_coverage
      comment: "Geographic scope of the evaluation — enables regional evaluation portfolio analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of evaluation cost — required for multi-currency cost analysis."
    - name: "program_id"
      expr: program_id
      comment: "Foreign key to program — enables program-level evaluation portfolio analysis."
    - name: "country_office_id"
      expr: country_office_id
      comment: "Foreign key to country office — enables country-level evaluation portfolio analysis."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Foreign key to partner organisation — enables partner evaluation performance analysis."
    - name: "planned_start_date_year"
      expr: DATE_TRUNC('YEAR', planned_start_date)
      comment: "Year the evaluation was planned to start — enables annual evaluation pipeline analysis."
    - name: "dissemination_date_year"
      expr: DATE_TRUNC('YEAR', dissemination_date)
      comment: "Year of evaluation dissemination — enables analysis of evaluation output timelines."
    - name: "ethics_approval_obtained"
      expr: ethics_approval_obtained
      comment: "Whether ethics approval was obtained — tracks compliance with ethical research standards."
    - name: "quality_assurance_conducted"
      expr: quality_assurance_conducted
      comment: "Whether quality assurance was conducted — tracks evaluation quality management compliance."
    - name: "dac_criteria_assessed"
      expr: dac_criteria_assessed
      comment: "DAC criteria covered in the evaluation — enables analysis of evaluation comprehensiveness."
  measures:
    - name: "total_evaluations"
      expr: COUNT(1)
      comment: "Total number of evaluations in the portfolio. Baseline metric for evaluation function capacity — used in annual MEL planning and resource allocation."
    - name: "completed_evaluations_count"
      expr: COUNT(CASE WHEN evaluation_status = 'completed' THEN 1 END)
      comment: "Count of completed evaluations. Tracks evaluation delivery performance — completion rate against planned evaluations is a key MEL function KPI."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of evaluations. Tracks evaluation function expenditure — used in budget management and value-for-money analysis."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount for evaluations. Used as denominator for budget utilisation analysis and financial planning."
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per evaluation. Benchmarks evaluation cost efficiency — outliers indicate over/under-resourced evaluations requiring management attention."
    - name: "evaluations_with_management_response_count"
      expr: COUNT(CASE WHEN management_response_status IS NOT NULL AND management_response_status <> '' THEN 1 END)
      comment: "Count of evaluations with a management response recorded. Tracks accountability follow-through — evaluations without management responses represent unaddressed accountability gaps."
    - name: "ethics_approved_evaluations_count"
      expr: COUNT(CASE WHEN ethics_approval_obtained = TRUE THEN 1 END)
      comment: "Count of evaluations with ethics approval obtained. Tracks ethical compliance in the evaluation portfolio — critical for institutional credibility and donor confidence."
    - name: "qa_conducted_evaluations_count"
      expr: COUNT(CASE WHEN quality_assurance_conducted = TRUE THEN 1 END)
      comment: "Count of evaluations where quality assurance was conducted. Measures evaluation quality management coverage — low QA rates signal systemic quality risks in the evaluation function."
    - name: "external_evaluations_count"
      expr: COUNT(CASE WHEN evaluator_type = 'external' THEN 1 END)
      comment: "Count of externally conducted evaluations. Tracks independence of evaluation function — donors often require a minimum proportion of external evaluations for credibility."
    - name: "distinct_programs_evaluated"
      expr: COUNT(DISTINCT program_id)
      comment: "Count of distinct programs with at least one evaluation. Measures evaluation coverage across the programme portfolio — gaps indicate programs without accountability evidence."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_evaluation_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on evaluation findings, recommendations, and management response implementation. Used by senior management and MEL teams to track accountability, learning uptake, and recommendation closure rates."
  source: "`vibe_ngo_v1`.`mel`.`evaluation_finding`"
  dimensions:
    - name: "evaluation_finding_type"
      expr: evaluation_finding_type
      comment: "Type of finding (recommendation, lesson learned, good practice, risk) — enables analysis by finding category."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the finding (high, medium, low) — enables prioritised management response tracking."
    - name: "implementation_status"
      expr: implementation_status
      comment: "Current implementation status of the recommendation — tracks management response follow-through."
    - name: "rating"
      expr: rating
      comment: "Rating assigned to the finding — enables quality benchmarking of evaluation findings."
    - name: "dac_criterion"
      expr: dac_criterion
      comment: "DAC evaluation criterion the finding relates to — enables analysis of findings by OECD DAC dimension."
    - name: "sector"
      expr: sector
      comment: "Sector the finding relates to — enables sector-level learning and accountability analysis."
    - name: "cross_cutting_theme"
      expr: cross_cutting_theme
      comment: "Cross-cutting theme (gender, protection, environment) — enables thematic learning analysis."
    - name: "responsible_unit"
      expr: responsible_unit
      comment: "Organisational unit responsible for implementing the recommendation — enables accountability tracking by unit."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the finding — ensures appropriate access control in reporting."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Whether the finding is visible to donors — tracks donor accountability transparency."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the finding — enables regional learning analysis."
    - name: "evaluation_id"
      expr: evaluation_id
      comment: "Foreign key to evaluation — enables finding-level drill-down from evaluation-level metrics."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Foreign key to partner organisation — enables partner-level accountability tracking."
    - name: "evaluation_finding_date_year"
      expr: DATE_TRUNC('YEAR', evaluation_finding_date)
      comment: "Year the finding was recorded — enables trend analysis of findings over time."
    - name: "target_completion_date_month"
      expr: DATE_TRUNC('MONTH', target_completion_date)
      comment: "Target month for recommendation completion — enables pipeline management of outstanding recommendations."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the finding — enables SDG-level learning and accountability reporting."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of evaluation findings recorded. Baseline metric for evaluation learning output — used to assess the volume of actionable insights generated."
    - name: "high_priority_findings_count"
      expr: COUNT(CASE WHEN priority_level = 'high' THEN 1 END)
      comment: "Count of high-priority findings. Tracks the volume of critical recommendations requiring urgent management attention — a key risk management metric."
    - name: "implemented_recommendations_count"
      expr: COUNT(CASE WHEN implementation_status = 'implemented' THEN 1 END)
      comment: "Count of recommendations with implemented status. Measures management response follow-through — low implementation rates signal accountability gaps and learning culture deficits."
    - name: "avg_implementation_progress_pct"
      expr: AVG(CAST(implementation_progress_percentage AS DOUBLE))
      comment: "Average implementation progress percentage across all findings. Tracks overall recommendation implementation momentum — used in quarterly accountability reviews."
    - name: "donor_visible_findings_count"
      expr: COUNT(CASE WHEN donor_visibility_flag = TRUE THEN 1 END)
      comment: "Count of findings visible to donors. Tracks transparency and donor accountability — used to ensure appropriate disclosure of evaluation results."
    - name: "overdue_recommendations_count"
      expr: COUNT(CASE WHEN target_completion_date < CURRENT_DATE AND implementation_status <> 'implemented' THEN 1 END)
      comment: "Count of recommendations past their target completion date and not yet implemented. Critical accountability metric — overdue recommendations represent unresolved programme risks."
    - name: "distinct_evaluations_with_findings"
      expr: COUNT(DISTINCT evaluation_id)
      comment: "Count of distinct evaluations that have generated findings. Measures evaluation learning output coverage — evaluations without findings may indicate quality issues."
    - name: "distinct_responsible_units"
      expr: COUNT(DISTINCT responsible_unit)
      comment: "Count of distinct organisational units with assigned recommendations. Measures breadth of accountability distribution — used to assess whether learning is organisation-wide."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_indicator_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on indicator target-setting quality, coverage, and revision patterns. Used by MEL managers and programme directors to govern target-setting rigour and donor reporting alignment."
  source: "`vibe_ngo_v1`.`mel`.`indicator_target`"
  dimensions:
    - name: "indicator_target_status"
      expr: indicator_target_status
      comment: "Status of the indicator target (draft, approved, revised, archived) — enables filtering to approved targets for reporting."
    - name: "indicator_target_type"
      expr: indicator_target_type
      comment: "Type of target (annual, cumulative, milestone) — enables analysis by target modality."
    - name: "measurement_frequency"
      expr: measurement_frequency
      comment: "Frequency at which the target is measured — enables workload planning for MEL teams."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the target — ensures correct interpretation of aggregated target values."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the target — enables SDG contribution target analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "DAC sector code — enables donor-aligned sector-level target analysis."
    - name: "disaggregation_sex"
      expr: disaggregation_sex
      comment: "Sex disaggregation of the target — enables gender-responsive target analysis."
    - name: "disaggregation_age_group"
      expr: disaggregation_age_group
      comment: "Age group disaggregation of the target — enables age-sensitive target analysis."
    - name: "indicator_id"
      expr: indicator_id
      comment: "Foreign key to indicator — enables indicator-level target portfolio analysis."
    - name: "intervention_id"
      expr: intervention_id
      comment: "Foreign key to intervention — enables intervention-level target analysis."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Foreign key to partner organisation — enables partner-level target assignment analysis."
    - name: "reporting_period_id"
      expr: reporting_period_id
      comment: "Foreign key to reporting period — enables period-level target analysis."
    - name: "approval_date_year"
      expr: DATE_TRUNC('YEAR', approval_date)
      comment: "Year of target approval — enables cohort analysis of target-setting over time."
    - name: "donor_reporting_requirement"
      expr: donor_reporting_requirement
      comment: "Donor reporting requirement associated with the target — enables donor compliance analysis."
  measures:
    - name: "total_indicator_targets"
      expr: COUNT(1)
      comment: "Total number of indicator targets defined. Baseline metric for MEL framework target coverage — used to assess completeness of target-setting across the programme."
    - name: "approved_targets_count"
      expr: COUNT(CASE WHEN indicator_target_status = 'approved' THEN 1 END)
      comment: "Count of approved indicator targets. Tracks target governance compliance — unapproved targets cannot be used for official donor reporting."
    - name: "total_target_value"
      expr: SUM(CAST(value AS DOUBLE))
      comment: "Sum of all indicator target values. Represents aggregate programme ambition — used in programme design reviews and donor negotiations."
    - name: "avg_target_value"
      expr: AVG(CAST(value AS DOUBLE))
      comment: "Average target value per indicator target. Benchmarks target ambition levels — outliers may indicate miscalibrated targets requiring review."
    - name: "total_baseline_value"
      expr: SUM(CAST(baseline_value AS DOUBLE))
      comment: "Sum of all baseline values associated with targets. Provides aggregate starting-point context for programme change measurement."
    - name: "revised_targets_count"
      expr: COUNT(CASE WHEN revision_date IS NOT NULL THEN 1 END)
      comment: "Count of targets that have been revised. Tracks target stability — high revision rates may indicate poor initial target-setting or significant programme changes."
    - name: "targets_with_donor_requirement_count"
      expr: COUNT(CASE WHEN donor_reporting_requirement IS NOT NULL AND donor_reporting_requirement <> '' THEN 1 END)
      comment: "Count of targets linked to donor reporting requirements. Tracks donor compliance coverage — ensures all donor-required targets are formally set and governed."
    - name: "distinct_indicators_with_targets"
      expr: COUNT(DISTINCT indicator_id)
      comment: "Count of distinct indicators with at least one target defined. Measures target-setting coverage across the indicator framework — indicators without targets cannot be assessed for achievement."
    - name: "distinct_partners_with_targets"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Count of distinct partner organisations with assigned targets. Tracks partner-level target assignment coverage — partners without targets lack accountability frameworks."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_meal_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on MEAL plan portfolio — budget allocation, coverage, and strategic alignment. Used by MEL directors and programme managers to govern the MEAL planning function and resource allocation."
  source: "`vibe_ngo_v1`.`mel`.`meal_plan`"
  dimensions:
    - name: "meal_plan_status"
      expr: meal_plan_status
      comment: "Current status of the MEAL plan (draft, approved, active, closed) — enables filtering to active plans."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the MEAL plan budget — required for multi-currency budget analysis."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the MEAL plan — enables SDG contribution planning analysis."
    - name: "rbm_framework_alignment"
      expr: rbm_framework_alignment
      comment: "Results-based management framework alignment — tracks adherence to RBM standards."
    - name: "chs_commitment_alignment"
      expr: chs_commitment_alignment
      comment: "Core Humanitarian Standard commitment alignment — tracks CHS compliance in MEAL planning."
    - name: "program_id"
      expr: program_id
      comment: "Foreign key to program — enables program-level MEAL plan analysis."
    - name: "country_office_id"
      expr: country_office_id
      comment: "Foreign key to country office — enables country-level MEAL planning analysis."
    - name: "intervention_id"
      expr: intervention_id
      comment: "Foreign key to intervention — enables intervention-level MEAL plan analysis."
    - name: "award_id"
      expr: award_id
      comment: "Foreign key to grant award — enables grant-level MEAL budget analysis."
    - name: "effective_start_date_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the MEAL plan became effective — enables annual MEAL planning trend analysis."
    - name: "approval_date_year"
      expr: DATE_TRUNC('YEAR', approval_date)
      comment: "Year of MEAL plan approval — enables analysis of planning governance timelines."
  measures:
    - name: "total_meal_plans"
      expr: COUNT(1)
      comment: "Total number of MEAL plans in the portfolio. Baseline metric for MEAL planning coverage — used to assess whether all programmes have active MEAL plans."
    - name: "approved_meal_plans_count"
      expr: COUNT(CASE WHEN meal_plan_status = 'approved' THEN 1 END)
      comment: "Count of approved MEAL plans. Tracks MEAL governance compliance — programmes without approved MEAL plans lack formal accountability frameworks."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated AS DOUBLE))
      comment: "Total budget allocated to MEAL activities across all plans. Tracks MEL investment — used to assess whether MEAL is adequately resourced relative to programme budgets."
    - name: "avg_budget_allocated"
      expr: AVG(CAST(budget_allocated AS DOUBLE))
      comment: "Average MEAL budget per plan. Benchmarks MEAL investment levels — low averages may indicate under-resourced MEL functions."
    - name: "plans_with_evaluation_strategy_count"
      expr: COUNT(CASE WHEN evaluation_strategy IS NOT NULL AND evaluation_strategy <> '' THEN 1 END)
      comment: "Count of MEAL plans with an evaluation strategy defined. Tracks evaluation planning completeness — plans without evaluation strategies lack accountability frameworks."
    - name: "plans_with_learning_agenda_count"
      expr: COUNT(CASE WHEN learning_agenda IS NOT NULL AND learning_agenda <> '' THEN 1 END)
      comment: "Count of MEAL plans with a learning agenda. Tracks organisational learning investment — learning agendas are a key indicator of MEL maturity."
    - name: "distinct_programs_with_meal_plans"
      expr: COUNT(DISTINCT program_id)
      comment: "Count of distinct programs with at least one MEAL plan. Measures MEAL coverage across the programme portfolio — gaps indicate programs without formal MEL frameworks."
    - name: "distinct_country_offices_with_meal_plans"
      expr: COUNT(DISTINCT country_office_id)
      comment: "Count of distinct country offices with MEAL plans. Tracks geographic MEAL coverage — used to identify country offices lacking formal MEL frameworks."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_logframe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on the MEL logframe portfolio — target achievement, framework coverage, and results-chain completeness. Used by programme directors and MEL managers to govern logframe quality and donor alignment."
  source: "`vibe_ngo_v1`.`mel`.`mel_logframe`"
  dimensions:
    - name: "mel_logframe_status"
      expr: mel_logframe_status
      comment: "Current status of the logframe entry (draft, approved, active, closed) — enables filtering to active logframes."
    - name: "results_chain_level"
      expr: results_chain_level
      comment: "Level in the results chain (input, activity, output, outcome, impact) — enables results-chain completeness analysis."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Reporting frequency for the logframe row — enables MEL workload planning."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the logframe indicator — ensures correct interpretation of values."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the logframe row — enables SDG contribution reporting."
    - name: "dac_evaluation_criterion"
      expr: dac_evaluation_criterion
      comment: "DAC evaluation criterion alignment — enables analysis against OECD DAC standards."
    - name: "theory_of_change_component"
      expr: theory_of_change_component
      comment: "Theory of change component the logframe row maps to — enables ToC coverage analysis."
    - name: "is_mandatory_donor_indicator"
      expr: is_mandatory_donor_indicator
      comment: "Whether this is a mandatory donor indicator — enables compliance tracking."
    - name: "is_custom_indicator"
      expr: is_custom_indicator
      comment: "Whether this is a custom indicator — enables portfolio standardisation analysis."
    - name: "program_id"
      expr: program_id
      comment: "Foreign key to program — enables program-level logframe analysis."
    - name: "intervention_id"
      expr: intervention_id
      comment: "Foreign key to intervention — enables intervention-level logframe analysis."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Foreign key to partner organisation — enables partner-level logframe analysis."
    - name: "effective_start_date_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the logframe row became effective — enables cohort analysis."
    - name: "donor_template_type"
      expr: donor_template_type
      comment: "Donor template type used for the logframe — enables donor-specific framework analysis."
  measures:
    - name: "total_logframe_rows"
      expr: COUNT(1)
      comment: "Total number of logframe rows. Baseline metric for logframe framework size — used to assess MEL framework scope and complexity."
    - name: "mandatory_donor_indicators_count"
      expr: COUNT(CASE WHEN is_mandatory_donor_indicator = TRUE THEN 1 END)
      comment: "Count of mandatory donor indicators in the logframe. Tracks donor compliance obligations — ensures all required donor indicators are represented in the logframe."
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Sum of all logframe target values. Represents aggregate programme ambition in the logframe — used in programme design and donor reporting."
    - name: "total_actual_value"
      expr: SUM(CAST(actual_value AS DOUBLE))
      comment: "Sum of all logframe actual values. Represents aggregate programme achievement recorded in the logframe — core KPI for programme performance reporting."
    - name: "total_baseline_value"
      expr: SUM(CAST(baseline_value AS DOUBLE))
      comment: "Sum of all logframe baseline values. Provides aggregate starting-point context for change measurement."
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual value per logframe row. Benchmarks per-indicator achievement — used to identify under-performing indicators."
    - name: "logframe_rows_with_sdg_alignment_count"
      expr: COUNT(CASE WHEN sdg_alignment IS NOT NULL AND sdg_alignment <> '' THEN 1 END)
      comment: "Count of logframe rows aligned to SDGs. Measures SDG contribution reporting readiness — critical for UN and institutional donor accountability."
    - name: "distinct_programs_in_logframe"
      expr: COUNT(DISTINCT program_id)
      comment: "Count of distinct programs represented in the logframe. Measures logframe coverage across the programme portfolio."
    - name: "active_logframe_rows_count"
      expr: COUNT(CASE WHEN mel_logframe_status = 'active' THEN 1 END)
      comment: "Count of currently active logframe rows. Tracks live logframe framework size — used in resource planning for data collection and reporting."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_reporting_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on reporting period governance — coverage, compliance deadlines, and data quality audit scheduling. Used by MEL managers to govern the reporting calendar and ensure timely data collection."
  source: "`vibe_ngo_v1`.`mel`.`reporting_period`"
  dimensions:
    - name: "reporting_period_status"
      expr: reporting_period_status
      comment: "Current status of the reporting period (open, closed, archived) — enables filtering to active periods."
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Type of reporting period (monthly, quarterly, annual, baseline, endline) — enables analysis by reporting cycle type."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Reporting frequency associated with the period — enables workload analysis by frequency."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the reporting period — enables fiscal-year-aligned performance analysis."
    - name: "calendar_year"
      expr: calendar_year
      comment: "Calendar year of the reporting period — enables calendar-year trend analysis."
    - name: "quarter_number"
      expr: quarter_number
      comment: "Quarter number within the year — enables quarterly performance analysis."
    - name: "program_id"
      expr: program_id
      comment: "Foreign key to program — enables program-level reporting period analysis."
    - name: "is_active"
      expr: is_active
      comment: "Whether the reporting period is currently active — enables filtering to live periods."
    - name: "baseline_period_flag"
      expr: baseline_period_flag
      comment: "Whether this is a baseline period — enables baseline-specific analysis."
    - name: "midline_period_flag"
      expr: midline_period_flag
      comment: "Whether this is a midline period — enables midline review analysis."
    - name: "endline_period_flag"
      expr: endline_period_flag
      comment: "Whether this is an endline period — enables endline evaluation analysis."
    - name: "data_quality_audit_flag"
      expr: data_quality_audit_flag
      comment: "Whether a data quality audit is scheduled for this period — tracks DQA compliance."
    - name: "donor_reporting_cycle"
      expr: donor_reporting_cycle
      comment: "Donor reporting cycle associated with the period — enables donor-aligned reporting analysis."
    - name: "start_date_year"
      expr: DATE_TRUNC('YEAR', start_date)
      comment: "Year the reporting period starts — enables annual reporting calendar analysis."
  measures:
    - name: "total_reporting_periods"
      expr: COUNT(1)
      comment: "Total number of reporting periods defined. Baseline metric for reporting calendar coverage — used to assess whether all required periods are formally defined."
    - name: "active_reporting_periods_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active reporting periods. Tracks live reporting obligations — used in MEL workload planning and resource allocation."
    - name: "closed_reporting_periods_count"
      expr: COUNT(CASE WHEN reporting_period_status = 'closed' THEN 1 END)
      comment: "Count of closed reporting periods. Tracks reporting cycle completion — used to assess historical reporting compliance."
    - name: "periods_with_dqa_scheduled_count"
      expr: COUNT(CASE WHEN data_quality_audit_flag = TRUE THEN 1 END)
      comment: "Count of reporting periods with a data quality audit scheduled. Tracks DQA coverage — ensures data quality is systematically verified across the reporting calendar."
    - name: "baseline_periods_count"
      expr: COUNT(CASE WHEN baseline_period_flag = TRUE THEN 1 END)
      comment: "Count of baseline reporting periods. Tracks baseline data collection coverage — programmes without baseline periods lack change measurement foundations."
    - name: "endline_periods_count"
      expr: COUNT(CASE WHEN endline_period_flag = TRUE THEN 1 END)
      comment: "Count of endline reporting periods. Tracks endline evaluation planning — programmes without endline periods lack final accountability evidence."
    - name: "overdue_submission_periods_count"
      expr: COUNT(CASE WHEN report_submission_deadline < CURRENT_DATE AND reporting_period_status <> 'closed' THEN 1 END)
      comment: "Count of reporting periods past their submission deadline and not yet closed. Critical compliance metric — overdue periods represent unmet donor and accountability obligations."
    - name: "distinct_programs_with_periods"
      expr: COUNT(DISTINCT program_id)
      comment: "Count of distinct programs with reporting periods defined. Measures reporting calendar coverage across the programme portfolio — gaps indicate programs without formal reporting schedules."
$$;