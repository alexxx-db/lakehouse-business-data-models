-- Metric views for domain: mel | Business: Ngo | Version: 2 | Generated on: 2026-07-03 06:15:30

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_indicator_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core MEL performance tracking view measuring indicator achievement, target attainment rates, data quality, and result variance across programs. Primary KPI surface for program performance steering."
  source: "`vibe_ngo_v1`.`mel`.`indicator_result`"
  dimensions:
    - name: "indicator_level"
      expr: indicator_level
      comment: "Results chain level of the indicator (output, outcome, impact) for hierarchical performance analysis."
    - name: "disaggregation_sex"
      expr: disaggregation_sex
      comment: "Sex disaggregation dimension enabling gender-responsive performance analysis."
    - name: "disaggregation_age_group"
      expr: disaggregation_age_group
      comment: "Age group disaggregation for demographic performance breakdown."
    - name: "disaggregation_displacement_status"
      expr: disaggregation_displacement_status
      comment: "Displacement status disaggregation to track results for displaced vs. host populations."
    - name: "disaggregation_disability"
      expr: disaggregation_disability
      comment: "Disability disaggregation dimension for inclusive programming analysis."
    - name: "result_status"
      expr: result_status
      comment: "Current status of the indicator result (e.g., verified, pending, rejected) for pipeline quality monitoring."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the result to assess data credibility and audit readiness."
    - name: "geographic_level"
      expr: geographic_level
      comment: "Geographic granularity of the result (national, regional, district) for spatial performance analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the indicator result, enabling like-for-like aggregation filtering."
    - name: "collection_date_month"
      expr: DATE_TRUNC('MONTH', collection_date)
      comment: "Month of data collection for trend analysis of result reporting cadence."
    - name: "collection_date_year"
      expr: YEAR(collection_date)
      comment: "Year of data collection for annual performance review."
    - name: "reported_to_donor"
      expr: reported_to_donor
      comment: "Flag indicating whether the result has been reported to the donor, for donor accountability tracking."
    - name: "is_milestone"
      expr: is_milestone
      comment: "Flag identifying milestone results for critical path monitoring."
  measures:
    - name: "total_result_value"
      expr: SUM(CAST(result_value AS DOUBLE))
      comment: "Total aggregated result value across selected indicators and periods. Core program output/outcome volume metric."
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Total aggregated target value for the same scope, used as denominator for achievement rate calculation."
    - name: "total_cumulative_result"
      expr: SUM(CAST(cumulative_result AS DOUBLE))
      comment: "Sum of cumulative results to date, reflecting program progress against lifetime targets."
    - name: "total_variance_from_target"
      expr: SUM(CAST(variance_from_target AS DOUBLE))
      comment: "Total absolute variance between results and targets. Negative values signal underperformance requiring management attention."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance from target across results. Key executive KPI for portfolio-level target attainment health."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across results. Drives decisions on data credibility and need for re-collection or verification."
    - name: "count_verified_results"
      expr: COUNT(CASE WHEN verification_status = 'verified' THEN indicator_result_id END)
      comment: "Number of results that have been formally verified. Indicates data credibility and audit readiness."
    - name: "count_total_results"
      expr: COUNT(indicator_result_id)
      comment: "Total number of indicator results recorded. Baseline volume metric for reporting completeness assessment."
    - name: "count_results_reported_to_donor"
      expr: COUNT(CASE WHEN reported_to_donor = TRUE THEN indicator_result_id END)
      comment: "Number of results formally reported to donors. Tracks donor accountability compliance."
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline value across results, providing context for interpreting magnitude of change achieved."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_indicator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Indicator portfolio health and design quality view. Tracks indicator coverage, SDG alignment, mandatory compliance, and baseline establishment across the MEL framework."
  source: "`vibe_ngo_v1`.`mel`.`indicator`"
  dimensions:
    - name: "indicator_type"
      expr: indicator_type
      comment: "Type of indicator (output, outcome, impact, process) for results chain portfolio analysis."
    - name: "indicator_status"
      expr: indicator_status
      comment: "Current lifecycle status of the indicator (active, inactive, archived) for portfolio management."
    - name: "sector"
      expr: sector
      comment: "Sector classification of the indicator for cross-sector performance comparison."
    - name: "theme"
      expr: theme
      comment: "Thematic area of the indicator (e.g., nutrition, WASH, protection) for thematic portfolio analysis."
    - name: "sdg_goal_code"
      expr: sdg_goal_code
      comment: "SDG goal alignment code for reporting contribution to global development frameworks."
    - name: "sdg_alignment_type"
      expr: sdg_alignment_type
      comment: "Type of SDG alignment (direct, indirect, proxy) for quality of alignment assessment."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency at which the indicator is reported (monthly, quarterly, annual) for reporting burden analysis."
    - name: "data_collection_frequency"
      expr: data_collection_frequency
      comment: "Frequency of data collection for operational planning and resource allocation."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the indicator, enabling like-for-like portfolio grouping."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Flag indicating whether the indicator is a mandatory donor or organizational requirement."
    - name: "is_custom"
      expr: is_custom
      comment: "Flag distinguishing custom program-specific indicators from standard organizational indicators."
    - name: "direction_of_change"
      expr: direction_of_change
      comment: "Expected direction of change (increase, decrease, maintain) for result interpretation."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the indicator became effective, for cohort and vintage analysis of the indicator portfolio."
  measures:
    - name: "total_indicators"
      expr: COUNT(indicator_id)
      comment: "Total number of indicators in the portfolio. Baseline for coverage and complexity assessment."
    - name: "count_mandatory_indicators"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN indicator_id END)
      comment: "Number of mandatory donor/organizational indicators. Drives compliance risk assessment."
    - name: "count_sdg_aligned_indicators"
      expr: COUNT(CASE WHEN sdg_goal_code IS NOT NULL THEN indicator_id END)
      comment: "Number of indicators with explicit SDG alignment. Measures strategic relevance to global frameworks."
    - name: "count_active_indicators"
      expr: COUNT(CASE WHEN indicator_status = 'active' THEN indicator_id END)
      comment: "Number of currently active indicators. Operational portfolio size for resource planning."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across indicators, providing a sense of ambition level in the portfolio."
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline value across indicators, contextualizing the starting point for change measurement."
    - name: "count_indicators_with_baseline"
      expr: COUNT(CASE WHEN baseline_value IS NOT NULL THEN indicator_id END)
      comment: "Number of indicators with an established baseline. Baseline coverage is a prerequisite for credible impact measurement."
    - name: "count_custom_indicators"
      expr: COUNT(CASE WHEN is_custom = TRUE THEN indicator_id END)
      comment: "Number of custom program-specific indicators. High custom counts may signal fragmentation or lack of standardization."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Evaluation portfolio quality and efficiency view. Tracks evaluation completion rates, DAC criteria ratings, budget utilization, and management response compliance — key inputs for organizational learning and accountability."
  source: "`vibe_ngo_v1`.`mel`.`evaluation`"
  dimensions:
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of evaluation (mid-term, final, real-time, impact) for portfolio composition analysis."
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current status of the evaluation (planned, in-progress, completed, cancelled) for pipeline management."
    - name: "evaluator_type"
      expr: evaluator_type
      comment: "Type of evaluator (internal, external, joint) for independence and cost analysis."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall quality rating of the evaluation for portfolio-level quality benchmarking."
    - name: "effectiveness_rating"
      expr: effectiveness_rating
      comment: "DAC effectiveness rating for cross-program effectiveness comparison."
    - name: "impact_rating"
      expr: impact_rating
      comment: "DAC impact rating for portfolio-level impact assessment."
    - name: "relevance_rating"
      expr: relevance_rating
      comment: "DAC relevance rating for strategic alignment analysis."
    - name: "sustainability_rating"
      expr: sustainability_rating
      comment: "DAC sustainability rating for long-term program viability assessment."
    - name: "management_response_status"
      expr: management_response_status
      comment: "Status of management response to evaluation findings, tracking accountability follow-through."
    - name: "geographic_coverage"
      expr: geographic_coverage
      comment: "Geographic scope of the evaluation for spatial coverage analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of evaluation budget for multi-currency portfolio normalization."
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year the evaluation was planned to start, for cohort and pipeline trend analysis."
    - name: "ethics_approval_obtained"
      expr: ethics_approval_obtained
      comment: "Flag indicating ethics approval status, critical for safeguarding and research compliance."
    - name: "quality_assurance_conducted"
      expr: quality_assurance_conducted
      comment: "Flag indicating whether quality assurance was conducted on the evaluation."
  measures:
    - name: "total_evaluations"
      expr: COUNT(evaluation_id)
      comment: "Total number of evaluations in the portfolio. Baseline for evaluation coverage and workload assessment."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated to evaluations. Key input for MEL investment analysis and cost-efficiency benchmarking."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred for evaluations. Used with budget to compute cost variance and efficiency."
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average cost per evaluation. Benchmarks evaluation efficiency and informs future budget planning."
    - name: "count_completed_evaluations"
      expr: COUNT(CASE WHEN evaluation_status = 'completed' THEN evaluation_id END)
      comment: "Number of completed evaluations. Measures evaluation pipeline throughput and organizational learning output."
    - name: "count_evaluations_with_management_response"
      expr: COUNT(CASE WHEN management_response_status IS NOT NULL AND management_response_status != '' THEN evaluation_id END)
      comment: "Number of evaluations with a management response. Tracks accountability and follow-through on evaluation findings."
    - name: "count_ethics_approved_evaluations"
      expr: COUNT(CASE WHEN ethics_approval_obtained = TRUE THEN evaluation_id END)
      comment: "Number of evaluations with ethics approval obtained. Measures compliance with research ethics standards."
    - name: "count_qa_conducted_evaluations"
      expr: COUNT(CASE WHEN quality_assurance_conducted = TRUE THEN evaluation_id END)
      comment: "Number of evaluations where quality assurance was conducted. Indicates evaluation quality management rigor."
    - name: "avg_budget_amount"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per evaluation for cost benchmarking and future planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_evaluation_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Evaluation findings implementation and accountability view. Tracks finding resolution rates, implementation progress, priority distribution, and management response quality — critical for organizational learning loops."
  source: "`vibe_ngo_v1`.`mel`.`evaluation_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type of finding (recommendation, lesson learned, good practice, risk) for portfolio composition analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the finding (critical, high, medium, low) for triage and resource allocation."
    - name: "implementation_status"
      expr: implementation_status
      comment: "Current implementation status of the finding action plan (not started, in progress, completed, overdue)."
    - name: "dac_criterion"
      expr: dac_criterion
      comment: "DAC evaluation criterion the finding relates to (relevance, effectiveness, efficiency, impact, sustainability)."
    - name: "sector"
      expr: sector
      comment: "Sector the finding applies to for cross-sector learning analysis."
    - name: "cross_cutting_theme"
      expr: cross_cutting_theme
      comment: "Cross-cutting theme (gender, protection, environment) for thematic learning analysis."
    - name: "responsible_unit"
      expr: responsible_unit
      comment: "Organizational unit responsible for implementing the finding action plan."
    - name: "beneficiary_category"
      expr: beneficiary_category
      comment: "Category of beneficiaries affected by the finding for equity-focused analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the finding for spatial learning analysis."
    - name: "rating"
      expr: rating
      comment: "Quality or severity rating of the finding for prioritization."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Flag indicating whether the finding is visible to donors, for accountability and transparency tracking."
    - name: "finding_date_year"
      expr: YEAR(finding_date)
      comment: "Year the finding was identified for trend analysis of organizational learning over time."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the finding for information governance."
  measures:
    - name: "total_findings"
      expr: COUNT(evaluation_finding_id)
      comment: "Total number of evaluation findings. Baseline for learning portfolio volume and accountability tracking."
    - name: "count_high_priority_findings"
      expr: COUNT(CASE WHEN priority_level IN ('critical', 'high') THEN evaluation_finding_id END)
      comment: "Number of critical or high priority findings. Drives executive attention and resource reallocation decisions."
    - name: "count_completed_findings"
      expr: COUNT(CASE WHEN implementation_status = 'completed' THEN evaluation_finding_id END)
      comment: "Number of findings with completed action plans. Measures organizational follow-through on evaluation recommendations."
    - name: "avg_implementation_progress_percentage"
      expr: AVG(CAST(implementation_progress_percentage AS DOUBLE))
      comment: "Average implementation progress percentage across all findings. Portfolio-level accountability health indicator."
    - name: "count_overdue_findings"
      expr: COUNT(CASE WHEN target_completion_date < CURRENT_DATE AND implementation_status != 'completed' THEN evaluation_finding_id END)
      comment: "Number of findings past their target completion date without completion. Critical risk and accountability metric."
    - name: "count_donor_visible_findings"
      expr: COUNT(CASE WHEN donor_visibility_flag = TRUE THEN evaluation_finding_id END)
      comment: "Number of findings visible to donors. Tracks transparency and donor accountability exposure."
    - name: "count_findings_with_management_response"
      expr: COUNT(CASE WHEN management_response IS NOT NULL AND management_response != '' THEN evaluation_finding_id END)
      comment: "Number of findings with a formal management response. Measures accountability and organizational responsiveness."
    - name: "total_implementation_progress"
      expr: SUM(CAST(implementation_progress_percentage AS DOUBLE))
      comment: "Sum of implementation progress percentages, used as numerator for weighted completion rate calculations in BI."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_indicator_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Indicator target-setting quality and ambition view. Tracks target coverage, disaggregation completeness, and target value distribution — informing whether program ambition is appropriately calibrated."
  source: "`vibe_ngo_v1`.`mel`.`indicator_target`"
  dimensions:
    - name: "target_type"
      expr: target_type
      comment: "Type of target (annual, cumulative, milestone, endline) for target portfolio composition analysis."
    - name: "target_status"
      expr: target_status
      comment: "Current status of the target (draft, approved, revised, closed) for target lifecycle management."
    - name: "measurement_frequency"
      expr: measurement_frequency
      comment: "Frequency of measurement for the target (monthly, quarterly, annual) for reporting burden analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the target value, enabling like-for-like aggregation."
    - name: "disaggregation_sex"
      expr: disaggregation_sex
      comment: "Sex disaggregation dimension for gender-responsive target analysis."
    - name: "disaggregation_age_group"
      expr: disaggregation_age_group
      comment: "Age group disaggregation for demographic target coverage analysis."
    - name: "disaggregation_disability_status"
      expr: disaggregation_disability_status
      comment: "Disability status disaggregation for inclusive programming target analysis."
    - name: "disaggregation_displacement_status"
      expr: disaggregation_displacement_status
      comment: "Displacement status disaggregation for population-specific target analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "DAC sector code for donor-aligned target portfolio analysis."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the target for global framework contribution tracking."
    - name: "target_date_year"
      expr: YEAR(target_date)
      comment: "Year the target is due for temporal pipeline and workload analysis."
    - name: "donor_reporting_requirement"
      expr: donor_reporting_requirement
      comment: "Donor reporting requirement associated with the target for compliance tracking."
  measures:
    - name: "total_targets"
      expr: COUNT(indicator_target_id)
      comment: "Total number of indicator targets. Baseline for target portfolio size and planning complexity."
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Total aggregated target value across the portfolio. Measures overall program ambition and scale."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value per indicator target. Benchmarks ambition level and identifies outliers."
    - name: "total_baseline_value"
      expr: SUM(CAST(baseline_value AS DOUBLE))
      comment: "Total baseline value across targets. Provides aggregate starting point context for change measurement."
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline value per target. Contextualizes the magnitude of change being targeted."
    - name: "count_approved_targets"
      expr: COUNT(CASE WHEN target_status = 'approved' THEN indicator_target_id END)
      comment: "Number of formally approved targets. Measures target governance compliance and readiness for monitoring."
    - name: "count_targets_with_disaggregation"
      expr: COUNT(CASE WHEN disaggregation_sex IS NOT NULL OR disaggregation_age_group IS NOT NULL OR disaggregation_disability_status IS NOT NULL THEN indicator_target_id END)
      comment: "Number of targets with at least one disaggregation dimension. Measures equity and inclusion in target-setting."
    - name: "count_donor_required_targets"
      expr: COUNT(CASE WHEN donor_reporting_requirement IS NOT NULL AND donor_reporting_requirement != '' THEN indicator_target_id END)
      comment: "Number of targets with explicit donor reporting requirements. Tracks compliance obligation volume."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_logframe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MEL logframe quality and results chain coverage view. Tracks logframe completeness, results chain hierarchy, SDG alignment, and target vs. actual performance at the logframe level — the backbone of program accountability."
  source: "`vibe_ngo_v1`.`mel`.`mel_logframe`"
  dimensions:
    - name: "results_chain_level"
      expr: results_chain_level
      comment: "Level in the results chain (input, activity, output, outcome, impact) for hierarchical performance analysis."
    - name: "mel_logframe_status"
      expr: mel_logframe_status
      comment: "Current status of the logframe (draft, approved, active, closed) for portfolio lifecycle management."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Reporting frequency for the logframe row for operational planning."
    - name: "dac_evaluation_criterion"
      expr: dac_evaluation_criterion
      comment: "DAC evaluation criterion alignment for donor-compliant logframe analysis."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the logframe row for global framework contribution reporting."
    - name: "donor_template_type"
      expr: donor_template_type
      comment: "Donor template type the logframe conforms to for donor-specific portfolio analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for logframe indicators for like-for-like aggregation."
    - name: "is_custom_indicator"
      expr: is_custom_indicator
      comment: "Flag distinguishing custom from standard indicators in the logframe."
    - name: "is_mandatory_donor_indicator"
      expr: is_mandatory_donor_indicator
      comment: "Flag for mandatory donor indicators, critical for compliance monitoring."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the logframe row became effective for cohort analysis."
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party responsible for the logframe row for accountability assignment analysis."
  measures:
    - name: "total_logframe_rows"
      expr: COUNT(mel_logframe_id)
      comment: "Total number of logframe rows. Baseline for logframe complexity and coverage assessment."
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Total aggregated target value across logframe rows. Measures overall program ambition at the logframe level."
    - name: "total_actual_value"
      expr: SUM(CAST(actual_value AS DOUBLE))
      comment: "Total aggregated actual value achieved across logframe rows. Core program performance volume metric."
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual value per logframe row. Benchmarks typical performance level across the results chain."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value per logframe row. Contextualizes ambition level across the results chain."
    - name: "count_mandatory_donor_indicators"
      expr: COUNT(CASE WHEN is_mandatory_donor_indicator = TRUE THEN mel_logframe_id END)
      comment: "Number of mandatory donor indicators in the logframe. Drives compliance risk and reporting obligation assessment."
    - name: "count_sdg_aligned_rows"
      expr: COUNT(CASE WHEN sdg_alignment IS NOT NULL AND sdg_alignment != '' THEN mel_logframe_id END)
      comment: "Number of logframe rows with SDG alignment. Measures strategic relevance to global development frameworks."
    - name: "count_active_logframe_rows"
      expr: COUNT(CASE WHEN mel_logframe_status = 'active' THEN mel_logframe_id END)
      comment: "Number of currently active logframe rows. Operational portfolio size for monitoring resource planning."
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline value across logframe rows, providing context for interpreting magnitude of change."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_meal_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MEL plan investment and strategic coverage view. Tracks MEL budget allocation, plan status, and strategic framework alignment — informing whether MEL capacity is adequately resourced and strategically aligned."
  source: "`vibe_ngo_v1`.`mel`.`meal_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the MEL plan (draft, approved, active, closed) for portfolio lifecycle management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the MEL plan budget for multi-currency portfolio analysis."
    - name: "chs_commitment_alignment"
      expr: chs_commitment_alignment
      comment: "Core Humanitarian Standard commitment alignment for accountability framework compliance analysis."
    - name: "dac_criteria_coverage"
      expr: dac_criteria_coverage
      comment: "DAC criteria covered by the MEL plan for evaluation framework completeness analysis."
    - name: "rbm_framework_alignment"
      expr: rbm_framework_alignment
      comment: "Results-based management framework alignment for organizational methodology consistency."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the MEL plan for global framework contribution tracking."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the MEL plan became effective for cohort and investment trend analysis."
    - name: "plan_version"
      expr: plan_version
      comment: "Version of the MEL plan for revision frequency and governance analysis."
  measures:
    - name: "total_mel_budget_allocated"
      expr: SUM(CAST(budget_allocated AS DOUBLE))
      comment: "Total MEL budget allocated across plans. Primary investment metric for MEL capacity and resourcing decisions."
    - name: "avg_mel_budget_allocated"
      expr: AVG(CAST(budget_allocated AS DOUBLE))
      comment: "Average MEL budget per plan. Benchmarks MEL investment level and identifies under-resourced programs."
    - name: "total_beneficiary_feedback_channels"
      expr: SUM(CAST(beneficiary_feedback_channels AS DOUBLE))
      comment: "Total number of beneficiary feedback channels across MEL plans. Measures accountability and community engagement investment."
    - name: "avg_beneficiary_feedback_channels"
      expr: AVG(CAST(beneficiary_feedback_channels AS DOUBLE))
      comment: "Average beneficiary feedback channels per MEL plan. Benchmarks accountability mechanism coverage."
    - name: "count_active_mel_plans"
      expr: COUNT(CASE WHEN plan_status = 'active' THEN meal_plan_id END)
      comment: "Number of currently active MEL plans. Operational portfolio size for MEL team capacity planning."
    - name: "count_approved_mel_plans"
      expr: COUNT(CASE WHEN plan_status = 'approved' THEN meal_plan_id END)
      comment: "Number of approved MEL plans. Measures governance compliance and readiness for implementation."
    - name: "total_mel_plans"
      expr: COUNT(meal_plan_id)
      comment: "Total number of MEL plans. Baseline for portfolio scope and organizational MEL coverage."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_data_collection_tool`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data collection tool quality and compliance view. Tracks tool deployment status, ethical review compliance, data protection adherence, and tool portfolio composition — informing MEL operational readiness and research ethics compliance."
  source: "`vibe_ngo_v1`.`mel`.`data_collection_tool`"
  dimensions:
    - name: "tool_type"
      expr: tool_type
      comment: "Type of data collection tool (survey, KII guide, FGD guide, observation checklist) for portfolio composition analysis."
    - name: "tool_status"
      expr: tool_status
      comment: "Current status of the tool (draft, approved, deployed, retired) for lifecycle management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the tool for governance compliance tracking."
    - name: "ethical_review_status"
      expr: ethical_review_status
      comment: "Ethical review status of the tool. Critical for research ethics and safeguarding compliance."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Data collection method (face-to-face, phone, online, observation) for methodology portfolio analysis."
    - name: "data_protection_compliance"
      expr: data_protection_compliance
      comment: "Data protection compliance status for GDPR and organizational data governance tracking."
    - name: "consent_mechanism"
      expr: consent_mechanism
      comment: "Consent mechanism used (verbal, written, digital) for ethical standards compliance analysis."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the tool for linguistic accessibility and localization analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the tool deployment for spatial coverage analysis."
    - name: "respondent_type"
      expr: respondent_type
      comment: "Type of respondent the tool targets (beneficiary, staff, community leader) for audience coverage analysis."
    - name: "deployment_start_year"
      expr: YEAR(deployment_start_date)
      comment: "Year of tool deployment start for temporal portfolio analysis."
  measures:
    - name: "total_tools"
      expr: COUNT(data_collection_tool_id)
      comment: "Total number of data collection tools. Baseline for MEL operational toolkit size and complexity."
    - name: "count_approved_tools"
      expr: COUNT(CASE WHEN approval_status = 'approved' THEN data_collection_tool_id END)
      comment: "Number of approved data collection tools. Measures governance compliance and deployment readiness."
    - name: "count_ethics_reviewed_tools"
      expr: COUNT(CASE WHEN ethical_review_status = 'approved' THEN data_collection_tool_id END)
      comment: "Number of tools with ethics review approval. Critical compliance metric for research ethics and safeguarding."
    - name: "count_deployed_tools"
      expr: COUNT(CASE WHEN tool_status = 'deployed' THEN data_collection_tool_id END)
      comment: "Number of currently deployed tools. Measures active MEL data collection capacity."
    - name: "count_data_protection_compliant_tools"
      expr: COUNT(CASE WHEN data_protection_compliance = 'compliant' THEN data_collection_tool_id END)
      comment: "Number of tools meeting data protection compliance requirements. Tracks GDPR and organizational data governance adherence."
    - name: "count_tools_pending_approval"
      expr: COUNT(CASE WHEN approval_status IN ('pending', 'under_review') THEN data_collection_tool_id END)
      comment: "Number of tools awaiting approval. Measures pipeline bottleneck in MEL operational readiness."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_reporting_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reporting period pipeline and compliance view. Tracks active reporting periods, deadline adherence, data quality audit scheduling, and special period flags — informing MEL operational calendar management and donor reporting compliance."
  source: "`vibe_ngo_v1`.`mel`.`reporting_period`"
  dimensions:
    - name: "period_type"
      expr: period_type
      comment: "Type of reporting period (monthly, quarterly, annual, baseline, endline) for calendar structure analysis."
    - name: "period_status"
      expr: period_status
      comment: "Current status of the reporting period (open, closed, pending) for pipeline management."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Reporting frequency associated with the period for workload and cadence analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the reporting period for annual planning and budget cycle alignment."
    - name: "calendar_year"
      expr: calendar_year
      comment: "Calendar year of the reporting period for temporal trend analysis."
    - name: "quarter_number"
      expr: quarter_number
      comment: "Quarter number within the year for quarterly performance review alignment."
    - name: "donor_reporting_cycle"
      expr: donor_reporting_cycle
      comment: "Donor reporting cycle the period belongs to for donor compliance tracking."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the reporting period is currently active."
    - name: "baseline_period_flag"
      expr: baseline_period_flag
      comment: "Flag identifying baseline reporting periods for baseline data completeness tracking."
    - name: "midline_period_flag"
      expr: midline_period_flag
      comment: "Flag identifying midline reporting periods for mid-term review scheduling."
    - name: "endline_period_flag"
      expr: endline_period_flag
      comment: "Flag identifying endline reporting periods for final evaluation scheduling."
    - name: "data_quality_audit_flag"
      expr: data_quality_audit_flag
      comment: "Flag indicating whether a data quality audit is scheduled for this period."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month of period start date for temporal distribution analysis."
  measures:
    - name: "total_reporting_periods"
      expr: COUNT(reporting_period_id)
      comment: "Total number of reporting periods. Baseline for MEL calendar complexity and reporting burden assessment."
    - name: "count_active_reporting_periods"
      expr: COUNT(CASE WHEN is_active = TRUE THEN reporting_period_id END)
      comment: "Number of currently active reporting periods. Measures current MEL operational workload."
    - name: "count_closed_reporting_periods"
      expr: COUNT(CASE WHEN period_status = 'closed' THEN reporting_period_id END)
      comment: "Number of closed reporting periods. Measures historical reporting completion and data availability."
    - name: "count_data_quality_audit_periods"
      expr: COUNT(CASE WHEN data_quality_audit_flag = TRUE THEN reporting_period_id END)
      comment: "Number of periods with scheduled data quality audits. Tracks data quality governance investment."
    - name: "count_overdue_submissions"
      expr: COUNT(CASE WHEN report_submission_deadline < CURRENT_DATE AND period_status != 'closed' THEN reporting_period_id END)
      comment: "Number of reporting periods past their submission deadline without closure. Critical donor compliance risk metric."
    - name: "count_baseline_periods"
      expr: COUNT(CASE WHEN baseline_period_flag = TRUE THEN reporting_period_id END)
      comment: "Number of baseline reporting periods. Measures baseline data collection coverage across the program portfolio."
    - name: "count_endline_periods"
      expr: COUNT(CASE WHEN endline_period_flag = TRUE THEN reporting_period_id END)
      comment: "Number of endline reporting periods. Tracks final evaluation scheduling and program closure readiness."
$$;