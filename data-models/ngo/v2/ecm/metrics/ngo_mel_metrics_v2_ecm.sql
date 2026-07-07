-- Metric views for domain: mel | Business: Ngo | Version: 2 | Generated on: 2026-07-03 05:04:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_indicator_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core MEL performance tracking view over indicator results. Provides KPIs on result achievement, variance from targets, data quality, and disaggregated reach. Used by MEL directors, program managers, and donor reporting teams to assess whether programs are on track against logframe commitments. Aligns with DHIS2, Kobo Toolbox, and eTools result-reporting workflows."
  source: "`vibe_ngo_v1`.`mel`.`indicator_result`"
  dimensions:
    - name: "indicator_level"
      expr: indicator_level
      comment: "Logframe level of the indicator (output, outcome, impact) — enables stratified performance analysis by results chain level."
    - name: "result_status"
      expr: result_status
      comment: "Current status of the result record (e.g. draft, submitted, verified, rejected) — used to filter dashboards to verified results only."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit in which the result is expressed (e.g. individuals, households, metric tons) — essential for comparing like-for-like across indicators."
    - name: "disaggregation_sex"
      expr: disaggregation_sex
      comment: "Sex disaggregation of the result (male, female, other) — mandatory for gender-responsive programming and donor reporting."
    - name: "disaggregation_age_group"
      expr: disaggregation_age_group
      comment: "Age group disaggregation — required for child-focused and age-sensitive program analysis."
    - name: "disaggregation_displacement_status"
      expr: disaggregation_displacement_status
      comment: "Displacement status disaggregation (IDP, refugee, host community) — critical for humanitarian targeting and protection analysis."
    - name: "disaggregation_disability"
      expr: disaggregation_disability
      comment: "Disability disaggregation — required for inclusive programming commitments and CRPD-aligned reporting."
    - name: "geographic_level"
      expr: geographic_level
      comment: "Geographic granularity of the result (national, regional, district, community) — enables geographic performance drill-down."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Method used to collect the result data (survey, observation, administrative records) — supports data quality triangulation."
    - name: "verification_status"
      expr: verification_status
      comment: "Whether the result has been independently verified — used to distinguish self-reported from verified results in donor submissions."
    - name: "reporting_period_start_date"
      expr: DATE_TRUNC('quarter', reporting_period_start_date)
      comment: "Reporting quarter start — enables quarterly trend analysis of indicator performance."
    - name: "is_milestone"
      expr: is_milestone
      comment: "Flag indicating whether this result represents a milestone — used to track key program milestones separately from routine results."
    - name: "reported_to_donor"
      expr: reported_to_donor
      comment: "Flag indicating whether this result has been included in a donor report — used for donor reporting completeness tracking."
  measures:
    - name: "total_result_value"
      expr: SUM(CAST(result_value AS DOUBLE))
      comment: "Total aggregated result value across all indicator results in scope. Primary KPI for program reach and output delivery — used in donor reports, logframe progress tracking, and steering meetings."
    - name: "avg_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average result value per reporting record. Useful for benchmarking performance across sites, partners, or periods."
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Total aggregated target value for the same scope. Used as the denominator in achievement rate calculations and for gap analysis."
    - name: "total_cumulative_result"
      expr: SUM(CAST(cumulative_result AS DOUBLE))
      comment: "Sum of cumulative results — represents total program-to-date achievement across all indicators in scope. Key metric for mid-term and final evaluations."
    - name: "total_variance_from_target"
      expr: SUM(CAST(variance_from_target AS DOUBLE))
      comment: "Total absolute variance between actual results and targets. Negative values indicate underperformance; positive values indicate over-achievement. Triggers management action when significantly negative."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance from target across results in scope. Provides a normalized view of performance gaps — used in steering meetings to identify underperforming indicators."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across indicator results. Low scores trigger data quality reviews and may invalidate donor reporting. Critical for audit readiness."
    - name: "verified_result_count"
      expr: COUNT(CASE WHEN verification_status = 'verified' THEN 1 END)
      comment: "Count of independently verified results. Ratio of verified to total results is a key data credibility KPI for donor audits and CHS accountability."
    - name: "total_indicator_results"
      expr: COUNT(1)
      comment: "Total number of indicator result records in scope. Baseline volume metric used to contextualize averages and rates."
    - name: "donor_reported_result_count"
      expr: COUNT(CASE WHEN reported_to_donor = TRUE THEN 1 END)
      comment: "Count of results that have been included in donor reports. Used to track donor reporting completeness and identify unreported results before submission deadlines."
    - name: "total_baseline_value"
      expr: SUM(CAST(baseline_value AS DOUBLE))
      comment: "Sum of baseline values across results in scope. Used to contextualize absolute result values and compute change-from-baseline metrics."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_indicator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic indicator portfolio view. Tracks the composition, coverage, and alignment of the indicator framework across programs, awards, and SDG commitments. Used by MEL leads, program directors, and compliance teams to govern indicator quality and donor alignment. Relevant to DHIS2 indicator management and eTools logframe configuration."
  source: "`vibe_ngo_v1`.`mel`.`indicator`"
  dimensions:
    - name: "indicator_type"
      expr: indicator_type
      comment: "Type of indicator (output, outcome, impact, process) — enables analysis of indicator portfolio balance across the results chain."
    - name: "indicator_category"
      expr: indicator_category
      comment: "Thematic category of the indicator (health, WASH, protection, education, livelihoods) — used for sector-level performance aggregation."
    - name: "indicator_status"
      expr: indicator_status
      comment: "Lifecycle status of the indicator (active, retired, draft) — used to filter dashboards to active indicators only."
    - name: "logframe_level"
      expr: logframe_level
      comment: "Position in the results chain (goal, outcome, output, activity) — critical for logframe completeness analysis."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "How often the indicator is reported (monthly, quarterly, annually) — used for reporting calendar planning."
    - name: "data_collection_frequency"
      expr: data_collection_frequency
      comment: "How often data is collected for this indicator — used to assess data collection burden and resource planning."
    - name: "sector"
      expr: sector
      comment: "Humanitarian sector the indicator belongs to (health, nutrition, shelter, WASH, protection) — enables sector-level portfolio analysis."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG goal(s) this indicator contributes to — used for SDG reporting and strategic alignment analysis."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the indicator is mandatory (e.g. donor-required or cluster-standard) — used to ensure mandatory indicators are always tracked."
    - name: "is_custom"
      expr: is_custom
      comment: "Whether the indicator is custom-designed vs. standard — used to assess standardization of the indicator framework."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measurement for the indicator — used to group comparable indicators and validate aggregation logic."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the indicator became effective — used for cohort analysis of indicator frameworks by program year."
  measures:
    - name: "total_indicators"
      expr: COUNT(1)
      comment: "Total number of indicators in the portfolio. Baseline metric for indicator framework size — used to assess monitoring burden and framework completeness."
    - name: "mandatory_indicator_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END)
      comment: "Count of mandatory indicators. Used to ensure all donor-required and cluster-standard indicators are present in the framework."
    - name: "custom_indicator_count"
      expr: COUNT(CASE WHEN is_custom = TRUE THEN 1 END)
      comment: "Count of custom (non-standard) indicators. High custom indicator counts increase reporting burden — used to drive indicator rationalization decisions."
    - name: "active_indicator_count"
      expr: COUNT(CASE WHEN indicator_status = 'active' THEN 1 END)
      comment: "Count of currently active indicators. Used to size the active monitoring workload and resource requirements."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across indicators in scope. Used to benchmark ambition levels across programs and sectors."
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline value across indicators. Used to contextualize target ambition and assess starting conditions."
    - name: "sdg_aligned_indicator_count"
      expr: COUNT(CASE WHEN sdg_alignment IS NOT NULL AND sdg_alignment <> '' THEN 1 END)
      comment: "Count of indicators with explicit SDG alignment. Used for SDG contribution reporting to donors and UN agencies."
    - name: "dhis2_linked_indicator_count"
      expr: COUNT(CASE WHEN dhis2_indicator_code IS NOT NULL AND dhis2_indicator_code <> '' THEN 1 END)
      comment: "Count of indicators linked to DHIS2 codes. Measures integration completeness between the MEL framework and national health information systems."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_indicator_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Indicator target-setting and planning view. Tracks the ambition, disaggregation coverage, and revision history of indicator targets across awards, partners, and reporting periods. Used by MEL managers and program directors to assess target quality and planning rigor. Supports eTools and DHIS2 target configuration workflows."
  source: "`vibe_ngo_v1`.`mel`.`indicator_target`"
  dimensions:
    - name: "target_type"
      expr: target_type
      comment: "Type of target (annual, cumulative, milestone, endline) — used to distinguish planning horizons in target analysis."
    - name: "target_status"
      expr: target_status
      comment: "Approval status of the target (draft, approved, revised, superseded) — used to filter to approved targets for reporting."
    - name: "measurement_frequency"
      expr: measurement_frequency
      comment: "How frequently this target is measured — used for reporting calendar alignment."
    - name: "disaggregation_sex"
      expr: disaggregation_sex
      comment: "Sex disaggregation applied to this target — used to assess gender-responsive target-setting."
    - name: "disaggregation_age_group"
      expr: disaggregation_age_group
      comment: "Age group disaggregation applied to this target — used for child-focused and age-sensitive program planning."
    - name: "disaggregation_displacement_status"
      expr: disaggregation_displacement_status
      comment: "Displacement status disaggregation — used to assess whether targets are set for refugee, IDP, and host community populations separately."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the target — used to ensure comparability across targets."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the target — used for SDG contribution planning."
    - name: "target_date"
      expr: DATE_TRUNC('year', target_date)
      comment: "Year the target is due — used for annual planning and target pipeline analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "DAC sector code for the target — used for OECD DAC-aligned reporting and sector-level aggregation."
  measures:
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Total planned target value across all indicator targets in scope. Primary planning KPI — used to assess total program ambition and resource requirements."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value per indicator target record. Used to benchmark target ambition levels across programs, partners, and sectors."
    - name: "total_baseline_value"
      expr: SUM(CAST(baseline_value AS DOUBLE))
      comment: "Sum of baseline values across targets. Used to contextualize target ambition relative to starting conditions."
    - name: "total_indicator_targets"
      expr: COUNT(1)
      comment: "Total number of indicator targets set. Used to assess planning completeness — all active indicators should have approved targets."
    - name: "approved_target_count"
      expr: COUNT(CASE WHEN target_status = 'approved' THEN 1 END)
      comment: "Count of approved indicator targets. Low approval rates indicate planning gaps that may delay program implementation."
    - name: "revised_target_count"
      expr: COUNT(CASE WHEN target_status = 'revised' THEN 1 END)
      comment: "Count of revised targets. High revision rates may indicate poor initial planning or significant context changes — triggers management review."
    - name: "sex_disaggregated_target_count"
      expr: COUNT(CASE WHEN disaggregation_sex IS NOT NULL AND disaggregation_sex <> '' THEN 1 END)
      comment: "Count of targets with sex disaggregation. Used to assess gender-responsive planning completeness — many donors require 100% sex-disaggregated targets."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program evaluation portfolio view. Tracks evaluation coverage, quality ratings, cost efficiency, and management response compliance across the evaluation portfolio. Used by MEL directors, senior management, and donor accountability teams. Aligns with OECD DAC evaluation standards and CHS commitments."
  source: "`vibe_ngo_v1`.`mel`.`evaluation`"
  dimensions:
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of evaluation (mid-term, final, real-time, impact, process) — used to analyze evaluation portfolio balance."
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current status of the evaluation (planned, in-progress, completed, disseminated) — used for pipeline and completion tracking."
    - name: "evaluator_type"
      expr: evaluator_type
      comment: "Whether the evaluation is internal, external, or joint — used to assess independence and credibility of the evaluation portfolio."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall DAC quality rating of the evaluation (highly satisfactory, satisfactory, unsatisfactory) — key performance signal for program quality."
    - name: "management_response_status"
      expr: management_response_status
      comment: "Status of management response to evaluation recommendations — used to track accountability and learning uptake."
    - name: "geographic_coverage"
      expr: geographic_coverage
      comment: "Geographic scope of the evaluation — used for geographic coverage analysis of the evaluation portfolio."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of evaluation budget — used for multi-currency cost analysis."
    - name: "planned_start_date"
      expr: DATE_TRUNC('year', planned_start_date)
      comment: "Year the evaluation was planned to start — used for annual evaluation pipeline analysis."
    - name: "ethics_approval_obtained"
      expr: ethics_approval_obtained
      comment: "Whether ethics approval was obtained — mandatory for evaluations involving human subjects; used for compliance tracking."
    - name: "quality_assurance_conducted"
      expr: quality_assurance_conducted
      comment: "Whether quality assurance was conducted on the evaluation — used to assess evaluation quality management."
  measures:
    - name: "total_evaluations"
      expr: COUNT(1)
      comment: "Total number of evaluations in the portfolio. Baseline metric for evaluation coverage — used to assess whether the organization meets donor and CHS evaluation commitments."
    - name: "completed_evaluation_count"
      expr: COUNT(CASE WHEN evaluation_status = 'completed' THEN 1 END)
      comment: "Count of completed evaluations. Used to track evaluation delivery against the annual evaluation plan."
    - name: "total_evaluation_budget"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated to evaluations in scope. Used for evaluation resource planning and cost benchmarking."
    - name: "total_evaluation_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of evaluations. Compared against budget to assess evaluation cost management."
    - name: "avg_evaluation_budget"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per evaluation. Used to benchmark evaluation investment levels and identify under-resourced evaluations."
    - name: "avg_evaluation_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per evaluation. Used alongside average budget to assess cost efficiency of the evaluation function."
    - name: "ethics_approved_evaluation_count"
      expr: COUNT(CASE WHEN ethics_approval_obtained = TRUE THEN 1 END)
      comment: "Count of evaluations with ethics approval. Used to ensure compliance with research ethics requirements — critical for evaluations involving vulnerable populations."
    - name: "management_response_completed_count"
      expr: COUNT(CASE WHEN management_response_status = 'completed' THEN 1 END)
      comment: "Count of evaluations with completed management responses. Low rates indicate poor learning uptake — a key CHS accountability indicator."
    - name: "external_evaluation_count"
      expr: COUNT(CASE WHEN evaluator_type = 'external' THEN 1 END)
      comment: "Count of externally commissioned evaluations. Many donors require independent external evaluations — used for donor compliance tracking."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_evaluation_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Evaluation findings and management response tracking view. Monitors the implementation of evaluation recommendations, priority distribution, and learning uptake. Used by MEL directors and senior management to drive organizational learning and accountability. Critical for CHS self-assessment and donor accountability reporting."
  source: "`vibe_ngo_v1`.`mel`.`evaluation_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type of finding (recommendation, lesson learned, good practice, concern) — used to categorize and prioritize follow-up actions."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the finding (critical, high, medium, low) — used to triage management response and resource allocation."
    - name: "implementation_status"
      expr: implementation_status
      comment: "Status of recommendation implementation (not started, in progress, completed, cancelled) — primary tracking dimension for learning uptake."
    - name: "dac_criterion"
      expr: dac_criterion
      comment: "DAC evaluation criterion the finding relates to (relevance, effectiveness, efficiency, impact, sustainability, coherence) — used for portfolio-level DAC analysis."
    - name: "sector"
      expr: sector
      comment: "Sector the finding relates to — used for sector-level learning analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the finding — used for geographic learning analysis."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Whether the finding is visible to donors — used to manage donor-facing learning communications."
    - name: "cross_cutting_theme"
      expr: cross_cutting_theme
      comment: "Cross-cutting theme (gender, protection, environment, accountability) — used for thematic learning analysis."
    - name: "finding_date"
      expr: DATE_TRUNC('year', finding_date)
      comment: "Year the finding was documented — used for annual learning trend analysis."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of evaluation findings. Baseline metric for learning portfolio size — used to assess organizational learning volume."
    - name: "critical_priority_finding_count"
      expr: COUNT(CASE WHEN priority_level = 'critical' THEN 1 END)
      comment: "Count of critical priority findings. Unaddressed critical findings represent significant program risk — triggers immediate management escalation."
    - name: "completed_recommendation_count"
      expr: COUNT(CASE WHEN implementation_status = 'completed' THEN 1 END)
      comment: "Count of fully implemented recommendations. Key learning uptake KPI — used in CHS self-assessments and donor accountability reports."
    - name: "avg_implementation_progress_percentage"
      expr: AVG(CAST(implementation_progress_percentage AS DOUBLE))
      comment: "Average implementation progress across all findings. Provides a portfolio-level view of recommendation follow-through — used in quarterly steering meetings."
    - name: "overdue_recommendation_count"
      expr: COUNT(CASE WHEN target_completion_date < CURRENT_DATE AND implementation_status <> 'completed' THEN 1 END)
      comment: "Count of recommendations past their target completion date and not yet completed. High overdue counts indicate accountability gaps — triggers management escalation."
    - name: "donor_visible_finding_count"
      expr: COUNT(CASE WHEN donor_visibility_flag = TRUE THEN 1 END)
      comment: "Count of findings flagged for donor visibility. Used to manage donor-facing learning communications and ensure appropriate transparency."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_data_quality_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data quality assessment (DQA) performance view. Tracks accuracy, completeness, consistency, and timeliness scores across the data quality portfolio. Used by MEL managers, compliance teams, and auditors to ensure data credibility for donor reporting and program decision-making. Aligns with USAID DQA requirements and DFID data quality standards."
  source: "`vibe_ngo_v1`.`mel`.`data_quality_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of DQA (routine, triggered, donor-required, pre-evaluation) — used to analyze DQA portfolio composition."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the DQA (planned, in-progress, completed, action-required) — used for pipeline and follow-up tracking."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the DQA — used to triage corrective action resources."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions identified in the DQA — used to track data quality improvement follow-through."
    - name: "data_source_type"
      expr: data_source_type
      comment: "Type of data source assessed (primary, secondary, administrative) — used to analyze data quality by source type."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify data quality (spot check, re-interview, record review) — used to assess rigor of DQA methodology."
    - name: "country_code"
      expr: country_code
      comment: "Country where the DQA was conducted — used for geographic data quality analysis."
    - name: "assessment_date"
      expr: DATE_TRUNC('quarter', assessment_date)
      comment: "Quarter the DQA was conducted — used for trend analysis of data quality over time."
  measures:
    - name: "avg_overall_dqa_score"
      expr: AVG(CAST(overall_dqa_score_percentage AS DOUBLE))
      comment: "Average overall DQA score across assessments. Primary data quality KPI — scores below threshold trigger mandatory corrective action and may invalidate donor reporting."
    - name: "avg_accuracy_score"
      expr: AVG(CAST(accuracy_score_percentage AS DOUBLE))
      comment: "Average accuracy score across DQAs. Accuracy is the most critical DQA dimension — low scores indicate systematic data collection errors."
    - name: "avg_completeness_score"
      expr: AVG(CAST(completeness_score_percentage AS DOUBLE))
      comment: "Average completeness score across DQAs. Incomplete data undermines program analysis and donor reporting — used to identify data gaps."
    - name: "avg_consistency_score"
      expr: AVG(CAST(consistency_score_percentage AS DOUBLE))
      comment: "Average consistency score across DQAs. Inconsistent data across sources indicates reporting errors — used to identify reconciliation needs."
    - name: "avg_timeliness_score"
      expr: AVG(CAST(timeliness_score_percentage AS DOUBLE))
      comment: "Average timeliness score across DQAs. Late data submission undermines real-time program management — used to assess reporting discipline."
    - name: "total_dqa_assessments"
      expr: COUNT(1)
      comment: "Total number of DQAs conducted. Used to assess DQA coverage relative to the active indicator portfolio."
    - name: "corrective_action_pending_count"
      expr: COUNT(CASE WHEN corrective_action_status IN ('pending', 'in_progress') THEN 1 END)
      comment: "Count of DQAs with pending corrective actions. Unresolved corrective actions represent ongoing data quality risk — used for risk management reporting."
    - name: "high_priority_dqa_count"
      expr: COUNT(CASE WHEN priority_level = 'high' THEN 1 END)
      comment: "Count of high-priority DQAs. Used to focus management attention on the most critical data quality issues."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_dhis2_aggregate_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DHIS2 aggregate reporting quality and integration view. Tracks submission completeness, data quality flags, and integration status for DHIS2 aggregate reports. Used by MEL and health information system teams to monitor national health data reporting compliance. Critical for Ministry of Health partnerships and UN agency coordination."
  source: "`vibe_ngo_v1`.`mel`.`dhis2_aggregate_report`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Status of the DHIS2 report (draft, submitted, approved, rejected) — used to track reporting pipeline."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the report — used to filter to approved reports for official statistics."
    - name: "integration_status"
      expr: integration_status
      comment: "Status of data integration from source systems to DHIS2 (pending, synced, failed) — used to monitor integration health."
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Type of reporting period (monthly, quarterly, annual) — used for period-appropriate analysis."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Boolean flag indicating data quality issues were detected in this report — used to identify reports requiring review before official submission."
    - name: "data_set_name"
      expr: data_set_name
      comment: "Name of the DHIS2 data set — used to analyze reporting performance by data set."
    - name: "reporting_period_start_date"
      expr: DATE_TRUNC('quarter', reporting_period_start_date)
      comment: "Quarter of the reporting period — used for trend analysis of DHIS2 reporting performance."
  measures:
    - name: "avg_completeness_percentage"
      expr: AVG(CAST(completeness_percentage AS DOUBLE))
      comment: "Average data completeness percentage across DHIS2 reports. Primary DHIS2 reporting KPI — completeness below 80% typically triggers national health authority escalation."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across DHIS2 aggregate reports. Used to monitor overall DHIS2 data quality and identify systematic issues."
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total number of DHIS2 aggregate reports submitted. Used to assess reporting volume and coverage."
    - name: "approved_report_count"
      expr: COUNT(CASE WHEN approval_status = 'approved' THEN 1 END)
      comment: "Count of approved DHIS2 reports. Approval rate is a key HMIS performance indicator — used in Ministry of Health performance reviews."
    - name: "data_quality_flagged_report_count"
      expr: COUNT(CASE WHEN data_quality_flag = TRUE THEN 1 END)
      comment: "Count of reports with data quality flags. High flag rates indicate systematic data collection or entry problems — triggers investigation and corrective action."
    - name: "integration_failed_report_count"
      expr: COUNT(CASE WHEN integration_status = 'failed' THEN 1 END)
      comment: "Count of reports where DHIS2 integration failed. Integration failures result in missing national statistics — triggers immediate IT and MEL team response."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_meal_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MEAL plan portfolio and budget tracking view. Monitors MEAL plan coverage, budget allocation, and strategic alignment across programs and awards. Used by MEL directors and program managers to ensure adequate MEAL resourcing and planning quality. Relevant to donor MEAL budget requirements (typically 3-5% of program budget)."
  source: "`vibe_ngo_v1`.`mel`.`meal_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the MEAL plan (draft, approved, active, closed) — used to filter to active plans for operational monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the MEAL plan budget — used for multi-currency budget analysis."
    - name: "chs_commitment_alignment"
      expr: chs_commitment_alignment
      comment: "CHS commitment the MEAL plan aligns to — used for CHS self-assessment and accountability reporting."
    - name: "rbm_framework_alignment"
      expr: rbm_framework_alignment
      comment: "Results-based management framework the plan aligns to — used to assess alignment with organizational and donor RBM requirements."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the MEAL plan became effective — used for annual portfolio analysis."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the MEAL plan — used for SDG contribution planning and reporting."
  measures:
    - name: "total_meal_budget_allocated"
      expr: SUM(CAST(budget_allocated AS DOUBLE))
      comment: "Total MEAL budget allocated across plans in scope. Primary MEAL resourcing KPI — used to assess whether MEAL investment meets donor requirements (typically 3-5% of program budget)."
    - name: "avg_meal_budget_allocated"
      expr: AVG(CAST(budget_allocated AS DOUBLE))
      comment: "Average MEAL budget per plan. Used to benchmark MEAL investment levels across programs and identify under-resourced plans."
    - name: "total_meal_plans"
      expr: COUNT(1)
      comment: "Total number of MEAL plans in the portfolio. Used to assess MEAL planning coverage — every active program should have an approved MEAL plan."
    - name: "approved_meal_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'approved' THEN 1 END)
      comment: "Count of approved MEAL plans. Programs without approved MEAL plans are at risk of donor non-compliance — used for compliance tracking."
    - name: "avg_beneficiary_feedback_channels"
      expr: AVG(CAST(beneficiary_feedback_channels AS DOUBLE))
      comment: "Average number of beneficiary feedback channels per MEAL plan. CHS Commitment 5 requires accessible feedback mechanisms — used for accountability compliance monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_geographic_scope`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Geographic coverage and vulnerability analysis view. Tracks the geographic footprint of MEL activities, population coverage, and vulnerability indices across operational areas. Used by program directors, MEL leads, and field coordinators to prioritize geographic targeting and assess coverage gaps. Supports humanitarian needs analysis and geographic targeting decisions."
  source: "`vibe_ngo_v1`.`mel`.`geographic_scope`"
  dimensions:
    - name: "scope_type"
      expr: scope_type
      comment: "Type of geographic scope (country, region, district, community) — used to analyze coverage at different administrative levels."
    - name: "scope_status"
      expr: scope_status
      comment: "Operational status of the geographic scope (active, inactive, phased-out) — used to filter to active operational areas."
    - name: "country_code"
      expr: country_code
      comment: "ISO country code — used for country-level geographic analysis."
    - name: "urban_rural_classification"
      expr: urban_rural_classification
      comment: "Urban/rural classification — used to analyze coverage equity between urban and rural populations."
    - name: "conflict_affected_flag"
      expr: conflict_affected_flag
      comment: "Whether the area is conflict-affected — used to prioritize humanitarian response and apply appropriate access protocols."
    - name: "hard_to_reach_flag"
      expr: hard_to_reach_flag
      comment: "Whether the area is hard to reach — used to identify coverage gaps and plan access strategies."
    - name: "disaster_prone_flag"
      expr: disaster_prone_flag
      comment: "Whether the area is disaster-prone — used for risk-informed programming and contingency planning."
    - name: "administrative_level"
      expr: administrative_level
      comment: "Administrative level of the geographic unit — used for hierarchical geographic analysis."
  measures:
    - name: "total_population_estimate"
      expr: SUM(CAST(population_estimate AS DOUBLE))
      comment: "Total estimated population across geographic scopes in scope. Primary coverage KPI — used to assess total potential reach and compare against actual beneficiary counts."
    - name: "avg_vulnerability_index"
      expr: AVG(CAST(vulnerability_index AS DOUBLE))
      comment: "Average vulnerability index across geographic areas. Used to prioritize geographic targeting — higher vulnerability areas should receive proportionally more resources."
    - name: "total_area_square_km"
      expr: SUM(CAST(area_square_km AS DOUBLE))
      comment: "Total geographic area covered in square kilometers. Used to assess operational footprint and plan field team deployment."
    - name: "conflict_affected_area_count"
      expr: COUNT(CASE WHEN conflict_affected_flag = TRUE THEN 1 END)
      comment: "Count of conflict-affected geographic areas. Used to assess the scale of conflict-affected operations and apply appropriate security and access protocols."
    - name: "hard_to_reach_area_count"
      expr: COUNT(CASE WHEN hard_to_reach_flag = TRUE THEN 1 END)
      comment: "Count of hard-to-reach areas. Used to identify coverage gaps and plan targeted outreach strategies for underserved populations."
    - name: "total_geographic_scopes"
      expr: COUNT(1)
      comment: "Total number of geographic scopes in the MEL framework. Used to assess geographic coverage breadth of the monitoring system."
    - name: "avg_population_per_scope"
      expr: AVG(CAST(population_estimate AS DOUBLE))
      comment: "Average population per geographic scope. Used to assess population density of operational areas and plan data collection resource requirements."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_reporting_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reporting period management and compliance view. Tracks the status, deadlines, and special characteristics of reporting periods across the MEL calendar. Used by MEL managers and program teams to ensure timely data submission and reporting compliance. Critical for donor reporting deadline management."
  source: "`vibe_ngo_v1`.`mel`.`reporting_period`"
  dimensions:
    - name: "period_type"
      expr: period_type
      comment: "Type of reporting period (monthly, quarterly, semi-annual, annual) — used to analyze reporting burden by period type."
    - name: "period_status"
      expr: period_status
      comment: "Current status of the reporting period (open, closed, locked) — used to filter to active periods for data entry management."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of reporting for this period — used for reporting calendar planning."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the reporting period — used for annual performance analysis."
    - name: "is_active"
      expr: is_active
      comment: "Whether the reporting period is currently active — used to filter dashboards to current periods."
    - name: "baseline_period_flag"
      expr: baseline_period_flag
      comment: "Whether this is a baseline reporting period — used to identify baseline data collection periods."
    - name: "midline_period_flag"
      expr: midline_period_flag
      comment: "Whether this is a midline reporting period — used to identify mid-term review periods."
    - name: "endline_period_flag"
      expr: endline_period_flag
      comment: "Whether this is an endline reporting period — used to identify final evaluation periods."
    - name: "data_quality_audit_flag"
      expr: data_quality_audit_flag
      comment: "Whether a data quality audit is scheduled for this period — used to plan DQA resources."
    - name: "start_date"
      expr: DATE_TRUNC('year', start_date)
      comment: "Year of the reporting period start — used for annual trend analysis."
  measures:
    - name: "total_reporting_periods"
      expr: COUNT(1)
      comment: "Total number of reporting periods in the MEL calendar. Used to assess reporting calendar complexity and plan MEL team capacity."
    - name: "active_reporting_period_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active reporting periods. Multiple simultaneous active periods indicate high concurrent reporting burden — used for workload management."
    - name: "overdue_submission_count"
      expr: COUNT(CASE WHEN report_submission_deadline < CURRENT_DATE AND period_status <> 'closed' THEN 1 END)
      comment: "Count of reporting periods past their submission deadline and not yet closed. Overdue submissions risk donor non-compliance and financial penalties — triggers immediate management escalation."
    - name: "data_quality_audit_scheduled_count"
      expr: COUNT(CASE WHEN data_quality_audit_flag = TRUE THEN 1 END)
      comment: "Count of reporting periods with scheduled data quality audits. Used to plan DQA resources and ensure audit coverage meets donor requirements."
    - name: "baseline_period_count"
      expr: COUNT(CASE WHEN baseline_period_flag = TRUE THEN 1 END)
      comment: "Count of baseline reporting periods. Used to ensure all programs have completed baseline data collection — a prerequisite for impact measurement."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_learning_agenda`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Organizational learning agenda tracking view. Monitors the progress, budget utilization, and strategic alignment of learning questions across the organization. Used by MEL directors and senior management to drive evidence-based decision-making and organizational learning. Aligns with CHS Commitment 7 (continuous learning and improvement)."
  source: "`vibe_ngo_v1`.`mel`.`learning_agenda`"
  dimensions:
    - name: "learning_agenda_status"
      expr: learning_agenda_status
      comment: "Current status of the learning agenda item (planned, in-progress, completed, disseminated) — used for pipeline tracking."
    - name: "learning_question_type"
      expr: learning_question_type
      comment: "Type of learning question (effectiveness, efficiency, relevance, sustainability, scalability) — used to analyze learning portfolio balance."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the learning question — used to focus resources on highest-priority learning needs."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the learning question — used for SDG-linked learning analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the learning budget — used for multi-currency budget analysis."
    - name: "donor_reporting_requirement"
      expr: donor_reporting_requirement
      comment: "Whether this learning question is a donor reporting requirement — used to prioritize donor-required learning activities."
    - name: "ethics_approval_required"
      expr: ethics_approval_required
      comment: "Whether ethics approval is required for this learning activity — used for ethics compliance planning."
    - name: "planned_start_date"
      expr: DATE_TRUNC('year', planned_start_date)
      comment: "Year the learning activity was planned to start — used for annual learning pipeline analysis."
  measures:
    - name: "total_learning_questions"
      expr: COUNT(1)
      comment: "Total number of learning agenda items. Used to assess the breadth of the organizational learning agenda."
    - name: "total_learning_budget_allocated"
      expr: SUM(CAST(budget_allocated AS DOUBLE))
      comment: "Total budget allocated to learning agenda activities. Used to assess organizational investment in learning and evidence generation."
    - name: "total_learning_budget_spent"
      expr: SUM(CAST(budget_spent AS DOUBLE))
      comment: "Total budget spent on learning agenda activities. Compared against allocated budget to assess learning investment utilization."
    - name: "avg_learning_budget_allocated"
      expr: AVG(CAST(budget_allocated AS DOUBLE))
      comment: "Average budget per learning question. Used to benchmark learning investment levels and identify under-resourced learning activities."
    - name: "completed_learning_count"
      expr: COUNT(CASE WHEN learning_agenda_status = 'completed' THEN 1 END)
      comment: "Count of completed learning agenda items. Used to track organizational learning delivery against the annual learning plan."
    - name: "donor_required_learning_count"
      expr: COUNT(CASE WHEN donor_reporting_requirement = TRUE THEN 1 END)
      comment: "Count of donor-required learning activities. Used to ensure all donor learning commitments are tracked and delivered."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_qualitative_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Qualitative data collection quality and coverage view. Tracks the volume, consent compliance, and quality of qualitative data records (FGDs, KIIs, case studies) across programs. Used by MEL managers to ensure qualitative evidence generation meets program learning needs and ethical standards. Relevant to Kobo Toolbox and Primero data collection workflows."
  source: "`vibe_ngo_v1`.`mel`.`qualitative_record`"
  dimensions:
    - name: "collection_method_type"
      expr: collection_method_type
      comment: "Type of qualitative data collection method (FGD, KII, observation, case study) — used to analyze qualitative method portfolio balance."
    - name: "qualitative_record_status"
      expr: qualitative_record_status
      comment: "Status of the qualitative record (draft, reviewed, approved, archived) — used to filter to approved records for analysis."
    - name: "data_quality_rating"
      expr: data_quality_rating
      comment: "Quality rating of the qualitative record (high, medium, low) — used to filter to high-quality records for evidence synthesis."
    - name: "country_code"
      expr: country_code
      comment: "Country where data was collected — used for geographic analysis of qualitative evidence."
    - name: "primary_theme"
      expr: primary_theme
      comment: "Primary thematic focus of the qualitative record — used for thematic evidence synthesis."
    - name: "informed_consent_obtained"
      expr: informed_consent_obtained
      comment: "Whether informed consent was obtained from participants — mandatory ethical requirement; used for compliance monitoring."
    - name: "translation_required"
      expr: translation_required
      comment: "Whether translation was required — used to plan translation resources and assess language accessibility."
    - name: "collection_date"
      expr: DATE_TRUNC('quarter', collection_date)
      comment: "Quarter data was collected — used for trend analysis of qualitative data collection activity."
  measures:
    - name: "total_qualitative_records"
      expr: COUNT(1)
      comment: "Total number of qualitative records collected. Baseline metric for qualitative evidence volume — used to assess qualitative data collection coverage."
    - name: "consent_compliant_record_count"
      expr: COUNT(CASE WHEN informed_consent_obtained = TRUE THEN 1 END)
      comment: "Count of records where informed consent was obtained. Consent compliance rate is a critical ethical KPI — non-compliant records cannot be used in analysis or reporting."
    - name: "high_quality_record_count"
      expr: COUNT(CASE WHEN data_quality_rating = 'high' THEN 1 END)
      comment: "Count of high-quality qualitative records. Used to assess the proportion of qualitative evidence that meets quality standards for evidence synthesis."
    - name: "approved_record_count"
      expr: COUNT(CASE WHEN qualitative_record_status = 'approved' THEN 1 END)
      comment: "Count of approved qualitative records. Only approved records should be used in program reports and evaluations — used for evidence quality control."
    - name: "recording_consent_compliant_count"
      expr: COUNT(CASE WHEN recording_consent_obtained = TRUE THEN 1 END)
      comment: "Count of records where recording consent was obtained. Required for audio/video recordings — used for data protection compliance monitoring."
$$;