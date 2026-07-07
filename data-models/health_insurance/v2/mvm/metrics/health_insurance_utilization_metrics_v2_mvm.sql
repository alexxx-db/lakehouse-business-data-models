-- Metric views for domain: utilization | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-27 10:36:42

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_pa_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior Authorization Request metrics tracking volume, financial exposure, approval/denial patterns, and turnaround performance. Core operational KPIs for UM leadership and medical directors to govern PA program efficiency and cost stewardship."
  source: "`vibe_health_insurance_v1`.`utilization`.`pa_request`"
  filter: is_active = True
  dimensions:
    - name: "pa_request_status"
      expr: pa_request_status
      comment: "Current status of the PA request (e.g., Pending, Approved, Denied, Withdrawn) — primary grouping for pipeline and outcome analysis."
    - name: "request_type"
      expr: request_type
      comment: "Type of PA request (e.g., Prospective, Concurrent, Retrospective) — drives workflow routing and regulatory compliance requirements."
    - name: "service_type"
      expr: service_type
      comment: "Clinical service category being requested — enables utilization pattern analysis by service line."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the PA was submitted (e.g., Portal, Fax, Phone) — informs digital adoption and administrative efficiency initiatives."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Coded reason for denial — critical for identifying systemic denial patterns and appeal risk."
    - name: "patient_gender"
      expr: patient_gender
      comment: "Gender of the patient at time of request — supports equity and population health analytics."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month the PA request was submitted — enables trend analysis of request volume over time."
    - name: "request_year"
      expr: YEAR(request_timestamp)
      comment: "Year the PA request was submitted — supports annual comparison and forecasting."
    - name: "is_duplicate_request"
      expr: is_duplicate_request
      comment: "Flag indicating whether this is a duplicate PA submission — used to measure administrative waste and provider education needs."
    - name: "is_appealable"
      expr: is_appealable
      comment: "Flag indicating whether the PA decision is eligible for appeal — relevant for member rights compliance tracking."
    - name: "clinical_criteria_version"
      expr: clinical_criteria_version
      comment: "Version of clinical criteria applied to the request — enables policy version impact analysis."
  measures:
    - name: "total_pa_requests"
      expr: COUNT(1)
      comment: "Total number of PA requests submitted. Baseline volume KPI used by UM leadership to size staffing, monitor demand trends, and benchmark against prior periods."
    - name: "total_estimated_gross_amount"
      expr: SUM(CAST(estimated_gross_amount AS DOUBLE))
      comment: "Total estimated gross dollar value of all PA requests. Measures the financial exposure under review — a primary cost stewardship metric for the CMO and CFO."
    - name: "total_estimated_net_amount"
      expr: SUM(CAST(estimated_net_amount AS DOUBLE))
      comment: "Total estimated net dollar value after adjustments across all PA requests. Reflects the net financial liability the health plan is managing through the PA program."
    - name: "total_estimated_adjustment_amount"
      expr: SUM(CAST(estimated_adjustment_amount AS DOUBLE))
      comment: "Total estimated adjustment (discount/reduction) applied across PA requests. Quantifies the financial impact of utilization management interventions on gross cost."
    - name: "avg_estimated_net_amount_per_request"
      expr: AVG(CAST(estimated_net_amount AS DOUBLE))
      comment: "Average estimated net cost per PA request. Tracks cost intensity per authorization event — rising averages signal higher-acuity service mix or cost inflation."
    - name: "duplicate_request_count"
      expr: COUNT(CASE WHEN is_duplicate_request = True THEN 1 END)
      comment: "Number of duplicate PA requests submitted. Measures administrative inefficiency and provider portal adoption gaps — high duplication drives unnecessary UM workload."
    - name: "duplicate_request_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_duplicate_request = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PA requests that are duplicates. A key operational quality metric — high rates indicate provider workflow issues or portal usability problems requiring intervention."
    - name: "urgent_request_count"
      expr: COUNT(CASE WHEN request_type = 'Urgent' THEN 1 END)
      comment: "Number of urgent PA requests. Monitors expedited review workload — spikes may indicate member acuity shifts or provider gaming of urgent pathways."
    - name: "distinct_members_requesting_pa"
      expr: COUNT(DISTINCT primary_pa_member_subscriber_id)
      comment: "Count of unique members with at least one PA request. Measures breadth of PA program reach and identifies high-utilizer cohorts for care management outreach."
    - name: "distinct_requesting_providers"
      expr: COUNT(DISTINCT primary_pa_provider_id)
      comment: "Count of unique providers submitting PA requests. Enables provider-level utilization pattern analysis and identification of outlier prescribing or ordering behavior."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_pa_decision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior Authorization Decision outcome metrics measuring approval rates, denial patterns, clinical criteria adherence, and regulatory compliance. Essential for medical directors, compliance officers, and UM program governance."
  source: "`vibe_health_insurance_v1`.`utilization`.`pa_decision`"
  filter: is_active = True
  dimensions:
    - name: "decision_status"
      expr: decision_status
      comment: "Outcome status of the PA decision (e.g., Approved, Denied, Partially Approved, Pending) — primary dimension for outcome rate analysis."
    - name: "decision_type"
      expr: decision_type
      comment: "Type of decision rendered (e.g., Medical Necessity, Administrative) — differentiates clinical from administrative denial drivers."
    - name: "denial_reason_category"
      expr: denial_reason_category
      comment: "High-level category of denial reason — enables root cause analysis of denial patterns across service lines and providers."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Specific coded reason for denial — granular dimension for denial trend analysis and appeal prediction."
    - name: "authorization_period_type"
      expr: authorization_period_type
      comment: "Type of authorization period granted (e.g., Single Episode, Ongoing) — informs authorization duration policy effectiveness."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month the PA decision was rendered — enables trend analysis of decision volume and outcome rates over time."
    - name: "decision_year"
      expr: YEAR(decision_date)
      comment: "Year the PA decision was rendered — supports annual benchmarking of approval and denial rates."
    - name: "is_telehealth"
      expr: is_telehealth
      comment: "Flag indicating whether the authorized service is telehealth — tracks telehealth utilization growth and policy alignment."
    - name: "is_urgent"
      expr: is_urgent
      comment: "Flag indicating whether the decision was made on an urgent/expedited basis — monitors compliance with expedited review timeframe requirements."
    - name: "criteria_met_flag"
      expr: criteria_met_flag
      comment: "Flag indicating whether clinical criteria were met — key dimension for separating criteria-based approvals from exceptions."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag indicating whether the decision met regulatory compliance requirements — critical for NCQA, CMS, and state DOI audit readiness."
    - name: "appeal_eligibility_flag"
      expr: appeal_eligibility_flag
      comment: "Flag indicating whether the decision is eligible for member appeal — relevant for member rights and grievance program monitoring."
  measures:
    - name: "total_pa_decisions"
      expr: COUNT(1)
      comment: "Total number of PA decisions rendered. Baseline throughput KPI for UM operations — used to size reviewer capacity and track decision velocity."
    - name: "approved_decision_count"
      expr: COUNT(CASE WHEN decision_status = 'Approved' THEN 1 END)
      comment: "Number of PA decisions resulting in approval. Tracks approval volume — the primary output of the PA program and a key input to claims cost forecasting."
    - name: "denied_decision_count"
      expr: COUNT(CASE WHEN decision_status = 'Denied' THEN 1 END)
      comment: "Number of PA decisions resulting in denial. Monitors denial volume — high denial rates may signal clinical criteria misalignment or provider education gaps."
    - name: "approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN decision_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PA decisions that result in approval. A primary UM program effectiveness KPI — benchmarked against NCQA standards and peer health plans."
    - name: "denial_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN decision_status = 'Denied' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PA decisions that result in denial. Monitored by CMO and compliance teams — outlier rates trigger regulatory scrutiny and member grievance risk."
    - name: "criteria_met_approval_count"
      expr: COUNT(CASE WHEN criteria_met_flag = True AND decision_status = 'Approved' THEN 1 END)
      comment: "Number of approvals where clinical criteria were explicitly met. Measures evidence-based decision-making adherence — a core NCQA UM accreditation metric."
    - name: "criteria_met_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN criteria_met_flag = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PA decisions where clinical criteria were met. Tracks clinical rigor of the UM program — low rates indicate criteria application inconsistency."
    - name: "regulatory_non_compliance_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = False THEN 1 END)
      comment: "Number of PA decisions flagged as non-compliant with regulatory requirements. A zero-tolerance KPI for compliance officers — any non-zero value triggers immediate remediation."
    - name: "regulatory_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_compliance_flag = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PA decisions meeting all regulatory compliance requirements. Directly tied to CMS, NCQA, and state DOI audit outcomes — must be maintained at or near 100%."
    - name: "appeal_eligible_denial_count"
      expr: COUNT(CASE WHEN appeal_eligibility_flag = True AND decision_status = 'Denied' THEN 1 END)
      comment: "Number of denied decisions eligible for member appeal. Quantifies the appeal pipeline risk — high volumes drive grievance operations costs and member satisfaction risk."
    - name: "distinct_members_with_decisions"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Count of unique members receiving PA decisions. Measures breadth of UM program impact on the member population — used in population health and care management targeting."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_inpatient_admission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inpatient admission utilization metrics covering cost, length of stay benchmarking, readmission rates, and authorization compliance. Core KPIs for CMO, CFO, and hospital contracting teams to manage inpatient cost and quality."
  source: "`vibe_health_insurance_v1`.`utilization`.`inpatient_admission`"
  filter: is_active = True
  dimensions:
    - name: "admission_type"
      expr: admission_type
      comment: "Type of inpatient admission (e.g., Elective, Emergency, Urgent) — primary dimension for cost and LOS benchmarking by acuity."
    - name: "admission_status"
      expr: admission_status
      comment: "Current status of the admission (e.g., Active, Discharged, Transferred) — used to filter active vs. closed admissions in operational dashboards."
    - name: "discharge_disposition"
      expr: discharge_disposition
      comment: "Destination at discharge (e.g., Home, SNF, Rehab, Expired) — critical for post-acute cost forecasting and care transition quality measurement."
    - name: "drg_code"
      expr: drg_code
      comment: "Diagnosis Related Group code — enables cost and LOS benchmarking by clinical episode type, the standard unit of inpatient payment analysis."
    - name: "primary_diagnosis_code"
      expr: primary_diagnosis_code
      comment: "Primary ICD diagnosis code for the admission — supports clinical population segmentation and disease burden analysis."
    - name: "payer_authorization_status"
      expr: payer_authorization_status
      comment: "Authorization status assigned by the payer — tracks PA compliance for inpatient admissions and identifies unauthorized admission risk."
    - name: "review_decision"
      expr: review_decision
      comment: "UM review decision for the admission (e.g., Approved, Denied, Pending) — links clinical review outcomes to financial exposure."
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of admission — enables trend analysis of inpatient volume and cost over time."
    - name: "admission_year"
      expr: YEAR(admission_date)
      comment: "Year of admission — supports annual inpatient utilization benchmarking and budget variance analysis."
    - name: "is_readmission"
      expr: is_readmission
      comment: "Flag indicating whether this admission is a readmission — readmission rate is a CMS quality measure and a key cost driver."
    - name: "readmission_within_30_days"
      expr: readmission_within_30_days
      comment: "Flag indicating readmission within 30 days of prior discharge — the standard CMS all-cause readmission quality metric."
    - name: "is_critical_care"
      expr: is_critical_care
      comment: "Flag indicating ICU/critical care admission — critical care admissions carry significantly higher cost and require separate benchmarking."
    - name: "los_benchmark_met_flag"
      expr: los_benchmark_met_flag
      comment: "Flag indicating whether the actual LOS met the benchmark target — primary efficiency metric for concurrent review and case management programs."
  measures:
    - name: "total_admissions"
      expr: COUNT(1)
      comment: "Total number of inpatient admissions. Baseline volume KPI for inpatient utilization — used to track admission trends, benchmark against prior periods, and size case management capacity."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost of all inpatient admissions. Primary financial KPI for inpatient cost management — directly tied to medical loss ratio and budget performance."
    - name: "total_expected_cost"
      expr: SUM(CAST(expected_cost_amount AS DOUBLE))
      comment: "Total expected (benchmark) cost across all inpatient admissions. Used as the denominator in cost efficiency analysis — variance from actual cost drives case management ROI measurement."
    - name: "avg_actual_cost_per_admission"
      expr: AVG(CAST(actual_cost_amount AS DOUBLE))
      comment: "Average actual cost per inpatient admission. Tracks cost intensity per episode — rising averages signal acuity mix shifts, coding changes, or contract performance issues."
    - name: "cost_variance_total"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE) - CAST(expected_cost_amount AS DOUBLE))
      comment: "Total cost variance (actual minus expected) across all admissions. Positive values indicate cost overruns vs. benchmark — the primary ROI metric for UM and case management programs."
    - name: "readmission_30_day_count"
      expr: COUNT(CASE WHEN readmission_within_30_days = True THEN 1 END)
      comment: "Number of admissions that are 30-day readmissions. CMS quality measure — high counts trigger quality improvement initiatives and may affect value-based contract performance."
    - name: "readmission_30_day_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN readmission_within_30_days = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "30-day all-cause readmission rate. A top-tier CMS and NCQA quality KPI — directly tied to value-based payment penalties, Star Ratings, and hospital contract performance."
    - name: "los_benchmark_met_count"
      expr: COUNT(CASE WHEN los_benchmark_met_flag = True THEN 1 END)
      comment: "Number of admissions where LOS met the benchmark target. Measures concurrent review program effectiveness — benchmark adherence reduces unnecessary inpatient days and cost."
    - name: "los_benchmark_met_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN los_benchmark_met_flag = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of admissions meeting LOS benchmark. Key efficiency KPI for the concurrent review program — low rates indicate opportunities for earlier discharge planning intervention."
    - name: "critical_care_admission_count"
      expr: COUNT(CASE WHEN is_critical_care = True THEN 1 END)
      comment: "Number of critical care (ICU) admissions. Tracks high-cost, high-acuity utilization — critical care mix drives disproportionate cost and requires dedicated case management resources."
    - name: "critical_care_admission_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_critical_care = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of admissions classified as critical care. Monitors acuity mix trends — rising rates signal population health deterioration or admission criteria changes."
    - name: "distinct_members_admitted"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Count of unique members with inpatient admissions. Measures inpatient utilization breadth — high-utilizer identification drives care management program targeting and cost reduction."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_concurrent_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Concurrent review metrics for active inpatient cases, tracking LOS benchmarking, readmission risk stratification, discharge planning effectiveness, and review cycle performance. Used by UM nurses, case managers, and medical directors to manage inpatient stays in real time."
  source: "`vibe_health_insurance_v1`.`utilization`.`concurrent_review`"
  filter: is_active = True
  dimensions:
    - name: "concurrent_review_status"
      expr: concurrent_review_status
      comment: "Current status of the concurrent review (e.g., Open, Closed, Escalated) — primary operational dimension for active case management dashboards."
    - name: "review_type"
      expr: review_type
      comment: "Type of concurrent review conducted (e.g., Initial, Continued Stay, Discharge Planning) — differentiates review stages in the inpatient UM workflow."
    - name: "discharge_destination"
      expr: discharge_destination
      comment: "Planned or actual discharge destination (e.g., Home, SNF, Rehab) — drives post-acute cost forecasting and care transition planning."
    - name: "readmission_risk_category"
      expr: readmission_risk_category
      comment: "Risk stratification category for readmission (e.g., Low, Medium, High) — used to prioritize case management intervention intensity."
    - name: "benchmark_source"
      expr: benchmark_source
      comment: "Source of the LOS benchmark used (e.g., Milliman, InterQual) — enables benchmark methodology comparison and standardization analysis."
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of the associated inpatient admission — enables trend analysis of concurrent review volume and outcomes over time."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the case is flagged as critical — critical cases require escalated review and physician advisor involvement."
    - name: "social_work_involved"
      expr: social_work_involved
      comment: "Flag indicating social work involvement in the case — tracks complex discharge barrier cases requiring multidisciplinary intervention."
  measures:
    - name: "total_concurrent_reviews"
      expr: COUNT(1)
      comment: "Total number of concurrent reviews conducted. Baseline workload KPI for UM nursing staff — used to size concurrent review capacity and track review velocity."
    - name: "avg_readmission_risk_score"
      expr: AVG(CAST(readmission_risk_score AS DOUBLE))
      comment: "Average readmission risk score across reviewed cases. Tracks population-level readmission risk — rising averages signal need for intensified discharge planning and post-acute coordination."
    - name: "avg_los_benchmark_target"
      expr: AVG(CAST(los_benchmark_target AS DOUBLE))
      comment: "Average benchmark target LOS across concurrent review cases. Establishes the expected efficiency baseline — compared against actual LOS to measure UM program performance."
    - name: "avg_los_benchmark_mean"
      expr: AVG(CAST(los_benchmark_mean AS DOUBLE))
      comment: "Average benchmark mean LOS across concurrent review cases. Provides the population-level LOS reference point for case-level variance analysis."
    - name: "high_readmission_risk_count"
      expr: COUNT(CASE WHEN readmission_risk_category = 'High' THEN 1 END)
      comment: "Number of concurrent review cases with high readmission risk. Identifies the highest-priority cohort for post-discharge care coordination — directly tied to 30-day readmission rate reduction programs."
    - name: "high_readmission_risk_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN readmission_risk_category = 'High' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of concurrent review cases classified as high readmission risk. Monitors population acuity trends — rising rates require proactive care management resource allocation."
    - name: "critical_case_count"
      expr: COUNT(CASE WHEN is_critical = True THEN 1 END)
      comment: "Number of concurrent review cases flagged as critical. Tracks escalated case volume — high counts indicate complex case mix requiring physician advisor and specialist involvement."
    - name: "social_work_case_count"
      expr: COUNT(CASE WHEN social_work_involved = True THEN 1 END)
      comment: "Number of cases with social work involvement. Measures complex discharge barrier prevalence — social work cases have longer LOS and higher post-acute cost, requiring targeted intervention."
    - name: "social_work_involvement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN social_work_involved = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of concurrent review cases requiring social work involvement. Tracks social determinants of health impact on discharge complexity — informs care management staffing and community resource investment."
    - name: "distinct_members_under_review"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Count of unique members with active concurrent reviews. Measures the breadth of inpatient case management program reach — used to calculate per-member case management intensity."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_um_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Utilization Management case metrics covering case complexity, turnaround performance, compliance, and disposition outcomes. Strategic KPIs for UM program directors, compliance officers, and care management leadership to govern UM case quality and efficiency."
  source: "`vibe_health_insurance_v1`.`utilization`.`um_case`"
  filter: is_active = True
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the UM case (e.g., Open, Closed, Escalated, Pending) — primary operational dimension for case pipeline management."
    - name: "case_type"
      expr: case_type
      comment: "Type of UM case (e.g., Inpatient, Outpatient, Behavioral Health) — enables workload analysis and resource allocation by case category."
    - name: "case_priority"
      expr: case_priority
      comment: "Priority level assigned to the UM case (e.g., Routine, Urgent, Emergent) — drives SLA compliance monitoring and reviewer assignment logic."
    - name: "case_severity"
      expr: case_severity
      comment: "Clinical severity classification of the UM case — used to stratify case complexity and benchmark resource utilization against severity-adjusted norms."
    - name: "disposition_code"
      expr: disposition_code
      comment: "Final disposition code for the UM case — the primary outcome dimension for case resolution analysis and program effectiveness measurement."
    - name: "primary_diagnosis_code"
      expr: primary_diagnosis_code
      comment: "Primary ICD diagnosis code for the UM case — enables disease-level utilization pattern analysis and clinical program targeting."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Coded reason for case denial — supports root cause analysis of denial patterns and provider education program design."
    - name: "case_open_month"
      expr: DATE_TRUNC('MONTH', case_open_date)
      comment: "Month the UM case was opened — enables trend analysis of case volume and complexity over time."
    - name: "case_open_year"
      expr: YEAR(case_open_date)
      comment: "Year the UM case was opened — supports annual UM program performance benchmarking."
    - name: "urgency_flag"
      expr: urgency_flag
      comment: "Flag indicating whether the case requires urgent handling — monitors expedited review compliance with regulatory timeframe requirements."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating whether the UM case met all compliance requirements — critical for NCQA accreditation and regulatory audit readiness."
    - name: "appeal_indicator"
      expr: appeal_indicator
      comment: "Flag indicating whether the case involves an appeal — tracks appeal volume and its impact on UM operations and member satisfaction."
  measures:
    - name: "total_um_cases"
      expr: COUNT(1)
      comment: "Total number of UM cases. Baseline workload KPI for UM program management — used to size staffing, track demand trends, and benchmark against prior periods."
    - name: "avg_case_complexity_score"
      expr: AVG(CAST(case_complexity_score AS DOUBLE))
      comment: "Average case complexity score across all UM cases. Tracks population-level case complexity trends — rising scores indicate higher-acuity member mix requiring more intensive UM resources."
    - name: "total_case_complexity_score"
      expr: SUM(CAST(case_complexity_score AS DOUBLE))
      comment: "Total case complexity score across all UM cases. Aggregate complexity burden metric — used to normalize workload allocation across UM coordinators and teams."
    - name: "compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of UM cases meeting all compliance requirements. A top-tier regulatory KPI — must be maintained near 100% to satisfy NCQA, CMS, and state DOI standards. Non-compliance triggers audit risk."
    - name: "non_compliant_case_count"
      expr: COUNT(CASE WHEN compliance_flag = False THEN 1 END)
      comment: "Number of UM cases with compliance failures. Zero-tolerance metric for compliance officers — any non-zero value triggers immediate root cause investigation and corrective action."
    - name: "appeal_case_count"
      expr: COUNT(CASE WHEN appeal_indicator = True THEN 1 END)
      comment: "Number of UM cases involving an appeal. Tracks appeal program volume — high appeal rates signal denial quality issues and drive grievance operations cost and member satisfaction risk."
    - name: "appeal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_indicator = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of UM cases that result in an appeal. Monitors denial quality and member advocacy activity — rising appeal rates are a leading indicator of UM program quality deterioration."
    - name: "urgent_case_count"
      expr: COUNT(CASE WHEN urgency_flag = True THEN 1 END)
      comment: "Number of UM cases flagged as urgent. Monitors expedited review workload — regulatory timeframes for urgent cases are shorter and non-compliance carries significant penalty risk."
    - name: "urgent_case_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN urgency_flag = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of UM cases classified as urgent. Tracks acuity mix of the UM pipeline — high urgent rates strain reviewer capacity and increase regulatory compliance risk."
    - name: "distinct_members_in_um"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Count of unique members with active UM cases. Measures UM program reach — used to calculate per-member UM intensity and identify high-utilizer cohorts for care management escalation."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_auth_service_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Authorized service line metrics tracking authorized quantities, costs, approval/denial outcomes, and service category utilization. Enables medical directors and finance teams to govern authorized benefit consumption and identify cost and quality outliers."
  source: "`vibe_health_insurance_v1`.`utilization`.`auth_service_line`"
  filter: is_active = True
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Status of the service line authorization (e.g., Approved, Denied, Partially Approved) — primary outcome dimension for authorization analysis."
    - name: "service_category"
      expr: service_category
      comment: "Clinical service category of the authorized service line — enables utilization and cost analysis by service type (e.g., Behavioral Health, Oncology, Surgical)."
    - name: "cpt_code"
      expr: cpt_code
      comment: "CPT procedure code for the authorized service — enables procedure-level utilization benchmarking and cost analysis."
    - name: "place_of_service"
      expr: place_of_service
      comment: "Setting where the authorized service will be delivered (e.g., Inpatient, Outpatient, Office) — drives site-of-care optimization analysis."
    - name: "denial_reason"
      expr: denial_reason
      comment: "Reason for service line denial — enables root cause analysis of denial patterns at the procedure and service category level."
    - name: "is_emergency"
      expr: is_emergency
      comment: "Flag indicating whether the service is emergency-related — emergency authorizations have different clinical and financial profiles requiring separate benchmarking."
    - name: "is_experimental"
      expr: is_experimental
      comment: "Flag indicating whether the service is classified as experimental — experimental service authorizations carry heightened clinical and legal risk."
    - name: "is_partial_approval"
      expr: is_partial_approval
      comment: "Flag indicating whether the authorization was partially approved — partial approvals represent a distinct outcome category with member and provider impact."
    - name: "authorized_start_month"
      expr: DATE_TRUNC('MONTH', authorized_start_date)
      comment: "Month the authorization period begins — enables trend analysis of authorized service volume and cost over time."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the authorized quantity (e.g., Days, Visits, Units) — required for meaningful quantity aggregation and benchmarking."
  measures:
    - name: "total_authorized_service_lines"
      expr: COUNT(1)
      comment: "Total number of authorized service lines. Baseline volume KPI for authorization program management — tracks authorization workload and benefit consumption breadth."
    - name: "total_authorized_price"
      expr: SUM(CAST(authorized_price AS DOUBLE))
      comment: "Total authorized dollar value across all service lines. Primary financial exposure metric — represents the maximum liability the health plan has committed to through authorizations."
    - name: "avg_authorized_price_per_line"
      expr: AVG(CAST(authorized_price AS DOUBLE))
      comment: "Average authorized price per service line. Tracks cost intensity per authorization — rising averages signal higher-cost service mix or pricing trend changes requiring contract review."
    - name: "total_authorized_quantity"
      expr: SUM(CAST(authorized_quantity AS DOUBLE))
      comment: "Total authorized quantity (visits, days, units) across all service lines. Measures volume of authorized benefit consumption — used to benchmark against plan design limits and actuarial assumptions."
    - name: "avg_authorized_quantity_per_line"
      expr: AVG(CAST(authorized_quantity AS DOUBLE))
      comment: "Average authorized quantity per service line. Tracks utilization intensity per authorization event — outlier values identify over-authorization patterns requiring clinical review."
    - name: "partial_approval_count"
      expr: COUNT(CASE WHEN is_partial_approval = True THEN 1 END)
      comment: "Number of service lines receiving partial approval. Tracks the volume of modified authorizations — high partial approval rates may indicate clinical criteria misalignment or provider documentation gaps."
    - name: "partial_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_partial_approval = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service line authorizations that are partially approved. Monitors authorization modification patterns — high rates drive member and provider satisfaction issues and appeal risk."
    - name: "experimental_service_authorization_count"
      expr: COUNT(CASE WHEN is_experimental = True THEN 1 END)
      comment: "Number of authorizations for experimental services. Tracks high-risk authorization volume — experimental service approvals carry legal, clinical, and financial risk requiring medical director oversight."
    - name: "distinct_members_authorized"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Count of unique members with authorized service lines. Measures authorization program reach — used to calculate per-member authorization intensity and identify high-utilizer cohorts."
$$;