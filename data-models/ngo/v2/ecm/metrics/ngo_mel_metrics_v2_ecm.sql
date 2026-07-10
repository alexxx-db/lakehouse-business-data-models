-- Metric views for domain: mel | Business: Ngo | Version: 2 | Generated on: 2026-07-10 18:25:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_indicator_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core MEL performance tracking view measuring indicator achievement, variance from targets, and data quality across reporting periods. Used by MEL directors and program managers to assess program effectiveness and donor reporting compliance."
  source: "`vibe_ngo_v1`.`mel`.`indicator_result`"
  dimensions:
    - name: "indicator_id"
      expr: indicator_id
      comment: "Foreign key to the indicator being measured — enables slicing all KPIs by specific indicator."
    - name: "intervention_id"
      expr: intervention_id
      comment: "Foreign key to the program intervention — enables performance analysis by intervention."
    - name: "award_id"
      expr: award_id
      comment: "Foreign key to the grant award — enables donor-level performance reporting."
    - name: "reporting_period_start_date"
      expr: reporting_period_start_date
      comment: "Start of the reporting period for time-series trending of indicator results."
    - name: "reporting_period_end_date"
      expr: reporting_period_end_date
      comment: "End of the reporting period — used to bucket results into quarterly or annual periods."
    - name: "geographic_level"
      expr: geographic_level
      comment: "Geographic granularity of the result (national, regional, district) — enables geographic performance disaggregation."
    - name: "disaggregation_sex"
      expr: disaggregation_sex
      comment: "Sex disaggregation dimension — critical for gender-sensitive programming and donor reporting."
    - name: "disaggregation_age_group"
      expr: disaggregation_age_group
      comment: "Age group disaggregation — enables analysis of program reach by demographic cohort."
    - name: "disaggregation_displacement_status"
      expr: disaggregation_displacement_status
      comment: "Displacement status disaggregation — critical for humanitarian programming targeting IDPs and refugees."
    - name: "indicator_result_status"
      expr: indicator_result_status
      comment: "Verification/approval status of the result record — filters to verified vs. pending results."
    - name: "verification_status"
      expr: verification_status
      comment: "Data verification status — distinguishes verified, pending, and rejected results for quality-gated reporting."
    - name: "reported_to_donor"
      expr: reported_to_donor
      comment: "Flag indicating whether this result has been included in donor reporting — tracks reporting compliance."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Implementing partner — enables partner-level performance comparison."
    - name: "project_site_id"
      expr: project_site_id
      comment: "Project site where the result was collected — enables site-level performance analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the indicator result — ensures correct interpretation of aggregated values."
  measures:
    - name: "total_results_reported"
      expr: COUNT(1)
      comment: "Total number of indicator result records reported. Baseline volume metric for MEL pipeline health."
    - name: "total_actual_value"
      expr: SUM(CAST(value AS DOUBLE))
      comment: "Sum of all reported indicator result values. Core output/outcome achievement metric used in donor reports and program reviews."
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Sum of all indicator targets against which results are measured. Required denominator for achievement rate calculation."
    - name: "total_cumulative_result"
      expr: SUM(CAST(cumulative_result AS DOUBLE))
      comment: "Sum of cumulative indicator results — tracks lifetime program achievement against multi-year targets."
    - name: "avg_achievement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(value AS DOUBLE)) / NULLIF(SUM(CAST(target_value AS DOUBLE)), 0), 2)
      comment: "Average indicator achievement rate as a percentage of target. Primary KPI for program performance reviews and donor reporting — triggers intervention when below threshold."
    - name: "avg_variance_from_target"
      expr: AVG(CAST(variance_from_target AS DOUBLE))
      comment: "Average variance between actual and target values. Negative values signal underperformance requiring management action."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance from target across all results. Used in steering meetings to identify systemic over- or under-performance."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across all indicator results. Low scores trigger data quality investigations and affect donor confidence."
    - name: "verified_results_count"
      expr: COUNT(CASE WHEN verification_status = 'verified' THEN 1 END)
      comment: "Count of results that have passed verification. Measures MEL pipeline integrity and readiness for donor reporting."
    - name: "reported_to_donor_count"
      expr: COUNT(CASE WHEN reported_to_donor = TRUE THEN 1 END)
      comment: "Count of results already reported to donors. Tracks donor reporting compliance and coverage."
    - name: "donor_reporting_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reported_to_donor = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of verified results that have been reported to donors. Critical compliance KPI — low rates risk donor relationship and grant renewal."
    - name: "milestone_results_count"
      expr: COUNT(CASE WHEN is_milestone = TRUE THEN 1 END)
      comment: "Count of milestone indicator results. Milestones are contractually significant — tracking them separately supports grant compliance monitoring."
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline value across indicators. Provides context for interpreting achievement magnitude relative to starting conditions."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_indicator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic indicator portfolio view tracking the composition, coverage, and alignment of the organization's indicator framework. Used by MEL leadership to manage indicator quality, donor alignment, and SDG coverage."
  source: "`vibe_ngo_v1`.`mel`.`indicator`"
  dimensions:
    - name: "indicator_id"
      expr: indicator_id
      comment: "Primary key — enables drill-down to individual indicator performance."
    - name: "award_id"
      expr: award_id
      comment: "Grant award the indicator belongs to — enables award-level indicator portfolio analysis."
    - name: "intervention_id"
      expr: intervention_id
      comment: "Program intervention the indicator measures — enables intervention-level results framework analysis."
    - name: "indicator_type"
      expr: indicator_type
      comment: "Type of indicator (output, outcome, impact) — enables results chain analysis."
    - name: "indicator_category"
      expr: indicator_category
      comment: "Thematic category of the indicator — enables sector-level portfolio analysis."
    - name: "logframe_level"
      expr: logframe_level
      comment: "Position in the logframe hierarchy (goal, purpose, output, activity) — critical for results chain completeness assessment."
    - name: "indicator_status"
      expr: indicator_status
      comment: "Current status of the indicator (active, suspended, completed) — filters to active portfolio."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the indicator is mandatory for donor reporting — distinguishes contractual from voluntary indicators."
    - name: "is_custom"
      expr: is_custom
      comment: "Whether the indicator is custom-designed vs. standard — informs indicator harmonization decisions."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "How often the indicator is reported — enables workload planning for MEL teams."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG goal alignment — enables SDG contribution reporting to donors and boards."
    - name: "sector"
      expr: sector
      comment: "Sector the indicator belongs to (health, education, WASH) — enables sector portfolio analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure — ensures correct aggregation and interpretation of indicator values."
    - name: "direction_of_change"
      expr: direction_of_change
      comment: "Expected direction of change (increase/decrease) — used to correctly interpret achievement rates."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Partner organization responsible for the indicator — enables partner accountability analysis."
  measures:
    - name: "total_indicators"
      expr: COUNT(1)
      comment: "Total number of indicators in the portfolio. Baseline measure for results framework size and MEL workload."
    - name: "mandatory_indicators_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END)
      comment: "Count of mandatory donor-required indicators. Tracks contractual compliance obligations — missing mandatory indicators risk grant non-compliance."
    - name: "custom_indicators_count"
      expr: COUNT(CASE WHEN is_custom = TRUE THEN 1 END)
      comment: "Count of custom indicators. High custom indicator counts increase MEL burden — informs standardization decisions."
    - name: "mandatory_indicator_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of indicators that are mandatory. High rates indicate heavy donor compliance burden; informs resource allocation for MEL teams."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across indicators. Provides scale context for program ambition and resource adequacy assessments."
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline value across indicators. Contextualizes the magnitude of change the program aims to achieve."
    - name: "active_indicators_count"
      expr: COUNT(CASE WHEN indicator_status = 'active' THEN 1 END)
      comment: "Count of currently active indicators. Tracks live MEL workload and results framework coverage."
    - name: "distinct_awards_covered"
      expr: COUNT(DISTINCT award_id)
      comment: "Number of distinct grant awards with indicators. Measures breadth of MEL coverage across the grant portfolio."
    - name: "distinct_interventions_covered"
      expr: COUNT(DISTINCT intervention_id)
      comment: "Number of distinct interventions with indicators. Ensures all program interventions have measurable indicators — gaps signal results framework weaknesses."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_indicator_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Indicator target-setting and planning view tracking target ambition, disaggregation coverage, and alignment with donor requirements. Used by MEL and program teams to manage target-setting quality and reporting obligations."
  source: "`vibe_ngo_v1`.`mel`.`indicator_target`"
  dimensions:
    - name: "indicator_id"
      expr: indicator_id
      comment: "Indicator the target belongs to — enables target analysis by indicator."
    - name: "award_id"
      expr: award_id
      comment: "Grant award the target is set under — enables award-level target portfolio review."
    - name: "intervention_id"
      expr: intervention_id
      comment: "Program intervention the target supports — enables intervention-level planning analysis."
    - name: "reporting_period_id"
      expr: reporting_period_id
      comment: "Reporting period the target applies to — enables time-phased target analysis."
    - name: "indicator_target_type"
      expr: indicator_target_type
      comment: "Type of target (annual, cumulative, milestone) — enables target structure analysis."
    - name: "indicator_target_status"
      expr: indicator_target_status
      comment: "Approval/active status of the target — filters to approved targets for reporting."
    - name: "measurement_frequency"
      expr: measurement_frequency
      comment: "How frequently the target is measured — informs MEL data collection scheduling."
    - name: "disaggregation_sex"
      expr: disaggregation_sex
      comment: "Sex disaggregation of the target — tracks gender-sensitive target-setting."
    - name: "disaggregation_age_group"
      expr: disaggregation_age_group
      comment: "Age group disaggregation of the target — tracks demographic-specific target coverage."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the target — enables SDG contribution planning analysis."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Partner responsible for achieving the target — enables partner accountability tracking."
    - name: "geographic_scope_id"
      expr: geographic_scope_id
      comment: "Geographic scope of the target — enables geographic target distribution analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the target value — ensures correct interpretation of aggregated targets."
  measures:
    - name: "total_targets"
      expr: COUNT(1)
      comment: "Total number of indicator targets set. Baseline measure for target-setting completeness."
    - name: "total_target_value"
      expr: SUM(CAST(value AS DOUBLE))
      comment: "Sum of all target values. Represents the aggregate program ambition — used in portfolio-level planning and donor negotiations."
    - name: "total_baseline_value"
      expr: SUM(CAST(baseline_value AS DOUBLE))
      comment: "Sum of baseline values across all targets. Provides aggregate starting-point context for program change measurement."
    - name: "avg_target_value"
      expr: AVG(CAST(value AS DOUBLE))
      comment: "Average target value per indicator target record. Informs target-setting benchmarking across interventions and partners."
    - name: "distinct_indicators_with_targets"
      expr: COUNT(DISTINCT indicator_id)
      comment: "Number of distinct indicators that have targets set. Gaps indicate indicators without measurable targets — a results framework quality risk."
    - name: "distinct_reporting_periods_covered"
      expr: COUNT(DISTINCT reporting_period_id)
      comment: "Number of distinct reporting periods with targets. Ensures multi-period target coverage for longitudinal program planning."
    - name: "approved_targets_count"
      expr: COUNT(CASE WHEN indicator_target_status = 'approved' THEN 1 END)
      comment: "Count of approved targets. Unapproved targets cannot be used for donor reporting — tracks approval pipeline health."
    - name: "target_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN indicator_target_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of targets that are approved. Low approval rates delay donor reporting and signal governance bottlenecks."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Evaluation portfolio management view tracking evaluation quality, cost efficiency, and DAC criteria coverage. Used by MEL directors and senior leadership to assess organizational learning investment and evaluation quality."
  source: "`vibe_ngo_v1`.`mel`.`evaluation`"
  dimensions:
    - name: "evaluation_id"
      expr: evaluation_id
      comment: "Primary key — enables drill-down to individual evaluation records."
    - name: "award_id"
      expr: award_id
      comment: "Grant award the evaluation covers — enables award-level evaluation portfolio analysis."
    - name: "intervention_id"
      expr: intervention_id
      comment: "Program intervention being evaluated — enables intervention-level learning analysis."
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of evaluation (midterm, endline, real-time, impact) — enables evaluation portfolio composition analysis."
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current status of the evaluation (planned, in-progress, completed) — tracks evaluation pipeline."
    - name: "evaluator_type"
      expr: evaluator_type
      comment: "Internal vs. external evaluator — informs independence and cost analysis."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall evaluation quality rating — enables portfolio-level quality assessment."
    - name: "management_response_status"
      expr: management_response_status
      comment: "Status of management response to evaluation findings — tracks organizational accountability for learning."
    - name: "ethics_approval_obtained"
      expr: ethics_approval_obtained
      comment: "Whether ethics approval was obtained — critical compliance dimension for research ethics governance."
    - name: "quality_assurance_conducted"
      expr: quality_assurance_conducted
      comment: "Whether QA was conducted on the evaluation — tracks evaluation quality assurance coverage."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of evaluation budget and cost figures — required for multi-currency portfolio analysis."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Partner organization involved in the evaluation — enables partner-level evaluation analysis."
  measures:
    - name: "total_evaluations"
      expr: COUNT(1)
      comment: "Total number of evaluations in the portfolio. Baseline measure for organizational learning investment volume."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted cost of all evaluations. Tracks organizational investment in evidence generation — used in MEL budget planning."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of completed evaluations. Compared against budget to assess evaluation cost management."
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average cost per evaluation. Benchmarks evaluation cost efficiency and informs future budget planning."
    - name: "cost_variance"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(budget_amount AS DOUBLE))
      comment: "Total cost variance (actual minus budget) across all evaluations. Positive values indicate cost overruns requiring management attention."
    - name: "completed_evaluations_count"
      expr: COUNT(CASE WHEN evaluation_status = 'completed' THEN 1 END)
      comment: "Count of completed evaluations. Tracks evaluation pipeline throughput and organizational learning output."
    - name: "ethics_approved_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ethics_approval_obtained = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of evaluations with ethics approval obtained. Low rates signal research ethics compliance risk — critical for donor and IRB accountability."
    - name: "qa_conducted_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_assurance_conducted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of evaluations where quality assurance was conducted. Tracks evaluation quality governance — low rates risk poor-quality evidence for decision-making."
    - name: "management_response_pending_count"
      expr: COUNT(CASE WHEN management_response_status = 'pending' THEN 1 END)
      comment: "Count of evaluations awaiting management response. Unresponded evaluations signal accountability gaps — tracked in organizational learning governance reviews."
    - name: "distinct_awards_evaluated"
      expr: COUNT(DISTINCT award_id)
      comment: "Number of distinct grant awards with evaluations. Measures evaluation coverage across the grant portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_evaluation_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Evaluation findings and management response tracking view. Used by MEL and program leadership to monitor recommendation implementation, accountability for learning, and cross-cutting theme coverage."
  source: "`vibe_ngo_v1`.`mel`.`evaluation_finding`"
  dimensions:
    - name: "evaluation_id"
      expr: evaluation_id
      comment: "Parent evaluation — enables finding analysis by evaluation."
    - name: "award_id"
      expr: award_id
      comment: "Grant award the finding relates to — enables award-level learning analysis."
    - name: "intervention_id"
      expr: intervention_id
      comment: "Program intervention the finding relates to — enables intervention-level learning."
    - name: "evaluation_finding_type"
      expr: evaluation_finding_type
      comment: "Type of finding (recommendation, lesson learned, good practice) — enables portfolio analysis by finding category."
    - name: "dac_criterion"
      expr: dac_criterion
      comment: "DAC evaluation criterion the finding addresses (relevance, effectiveness, efficiency, impact, sustainability) — tracks DAC criteria coverage."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the finding — enables triage of high-priority recommendations."
    - name: "implementation_status"
      expr: implementation_status
      comment: "Status of recommendation implementation — tracks organizational accountability for acting on findings."
    - name: "rating"
      expr: rating
      comment: "Rating of the finding — enables quality-weighted analysis of evaluation findings."
    - name: "cross_cutting_theme"
      expr: cross_cutting_theme
      comment: "Cross-cutting theme (gender, protection, environment) — enables thematic learning analysis."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the finding — enables SDG-linked learning reporting."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Whether the finding is visible to donors — tracks donor-facing learning transparency."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Partner organization the finding relates to — enables partner accountability analysis."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of evaluation findings. Baseline measure for organizational learning output volume."
    - name: "implemented_findings_count"
      expr: COUNT(CASE WHEN implementation_status = 'implemented' THEN 1 END)
      comment: "Count of findings where recommendations have been fully implemented. Core accountability metric — low implementation rates signal organizational learning failures."
    - name: "implementation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN implementation_status = 'implemented' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of evaluation findings that have been implemented. Primary learning accountability KPI — tracked in board and donor reviews."
    - name: "avg_implementation_progress_pct"
      expr: AVG(CAST(implementation_progress_percentage AS DOUBLE))
      comment: "Average implementation progress percentage across all findings. Tracks overall recommendation uptake momentum."
    - name: "high_priority_findings_count"
      expr: COUNT(CASE WHEN priority_level = 'high' THEN 1 END)
      comment: "Count of high-priority findings. High-priority unimplemented findings represent the greatest organizational risk — tracked in steering meetings."
    - name: "donor_visible_findings_count"
      expr: COUNT(CASE WHEN donor_visibility_flag = TRUE THEN 1 END)
      comment: "Count of findings visible to donors. Tracks transparency and donor engagement in organizational learning."
    - name: "overdue_findings_count"
      expr: COUNT(CASE WHEN target_completion_date < CURRENT_DATE AND implementation_status != 'implemented' THEN 1 END)
      comment: "Count of findings past their target completion date that are not yet implemented. Overdue findings signal accountability failures requiring escalation."
    - name: "distinct_evaluations_with_findings"
      expr: COUNT(DISTINCT evaluation_id)
      comment: "Number of distinct evaluations that have generated findings. Measures evaluation output quality — evaluations without findings may indicate quality issues."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_data_quality_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data quality assessment tracking view measuring MEL data integrity across accuracy, completeness, consistency, and timeliness dimensions. Used by MEL managers and compliance teams to ensure data quality standards for donor reporting."
  source: "`vibe_ngo_v1`.`mel`.`data_quality_assessment`"
  dimensions:
    - name: "data_quality_assessment_id"
      expr: data_quality_assessment_id
      comment: "Primary key — enables drill-down to individual DQA records."
    - name: "award_id"
      expr: award_id
      comment: "Grant award the DQA covers — enables award-level data quality analysis."
    - name: "indicator_id"
      expr: indicator_id
      comment: "Indicator assessed — enables indicator-level data quality tracking."
    - name: "intervention_id"
      expr: intervention_id
      comment: "Program intervention the DQA covers — enables intervention-level quality analysis."
    - name: "data_quality_assessment_type"
      expr: data_quality_assessment_type
      comment: "Type of DQA (routine, special, donor-requested) — enables analysis by assessment trigger."
    - name: "data_quality_assessment_status"
      expr: data_quality_assessment_status
      comment: "Current status of the DQA — filters to completed assessments for quality scoring."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions from the DQA — tracks remediation pipeline."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the DQA — enables triage of high-priority quality issues."
    - name: "data_source_type"
      expr: data_source_type
      comment: "Type of data source assessed — enables quality analysis by data collection modality."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Partner organization whose data was assessed — enables partner-level data quality benchmarking."
    - name: "project_site_id"
      expr: project_site_id
      comment: "Project site where data was collected — enables site-level quality analysis."
    - name: "data_quality_assessment_date"
      expr: data_quality_assessment_date
      comment: "Date of the assessment — enables time-series quality trend analysis."
  measures:
    - name: "total_dqa_assessments"
      expr: COUNT(1)
      comment: "Total number of data quality assessments conducted. Baseline measure for DQA coverage and MEL quality governance activity."
    - name: "avg_overall_dqa_score_pct"
      expr: AVG(CAST(overall_dqa_score_percentage AS DOUBLE))
      comment: "Average overall DQA score across all assessments. Primary data quality KPI — scores below threshold trigger mandatory corrective action and affect donor reporting credibility."
    - name: "avg_accuracy_score_pct"
      expr: AVG(CAST(accuracy_score_percentage AS DOUBLE))
      comment: "Average accuracy score across DQAs. Low accuracy scores indicate systematic data collection errors requiring process redesign."
    - name: "avg_completeness_score_pct"
      expr: AVG(CAST(completeness_score_percentage AS DOUBLE))
      comment: "Average completeness score across DQAs. Incomplete data undermines indicator results and donor reporting — tracked as a core quality dimension."
    - name: "avg_consistency_score_pct"
      expr: AVG(CAST(consistency_score_percentage AS DOUBLE))
      comment: "Average consistency score across DQAs. Inconsistent data signals process or training failures across data collection teams."
    - name: "avg_timeliness_score_pct"
      expr: AVG(CAST(timeliness_score_percentage AS DOUBLE))
      comment: "Average timeliness score across DQAs. Late data collection jeopardizes donor reporting deadlines — tracked as a compliance risk indicator."
    - name: "corrective_action_pending_count"
      expr: COUNT(CASE WHEN corrective_action_status = 'pending' THEN 1 END)
      comment: "Count of DQAs with pending corrective actions. Unresolved corrective actions represent ongoing data quality risk — escalated in MEL governance reviews."
    - name: "corrective_action_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DQAs where corrective actions have been completed. Measures organizational responsiveness to data quality findings."
    - name: "high_priority_dqa_count"
      expr: COUNT(CASE WHEN priority_level = 'high' THEN 1 END)
      comment: "Count of high-priority DQAs. High-priority quality issues with unresolved corrective actions represent the greatest risk to donor reporting integrity."
    - name: "distinct_partners_assessed"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of distinct partner organizations whose data quality has been assessed. Measures DQA coverage across the partner portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_logframe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Logframe portfolio management view tracking results framework coverage, target achievement, and donor alignment. Per VREQ-003, mel.mel_logframe is the SSOT owner for logframe entities. Used by MEL directors and program managers to manage results frameworks across the grant portfolio."
  source: "`vibe_ngo_v1`.`mel`.`mel_logframe`"
  dimensions:
    - name: "mel_logframe_id"
      expr: mel_logframe_id
      comment: "Primary key — enables drill-down to individual logframe entries."
    - name: "grant_award_id"
      expr: grant_award_id
      comment: "Grant award the logframe belongs to — enables award-level results framework analysis."
    - name: "intervention_id"
      expr: intervention_id
      comment: "Program intervention the logframe entry measures — enables intervention-level results chain analysis."
    - name: "results_chain_level"
      expr: results_chain_level
      comment: "Level in the results chain (input, activity, output, outcome, impact) — enables results chain completeness analysis."
    - name: "mel_logframe_status"
      expr: mel_logframe_status
      comment: "Current status of the logframe entry — filters to active entries for reporting."
    - name: "is_mandatory_donor_indicator"
      expr: is_mandatory_donor_indicator
      comment: "Whether this is a mandatory donor indicator — distinguishes contractual from voluntary logframe entries."
    - name: "is_custom_indicator"
      expr: is_custom_indicator
      comment: "Whether this is a custom indicator — informs standardization and harmonization decisions."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Reporting frequency for this logframe entry — informs MEL data collection scheduling."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the logframe entry — enables SDG contribution reporting."
    - name: "donor_template_type"
      expr: donor_template_type
      comment: "Donor template type the logframe follows — enables donor-specific results framework analysis."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Partner organization responsible for the logframe entry — enables partner accountability analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for logframe values — ensures correct interpretation of aggregated figures."
  measures:
    - name: "total_logframe_entries"
      expr: COUNT(1)
      comment: "Total number of logframe entries. Baseline measure for results framework size and complexity."
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Sum of all logframe target values. Represents aggregate program ambition across the results framework."
    - name: "total_actual_value"
      expr: SUM(CAST(actual_value AS DOUBLE))
      comment: "Sum of all logframe actual values. Tracks aggregate results framework achievement."
    - name: "total_baseline_value"
      expr: SUM(CAST(baseline_value AS DOUBLE))
      comment: "Sum of baseline values across all logframe entries. Provides aggregate starting-point context."
    - name: "avg_achievement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_value AS DOUBLE)) / NULLIF(SUM(CAST(target_value AS DOUBLE)), 0), 2)
      comment: "Average logframe achievement rate as percentage of target. Primary results framework performance KPI used in donor reports and board reviews."
    - name: "mandatory_donor_indicator_count"
      expr: COUNT(CASE WHEN is_mandatory_donor_indicator = TRUE THEN 1 END)
      comment: "Count of mandatory donor indicators in the logframe. Tracks contractual compliance obligations — missing entries risk grant non-compliance."
    - name: "mandatory_indicator_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_mandatory_donor_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of logframe entries that are mandatory donor indicators. High rates indicate heavy donor compliance burden."
    - name: "active_logframe_entries_count"
      expr: COUNT(CASE WHEN mel_logframe_status = 'active' THEN 1 END)
      comment: "Count of currently active logframe entries. Tracks live results framework scope and MEL workload."
    - name: "distinct_awards_in_logframe"
      expr: COUNT(DISTINCT grant_award_id)
      comment: "Number of distinct grant awards with logframe entries. Measures results framework coverage across the grant portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_meal_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MEAL plan portfolio view tracking MEL investment, planning quality, and strategic alignment across programs. Used by MEL directors and program managers to assess MEAL system coverage and resource adequacy."
  source: "`vibe_ngo_v1`.`mel`.`meal_plan`"
  dimensions:
    - name: "meal_plan_id"
      expr: meal_plan_id
      comment: "Primary key — enables drill-down to individual MEAL plans."
    - name: "award_id"
      expr: award_id
      comment: "Grant award the MEAL plan covers — enables award-level MEAL investment analysis."
    - name: "intervention_id"
      expr: intervention_id
      comment: "Program intervention the MEAL plan supports — enables intervention-level MEAL coverage analysis."
    - name: "meal_plan_status"
      expr: meal_plan_status
      comment: "Current status of the MEAL plan (draft, approved, active, closed) — filters to active plans."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of MEAL budget figures — required for multi-currency portfolio analysis."
    - name: "mel_logframe_id"
      expr: mel_logframe_id
      comment: "Linked logframe — enables analysis of MEAL plans with and without logframe coverage."
    - name: "partnership_agreement_id"
      expr: partnership_agreement_id
      comment: "Partnership agreement the MEAL plan covers — enables partner-level MEAL investment analysis."
  measures:
    - name: "total_meal_plans"
      expr: COUNT(1)
      comment: "Total number of MEAL plans. Baseline measure for MEAL system coverage across the program portfolio."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated AS DOUBLE))
      comment: "Total MEAL budget allocated across all plans. Tracks organizational investment in monitoring, evaluation, accountability, and learning."
    - name: "avg_budget_allocated"
      expr: AVG(CAST(budget_allocated AS DOUBLE))
      comment: "Average MEAL budget per plan. Benchmarks MEAL investment adequacy — low averages may indicate under-resourced MEL systems."
    - name: "active_meal_plans_count"
      expr: COUNT(CASE WHEN meal_plan_status = 'active' THEN 1 END)
      comment: "Count of currently active MEAL plans. Tracks live MEL system coverage across the program portfolio."
    - name: "approved_meal_plans_count"
      expr: COUNT(CASE WHEN meal_plan_status = 'approved' THEN 1 END)
      comment: "Count of approved MEAL plans. Unapproved plans cannot be operationalized — tracks approval pipeline health."
    - name: "distinct_awards_with_meal_plans"
      expr: COUNT(DISTINCT award_id)
      comment: "Number of distinct grant awards with MEAL plans. Awards without MEAL plans represent MEL coverage gaps — a compliance and quality risk."
    - name: "plans_with_logframe_count"
      expr: COUNT(CASE WHEN mel_logframe_id IS NOT NULL THEN 1 END)
      comment: "Count of MEAL plans linked to a logframe. MEAL plans without logframes lack a results framework — a structural quality gap."
    - name: "logframe_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mel_logframe_id IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of MEAL plans linked to a logframe. Low coverage rates indicate results framework gaps requiring remediation."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_reporting_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reporting period management view tracking reporting cycle health, deadline compliance, and data collection scheduling. Used by MEL managers to ensure timely data collection and donor reporting across all active periods."
  source: "`vibe_ngo_v1`.`mel`.`reporting_period`"
  dimensions:
    - name: "reporting_period_id"
      expr: reporting_period_id
      comment: "Primary key — enables drill-down to individual reporting periods."
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Type of reporting period (monthly, quarterly, annual, midline, endline) — enables analysis by reporting cycle type."
    - name: "reporting_period_status"
      expr: reporting_period_status
      comment: "Current status of the reporting period (open, closed, overdue) — tracks reporting pipeline health."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of reporting — enables workload analysis by reporting cadence."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year the reporting period falls in — enables annual reporting cycle analysis."
    - name: "calendar_year"
      expr: calendar_year
      comment: "Calendar year — enables year-over-year reporting trend analysis."
    - name: "quarter_number"
      expr: quarter_number
      comment: "Quarter number — enables quarterly reporting cycle analysis."
    - name: "is_active"
      expr: is_active
      comment: "Whether the reporting period is currently active — filters to live reporting periods."
    - name: "baseline_period_flag"
      expr: baseline_period_flag
      comment: "Whether this is a baseline reporting period — enables baseline vs. follow-up period analysis."
    - name: "midline_period_flag"
      expr: midline_period_flag
      comment: "Whether this is a midline reporting period — enables midline evaluation scheduling analysis."
    - name: "endline_period_flag"
      expr: endline_period_flag
      comment: "Whether this is an endline reporting period — enables endline evaluation scheduling analysis."
    - name: "data_quality_audit_flag"
      expr: data_quality_audit_flag
      comment: "Whether a data quality audit is scheduled for this period — tracks DQA coverage across reporting cycles."
    - name: "mel_logframe_id"
      expr: mel_logframe_id
      comment: "Linked logframe — enables reporting period analysis by results framework."
    - name: "start_date"
      expr: start_date
      comment: "Start date of the reporting period — enables time-series analysis of reporting cycles."
    - name: "end_date"
      expr: end_date
      comment: "End date of the reporting period — used for deadline tracking and period duration analysis."
  measures:
    - name: "total_reporting_periods"
      expr: COUNT(1)
      comment: "Total number of reporting periods. Baseline measure for reporting cycle volume and MEL calendar complexity."
    - name: "active_reporting_periods_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active reporting periods. Tracks live reporting workload — high counts signal MEL team capacity pressure."
    - name: "overdue_reporting_periods_count"
      expr: COUNT(CASE WHEN report_submission_deadline < CURRENT_DATE AND reporting_period_status != 'closed' THEN 1 END)
      comment: "Count of reporting periods past their submission deadline that are not yet closed. Overdue periods risk donor relationship damage and grant compliance violations."
    - name: "dqa_scheduled_periods_count"
      expr: COUNT(CASE WHEN data_quality_audit_flag = TRUE THEN 1 END)
      comment: "Count of reporting periods with a data quality audit scheduled. Tracks DQA coverage across the reporting calendar — gaps indicate quality governance risks."
    - name: "dqa_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN data_quality_audit_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reporting periods with a DQA scheduled. Low coverage rates indicate insufficient data quality governance across the reporting cycle."
    - name: "baseline_periods_count"
      expr: COUNT(CASE WHEN baseline_period_flag = TRUE THEN 1 END)
      comment: "Count of baseline reporting periods. Tracks baseline data collection coverage — missing baselines undermine impact measurement."
    - name: "endline_periods_count"
      expr: COUNT(CASE WHEN endline_period_flag = TRUE THEN 1 END)
      comment: "Count of endline reporting periods. Tracks endline evaluation scheduling — missing endlines prevent impact assessment and donor accountability."
    - name: "closed_periods_count"
      expr: COUNT(CASE WHEN reporting_period_status = 'closed' THEN 1 END)
      comment: "Count of closed reporting periods. Measures reporting cycle completion rate — used to track MEL pipeline throughput."
    - name: "period_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reporting_period_status = 'closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reporting periods that have been closed. Low closure rates indicate reporting backlogs requiring management intervention."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_data_collection_tool`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data collection tool portfolio view tracking tool deployment, approval status, and ethical compliance. Used by MEL managers to ensure data collection infrastructure is fit-for-purpose and ethically compliant."
  source: "`vibe_ngo_v1`.`mel`.`data_collection_tool`"
  dimensions:
    - name: "data_collection_tool_id"
      expr: data_collection_tool_id
      comment: "Primary key — enables drill-down to individual data collection tools."
    - name: "data_collection_tool_type"
      expr: data_collection_tool_type
      comment: "Type of tool (survey, KII guide, FGD guide, observation checklist) — enables portfolio analysis by tool type."
    - name: "data_collection_tool_status"
      expr: data_collection_tool_status
      comment: "Current status of the tool (draft, approved, deployed, retired) — filters to active tools."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the tool — tracks governance compliance for data collection."
    - name: "ethical_review_status"
      expr: ethical_review_status
      comment: "Ethics review status — critical compliance dimension for research ethics governance."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Data collection method (face-to-face, phone, digital) — enables method-level analysis."
    - name: "data_protection_compliance"
      expr: data_protection_compliance
      comment: "Data protection compliance status — tracks GDPR and data protection policy adherence."
    - name: "respondent_type"
      expr: respondent_type
      comment: "Type of respondent (beneficiary, community leader, staff) — enables tool coverage analysis by target population."
    - name: "award_id"
      expr: award_id
      comment: "Grant award the tool is used for — enables award-level tool portfolio analysis."
    - name: "intervention_id"
      expr: intervention_id
      comment: "Program intervention the tool supports — enables intervention-level data collection analysis."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the tool — enables language coverage analysis for inclusive data collection."
    - name: "deployment_start_date"
      expr: deployment_start_date
      comment: "Tool deployment start date — enables time-series analysis of data collection activity."
  measures:
    - name: "total_tools"
      expr: COUNT(1)
      comment: "Total number of data collection tools. Baseline measure for MEL data collection infrastructure size."
    - name: "approved_tools_count"
      expr: COUNT(CASE WHEN approval_status = 'approved' THEN 1 END)
      comment: "Count of approved data collection tools. Unapproved tools cannot be deployed — tracks governance compliance."
    - name: "tool_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tools that are approved. Low approval rates indicate governance bottlenecks delaying data collection."
    - name: "ethics_approved_tools_count"
      expr: COUNT(CASE WHEN ethical_review_status = 'approved' THEN 1 END)
      comment: "Count of tools with ethics approval. Tools without ethics approval cannot be used for primary data collection — a critical compliance risk."
    - name: "ethics_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ethical_review_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tools with ethics approval. Low rates signal research ethics compliance risk across the data collection portfolio."
    - name: "deployed_tools_count"
      expr: COUNT(CASE WHEN data_collection_tool_status = 'deployed' THEN 1 END)
      comment: "Count of currently deployed tools. Tracks active data collection infrastructure — used in MEL capacity planning."
    - name: "distinct_awards_with_tools"
      expr: COUNT(DISTINCT award_id)
      comment: "Number of distinct grant awards with data collection tools. Awards without tools have no primary data collection infrastructure — a MEL coverage gap."
    - name: "distinct_interventions_with_tools"
      expr: COUNT(DISTINCT intervention_id)
      comment: "Number of distinct interventions with data collection tools. Interventions without tools cannot generate primary evidence — a results framework risk."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_geographic_scope`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Geographic scope portfolio view tracking program geographic coverage, vulnerability context, and population reach. Used by MEL and program teams to assess geographic targeting adequacy and humanitarian context. Note: latitude and longitude are PII-candidate attributes per VREQ-062 and should be tagged restricted/confidential."
  source: "`vibe_ngo_v1`.`mel`.`geographic_scope`"
  dimensions:
    - name: "geographic_scope_id"
      expr: geographic_scope_id
      comment: "Primary key — enables drill-down to individual geographic scope records."
    - name: "geographic_scope_type"
      expr: geographic_scope_type
      comment: "Type of geographic scope (country, region, district, community) — enables analysis by administrative level."
    - name: "geographic_scope_status"
      expr: geographic_scope_status
      comment: "Current status of the geographic scope — filters to active program geographies."
    - name: "administrative_level"
      expr: administrative_level
      comment: "Administrative level of the scope — enables hierarchical geographic analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country code — enables country-level geographic portfolio analysis."
    - name: "country_name"
      expr: country_name
      comment: "Country name — human-readable country dimension for dashboards."
    - name: "conflict_affected_flag"
      expr: conflict_affected_flag
      comment: "Whether the area is conflict-affected — critical context for humanitarian programming targeting decisions."
    - name: "disaster_prone_flag"
      expr: disaster_prone_flag
      comment: "Whether the area is disaster-prone — informs risk-sensitive programming and resource pre-positioning."
    - name: "hard_to_reach_flag"
      expr: hard_to_reach_flag
      comment: "Whether the area is hard-to-reach — informs access planning and cost modeling for field operations."
    - name: "urban_rural_classification"
      expr: urban_rural_classification
      comment: "Urban/rural classification — enables urban vs. rural program reach analysis."
    - name: "region_name"
      expr: region_name
      comment: "Region name — enables regional geographic analysis."
  measures:
    - name: "total_geographic_scopes"
      expr: COUNT(1)
      comment: "Total number of geographic scope records. Baseline measure for program geographic footprint."
    - name: "total_population_estimate"
      expr: SUM(CAST(population_estimate AS DOUBLE))
      comment: "Total estimated population across all program geographic scopes. Measures potential program reach — core KPI for scale and coverage reporting to donors and boards."
    - name: "avg_population_estimate"
      expr: AVG(CAST(population_estimate AS DOUBLE))
      comment: "Average population per geographic scope. Informs geographic targeting equity — very low averages may indicate over-fragmented geographic coverage."
    - name: "total_area_square_km"
      expr: SUM(CAST(area_square_km AS DOUBLE))
      comment: "Total geographic area covered in square kilometers. Measures program geographic footprint — used in coverage density analysis."
    - name: "conflict_affected_scope_count"
      expr: COUNT(CASE WHEN conflict_affected_flag = TRUE THEN 1 END)
      comment: "Count of geographic scopes in conflict-affected areas. Tracks humanitarian programming reach in the most vulnerable contexts."
    - name: "conflict_affected_population"
      expr: SUM(CASE WHEN conflict_affected_flag = TRUE THEN population_estimate ELSE 0 END)
      comment: "Total population in conflict-affected program areas. Critical KPI for humanitarian mandate accountability — reported to donors and humanitarian coordination bodies."
    - name: "hard_to_reach_scope_count"
      expr: COUNT(CASE WHEN hard_to_reach_flag = TRUE THEN 1 END)
      comment: "Count of hard-to-reach geographic scopes. High counts indicate significant access challenges — informs operational planning and cost modeling."
    - name: "avg_vulnerability_index"
      expr: AVG(CAST(vulnerability_index AS DOUBLE))
      comment: "Average vulnerability index across program geographic scopes. Higher values indicate more vulnerable target populations — used to assess program targeting quality and humanitarian prioritization."
    - name: "distinct_countries_covered"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of distinct countries in the program geographic portfolio. Measures organizational geographic reach — used in annual reports and donor communications."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_learning_agenda`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Learning agenda portfolio view tracking organizational learning investment, question coverage, and evidence generation progress. Used by MEL directors and senior leadership to manage the organizational learning agenda and ensure evidence-based decision-making."
  source: "`vibe_ngo_v1`.`mel`.`learning_agenda`"
  dimensions:
    - name: "learning_agenda_id"
      expr: learning_agenda_id
      comment: "Primary key — enables drill-down to individual learning agenda items."
    - name: "award_id"
      expr: award_id
      comment: "Grant award the learning agenda item belongs to — enables award-level learning analysis."
    - name: "intervention_id"
      expr: intervention_id
      comment: "Program intervention the learning question addresses — enables intervention-level learning analysis."
    - name: "learning_agenda_status"
      expr: learning_agenda_status
      comment: "Current status of the learning agenda item — tracks learning pipeline progress."
    - name: "learning_question_type"
      expr: learning_question_type
      comment: "Type of learning question (effectiveness, efficiency, relevance, impact) — enables learning portfolio composition analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the learning question — enables triage of high-priority learning investments."
    - name: "donor_reporting_requirement"
      expr: donor_reporting_requirement
      comment: "Whether the learning question is a donor reporting requirement — distinguishes contractual from voluntary learning."
    - name: "ethics_approval_required"
      expr: ethics_approval_required
      comment: "Whether ethics approval is required — tracks research ethics compliance obligations."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the learning question — enables SDG-linked learning reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of learning budget figures — required for multi-currency portfolio analysis."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Partner organization involved in the learning agenda item — enables partner-level learning analysis."
  measures:
    - name: "total_learning_questions"
      expr: COUNT(1)
      comment: "Total number of learning agenda items. Baseline measure for organizational learning agenda scope."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated AS DOUBLE))
      comment: "Total budget allocated to learning agenda items. Tracks organizational investment in evidence generation and learning."
    - name: "total_budget_spent"
      expr: SUM(CAST(budget_spent AS DOUBLE))
      comment: "Total budget spent on learning agenda items. Compared against allocated budget to assess learning investment utilization."
    - name: "budget_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(budget_spent AS DOUBLE)) / NULLIF(SUM(CAST(budget_allocated AS DOUBLE)), 0), 2)
      comment: "Percentage of learning budget that has been spent. Low utilization rates indicate learning activities are behind schedule — triggers management review."
    - name: "avg_budget_per_question"
      expr: AVG(CAST(budget_allocated AS DOUBLE))
      comment: "Average budget allocated per learning question. Benchmarks learning investment adequacy — very low averages may indicate under-resourced learning activities."
    - name: "completed_learning_items_count"
      expr: COUNT(CASE WHEN learning_agenda_status = 'completed' THEN 1 END)
      comment: "Count of completed learning agenda items. Tracks organizational learning output — used in annual learning reviews and donor reports."
    - name: "learning_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN learning_agenda_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of learning agenda items that have been completed. Primary learning agenda KPI — low rates indicate organizational learning gaps."
    - name: "donor_required_learning_count"
      expr: COUNT(CASE WHEN donor_reporting_requirement = TRUE THEN 1 END)
      comment: "Count of learning agenda items that are donor reporting requirements. Tracks contractual learning obligations — incomplete items risk grant compliance violations."
    - name: "distinct_awards_with_learning"
      expr: COUNT(DISTINCT award_id)
      comment: "Number of distinct grant awards with learning agenda items. Awards without learning agendas lack structured organizational learning — a quality and accountability gap."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_needs_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MEL needs assessment portfolio view tracking humanitarian needs analysis coverage, nutrition indicators, and assessment quality. Per VREQ-003, mel.mel_needs_assessment is the SSOT owner for needs assessment entities. Used by MEL and program teams to assess needs analysis coverage and inform program design."
  source: "`vibe_ngo_v1`.`mel`.`mel_needs_assessment`"
  dimensions:
    - name: "mel_needs_assessment_id"
      expr: mel_needs_assessment_id
      comment: "Primary key — enables drill-down to individual needs assessment records."
    - name: "award_id"
      expr: award_id
      comment: "Grant award the needs assessment informs — enables award-level needs analysis."
    - name: "intervention_id"
      expr: intervention_id
      comment: "Program intervention the needs assessment informs — enables intervention-level needs analysis."
    - name: "mel_needs_assessment_type"
      expr: mel_needs_assessment_type
      comment: "Type of needs assessment (rapid, comprehensive, sectoral) — enables portfolio analysis by assessment type."
    - name: "mel_needs_assessment_status"
      expr: mel_needs_assessment_status
      comment: "Current status of the needs assessment — filters to completed assessments for analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country where the assessment was conducted — enables country-level needs analysis."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the assessment — tracks quality assurance of needs data."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Data collection method used — enables method-level quality analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "DAC sector code — enables sector-level needs analysis for donor reporting."
    - name: "country_office_id"
      expr: country_office_id
      comment: "Country office that conducted the assessment — enables office-level needs analysis coverage."
    - name: "start_date"
      expr: start_date
      comment: "Assessment start date — enables time-series analysis of needs assessment activity."
  measures:
    - name: "total_needs_assessments"
      expr: COUNT(1)
      comment: "Total number of needs assessments conducted. Baseline measure for needs analysis coverage and program design evidence base."
    - name: "avg_gam_rate_pct"
      expr: AVG(CAST(gam_rate_percentage AS DOUBLE))
      comment: "Average Global Acute Malnutrition (GAM) rate across assessed areas. Critical humanitarian nutrition KPI — rates above 15% trigger emergency response protocols and donor escalation."
    - name: "avg_sam_rate_pct"
      expr: AVG(CAST(sam_rate_percentage AS DOUBLE))
      comment: "Average Severe Acute Malnutrition (SAM) rate across assessed areas. SAM rates above 2% indicate a nutrition emergency — directly triggers resource mobilization decisions."
    - name: "validated_assessments_count"
      expr: COUNT(CASE WHEN validation_status = 'validated' THEN 1 END)
      comment: "Count of validated needs assessments. Unvalidated assessments cannot be used for program design or donor reporting — tracks quality assurance pipeline."
    - name: "validation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN validation_status = 'validated' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of needs assessments that have been validated. Low validation rates indicate quality assurance bottlenecks in the needs analysis pipeline."
    - name: "completed_assessments_count"
      expr: COUNT(CASE WHEN mel_needs_assessment_status = 'completed' THEN 1 END)
      comment: "Count of completed needs assessments. Tracks needs analysis pipeline throughput and evidence base completeness."
    - name: "distinct_countries_assessed"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of distinct countries with needs assessments. Measures geographic coverage of needs analysis — gaps indicate program design evidence deficits."
    - name: "distinct_awards_with_assessments"
      expr: COUNT(DISTINCT award_id)
      comment: "Number of distinct grant awards with needs assessments. Awards without needs assessments lack evidence-based program design — a quality and accountability risk."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_dhis2_aggregate_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DHIS2 aggregate reporting integration view tracking data submission completeness, quality, and timeliness for national health information system reporting. Used by MEL and technology teams to monitor DHIS2 integration health and reporting compliance."
  source: "`vibe_ngo_v1`.`mel`.`dhis2_aggregate_report`"
  dimensions:
    - name: "dhis2_aggregate_report_id"
      expr: dhis2_aggregate_report_id
      comment: "Primary key — enables drill-down to individual DHIS2 report records."
    - name: "award_id"
      expr: award_id
      comment: "Grant award the report belongs to — enables award-level DHIS2 reporting analysis."
    - name: "reporting_period_id"
      expr: reporting_period_id
      comment: "Reporting period the DHIS2 report covers — enables time-series reporting analysis."
    - name: "dhis2_aggregate_report_status"
      expr: dhis2_aggregate_report_status
      comment: "Current status of the DHIS2 report (submitted, approved, rejected) — tracks reporting pipeline."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the report — tracks governance compliance for DHIS2 submissions."
    - name: "integration_status"
      expr: integration_status
      comment: "Integration status with DHIS2 system — tracks technical integration health."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Whether a data quality issue was flagged — enables quality-gated reporting analysis."
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Type of reporting period (monthly, quarterly) — enables analysis by reporting cadence."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Partner organization submitting the report — enables partner-level DHIS2 compliance analysis."
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit the report belongs to — enables org-unit-level reporting analysis."
    - name: "submission_date"
      expr: submission_date
      comment: "Date the report was submitted — enables timeliness analysis."
  measures:
    - name: "total_dhis2_reports"
      expr: COUNT(1)
      comment: "Total number of DHIS2 aggregate reports. Baseline measure for DHIS2 reporting volume and integration activity."
    - name: "avg_completeness_percentage"
      expr: AVG(CAST(completeness_percentage AS DOUBLE))
      comment: "Average data completeness percentage across all DHIS2 reports. Low completeness rates indicate data collection gaps that undermine national health information system quality."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across DHIS2 reports. Low scores trigger data quality investigations and affect national reporting credibility."
    - name: "data_quality_flagged_count"
      expr: COUNT(CASE WHEN data_quality_flag = TRUE THEN 1 END)
      comment: "Count of DHIS2 reports with data quality flags. Flagged reports require investigation before national submission — tracks quality remediation workload."
    - name: "data_quality_flag_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN data_quality_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DHIS2 reports with data quality flags. High flag rates indicate systemic data collection or integration issues requiring process redesign."
    - name: "approved_reports_count"
      expr: COUNT(CASE WHEN approval_status = 'approved' THEN 1 END)
      comment: "Count of approved DHIS2 reports. Unapproved reports are not counted in national statistics — tracks reporting compliance."
    - name: "report_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DHIS2 reports that have been approved. Low approval rates indicate governance bottlenecks or data quality issues blocking national reporting."
    - name: "integrated_reports_count"
      expr: COUNT(CASE WHEN integration_status = 'integrated' THEN 1 END)
      comment: "Count of reports successfully integrated into DHIS2. Tracks technical integration health — low counts indicate system integration failures."
    - name: "distinct_partners_reporting"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of distinct partner organizations submitting DHIS2 reports. Measures DHIS2 reporting coverage across the partner portfolio."
$$;