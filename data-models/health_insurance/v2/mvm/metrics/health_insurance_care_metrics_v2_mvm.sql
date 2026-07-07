-- Metric views for domain: care | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-27 10:36:42

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for care plan management — tracks active plan distribution, high-risk member coverage, and plan lifecycle health across coordinators, plan types, and risk tiers."
  source: "`vibe_health_insurance_v1`.`care`.`care_plan`"
  dimensions:
    - name: "care_plan_status"
      expr: care_plan_status
      comment: "Current status of the care plan (e.g., Active, Closed, Pending) — primary operational segmentation for plan management."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of care plan (e.g., Chronic, Preventive, Transitional) — used to segment KPIs by clinical program category."
    - name: "high_risk_flag"
      expr: high_risk_flag
      comment: "Indicates whether the member on this care plan is flagged as high-risk — critical for prioritizing care management resources."
    - name: "privacy_consent_flag"
      expr: privacy_consent_flag
      comment: "Indicates whether the member has provided privacy consent — required for regulatory compliance reporting."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the care plan became effective — used for trend analysis of new plan activations over time."
    - name: "effective_end_month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
      comment: "Month the care plan is scheduled to end — used for expiration pipeline and renewal forecasting."
    - name: "plan_name"
      expr: plan_name
      comment: "Name of the care plan — used for plan-level performance comparisons."
  measures:
    - name: "total_active_care_plans"
      expr: COUNT(CASE WHEN care_plan_status = 'Active' THEN 1 END)
      comment: "Total number of currently active care plans — baseline KPI for care management capacity and workload assessment."
    - name: "total_high_risk_care_plans"
      expr: COUNT(CASE WHEN high_risk_flag = TRUE THEN 1 END)
      comment: "Total care plans flagged as high-risk — drives resource allocation decisions for intensive care management programs."
    - name: "high_risk_plan_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN high_risk_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of care plans flagged as high-risk — executive KPI indicating the proportion of the member population requiring intensive care management."
    - name: "privacy_consent_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN privacy_consent_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of care plans with member privacy consent on file — regulatory compliance KPI; low rates trigger compliance remediation."
    - name: "total_care_plans"
      expr: COUNT(1)
      comment: "Total number of care plans across all statuses — denominator baseline for rate calculations and capacity planning."
    - name: "distinct_coordinators_assigned"
      expr: COUNT(DISTINCT coordinator_id)
      comment: "Number of unique care coordinators with at least one assigned care plan — used to assess coordinator workload distribution and staffing adequacy."
    - name: "distinct_members_in_care_plans"
      expr: COUNT(DISTINCT plan_care_member_subscriber_id)
      comment: "Number of unique members enrolled in at least one care plan — measures care management program reach across the member population."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_condition_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical condition management KPIs — tracks chronic condition prevalence, risk adjustment impact, RAF score distribution, and condition identification quality across the member population."
  source: "`vibe_health_insurance_v1`.`care`.`condition_registry`"
  dimensions:
    - name: "condition_category"
      expr: condition_category
      comment: "Clinical category of the condition (e.g., Cardiovascular, Diabetes, Behavioral Health) — primary segmentation for population health analysis."
    - name: "is_chronic"
      expr: is_chronic
      comment: "Indicates whether the condition is chronic — used to segment chronic vs. acute condition burden across the population."
    - name: "active_flag"
      expr: active_flag
      comment: "Indicates whether the condition record is currently active — filters for current vs. historical condition burden."
    - name: "risk_adjustment_flag"
      expr: risk_adjustment_flag
      comment: "Indicates whether the condition is eligible for risk adjustment — critical for revenue and RAF score management."
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Confirmation status of the condition (e.g., Confirmed, Suspected, Ruled Out) — used to assess data quality and clinical confidence."
    - name: "severity"
      expr: severity
      comment: "Clinical severity level of the condition — used to stratify population by acuity for care management prioritization."
    - name: "identification_method"
      expr: identification_method
      comment: "Method by which the condition was identified (e.g., Claims, EHR, HRA) — used to evaluate data completeness and source diversity."
    - name: "population_segment"
      expr: population_segment
      comment: "Population segment associated with the condition — enables cohort-level condition burden analysis."
    - name: "identification_year"
      expr: DATE_TRUNC('YEAR', identification_date)
      comment: "Year the condition was first identified — used for longitudinal trend analysis of condition prevalence."
  measures:
    - name: "total_active_conditions"
      expr: COUNT(CASE WHEN active_flag = TRUE THEN 1 END)
      comment: "Total number of active conditions in the registry — baseline measure of clinical condition burden across the member population."
    - name: "chronic_condition_count"
      expr: COUNT(CASE WHEN is_chronic = TRUE AND active_flag = TRUE THEN 1 END)
      comment: "Total active chronic conditions — key population health KPI driving care management program enrollment and cost projections."
    - name: "chronic_condition_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_chronic = TRUE AND active_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN active_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active conditions that are chronic — executive KPI for population health complexity and long-term cost risk."
    - name: "risk_adjustable_condition_count"
      expr: COUNT(CASE WHEN risk_adjustment_flag = TRUE AND active_flag = TRUE THEN 1 END)
      comment: "Total active conditions eligible for risk adjustment — directly tied to RAF score revenue; low counts signal documentation gaps."
    - name: "risk_adjustment_capture_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_adjustment_flag = TRUE AND active_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN active_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active conditions flagged for risk adjustment — measures risk adjustment documentation completeness; directly impacts CMS revenue."
    - name: "avg_raf_score"
      expr: ROUND(AVG(CAST(raf_score AS DOUBLE)), 4)
      comment: "Average RAF (Risk Adjustment Factor) score across condition records — key revenue and risk management KPI; lower-than-expected scores indicate under-documentation."
    - name: "total_raf_score"
      expr: ROUND(SUM(CAST(raf_score AS DOUBLE)), 2)
      comment: "Total RAF score across all condition records — aggregate risk adjustment revenue signal; used in financial forecasting and CMS reconciliation."
    - name: "distinct_members_with_conditions"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Number of unique members with at least one condition in the registry — measures clinical program reach and population health coverage."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_gap`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care gap management KPIs — tracks open gap volume, critical gap rates, closure performance, and risk score distribution across clinical categories, gap types, and priority levels. Directly tied to HEDIS performance and quality star ratings."
  source: "`vibe_health_insurance_v1`.`care`.`gap`"
  dimensions:
    - name: "gap_status"
      expr: gap_status
      comment: "Current status of the care gap (e.g., Open, Closed, In Progress) — primary operational dimension for gap management workflows."
    - name: "gap_type"
      expr: gap_type
      comment: "Type of care gap (e.g., Preventive, Chronic, Medication Adherence) — used to segment gap closure performance by clinical category."
    - name: "clinical_category"
      expr: clinical_category
      comment: "Clinical category of the gap — enables population health program targeting by condition area."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the gap (e.g., High, Medium, Low) — used to assess whether high-priority gaps are being closed faster than low-priority ones."
    - name: "is_critical"
      expr: is_critical
      comment: "Indicates whether the gap is flagged as clinically critical — used to monitor critical gap backlog and escalation rates."
    - name: "closure_method"
      expr: closure_method
      comment: "Method used to close the gap (e.g., Claim, Manual, Outreach) — used to evaluate effectiveness of different closure strategies."
    - name: "open_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the gap was opened — used for trend analysis of new gap creation rates over time."
    - name: "documentation_status"
      expr: documentation_status
      comment: "Documentation completeness status of the gap — used to identify gaps at risk of not being counted in HEDIS due to missing documentation."
  measures:
    - name: "total_open_gaps"
      expr: COUNT(CASE WHEN gap_status = 'Open' THEN 1 END)
      comment: "Total number of currently open care gaps — primary operational KPI for care gap management; high counts signal quality and HEDIS performance risk."
    - name: "total_critical_open_gaps"
      expr: COUNT(CASE WHEN is_critical = TRUE AND gap_status = 'Open' THEN 1 END)
      comment: "Total open gaps flagged as clinically critical — executive escalation KPI; drives immediate care coordinator intervention decisions."
    - name: "critical_gap_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_critical = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of all gaps that are critical — measures clinical acuity of the gap population; high rates indicate systemic care quality issues."
    - name: "gap_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gap_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of gaps that have been closed — primary HEDIS and quality performance KPI; directly impacts star ratings and CMS quality bonuses."
    - name: "avg_gap_risk_score"
      expr: ROUND(AVG(CAST(risk_score AS DOUBLE)), 4)
      comment: "Average risk score across all gap records — measures the aggregate clinical risk associated with unresolved care gaps; informs care management prioritization."
    - name: "avg_measure_target_value"
      expr: ROUND(AVG(CAST(measure_target_value AS DOUBLE)), 4)
      comment: "Average HEDIS measure target value across gaps — used to benchmark gap closure targets against national/plan standards."
    - name: "distinct_members_with_open_gaps"
      expr: COUNT(DISTINCT CASE WHEN gap_status = 'Open' THEN member_subscriber_id END)
      comment: "Number of unique members with at least one open care gap — measures the breadth of the quality gap problem across the member population."
    - name: "distinct_gaps_by_coordinator"
      expr: COUNT(DISTINCT assigned_care_coordinator_id)
      comment: "Number of unique care coordinators with at least one assigned gap — used to assess gap workload distribution and coordinator capacity."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_hedis_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HEDIS quality measure performance KPIs — tracks numerator/denominator compliance rates, exclusion rates, and measure scores across measures, years, and collection methods. Directly drives star ratings and CMS quality bonus payments."
  source: "`vibe_health_insurance_v1`.`care`.`hedis_result`"
  dimensions:
    - name: "measure_category"
      expr: measure_category
      comment: "HEDIS measure category (e.g., Effectiveness of Care, Access/Availability) — primary segmentation for quality performance reporting."
    - name: "measure_type"
      expr: measure_type
      comment: "Type of HEDIS measure — used to segment performance by measure classification."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the HEDIS result record (e.g., Compliant, Non-Compliant) — primary dimension for quality gap identification."
    - name: "measurement_year"
      expr: measurement_year
      comment: "Measurement year for the HEDIS result — enables year-over-year quality performance trending."
    - name: "collection_method"
      expr: collection_method
      comment: "Data collection method used (e.g., Administrative, Hybrid, Survey) — used to assess data source quality and completeness."
    - name: "exclusion_flag"
      expr: exclusion_flag
      comment: "Indicates whether the member was excluded from the measure denominator — used to monitor exclusion rates and potential gaming."
    - name: "denominator_flag"
      expr: denominator_flag
      comment: "Indicates whether the member meets denominator eligibility criteria — used to validate eligible population size for each measure."
    - name: "numerator_flag"
      expr: numerator_flag
      comment: "Indicates whether the member met the numerator criteria (i.e., received the required service) — primary compliance indicator."
    - name: "data_source"
      expr: data_source
      comment: "Source system providing the HEDIS data — used to assess data completeness and identify gaps by source."
  measures:
    - name: "total_denominator_eligible"
      expr: COUNT(CASE WHEN denominator_flag = TRUE THEN 1 END)
      comment: "Total members meeting HEDIS denominator eligibility criteria — baseline population for compliance rate calculations."
    - name: "total_numerator_compliant"
      expr: COUNT(CASE WHEN numerator_flag = TRUE THEN 1 END)
      comment: "Total members who met the HEDIS numerator criteria (received required care) — primary quality compliance count."
    - name: "hedis_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN numerator_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN denominator_flag = TRUE THEN 1 END), 0), 2)
      comment: "HEDIS compliance rate — percentage of eligible members who received required care. Core star rating KPI; directly tied to CMS quality bonus revenue."
    - name: "exclusion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN exclusion_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN denominator_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of denominator-eligible members excluded from the measure — high exclusion rates may indicate documentation issues or population health concerns."
    - name: "avg_measure_score"
      expr: ROUND(AVG(CAST(measure_score AS DOUBLE)), 4)
      comment: "Average HEDIS measure score across result records — aggregate quality performance indicator used in executive dashboards and CMS submissions."
    - name: "distinct_measures_tracked"
      expr: COUNT(DISTINCT hedis_measure_id)
      comment: "Number of distinct HEDIS measures with results — indicates breadth of quality measurement program coverage."
    - name: "distinct_members_measured"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Number of unique members included in at least one HEDIS measure — measures quality program reach across the enrolled population."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_hra`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health Risk Assessment (HRA) completion and SDOH screening KPIs — tracks assessment completion rates, SDOH risk factor prevalence, and CMS/NCQA compliance. Directly informs care management program enrollment and regulatory compliance."
  source: "`vibe_health_insurance_v1`.`care`.`hra`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the HRA (e.g., Completed, Pending, Refused) — primary operational dimension for HRA completion tracking."
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of health risk assessment administered — used to segment completion rates by assessment program."
    - name: "completion_channel"
      expr: completion_channel
      comment: "Channel through which the HRA was completed (e.g., Phone, Online, In-Person) — used to optimize outreach strategy by channel effectiveness."
    - name: "compliance_cms_required"
      expr: compliance_cms_required
      comment: "Indicates whether the HRA is required for CMS compliance — used to prioritize completion outreach for regulatory requirements."
    - name: "compliance_ncqa_required"
      expr: compliance_ncqa_required
      comment: "Indicates whether the HRA is required for NCQA accreditation compliance — used to track accreditation readiness."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month the HRA was administered — used for trend analysis of HRA completion rates over time."
    - name: "screening_tool"
      expr: screening_tool
      comment: "Screening tool used for the HRA — used to compare completion and SDOH detection rates across different assessment instruments."
  measures:
    - name: "total_hras_completed"
      expr: COUNT(CASE WHEN assessment_status = 'Completed' THEN 1 END)
      comment: "Total number of completed HRAs — primary KPI for HRA program performance; low counts trigger outreach escalation."
    - name: "hra_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN assessment_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of HRAs that have been completed — CMS and NCQA compliance KPI; directly impacts star ratings and accreditation status."
    - name: "cms_compliance_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_cms_required = TRUE AND assessment_status = 'Completed' THEN 1 END) / NULLIF(COUNT(CASE WHEN compliance_cms_required = TRUE THEN 1 END), 0), 2)
      comment: "Completion rate for CMS-required HRAs — regulatory compliance KPI; failure to meet CMS thresholds results in financial penalties."
    - name: "sdoh_food_insecurity_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sdoh_food_insecurity = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN assessment_status = 'Completed' THEN 1 END), 0), 2)
      comment: "Percentage of completed HRAs identifying food insecurity — SDOH prevalence KPI driving community resource referral programs."
    - name: "sdoh_housing_instability_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sdoh_housing_instability = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN assessment_status = 'Completed' THEN 1 END), 0), 2)
      comment: "Percentage of completed HRAs identifying housing instability — SDOH KPI used to target housing assistance programs and reduce avoidable utilization."
    - name: "sdoh_transportation_barrier_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sdoh_transportation = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN assessment_status = 'Completed' THEN 1 END), 0), 2)
      comment: "Percentage of completed HRAs identifying transportation barriers — SDOH KPI linked to missed appointments and care access gaps."
    - name: "multi_sdoh_risk_count"
      expr: COUNT(CASE WHEN (CAST(sdoh_food_insecurity AS INT) + CAST(sdoh_housing_instability AS INT) + CAST(sdoh_transportation AS INT) + CAST(sdoh_social_isolation AS INT) + CAST(sdoh_financial_strain AS INT)) >= 2 THEN 1 END)
      comment: "Number of members with two or more SDOH risk factors identified — high-complexity social risk KPI driving intensive case management enrollment decisions."
    - name: "distinct_members_assessed"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Number of unique members who have had at least one HRA administered — measures HRA program reach across the enrolled population."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_member_risk_tier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member risk stratification KPIs — tracks risk tier distribution, average risk and HCC scores, chronic condition flags, and tier assignment currency. Drives care management program targeting and cost forecasting."
  source: "`vibe_health_insurance_v1`.`care`.`member_risk_tier`"
  dimensions:
    - name: "tier_name"
      expr: tier_name
      comment: "Name of the risk tier (e.g., High, Medium, Low) — primary segmentation for risk-stratified care management programs."
    - name: "tier_band"
      expr: tier_band
      comment: "Risk tier band grouping — used for broader risk cohort analysis and program enrollment targeting."
    - name: "segment_name"
      expr: segment_name
      comment: "Population segment name associated with the risk tier — used to align risk stratification with care management program design."
    - name: "is_current"
      expr: is_current
      comment: "Indicates whether this is the member's current active risk tier assignment — filters for point-in-time risk population analysis."
    - name: "chronic_condition_flag"
      expr: chronic_condition_flag
      comment: "Indicates whether the member has a chronic condition contributing to their risk tier — used to segment chronic vs. acute risk populations."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign the risk tier (e.g., Predictive Model, Manual, Claims-Based) — used to assess model coverage and manual override rates."
    - name: "pmpm_cost_band"
      expr: pmpm_cost_band
      comment: "Per-member-per-month cost band associated with the risk tier — used to align risk stratification with financial cost projections."
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', assignment_date)
      comment: "Month the risk tier was assigned — used for trend analysis of risk tier migration over time."
  measures:
    - name: "total_current_risk_assignments"
      expr: COUNT(CASE WHEN is_current = TRUE THEN 1 END)
      comment: "Total number of current active risk tier assignments — baseline KPI for risk stratification program coverage."
    - name: "high_risk_member_count"
      expr: COUNT(CASE WHEN is_current = TRUE AND chronic_condition_flag = TRUE THEN 1 END)
      comment: "Number of currently active risk assignments with chronic condition flags — proxy for high-complexity member population size driving care management investment."
    - name: "avg_risk_score"
      expr: ROUND(AVG(CAST(risk_score AS DOUBLE)), 4)
      comment: "Average risk score across member risk tier records — population-level risk indicator used in actuarial forecasting and care management program sizing."
    - name: "avg_hcc_score"
      expr: ROUND(AVG(CAST(hcc_score AS DOUBLE)), 4)
      comment: "Average HCC (Hierarchical Condition Category) score — key CMS risk adjustment revenue metric; lower-than-expected scores indicate documentation gaps."
    - name: "avg_risk_factor_weight"
      expr: ROUND(AVG(CAST(risk_factor_weight AS DOUBLE)), 4)
      comment: "Average risk factor weight across tier assignments — measures the aggregate clinical complexity weighting of the risk-stratified population."
    - name: "distinct_members_risk_stratified"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Number of unique members with a risk tier assignment — measures risk stratification program coverage across the enrolled population."
    - name: "chronic_condition_risk_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN chronic_condition_flag = TRUE AND is_current = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_current = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of currently risk-stratified members with a chronic condition flag — population health complexity KPI used in care management program investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care program management KPIs — tracks program enrollment capacity utilization, evidence-based program adoption, and program portfolio health across lines of business and program types."
  source: "`vibe_health_insurance_v1`.`care`.`program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current operational status of the program (e.g., Active, Inactive, Pending) — primary dimension for program portfolio management."
    - name: "program_type"
      expr: program_type
      comment: "Type of care program (e.g., Disease Management, Wellness, Transitional Care) — used to segment enrollment and outcome KPIs by program category."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business the program serves (e.g., Medicare, Medicaid, Commercial) — used to align program performance with business segment strategy."
    - name: "is_evidence_based"
      expr: is_evidence_based
      comment: "Indicates whether the program is evidence-based — used to track adoption of clinically validated programs vs. non-validated interventions."
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Accreditation status of the program — used to monitor regulatory and quality accreditation compliance across the program portfolio."
    - name: "program_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the program became active — used for program launch trend analysis."
    - name: "category"
      expr: category
      comment: "Broad category of the program — used for high-level portfolio segmentation in executive reporting."
  measures:
    - name: "total_active_programs"
      expr: COUNT(CASE WHEN program_status = 'Active' THEN 1 END)
      comment: "Total number of active care programs — baseline KPI for program portfolio size and operational scope."
    - name: "total_enrollment_current"
      expr: SUM(CAST(enrollment_current AS DOUBLE))
      comment: "Total current enrollment across all care programs — measures aggregate care management program reach across the member population."
    - name: "total_enrollment_capacity"
      expr: SUM(CAST(enrollment_cap AS DOUBLE))
      comment: "Total enrollment capacity across all care programs — used as denominator for capacity utilization rate calculations."
    - name: "enrollment_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(enrollment_current AS DOUBLE)) / NULLIF(SUM(CAST(enrollment_cap AS DOUBLE)), 0), 2)
      comment: "Percentage of total program enrollment capacity currently utilized — operational efficiency KPI; high rates signal need for program expansion, low rates indicate underutilization."
    - name: "evidence_based_program_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_evidence_based = TRUE AND program_status = 'Active' THEN 1 END) / NULLIF(COUNT(CASE WHEN program_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active programs that are evidence-based — quality and accreditation KPI; NCQA and CMS favor evidence-based program portfolios."
    - name: "avg_risk_adjustment_factor"
      expr: ROUND(AVG(CAST(risk_adjustment_factor AS DOUBLE)), 4)
      comment: "Average risk adjustment factor across care programs — measures the aggregate risk adjustment impact of the program portfolio on CMS revenue."
    - name: "distinct_active_programs_by_lob"
      expr: COUNT(DISTINCT CASE WHEN program_status = 'Active' THEN program_id END)
      comment: "Number of distinct active programs — used with line_of_business dimension to assess program portfolio breadth by business segment."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_plan_goal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care plan goal achievement KPIs — tracks goal completion rates, compliance, target vs. actual value performance, and goal category distribution. Measures effectiveness of care management interventions at the goal level."
  source: "`vibe_health_insurance_v1`.`care`.`plan_goal`"
  dimensions:
    - name: "plan_goal_status"
      expr: plan_goal_status
      comment: "Current status of the care plan goal (e.g., Achieved, In Progress, Not Met) — primary dimension for goal performance tracking."
    - name: "goal_category"
      expr: goal_category
      comment: "Clinical or behavioral category of the goal (e.g., Medication Adherence, Weight Management, Blood Pressure) — used to segment goal performance by intervention type."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the goal is in compliance with the care plan — used to identify members falling behind on care plan objectives."
    - name: "priority"
      expr: priority
      comment: "Priority level of the goal — used to assess whether high-priority goals are being achieved at higher rates than lower-priority ones."
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement used to track goal progress (e.g., Lab Value, Self-Report, Claims) — used to assess data quality of goal tracking."
    - name: "target_month"
      expr: DATE_TRUNC('MONTH', target_date)
      comment: "Month the goal is targeted for completion — used for goal pipeline and deadline management analysis."
  measures:
    - name: "total_goals"
      expr: COUNT(1)
      comment: "Total number of care plan goals across all statuses — baseline measure for care plan goal volume and care management program intensity."
    - name: "goals_achieved_count"
      expr: COUNT(CASE WHEN plan_goal_status = 'Achieved' THEN 1 END)
      comment: "Total number of care plan goals that have been achieved — primary outcome KPI for care management program effectiveness."
    - name: "goal_achievement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN plan_goal_status = 'Achieved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of care plan goals that have been achieved — executive KPI for care management program effectiveness; directly tied to member health outcomes and quality scores."
    - name: "goal_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of care plan goals currently in compliance — operational KPI for care coordinator performance and member engagement."
    - name: "avg_target_value"
      expr: ROUND(AVG(CAST(target_value AS DOUBLE)), 4)
      comment: "Average target value across care plan goals — used to benchmark goal ambition levels across care programs and coordinators."
    - name: "avg_actual_value"
      expr: ROUND(AVG(CAST(actual_value AS DOUBLE)), 4)
      comment: "Average actual achieved value across care plan goals — compared against avg_target_value to assess aggregate goal attainment performance."
    - name: "distinct_members_with_goals"
      expr: COUNT(DISTINCT plan_id)
      comment: "Number of distinct care plans with at least one goal — measures care plan goal coverage and care management program engagement depth."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_coordinator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care coordinator workforce KPIs — tracks coordinator capacity, caseload utilization, and workforce composition. Drives staffing decisions and coordinator performance management."
  source: "`vibe_health_insurance_v1`.`care`.`coordinator`"
  dimensions:
    - name: "coordinator_status"
      expr: coordinator_status
      comment: "Current employment/operational status of the coordinator (e.g., Active, Inactive, On Leave) — primary dimension for workforce availability analysis."
    - name: "role_type"
      expr: role_type
      comment: "Role type of the coordinator (e.g., RN Care Manager, Social Worker, Health Coach) — used to segment caseload and capacity by clinical role."
    - name: "specialty_area"
      expr: specialty_area
      comment: "Clinical specialty area of the coordinator — used to match coordinator expertise to member clinical needs."
    - name: "assigned_lob"
      expr: assigned_lob
      comment: "Line of business the coordinator is assigned to (e.g., Medicare, Medicaid, Commercial) — used to assess workforce distribution across business segments."
    - name: "employment_status"
      expr: employment_status
      comment: "Employment status of the coordinator (e.g., Full-Time, Part-Time, Contract) — used for workforce planning and FTE analysis."
    - name: "organization_unit"
      expr: organization_unit
      comment: "Organizational unit the coordinator belongs to — used for departmental performance benchmarking."
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month the coordinator was hired — used for workforce tenure and retention analysis."
  measures:
    - name: "total_active_coordinators"
      expr: COUNT(CASE WHEN coordinator_status = 'Active' THEN 1 END)
      comment: "Total number of active care coordinators — baseline workforce capacity KPI; directly constrains care management program throughput."
    - name: "avg_caseload_weight"
      expr: ROUND(AVG(CAST(caseload_weight AS DOUBLE)), 4)
      comment: "Average caseload weight across coordinators — measures aggregate care complexity burden per coordinator; high values signal burnout risk and quality degradation."
    - name: "total_caseload_weight"
      expr: ROUND(SUM(CAST(caseload_weight AS DOUBLE)), 2)
      comment: "Total caseload weight across all coordinators — aggregate workforce burden metric used in staffing model calibration."
    - name: "distinct_active_coordinators_by_role"
      expr: COUNT(DISTINCT CASE WHEN coordinator_status = 'Active' THEN coordinator_id END)
      comment: "Number of distinct active coordinators — used with role_type dimension to assess workforce composition and identify role-level staffing gaps."
$$;