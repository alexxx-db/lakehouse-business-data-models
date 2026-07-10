-- Metric views for domain: partnership | Business: Ngo | Version: 2 | Generated on: 2026-07-10 18:25:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for partnership agreements — tracks portfolio health, financial exposure, and agreement lifecycle status to inform partnership investment and risk decisions."
  source: "`vibe_ngo_v1`.`partnership`.`partnership_agreement`"
  dimensions:
    - name: "partnership_agreement_status"
      expr: partnership_agreement_status
      comment: "Current lifecycle status of the agreement (e.g., Active, Expired, Terminated) — primary filter for portfolio health analysis."
    - name: "partnership_agreement_type"
      expr: partnership_agreement_type
      comment: "Classification of the agreement type (e.g., Sub-award, MOU, Grant Agreement) — used to segment portfolio by instrument."
    - name: "operational_country_code"
      expr: operational_country_code
      comment: "Country where the partnership operates — enables geographic breakdown of the agreement portfolio."
    - name: "program_sector"
      expr: program_sector
      comment: "Thematic sector of the program covered by the agreement — supports sector-level portfolio analysis."
    - name: "is_consortium_agreement"
      expr: is_consortium_agreement
      comment: "Flags whether the agreement is part of a consortium arrangement — distinguishes bilateral from multi-party agreements."
    - name: "is_sub_award"
      expr: is_sub_award
      comment: "Flags whether the agreement is a sub-award — critical for compliance and pass-through funding tracking."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "How often the partner must report (e.g., Monthly, Quarterly) — used to assess reporting burden and compliance risk."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the agreement became effective — enables cohort and vintage analysis of the partnership portfolio."
    - name: "effective_end_year"
      expr: YEAR(effective_end_date)
      comment: "Year the agreement is scheduled to end — supports pipeline and renewal planning."
    - name: "due_diligence_risk_rating"
      expr: due_diligence_risk_rating
      comment: "Risk rating assigned during due diligence — key dimension for risk-stratified portfolio views."
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total number of partnership agreements — baseline portfolio size metric used in all agreement-level dashboards."
    - name: "total_funding_ceiling_usd"
      expr: SUM(CAST(funding_ceiling_amount AS DOUBLE))
      comment: "Sum of all agreement funding ceilings — represents total financial commitment across the partnership portfolio, a primary executive KPI."
    - name: "avg_funding_ceiling_usd"
      expr: AVG(CAST(funding_ceiling_amount AS DOUBLE))
      comment: "Average funding ceiling per agreement — benchmarks deal size and informs resource allocation decisions."
    - name: "avg_indirect_cost_rate_pct"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate across agreements — monitors overhead burden on the partnership portfolio and flags outliers for renegotiation."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN partnership_agreement_status = 'Active' THEN 1 END)
      comment: "Number of currently active agreements — core operational health indicator for the partnership portfolio."
    - name: "sub_award_agreement_count"
      expr: COUNT(CASE WHEN is_sub_award = TRUE THEN 1 END)
      comment: "Number of sub-award agreements — tracks pass-through funding volume for donor compliance and localization reporting."
    - name: "consortium_agreement_count"
      expr: COUNT(CASE WHEN is_consortium_agreement = TRUE THEN 1 END)
      comment: "Number of consortium agreements — measures multi-partner collaboration scale, a key localization and Grand Bargain indicator."
    - name: "distinct_partner_orgs"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of unique partner organizations with agreements — measures breadth of the partnership network."
    - name: "high_risk_agreement_count"
      expr: COUNT(CASE WHEN due_diligence_risk_rating IN ('High', 'Critical') THEN 1 END)
      comment: "Number of agreements with high or critical due diligence risk ratings — triggers enhanced monitoring and executive escalation."
    - name: "high_risk_funding_exposure_usd"
      expr: SUM(CASE WHEN due_diligence_risk_rating IN ('High', 'Critical') THEN CAST(funding_ceiling_amount AS DOUBLE) ELSE 0 END)
      comment: "Total funding ceiling for high/critical risk agreements — quantifies financial exposure from risky partnerships for risk committee review."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partner_org`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner organization portfolio KPIs — tracks due diligence status, capacity, financial scale, and sanctions screening health across the partner base."
  source: "`vibe_ngo_v1`.`partnership`.`partner_org`"
  dimensions:
    - name: "partner_org_type"
      expr: partner_org_type
      comment: "Type of partner organization (e.g., NGO, CBO, Government) — primary segmentation dimension for partner portfolio analysis."
    - name: "partnership_status"
      expr: partnership_status
      comment: "Current status of the partnership relationship — used to filter active vs. inactive partners."
    - name: "due_diligence_status"
      expr: due_diligence_status
      comment: "Current due diligence status of the partner — critical compliance dimension for donor reporting."
    - name: "hq_country"
      expr: hq_country
      comment: "Country where the partner organization is headquartered — enables geographic portfolio segmentation."
    - name: "chs_certified"
      expr: chs_certified
      comment: "Whether the partner holds Core Humanitarian Standard certification — quality and accountability indicator."
    - name: "sanctions_screened"
      expr: sanctions_screened
      comment: "Whether the partner has been screened against sanctions lists — compliance gate for all partnerships."
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Partner accreditation status — used to segment partners by quality tier."
  measures:
    - name: "total_partner_orgs"
      expr: COUNT(1)
      comment: "Total number of partner organizations in the registry — baseline portfolio size for partnership management."
    - name: "active_partner_count"
      expr: COUNT(CASE WHEN partnership_status = 'Active' THEN 1 END)
      comment: "Number of currently active partner organizations — core operational metric for partnership portfolio health."
    - name: "chs_certified_partner_count"
      expr: COUNT(CASE WHEN chs_certified = TRUE THEN 1 END)
      comment: "Number of CHS-certified partners — measures quality and accountability standards compliance across the partner base."
    - name: "chs_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN chs_certified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners with CHS certification — Grand Bargain localization KPI tracked by leadership and donors."
    - name: "sanctions_screened_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sanctions_screened = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners with completed sanctions screening — compliance health metric; any gap triggers immediate remediation."
    - name: "due_diligence_complete_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN due_diligence_status = 'Complete' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners with completed due diligence — donor compliance KPI; low rates signal fiduciary risk."
    - name: "total_annual_budget_usd"
      expr: SUM(CAST(annual_budget_usd AS DOUBLE))
      comment: "Sum of annual budgets across all partner organizations — proxy for total partner ecosystem financial scale."
    - name: "avg_capacity_assessment_score"
      expr: AVG(CAST(capacity_assessment_score AS DOUBLE))
      comment: "Average capacity assessment score across partners — tracks overall partner capability level and informs capacity building investment."
    - name: "overdue_due_diligence_count"
      expr: COUNT(CASE WHEN due_diligence_expiry_date < CURRENT_DATE() AND partnership_status = 'Active' THEN 1 END)
      comment: "Number of active partners with expired due diligence — critical compliance risk indicator requiring immediate action."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_capacity_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner capacity assessment KPIs — tracks assessment scores, risk ratings, and capacity gaps to drive targeted capacity building investment decisions."
  source: "`vibe_ngo_v1`.`partnership`.`capacity_assessment`"
  dimensions:
    - name: "capacity_assessment_status"
      expr: capacity_assessment_status
      comment: "Current status of the assessment (e.g., Completed, In Progress, Pending) — used to filter actionable assessments."
    - name: "capacity_assessment_type"
      expr: capacity_assessment_type
      comment: "Type of capacity assessment conducted — segments assessments by methodology or scope."
    - name: "overall_risk_rating"
      expr: overall_risk_rating
      comment: "Overall risk rating assigned by the assessment — primary risk stratification dimension for partner oversight."
    - name: "financial_risk_rating"
      expr: financial_risk_rating
      comment: "Financial management risk rating — used to identify partners requiring enhanced financial oversight."
    - name: "location_country"
      expr: location_country
      comment: "Country where the assessment was conducted — enables geographic analysis of partner capacity levels."
    - name: "capacity_building_plan_required"
      expr: capacity_building_plan_required
      comment: "Whether a capacity building plan is required based on assessment findings — drives follow-up action tracking."
    - name: "enhanced_monitoring_required"
      expr: enhanced_monitoring_required
      comment: "Whether enhanced monitoring was triggered by the assessment — flags partners needing intensified oversight."
    - name: "assessment_year"
      expr: YEAR(capacity_assessment_date)
      comment: "Year the assessment was conducted — enables trend analysis of partner capacity over time."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of capacity assessments conducted — baseline volume metric for assessment program management."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall capacity score across all assessments — headline KPI for partner ecosystem capability level."
    - name: "avg_financial_mgmt_score"
      expr: AVG(CAST(financial_mgmt_score AS DOUBLE))
      comment: "Average financial management score — tracks fiduciary capability across the partner base, a key donor compliance metric."
    - name: "avg_governance_score"
      expr: AVG(CAST(governance_score AS DOUBLE))
      comment: "Average governance score — measures organizational governance quality across partners."
    - name: "avg_program_mgmt_score"
      expr: AVG(CAST(program_mgmt_score AS DOUBLE))
      comment: "Average program management score — tracks programmatic delivery capability across the partner base."
    - name: "avg_mel_score"
      expr: AVG(CAST(mel_score AS DOUBLE))
      comment: "Average MEL (Monitoring, Evaluation, Learning) score — measures partner data quality and accountability capability."
    - name: "high_risk_partner_count"
      expr: COUNT(CASE WHEN overall_risk_rating IN ('High', 'Critical') THEN 1 END)
      comment: "Number of partners assessed as high or critical risk — triggers enhanced monitoring and executive escalation."
    - name: "capacity_building_plan_required_count"
      expr: COUNT(CASE WHEN capacity_building_plan_required = TRUE THEN 1 END)
      comment: "Number of assessments requiring a capacity building plan — drives capacity investment pipeline and budget planning."
    - name: "enhanced_monitoring_required_count"
      expr: COUNT(CASE WHEN enhanced_monitoring_required = TRUE THEN 1 END)
      comment: "Number of partners requiring enhanced monitoring — operational workload metric for partnership oversight teams."
    - name: "avg_partner_self_assessment_score"
      expr: AVG(CAST(partner_self_assessment_score AS DOUBLE))
      comment: "Average partner self-assessment score — compared against assessor scores to identify perception gaps and accountability culture."
    - name: "score_gap_assessor_vs_self"
      expr: AVG(CAST(overall_score AS DOUBLE)) - AVG(CAST(partner_self_assessment_score AS DOUBLE))
      comment: "Difference between assessor-assigned and partner self-assessment scores — measures alignment and identifies over/under-confident partners."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_capacity_building_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity building activity KPIs — tracks delivery, cost-efficiency, and quality of capacity building interventions to optimize the partner strengthening investment."
  source: "`vibe_ngo_v1`.`partnership`.`capacity_building_activity`"
  dimensions:
    - name: "capacity_building_activity_status"
      expr: capacity_building_activity_status
      comment: "Current status of the activity (e.g., Completed, In Progress, Cancelled) — used to filter delivered vs. pipeline activities."
    - name: "capacity_building_activity_type"
      expr: capacity_building_activity_type
      comment: "Type of capacity building activity (e.g., Training, Coaching, Workshop) — segments investment by modality."
    - name: "capacity_domain"
      expr: capacity_domain
      comment: "Functional domain targeted by the activity (e.g., Finance, HR, MEL) — identifies where capacity investment is concentrated."
    - name: "delivery_mode"
      expr: delivery_mode
      comment: "How the activity was delivered (e.g., In-person, Virtual, Blended) — used to compare cost and effectiveness by modality."
    - name: "thematic_area"
      expr: thematic_area
      comment: "Thematic sector of the activity — links capacity building to programmatic priorities."
    - name: "country_code"
      expr: country_code
      comment: "Country where the activity was delivered — enables geographic analysis of capacity building reach."
    - name: "is_certified"
      expr: is_certified
      comment: "Whether the activity results in a formal certification — distinguishes accredited from non-accredited training."
    - name: "facilitator_type"
      expr: facilitator_type
      comment: "Type of facilitator (e.g., Internal, External Consultant) — used to analyze cost and quality by delivery source."
    - name: "delivery_year"
      expr: YEAR(actual_delivery_date)
      comment: "Year the activity was delivered — enables trend analysis of capacity building program volume."
  measures:
    - name: "total_activities"
      expr: COUNT(1)
      comment: "Total number of capacity building activities — baseline volume metric for program delivery tracking."
    - name: "total_cost_usd"
      expr: SUM(CAST(cost_usd AS DOUBLE))
      comment: "Total cost of capacity building activities — primary financial KPI for capacity building program budget management."
    - name: "avg_cost_per_activity_usd"
      expr: AVG(CAST(cost_usd AS DOUBLE))
      comment: "Average cost per capacity building activity — efficiency benchmark for program planning and budget optimization."
    - name: "total_duration_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total hours of capacity building delivered — measures program intensity and investment in partner development."
    - name: "avg_completion_rate_pct"
      expr: AVG(CAST(completion_rate_pct AS DOUBLE))
      comment: "Average activity completion rate — quality indicator for capacity building program effectiveness."
    - name: "avg_participant_satisfaction_score"
      expr: AVG(CAST(participant_satisfaction_score AS DOUBLE))
      comment: "Average participant satisfaction score — measures perceived quality of capacity building delivery."
    - name: "avg_pre_assessment_score"
      expr: AVG(CAST(pre_assessment_score AS DOUBLE))
      comment: "Average pre-activity assessment score — baseline capability level before intervention."
    - name: "avg_post_assessment_score"
      expr: AVG(CAST(post_assessment_score AS DOUBLE))
      comment: "Average post-activity assessment score — measures knowledge/skill gain from capacity building."
    - name: "learning_gain_score"
      expr: AVG(CAST(post_assessment_score AS DOUBLE)) - AVG(CAST(pre_assessment_score AS DOUBLE))
      comment: "Average improvement from pre- to post-assessment — headline effectiveness KPI for capacity building program ROI."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_required = TRUE THEN 1 END)
      comment: "Number of activities requiring follow-up — tracks unresolved capacity gaps and pending action items."
    - name: "distinct_partners_trained"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of unique partner organizations that received capacity building — measures breadth of program reach."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_capacity_building_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity building plan KPIs — tracks plan progress, budget utilization, and score improvement targets to steer the partner strengthening strategy."
  source: "`vibe_ngo_v1`.`partnership`.`capacity_building_plan`"
  dimensions:
    - name: "capacity_building_plan_status"
      expr: capacity_building_plan_status
      comment: "Current status of the plan (e.g., Active, Completed, On Hold) — primary filter for active plan management."
    - name: "capacity_building_plan_type"
      expr: capacity_building_plan_type
      comment: "Type of capacity building plan — segments plans by scope or approach."
    - name: "overall_progress_status"
      expr: overall_progress_status
      comment: "Overall implementation progress status — used to identify plans at risk of falling behind."
    - name: "country_code"
      expr: country_code
      comment: "Country of plan implementation — enables geographic analysis of capacity building investment."
    - name: "chs_standard_aligned"
      expr: chs_standard_aligned
      comment: "Whether the plan is aligned to CHS standards — quality and accountability compliance dimension."
    - name: "safeguarding_component_included"
      expr: safeguarding_component_included
      comment: "Whether the plan includes a safeguarding component — tracks safeguarding mainstreaming across partner capacity programs."
    - name: "plan_start_year"
      expr: YEAR(start_date)
      comment: "Year the plan started — enables cohort analysis of capacity building plan outcomes."
  measures:
    - name: "total_plans"
      expr: COUNT(1)
      comment: "Total number of capacity building plans — baseline volume for program portfolio management."
    - name: "total_budget_usd"
      expr: SUM(CAST(total_budget_usd AS DOUBLE))
      comment: "Total budget allocated across all capacity building plans — primary financial commitment metric for the program."
    - name: "total_expenditure_to_date_usd"
      expr: SUM(CAST(expenditure_to_date_usd AS DOUBLE))
      comment: "Total expenditure to date across all plans — tracks actual spend against budget for financial management."
    - name: "budget_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(expenditure_to_date_usd AS DOUBLE)) / NULLIF(SUM(CAST(total_budget_usd AS DOUBLE)), 0), 2)
      comment: "Percentage of total budget spent to date — key financial efficiency KPI for capacity building program management."
    - name: "avg_baseline_capacity_score"
      expr: AVG(CAST(baseline_capacity_score AS DOUBLE))
      comment: "Average baseline capacity score at plan start — establishes the starting point for measuring capacity improvement."
    - name: "avg_current_capacity_score"
      expr: AVG(CAST(current_capacity_score AS DOUBLE))
      comment: "Average current capacity score — tracks real-time progress toward capacity targets."
    - name: "avg_target_capacity_score"
      expr: AVG(CAST(target_capacity_score AS DOUBLE))
      comment: "Average target capacity score — benchmarks ambition level of capacity building plans."
    - name: "capacity_score_improvement"
      expr: AVG(CAST(current_capacity_score AS DOUBLE)) - AVG(CAST(baseline_capacity_score AS DOUBLE))
      comment: "Average improvement in capacity score from baseline to current — headline outcome KPI for the capacity building program."
    - name: "safeguarding_component_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN safeguarding_component_included = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of plans that include a safeguarding component — measures safeguarding mainstreaming across the partner portfolio."
    - name: "distinct_partners_with_plans"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of unique partner organizations with active capacity building plans — measures breadth of structured capacity investment."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_due_diligence_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Due diligence KPIs — tracks compliance completeness, risk levels, and verification status across partner due diligence processes to manage fiduciary and reputational risk."
  source: "`vibe_ngo_v1`.`partnership`.`due_diligence_record`"
  dimensions:
    - name: "diligence_status"
      expr: diligence_status
      comment: "Current status of the due diligence process — primary filter for compliance tracking dashboards."
    - name: "diligence_type"
      expr: diligence_type
      comment: "Type of due diligence conducted (e.g., Full, Simplified, Enhanced) — segments by rigor level."
    - name: "risk_level"
      expr: risk_level
      comment: "Overall risk level assigned — primary risk stratification dimension for partner oversight."
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Final outcome of the due diligence (e.g., Approved, Rejected, Conditional) — tracks approval rates and rejection patterns."
    - name: "ngo_registration_country"
      expr: ngo_registration_country
      comment: "Country of NGO registration — enables geographic analysis of due diligence portfolio."
    - name: "chs_certification_status"
      expr: chs_certification_status
      comment: "CHS certification status at time of due diligence — quality compliance dimension."
    - name: "aml_cft_check_status"
      expr: aml_cft_check_status
      comment: "Anti-money laundering / counter-terrorism financing check status — critical compliance gate."
    - name: "initiation_year"
      expr: YEAR(initiation_date)
      comment: "Year due diligence was initiated — enables trend analysis of due diligence volume and cycle times."
  measures:
    - name: "total_due_diligence_records"
      expr: COUNT(1)
      comment: "Total number of due diligence records — baseline volume for compliance program management."
    - name: "completed_due_diligence_count"
      expr: COUNT(CASE WHEN diligence_status = 'Complete' THEN 1 END)
      comment: "Number of completed due diligence processes — tracks compliance throughput."
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN diligence_status = 'Complete' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of due diligence records completed — headline compliance health KPI for donor reporting."
    - name: "high_risk_count"
      expr: COUNT(CASE WHEN risk_level IN ('High', 'Critical') THEN 1 END)
      comment: "Number of high or critical risk due diligence records — triggers enhanced oversight and executive escalation."
    - name: "safeguarding_policy_verified_count"
      expr: COUNT(CASE WHEN safeguarding_policy_verified = TRUE THEN 1 END)
      comment: "Number of partners with verified safeguarding policies — tracks safeguarding compliance across the partner base."
    - name: "safeguarding_verification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN safeguarding_policy_verified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners with verified safeguarding policies — key accountability metric for safeguarding compliance programs."
    - name: "avg_cycle_time_days"
      expr: AVG(DATEDIFF(completion_date, initiation_date))
      comment: "Average number of days from due diligence initiation to completion — operational efficiency KPI for the compliance team."
    - name: "legal_registration_verified_count"
      expr: COUNT(CASE WHEN legal_registration_verified = TRUE THEN 1 END)
      comment: "Number of partners with verified legal registration — baseline legal compliance metric."
    - name: "financial_audit_reviewed_count"
      expr: COUNT(CASE WHEN financial_audit_reviewed = TRUE THEN 1 END)
      comment: "Number of partners with reviewed financial audits — fiduciary compliance metric for donor accountability."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partner_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner performance review KPIs — tracks programmatic quality, financial accountability, and corrective action rates to drive partnership renewal and risk decisions."
  source: "`vibe_ngo_v1`.`partnership`.`partner_performance_review`"
  dimensions:
    - name: "partner_performance_review_status"
      expr: partner_performance_review_status
      comment: "Current status of the review — used to filter completed vs. in-progress reviews."
    - name: "partner_performance_review_type"
      expr: partner_performance_review_type
      comment: "Type of performance review (e.g., Annual, Mid-term, Ad hoc) — segments reviews by cycle."
    - name: "overall_performance_rating"
      expr: overall_performance_rating
      comment: "Overall performance rating assigned — primary outcome dimension for partner performance analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned during the review — used to identify partners requiring intervention."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether a corrective action was required — flags underperforming partners for follow-up."
    - name: "capacity_building_recommended"
      expr: capacity_building_recommended
      comment: "Whether capacity building was recommended — links performance reviews to capacity investment pipeline."
    - name: "review_year"
      expr: YEAR(partner_performance_review_date)
      comment: "Year the review was conducted — enables trend analysis of partner performance over time."
    - name: "partnership_renewal_recommendation"
      expr: partnership_renewal_recommendation
      comment: "Recommendation on whether to renew the partnership — strategic decision-support dimension."
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of partner performance reviews — baseline volume for review program management."
    - name: "avg_overall_performance_score"
      expr: AVG(CAST(overall_performance_score AS DOUBLE))
      comment: "Average overall performance score across all reviews — headline KPI for partner portfolio quality."
    - name: "avg_budget_utilisation_rate_pct"
      expr: AVG(CAST(budget_utilisation_rate AS DOUBLE))
      comment: "Average budget utilization rate across partner reviews — financial efficiency KPI for partnership management."
    - name: "avg_milestone_achievement_rate_pct"
      expr: AVG(CAST(milestone_achievement_rate AS DOUBLE))
      comment: "Average milestone achievement rate — programmatic delivery KPI measuring partner execution against plans."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of reviews requiring corrective action — tracks underperformance volume and remediation workload."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews resulting in corrective action — portfolio quality health indicator; high rates signal systemic partner issues."
    - name: "capacity_building_recommended_count"
      expr: COUNT(CASE WHEN capacity_building_recommended = TRUE THEN 1 END)
      comment: "Number of reviews recommending capacity building — drives capacity investment pipeline from performance evidence."
    - name: "field_visit_conducted_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN field_visit_conducted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews that included a field visit — measures rigor of the performance review process."
    - name: "distinct_partners_reviewed"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of unique partner organizations reviewed — measures coverage of the performance review program."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partner_report_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner reporting compliance KPIs — tracks submission timeliness, quality, and financial accountability to manage donor compliance and partner accountability."
  source: "`vibe_ngo_v1`.`partnership`.`partner_report_submission`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of report submitted (e.g., Narrative, Financial, Combined) — segments reporting compliance by report category."
    - name: "review_status"
      expr: review_status
      comment: "Current review status of the submission — used to track reports pending review or requiring revision."
    - name: "is_late_submission"
      expr: is_late_submission
      comment: "Whether the report was submitted late — primary timeliness compliance dimension."
    - name: "country_code"
      expr: country_code
      comment: "Country of the reporting partner — enables geographic analysis of reporting compliance."
    - name: "report_period_frequency"
      expr: report_period_frequency
      comment: "Reporting frequency (e.g., Monthly, Quarterly, Annual) — segments compliance by reporting cycle."
    - name: "donor_reporting_obligation"
      expr: donor_reporting_obligation
      comment: "Whether the report fulfills a donor reporting obligation — distinguishes donor-required from internal reports."
    - name: "submission_year"
      expr: YEAR(partner_report_submission_date)
      comment: "Year of report submission — enables trend analysis of reporting compliance over time."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of partner report submissions — baseline volume for reporting compliance management."
    - name: "on_time_submission_count"
      expr: COUNT(CASE WHEN is_late_submission = FALSE THEN 1 END)
      comment: "Number of reports submitted on time — core timeliness compliance metric."
    - name: "on_time_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_late_submission = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports submitted on time — headline donor compliance KPI; low rates trigger partner remediation."
    - name: "total_expenditure_reported_usd"
      expr: SUM(CAST(total_expenditure_reported AS DOUBLE))
      comment: "Total expenditure reported across all partner submissions — tracks financial accountability volume."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average report quality score — measures narrative and financial reporting quality across the partner base."
    - name: "financial_documentation_attached_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN financial_documentation_attached = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports with financial documentation attached — fiduciary compliance metric for donor accountability."
    - name: "mel_indicators_reported_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mel_indicators_reported = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports that include MEL indicator data — measures programmatic accountability and data quality compliance."
    - name: "distinct_partners_reporting"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of unique partner organizations that submitted reports — measures reporting program coverage."
    - name: "avg_approved_budget_usd"
      expr: AVG(CAST(approved_budget_amount AS DOUBLE))
      comment: "Average approved budget per report submission — benchmarks financial scale of reporting obligations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_field_monitoring_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field monitoring visit KPIs — tracks compliance findings, corrective action rates, and monitoring coverage to manage partner oversight quality and risk."
  source: "`vibe_ngo_v1`.`partnership`.`field_monitoring_visit`"
  dimensions:
    - name: "field_monitoring_visit_status"
      expr: field_monitoring_visit_status
      comment: "Current status of the monitoring visit — used to filter completed vs. planned visits."
    - name: "field_monitoring_visit_type"
      expr: field_monitoring_visit_type
      comment: "Type of monitoring visit (e.g., Scheduled, Unannounced, Remote) — segments oversight by approach."
    - name: "overall_compliance_rating"
      expr: overall_compliance_rating
      comment: "Overall compliance rating from the visit — primary outcome dimension for monitoring quality analysis."
    - name: "corrective_action_plan_required"
      expr: corrective_action_plan_required
      comment: "Whether a corrective action plan was required — flags non-compliant partners for follow-up."
    - name: "site_country_code"
      expr: site_country_code
      comment: "Country of the monitored site — enables geographic analysis of monitoring coverage and findings."
    - name: "program_sector"
      expr: program_sector
      comment: "Program sector of the monitored activity — segments findings by thematic area."
    - name: "donor_notification_required"
      expr: donor_notification_required
      comment: "Whether the donor must be notified of findings — flags high-severity compliance issues."
    - name: "visit_year"
      expr: YEAR(field_monitoring_visit_date)
      comment: "Year of the monitoring visit — enables trend analysis of monitoring activity and findings."
  measures:
    - name: "total_monitoring_visits"
      expr: COUNT(1)
      comment: "Total number of field monitoring visits — baseline volume for oversight program management."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_plan_required = TRUE THEN 1 END)
      comment: "Number of visits requiring a corrective action plan — tracks non-compliance volume across the partner portfolio."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_plan_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of monitoring visits resulting in corrective action — headline compliance quality KPI for the oversight program."
    - name: "donor_notification_required_count"
      expr: COUNT(CASE WHEN donor_notification_required = TRUE THEN 1 END)
      comment: "Number of visits requiring donor notification — tracks high-severity compliance incidents with donor reporting implications."
    - name: "follow_up_visit_required_count"
      expr: COUNT(CASE WHEN follow_up_visit_required = TRUE THEN 1 END)
      comment: "Number of visits requiring a follow-up visit — measures unresolved compliance issues and monitoring workload."
    - name: "assets_verified_count"
      expr: COUNT(CASE WHEN assets_verified = TRUE THEN 1 END)
      comment: "Number of visits where assets were verified — tracks asset accountability compliance across the partner portfolio."
    - name: "distinct_partners_monitored"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of unique partner organizations monitored — measures coverage of the field monitoring program."
    - name: "distinct_awards_monitored"
      expr: COUNT(DISTINCT award_id)
      comment: "Number of unique awards covered by monitoring visits — tracks monitoring coverage relative to the active award portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partner_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner risk register KPIs — tracks financial exposure, risk materialization, and escalation rates to inform risk appetite decisions and partner oversight prioritization."
  source: "`vibe_ngo_v1`.`partnership`.`partner_risk_register`"
  dimensions:
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk (e.g., Open, Mitigated, Closed) — primary filter for active risk management."
    - name: "risk_category"
      expr: risk_category
      comment: "Category of the risk (e.g., Financial, Safeguarding, Operational) — segments risk portfolio by type."
    - name: "risk_level"
      expr: risk_level
      comment: "Overall risk level (e.g., Low, Medium, High, Critical) — primary risk stratification dimension."
    - name: "likelihood_rating"
      expr: likelihood_rating
      comment: "Likelihood rating of the risk materializing — used in risk matrix analysis."
    - name: "impact_rating"
      expr: impact_rating
      comment: "Impact rating if the risk materializes — used in risk matrix analysis."
    - name: "fiduciary_risk_flag"
      expr: fiduciary_risk_flag
      comment: "Whether the risk is fiduciary in nature — flags financial integrity risks for donor compliance."
    - name: "safeguarding_risk_flag"
      expr: safeguarding_risk_flag
      comment: "Whether the risk relates to safeguarding — flags risks requiring safeguarding escalation protocols."
    - name: "escalation_required"
      expr: escalation_required
      comment: "Whether the risk requires escalation — identifies risks needing senior management attention."
    - name: "risk_identification_year"
      expr: YEAR(risk_identification_date)
      comment: "Year the risk was identified — enables trend analysis of risk emergence patterns."
  measures:
    - name: "total_risks"
      expr: COUNT(1)
      comment: "Total number of risks in the partner risk register — baseline portfolio size for risk management."
    - name: "open_risk_count"
      expr: COUNT(CASE WHEN risk_status = 'Open' THEN 1 END)
      comment: "Number of currently open risks — operational risk management KPI requiring active mitigation."
    - name: "total_financial_exposure_usd"
      expr: SUM(CAST(financial_exposure_usd AS DOUBLE))
      comment: "Total financial exposure from all open risks — primary financial risk KPI for executive and board reporting."
    - name: "avg_financial_exposure_usd"
      expr: AVG(CAST(financial_exposure_usd AS DOUBLE))
      comment: "Average financial exposure per risk — benchmarks risk severity and informs risk appetite decisions."
    - name: "high_critical_risk_count"
      expr: COUNT(CASE WHEN risk_level IN ('High', 'Critical') THEN 1 END)
      comment: "Number of high or critical risks — triggers executive escalation and enhanced partner oversight."
    - name: "risk_materialized_count"
      expr: COUNT(CASE WHEN risk_materialised = TRUE THEN 1 END)
      comment: "Number of risks that have materialized — tracks actual loss events and informs risk model calibration."
    - name: "risk_materialization_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_materialised = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of identified risks that materialized — measures risk prediction accuracy and partner risk management effectiveness."
    - name: "fiduciary_risk_exposure_usd"
      expr: SUM(CASE WHEN fiduciary_risk_flag = TRUE THEN CAST(financial_exposure_usd AS DOUBLE) ELSE 0 END)
      comment: "Total financial exposure from fiduciary risks — critical donor compliance metric quantifying financial integrity risk."
    - name: "escalation_required_count"
      expr: COUNT(CASE WHEN escalation_required = TRUE THEN 1 END)
      comment: "Number of risks requiring escalation — operational workload metric for senior management and risk committees."
    - name: "distinct_partners_with_open_risks"
      expr: COUNT(DISTINCT CASE WHEN risk_status = 'Open' THEN partner_org_id END)
      comment: "Number of unique partner organizations with open risks — measures breadth of active risk exposure across the partner portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_consortium`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consortium KPIs — tracks multi-partner collaboration scale, localization progress, and funding distribution to inform Grand Bargain commitments and consortium governance decisions."
  source: "`vibe_ngo_v1`.`partnership`.`consortium`"
  dimensions:
    - name: "consortium_type"
      expr: consortium_type
      comment: "Type of consortium arrangement — segments by governance model or purpose."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the consortium — primary filter for active consortium management."
    - name: "country_code"
      expr: country_code
      comment: "Country of consortium operations — enables geographic analysis of multi-partner collaboration."
    - name: "ngo_role"
      expr: ngo_role
      comment: "Role of the NGO within the consortium (e.g., Lead, Member) — used to analyze leadership vs. participation patterns."
    - name: "grand_bargain_localization"
      expr: grand_bargain_localization
      comment: "Whether the consortium is aligned to Grand Bargain localization commitments — key accountability dimension for donor reporting."
    - name: "thematic_focus"
      expr: thematic_focus
      comment: "Thematic focus area of the consortium — segments by programmatic priority."
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the consortium was established — enables cohort analysis of consortium portfolio."
  measures:
    - name: "total_consortia"
      expr: COUNT(1)
      comment: "Total number of consortia — baseline portfolio size for multi-partner collaboration management."
    - name: "total_funding_amount_usd"
      expr: SUM(CAST(total_funding_amount AS DOUBLE))
      comment: "Total funding mobilized across all consortia — primary financial scale KPI for consortium portfolio management."
    - name: "avg_localization_percentage"
      expr: AVG(CAST(localization_percentage AS DOUBLE))
      comment: "Average localization percentage across consortia — headline Grand Bargain KPI measuring local partner funding share."
    - name: "avg_ngo_funding_share_pct"
      expr: AVG(CAST(ngo_funding_share AS DOUBLE))
      comment: "Average NGO funding share within consortia — tracks the organization's financial stake in multi-partner arrangements."
    - name: "grand_bargain_aligned_count"
      expr: COUNT(CASE WHEN grand_bargain_localization = TRUE THEN 1 END)
      comment: "Number of consortia aligned to Grand Bargain localization commitments — tracks progress against international accountability pledges."
    - name: "grand_bargain_alignment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN grand_bargain_localization = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consortia aligned to Grand Bargain localization — executive KPI for humanitarian accountability reporting."
    - name: "distinct_lead_partners"
      expr: COUNT(DISTINCT lead_partner_org_id)
      comment: "Number of unique lead partner organizations across consortia — measures diversity of consortium leadership."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_agreement_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agreement amendment KPIs — tracks amendment volume, budget changes, and extension patterns to manage agreement stability and donor compliance risk."
  source: "`vibe_ngo_v1`.`partnership`.`agreement_amendment`"
  dimensions:
    - name: "agreement_amendment_status"
      expr: agreement_amendment_status
      comment: "Current status of the amendment (e.g., Approved, Pending, Rejected) — primary filter for amendment pipeline management."
    - name: "agreement_amendment_type"
      expr: agreement_amendment_type
      comment: "Type of amendment (e.g., Budget, Scope, Extension) — segments amendments by nature of change."
    - name: "is_no_cost_extension"
      expr: is_no_cost_extension
      comment: "Whether the amendment is a no-cost extension — distinguishes timeline adjustments from substantive changes."
    - name: "donor_prior_approval_required"
      expr: donor_prior_approval_required
      comment: "Whether donor prior approval was required — tracks compliance burden and approval pipeline."
    - name: "budget_change_flag"
      expr: budget_change_amount
      comment: "Budget change amount — used as a dimension to segment amendments by financial impact direction."
    - name: "geographic_scope_change"
      expr: geographic_scope_change
      comment: "Whether the amendment changed the geographic scope — tracks programmatic scope changes."
    - name: "approved_year"
      expr: YEAR(approved_date)
      comment: "Year the amendment was approved — enables trend analysis of amendment activity."
  measures:
    - name: "total_amendments"
      expr: COUNT(1)
      comment: "Total number of agreement amendments — baseline volume for amendment management; high counts signal agreement instability."
    - name: "total_budget_change_usd"
      expr: SUM(CAST(budget_change_amount AS DOUBLE))
      comment: "Net total budget change across all amendments — tracks cumulative financial scope changes in the partnership portfolio."
    - name: "avg_budget_change_usd"
      expr: AVG(CAST(budget_change_amount AS DOUBLE))
      comment: "Average budget change per amendment — benchmarks the financial magnitude of agreement modifications."
    - name: "no_cost_extension_count"
      expr: COUNT(CASE WHEN is_no_cost_extension = TRUE THEN 1 END)
      comment: "Number of no-cost extensions — tracks timeline slippage patterns across the partnership portfolio."
    - name: "no_cost_extension_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_no_cost_extension = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of amendments that are no-cost extensions — indicator of delivery delays and implementation challenges."
    - name: "donor_prior_approval_required_count"
      expr: COUNT(CASE WHEN donor_prior_approval_required = TRUE THEN 1 END)
      comment: "Number of amendments requiring donor prior approval — tracks compliance burden and approval pipeline workload."
    - name: "distinct_agreements_amended"
      expr: COUNT(DISTINCT partnership_agreement_id)
      comment: "Number of unique agreements that have been amended — measures amendment prevalence across the portfolio."
    - name: "avg_extension_approval_cycle_days"
      expr: AVG(DATEDIFF(approved_date, submitted_date))
      comment: "Average days from amendment submission to approval — operational efficiency KPI for amendment processing."
$$;