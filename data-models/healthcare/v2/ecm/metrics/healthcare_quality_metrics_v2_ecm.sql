-- Metric views for domain: quality | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 14:53:25

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_measure_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality measure performance outcomes — core KPI layer for value-based purchasing, MIPS, and public reporting decisions."
  source: "`vibe_healthcare_v1`.`quality`.`measure_result`"
  dimensions:
    - name: "measurement_period_end"
      expr: DATE_TRUNC('MONTH', measurement_period_end_date)
      comment: "Month bucket of the measurement period end for trending performance over time."
    - name: "reporting_program"
      expr: reporting_program
      comment: "The reporting program (CMS, MIPS, NCQA, etc.) the measure result belongs to."
    - name: "vbp_domain"
      expr: vbp_domain
      comment: "Value-based purchasing domain (safety, clinical outcomes, efficiency, patient experience)."
    - name: "measure_domain"
      expr: measure_domain
      comment: "Clinical/measure domain grouping for portfolio analysis."
    - name: "result_status"
      expr: result_status
      comment: "Status of the measure result (final, preliminary, etc.)."
    - name: "performance_year"
      expr: performance_year
      comment: "Performance/reporting year for cohort comparison."
    - name: "is_publicly_reported"
      expr: is_publicly_reported
      comment: "Whether this measure result is publicly reported, driving reputational risk decisions."
  measures:
    - name: "Measure Result Count"
      expr: COUNT(1)
      comment: "Total number of measure results — baseline volume for coverage tracking."
    - name: "Avg Performance Rate"
      expr: AVG(CAST(performance_rate AS DOUBLE))
      comment: "Average performance rate across measures — headline quality KPI for steering committees."
    - name: "Avg Gap To Target Rate"
      expr: AVG(CAST(gap_to_target_rate AS DOUBLE))
      comment: "Average gap to target — quantifies distance from performance goals to prioritize improvement effort."
    - name: "Avg National Benchmark Rate"
      expr: AVG(CAST(national_benchmark_rate AS DOUBLE))
      comment: "Average national benchmark rate for competitive positioning."
    - name: "Avg Percentile Rank"
      expr: AVG(CAST(percentile_rank AS DOUBLE))
      comment: "Average percentile rank against peers — indicates relative national standing."
    - name: "Total VBP Achievement Score"
      expr: SUM(CAST(vbp_achievement_score AS DOUBLE))
      comment: "Sum of VBP achievement points — drives payment adjustment outcomes."
    - name: "Total VBP Improvement Score"
      expr: SUM(CAST(vbp_improvement_score AS DOUBLE))
      comment: "Sum of VBP improvement points — rewards year-over-year gains under value-based payment."
    - name: "Total MIPS Points Earned"
      expr: SUM(CAST(mips_points_earned AS DOUBLE))
      comment: "Sum of MIPS points earned — directly tied to Medicare reimbursement adjustments."
    - name: "Avg Data Completeness Rate"
      expr: AVG(CAST(data_completeness_rate AS DOUBLE))
      comment: "Average data completeness — data quality risk indicator for reporting validity."
    - name: "Publicly Reported Measure Count"
      expr: COUNT(DISTINCT CASE WHEN is_publicly_reported = TRUE THEN measure_result_id END)
      comment: "Count of publicly reported measure results — reputational exposure surface."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_patient_safety_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient safety event tracking — critical for harm reduction, sentinel event management, and regulatory reporting decisions."
  source: "`vibe_healthcare_v1`.`quality`.`patient_safety_event`"
  dimensions:
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of the safety event for trend and hotspot analysis."
    - name: "event_type"
      expr: event_type
      comment: "Type of patient safety event for categorized safety surveillance."
    - name: "event_category"
      expr: event_category
      comment: "Event category grouping for portfolio-level safety analysis."
    - name: "harm_level_description"
      expr: harm_level_description
      comment: "Severity of patient harm — drives escalation and intervention priority."
    - name: "event_status"
      expr: event_status
      comment: "Lifecycle status of the event investigation."
    - name: "patient_outcome"
      expr: patient_outcome
      comment: "Resulting patient outcome for harm severity assessment."
    - name: "action_plan_status"
      expr: action_plan_status
      comment: "Status of the corrective action plan for accountability tracking."
  measures:
    - name: "Safety Event Count"
      expr: COUNT(1)
      comment: "Total safety events — core patient safety volume metric for board safety reviews."
    - name: "Sentinel Event Count"
      expr: COUNT(DISTINCT CASE WHEN is_sentinel_event = TRUE THEN patient_safety_event_id END)
      comment: "Count of sentinel events — highest-severity events triggering mandatory root cause analysis."
    - name: "CMS Reportable Event Count"
      expr: COUNT(DISTINCT CASE WHEN is_cms_reportable = TRUE THEN patient_safety_event_id END)
      comment: "Count of CMS-reportable events — regulatory exposure and compliance obligation."
    - name: "State Reportable Event Count"
      expr: COUNT(DISTINCT CASE WHEN is_state_reportable = TRUE THEN patient_safety_event_id END)
      comment: "Count of state-reportable events for state regulatory compliance."
    - name: "Effectiveness Verified Count"
      expr: COUNT(DISTINCT CASE WHEN effectiveness_verified = TRUE THEN patient_safety_event_id END)
      comment: "Count of events with verified action-plan effectiveness — measures closure quality."
    - name: "Disclosed Event Count"
      expr: COUNT(DISTINCT CASE WHEN disclosure_status IS NOT NULL AND disclosure_status <> '' THEN patient_safety_event_id END)
      comment: "Count of events with patient disclosure — transparency and communication compliance."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_hedis_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HEDIS measure results — payer/health plan quality performance for Stars ratings and NCQA accreditation decisions."
  source: "`vibe_healthcare_v1`.`quality`.`hedis_result`"
  dimensions:
    - name: "reporting_period_end"
      expr: DATE_TRUNC('MONTH', reporting_period_end_date)
      comment: "Month bucket of the HEDIS reporting period end for trending."
    - name: "measurement_year"
      expr: measurement_year
      comment: "HEDIS measurement year for year-over-year cohort comparison."
    - name: "product_line"
      expr: product_line
      comment: "Product line (commercial, Medicare, Medicaid) for line-of-business analysis."
    - name: "methodology_type"
      expr: methodology_type
      comment: "HEDIS methodology (administrative vs hybrid) for data-collection strategy."
    - name: "submission_status"
      expr: submission_status
      comment: "Submission status to NCQA/CMS for compliance tracking."
    - name: "benchmark_comparison_result"
      expr: benchmark_comparison_result
      comment: "Result of comparison to NCQA benchmark for positioning."
  measures:
    - name: "HEDIS Result Count"
      expr: COUNT(1)
      comment: "Total HEDIS results — reporting coverage baseline."
    - name: "Avg Performance Rate"
      expr: AVG(CAST(performance_rate AS DOUBLE))
      comment: "Average HEDIS performance rate — headline quality KPI driving Stars ratings."
    - name: "Avg Prior Year Performance Rate"
      expr: AVG(CAST(prior_year_performance_rate AS DOUBLE))
      comment: "Average prior-year rate to contextualize improvement."
    - name: "Avg Rate Change From Prior Year"
      expr: AVG(CAST(rate_change_from_prior_year AS DOUBLE))
      comment: "Average year-over-year rate change — quantifies improvement trajectory."
    - name: "Avg NCQA 90th Percentile Benchmark"
      expr: AVG(CAST(ncqa_benchmark_percentile_90 AS DOUBLE))
      comment: "Average NCQA 90th percentile benchmark — top-decile performance target."
    - name: "Total Care Gap Count"
      expr: SUM(CAST(gap_count AS BIGINT))
      comment: "Sum of open care gaps — actionable population health workload to close."
    - name: "Starred Measure Count"
      expr: COUNT(DISTINCT CASE WHEN is_starred_measure = TRUE THEN hedis_result_id END)
      comment: "Count of Stars-weighted measures — highest-impact measures for Medicare Advantage bonus payments."
    - name: "Avg Star Rating Weight"
      expr: AVG(CAST(star_rating_weight AS DOUBLE))
      comment: "Average star-rating weight of results — measures Stars program exposure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_population_health_gap`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Population health care gaps — actionable gap closure workload for value-based care and quality bonus achievement."
  source: "`vibe_healthcare_v1`.`quality`.`population_health_gap`"
  dimensions:
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the gap was identified for inflow trending."
    - name: "gap_type"
      expr: gap_type
      comment: "Type of care gap for clinical categorization."
    - name: "gap_category"
      expr: gap_category
      comment: "Care gap category grouping for portfolio analysis."
    - name: "gap_status"
      expr: gap_status
      comment: "Open/closed status of the gap for workload management."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for outreach prioritization."
    - name: "reporting_program"
      expr: reporting_program
      comment: "Quality/reporting program driving the gap for program-level accountability."
    - name: "measurement_year"
      expr: measurement_year
      comment: "Measurement year cohort."
  measures:
    - name: "Care Gap Count"
      expr: COUNT(1)
      comment: "Total care gaps — population health workload baseline."
    - name: "Closed Gap Count"
      expr: COUNT(DISTINCT CASE WHEN closure_date IS NOT NULL THEN population_health_gap_id END)
      comment: "Count of closed gaps — gap-closure throughput measure tied to quality bonuses."
    - name: "Numerator Compliant Count"
      expr: COUNT(DISTINCT CASE WHEN is_numerator_compliant = TRUE THEN population_health_gap_id END)
      comment: "Count of numerator-compliant patients — numerator hits driving measure performance."
    - name: "Denominator Eligible Count"
      expr: COUNT(DISTINCT CASE WHEN is_denominator_eligible = TRUE THEN population_health_gap_id END)
      comment: "Count of denominator-eligible patients — measure denominator for rate calculation."
    - name: "Avg Risk Score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average patient risk score — prioritizes high-risk populations for intervention."
    - name: "Total Outreach Attempts"
      expr: SUM(CAST(outreach_attempt_count AS BIGINT))
      comment: "Sum of outreach attempts — measures engagement effort against gap closure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_cahps_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CAHPS/HCAHPS patient experience survey results — patient satisfaction KPIs for VBP and public reporting."
  source: "`vibe_healthcare_v1`.`quality`.`cahps_survey`"
  dimensions:
    - name: "reporting_period_end"
      expr: DATE_TRUNC('MONTH', reporting_period_end)
      comment: "Month bucket of reporting period end for trend analysis."
    - name: "survey_type"
      expr: survey_type
      comment: "Type of CAHPS survey for cross-survey comparison."
    - name: "star_rating"
      expr: star_rating
      comment: "HCAHPS star rating for public-reporting positioning."
    - name: "survey_status"
      expr: survey_status
      comment: "Survey lifecycle status."
    - name: "publicly_reported"
      expr: publicly_reported
      comment: "Whether the survey result is publicly reported — reputational exposure."
  measures:
    - name: "Survey Count"
      expr: COUNT(1)
      comment: "Total CAHPS surveys — patient experience sampling volume."
    - name: "Avg Doctor Communication Score"
      expr: AVG(CAST(score_communication_doctors AS DOUBLE))
      comment: "Average doctor communication score — key HCAHPS experience dimension."
    - name: "Avg Nurse Communication Score"
      expr: AVG(CAST(score_communication_nurses AS DOUBLE))
      comment: "Average nurse communication score — key HCAHPS experience dimension."
    - name: "Avg Staff Responsiveness Score"
      expr: AVG(CAST(score_responsiveness_staff AS DOUBLE))
      comment: "Average staff responsiveness score — operational service KPI."
    - name: "Avg Care Transition Score"
      expr: AVG(CAST(score_care_transition AS DOUBLE))
      comment: "Average care transition score — discharge and continuity experience."
    - name: "Avg HCAHPS Linear Mean Score"
      expr: AVG(CAST(hcahps_linear_mean_score AS DOUBLE))
      comment: "Average HCAHPS linear mean score — headline patient experience composite."
    - name: "Avg VBP Patient Experience Score"
      expr: AVG(CAST(vbp_patient_experience_score AS DOUBLE))
      comment: "Average VBP patient experience score — directly drives value-based payment adjustments."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action tracking — accountability and timeliness of quality/safety remediation for compliance and risk decisions."
  source: "`vibe_healthcare_v1`.`quality`.`corrective_action`"
  dimensions:
    - name: "assigned_month"
      expr: DATE_TRUNC('MONTH', assigned_date)
      comment: "Month the action was assigned for workload trending."
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action for categorization."
    - name: "action_status"
      expr: action_status
      comment: "Status of the corrective action for workflow tracking."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for triage and resource allocation."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for systemic pattern analysis."
    - name: "regulatory_program"
      expr: regulatory_program
      comment: "Associated regulatory program for compliance grouping."
  measures:
    - name: "Corrective Action Count"
      expr: COUNT(1)
      comment: "Total corrective actions — remediation workload baseline."
    - name: "Overdue Action Count"
      expr: COUNT(DISTINCT CASE WHEN is_overdue = TRUE THEN corrective_action_id END)
      comment: "Count of overdue actions — timeliness risk indicator requiring escalation."
    - name: "Effectiveness Verified Count"
      expr: COUNT(DISTINCT CASE WHEN effectiveness_verified = TRUE THEN corrective_action_id END)
      comment: "Count of actions with verified effectiveness — remediation quality measure."
    - name: "CMS Reportable Action Count"
      expr: COUNT(DISTINCT CASE WHEN is_cms_reportable = TRUE THEN corrective_action_id END)
      comment: "Count of CMS-reportable corrective actions — regulatory obligation surface."
    - name: "Avg Days To Complete"
      expr: AVG(CAST(days_to_complete AS DOUBLE))
      comment: "Average days to complete corrective actions — remediation cycle-time efficiency KPI."
    - name: "Completed Action Count"
      expr: COUNT(DISTINCT CASE WHEN completion_date IS NOT NULL THEN corrective_action_id END)
      comment: "Count of completed actions — closure throughput measure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_accreditation_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accreditation survey outcomes — Joint Commission/CMS survey readiness and deficiency management for accreditation risk."
  source: "`vibe_healthcare_v1`.`quality`.`accreditation_survey`"
  dimensions:
    - name: "survey_start_month"
      expr: DATE_TRUNC('MONTH', survey_start_date)
      comment: "Month bucket of survey start for scheduling and trend analysis."
    - name: "survey_type"
      expr: survey_type
      comment: "Type of accreditation survey."
    - name: "survey_status"
      expr: survey_status
      comment: "Survey lifecycle status."
    - name: "accreditation_decision"
      expr: accreditation_decision
      comment: "Accreditation decision outcome — the ultimate survey result."
    - name: "accrediting_body"
      expr: accrediting_body
      comment: "Accrediting body (TJC, DNV, CMS) for body-specific analysis."
  measures:
    - name: "Survey Count"
      expr: COUNT(1)
      comment: "Total accreditation surveys — survey activity baseline."
    - name: "Avg Overall Readiness Score"
      expr: AVG(CAST(overall_readiness_score AS DOUBLE))
      comment: "Average survey readiness score — predictive KPI for accreditation success."
    - name: "Total Findings Count"
      expr: SUM(CAST(findings_count_total AS BIGINT))
      comment: "Sum of total survey findings — deficiency burden requiring correction."
    - name: "Total Immediate Threat Findings"
      expr: SUM(CAST(findings_count_immediate_threat AS BIGINT))
      comment: "Sum of immediate-threat findings — highest-severity deficiencies risking accreditation loss."
    - name: "Condition Level Deficiency Survey Count"
      expr: COUNT(DISTINCT CASE WHEN condition_level_deficiency = TRUE THEN accreditation_survey_id END)
      comment: "Count of surveys with condition-level deficiencies — most serious CMS finding category."
    - name: "Follow Up Required Count"
      expr: COUNT(DISTINCT CASE WHEN follow_up_survey_required = TRUE THEN accreditation_survey_id END)
      comment: "Count of surveys requiring follow-up — ongoing remediation obligation."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_mortality_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mortality review outcomes — preventability and quality-of-care assessment for patient safety and clinical governance."
  source: "`vibe_healthcare_v1`.`quality`.`mortality_review`"
  dimensions:
    - name: "review_initiated_month"
      expr: DATE_TRUNC('MONTH', review_initiated_date)
      comment: "Month the mortality review was initiated."
    - name: "review_status"
      expr: review_status
      comment: "Review lifecycle status."
    - name: "death_classification"
      expr: death_classification
      comment: "Classification of death for categorized analysis."
    - name: "preventability_determination"
      expr: preventability_determination
      comment: "Preventability determination — central quality-of-care finding."
    - name: "care_quality_rating"
      expr: care_quality_rating
      comment: "Care quality rating assigned during review."
    - name: "review_trigger_type"
      expr: review_trigger_type
      comment: "What triggered the review for surveillance analysis."
  measures:
    - name: "Mortality Review Count"
      expr: COUNT(1)
      comment: "Total mortality reviews — clinical governance review volume."
    - name: "Sentinel Event Related Count"
      expr: COUNT(DISTINCT CASE WHEN sentinel_event_flag = TRUE THEN mortality_review_id END)
      comment: "Count of sentinel-event-related deaths — mandatory intensive review cases."
    - name: "HAI Related Count"
      expr: COUNT(DISTINCT CASE WHEN hai_related_flag = TRUE THEN mortality_review_id END)
      comment: "Count of HAI-related deaths — infection-prevention impact measure."
    - name: "Readmission Related Count"
      expr: COUNT(DISTINCT CASE WHEN readmission_related_flag = TRUE THEN mortality_review_id END)
      comment: "Count of readmission-related deaths — care-continuity risk indicator."
    - name: "Action Plan Required Count"
      expr: COUNT(DISTINCT CASE WHEN action_plan_required_flag = TRUE THEN mortality_review_id END)
      comment: "Count of reviews requiring action plans — remediation workload from mortality analysis."
    - name: "Avg Days From Admission To Death"
      expr: AVG(CAST(days_from_admission_to_death AS DOUBLE))
      comment: "Average days from admission to death — clinical acuity and timing indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_sdoh_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Social determinants of health screening — health equity KPIs and referral effectiveness for population health and CMS compliance."
  source: "`vibe_healthcare_v1`.`quality`.`sdoh_screening`"
  dimensions:
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', screening_date)
      comment: "Month of screening for volume and trend analysis."
    - name: "sdoh_domain"
      expr: sdoh_domain
      comment: "SDOH domain (housing, food, transportation, etc.) for need categorization."
    - name: "screening_status"
      expr: screening_status
      comment: "Screening lifecycle status."
    - name: "screening_setting"
      expr: screening_setting
      comment: "Setting where the screening occurred."
    - name: "health_equity_stratifier"
      expr: health_equity_stratifier
      comment: "Health equity stratifier for disparity analysis."
    - name: "program_year"
      expr: program_year
      comment: "Program year cohort."
  measures:
    - name: "Screening Count"
      expr: COUNT(1)
      comment: "Total SDOH screenings — screening coverage baseline for CMS compliance."
    - name: "Positive Screen Count"
      expr: COUNT(DISTINCT CASE WHEN is_positive_screen = TRUE THEN sdoh_screening_id END)
      comment: "Count of positive screens — identified social need volume driving intervention."
    - name: "Referral Generated Count"
      expr: COUNT(DISTINCT CASE WHEN is_referral_generated = TRUE THEN sdoh_screening_id END)
      comment: "Count of referrals generated — closed-loop referral activity."
    - name: "Need Resolved Count"
      expr: COUNT(DISTINCT CASE WHEN need_resolved = TRUE THEN sdoh_screening_id END)
      comment: "Count of resolved needs — health equity outcome measure."
    - name: "Community Resource Connected Count"
      expr: COUNT(DISTINCT CASE WHEN community_resource_connected = TRUE THEN sdoh_screening_id END)
      comment: "Count of patients connected to community resources — social intervention effectiveness."
    - name: "Numerator Compliant Count"
      expr: COUNT(DISTINCT CASE WHEN is_numerator_compliant = TRUE THEN sdoh_screening_id END)
      comment: "Count of numerator-compliant screenings — measure performance driver."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_improvement_initiative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality improvement initiatives — performance-vs-goal tracking for QI portfolio management and executive steering."
  source: "`vibe_healthcare_v1`.`quality`.`improvement_initiative`"
  dimensions:
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the initiative started for portfolio timeline analysis."
    - name: "initiative_type"
      expr: initiative_type
      comment: "Type of improvement initiative."
    - name: "initiative_status"
      expr: initiative_status
      comment: "Initiative lifecycle status for portfolio health."
    - name: "current_phase"
      expr: current_phase
      comment: "Current phase (e.g., PDSA stage) for progress tracking."
    - name: "improvement_methodology"
      expr: improvement_methodology
      comment: "QI methodology (Lean, Six Sigma, PDSA) for approach analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for resource prioritization."
  measures:
    - name: "Initiative Count"
      expr: COUNT(1)
      comment: "Total improvement initiatives — QI portfolio size."
    - name: "Avg Baseline Value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline performance value — starting point for improvement measurement."
    - name: "Avg Current Performance Value"
      expr: AVG(CAST(current_performance_value AS DOUBLE))
      comment: "Average current performance value — real-time initiative progress."
    - name: "Avg Goal Value"
      expr: AVG(CAST(goal_value AS DOUBLE))
      comment: "Average target goal value — aspiration benchmark for initiatives."
    - name: "CMS Reportable Initiative Count"
      expr: COUNT(DISTINCT CASE WHEN is_cms_reportable = TRUE THEN improvement_initiative_id END)
      comment: "Count of CMS-reportable initiatives — regulatory-linked QI work."
    - name: "Sentinel Event Related Count"
      expr: COUNT(DISTINCT CASE WHEN is_sentinel_event_related = TRUE THEN improvement_initiative_id END)
      comment: "Count of sentinel-event-driven initiatives — highest-priority safety improvement work."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_contract_initiative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payer contract quality initiatives — incentive earning and penalty exposure for value-based contract management."
  source: "`vibe_healthcare_v1`.`quality`.`contract_initiative`"
  dimensions:
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the contract initiative started."
    - name: "contract_initiative_status"
      expr: contract_initiative_status
      comment: "Status of the contract initiative."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Reporting frequency for cadence analysis."
    - name: "contract_measure_code"
      expr: contract_measure_code
      comment: "Contract measure code for measure-level contract analysis."
  measures:
    - name: "Contract Initiative Count"
      expr: COUNT(1)
      comment: "Total contract initiatives — value-based contract portfolio size."
    - name: "Total Incentive Earned To Date"
      expr: SUM(CAST(incentive_earned_to_date AS DOUBLE))
      comment: "Sum of incentives earned — realized value-based revenue KPI."
    - name: "Total Penalty Incurred To Date"
      expr: SUM(CAST(penalty_incurred_to_date AS DOUBLE))
      comment: "Sum of penalties incurred — downside contract risk realized."
    - name: "Total Incentive Amount At Stake"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Sum of total incentive amounts available — upside opportunity in contracts."
    - name: "Total Penalty Amount At Risk"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Sum of penalty amounts at risk — downside exposure requiring management."
    - name: "Avg Performance Target"
      expr: AVG(CAST(performance_target AS DOUBLE))
      comment: "Average performance target across contract measures."
    - name: "Mandatory Initiative Count"
      expr: COUNT(DISTINCT CASE WHEN is_mandatory = TRUE THEN contract_initiative_id END)
      comment: "Count of mandatory contract initiatives — non-negotiable obligations."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_peer_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physician peer review outcomes — provider quality governance, FPPE/OPPE triggers, and NPDB reporting decisions."
  source: "`vibe_healthcare_v1`.`quality`.`quality_peer_review`"
  dimensions:
    - name: "case_open_month"
      expr: DATE_TRUNC('MONTH', case_open_date)
      comment: "Month the peer review case opened."
    - name: "review_type"
      expr: review_type
      comment: "Type of peer review."
    - name: "review_level"
      expr: review_level
      comment: "Review level for escalation analysis."
    - name: "case_status"
      expr: case_status
      comment: "Case lifecycle status."
    - name: "care_determination"
      expr: care_determination
      comment: "Care determination outcome — central quality judgment."
    - name: "trigger_type"
      expr: trigger_type
      comment: "Trigger type for the review."
  measures:
    - name: "Peer Review Count"
      expr: COUNT(1)
      comment: "Total peer review cases — provider quality governance volume."
    - name: "NPDB Reportable Count"
      expr: COUNT(DISTINCT CASE WHEN npdb_reportable_flag = TRUE THEN quality_peer_review_id END)
      comment: "Count of NPDB-reportable cases — national practitioner data bank reporting obligation."
    - name: "FPPE Trigger Count"
      expr: COUNT(DISTINCT CASE WHEN fppe_trigger_flag = TRUE THEN quality_peer_review_id END)
      comment: "Count of cases triggering focused professional practice evaluation — provider oversight escalation."
    - name: "Privileging Impact Count"
      expr: COUNT(DISTINCT CASE WHEN privileging_impact_flag = TRUE THEN quality_peer_review_id END)
      comment: "Count of cases impacting privileges — most consequential peer review outcomes."
    - name: "Educational Opportunity Count"
      expr: COUNT(DISTINCT CASE WHEN educational_opportunity_flag = TRUE THEN quality_peer_review_id END)
      comment: "Count of cases identifying educational opportunities — non-punitive improvement pathway."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_cdi_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical documentation integrity reviews — DRG accuracy and CMI impact for documentation quality and revenue integrity."
  source: "`vibe_healthcare_v1`.`quality`.`cdi_review`"
  dimensions:
    - name: "review_month"
      expr: DATE_TRUNC('MONTH', review_date)
      comment: "Month of the CDI review."
    - name: "review_type"
      expr: review_type
      comment: "Type of CDI review."
    - name: "review_status"
      expr: review_status
      comment: "Review lifecycle status."
    - name: "query_type"
      expr: query_type
      comment: "Type of CDI query issued to providers."
    - name: "query_outcome"
      expr: query_outcome
      comment: "Outcome of the CDI query — documentation impact result."
    - name: "cc_mcc_status"
      expr: cc_mcc_status
      comment: "CC/MCC status for severity-of-illness documentation analysis."
  measures:
    - name: "CDI Review Count"
      expr: COUNT(1)
      comment: "Total CDI reviews — documentation review workload."
    - name: "Avg CMI Impact"
      expr: AVG(CAST(cmi_impact AS DOUBLE))
      comment: "Average case-mix-index impact — quantifies documentation-driven reimbursement effect."
    - name: "Total CMI Impact"
      expr: SUM(CAST(cmi_impact AS DOUBLE))
      comment: "Sum of CMI impact across reviews — aggregate documentation revenue-integrity effect."
    - name: "Query Initiated Count"
      expr: COUNT(DISTINCT CASE WHEN query_initiated_flag = TRUE THEN cdi_review_id END)
      comment: "Count of reviews initiating a provider query — CDI engagement intensity."
    - name: "DRG Change Count"
      expr: COUNT(DISTINCT CASE WHEN drg_change_flag = TRUE THEN cdi_review_id END)
      comment: "Count of reviews resulting in a DRG change — documentation accuracy correction volume."
    - name: "CC MCC Opportunity Count"
      expr: COUNT(DISTINCT CASE WHEN cc_mcc_opportunity_flag = TRUE THEN cdi_review_id END)
      comment: "Count of CC/MCC capture opportunities — severity-documentation improvement pipeline."
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
    - name: "health_plan_id"
      expr: health_plan_id
      comment: "Health plan linked to the HEDIS measure"
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