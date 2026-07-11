-- Metric views for domain: care | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 22:41:45

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care program enrollment metrics tracking member participation, risk stratification, and enrollment lifecycle for care management programs."
  source: "`vibe_health_insurance_v1`.`care`.`care_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the care enrollment (active, pending, disenrolled, etc.)"
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of care enrollment (voluntary, auto-enrolled, provider-referred, etc.)"
    - name: "acuity_level"
      expr: acuity_level
      comment: "Clinical acuity level of the enrolled member (low, medium, high, critical)"
    - name: "program_tier"
      expr: program_tier
      comment: "Care program tier assigned to the member"
    - name: "consent_status"
      expr: consent_status
      comment: "Member consent status for care management participation"
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source system or channel that initiated the enrollment"
    - name: "enrollment_year"
      expr: YEAR(effective_start_date)
      comment: "Year the care enrollment became effective"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the care enrollment became effective"
    - name: "disenrollment_year"
      expr: YEAR(disenrollment_date)
      comment: "Year of disenrollment from care program"
    - name: "is_high_risk"
      expr: CASE WHEN risk_score >= 2.0 THEN 'High Risk' WHEN risk_score >= 1.0 THEN 'Medium Risk' ELSE 'Low Risk' END
      comment: "Risk stratification category based on member risk score"
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total number of care program enrollments"
    - name: "unique_members_enrolled"
      expr: COUNT(DISTINCT member_enrollment_id)
      comment: "Distinct count of members enrolled in care programs"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average member risk score across enrollments, indicating population health complexity"
    - name: "avg_hcc_score"
      expr: AVG(CAST(hcc_score AS DOUBLE))
      comment: "Average Hierarchical Condition Category score, key driver of risk-adjusted payments"
    - name: "total_risk_score"
      expr: SUM(CAST(risk_score AS DOUBLE))
      comment: "Sum of all member risk scores, representing total population risk burden"
    - name: "total_hcc_score"
      expr: SUM(CAST(hcc_score AS DOUBLE))
      comment: "Sum of all HCC scores, representing total risk-adjusted revenue opportunity"
    - name: "high_risk_enrollment_count"
      expr: COUNT(CASE WHEN risk_score >= 2.0 THEN 1 END)
      comment: "Count of enrollments with high risk scores (>=2.0), requiring intensive care management"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care plan metrics tracking individualized care planning, high-risk member identification, and care plan lifecycle management."
  source: "`vibe_health_insurance_v1`.`care`.`care_plan`"
  dimensions:
    - name: "care_plan_status"
      expr: care_plan_status
      comment: "Current status of the care plan (active, completed, suspended, etc.)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of care plan (chronic care, transitional care, preventive, etc.)"
    - name: "high_risk_flag"
      expr: high_risk_flag
      comment: "Boolean indicator whether member is flagged as high risk"
    - name: "privacy_consent_flag"
      expr: privacy_consent_flag
      comment: "Boolean indicator of member privacy consent for care coordination"
    - name: "plan_creation_year"
      expr: YEAR(effective_start_date)
      comment: "Year the care plan became effective"
    - name: "plan_creation_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the care plan became effective"
  measures:
    - name: "total_care_plans"
      expr: COUNT(1)
      comment: "Total number of care plans created"
    - name: "unique_members_with_plans"
      expr: COUNT(DISTINCT care_enrollment_id)
      comment: "Distinct count of members with active or historical care plans"
    - name: "high_risk_plan_count"
      expr: COUNT(CASE WHEN high_risk_flag = TRUE THEN 1 END)
      comment: "Count of care plans for high-risk members, requiring intensive resource allocation"
    - name: "privacy_consent_rate_numerator"
      expr: COUNT(CASE WHEN privacy_consent_flag = TRUE THEN 1 END)
      comment: "Count of care plans with member privacy consent (numerator for consent rate calculation)"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_condition_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Condition registry metrics tracking chronic disease prevalence, risk adjustment capture, and clinical condition management across the member population."
  source: "`vibe_health_insurance_v1`.`care`.`condition_registry`"
  dimensions:
    - name: "condition_category"
      expr: condition_category
      comment: "Clinical category of the condition (cardiovascular, diabetes, respiratory, etc.)"
    - name: "condition_code"
      expr: condition_code
      comment: "Standardized condition code (ICD-10, SNOMED, etc.)"
    - name: "severity"
      expr: severity
      comment: "Clinical severity level of the condition (mild, moderate, severe, critical)"
    - name: "is_chronic"
      expr: is_chronic
      comment: "Boolean indicator whether condition is chronic (long-term management required)"
    - name: "active_flag"
      expr: active_flag
      comment: "Boolean indicator whether condition is currently active"
    - name: "risk_adjustment_flag"
      expr: risk_adjustment_flag
      comment: "Boolean indicator whether condition qualifies for risk adjustment (HCC-eligible)"
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Clinical confirmation status of the condition (confirmed, suspected, ruled out, etc.)"
    - name: "identification_method"
      expr: identification_method
      comment: "Method by which condition was identified (claims, clinical assessment, lab, etc.)"
    - name: "population_segment"
      expr: population_segment
      comment: "Population segment or cohort associated with the condition"
    - name: "identification_year"
      expr: YEAR(identification_date)
      comment: "Year the condition was first identified"
    - name: "identification_month"
      expr: DATE_TRUNC('MONTH', identification_date)
      comment: "Month the condition was first identified"
  measures:
    - name: "total_conditions"
      expr: COUNT(1)
      comment: "Total number of conditions registered in the condition registry"
    - name: "unique_members_with_conditions"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct count of members with registered conditions, representing disease burden"
    - name: "chronic_condition_count"
      expr: COUNT(CASE WHEN is_chronic = TRUE THEN 1 END)
      comment: "Count of chronic conditions requiring ongoing care management and resource allocation"
    - name: "risk_adjustment_eligible_count"
      expr: COUNT(CASE WHEN risk_adjustment_flag = TRUE THEN 1 END)
      comment: "Count of conditions eligible for risk adjustment (HCC), directly impacting revenue capture"
    - name: "active_condition_count"
      expr: COUNT(CASE WHEN active_flag = TRUE THEN 1 END)
      comment: "Count of currently active conditions requiring clinical attention and resources"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_coordinator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care coordinator workforce metrics tracking capacity, caseload utilization, and coordinator availability for care management operations."
  source: "`vibe_health_insurance_v1`.`care`.`coordinator`"
  dimensions:
    - name: "coordinator_status"
      expr: coordinator_status
      comment: "Current employment status of the care coordinator (active, on leave, terminated, etc.)"
    - name: "employment_status"
      expr: employment_status
      comment: "Employment type (full-time, part-time, contractor, etc.)"
    - name: "role_type"
      expr: role_type
      comment: "Care coordinator role type (RN, social worker, health coach, etc.)"
    - name: "specialty_area"
      expr: specialty_area
      comment: "Clinical or functional specialty area of the coordinator"
    - name: "assigned_lob"
      expr: assigned_lob
      comment: "Line of business assigned to the coordinator (Medicare, Medicaid, Commercial, etc.)"
    - name: "organization_unit"
      expr: organization_unit
      comment: "Organizational unit or department of the coordinator"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year the coordinator was hired"
  measures:
    - name: "total_coordinators"
      expr: COUNT(1)
      comment: "Total number of care coordinators in the workforce"
    - name: "avg_caseload_weight"
      expr: AVG(CAST(caseload_weight AS DOUBLE))
      comment: "Average caseload weight per coordinator, indicating workload complexity and resource allocation efficiency"
    - name: "total_caseload_weight"
      expr: SUM(CAST(caseload_weight AS DOUBLE))
      comment: "Sum of all coordinator caseload weights, representing total care management capacity demand"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_gap`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care gap metrics tracking quality measure gaps, HEDIS compliance opportunities, and gap closure performance for value-based care contracts."
  source: "`vibe_health_insurance_v1`.`care`.`gap`"
  dimensions:
    - name: "gap_status"
      expr: gap_status
      comment: "Current status of the care gap (open, closed, in progress, etc.)"
    - name: "gap_type"
      expr: gap_type
      comment: "Type of care gap (preventive, chronic care, screening, medication adherence, etc.)"
    - name: "clinical_category"
      expr: clinical_category
      comment: "Clinical category of the care gap (diabetes, cardiovascular, cancer screening, etc.)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for gap closure (high, medium, low)"
    - name: "is_critical"
      expr: is_critical
      comment: "Boolean indicator whether gap is critical for member safety or quality performance"
    - name: "documentation_status"
      expr: documentation_status
      comment: "Status of gap documentation (documented, pending, missing, etc.)"
    - name: "closure_method"
      expr: closure_method
      comment: "Method by which gap was closed (office visit, telehealth, lab result, etc.)"
    - name: "gap_open_year"
      expr: YEAR(open_date)
      comment: "Year the care gap was opened"
    - name: "gap_open_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the care gap was opened"
    - name: "gap_close_year"
      expr: YEAR(close_date)
      comment: "Year the care gap was closed"
    - name: "gap_close_month"
      expr: DATE_TRUNC('MONTH', close_date)
      comment: "Month the care gap was closed"
  measures:
    - name: "total_gaps"
      expr: COUNT(1)
      comment: "Total number of care gaps identified across the member population"
    - name: "unique_members_with_gaps"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct count of members with one or more care gaps, representing quality improvement opportunity"
    - name: "open_gap_count"
      expr: COUNT(CASE WHEN gap_status = 'open' THEN 1 END)
      comment: "Count of currently open care gaps requiring intervention, directly impacting quality scores"
    - name: "closed_gap_count"
      expr: COUNT(CASE WHEN gap_status = 'closed' THEN 1 END)
      comment: "Count of closed care gaps, representing successful quality improvement interventions"
    - name: "critical_gap_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Count of critical care gaps requiring immediate attention for member safety or contract performance"
    - name: "avg_gap_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of members with care gaps, indicating population complexity"
    - name: "avg_measure_target_value"
      expr: AVG(CAST(measure_target_value AS DOUBLE))
      comment: "Average target value for quality measures associated with gaps, representing performance benchmarks"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_hedis_measure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HEDIS measure definition metrics tracking quality measure inventory, benchmarks, and measure lifecycle for NCQA accreditation and Star Ratings."
  source: "`vibe_health_insurance_v1`.`care`.`hedis_measure`"
  dimensions:
    - name: "measure_code"
      expr: measure_code
      comment: "Standardized HEDIS measure code (e.g., CDC-HbA1c, CBP, COL)"
    - name: "measure_name"
      expr: measure_name
      comment: "Full name of the HEDIS measure"
    - name: "measure_domain"
      expr: measure_domain
      comment: "Clinical domain of the measure (effectiveness of care, access, utilization, etc.)"
    - name: "measure_status"
      expr: measure_status
      comment: "Current status of the measure (active, retired, under review, etc.)"
    - name: "measure_star_rating_impact"
      expr: measure_star_rating_impact
      comment: "Impact level of measure on CMS Star Ratings (high, medium, low)"
    - name: "data_collection_methodology"
      expr: data_collection_methodology
      comment: "Methodology for data collection (administrative, hybrid, CAHPS survey, etc.)"
    - name: "measure_scoring_method"
      expr: measure_scoring_method
      comment: "Scoring method for the measure (proportion, ratio, continuous variable, etc.)"
    - name: "measurement_year"
      expr: measurement_year
      comment: "Measurement year for which the measure definition applies"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the measure definition became effective"
  measures:
    - name: "total_measures"
      expr: COUNT(1)
      comment: "Total number of HEDIS measures defined in the measure library"
    - name: "active_measure_count"
      expr: COUNT(CASE WHEN measure_status = 'active' THEN 1 END)
      comment: "Count of active HEDIS measures currently in use for quality reporting"
    - name: "avg_national_benchmark"
      expr: AVG(CAST(measure_national_benchmark AS DOUBLE))
      comment: "Average national benchmark across all measures, representing national quality performance baseline"
    - name: "avg_state_benchmark"
      expr: AVG(CAST(measure_state_benchmark AS DOUBLE))
      comment: "Average state benchmark across all measures, representing state-level quality performance baseline"
    - name: "avg_target_value"
      expr: AVG(CAST(measure_target_value AS DOUBLE))
      comment: "Average target value across all measures, representing organizational quality performance goals"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_hedis_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HEDIS result metrics tracking member-level quality measure performance, numerator/denominator compliance, and exclusion patterns for NCQA reporting."
  source: "`vibe_health_insurance_v1`.`care`.`hedis_result`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status for the measure (compliant, non-compliant, pending, etc.)"
    - name: "measure_category"
      expr: measure_category
      comment: "Category of the quality measure (preventive, chronic care, behavioral health, etc.)"
    - name: "measure_type"
      expr: measure_type
      comment: "Type of quality measure (process, outcome, structural, etc.)"
    - name: "collection_method"
      expr: collection_method
      comment: "Method used to collect measure data (administrative claims, medical record, survey, etc.)"
    - name: "data_source"
      expr: data_source
      comment: "Source system or data feed for the measure result"
    - name: "is_excluded"
      expr: is_excluded
      comment: "Boolean indicator whether member is excluded from measure denominator"
    - name: "exclusion_reason"
      expr: exclusion_reason
      comment: "Reason for exclusion from measure denominator (hospice, institutional, etc.)"
    - name: "numerator_criteria_met"
      expr: numerator_criteria_met
      comment: "Boolean indicator whether member met numerator criteria (quality measure passed)"
    - name: "denominator_criteria_met"
      expr: denominator_criteria_met
      comment: "Boolean indicator whether member met denominator criteria (eligible for measure)"
    - name: "measurement_year"
      expr: measurement_year
      comment: "Measurement year for the HEDIS result"
    - name: "result_year"
      expr: YEAR(result_timestamp)
      comment: "Year the measure result was recorded"
    - name: "result_month"
      expr: DATE_TRUNC('MONTH', result_timestamp)
      comment: "Month the measure result was recorded"
  measures:
    - name: "total_results"
      expr: COUNT(1)
      comment: "Total number of HEDIS measure results recorded"
    - name: "unique_members_measured"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct count of members with HEDIS measure results, representing quality measurement coverage"
    - name: "denominator_eligible_count"
      expr: COUNT(CASE WHEN denominator_criteria_met = TRUE THEN 1 END)
      comment: "Count of members eligible for measure (denominator), representing quality measurement population"
    - name: "numerator_compliant_count"
      expr: COUNT(CASE WHEN numerator_criteria_met = TRUE THEN 1 END)
      comment: "Count of members meeting measure criteria (numerator), representing quality performance achievement"
    - name: "exclusion_count"
      expr: COUNT(CASE WHEN is_excluded = TRUE THEN 1 END)
      comment: "Count of members excluded from measure denominator, impacting reportable population size"
    - name: "avg_measure_score"
      expr: AVG(CAST(measure_score AS DOUBLE))
      comment: "Average measure score across all results, representing overall quality performance level"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_member_risk_tier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member risk tier metrics tracking risk stratification, segment assignment, and risk-based care program targeting for population health management."
  source: "`vibe_health_insurance_v1`.`care`.`member_risk_tier`"
  dimensions:
    - name: "tier_name"
      expr: tier_name
      comment: "Name of the risk tier (high risk, rising risk, stable, healthy, etc.)"
    - name: "tier_code"
      expr: tier_code
      comment: "Standardized code for the risk tier"
    - name: "tier_band"
      expr: tier_band
      comment: "Risk tier band or grouping"
    - name: "segment_name"
      expr: segment_name
      comment: "Population segment name assigned to the member"
    - name: "demographic_group"
      expr: demographic_group
      comment: "Demographic grouping for risk stratification (age band, gender, etc.)"
    - name: "pmpm_cost_band"
      expr: pmpm_cost_band
      comment: "Per-member-per-month cost band associated with the risk tier"
    - name: "chronic_condition_flag"
      expr: chronic_condition_flag
      comment: "Boolean indicator whether member has chronic conditions"
    - name: "member_risk_tier_status"
      expr: member_risk_tier_status
      comment: "Status of the risk tier assignment (active, expired, pending, etc.)"
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign risk tier (predictive model, clinical assessment, claims-based, etc.)"
    - name: "model_type"
      expr: model_type
      comment: "Type of risk model used for tier assignment (HCC, ACG, proprietary, etc.)"
    - name: "risk_score_source"
      expr: risk_score_source
      comment: "Source of the risk score used for tier assignment"
    - name: "is_current"
      expr: is_current
      comment: "Boolean indicator whether this is the current active risk tier assignment"
    - name: "assignment_year"
      expr: YEAR(assignment_date)
      comment: "Year the risk tier was assigned"
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', assignment_date)
      comment: "Month the risk tier was assigned"
  measures:
    - name: "total_risk_tier_assignments"
      expr: COUNT(1)
      comment: "Total number of risk tier assignments across all members and time periods"
    - name: "unique_members_stratified"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct count of members with risk tier assignments, representing stratified population coverage"
    - name: "current_tier_assignment_count"
      expr: COUNT(CASE WHEN is_current = TRUE THEN 1 END)
      comment: "Count of current active risk tier assignments, representing current stratified population"
    - name: "chronic_condition_member_count"
      expr: COUNT(CASE WHEN chronic_condition_flag = TRUE THEN 1 END)
      comment: "Count of members with chronic conditions, requiring ongoing care management resources"
    - name: "avg_risk_factor_weight"
      expr: AVG(CAST(risk_factor_weight AS DOUBLE))
      comment: "Average risk factor weight across tier assignments, indicating population risk complexity"
    - name: "total_risk_factor_weight"
      expr: SUM(CAST(risk_factor_weight AS DOUBLE))
      comment: "Sum of all risk factor weights, representing total population risk burden for resource planning"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_plan_goal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care plan goal metrics tracking goal setting, achievement, and compliance for individualized member care plans and clinical outcomes."
  source: "`vibe_health_insurance_v1`.`care`.`plan_goal`"
  dimensions:
    - name: "plan_goal_status"
      expr: plan_goal_status
      comment: "Current status of the care plan goal (active, achieved, not met, in progress, etc.)"
    - name: "goal_category"
      expr: goal_category
      comment: "Category of the care plan goal (clinical, behavioral, functional, social determinant, etc.)"
    - name: "goal_code"
      expr: goal_code
      comment: "Standardized code for the goal type"
    - name: "priority"
      expr: priority
      comment: "Priority level of the goal (high, medium, low)"
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement for goal tracking (quantitative, qualitative, binary, etc.)"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Boolean indicator whether goal is in compliance with target"
    - name: "target_unit"
      expr: target_unit
      comment: "Unit of measurement for the goal target (days, visits, mg/dL, etc.)"
    - name: "goal_creation_year"
      expr: YEAR(created_timestamp)
      comment: "Year the goal was created"
    - name: "target_year"
      expr: YEAR(target_date)
      comment: "Year the goal target date falls in"
    - name: "actual_year"
      expr: YEAR(actual_date)
      comment: "Year the goal was actually achieved"
  measures:
    - name: "total_goals"
      expr: COUNT(1)
      comment: "Total number of care plan goals set across all members and plans"
    - name: "unique_plans_with_goals"
      expr: COUNT(DISTINCT plan_id)
      comment: "Distinct count of care plans with defined goals, representing care planning completeness"
    - name: "compliant_goal_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Count of goals in compliance with targets, representing care plan effectiveness"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across all goals, representing care plan ambition level"
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual value achieved across all goals, representing care plan performance"
    - name: "avg_goal_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score associated with goals, indicating complexity of goal achievement"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care program metrics tracking program enrollment capacity, utilization, outcomes, and evidence-based program performance for population health initiatives."
  source: "`vibe_health_insurance_v1`.`care`.`program`"
  dimensions:
    - name: "program_name"
      expr: name
      comment: "Name of the care management program"
    - name: "program_code"
      expr: code
      comment: "Standardized code for the care program"
    - name: "program_type"
      expr: program_type
      comment: "Type of care program (disease management, case management, wellness, transitional care, etc.)"
    - name: "category"
      expr: category
      comment: "Category of the care program (chronic care, preventive, behavioral health, etc.)"
    - name: "program_status"
      expr: program_status
      comment: "Current status of the program (active, pilot, suspended, retired, etc.)"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business the program serves (Medicare, Medicaid, Commercial, etc.)"
    - name: "target_population"
      expr: target_population
      comment: "Target population or eligibility criteria for the program"
    - name: "is_evidence_based"
      expr: is_evidence_based
      comment: "Boolean indicator whether program is evidence-based (peer-reviewed, clinically validated)"
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Accreditation status of the program (NCQA, URAC, etc.)"
    - name: "accreditation_body"
      expr: accreditation_body
      comment: "Accrediting body for the program"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the program started"
    - name: "end_year"
      expr: YEAR(end_date)
      comment: "Year the program ended or is scheduled to end"
  measures:
    - name: "total_programs"
      expr: COUNT(1)
      comment: "Total number of care management programs in the portfolio"
    - name: "active_program_count"
      expr: COUNT(CASE WHEN program_status = 'active' THEN 1 END)
      comment: "Count of currently active care programs available for member enrollment"
    - name: "evidence_based_program_count"
      expr: COUNT(CASE WHEN is_evidence_based = TRUE THEN 1 END)
      comment: "Count of evidence-based programs, representing clinical rigor and quality of program portfolio"
    - name: "total_enrollment_capacity"
      expr: SUM(CAST(enrollment_cap AS DOUBLE))
      comment: "Sum of enrollment capacity across all programs, representing total program capacity"
    - name: "total_current_enrollment"
      expr: SUM(CAST(enrollment_current AS DOUBLE))
      comment: "Sum of current enrollment across all programs, representing total program utilization"
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor across programs, indicating program complexity and reimbursement impact"
$$;