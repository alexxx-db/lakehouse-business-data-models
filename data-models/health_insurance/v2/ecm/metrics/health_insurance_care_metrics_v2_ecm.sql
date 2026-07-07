-- Metric views for domain: care | Business: Health Insurance | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_barrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care barrier identification and mitigation metrics tracking SDOH barriers, resolution outcomes, and impact on care delivery"
  source: "`vibe_health_insurance_v1`.`care`.`barrier`"
  dimensions:
    - name: "barrier_status"
      expr: barrier_status
      comment: "Current status of identified barrier (open, in-progress, resolved)"
    - name: "barrier_type"
      expr: barrier_type
      comment: "Type or category of care barrier"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of barrier impact (low, medium, high, critical)"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether barrier is critical to care delivery"
    - name: "intervention_type"
      expr: intervention_type
      comment: "Type of intervention applied to address barrier"
    - name: "identification_source"
      expr: identification_source
      comment: "Source that identified the barrier (HRA, outreach, claim, provider)"
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of barrier resolution efforts"
    - name: "hcc_impact"
      expr: hcc_impact
      comment: "Flag indicating whether barrier impacts HCC coding or risk adjustment"
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Flag indicating whether follow-up is required"
    - name: "identification_year"
      expr: YEAR(identification_timestamp)
      comment: "Year barrier was identified"
    - name: "identification_month"
      expr: DATE_TRUNC('MONTH', identification_timestamp)
      comment: "Month barrier was identified"
  measures:
    - name: "Total Barriers"
      expr: COUNT(1)
      comment: "Total number of care barriers identified"
    - name: "Open Barriers"
      expr: SUM(CASE WHEN barrier_status = 'open' THEN 1 ELSE 0 END)
      comment: "Count of barriers currently open"
    - name: "Resolved Barriers"
      expr: SUM(CASE WHEN barrier_status = 'resolved' THEN 1 ELSE 0 END)
      comment: "Count of barriers successfully resolved"
    - name: "Resolution Rate"
      expr: ROUND(100.0 * SUM(CASE WHEN barrier_status = 'resolved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of barriers resolved"
    - name: "Critical Barriers"
      expr: SUM(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END)
      comment: "Count of barriers flagged as critical"
    - name: "Critical Barrier Rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of barriers that are critical"
    - name: "Average Impact Score"
      expr: AVG(CAST(impact_score AS DOUBLE))
      comment: "Average impact score of identified barriers"
    - name: "Average Risk Adjustment Factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor associated with barriers"
    - name: "HCC Impact Barriers"
      expr: SUM(CASE WHEN hcc_impact = TRUE THEN 1 ELSE 0 END)
      comment: "Count of barriers impacting HCC coding or risk adjustment"
    - name: "Barriers with Intervention"
      expr: SUM(CASE WHEN intervention_applied IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of barriers where intervention was applied"
    - name: "Intervention Rate"
      expr: ROUND(100.0 * SUM(CASE WHEN intervention_applied IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of barriers receiving intervention"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_cahps_member_experience`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CAHPS member experience survey metrics tracking satisfaction scores, response rates, and Star Rating impact across survey types and member demographics. CAHPS scores directly contribute to CMS Star Ratings and drive member retention strategy."
  source: "`vibe_health_insurance_v1`.`care`.`cahps_survey`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Type of CAHPS survey (MA, PDP, HOS) — different survey types contribute to different Star Rating domains."
    - name: "survey_year"
      expr: survey_year
      comment: "Year of survey administration — enables year-over-year member experience trend analysis."
    - name: "survey_mode"
      expr: survey_mode
      comment: "Survey administration mode (Mail, Phone, Web) — affects response rates and score distributions."
    - name: "survey_language"
      expr: survey_language
      comment: "Language of survey administration — used for health equity analysis and language access compliance."
    - name: "member_state"
      expr: member_state
      comment: "Member state of residence — enables geographic analysis of member experience variation."
    - name: "administration_method"
      expr: administration_method
      comment: "Method used to administer the survey — affects data quality and comparability across survey cycles."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Whether the survey result is used for regulatory reporting — filters to CMS-reportable survey records."
  measures:
    - name: "avg_overall_satisfaction_score"
      expr: AVG(CAST(overall_satisfaction_score AS DOUBLE))
      comment: "Average overall member satisfaction score. Primary member experience KPI — directly contributes to CAHPS Star Rating domain and drives member retention and plan marketing strategy."
    - name: "avg_getting_needed_care_score"
      expr: AVG(CAST(getting_needed_care_score AS DOUBLE))
      comment: "Average score for getting needed care composite. Measures access to care — low scores trigger network adequacy review and prior authorization policy changes."
    - name: "avg_getting_care_quickly_score"
      expr: AVG(CAST(getting_care_quickly_score AS DOUBLE))
      comment: "Average score for getting care quickly composite. Measures timely access — low scores drive network expansion and appointment availability initiatives."
    - name: "avg_doctor_communication_score"
      expr: AVG(CAST(doctor_communication_score AS DOUBLE))
      comment: "Average doctor communication score. Provider communication quality directly impacts member satisfaction and care adherence — low scores drive provider engagement programs."
    - name: "avg_customer_service_score"
      expr: AVG(CAST(customer_service_score AS DOUBLE))
      comment: "Average customer service score. Reflects plan administrative experience — low scores drive call center and member services improvement investments."
    - name: "avg_response_rate"
      expr: AVG(CAST(response_rate AS DOUBLE))
      comment: "Average survey response rate. Low response rates reduce statistical reliability of CAHPS scores and may trigger CMS data sufficiency concerns — drives survey outreach strategy."
    - name: "avg_star_rating_impact_score"
      expr: AVG(CAST(star_rating_impact_score AS DOUBLE))
      comment: "Average Star Rating impact score from CAHPS surveys. Quantifies the contribution of member experience to overall Star Rating — used to prioritize member experience investments."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_cahps_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CAHPS member experience survey analytics measuring satisfaction scores, response rates, and Star Rating impact for member experience improvement initiatives."
  source: "`vibe_health_insurance_v1`.`care`.`cahps_survey`"
  dimensions:
    - name: "survey_year"
      expr: survey_year
      comment: "Survey administration year for annual experience trend analysis."
    - name: "survey_type"
      expr: survey_type
      comment: "Type of CAHPS survey (e.g., Medicare, Medicaid, Commercial)."
    - name: "survey_status"
      expr: survey_status
      comment: "Current status of the survey (completed, in-progress, not started)."
    - name: "survey_mode"
      expr: survey_mode
      comment: "Mode of survey administration (mail, phone, online, mixed)."
    - name: "administration_method"
      expr: administration_method
      comment: "Method used to administer the survey for response rate optimization."
    - name: "member_state"
      expr: member_state
      comment: "State of the surveyed member for geographic performance analysis."
    - name: "survey_language"
      expr: survey_language
      comment: "Language in which the survey was administered for equity analysis."
    - name: "survey_start_month"
      expr: DATE_TRUNC('month', survey_start_date)
      comment: "Month the survey period started for seasonal trending."
  measures:
    - name: "total_surveys"
      expr: COUNT(1)
      comment: "Total number of CAHPS surveys administered or tracked."
    - name: "avg_overall_satisfaction_score"
      expr: AVG(CAST(overall_satisfaction_score AS DOUBLE))
      comment: "Average overall member satisfaction score, a key driver of Star Ratings and member retention."
    - name: "avg_doctor_communication_score"
      expr: AVG(CAST(doctor_communication_score AS DOUBLE))
      comment: "Average doctor communication score measuring provider-member interaction quality."
    - name: "avg_getting_care_quickly_score"
      expr: AVG(CAST(getting_care_quickly_score AS DOUBLE))
      comment: "Average score for getting care quickly, measuring access and timeliness of care delivery."
    - name: "avg_getting_needed_care_score"
      expr: AVG(CAST(getting_needed_care_score AS DOUBLE))
      comment: "Average score for getting needed care, measuring adequacy of network and benefit access."
    - name: "avg_customer_service_score"
      expr: AVG(CAST(customer_service_score AS DOUBLE))
      comment: "Average customer service score measuring plan administrative and support quality."
    - name: "avg_response_rate"
      expr: AVG(CAST(response_rate AS DOUBLE))
      comment: "Average survey response rate indicating member engagement and survey methodology effectiveness."
    - name: "avg_star_rating_impact_score"
      expr: AVG(CAST(star_rating_impact_score AS DOUBLE))
      comment: "Average Star Rating impact score quantifying how CAHPS results influence overall Star performance."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care program enrollment metrics tracking member participation, risk stratification, and program effectiveness"
  source: "`vibe_health_insurance_v1`.`care`.`care_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of care program enrollment (active, pending, disenrolled)"
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment (voluntary, auto-enrolled, provider-referred)"
    - name: "program_tier"
      expr: program_tier
      comment: "Care program tier or intensity level assigned to member"
    - name: "acuity_level"
      expr: acuity_level
      comment: "Clinical acuity level of enrolled member"
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source system or channel that initiated enrollment"
    - name: "enrollment_year"
      expr: YEAR(effective_start_date)
      comment: "Year of enrollment start"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month of enrollment start"
    - name: "consent_status"
      expr: consent_status
      comment: "Member consent status for program participation"
  measures:
    - name: "Total Enrollments"
      expr: COUNT(1)
      comment: "Total number of care program enrollments"
    - name: "Unique Programs"
      expr: COUNT(DISTINCT program_id)
      comment: "Distinct count of care programs with active enrollments"
    - name: "Average Risk Score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of enrolled members"
    - name: "Average HCC Score"
      expr: AVG(CAST(hcc_score AS DOUBLE))
      comment: "Average Hierarchical Condition Category score of enrolled members"
    - name: "Total Risk Score"
      expr: SUM(CAST(risk_score AS DOUBLE))
      comment: "Sum of risk scores across all enrollments"
    - name: "Active Enrollment Rate"
      expr: ROUND(100.0 * SUM(CASE WHEN enrollment_status = 'active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments currently active"
    - name: "Disenrollment Rate"
      expr: ROUND(100.0 * SUM(CASE WHEN disenrollment_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments that have been disenrolled"
    - name: "High Risk Enrollment Count"
      expr: SUM(CASE WHEN CAST(risk_score AS DOUBLE) >= 3.0 THEN 1 ELSE 0 END)
      comment: "Count of enrollments with risk score >= 3.0 indicating high-risk members"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care plan analytics measuring plan creation, risk stratification, and active plan management for coordinated member care delivery."
  source: "`vibe_health_insurance_v1`.`care`.`care_plan`"
  dimensions:
    - name: "care_plan_status"
      expr: care_plan_status
      comment: "Current status of the care plan (active, completed, draft, discontinued)."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of care plan (e.g., disease management, complex care, transitional care)."
    - name: "high_risk_flag"
      expr: CAST(high_risk_flag AS STRING)
      comment: "Whether the care plan is flagged for high-risk members requiring intensive management."
    - name: "plan_creation_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the care plan became effective for trend and cohort analysis."
    - name: "plan_creation_year"
      expr: YEAR(effective_start_date)
      comment: "Year the care plan became effective for annual program review."
    - name: "source_system"
      expr: source_system
      comment: "Originating system of the care plan record for data lineage tracking."
  measures:
    - name: "total_care_plans"
      expr: COUNT(1)
      comment: "Total number of care plans created across the member population."
    - name: "active_care_plans"
      expr: SUM(CASE WHEN care_plan_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active care plans representing ongoing coordinated care efforts."
    - name: "high_risk_care_plans"
      expr: SUM(CASE WHEN high_risk_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of care plans for high-risk members requiring intensive resource allocation."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across care plans indicating population complexity and resource requirements."
    - name: "distinct_coordinators_assigned"
      expr: COUNT(DISTINCT coordinator_id)
      comment: "Distinct coordinators managing care plans for workload distribution analysis."
    - name: "avg_plan_duration_days"
      expr: AVG(CAST(DATEDIFF(COALESCE(effective_end_date, CURRENT_DATE()), effective_start_date) AS DOUBLE))
      comment: "Average duration of care plans in days, indicating typical care management engagement length."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_plan_management`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care plan creation, status, and risk metrics tracking active care plans, high-risk member coverage, and plan lifecycle. Care plans are the primary care management artifact — their quality and coverage directly drive clinical outcomes and quality measure performance."
  source: "`vibe_health_insurance_v1`.`care`.`care_plan`"
  dimensions:
    - name: "care_plan_status"
      expr: care_plan_status
      comment: "Current status of the care plan (Active, Closed, Suspended) — primary operational dimension for care management workflow."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of care plan (Disease Management, Transition of Care, Preventive) — used to segment care management program performance."
    - name: "high_risk_flag"
      expr: high_risk_flag
      comment: "Whether the care plan is for a high-risk member — high-risk plans require more intensive coordination and drive disproportionate cost."
    - name: "privacy_consent_flag"
      expr: privacy_consent_flag
      comment: "Whether privacy consent has been obtained for the care plan — required for HIPAA-compliant care coordination."
  measures:
    - name: "total_active_care_plans"
      expr: SUM(CASE WHEN care_plan_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of currently active care plans. Primary capacity metric for care management — compared against coordinator caseload capacity to identify staffing needs."
    - name: "high_risk_care_plan_count"
      expr: SUM(CASE WHEN high_risk_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of care plans for high-risk members. High-risk members drive disproportionate medical cost — their care plan coverage rate is a key quality and cost management KPI."
    - name: "high_risk_care_plan_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN high_risk_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of care plans designated as high-risk. Tracks intensity of care management program — rising rates signal increasing population acuity and cost trend."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of members with active care plans. Measures the acuity of the care-managed population — used to validate that care management is targeting the right members."
    - name: "consent_obtained_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN privacy_consent_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of care plans with privacy consent obtained. HIPAA compliance KPI — low consent rates create regulatory risk and limit care coordination activities."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_condition_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Condition registry analytics measuring chronic condition prevalence, risk adjustment factors, and condition management for population health and HCC coding accuracy."
  source: "`vibe_health_insurance_v1`.`care`.`condition_registry`"
  dimensions:
    - name: "condition_category"
      expr: condition_category
      comment: "Clinical category of the condition (e.g., diabetes, cardiovascular, respiratory, behavioral health)."
    - name: "severity"
      expr: severity
      comment: "Severity level of the condition for acuity-based population stratification."
    - name: "is_chronic"
      expr: CAST(is_chronic AS STRING)
      comment: "Whether the condition is classified as chronic for disease management program targeting."
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Confirmation status of the condition (confirmed, suspected, ruled-out)."
    - name: "risk_adjustment_flag"
      expr: CAST(risk_adjustment_flag AS STRING)
      comment: "Whether the condition is relevant for risk adjustment and HCC coding."
    - name: "active_flag"
      expr: CAST(active_flag AS STRING)
      comment: "Whether the condition is currently active for the member."
    - name: "population_segment"
      expr: population_segment
      comment: "Population segment the member belongs to for cohort-level condition analysis."
    - name: "identification_method"
      expr: identification_method
      comment: "Method used to identify the condition (claims, EHR, HRA, chart review)."
    - name: "hcc_code"
      expr: hcc_code
      comment: "HCC code associated with the condition for risk adjustment revenue analysis."
  measures:
    - name: "total_conditions"
      expr: COUNT(1)
      comment: "Total number of conditions in the registry for population health burden assessment."
    - name: "active_conditions"
      expr: SUM(CASE WHEN active_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of currently active conditions requiring ongoing management."
    - name: "chronic_conditions"
      expr: SUM(CASE WHEN is_chronic = TRUE THEN 1 ELSE 0 END)
      comment: "Count of chronic conditions for disease management program sizing and resource planning."
    - name: "risk_adjustment_conditions"
      expr: SUM(CASE WHEN risk_adjustment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of conditions flagged for risk adjustment, directly impacting HCC revenue capture."
    - name: "avg_raf_score"
      expr: AVG(CAST(raf_score AS DOUBLE))
      comment: "Average RAF score across conditions indicating risk adjustment revenue opportunity."
    - name: "confirmed_conditions"
      expr: SUM(CASE WHEN confirmation_status = 'confirmed' THEN 1 ELSE 0 END)
      comment: "Count of confirmed conditions for accurate population health reporting."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_condition_registry_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chronic condition registry metrics tracking condition prevalence, HCC coding completeness, and risk adjustment documentation quality. Accurate condition registries drive CMS risk adjustment revenue and care management program targeting."
  source: "`vibe_health_insurance_v1`.`care`.`condition_registry`"
  dimensions:
    - name: "condition_category"
      expr: condition_category
      comment: "Clinical category of the condition (e.g., Diabetes, Heart Failure, COPD) — used for disease management program sizing and network adequacy planning."
    - name: "registry_type_code"
      expr: registry_type_code
      comment: "Type of condition registry (Chronic, Acute, Behavioral Health) — used to segment condition management programs."
    - name: "registry_status_code"
      expr: registry_status_code
      comment: "Status of the registry record (Active, Resolved, Inactive) — filters to current active conditions for risk adjustment."
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Whether the condition has been clinically confirmed — unconfirmed conditions cannot be used for risk adjustment coding."
    - name: "risk_adjustment_flag"
      expr: risk_adjustment_flag
      comment: "Whether the condition is flagged for risk adjustment — directly drives CMS RAF score and capitation revenue."
    - name: "is_chronic"
      expr: is_chronic
      comment: "Whether the condition is chronic — chronic conditions drive ongoing care management intensity and long-term cost projections."
    - name: "evidence_source_code"
      expr: evidence_source_code
      comment: "Source of condition evidence (Claim, Medical Record, Lab) — used to assess documentation quality for risk adjustment audit defense."
    - name: "severity_code"
      expr: severity_code
      comment: "Severity of the condition — used to prioritize care management interventions and predict cost trajectory."
  measures:
    - name: "total_registered_conditions"
      expr: COUNT(1)
      comment: "Total conditions in the registry. Baseline metric for condition prevalence analysis — compared against claims-based condition counts to identify documentation gaps."
    - name: "risk_adjustment_eligible_count"
      expr: SUM(CASE WHEN risk_adjustment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of conditions eligible for risk adjustment coding. Directly drives CMS RAF score and capitation revenue — gaps represent unrealized revenue."
    - name: "chronic_condition_count"
      expr: SUM(CASE WHEN is_chronic = TRUE THEN 1 ELSE 0 END)
      comment: "Count of chronic conditions in the registry. Chronic condition burden drives care management program sizing, specialty network needs, and long-term medical cost projections."
    - name: "confirmed_condition_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN confirmation_status = 'Confirmed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of registry conditions that are clinically confirmed. Low confirmation rates reduce risk adjustment revenue and indicate documentation quality issues requiring provider education."
    - name: "avg_raf_score"
      expr: AVG(CAST(raf_score AS DOUBLE))
      comment: "Average RAF (Risk Adjustment Factor) score across registry conditions. RAF scores directly determine CMS capitation payments — monitoring average RAF identifies revenue optimization opportunities."
    - name: "distinct_members_with_conditions"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Count of distinct members with conditions in the registry. Measures condition registry coverage — compared against total enrolled population to identify members not yet risk-stratified."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_coordinator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care coordinator capacity and workload metrics tracking caseload utilization and coordinator availability"
  source: "`vibe_health_insurance_v1`.`care`.`coordinator`"
  dimensions:
    - name: "coordinator_status"
      expr: coordinator_status
      comment: "Current status of care coordinator (active, inactive, on-leave)"
    - name: "role_type"
      expr: role_type
      comment: "Role type of care coordinator"
    - name: "specialty_area"
      expr: specialty_area
      comment: "Specialty area or clinical focus of coordinator"
    - name: "assigned_lob"
      expr: assigned_lob
      comment: "Line of business assigned to coordinator"
    - name: "employment_status"
      expr: employment_status
      comment: "Employment status (full-time, part-time, contractor)"
    - name: "organization_unit"
      expr: organization_unit
      comment: "Organizational unit or department"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year coordinator was hired"
  measures:
    - name: "Total Coordinators"
      expr: COUNT(1)
      comment: "Total number of care coordinators"
    - name: "Active Coordinators"
      expr: SUM(CASE WHEN coordinator_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active care coordinators"
    - name: "Total Caseload Capacity"
      expr: SUM(CAST(caseload_capacity AS DOUBLE))
      comment: "Sum of caseload capacity across all coordinators"
    - name: "Total Current Caseload"
      expr: SUM(CAST(current_caseload_count AS DOUBLE))
      comment: "Sum of current caseload across all coordinators"
    - name: "Average Caseload Utilization"
      expr: ROUND(100.0 * SUM(CAST(current_caseload_count AS DOUBLE)) / NULLIF(SUM(CAST(caseload_capacity AS DOUBLE)), 0), 2)
      comment: "Percentage of coordinator capacity currently utilized"
    - name: "Average Caseload Weight"
      expr: AVG(CAST(caseload_weight AS DOUBLE))
      comment: "Average caseload weight per coordinator"
    - name: "Total Caseload Weight"
      expr: SUM(CAST(caseload_weight AS DOUBLE))
      comment: "Sum of caseload weight across all coordinators"
    - name: "Coordinators at Capacity"
      expr: SUM(CASE WHEN CAST(current_caseload_count AS DOUBLE) >= CAST(caseload_capacity AS DOUBLE) THEN 1 ELSE 0 END)
      comment: "Count of coordinators at or above caseload capacity"
    - name: "Capacity Constraint Rate"
      expr: ROUND(100.0 * SUM(CASE WHEN CAST(current_caseload_count AS DOUBLE) >= CAST(caseload_capacity AS DOUBLE) THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN coordinator_status = 'active' THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of active coordinators at or above capacity"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_coordinator_workload`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care coordinator assignment and workload metrics tracking caseload distribution, assignment duration, and primary assignment rates. Enables care management operations to optimize coordinator capacity and prevent burnout."
  source: "`vibe_health_insurance_v1`.`care`.`coordinator_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the coordinator assignment (Active, Closed, Transferred) — primary operational dimension for workload management."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of coordinator assignment (Primary, Secondary, Temporary) — informs accountability and escalation routing."
    - name: "assignment_method"
      expr: assignment_method
      comment: "How the assignment was made (Algorithmic, Manual, Referral) — used to evaluate assignment model effectiveness."
    - name: "assignment_reason"
      expr: assignment_reason
      comment: "Business reason for the assignment — identifies drivers of coordinator demand (e.g., high risk, gap closure, transition of care)."
    - name: "primary_assignment_flag"
      expr: primary_assignment_flag
      comment: "Whether this is the primary coordinator assignment for the member — ensures single accountability for care coordination."
  measures:
    - name: "total_active_assignments"
      expr: SUM(CASE WHEN assignment_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Total active coordinator assignments. Primary caseload metric for staffing decisions — compared against coordinator capacity to identify overload risk."
    - name: "avg_caseload_weight"
      expr: AVG(CAST(caseload_weight AS DOUBLE))
      comment: "Average caseload weight per assignment. Caseload weight accounts for member complexity — high average weight signals coordinator burnout risk and quality degradation."
    - name: "total_caseload_weight"
      expr: SUM(CAST(caseload_weight AS DOUBLE))
      comment: "Total caseload weight across all active assignments. Used to balance workload distribution across the coordinator team and justify staffing additions."
    - name: "primary_assignment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN primary_assignment_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments designated as primary. Low primary assignment rates indicate accountability gaps in care coordination — every member should have one primary coordinator."
    - name: "distinct_members_assigned"
      expr: COUNT(DISTINCT coordinator_member_subscriber_id)
      comment: "Count of distinct members with an active coordinator assignment. Measures care management program reach — compared against high-risk population size to identify coverage gaps."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_gap`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care gap closure metrics tracking quality measure gaps, HEDIS performance, and gap resolution effectiveness"
  source: "`vibe_health_insurance_v1`.`care`.`gap`"
  dimensions:
    - name: "gap_status"
      expr: gap_status
      comment: "Current status of care gap (open, closed, in-progress)"
    - name: "gap_type"
      expr: gap_type
      comment: "Type or category of care gap"
    - name: "clinical_category"
      expr: clinical_category
      comment: "Clinical domain or category of the care gap"
    - name: "hedis_measure_code"
      expr: hedis_measure_code
      comment: "HEDIS measure code associated with the gap"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for gap closure (high, medium, low)"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether gap is critical for member health or quality ratings"
    - name: "documentation_status"
      expr: documentation_status
      comment: "Status of gap documentation and evidence"
    - name: "closure_method"
      expr: closure_method
      comment: "Method used to close the gap (chart review, claim, encounter)"
    - name: "gap_open_year"
      expr: YEAR(open_date)
      comment: "Year the gap was opened"
    - name: "gap_open_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the gap was opened"
  measures:
    - name: "Total Gaps"
      expr: COUNT(1)
      comment: "Total number of care gaps identified"
    - name: "Open Gaps"
      expr: SUM(CASE WHEN gap_status = 'open' THEN 1 ELSE 0 END)
      comment: "Count of care gaps currently open"
    - name: "Closed Gaps"
      expr: SUM(CASE WHEN gap_status = 'closed' THEN 1 ELSE 0 END)
      comment: "Count of care gaps successfully closed"
    - name: "Gap Closure Rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gap_status = 'closed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of gaps closed out of total gaps identified"
    - name: "Critical Gaps"
      expr: SUM(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END)
      comment: "Count of gaps flagged as critical"
    - name: "Critical Gap Rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of gaps that are critical"
    - name: "Average Risk Score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score associated with care gaps"
    - name: "Average Measure Target Value"
      expr: AVG(CAST(measure_target_value AS DOUBLE))
      comment: "Average target value for quality measures associated with gaps"
    - name: "Gaps Closed On Time"
      expr: SUM(CASE WHEN gap_status = 'closed' AND actual_resolution_date <= target_date THEN 1 ELSE 0 END)
      comment: "Count of gaps closed by or before target date"
    - name: "On-Time Closure Rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gap_status = 'closed' AND actual_resolution_date <= target_date THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN gap_status = 'closed' THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of closed gaps that were closed on or before target date"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_gap_management`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care gap identification, prioritization, and closure metrics. Tracks open gaps, closure rates, and risk-adjusted gap burden by clinical category, plan, and coordinator. Directly informs quality improvement programs and Star Rating improvement strategies."
  source: "`vibe_health_insurance_v1`.`care`.`gap`"
  dimensions:
    - name: "gap_status"
      expr: gap_status
      comment: "Current status of the care gap (Open, Closed, In Progress) — primary operational dimension for gap management workflows."
    - name: "gap_type"
      expr: gap_type
      comment: "Type of care gap (e.g., Preventive, Chronic, Medication Adherence) for clinical category analysis."
    - name: "clinical_category"
      expr: clinical_category
      comment: "Clinical domain of the gap (e.g., Diabetes, Cardiovascular) for population health program targeting."
    - name: "priority_level"
      expr: priority_level
      comment: "Gap priority level (High, Medium, Low) used to triage outreach and intervention resources."
    - name: "closure_method"
      expr: closure_method
      comment: "How the gap was closed (e.g., Claim, Medical Record, Attestation) — informs data collection strategy effectiveness."
    - name: "documentation_status"
      expr: documentation_status
      comment: "Status of supporting documentation for gap closure — tracks evidence completeness for audit purposes."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the gap is clinically critical, used to escalate high-risk member interventions."
  measures:
    - name: "total_open_gaps"
      expr: SUM(CASE WHEN gap_status = 'Open' THEN 1 ELSE 0 END)
      comment: "Total count of open care gaps. The primary operational KPI for care management — drives outreach prioritization and resource allocation."
    - name: "total_closed_gaps"
      expr: SUM(CASE WHEN gap_status = 'Closed' THEN 1 ELSE 0 END)
      comment: "Total count of closed care gaps. Measures care management program effectiveness and quality improvement throughput."
    - name: "gap_closure_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gap_status = 'Closed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of all identified gaps that have been closed. Core KPI for quality improvement programs — directly correlates with HEDIS compliance rates and Star Rating improvement."
    - name: "critical_open_gap_count"
      expr: SUM(CASE WHEN gap_status = 'Open' AND is_critical = TRUE THEN 1 ELSE 0 END)
      comment: "Count of open gaps flagged as clinically critical. Drives urgent care management escalation and risk mitigation decisions."
    - name: "avg_risk_score_open_gaps"
      expr: AVG(CASE WHEN gap_status = 'Open' THEN risk_score ELSE NULL END)
      comment: "Average risk score of members with open gaps. Higher scores indicate sicker populations with unmet care needs — informs resource prioritization."
    - name: "avg_gap_measure_target"
      expr: AVG(CAST(measure_target_value AS DOUBLE))
      comment: "Average measure target value across gaps, representing the clinical threshold that must be met for gap closure. Used to calibrate program goals."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_hedis_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HEDIS quality measure performance metrics tracking numerator/denominator rates, exclusion rates, and compliance status by measure, plan, and provider. Core quality scorecard for Star Ratings and regulatory reporting."
  source: "`vibe_health_insurance_v1`.`care`.`hedis_result`"
  dimensions:
    - name: "measure_year"
      expr: measure_year
      comment: "The measurement year for HEDIS reporting, used to trend quality performance year-over-year."
    - name: "measure_category"
      expr: measure_category
      comment: "Clinical category of the HEDIS measure (e.g., Effectiveness of Care, Access/Availability) for domain-level rollup."
    - name: "measure_type"
      expr: measure_type
      comment: "Type of HEDIS measure (e.g., HEDIS, CAHPS, HOS) to segment performance reporting."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Whether the member-measure record is compliant, non-compliant, or excluded — drives gap closure prioritization."
    - name: "collection_method"
      expr: collection_method
      comment: "Data collection method (Administrative, Hybrid, Survey) affecting measure validity and audit requirements."
    - name: "data_source"
      expr: data_source
      comment: "Source system providing the HEDIS result data, used for data lineage and quality audits."
    - name: "hybrid_chase_status_code"
      expr: hybrid_chase_status_code
      comment: "Chase status for hybrid measure medical record retrieval — tracks outstanding medical record requests."
  measures:
    - name: "total_denominator_eligible"
      expr: SUM(CASE WHEN denominator_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of members meeting HEDIS denominator eligibility criteria. Denominator size drives statistical reliability of the measure rate."
    - name: "total_numerator_met"
      expr: SUM(CASE WHEN numerator_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of members meeting the HEDIS numerator (i.e., received the recommended care). Numerator drives the compliance rate."
    - name: "total_excluded"
      expr: SUM(CASE WHEN exclusion_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of members excluded from the measure. High exclusion rates may indicate documentation gaps or population health issues."
    - name: "hedis_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN numerator_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN denominator_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "HEDIS measure compliance rate (numerator / denominator %). The primary quality KPI used in Star Ratings, NCQA accreditation, and CMS reporting. Directly drives quality bonus payments."
    - name: "exclusion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN exclusion_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN denominator_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of eligible members excluded from the measure. Elevated exclusion rates trigger compliance review and may indicate coding or documentation issues."
    - name: "avg_measure_score"
      expr: AVG(CAST(measure_score AS DOUBLE))
      comment: "Average HEDIS measure score across all result records. Used to benchmark plan performance against national and state thresholds."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_hedis_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HEDIS quality measure performance metrics tracking numerator/denominator compliance and measure scores"
  source: "`vibe_health_insurance_v1`.`care`.`hedis_result`"
  dimensions:
    - name: "measurement_year"
      expr: measurement_year
      comment: "HEDIS measurement year"
    - name: "measure_type"
      expr: measure_type
      comment: "Type of HEDIS measure"
    - name: "measure_category"
      expr: measure_category
      comment: "Category of HEDIS measure"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status for the measure"
    - name: "collection_method"
      expr: collection_method
      comment: "Method used to collect measure data (administrative, hybrid, survey)"
    - name: "is_excluded"
      expr: is_excluded
      comment: "Flag indicating whether member was excluded from measure"
    - name: "exclusion_reason"
      expr: exclusion_reason
      comment: "Reason for exclusion from measure denominator"
    - name: "data_source"
      expr: data_source
      comment: "Source of measure data"
    - name: "measure_version"
      expr: measure_version
      comment: "Version of HEDIS measure specification"
  measures:
    - name: "Total Measure Results"
      expr: COUNT(1)
      comment: "Total number of HEDIS measure results recorded"
    - name: "Unique Measures"
      expr: COUNT(DISTINCT hedis_measure_id)
      comment: "Distinct count of HEDIS measures evaluated"
    - name: "Denominator Count"
      expr: SUM(CASE WHEN denominator_criteria_met = TRUE THEN 1 ELSE 0 END)
      comment: "Count of members meeting denominator criteria (eligible population)"
    - name: "Numerator Count"
      expr: SUM(CASE WHEN numerator_criteria_met = TRUE THEN 1 ELSE 0 END)
      comment: "Count of members meeting numerator criteria (compliant with measure)"
    - name: "Exclusion Count"
      expr: SUM(CASE WHEN is_excluded = TRUE THEN 1 ELSE 0 END)
      comment: "Count of members excluded from measure denominator"
    - name: "Measure Compliance Rate"
      expr: ROUND(100.0 * SUM(CASE WHEN numerator_criteria_met = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN denominator_criteria_met = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of eligible members who met measure criteria (numerator/denominator)"
    - name: "Exclusion Rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_excluded = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measure results that were excluded"
    - name: "Average Measure Score"
      expr: AVG(CAST(measure_score AS DOUBLE))
      comment: "Average score across all HEDIS measure results"
    - name: "Compliant Members"
      expr: SUM(CASE WHEN compliance_status = 'compliant' THEN 1 ELSE 0 END)
      comment: "Count of members with compliant status"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_hra`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health Risk Assessment metrics tracking completion rates, risk stratification, and SDOH screening results"
  source: "`vibe_health_insurance_v1`.`care`.`hra`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Status of HRA completion (completed, in-progress, abandoned)"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of health risk assessment"
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier assigned based on HRA results (low, medium, high)"
    - name: "completion_channel"
      expr: completion_channel
      comment: "Channel through which HRA was completed (web, phone, paper)"
    - name: "screening_tool"
      expr: screening_tool
      comment: "Screening tool or instrument used for assessment"
    - name: "compliance_cms_required"
      expr: compliance_cms_required
      comment: "Flag indicating whether HRA is CMS-required"
    - name: "compliance_ncqa_required"
      expr: compliance_ncqa_required
      comment: "Flag indicating whether HRA is NCQA-required"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of HRA completion"
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of HRA completion"
  measures:
    - name: "Total HRAs"
      expr: COUNT(1)
      comment: "Total number of health risk assessments"
    - name: "Completed HRAs"
      expr: SUM(CASE WHEN assessment_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of HRAs with completed status"
    - name: "Completion Rate"
      expr: ROUND(100.0 * SUM(CASE WHEN assessment_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of HRAs completed"
    - name: "Average Risk Score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score from HRA results"
    - name: "Average Risk Percentile"
      expr: AVG(CAST(risk_score_percentile AS DOUBLE))
      comment: "Average risk score percentile from HRA results"
    - name: "High Risk Count"
      expr: SUM(CASE WHEN risk_tier = 'high' THEN 1 ELSE 0 END)
      comment: "Count of HRAs identifying high-risk members"
    - name: "High Risk Rate"
      expr: ROUND(100.0 * SUM(CASE WHEN risk_tier = 'high' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of HRAs identifying high-risk members"
    - name: "SDOH Food Insecurity Count"
      expr: SUM(CASE WHEN sdoh_food_insecurity = TRUE THEN 1 ELSE 0 END)
      comment: "Count of HRAs identifying food insecurity"
    - name: "SDOH Housing Instability Count"
      expr: SUM(CASE WHEN sdoh_housing_instability = TRUE THEN 1 ELSE 0 END)
      comment: "Count of HRAs identifying housing instability"
    - name: "SDOH Transportation Barrier Count"
      expr: SUM(CASE WHEN sdoh_transportation = TRUE THEN 1 ELSE 0 END)
      comment: "Count of HRAs identifying transportation barriers"
    - name: "SDOH Social Isolation Count"
      expr: SUM(CASE WHEN sdoh_social_isolation = TRUE THEN 1 ELSE 0 END)
      comment: "Count of HRAs identifying social isolation"
    - name: "SDOH Financial Strain Count"
      expr: SUM(CASE WHEN sdoh_financial_strain = TRUE THEN 1 ELSE 0 END)
      comment: "Count of HRAs identifying financial strain"
    - name: "SDOH Prevalence Rate"
      expr: ROUND(100.0 * SUM(CASE WHEN (sdoh_food_insecurity = TRUE OR sdoh_housing_instability = TRUE OR sdoh_transportation = TRUE OR sdoh_social_isolation = TRUE OR sdoh_financial_strain = TRUE) THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of HRAs identifying any social determinant of health barrier"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_member_outreach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member outreach effectiveness metrics tracking contact attempts, outcomes, and engagement rates"
  source: "`vibe_health_insurance_v1`.`care`.`member_outreach`"
  dimensions:
    - name: "member_outreach_status"
      expr: member_outreach_status
      comment: "Status of outreach attempt"
    - name: "channel"
      expr: channel
      comment: "Communication channel used for outreach (phone, email, SMS, mail)"
    - name: "purpose"
      expr: purpose
      comment: "Purpose or reason for member outreach"
    - name: "outcome"
      expr: outcome
      comment: "Outcome of outreach attempt (contacted, left message, no answer, refused)"
    - name: "is_automated"
      expr: is_automated
      comment: "Flag indicating whether outreach was automated or manual"
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Flag indicating whether follow-up outreach is required"
    - name: "language_preference"
      expr: language_preference
      comment: "Member language preference for outreach"
    - name: "compliance_consent_obtained"
      expr: compliance_consent_obtained
      comment: "Flag indicating whether member consent was obtained"
    - name: "outreach_year"
      expr: YEAR(outreach_timestamp)
      comment: "Year of outreach attempt"
    - name: "outreach_month"
      expr: DATE_TRUNC('MONTH', outreach_timestamp)
      comment: "Month of outreach attempt"
  measures:
    - name: "Total Outreach Attempts"
      expr: COUNT(1)
      comment: "Total number of member outreach attempts"
    - name: "Successful Contacts"
      expr: SUM(CASE WHEN outcome IN ('contacted', 'completed', 'successful') THEN 1 ELSE 0 END)
      comment: "Count of outreach attempts that successfully reached the member"
    - name: "Contact Success Rate"
      expr: ROUND(100.0 * SUM(CASE WHEN outcome IN ('contacted', 'completed', 'successful') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outreach attempts that successfully contacted member"
    - name: "Follow-Up Required Count"
      expr: SUM(CASE WHEN follow_up_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of outreach attempts requiring follow-up"
    - name: "Follow-Up Rate"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outreach attempts requiring follow-up"
    - name: "Consent Obtained Count"
      expr: SUM(CASE WHEN compliance_consent_obtained = TRUE THEN 1 ELSE 0 END)
      comment: "Count of outreach attempts where member consent was obtained"
    - name: "Consent Rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_consent_obtained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outreach attempts that obtained member consent"
    - name: "Automated Outreach Count"
      expr: SUM(CASE WHEN is_automated = TRUE THEN 1 ELSE 0 END)
      comment: "Count of automated outreach attempts"
    - name: "Automation Rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_automated = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outreach attempts that were automated"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_member_outreach_effectiveness`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care management member outreach metrics tracking outreach volume, channel effectiveness, consent rates, and follow-up compliance. Outreach effectiveness directly drives care gap closure rates and program enrollment."
  source: "`vibe_health_insurance_v1`.`care`.`member_outreach`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Outreach channel used (Phone, Mail, Portal, SMS) — channel effectiveness analysis drives outreach strategy optimization."
    - name: "purpose"
      expr: purpose
      comment: "Purpose of the outreach (Gap Closure, Program Enrollment, Transition Follow-up) — used to measure outreach ROI by program type."
    - name: "member_outreach_status"
      expr: member_outreach_status
      comment: "Current status of the outreach attempt (Completed, Pending, Failed) — operational dimension for outreach workflow management."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the outreach attempt (Reached, Voicemail, No Answer, Refused) — outcome distribution drives channel strategy and script optimization."
    - name: "is_automated"
      expr: is_automated
      comment: "Whether the outreach was automated or manual — used to measure automation ROI and identify candidates for further automation."
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Whether follow-up is required after the outreach — tracks outstanding follow-up obligations for care coordinators."
    - name: "language_preference"
      expr: language_preference
      comment: "Member language preference for outreach — used for health equity analysis and language access compliance."
  measures:
    - name: "total_outreach_attempts"
      expr: COUNT(1)
      comment: "Total outreach attempts. Baseline volume metric for care management outreach program — compared against member population to measure outreach coverage."
    - name: "successful_contact_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN outcome = 'Reached' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outreach attempts resulting in successful member contact. Core outreach effectiveness KPI — low contact rates drive channel strategy changes and outreach timing optimization."
    - name: "consent_obtained_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_consent_obtained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outreach attempts resulting in consent obtained. Consent is required for care management program enrollment — low rates limit program reach and drive consent strategy review."
    - name: "automated_outreach_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_automated = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outreach conducted via automated channels. Automation rate drives cost efficiency — higher automation reduces per-contact cost while maintaining outreach volume."
    - name: "pending_follow_up_count"
      expr: SUM(CASE WHEN follow_up_required = TRUE AND member_outreach_status != 'Completed' THEN 1 ELSE 0 END)
      comment: "Count of outreach records with outstanding follow-up obligations. Tracks care coordinator workload and compliance with follow-up protocols — high counts signal capacity constraints."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_member_risk_stratification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member-level risk stratification metrics tracking risk score distribution, tier assignments, and HCC burden. Informs care management program targeting, actuarial risk adjustment, and CMS RAF score optimization."
  source: "`vibe_health_insurance_v1`.`care`.`member_risk_tier`"
  dimensions:
    - name: "tier_code"
      expr: tier_code
      comment: "Risk tier code (e.g., T1-T5) assigned to the member — primary segmentation dimension for care management program enrollment."
    - name: "tier_name"
      expr: tier_name
      comment: "Human-readable risk tier name for reporting and dashboard display."
    - name: "model_type"
      expr: model_type
      comment: "Risk stratification model used (e.g., CMS-HCC, Hierarchical Condition Category) — affects comparability across populations."
    - name: "assignment_method"
      expr: assignment_method
      comment: "How the risk tier was assigned (Algorithmic, Manual, Clinical Review) — informs model accuracy and override rates."
    - name: "recommended_care_program"
      expr: recommended_care_program
      comment: "Care program recommended based on risk tier — links risk stratification to care management program enrollment."
    - name: "chronic_condition_flag"
      expr: chronic_condition_flag
      comment: "Whether the member has at least one chronic condition — key driver of care management intensity and cost."
    - name: "is_current"
      expr: is_current
      comment: "Whether this is the current active risk tier assignment — filters to point-in-time risk population."
    - name: "demographic_group"
      expr: demographic_group
      comment: "Demographic cohort of the member — used for health equity analysis and population health disparity reporting."
  measures:
    - name: "total_risk_stratified_members"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Count of distinct members with a risk tier assignment. Measures risk stratification program coverage — gaps indicate members not yet scored."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across stratified members. Core actuarial KPI — rising average risk scores signal increasing medical cost trend and drive premium rate adjustments."
    - name: "avg_hcc_score"
      expr: AVG(CAST(hcc_score AS DOUBLE))
      comment: "Average HCC (Hierarchical Condition Category) score. Directly drives CMS risk adjustment revenue — higher scores yield higher capitation payments."
    - name: "high_risk_member_count"
      expr: SUM(CASE WHEN tier_code IN ('T4', 'T5') OR tier_name LIKE '%High%' THEN 1 ELSE 0 END)
      comment: "Count of members in the highest risk tiers. Drives care management staffing models, outreach prioritization, and medical cost containment investment decisions."
    - name: "chronic_condition_member_count"
      expr: SUM(CASE WHEN chronic_condition_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of members with at least one chronic condition. Informs disease management program sizing and specialty care network adequacy planning."
    - name: "avg_risk_factor_weight"
      expr: AVG(CAST(risk_factor_weight AS DOUBLE))
      comment: "Average risk factor weight applied in the stratification model. Used to validate model calibration and identify populations where risk factors may be under- or over-weighted."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_plan_goal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care plan goal analytics measuring goal attainment, progress tracking, and clinical outcome achievement for care management effectiveness evaluation."
  source: "`vibe_health_insurance_v1`.`care`.`plan_goal`"
  dimensions:
    - name: "plan_goal_status"
      expr: plan_goal_status
      comment: "Current status of the care plan goal (active, achieved, not met, in-progress)."
    - name: "goal_category"
      expr: goal_category
      comment: "Category of the care plan goal (e.g., clinical, behavioral, functional, self-management)."
    - name: "priority"
      expr: priority
      comment: "Priority level of the goal for resource allocation and focus."
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement used to evaluate goal progress."
    - name: "goal_target_month"
      expr: DATE_TRUNC('month', target_date)
      comment: "Target month for goal achievement for timeline tracking."
  measures:
    - name: "total_goals"
      expr: COUNT(1)
      comment: "Total number of care plan goals established across the managed population."
    - name: "achieved_goals"
      expr: SUM(CASE WHEN plan_goal_status = 'achieved' THEN 1 ELSE 0 END)
      comment: "Count of goals successfully achieved, measuring care management effectiveness."
    - name: "active_goals"
      expr: SUM(CASE WHEN plan_goal_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active goals being worked toward."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across goals for benchmark setting."
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual value achieved across goals for performance measurement."
    - name: "compliant_goals"
      expr: SUM(CASE WHEN compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of goals meeting compliance criteria for regulatory and quality reporting."
    - name: "distinct_care_plans_with_goals"
      expr: COUNT(DISTINCT care_plan_id)
      comment: "Distinct care plans with established goals measuring care planning thoroughness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_population_risk_segmentation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Population risk segmentation metrics tracking member distribution across risk tiers, PMPM cost bands, and segment sizes. Enables actuarial and care management leadership to allocate resources and design targeted interventions."
  source: "`vibe_health_insurance_v1`.`care`.`population_segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of population segment (e.g., High Risk, Rising Risk, Stable) for stratified care management program design."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier assignment for the segment — primary dimension for resource allocation and care program targeting."
    - name: "pmpm_cost_band"
      expr: pmpm_cost_band
      comment: "Per-member-per-month cost band for the segment, used to identify high-cost cohorts for cost containment programs."
    - name: "recommended_care_program"
      expr: recommended_care_program
      comment: "Care program recommended for this segment — links population segmentation to care management program enrollment decisions."
    - name: "refresh_frequency_code"
      expr: refresh_frequency_code
      comment: "How frequently the segment is refreshed (Daily, Weekly, Monthly) — affects data currency for operational decisions."
    - name: "population_segment_status"
      expr: population_segment_status
      comment: "Active/inactive status of the segment definition — filters to current operational segments."
  measures:
    - name: "total_population_count"
      expr: SUM(CAST(population_count AS DOUBLE))
      comment: "Total number of members across all population segments. Baseline denominator for per-member cost and utilization analysis."
    - name: "avg_population_per_segment"
      expr: AVG(CAST(population_count AS DOUBLE))
      comment: "Average member count per segment. Segments that are too large or too small may indicate segmentation model recalibration needs."
    - name: "avg_pmpm_cost"
      expr: AVG(CAST(average_pmpm_cost AS DOUBLE))
      comment: "Average per-member-per-month cost across segments. Core financial KPI for actuarial pricing, reserve setting, and care management ROI analysis."
    - name: "total_active_segments"
      expr: SUM(CASE WHEN population_segment_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of active population segments. Tracks segmentation model coverage and operational readiness."
    - name: "high_risk_population_count"
      expr: SUM(CASE WHEN risk_tier = 'High' THEN population_count ELSE 0 END)
      comment: "Total members in high-risk segments. Directly drives care management staffing, outreach budget, and medical cost trend projections."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care program performance metrics tracking enrollment capacity, accreditation status, and program outcomes"
  source: "`vibe_health_insurance_v1`.`care`.`program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current status of care program (active, inactive, suspended)"
    - name: "program_type"
      expr: program_type
      comment: "Type of care program (disease management, case management, wellness)"
    - name: "program_category"
      expr: program_category
      comment: "Category of care program"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for program (Medicare, Medicaid, Commercial)"
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Accreditation status of program"
    - name: "accreditation_body"
      expr: accreditation_body
      comment: "Accrediting body for program (NCQA, URAC, Joint Commission)"
    - name: "is_evidence_based"
      expr: is_evidence_based
      comment: "Flag indicating whether program is evidence-based"
    - name: "target_population"
      expr: target_population
      comment: "Target population for program enrollment"
    - name: "program_start_year"
      expr: YEAR(start_date)
      comment: "Year program started"
  measures:
    - name: "Total Programs"
      expr: COUNT(1)
      comment: "Total number of care programs"
    - name: "Active Programs"
      expr: SUM(CASE WHEN program_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active care programs"
    - name: "Total Enrollment Capacity"
      expr: SUM(CAST(enrollment_cap AS DOUBLE))
      comment: "Sum of enrollment capacity across all programs"
    - name: "Total Current Enrollment"
      expr: SUM(CAST(enrollment_current AS DOUBLE))
      comment: "Sum of current enrollment across all programs"
    - name: "Average Enrollment Utilization"
      expr: ROUND(100.0 * SUM(CAST(enrollment_current AS DOUBLE)) / NULLIF(SUM(CAST(enrollment_cap AS DOUBLE)), 0), 2)
      comment: "Percentage of program capacity currently utilized"
    - name: "Accredited Programs"
      expr: SUM(CASE WHEN accreditation_status IN ('accredited', 'active') THEN 1 ELSE 0 END)
      comment: "Count of programs with active accreditation"
    - name: "Accreditation Rate"
      expr: ROUND(100.0 * SUM(CASE WHEN accreditation_status IN ('accredited', 'active') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of programs that are accredited"
    - name: "Evidence-Based Programs"
      expr: SUM(CASE WHEN is_evidence_based = TRUE THEN 1 ELSE 0 END)
      comment: "Count of evidence-based care programs"
    - name: "Evidence-Based Rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_evidence_based = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of programs that are evidence-based"
    - name: "Average Risk Adjustment Factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor across programs"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_program_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care management program enrollment metrics tracking enrollment volume, engagement levels, graduation rates, and opt-out patterns. Enables care management leadership to evaluate program effectiveness and capacity utilization."
  source: "`vibe_health_insurance_v1`.`care`.`program_enrollment`"
  dimensions:
    - name: "enrollment_status_code"
      expr: enrollment_status_code
      comment: "Current enrollment status (Active, Graduated, Disenrolled, Pending) — primary operational dimension for program capacity management."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment (Voluntary, Mandatory, Referral) — informs engagement strategy and expected completion rates."
    - name: "engagement_level_code"
      expr: engagement_level_code
      comment: "Member engagement level (High, Medium, Low) — key predictor of program outcomes and care gap closure rates."
    - name: "opt_out_reason_code"
      expr: opt_out_reason_code
      comment: "Reason for program opt-out — identifies barriers to care management engagement for program design improvement."
    - name: "status_code"
      expr: status_code
      comment: "Detailed status code for the enrollment record — used for operational workflow management."
  measures:
    - name: "total_active_enrollments"
      expr: SUM(CASE WHEN enrollment_status_code = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of currently active care program enrollments. Primary capacity metric for care management staffing and caseload planning."
    - name: "total_graduated_members"
      expr: SUM(CASE WHEN graduation_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of members who successfully graduated from the care program. Measures program effectiveness and successful care management outcomes."
    - name: "graduation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN graduation_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments resulting in graduation. Core program effectiveness KPI — low graduation rates trigger program design review and intervention strategy changes."
    - name: "opt_out_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN opt_out_reason_code IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments that resulted in opt-out. High opt-out rates signal engagement barriers and drive program redesign decisions."
    - name: "avg_participation_rate"
      expr: AVG(CAST(participation_rate AS DOUBLE))
      comment: "Average member participation rate across enrollments. Measures program engagement intensity — directly correlates with care gap closure and quality measure improvement."
    - name: "high_engagement_enrollment_count"
      expr: SUM(CASE WHEN engagement_level_code = 'High' THEN 1 ELSE 0 END)
      comment: "Count of enrollments with high engagement level. High-engagement members drive disproportionate quality improvement — used to benchmark program design effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_sdoh_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Social Determinants of Health (SDOH) assessment metrics tracking SDOH risk prevalence, referral rates, and assessment completion. SDOH factors drive 40-60% of health outcomes — identifying and addressing them is critical for quality improvement and health equity."
  source: "`vibe_health_insurance_v1`.`care`.`sdoh_assessment`"
  dimensions:
    - name: "sdoh_domain"
      expr: sdoh_domain
      comment: "SDOH domain assessed (Housing, Food, Transportation, Financial) — used to identify prevalent social needs and target community resource investments."
    - name: "risk_level"
      expr: risk_level
      comment: "SDOH risk level (High, Medium, Low) — drives referral urgency and care management intervention intensity."
    - name: "sdoh_assessment_status"
      expr: sdoh_assessment_status
      comment: "Status of the SDOH assessment (Completed, Pending, Refused) — tracks assessment completion rates for quality reporting."
    - name: "follow_up_status"
      expr: follow_up_status
      comment: "Status of SDOH follow-up actions — tracks whether identified social needs are being addressed."
    - name: "referral_made_flag"
      expr: referral_made_flag
      comment: "Whether a community resource referral was made — measures SDOH program action rate and community partnership utilization."
    - name: "screening_tool"
      expr: screening_tool
      comment: "SDOH screening tool used (AHC-HRSN, PRAPARE, etc.) — standardized tools enable benchmarking and regulatory compliance."
  measures:
    - name: "total_sdoh_assessments"
      expr: COUNT(1)
      comment: "Total SDOH assessments completed. Measures SDOH screening program reach — compared against enrolled population to identify screening coverage gaps."
    - name: "high_risk_sdoh_count"
      expr: SUM(CASE WHEN risk_level = 'High' THEN 1 ELSE 0 END)
      comment: "Count of members with high SDOH risk. High SDOH risk members have significantly worse health outcomes and higher utilization — drives community resource investment and care management prioritization."
    - name: "referral_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN referral_made_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SDOH assessments resulting in a community resource referral. Measures SDOH program action rate — low referral rates for high-risk members indicate care coordination gaps."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average SDOH assessment score. Tracks population-level social risk burden — rising scores signal increasing social determinant challenges requiring community investment."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor from SDOH assessments. SDOH factors increasingly inform risk adjustment models — tracking this drives advocacy for SDOH inclusion in CMS risk adjustment methodology."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_snf_stay`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Skilled Nursing Facility stay analytics measuring admission patterns, length of stay, costs, and readmission rates for post-acute care management and cost containment."
  source: "`vibe_health_insurance_v1`.`care`.`snf_stay`"
  dimensions:
    - name: "snf_stay_status"
      expr: snf_stay_status
      comment: "Current status of the SNF stay (admitted, discharged, in-review)."
    - name: "snf_type"
      expr: snf_type
      comment: "Type of SNF facility or stay classification."
    - name: "discharge_destination"
      expr: discharge_destination
      comment: "Destination upon SNF discharge (home, hospital, LTAC, hospice) for transition planning."
    - name: "discharge_planning_status"
      expr: discharge_planning_status
      comment: "Status of discharge planning for the SNF stay."
    - name: "readmission_within_30_days"
      expr: CAST(readmission_within_30_days AS STRING)
      comment: "Whether the member was readmitted within 30 days of SNF discharge."
    - name: "readmission_risk_flag"
      expr: CAST(readmission_risk_flag AS STRING)
      comment: "Whether the member is flagged as high risk for readmission."
    - name: "patient_condition_at_admission"
      expr: patient_condition_at_admission
      comment: "Patient condition severity at SNF admission for acuity-based analysis."
    - name: "admission_month"
      expr: DATE_TRUNC('month', admission_timestamp)
      comment: "Month of SNF admission for seasonal and capacity planning analysis."
  measures:
    - name: "total_snf_stays"
      expr: COUNT(1)
      comment: "Total number of SNF stays managed for post-acute care volume tracking."
    - name: "readmissions_within_30_days"
      expr: SUM(CASE WHEN readmission_within_30_days = TRUE THEN 1 ELSE 0 END)
      comment: "Count of 30-day readmissions from SNF, a key quality and cost metric for post-acute care."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount for SNF stays representing post-acute care spend."
    - name: "total_charge_amount"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total charges for SNF stays before adjustments for cost analysis."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(total_adjustment_amount AS DOUBLE))
      comment: "Total adjustment amounts applied to SNF stays for financial reconciliation."
    - name: "avg_net_amount_per_stay"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net payment per SNF stay for cost benchmarking and contract negotiation."
    - name: "avg_hcc_score"
      expr: AVG(CAST(hcc_score AS DOUBLE))
      comment: "Average HCC score of SNF patients indicating population complexity and expected cost."
    - name: "care_gap_flagged_stays"
      expr: SUM(CASE WHEN care_gap_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of SNF stays with associated care gaps for quality measure follow-up."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_snf_stay_management`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Skilled Nursing Facility (SNF) stay metrics tracking readmission risk, length of stay, and financial exposure. SNF stays are high-cost post-acute events — managing readmission risk and length of stay directly drives medical cost trend."
  source: "`vibe_health_insurance_v1`.`care`.`snf_stay`"
  dimensions:
    - name: "snf_stay_status"
      expr: snf_stay_status
      comment: "Current status of the SNF stay (Active, Discharged, Transferred) — primary operational dimension for concurrent review management."
    - name: "snf_type"
      expr: snf_type
      comment: "Type of SNF facility — used to analyze cost and quality variation across facility types."
    - name: "discharge_destination"
      expr: discharge_destination
      comment: "Where the member was discharged to (Home, Hospital, Hospice) — discharge destination predicts readmission risk and drives transition of care planning."
    - name: "readmission_risk_flag"
      expr: readmission_risk_flag
      comment: "Whether the member is flagged as high readmission risk — triggers proactive transition of care interventions."
    - name: "readmission_within_30_days"
      expr: readmission_within_30_days
      comment: "Whether the member was readmitted within 30 days — key quality and cost KPI tracked by CMS and used in Star Ratings."
    - name: "discharge_planning_status"
      expr: discharge_planning_status
      comment: "Status of discharge planning — incomplete discharge planning is a leading indicator of readmission risk."
    - name: "care_gap_flag"
      expr: care_gap_flag
      comment: "Whether a care gap was identified during the SNF stay — drives post-discharge care management outreach."
  measures:
    - name: "total_snf_stays"
      expr: COUNT(1)
      comment: "Total count of SNF stays. Baseline utilization metric for post-acute care management — compared against benchmarks to identify over- or under-utilization."
    - name: "readmission_within_30_days_count"
      expr: SUM(CASE WHEN readmission_within_30_days = TRUE THEN 1 ELSE 0 END)
      comment: "Count of SNF stays resulting in 30-day readmission. Readmissions are a key CMS quality measure and cost driver — high counts trigger care transition program investment."
    - name: "readmission_30_day_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN readmission_within_30_days = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "30-day readmission rate for SNF stays. Core post-acute quality KPI — directly impacts Star Ratings and CMS value-based payment arrangements."
    - name: "total_snf_charges"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total charges across all SNF stays. Primary financial exposure metric for post-acute care — drives network contracting strategy and utilization management investment."
    - name: "avg_snf_charge_per_stay"
      expr: AVG(CAST(total_charge_amount AS DOUBLE))
      comment: "Average charge per SNF stay. Used to benchmark facility cost efficiency and identify high-cost outlier facilities for network management."
    - name: "avg_hcc_score"
      expr: AVG(CAST(hcc_score AS DOUBLE))
      comment: "Average HCC score of members with SNF stays. Higher HCC scores indicate more complex patients — used to risk-adjust SNF utilization rates for fair provider comparisons."
    - name: "high_readmission_risk_count"
      expr: SUM(CASE WHEN readmission_risk_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of SNF stays with high readmission risk flag. Drives proactive transition of care intervention — each prevented readmission saves significant medical cost."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_star_rating_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CMS Star Rating performance metrics tracking star scores, quality bonus eligibility, and measure weights by domain and measurement year. Star Ratings directly determine quality bonus payments and plan marketing positioning."
  source: "`vibe_health_insurance_v1`.`care`.`star_rating_result`"
  dimensions:
    - name: "measurement_year"
      expr: measurement_year
      comment: "CMS measurement year for the star rating — enables year-over-year trend analysis of plan quality performance."
    - name: "star_domain"
      expr: star_domain
      comment: "CMS Star Rating domain (e.g., Drug Plan Quality, Member Experience) — used for domain-level performance analysis and targeted improvement programs."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of health plan (MA-PD, PDP, etc.) — star ratings differ by plan type and affect different member populations."
    - name: "rating_status"
      expr: rating_status
      comment: "Status of the star rating record (Final, Preliminary, Revised) — ensures analysis uses only finalized ratings."
    - name: "improvement_measure_flag"
      expr: improvement_measure_flag
      comment: "Whether the measure is an improvement measure — improvement measures receive bonus weighting in CMS calculations."
    - name: "quality_bonus_eligible"
      expr: quality_bonus_eligible
      comment: "Whether the plan is eligible for CMS quality bonus payments — directly tied to revenue impact of star performance."
    - name: "trend_direction"
      expr: trend_direction
      comment: "Direction of star score trend (Improving, Declining, Stable) — used to identify measures requiring urgent intervention."
  measures:
    - name: "avg_measure_weight"
      expr: AVG(CAST(measure_weight AS DOUBLE))
      comment: "Average weight of measures in the star rating calculation. Higher-weight measures deserve disproportionate quality improvement investment."
    - name: "quality_bonus_eligible_plan_count"
      expr: SUM(CASE WHEN quality_bonus_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of plan-measure combinations eligible for CMS quality bonus payments. Directly tied to revenue — each star above 4.0 triggers significant bonus payment."
    - name: "improvement_measure_count"
      expr: SUM(CASE WHEN improvement_measure_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of improvement measures in the star rating. Improvement measures receive bonus weighting — tracking them separately informs targeted quality investment strategy."
    - name: "declining_measure_count"
      expr: SUM(CASE WHEN trend_direction = 'Declining' THEN 1 ELSE 0 END)
      comment: "Count of measures with a declining trend. Declining measures are the highest-priority targets for quality improvement programs — directly threatens star rating and bonus eligibility."
    - name: "avg_star_rating_impact_score"
      expr: AVG(CAST(cutpoint_4_star AS DOUBLE))
      comment: "Average 4-star cutpoint threshold across measures. Represents the performance level required to achieve 4+ stars — used to set quality improvement targets and assess gap to bonus eligibility."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_star_rating_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medicare Star Ratings performance metrics tracking measure scores, domain ratings, and quality bonus eligibility"
  source: "`vibe_health_insurance_v1`.`care`.`star_rating_result`"
  dimensions:
    - name: "measurement_year"
      expr: measurement_year
      comment: "Star rating measurement year"
    - name: "star_domain"
      expr: star_domain
      comment: "Star rating domain (outcomes, access, process, patient experience)"
    - name: "rating_status"
      expr: rating_status
      comment: "Status of star rating result"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of health plan (MA, MA-PD, PDP)"
    - name: "improvement_measure_flag"
      expr: improvement_measure_flag
      comment: "Flag indicating whether measure is an improvement measure"
    - name: "quality_bonus_eligible"
      expr: quality_bonus_eligible
      comment: "Flag indicating whether plan is eligible for quality bonus payment"
    - name: "trend_direction"
      expr: trend_direction
      comment: "Direction of performance trend (improving, declining, stable)"
    - name: "overall_star_rating"
      expr: overall_star_rating
      comment: "Overall star rating (1-5 stars)"
    - name: "domain_star_score"
      expr: domain_star_score
      comment: "Star score for specific domain"
  measures:
    - name: "Total Star Rating Results"
      expr: COUNT(1)
      comment: "Total number of star rating measure results"
    - name: "Unique Measures"
      expr: COUNT(DISTINCT hedis_measure_id)
      comment: "Distinct count of measures included in star ratings"
    - name: "Quality Bonus Eligible Count"
      expr: SUM(CASE WHEN quality_bonus_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of results eligible for quality bonus payment"
    - name: "Quality Bonus Eligibility Rate"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_bonus_eligible = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of results eligible for quality bonus"
    - name: "Improvement Measures Count"
      expr: SUM(CASE WHEN improvement_measure_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of improvement measures"
    - name: "Average Measure Weight"
      expr: AVG(CAST(measure_weight AS DOUBLE))
      comment: "Average weight of measures in star rating calculation"
    - name: "Average 5-Star Cutpoint"
      expr: AVG(CAST(cutpoint_5_star AS DOUBLE))
      comment: "Average cutpoint threshold for 5-star rating"
    - name: "Average 4-Star Cutpoint"
      expr: AVG(CAST(cutpoint_4_star AS DOUBLE))
      comment: "Average cutpoint threshold for 4-star rating"
    - name: "Average 3-Star Cutpoint"
      expr: AVG(CAST(cutpoint_3_star AS DOUBLE))
      comment: "Average cutpoint threshold for 3-star rating"
    - name: "Five Star Results"
      expr: SUM(CASE WHEN star_score = '5' THEN 1 ELSE 0 END)
      comment: "Count of measures achieving 5-star rating"
    - name: "Four Plus Star Results"
      expr: SUM(CASE WHEN star_score IN ('4', '5') THEN 1 ELSE 0 END)
      comment: "Count of measures achieving 4 or 5 stars"
    - name: "High Performance Rate"
      expr: ROUND(100.0 * SUM(CASE WHEN star_score IN ('4', '5') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measures achieving 4 or 5 stars"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_transition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transition of care analytics measuring care setting transitions, readmission risk, and discharge planning effectiveness for reducing avoidable readmissions."
  source: "`vibe_health_insurance_v1`.`care`.`transition`"
  dimensions:
    - name: "transition_type"
      expr: transition_type
      comment: "Type of care transition (e.g., inpatient-to-home, inpatient-to-SNF, ED-to-home)."
    - name: "transition_status"
      expr: transition_status
      comment: "Current status of the transition (planned, in-progress, completed, cancelled)."
    - name: "from_setting"
      expr: from_setting
      comment: "Care setting the member is transitioning from (e.g., acute inpatient, ED, SNF)."
    - name: "to_setting"
      expr: to_setting
      comment: "Care setting the member is transitioning to (e.g., home, SNF, rehab, LTAC)."
    - name: "readmission_risk_flag"
      expr: CAST(readmission_risk_flag AS STRING)
      comment: "Whether the member is flagged as high risk for readmission within 30 days."
    - name: "is_critical_transition"
      expr: CAST(is_critical_transition AS STRING)
      comment: "Whether the transition is classified as critical requiring intensive coordination."
    - name: "discharge_planning_status"
      expr: discharge_planning_status
      comment: "Status of discharge planning activities for the transition."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the care transition (successful, readmitted, complications, etc.)."
    - name: "transition_month"
      expr: DATE_TRUNC('month', transition_timestamp)
      comment: "Month of the transition event for seasonal and operational trending."
  measures:
    - name: "total_transitions"
      expr: COUNT(1)
      comment: "Total number of care transitions managed across the population."
    - name: "high_readmission_risk_transitions"
      expr: SUM(CASE WHEN readmission_risk_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of transitions flagged as high readmission risk requiring intensive post-discharge follow-up."
    - name: "critical_transitions"
      expr: SUM(CASE WHEN is_critical_transition = TRUE THEN 1 ELSE 0 END)
      comment: "Count of critical transitions requiring immediate and intensive care coordination."
    - name: "toc_plans_completed"
      expr: SUM(CASE WHEN toc_plan_completed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of transitions with completed transition-of-care plans, measuring care coordination thoroughness."
    - name: "avg_readmission_risk_score"
      expr: AVG(CAST(readmission_risk_score AS DOUBLE))
      comment: "Average readmission risk score across transitions for population risk stratification."
    - name: "care_gap_flagged_transitions"
      expr: SUM(CASE WHEN care_gap_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of transitions with associated care gaps requiring quality measure follow-up."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_transition_management`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care transition metrics tracking transition types, readmission risk, and transition of care plan completion. Effective transitions of care reduce readmissions, improve quality scores, and lower post-acute medical costs."
  source: "`vibe_health_insurance_v1`.`care`.`transition`"
  dimensions:
    - name: "transition_type"
      expr: transition_type
      comment: "Type of care transition (Hospital to Home, Hospital to SNF, SNF to Home) — different transition types carry different readmission risk profiles."
    - name: "transition_status"
      expr: transition_status
      comment: "Current status of the transition (Active, Completed, Cancelled) — operational dimension for transition of care workflow management."
    - name: "from_setting"
      expr: from_setting
      comment: "Care setting the member is transitioning from — used to analyze transition patterns and identify high-risk transition pathways."
    - name: "to_setting"
      expr: to_setting
      comment: "Care setting the member is transitioning to — destination setting predicts post-transition resource needs and readmission risk."
    - name: "readmission_risk_flag"
      expr: readmission_risk_flag
      comment: "Whether the member is flagged as high readmission risk at transition — triggers intensive post-discharge follow-up."
    - name: "toc_plan_completed"
      expr: toc_plan_completed
      comment: "Whether the transition of care plan was completed — incomplete TOC plans are a leading indicator of readmission."
    - name: "is_critical_transition"
      expr: is_critical_transition
      comment: "Whether the transition is flagged as clinically critical — drives escalation to senior care coordinators."
  measures:
    - name: "total_transitions"
      expr: COUNT(1)
      comment: "Total count of care transitions. Baseline utilization metric for post-acute care management program sizing."
    - name: "toc_plan_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN toc_plan_completed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transitions with a completed transition of care plan. TOC plan completion is a leading indicator of readmission prevention — directly tied to CMS quality measures and Star Ratings."
    - name: "high_readmission_risk_transition_count"
      expr: SUM(CASE WHEN readmission_risk_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of transitions with high readmission risk. Drives proactive care management intervention — each prevented readmission reduces medical cost and improves quality scores."
    - name: "avg_readmission_risk_score"
      expr: AVG(CAST(readmission_risk_score AS DOUBLE))
      comment: "Average readmission risk score at transition. Used to calibrate transition of care program intensity and identify populations requiring enhanced post-discharge support."
    - name: "critical_transition_count"
      expr: SUM(CASE WHEN is_critical_transition = TRUE THEN 1 ELSE 0 END)
      comment: "Count of clinically critical transitions. Critical transitions require immediate care coordinator intervention — high counts signal capacity constraints in the care management team."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor for transitioning members. Used to risk-adjust transition outcomes for fair comparison across care coordinator performance and network quality assessments."
$$;
