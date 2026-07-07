-- Metric views for domain: utilization | Business: Health Insurance | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_bed_day_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bed Day Review KPIs — measures inpatient day approval rates, LOS benchmark adherence, readmission risk, and regulatory compliance to optimize concurrent UM and reduce avoidable hospital days."
  source: "`vibe_health_insurance_v1`.`utilization`.`bed_day_review`"
  filter: is_active = TRUE
  dimensions:
    - name: "bed_day_review_status"
      expr: bed_day_review_status
      comment: "Current status of the bed day review for workload and pipeline management."
    - name: "approval_decision"
      expr: approval_decision
      comment: "Approval decision for the bed day review (approved, denied, modified) for outcome analysis."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code for denied bed days for root-cause and pattern analysis."
    - name: "readmission_risk_category"
      expr: readmission_risk_category
      comment: "Readmission risk stratification for targeted discharge planning intervention."
    - name: "clinical_criteria_met_flag"
      expr: clinical_criteria_met_flag
      comment: "Whether clinical criteria were met for the bed day, measuring evidence-based UM decision quality."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether the bed day review met regulatory requirements for compliance reporting."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag for critical/complex cases requiring escalated UM attention."
    - name: "review_month"
      expr: DATE_TRUNC('MONTH', review_timestamp)
      comment: "Month of the bed day review for trend analysis."
  measures:
    - name: "total_bed_day_reviews"
      expr: COUNT(1)
      comment: "Total bed day reviews conducted. Baseline concurrent UM throughput metric for staffing and capacity planning."
    - name: "approved_bed_day_count"
      expr: COUNT(CASE WHEN approval_decision = 'Approved' THEN 1 END)
      comment: "Count of approved bed day reviews. Measures authorized inpatient day volume and associated cost liability."
    - name: "denied_bed_day_count"
      expr: COUNT(CASE WHEN approval_decision = 'Denied' THEN 1 END)
      comment: "Count of denied bed day reviews. Measures UM program effectiveness in reducing medically unnecessary inpatient days."
    - name: "bed_day_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_decision = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bed day reviews resulting in approval. Benchmark against clinical criteria standards; high rates may indicate under-utilization of UM."
    - name: "avg_readmission_risk_score"
      expr: AVG(CAST(readmission_risk_score AS DOUBLE))
      comment: "Average readmission risk score across bed day reviews. Drives discharge planning resource allocation decisions."
    - name: "criteria_met_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN clinical_criteria_met_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bed day reviews where clinical criteria were met. NCQA/URAC accreditation metric for evidence-based UM."
    - name: "regulatory_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bed day reviews meeting regulatory requirements. State DOI and CMS compliance metric."
    - name: "social_work_involvement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN social_work_involved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bed day reviews with social work involvement. Measures complex discharge barrier prevalence requiring additional care coordination resources."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_concurrent_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Concurrent Review KPIs — measures real-time inpatient UM effectiveness including LOS management, discharge planning, readmission risk stratification, and benchmark adherence."
  source: "`vibe_health_insurance_v1`.`utilization`.`concurrent_review`"
  filter: is_active = TRUE
  dimensions:
    - name: "concurrent_review_status"
      expr: concurrent_review_status
      comment: "Current status of the concurrent review (open, closed, escalated) for workload management."
    - name: "review_type"
      expr: review_type
      comment: "Type of concurrent review (initial, continued stay, discharge planning) for process segmentation."
    - name: "discharge_destination"
      expr: discharge_destination
      comment: "Planned discharge destination for post-acute care coordination and cost forecasting."
    - name: "readmission_risk_category"
      expr: readmission_risk_category
      comment: "Risk stratification category (low, medium, high) for targeted care management intervention."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag for critical/complex cases requiring escalated UM attention."
    - name: "social_work_involved"
      expr: social_work_involved
      comment: "Flag indicating social work involvement, a proxy for complex discharge barrier cases."
    - name: "review_month"
      expr: DATE_TRUNC('MONTH', review_start_timestamp)
      comment: "Month the concurrent review was initiated for trend analysis."
  measures:
    - name: "total_concurrent_reviews"
      expr: COUNT(1)
      comment: "Total concurrent reviews conducted. Baseline UM throughput metric for staffing and capacity planning."
    - name: "avg_los_benchmark_mean"
      expr: AVG(CAST(los_benchmark_mean AS DOUBLE))
      comment: "Average benchmark LOS across reviewed cases. Used to calibrate UM targets against evidence-based norms."
    - name: "avg_los_benchmark_target"
      expr: AVG(CAST(los_benchmark_target AS DOUBLE))
      comment: "Average target LOS set during concurrent review. Measures UM program's LOS management ambition."
    - name: "avg_readmission_risk_score"
      expr: AVG(CAST(readmission_risk_score AS DOUBLE))
      comment: "Average readmission risk score across reviewed admissions. Elevated scores trigger care transition program enrollment decisions."
    - name: "high_readmission_risk_count"
      expr: COUNT(CASE WHEN readmission_risk_category = 'High' THEN 1 END)
      comment: "Count of cases with high readmission risk. Drives care management resource allocation and post-discharge follow-up investment."
    - name: "high_readmission_risk_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN readmission_risk_category = 'High' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of concurrent reviews with high readmission risk. Benchmark for care management program targeting effectiveness."
    - name: "social_work_involvement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN social_work_involved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of concurrent reviews involving social work. Measures complexity of discharge barrier cases requiring additional resources."
    - name: "critical_case_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Count of critical/complex concurrent review cases. Drives escalation staffing and medical director review workload planning."
    - name: "distinct_members_under_review"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Unique members with active concurrent reviews. Measures UM program reach across the inpatient population."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_episode_of_care`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Episode of Care KPIs — measures total episode cost, clinical outcomes, complication rates, and bundled payment performance to support value-based care and population health management."
  source: "`vibe_health_insurance_v1`.`utilization`.`episode_of_care`"
  filter: is_active = TRUE
  dimensions:
    - name: "classification_or_type"
      expr: classification_or_type
      comment: "Episode classification or type (e.g., cardiac, orthopedic, maternity) for clinical program segmentation."
    - name: "grouper_methodology_code"
      expr: grouper_methodology_code
      comment: "Episode grouper methodology (e.g., ETG, MEG, APR-DRG) for methodology-consistent benchmarking."
    - name: "status_code"
      expr: status_code
      comment: "Current episode status for pipeline and completion analysis."
    - name: "trigger_event_code"
      expr: trigger_event_code
      comment: "Event that triggered the episode (admission, procedure, diagnosis) for root-cause analysis."
    - name: "primary_diagnosis_code"
      expr: primary_diagnosis_code
      comment: "Primary diagnosis driving the episode for clinical pattern analysis."
    - name: "complication_flag"
      expr: complication_flag
      comment: "Whether the episode involved a complication, a key quality and cost driver."
    - name: "prior_authorization_status"
      expr: prior_authorization_status
      comment: "PA status for the episode to analyze authorization compliance and its impact on episode cost."
    - name: "episode_start_month"
      expr: DATE_TRUNC('MONTH', episode_start_date)
      comment: "Month the episode started for trend analysis of episode volume and cost."
    - name: "utilization_review_decision"
      expr: utilization_review_decision
      comment: "UM review decision for the episode for medical necessity outcome analysis."
  measures:
    - name: "total_episodes"
      expr: COUNT(1)
      comment: "Total episodes of care. Baseline volume metric for population health and bundled payment program management."
    - name: "total_episode_cost"
      expr: SUM(CAST(total_episode_cost AS DOUBLE))
      comment: "Total cost across all episodes. Primary financial metric for value-based care program performance and bundled payment reconciliation."
    - name: "avg_episode_cost"
      expr: AVG(CAST(total_episode_cost AS DOUBLE))
      comment: "Average cost per episode. Benchmarked against bundled payment targets to identify over/under-performing episodes."
    - name: "total_charges"
      expr: SUM(CAST(total_charges AS DOUBLE))
      comment: "Total billed charges across all episodes. Used to compute charge-to-cost ratios and negotiate provider contracts."
    - name: "total_payments"
      expr: SUM(CAST(total_payments AS DOUBLE))
      comment: "Total payments made across all episodes. Measures actual financial outflow for episode-based payment programs."
    - name: "total_adjustments"
      expr: SUM(CAST(total_adjustments AS DOUBLE))
      comment: "Total payment adjustments across episodes. Tracks financial corrections and their impact on episode economics."
    - name: "net_amount_due_total"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due across all episodes. Measures outstanding financial liability in the episode portfolio."
    - name: "complication_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN complication_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of episodes with complications. Quality metric tied to provider performance and bundled payment quality gates."
    - name: "avg_severity_score"
      expr: AVG(CAST(severity_score AS DOUBLE))
      comment: "Average episode severity score. Risk-adjusts episode cost comparisons and drives care management intensity decisions."
    - name: "distinct_members_in_episodes"
      expr: COUNT(DISTINCT identity_id)
      comment: "Unique members with episodes of care. Measures population-level episode program reach."
    - name: "bundled_payment_episode_count"
      expr: COUNT(CASE WHEN bundled_payment_episode_id IS NOT NULL THEN 1 END)
      comment: "Count of episodes enrolled in bundled payment arrangements. Tracks VBC program scale and financial risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_inpatient_admission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inpatient Admission KPIs — tracks admission volume, length of stay performance, cost variance, readmission risk, and clinical criteria compliance to drive hospital utilization management."
  source: "`vibe_health_insurance_v1`.`utilization`.`inpatient_admission`"
  filter: is_active = TRUE
  dimensions:
    - name: "admission_type"
      expr: admission_type
      comment: "Type of admission (elective, emergency, urgent) for acuity-based segmentation."
    - name: "admission_status"
      expr: admission_status
      comment: "Current status of the admission (active, discharged, transferred) for census management."
    - name: "discharge_disposition"
      expr: discharge_disposition
      comment: "Post-discharge destination (home, SNF, rehab, expired) for care transition analysis."
    - name: "drg_code"
      expr: drg_code
      comment: "Diagnosis-Related Group code for case-mix and cost benchmarking."
    - name: "primary_diagnosis_code"
      expr: primary_diagnosis_code
      comment: "Primary ICD-10 diagnosis code for clinical pattern analysis."
    - name: "is_readmission"
      expr: is_readmission
      comment: "Flag indicating whether this is a readmission, a key quality and CMS penalty metric."
    - name: "is_critical_care"
      expr: is_critical_care
      comment: "Flag for ICU/critical care admissions, which carry significantly higher cost and resource intensity."
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of admission for trend analysis of inpatient volume and cost."
    - name: "review_decision"
      expr: review_decision
      comment: "UM review decision for the admission (approved, denied, modified) for medical necessity tracking."
  measures:
    - name: "total_admissions"
      expr: COUNT(1)
      comment: "Total inpatient admissions. Baseline volume metric for capacity planning and trend monitoring."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost of all inpatient admissions. Primary financial metric for hospital utilization spend management."
    - name: "total_expected_cost"
      expr: SUM(CAST(expected_cost_amount AS DOUBLE))
      comment: "Total expected/benchmark cost for inpatient admissions. Used to compute cost variance against actuals."
    - name: "avg_actual_cost_per_admission"
      expr: AVG(CAST(actual_cost_amount AS DOUBLE))
      comment: "Average actual cost per inpatient admission. Benchmarked against DRG norms to identify high-cost outliers."
    - name: "cost_variance_total"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE) - CAST(expected_cost_amount AS DOUBLE))
      comment: "Total cost variance (actual minus expected) across all admissions. Negative values indicate cost savings; positive values signal overspend requiring intervention."
    - name: "readmission_count"
      expr: COUNT(CASE WHEN is_readmission = TRUE THEN 1 END)
      comment: "Count of readmissions. CMS Hospital Readmissions Reduction Program metric; excess readmissions trigger Medicare payment penalties."
    - name: "readmission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_readmission = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of admissions that are readmissions. Benchmark against CMS national rates; drives care transition program investment decisions."
    - name: "readmission_within_30_days_count"
      expr: COUNT(CASE WHEN readmission_within_30_days = TRUE THEN 1 END)
      comment: "Count of 30-day readmissions. The standard CMS quality measure window for readmission penalty calculations."
    - name: "los_benchmark_met_count"
      expr: COUNT(CASE WHEN los_benchmark_met_flag = TRUE THEN 1 END)
      comment: "Count of admissions meeting LOS benchmark. Measures UM effectiveness in managing length of stay to evidence-based targets."
    - name: "los_benchmark_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN los_benchmark_met_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of admissions meeting LOS benchmark. Key UM performance indicator; low rates indicate over-utilization of inpatient days."
    - name: "critical_care_admission_count"
      expr: COUNT(CASE WHEN is_critical_care = TRUE THEN 1 END)
      comment: "Count of ICU/critical care admissions. High-cost segment requiring dedicated case management resources."
    - name: "distinct_members_admitted"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Unique members with inpatient admissions. Measures population-level inpatient utilization breadth."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_medical_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical policy coverage and prior authorization requirement tracking — monitors policy status, PA requirements, and coverage limits for UM program configuration and compliance."
  source: "`vibe_health_insurance_v1`.`utilization`.`medical_policy`"
  dimensions:
    - name: "policy_type"
      expr: policy_type
      comment: "Type of medical policy (e.g., coverage, clinical guideline, utilization management)."
    - name: "medical_policy_status"
      expr: medical_policy_status
      comment: "Current status of the medical policy (e.g., active, retired, under review)."
    - name: "clinical_category"
      expr: clinical_category
      comment: "Clinical category of the policy (e.g., surgical, diagnostic, therapeutic, preventive)."
    - name: "is_prior_auth_required"
      expr: CASE WHEN is_prior_auth_required = TRUE THEN 'PA Required' ELSE 'PA Not Required' END
      comment: "Whether prior authorization is required under this policy."
    - name: "is_emergency_covered"
      expr: CASE WHEN is_emergency_covered = TRUE THEN 'Emergency Covered' ELSE 'Emergency Not Covered' END
      comment: "Whether emergency services are covered under this policy."
    - name: "is_experimental_covered"
      expr: CASE WHEN is_experimental_covered = TRUE THEN 'Experimental Covered' ELSE 'Experimental Not Covered' END
      comment: "Whether experimental or investigational services are covered."
    - name: "is_telehealth_covered"
      expr: CASE WHEN is_telehealth_covered = TRUE THEN 'Telehealth Covered' ELSE 'Telehealth Not Covered' END
      comment: "Whether telehealth services are covered under this policy."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the policy (e.g., compliant, non-compliant, pending review)."
    - name: "effective_year"
      expr: YEAR(effective_from)
      comment: "Year the policy became effective."
  measures:
    - name: "total_medical_policies"
      expr: COUNT(1)
      comment: "Total number of medical policies — baseline metric for policy inventory."
    - name: "total_active_policies"
      expr: COUNT(CASE WHEN medical_policy_status = 'active' THEN 1 END)
      comment: "Count of active medical policies — tracks current policy coverage."
    - name: "pa_required_policy_count"
      expr: COUNT(CASE WHEN is_prior_auth_required = TRUE THEN 1 END)
      comment: "Count of policies requiring prior authorization — measures PA program scope."
    - name: "pa_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_prior_auth_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of policies requiring prior authorization — indicates UM program intensity."
    - name: "emergency_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_emergency_covered = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of policies covering emergency services — access and compliance metric."
    - name: "telehealth_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_telehealth_covered = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of policies covering telehealth — tracks telehealth adoption and access."
    - name: "experimental_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_experimental_covered = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of policies covering experimental services — risk and innovation metric."
    - name: "avg_coverage_limit_amount"
      expr: AVG(CAST(coverage_limit_amount AS DOUBLE))
      comment: "Average coverage limit amount across policies — financial exposure metric."
    - name: "total_coverage_limit_amount"
      expr: SUM(CAST(coverage_limit_amount AS DOUBLE))
      comment: "Sum of coverage limit amounts across policies — total financial exposure under policy limits."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_pa_decision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior Authorization Decision KPIs — measures approval/denial outcomes, clinical criteria adherence, and regulatory compliance of PA decisions to support medical management governance."
  source: "`vibe_health_insurance_v1`.`utilization`.`pa_decision`"
  filter: is_active = TRUE
  dimensions:
    - name: "decision_status"
      expr: decision_status
      comment: "Final decision status (Approved, Denied, Partially Approved, Pended) for outcome segmentation."
    - name: "decision_type"
      expr: decision_type
      comment: "Type of decision (initial, appeal, peer-to-peer) to distinguish review pathways."
    - name: "denial_reason_category"
      expr: denial_reason_category
      comment: "High-level category of denial reason for root-cause analysis and regulatory reporting."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Specific denial reason code for granular denial pattern analysis."
    - name: "is_urgent"
      expr: is_urgent
      comment: "Urgent/expedited decision flag for TAT compliance segmentation."
    - name: "criteria_met_flag"
      expr: criteria_met_flag
      comment: "Whether clinical criteria were met, enabling analysis of evidence-based decision rates."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month of decision for trend analysis of approval/denial rates over time."
    - name: "authorization_period_type"
      expr: authorization_period_type
      comment: "Duration type of authorization (single episode, ongoing) for utilization pattern analysis."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether the decision met regulatory TAT and documentation requirements."
  measures:
    - name: "total_pa_decisions"
      expr: COUNT(1)
      comment: "Total PA decisions rendered. Baseline throughput metric for UM operations capacity planning."
    - name: "approval_count"
      expr: COUNT(CASE WHEN decision_status = 'Approved' THEN 1 END)
      comment: "Count of approved PA decisions. Tracks approval volume for financial liability forecasting."
    - name: "denial_count"
      expr: COUNT(CASE WHEN decision_status = 'Denied' THEN 1 END)
      comment: "Count of denied PA decisions. Core regulatory metric monitored by NCQA, URAC, and state DOI."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN decision_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PA decisions that resulted in approval. Benchmark against industry standards; low rates trigger regulatory scrutiny."
    - name: "criteria_met_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN criteria_met_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of decisions where clinical criteria were met. Measures evidence-based decision-making quality."
    - name: "regulatory_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PA decisions meeting all regulatory requirements (TAT, documentation). Critical NCQA/URAC accreditation metric."
    - name: "appeal_eligible_denial_count"
      expr: COUNT(CASE WHEN decision_status = 'Denied' AND appeal_eligibility_flag = TRUE THEN 1 END)
      comment: "Count of denied decisions eligible for appeal. Drives member rights compliance monitoring and appeal workload forecasting."
    - name: "distinct_members_with_decisions"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Unique members receiving PA decisions. Measures breadth of UM program impact on the member population."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_pa_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior Authorization Request KPIs — tracks PA volume, financial exposure, turnaround compliance, and denial patterns to steer medical management and regulatory adherence."
  source: "`vibe_health_insurance_v1`.`utilization`.`pa_request`"
  filter: is_active = TRUE
  dimensions:
    - name: "pa_request_status"
      expr: pa_request_status
      comment: "Current status of the PA request (Pending, Approved, Denied, Withdrawn) for pipeline segmentation."
    - name: "request_type"
      expr: request_type
      comment: "Type of PA request (prospective, concurrent, retrospective) to distinguish review pathways."
    - name: "service_type"
      expr: service_type
      comment: "Clinical service category requested, enabling volume analysis by service line."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code for denied requests, used to identify systemic denial patterns."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the PA was submitted (portal, fax, phone) for operational efficiency analysis."
    - name: "line_of_business"
      expr: service_code
      comment: "Service code acting as a proxy for line-of-business segmentation of PA requests."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month the PA request was submitted, enabling trend analysis over time."
    - name: "is_appealable"
      expr: is_appealable
      comment: "Flag indicating whether a denied request is eligible for appeal, informing member rights compliance."
  measures:
    - name: "total_pa_requests"
      expr: COUNT(1)
      comment: "Total number of PA requests submitted. Baseline volume KPI for capacity planning and trend monitoring."
    - name: "total_estimated_gross_amount"
      expr: SUM(CAST(estimated_gross_amount AS DOUBLE))
      comment: "Total estimated gross dollar value of all PA requests. Measures financial exposure under review."
    - name: "total_estimated_net_amount"
      expr: SUM(CAST(estimated_net_amount AS DOUBLE))
      comment: "Total estimated net dollar value after adjustments. Reflects expected financial liability if all requests are approved."
    - name: "avg_estimated_net_amount_per_request"
      expr: AVG(CAST(estimated_net_amount AS DOUBLE))
      comment: "Average net dollar value per PA request. Identifies high-cost service categories driving financial risk."
    - name: "total_denied_requests"
      expr: COUNT(CASE WHEN pa_request_status = 'Denied' THEN 1 END)
      comment: "Count of denied PA requests. Key quality and compliance metric tracked by regulators and accreditors."
    - name: "denial_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pa_request_status = 'Denied' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PA requests that were denied. Regulatory and NCQA/URAC benchmark metric; high denial rates trigger audits."
    - name: "duplicate_request_count"
      expr: COUNT(CASE WHEN is_duplicate_request = TRUE THEN 1 END)
      comment: "Count of duplicate PA requests. Operational efficiency metric; high duplication indicates provider portal or workflow issues."
    - name: "total_estimated_adjustment_amount"
      expr: SUM(CAST(estimated_adjustment_amount AS DOUBLE))
      comment: "Total estimated adjustment dollars across all PA requests. Measures financial impact of clinical review decisions."
    - name: "distinct_members_with_pa"
      expr: COUNT(DISTINCT primary_pa_member_subscriber_id)
      comment: "Count of unique members with at least one PA request. Measures breadth of utilization management program reach."
    - name: "distinct_providers_submitting_pa"
      expr: COUNT(DISTINCT primary_pa_provider_id)
      comment: "Count of unique providers submitting PA requests. Identifies provider engagement and potential outliers in PA submission behavior."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_peer_to_peer_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Peer-to-Peer Review KPIs — measures P2P review volume, outcomes, deadline compliance, and regulatory adherence to manage provider relations and UM decision quality."
  source: "`vibe_health_insurance_v1`.`utilization`.`peer_to_peer_review`"
  filter: is_active = TRUE
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Current P2P review status (scheduled, completed, cancelled) for pipeline management."
    - name: "review_outcome"
      expr: review_outcome
      comment: "Outcome of the P2P review (upheld, overturned, modified) for decision quality analysis."
    - name: "state_code"
      expr: state_code
      comment: "State jurisdiction for multi-state P2P regulatory requirement compliance analysis."
    - name: "deadline_compliance_flag"
      expr: deadline_compliance_flag
      comment: "Whether the P2P review was completed within the regulatory deadline."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether the P2P review met all regulatory requirements."
    - name: "review_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month the P2P review was requested for trend analysis."
  measures:
    - name: "total_p2p_reviews"
      expr: COUNT(1)
      comment: "Total peer-to-peer reviews conducted. Baseline metric for UM medical director workload and provider relations management."
    - name: "overturned_decision_count"
      expr: COUNT(CASE WHEN review_outcome = 'Overturned' THEN 1 END)
      comment: "Count of P2P reviews resulting in overturned UM decisions. High rates signal clinical criteria or decision quality issues requiring UM program review."
    - name: "overturn_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN review_outcome = 'Overturned' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of P2P reviews resulting in overturned decisions. NCQA/URAC quality metric; high rates trigger clinical criteria review and medical director training."
    - name: "deadline_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN deadline_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of P2P reviews completed within regulatory deadline. State DOI compliance metric; non-compliance triggers penalties."
    - name: "regulatory_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of P2P reviews meeting all regulatory requirements. Accreditation and state compliance metric."
    - name: "distinct_providers_requesting_p2p"
      expr: COUNT(DISTINCT requesting_provider_id)
      comment: "Unique providers requesting P2P reviews. Identifies high-frequency requesters for targeted provider relations and education programs."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_retrospective_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retrospective Review KPIs — measures post-service medical necessity outcomes, financial recovery, documentation quality, and review deadline compliance to manage retrospective UM program performance."
  source: "`vibe_health_insurance_v1`.`utilization`.`retrospective_review`"
  filter: is_active = TRUE
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Current status of the retrospective review for workload pipeline management."
    - name: "review_type"
      expr: review_type
      comment: "Type of retrospective review (medical necessity, coding, fraud) for program segmentation."
    - name: "medical_necessity_outcome"
      expr: medical_necessity_outcome
      comment: "Medical necessity determination outcome (upheld, overturned, modified) for quality and financial impact analysis."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Denial reason code for retrospective reviews resulting in denial, enabling root-cause analysis."
    - name: "documentation_completeness_flag"
      expr: documentation_completeness_flag
      comment: "Whether documentation was complete at review, a key driver of review outcomes and turnaround time."
    - name: "retro_review_deadline_flag"
      expr: retro_review_deadline_flag
      comment: "Whether the review met its regulatory deadline, a compliance metric for state reporting."
    - name: "review_initiation_month"
      expr: DATE_TRUNC('MONTH', review_initiation_date)
      comment: "Month the retrospective review was initiated for trend analysis."
  measures:
    - name: "total_retrospective_reviews"
      expr: COUNT(1)
      comment: "Total retrospective reviews conducted. Baseline volume metric for retro UM program scope and staffing."
    - name: "total_adjusted_amount"
      expr: SUM(CAST(adjusted_amount AS DOUBLE))
      comment: "Total financial adjustment amount from retrospective reviews. Measures financial recovery and cost avoidance from post-service UM."
    - name: "avg_adjusted_amount_per_review"
      expr: AVG(CAST(adjusted_amount AS DOUBLE))
      comment: "Average financial adjustment per retrospective review. Measures ROI of the retrospective UM program."
    - name: "deadline_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN retro_review_deadline_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of retrospective reviews completed within regulatory deadline. State DOI reporting metric; non-compliance triggers penalties."
    - name: "documentation_complete_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN documentation_completeness_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews with complete documentation. Low rates indicate provider documentation gaps requiring education or outreach."
    - name: "medical_necessity_upheld_count"
      expr: COUNT(CASE WHEN medical_necessity_outcome = 'Upheld' THEN 1 END)
      comment: "Count of reviews where medical necessity was upheld. Validates UM program clinical decision quality."
    - name: "medical_necessity_overturned_count"
      expr: COUNT(CASE WHEN medical_necessity_outcome = 'Overturned' THEN 1 END)
      comment: "Count of reviews where medical necessity determination was overturned. High rates signal UM decision quality issues requiring clinical criteria review."
    - name: "distinct_providers_reviewed"
      expr: COUNT(DISTINCT provider_id)
      comment: "Unique providers with retrospective reviews. Identifies provider outliers for targeted education and contract management."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_tat_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Turnaround Time Compliance metrics measuring adherence to regulatory and contractual decision timeframes - a primary regulatory KPI for health plan UM operations."
  source: "`vibe_health_insurance_v1`.`utilization`.`tat_compliance_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of TAT compliance event being tracked"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the TAT event"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Boolean flag indicating whether TAT was met"
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency classification of the request (standard, urgent, expedited)"
    - name: "review_type"
      expr: review_type
      comment: "Type of utilization review (prospective, concurrent, retrospective)"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "State or regulatory jurisdiction governing the TAT requirement"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (commercial, Medicare, Medicaid) with different TAT standards"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for TAT non-compliance events"
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the TAT compliance event"
  measures:
    - name: "total_tat_events"
      expr: COUNT(1)
      comment: "Total TAT compliance events tracked - baseline for compliance monitoring volume"
    - name: "compliant_event_count"
      expr: SUM(CASE WHEN compliance_flag = true THEN 1 ELSE 0 END)
      comment: "Number of events meeting TAT requirements - numerator for compliance rate calculation"
    - name: "non_compliant_event_count"
      expr: SUM(CASE WHEN compliance_flag = false THEN 1 ELSE 0 END)
      comment: "Number of events failing TAT requirements - triggers corrective action and regulatory reporting"
    - name: "avg_variance_days"
      expr: AVG(CAST(variance_days AS DOUBLE))
      comment: "Average variance in days from TAT standard - positive values indicate late decisions, negative indicate early"
    - name: "avg_variance_hours"
      expr: AVG(CAST(variance_hours AS DOUBLE))
      comment: "Average variance in hours from TAT standard - granular measure for urgent request compliance"
    - name: "max_variance_days"
      expr: MAX(CAST(variance_days AS DOUBLE))
      comment: "Maximum TAT variance in days - identifies worst-case outliers requiring immediate intervention"
    - name: "total_variance_days"
      expr: SUM(CAST(variance_days AS DOUBLE))
      comment: "Total accumulated variance days - aggregate measure of TAT debt across the organization"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_tat_compliance_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "TAT Compliance Event KPIs — measures turnaround time compliance rates, variance from regulatory standards, and root-cause patterns to manage regulatory risk and avoid state/CMS penalties."
  source: "`vibe_health_insurance_v1`.`utilization`.`tat_compliance_event`"
  filter: is_active = TRUE
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of TAT compliance event (PA decision, appeal, notification) for regulatory requirement segmentation."
    - name: "review_type"
      expr: review_type
      comment: "Review type (standard, expedited, concurrent) determining the applicable TAT standard."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Whether the event was compliant or non-compliant with TAT requirements."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency level of the event, which determines the applicable regulatory TAT window."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "State or federal jurisdiction governing the TAT requirement for multi-state compliance reporting."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (Medicare, Medicaid, Commercial) with distinct TAT regulatory requirements."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for non-compliant events, enabling systemic process improvement."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of the TAT compliance event for regulatory reporting period analysis."
    - name: "regulatory_reporting_period"
      expr: regulatory_reporting_period
      comment: "Regulatory reporting period for state/CMS submission alignment."
  measures:
    - name: "total_tat_events"
      expr: COUNT(1)
      comment: "Total TAT compliance events. Baseline volume for regulatory reporting and compliance program scope."
    - name: "compliant_event_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Count of events meeting TAT requirements. Numerator for regulatory compliance rate reporting."
    - name: "non_compliant_event_count"
      expr: COUNT(CASE WHEN compliance_flag = FALSE THEN 1 END)
      comment: "Count of TAT non-compliant events. Directly drives regulatory penalty exposure and corrective action plan requirements."
    - name: "tat_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events meeting TAT requirements. Primary regulatory KPI reported to state DOI and CMS; thresholds typically 95%+."
    - name: "avg_variance_days"
      expr: AVG(CAST(variance_days AS DOUBLE))
      comment: "Average days of variance from TAT standard. Negative = early; positive = late. Measures systemic TAT performance gap."
    - name: "avg_variance_hours"
      expr: AVG(CAST(variance_hours AS DOUBLE))
      comment: "Average hours of variance from TAT standard. Granular metric for expedited review compliance where hours matter."
    - name: "total_variance_days"
      expr: SUM(CAST(variance_days AS DOUBLE))
      comment: "Total accumulated TAT variance days. Measures aggregate regulatory exposure across all non-compliant events."
    - name: "distinct_members_affected_by_tat_breach"
      expr: COUNT(DISTINCT CASE WHEN compliance_flag = FALSE THEN member_identity_id END)
      comment: "Unique members affected by TAT non-compliance. Drives member remediation and regulatory notification obligations."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_um_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "UM Case KPIs — measures utilization management case volume, complexity, priority distribution, and clinical outcomes to optimize UM program performance and resource allocation."
  source: "`vibe_health_insurance_v1`.`utilization`.`um_case`"
  filter: is_active = TRUE
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Type of UM case (PA, concurrent, retrospective, disease management) for program segmentation."
    - name: "case_status"
      expr: case_status
      comment: "Current case status (open, closed, pended, escalated) for workload pipeline management."
    - name: "case_priority"
      expr: case_priority
      comment: "Case priority level for SLA and staffing allocation analysis."
    - name: "priority_level_code"
      expr: priority_level_code
      comment: "Standardized priority code for regulatory TAT compliance segmentation."
    - name: "urgency_code"
      expr: urgency_code
      comment: "Urgency code determining applicable regulatory turnaround time requirements."
    - name: "prior_authorization_status"
      expr: prior_authorization_status
      comment: "PA status associated with the UM case for authorization outcome analysis."
    - name: "primary_diagnosis_code"
      expr: primary_diagnosis_code
      comment: "Primary diagnosis driving the UM case for clinical pattern and cost analysis."
    - name: "case_open_month"
      expr: DATE_TRUNC('MONTH', case_open_date)
      comment: "Month the UM case was opened for trend and capacity planning analysis."
    - name: "disposition_code"
      expr: disposition_code
      comment: "Final case disposition code for outcome analysis and quality reporting."
  measures:
    - name: "total_um_cases"
      expr: COUNT(1)
      comment: "Total UM cases. Baseline volume metric for UM program capacity planning and staffing decisions."
    - name: "open_case_count"
      expr: COUNT(CASE WHEN case_status = 'Open' THEN 1 END)
      comment: "Count of currently open UM cases. Real-time workload metric driving daily staffing and escalation decisions."
    - name: "avg_case_complexity_score"
      expr: AVG(CAST(case_complexity_score AS DOUBLE))
      comment: "Average case complexity score. Drives staffing mix decisions between RN case managers and medical directors."
    - name: "high_complexity_case_count"
      expr: COUNT(CASE WHEN case_complexity_score > 7 THEN 1 END)
      comment: "Count of high-complexity UM cases (score > 7). Identifies cases requiring medical director involvement and additional resources."
    - name: "urgent_case_count"
      expr: COUNT(CASE WHEN urgency_flag = TRUE THEN 1 END)
      comment: "Count of urgent UM cases. Drives expedited review staffing and regulatory TAT compliance monitoring."
    - name: "urgent_case_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN urgency_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of UM cases flagged as urgent. Elevated rates signal member acuity trends and operational pressure on expedited review capacity."
    - name: "appeal_indicator_count"
      expr: COUNT(CASE WHEN appeal_indicator = TRUE THEN 1 END)
      comment: "Count of UM cases with an associated appeal. Measures downstream appeal burden driven by UM decisions."
    - name: "compliance_flag_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of UM cases meeting compliance requirements. Regulatory performance metric for NCQA/URAC accreditation."
    - name: "distinct_members_with_um_cases"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Unique members with UM cases. Measures UM program reach and identifies members with high case frequency."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_um_delegation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "UM Delegation KPIs — measures delegation compliance, audit performance, and oversight effectiveness for delegated UM entities to manage regulatory and contractual risk."
  source: "`vibe_health_insurance_v1`.`utilization`.`um_delegation`"
  filter: is_active = TRUE
  dimensions:
    - name: "delegation_status"
      expr: delegation_status
      comment: "Current status of the delegation arrangement (active, suspended, terminated) for oversight management."
    - name: "delegated_entity_type"
      expr: delegated_entity_type
      comment: "Type of delegated entity (health plan, IPA, medical group) for delegation portfolio segmentation."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the delegation arrangement for regulatory risk monitoring."
    - name: "audit_result_status"
      expr: audit_result_status
      comment: "Result of the most recent delegation audit (pass, conditional, fail) for oversight effectiveness analysis."
    - name: "sub_delegation_allowed_flag"
      expr: sub_delegation_allowed_flag
      comment: "Whether sub-delegation is permitted, a key regulatory risk factor requiring enhanced oversight."
  measures:
    - name: "total_delegation_arrangements"
      expr: COUNT(1)
      comment: "Total UM delegation arrangements. Baseline metric for delegation portfolio governance and oversight resource planning."
    - name: "active_delegation_count"
      expr: COUNT(CASE WHEN delegation_status = 'Active' THEN 1 END)
      comment: "Count of active delegation arrangements. Measures current delegation exposure requiring ongoing oversight."
    - name: "compliant_delegation_count"
      expr: COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END)
      comment: "Count of delegation arrangements in compliance. NCQA/URAC accreditation metric for delegation oversight program."
    - name: "delegation_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delegation arrangements in compliance. Regulatory metric; non-compliant delegations must be remediated or terminated."
    - name: "failed_audit_count"
      expr: COUNT(CASE WHEN audit_result_status = 'Fail' THEN 1 END)
      comment: "Count of delegation arrangements with failed audits. Triggers corrective action plan requirements and potential delegation termination."
    - name: "sub_delegation_arrangement_count"
      expr: COUNT(CASE WHEN sub_delegation_allowed_flag = TRUE THEN 1 END)
      comment: "Count of arrangements permitting sub-delegation. Elevated counts increase regulatory oversight complexity and risk."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_um_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "UM Program KPIs — measures accreditation status, compliance posture, and program coverage across UM programs to support NCQA/URAC accreditation and regulatory governance."
  source: "`vibe_health_insurance_v1`.`utilization`.`um_program`"
  filter: is_active = TRUE
  dimensions:
    - name: "program_type"
      expr: program_type
      comment: "Type of UM program (PA, concurrent review, disease management, case management) for portfolio analysis."
    - name: "um_program_status"
      expr: um_program_status
      comment: "Current program status (active, suspended, terminated) for governance oversight."
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "NCQA/URAC accreditation status of the UM program. Critical for regulatory standing and contract eligibility."
    - name: "accreditation_category"
      expr: accreditation_category
      comment: "Accreditation category (full, provisional, conditional) for compliance risk stratification."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business covered by the UM program (Medicare, Medicaid, Commercial) for regulatory segmentation."
    - name: "gap_analysis_status"
      expr: gap_analysis_status
      comment: "Status of the most recent gap analysis for accreditation readiness monitoring."
    - name: "pa_required_flag"
      expr: pa_required_flag
      comment: "Whether the program requires prior authorization, affecting member access and provider burden."
  measures:
    - name: "total_um_programs"
      expr: COUNT(1)
      comment: "Total UM programs in the portfolio. Baseline metric for governance and accreditation scope management."
    - name: "accredited_program_count"
      expr: COUNT(CASE WHEN accreditation_status = 'Accredited' THEN 1 END)
      comment: "Count of fully accredited UM programs. Directly impacts CMS Star Ratings and commercial contract eligibility."
    - name: "accreditation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN accreditation_status = 'Accredited' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of UM programs with full accreditation. Board-level governance metric for regulatory standing."
    - name: "programs_with_open_gaps_count"
      expr: COUNT(CASE WHEN gap_analysis_status = 'Open' THEN 1 END)
      comment: "Count of UM programs with open gap analysis findings. Drives accreditation remediation prioritization and resource allocation."
    - name: "pa_required_program_count"
      expr: COUNT(CASE WHEN pa_required_flag = TRUE THEN 1 END)
      comment: "Count of UM programs requiring prior authorization. Measures PA program scope and associated member/provider burden."
    - name: "distinct_health_plans_with_um_programs"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Unique health plans with active UM programs. Measures UM program coverage breadth across the plan portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_um_program_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "UM Program Enrollment KPIs — measures member enrollment volume, retention, and opt-in patterns across UM programs to optimize program reach and engagement."
  source: "`vibe_health_insurance_v1`.`utilization`.`um_program_enrollment`"
  filter: is_active = TRUE
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (active, disenrolled, pended) for program census management."
    - name: "enrollment_reason_code"
      expr: enrollment_reason_code
      comment: "Reason for enrollment (referral, auto-enrollment, voluntary) for program intake analysis."
    - name: "opt_in_method_code"
      expr: opt_in_method_code
      comment: "Method by which the member opted into the UM program for channel effectiveness analysis."
    - name: "delegation_flag"
      expr: delegation_flag
      comment: "Whether the enrollment is managed by a delegated entity for oversight segmentation."
    - name: "risk_level"
      expr: risk_level
      comment: "Member risk level at enrollment for program targeting effectiveness analysis."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment for trend analysis of program growth and seasonality."
    - name: "program_name"
      expr: program_name
      comment: "Name of the UM program for cross-program enrollment comparison."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total UM program enrollments. Baseline metric for program reach and capacity planning."
    - name: "active_enrollment_count"
      expr: COUNT(CASE WHEN enrollment_status = 'Active' THEN 1 END)
      comment: "Count of currently active UM program enrollments. Real-time program census for staffing and resource allocation."
    - name: "disenrollment_count"
      expr: COUNT(CASE WHEN disenrollment_date IS NOT NULL THEN 1 END)
      comment: "Count of disenrolled members. Measures program attrition and informs retention strategy decisions."
    - name: "disenrollment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN disenrollment_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments that resulted in disenrollment. High rates signal program engagement or eligibility issues."
    - name: "avg_auto_approval_threshold"
      expr: AVG(CAST(auto_approval_threshold AS DOUBLE))
      comment: "Average auto-approval threshold across UM program enrollments. Measures the financial risk tolerance set for automated UM decisions."
    - name: "delegated_enrollment_count"
      expr: COUNT(CASE WHEN delegation_flag = TRUE THEN 1 END)
      comment: "Count of enrollments managed by delegated entities. Measures delegation program scale and associated oversight requirements."
    - name: "distinct_members_enrolled"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Unique members enrolled in UM programs. Measures unduplicated program reach across the member population."
    - name: "distinct_programs_with_enrollments"
      expr: COUNT(DISTINCT um_program_id)
      comment: "Unique UM programs with active enrollments. Measures breadth of UM program portfolio utilization."
$$;
