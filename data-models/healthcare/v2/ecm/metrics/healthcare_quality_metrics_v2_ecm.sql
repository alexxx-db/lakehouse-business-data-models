-- Metric views for domain: quality | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 07:21:53

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_measure_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality measure performance results used for CMS/MIPS/VBP reporting and provider performance steering. Tracks numerator/denominator, performance rates, benchmark gaps, and VBP scoring."
  source: "`vibe_healthcare_v1`.`quality`.`measure_result`"
  dimensions:
    - name: "performance_year"
      expr: performance_year
      comment: "Performance measurement year for trending measure results."
    - name: "reporting_program"
      expr: reporting_program
      comment: "Reporting program (e.g., MIPS, VBP, HEDIS) the result belongs to."
    - name: "measure_domain"
      expr: measure_domain
      comment: "Clinical/quality domain of the measure for portfolio grouping."
    - name: "vbp_domain"
      expr: vbp_domain
      comment: "Value-based purchasing domain for VBP scoring rollups."
    - name: "result_status"
      expr: result_status
      comment: "Status of the measure result (final, draft, etc.)."
    - name: "is_publicly_reported"
      expr: is_publicly_reported
      comment: "Whether result is publicly reported, driving reputation exposure."
    - name: "measurement_period_start_month"
      expr: DATE_TRUNC('MONTH', measurement_period_start_date)
      comment: "Measurement period start bucketed to month for trend analysis."
  measures:
    - name: "result_count"
      expr: COUNT(1)
      comment: "Number of measure result records — baseline volume for reporting coverage."
    - name: "avg_performance_rate"
      expr: AVG(CAST(performance_rate AS DOUBLE))
      comment: "Average measure performance rate — core quality performance KPI for leadership review."
    - name: "avg_gap_to_target_rate"
      expr: AVG(CAST(gap_to_target_rate AS DOUBLE))
      comment: "Average gap between performance and target — signals improvement opportunity for intervention."
    - name: "avg_percentile_rank"
      expr: AVG(CAST(percentile_rank AS DOUBLE))
      comment: "Average national percentile rank — competitive benchmarking KPI."
    - name: "total_mips_points_earned"
      expr: SUM(CAST(mips_points_earned AS DOUBLE))
      comment: "Total MIPS points earned — directly tied to CMS payment adjustment."
    - name: "avg_vbp_achievement_score"
      expr: AVG(CAST(vbp_achievement_score AS DOUBLE))
      comment: "Average VBP achievement score — drives value-based payment outcomes."
    - name: "publicly_reported_result_count"
      expr: COUNT(CASE WHEN is_publicly_reported = TRUE THEN 1 END)
      comment: "Count of publicly reported results — reputational risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_care_gap_closure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care gap closure tracking for HEDIS/measure compliance. Central KPI layer for population health gap-closure rate, timeliness, and financial impact of open gaps."
  source: "`vibe_healthcare_v1`.`quality`.`care_gap_closure`"
  dimensions:
    - name: "gap_type"
      expr: gap_type
      comment: "Type of care gap for portfolio prioritization."
    - name: "gap_status"
      expr: gap_status
      comment: "Current status of the gap (open/closed) for pipeline tracking."
    - name: "closure_method"
      expr: closure_method
      comment: "Method used to close the gap for channel effectiveness analysis."
    - name: "measurement_year"
      expr: measurement_year
      comment: "Measurement year for annual gap-closure trending."
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for program alignment."
    - name: "gap_identified_month"
      expr: DATE_TRUNC('MONTH', gap_identified_date)
      comment: "Month gap was identified for cohort trending."
  measures:
    - name: "gap_count"
      expr: COUNT(1)
      comment: "Total care gaps tracked — denominator for closure-rate KPIs."
    - name: "closed_gap_count"
      expr: COUNT(CASE WHEN is_closed = TRUE THEN 1 END)
      comment: "Count of closed care gaps — numerator for closure-rate KPI."
    - name: "gap_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_closed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of gaps closed — flagship population-health quality KPI steering outreach investment."
    - name: "avg_days_to_closure"
      expr: AVG(CAST(days_to_closure AS DOUBLE))
      comment: "Average days to close a gap — timeliness KPI driving outreach process improvement."
    - name: "excluded_gap_count"
      expr: COUNT(CASE WHEN is_excluded = TRUE THEN 1 END)
      comment: "Count of excluded gaps — measures exclusion volume affecting compliant denominator."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of care gaps — ties gap closure to revenue/at-risk dollars."
    - name: "avg_outreach_attempts"
      expr: AVG(CAST(outreach_count AS DOUBLE))
      comment: "Average outreach attempts per gap — efficiency of engagement operations."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_patient_safety_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient safety event surveillance layer. Tracks sentinel events, harm levels, reportability, and action-plan closure — core patient-safety and regulatory risk KPIs."
  source: "`vibe_healthcare_v1`.`quality`.`patient_safety_event`"
  dimensions:
    - name: "event_category"
      expr: event_category
      comment: "Category of the safety event for portfolio grouping."
    - name: "event_type"
      expr: event_type
      comment: "Type of safety event for root-cause analysis."
    - name: "harm_level_description"
      expr: harm_level_description
      comment: "Severity of patient harm for risk stratification."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the event record."
    - name: "action_plan_status"
      expr: action_plan_status
      comment: "Status of the corrective action plan."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Event occurrence month for trending safety incidents."
  measures:
    - name: "event_count"
      expr: COUNT(1)
      comment: "Total patient safety events — baseline safety surveillance volume."
    - name: "sentinel_event_count"
      expr: COUNT(CASE WHEN is_sentinel_event = TRUE THEN 1 END)
      comment: "Count of sentinel events — highest-severity safety KPI triggering board-level review."
    - name: "cms_reportable_count"
      expr: COUNT(CASE WHEN is_cms_reportable = TRUE THEN 1 END)
      comment: "CMS reportable events — regulatory compliance exposure."
    - name: "state_reportable_count"
      expr: COUNT(CASE WHEN is_state_reportable = TRUE THEN 1 END)
      comment: "State reportable events — state regulatory exposure."
    - name: "sentinel_event_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_sentinel_event = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of events that are sentinel — safety severity KPI for quality steering."
    - name: "effectiveness_verified_count"
      expr: COUNT(CASE WHEN effectiveness_verified = TRUE THEN 1 END)
      comment: "Events with verified corrective-action effectiveness — closure quality KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_hedis_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HEDIS measure result layer for health-plan quality reporting and Star Ratings. Tracks performance rates versus NCQA benchmarks and star weighting."
  source: "`vibe_healthcare_v1`.`quality`.`hedis_result`"
  dimensions:
    - name: "measurement_year"
      expr: measurement_year
      comment: "HEDIS measurement year for annual trending."
    - name: "product_line"
      expr: product_line
      comment: "Product line (Commercial/Medicare/Medicaid) for line-of-business analysis."
    - name: "data_source_type"
      expr: data_source_type
      comment: "Administrative vs hybrid data source affecting rates."
    - name: "submission_status"
      expr: submission_status
      comment: "NCQA submission status for reporting readiness."
    - name: "benchmark_comparison_result"
      expr: benchmark_comparison_result
      comment: "Result of benchmark comparison for competitive positioning."
  measures:
    - name: "hedis_result_count"
      expr: COUNT(1)
      comment: "Total HEDIS result records — reporting coverage baseline."
    - name: "avg_performance_rate"
      expr: AVG(CAST(performance_rate AS DOUBLE))
      comment: "Average HEDIS performance rate — flagship health-plan quality KPI driving Star Ratings."
    - name: "avg_rate_change_from_prior_year"
      expr: AVG(CAST(rate_change_from_prior_year AS DOUBLE))
      comment: "Average year-over-year rate change — improvement trajectory KPI."
    - name: "starred_measure_count"
      expr: COUNT(CASE WHEN is_starred_measure = TRUE THEN 1 END)
      comment: "Count of star-rated measures — Star Ratings portfolio exposure."
    - name: "avg_star_rating_weight"
      expr: AVG(CAST(star_rating_weight AS DOUBLE))
      comment: "Average star-rating weight — weighting of measures in bonus calculations."
    - name: "reportable_result_count"
      expr: COUNT(CASE WHEN is_reportable = TRUE THEN 1 END)
      comment: "Count of reportable results meeting thresholds — submission completeness KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_mips_measure_reporting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MIPS measure reporting layer tracking points earned, data completeness, and payment adjustment — directly tied to CMS reimbursement outcomes."
  source: "`vibe_healthcare_v1`.`quality`.`mips_measure_reporting`"
  dimensions:
    - name: "mips_category"
      expr: mips_category
      comment: "MIPS performance category for score composition."
    - name: "performance_year"
      expr: performance_year
      comment: "MIPS performance year for annual trending."
    - name: "collection_type"
      expr: collection_type
      comment: "Data collection method affecting scoring."
    - name: "submission_status"
      expr: submission_status
      comment: "Submission status for reporting readiness."
    - name: "high_priority_flag"
      expr: high_priority_flag
      comment: "Whether the measure is high priority for bonus eligibility."
  measures:
    - name: "mips_reporting_count"
      expr: COUNT(1)
      comment: "Total MIPS measure reporting records — reporting volume baseline."
    - name: "avg_measure_score"
      expr: AVG(CAST(measure_score AS DOUBLE))
      comment: "Average MIPS measure score — core reimbursement-driving KPI."
    - name: "total_points_earned"
      expr: SUM(CAST(points_earned AS DOUBLE))
      comment: "Total MIPS points earned — aggregate performance tied to payment adjustment."
    - name: "avg_data_completeness_rate"
      expr: AVG(CAST(data_completeness_rate AS DOUBLE))
      comment: "Average data completeness — must exceed CMS threshold to avoid penalties."
    - name: "avg_payment_adjustment_pct"
      expr: AVG(CAST(payment_adjustment_pct AS DOUBLE))
      comment: "Average payment adjustment percentage — direct financial outcome KPI."
    - name: "topped_out_measure_count"
      expr: COUNT(CASE WHEN is_topped_out = TRUE THEN 1 END)
      comment: "Count of topped-out measures — signals need to reselect measures for scoring value."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_raf_score`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk Adjustment Factor (RAF) scoring layer for Medicare Advantage revenue optimization. Tracks RAF values, HCC recapture, coding gaps, and revenue impact."
  source: "`vibe_healthcare_v1`.`quality`.`raf_score`"
  dimensions:
    - name: "measurement_year"
      expr: measurement_year
      comment: "RAF measurement year for annual trending."
    - name: "payment_year"
      expr: payment_year
      comment: "Payment year for revenue alignment."
    - name: "hcc_model_version"
      expr: hcc_model_version
      comment: "CMS-HCC model version used for scoring."
    - name: "risk_segment"
      expr: risk_segment
      comment: "Risk segment for population stratification."
    - name: "score_status"
      expr: score_status
      comment: "Status of the RAF score (draft/final)."
  measures:
    - name: "raf_member_count"
      expr: COUNT(1)
      comment: "Number of scored members — RAF population baseline."
    - name: "avg_raf_score"
      expr: AVG(CAST(raf_score AS DOUBLE))
      comment: "Average RAF score — flagship risk-adjustment revenue KPI for MA plans."
    - name: "avg_raf_delta"
      expr: AVG(CAST(raf_delta AS DOUBLE))
      comment: "Average RAF change — trajectory of documented member acuity."
    - name: "total_revenue_impact"
      expr: SUM(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Total revenue impact of RAF — directly ties coding accuracy to plan revenue."
    - name: "recapture_opportunity_count"
      expr: COUNT(CASE WHEN recapture_opportunity_flag = TRUE THEN 1 END)
      comment: "Members with HCC recapture opportunity — actionable coding-improvement KPI."
    - name: "avg_coding_completeness_pct"
      expr: AVG(CAST(coding_completeness_pct AS DOUBLE))
      comment: "Average coding completeness — quality of documentation driving accurate RAF."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_cahps_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HCAHPS/CAHPS patient experience survey layer. Tracks domain composite scores, star ratings, and response performance — patient-experience KPIs feeding VBP."
  source: "`vibe_healthcare_v1`.`quality`.`cahps_survey`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Type of CAHPS survey for cohort analysis."
    - name: "star_rating"
      expr: star_rating
      comment: "Overall star rating for reputational benchmarking."
    - name: "survey_status"
      expr: survey_status
      comment: "Survey status for completeness tracking."
    - name: "administration_mode"
      expr: administration_mode
      comment: "Survey administration mode affecting response patterns."
    - name: "reporting_period_start_month"
      expr: DATE_TRUNC('MONTH', reporting_period_start)
      comment: "Reporting period start month for experience trending."
  measures:
    - name: "survey_count"
      expr: COUNT(1)
      comment: "Total CAHPS surveys — experience program volume baseline."
    - name: "avg_nurse_communication_score"
      expr: AVG(CAST(score_communication_nurses AS DOUBLE))
      comment: "Average nurse communication score — key patient-experience driver."
    - name: "avg_doctor_communication_score"
      expr: AVG(CAST(score_communication_doctors AS DOUBLE))
      comment: "Average doctor communication score — key patient-experience driver."
    - name: "avg_responsiveness_score"
      expr: AVG(CAST(score_responsiveness_staff AS DOUBLE))
      comment: "Average staff responsiveness score — operational experience KPI."
    - name: "avg_vbp_patient_experience_score"
      expr: AVG(CAST(vbp_patient_experience_score AS DOUBLE))
      comment: "Average VBP patient experience score — ties experience to value-based payment."
    - name: "response_received_count"
      expr: COUNT(CASE WHEN response_received = TRUE THEN 1 END)
      comment: "Surveys with received responses — response-rate numerator for experience programs."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_improvement_initiative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality improvement initiative portfolio layer. Tracks cost savings, ROI, completion, and sustainment — steering QI investment decisions."
  source: "`vibe_healthcare_v1`.`quality`.`improvement_initiative`"
  dimensions:
    - name: "initiative_type"
      expr: initiative_type
      comment: "Type of improvement initiative for portfolio grouping."
    - name: "initiative_status"
      expr: initiative_status
      comment: "Current status of the initiative."
    - name: "clinical_domain"
      expr: clinical_domain
      comment: "Clinical domain the initiative targets."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for resource allocation."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Initiative start month for portfolio timing analysis."
  measures:
    - name: "initiative_count"
      expr: COUNT(1)
      comment: "Total improvement initiatives — QI portfolio volume."
    - name: "total_actual_savings"
      expr: SUM(CAST(actual_savings_amount AS DOUBLE))
      comment: "Total realized savings — financial outcome of QI portfolio."
    - name: "total_estimated_savings"
      expr: SUM(CAST(estimated_savings AS DOUBLE))
      comment: "Total estimated savings — planned financial value for pipeline sizing."
    - name: "avg_roi_percentage"
      expr: AVG(CAST(roi_percentage AS DOUBLE))
      comment: "Average ROI — efficiency of QI investment for prioritization."
    - name: "sustained_initiative_count"
      expr: COUNT(CASE WHEN sustained_flag = TRUE THEN 1 END)
      comment: "Count of sustained initiatives — durability KPI for QI effectiveness."
    - name: "improvement_achieved_count"
      expr: COUNT(CASE WHEN improvement_achieved_flag = TRUE THEN 1 END)
      comment: "Initiatives achieving target improvement — success-rate numerator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_mortality_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mortality review layer tracking preventability, sentinel classification, and CMS mortality measure impact — critical clinical quality and safety KPIs."
  source: "`vibe_healthcare_v1`.`quality`.`mortality_review`"
  dimensions:
    - name: "death_classification"
      expr: death_classification
      comment: "Classification of death for review categorization."
    - name: "preventability_determination"
      expr: preventability_determination
      comment: "Preventability determination — key quality signal."
    - name: "review_status"
      expr: review_status
      comment: "Status of the mortality review."
    - name: "review_trigger_type"
      expr: review_trigger_type
      comment: "What triggered the review for source analysis."
    - name: "death_month"
      expr: DATE_TRUNC('MONTH', death_date)
      comment: "Month of death for mortality trending."
  measures:
    - name: "review_count"
      expr: COUNT(1)
      comment: "Total mortality reviews — surveillance volume baseline."
    - name: "sentinel_event_count"
      expr: COUNT(CASE WHEN sentinel_event_flag = TRUE THEN 1 END)
      comment: "Mortality reviews flagged sentinel — highest-severity quality KPI."
    - name: "hai_related_count"
      expr: COUNT(CASE WHEN hai_related_flag = TRUE THEN 1 END)
      comment: "HAI-related deaths — infection-prevention outcome KPI."
    - name: "readmission_related_count"
      expr: COUNT(CASE WHEN readmission_related_flag = TRUE THEN 1 END)
      comment: "Readmission-related deaths — care-coordination quality signal."
    - name: "avg_days_admission_to_death"
      expr: AVG(CAST(days_from_admission_to_death AS DOUBLE))
      comment: "Average days from admission to death — clinical trajectory KPI."
    - name: "action_plan_required_count"
      expr: COUNT(CASE WHEN action_plan_required_flag = TRUE THEN 1 END)
      comment: "Reviews requiring action plans — improvement workload driver."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_accreditation_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accreditation survey layer tracking findings, deficiencies, readiness scores, and corrective-action status — regulatory compliance and accreditation risk KPIs."
  source: "`vibe_healthcare_v1`.`quality`.`accreditation_survey`"
  dimensions:
    - name: "accrediting_body"
      expr: accrediting_body
      comment: "Accrediting body (e.g., TJC) for survey type analysis."
    - name: "survey_type"
      expr: survey_type
      comment: "Type of survey conducted."
    - name: "survey_status"
      expr: survey_status
      comment: "Current status of the survey."
    - name: "accreditation_decision"
      expr: accreditation_decision
      comment: "Accreditation decision outcome."
    - name: "survey_start_month"
      expr: DATE_TRUNC('MONTH', survey_start_date)
      comment: "Survey start month for timeline tracking."
  measures:
    - name: "survey_count"
      expr: COUNT(1)
      comment: "Total accreditation surveys — compliance activity baseline."
    - name: "avg_overall_readiness_score"
      expr: AVG(CAST(overall_readiness_score AS DOUBLE))
      comment: "Average readiness score — accreditation-preparedness KPI for leadership."
    - name: "condition_level_deficiency_count"
      expr: COUNT(CASE WHEN condition_level_deficiency = TRUE THEN 1 END)
      comment: "Surveys with condition-level deficiencies — most severe compliance risk."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_survey_required = TRUE THEN 1 END)
      comment: "Surveys requiring follow-up — remediation workload and risk KPI."
    - name: "unannounced_survey_count"
      expr: COUNT(CASE WHEN is_unannounced = TRUE THEN 1 END)
      comment: "Count of unannounced surveys — exposure to surprise regulatory scrutiny."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_sdoh_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Social determinants of health screening layer. Tracks positive screens, risk stratification, and referral generation — health-equity and population-health KPIs."
  source: "`vibe_healthcare_v1`.`quality`.`sdoh_screening`"
  dimensions:
    - name: "screening_tool"
      expr: screening_tool
      comment: "Screening instrument used for methodology comparison."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier assigned for stratification."
    - name: "screening_status"
      expr: screening_status
      comment: "Status of the screening record."
    - name: "sdoh_category"
      expr: sdoh_category
      comment: "SDOH category for domain-level need analysis."
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', screening_date)
      comment: "Screening month for equity-program trending."
  measures:
    - name: "screening_count"
      expr: COUNT(1)
      comment: "Total SDOH screenings — health-equity program volume."
    - name: "positive_screen_count"
      expr: COUNT(CASE WHEN positive_screen_flag = TRUE THEN 1 END)
      comment: "Positive screens — identified social-need volume driving intervention."
    - name: "positive_screen_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN positive_screen_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of positive screens — population social-risk prevalence KPI."
    - name: "referral_generated_count"
      expr: COUNT(CASE WHEN referral_generated_flag = TRUE THEN 1 END)
      comment: "Screenings generating referrals — resource-connection action KPI."
    - name: "avg_overall_risk_score"
      expr: AVG(CAST(overall_risk_score AS DOUBLE))
      comment: "Average overall SDOH risk score — population social-risk intensity KPI."
    - name: "need_closed_count"
      expr: COUNT(CASE WHEN need_closed_flag = TRUE THEN 1 END)
      comment: "Screenings with closed needs — outcome KPI for social-need resolution."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_apm_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Alternative Payment Model enrollment layer tracking shared savings/loss, benchmark expenditure, and QP status — value-based payment risk and revenue KPIs."
  source: "`vibe_healthcare_v1`.`quality`.`apm_enrollment`"
  dimensions:
    - name: "apm_model_name"
      expr: apm_model_name
      comment: "APM model name for program grouping."
    - name: "risk_arrangement_type"
      expr: risk_arrangement_type
      comment: "Risk arrangement type for risk-bearing analysis."
    - name: "participation_status"
      expr: participation_status
      comment: "Participation status in the APM."
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for annual trending."
    - name: "qp_status"
      expr: qp_status
      comment: "Qualifying APM Participant status affecting bonus."
  measures:
    - name: "enrollment_count"
      expr: COUNT(1)
      comment: "Total APM enrollments — VBP participation baseline."
    - name: "total_shared_savings"
      expr: SUM(CAST(shared_savings_amount AS DOUBLE))
      comment: "Total shared savings earned — direct VBP revenue outcome."
    - name: "total_shared_loss"
      expr: SUM(CAST(shared_loss_amount AS DOUBLE))
      comment: "Total shared losses incurred — downside risk exposure KPI."
    - name: "total_cost_of_care"
      expr: SUM(CAST(total_cost_of_care AS DOUBLE))
      comment: "Total cost of care under APMs — expenditure management KPI."
    - name: "avg_benchmark_expenditure"
      expr: AVG(CAST(benchmark_expenditure AS DOUBLE))
      comment: "Average benchmark expenditure — baseline for savings calculation."
    - name: "two_sided_risk_count"
      expr: COUNT(CASE WHEN two_sided_risk_flag = TRUE THEN 1 END)
      comment: "Enrollments in two-sided risk — downside-risk portfolio exposure."
    - name: "qualifying_participant_count"
      expr: COUNT(CASE WHEN qualifying_apm_participant_flag = TRUE THEN 1 END)
      comment: "Qualifying APM participants — eligibility for advanced-APM bonus."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_population_health_gap`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Population health gap tracking layer. Monitors open/closed gaps, outreach status, and priority scoring — population-health management steering KPIs."
  source: "`vibe_healthcare_v1`.`quality`.`population_health_gap`"
  dimensions:
    - name: "gap_category"
      expr: gap_category
      comment: "Category of population-health gap for prioritization."
    - name: "gap_status"
      expr: gap_status
      comment: "Current status of the gap."
    - name: "clinical_domain"
      expr: clinical_domain
      comment: "Clinical domain the gap belongs to."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for outreach targeting."
    - name: "measurement_year"
      expr: measurement_year
      comment: "Measurement year for annual trending."
  measures:
    - name: "gap_count"
      expr: COUNT(1)
      comment: "Total population-health gaps — management pipeline baseline."
    - name: "open_gap_count"
      expr: COUNT(CASE WHEN is_open = TRUE THEN 1 END)
      comment: "Open gaps — actionable outreach backlog KPI."
    - name: "closed_gap_count"
      expr: COUNT(CASE WHEN is_closed = TRUE THEN 1 END)
      comment: "Closed gaps — closure numerator for population-health effectiveness."
    - name: "gap_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_closed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of gaps closed — population-health management effectiveness KPI."
    - name: "avg_priority_score"
      expr: AVG(CAST(priority_score AS DOUBLE))
      comment: "Average gap priority score — targeting-intensity KPI for outreach resourcing."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action plan tracking layer. Monitors completion progress, effectiveness verification, and recurrence — quality-remediation execution KPIs."
  source: "`vibe_healthcare_v1`.`quality`.`corrective_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action for portfolio grouping."
    - name: "action_status"
      expr: action_status
      comment: "Current status of the corrective action."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for remediation sequencing."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department accountable for the action."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Action due month for remediation timeline tracking."
  measures:
    - name: "action_count"
      expr: COUNT(1)
      comment: "Total corrective actions — remediation portfolio baseline."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete — remediation progress KPI."
    - name: "effectiveness_verified_count"
      expr: COUNT(CASE WHEN effectiveness_verified = TRUE THEN 1 END)
      comment: "Actions with verified effectiveness — durable-fix KPI."
    - name: "recurrence_count"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Actions with recurrence — signals ineffective remediation for escalation."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_accreditation_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accreditation program performance metrics"
  source: "`vibe_healthcare_v1`.`quality`.`accreditation_program`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Identifier of the care site"
    - name: "program_name"
      expr: program_name
      comment: "Name of the accreditation program"
    - name: "program_type"
      expr: program_type
      comment: "Type of accreditation program"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the accreditation program became effective"
  measures:
    - name: "total_accreditations"
      expr: COUNT(1)
      comment: "Total number of accreditation program records"
    - name: "active_accreditations"
      expr: SUM(CASE WHEN expiration_date >= CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of currently active accreditations (expiration date in the future)"
    - name: "avg_readiness_score"
      expr: AVG(CAST(readiness_score AS DOUBLE))
      comment: "Average readiness score across accreditation programs"
    - name: "deemed_accreditations"
      expr: SUM(CASE WHEN deemed_status THEN 1 ELSE 0 END)
      comment: "Count of accreditations where deemed_status is true"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_hedis_measure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HEDIS measure performance metrics"
  source: "`vibe_healthcare_v1`.`quality`.`hedis_measure`"
  dimensions:
    - name: "measure_year"
      expr: measurement_year
      comment: "Year of the measurement period"
    - name: "clinical_area"
      expr: clinical_area
      comment: "Clinical area of the measure"
    - name: "measure_type"
      expr: measure_type
      comment: "Type/category of the measure"
  measures:
    - name: "total_measures"
      expr: COUNT(1)
      comment: "Total number of HEDIS measures defined"
    - name: "avg_target_performance_rate"
      expr: AVG(CAST(target_performance_rate AS DOUBLE))
      comment: "Average target performance rate across measures"
    - name: "avg_national_average_rate"
      expr: AVG(CAST(national_average_rate AS DOUBLE))
      comment: "Average national benchmark rate"
    - name: "avg_minimum_performance_threshold"
      expr: AVG(CAST(minimum_performance_threshold AS DOUBLE))
      comment: "Average minimum performance threshold"
$$;