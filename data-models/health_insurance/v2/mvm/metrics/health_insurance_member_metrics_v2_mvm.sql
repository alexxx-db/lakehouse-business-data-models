-- Metric views for domain: member | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-27 10:36:42

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_subscriber`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core member subscriber KPIs tracking enrollment health, demographic composition, risk profile, and financial exposure across the active subscriber population. Used by VP of Membership, Chief Actuary, and CMO for strategic workforce and risk decisions."
  source: "`vibe_health_insurance_v1`.`member`.`subscriber`"
  dimensions:
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (e.g., Commercial, Medicare, Medicaid) for segmenting subscriber population by product type."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage held by the subscriber (e.g., HMO, PPO, EPO) for plan-mix analysis."
    - name: "subscriber_status"
      expr: subscriber_status
      comment: "Current enrollment status of the subscriber (e.g., Active, Terminated, Suspended) for membership lifecycle tracking."
    - name: "gender"
      expr: gender
      comment: "Subscriber gender for demographic segmentation and health equity reporting."
    - name: "race_ethnicity"
      expr: race_ethnicity
      comment: "Race and ethnicity classification for health equity and HEDIS demographic reporting."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Channel or source through which the subscriber enrolled (e.g., Employer, Exchange, Direct) for acquisition analysis."
    - name: "disability_status"
      expr: disability_status
      comment: "Disability classification of the subscriber for care management segmentation and regulatory reporting."
    - name: "tobacco_use_status"
      expr: tobacco_use_status
      comment: "Tobacco use indicator for actuarial risk stratification and wellness program targeting."
    - name: "language_preference"
      expr: language_preference
      comment: "Preferred language of the subscriber for member communication and health literacy program planning."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the subscriber record is currently active."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month of subscriber effective start date for enrollment trend analysis."
    - name: "termination_date_month"
      expr: DATE_TRUNC('MONTH', termination_date)
      comment: "Month of subscriber termination date for disenrollment trend analysis."
  measures:
    - name: "total_active_subscribers"
      expr: COUNT(CASE WHEN is_active = TRUE THEN subscriber_id END)
      comment: "Total count of currently active subscribers. Core membership census KPI used in board reporting and premium revenue forecasting."
    - name: "avg_hcc_risk_score"
      expr: AVG(CAST(hcc_score AS DOUBLE))
      comment: "Average Hierarchical Condition Category (HCC) risk score across subscribers. Drives CMS risk adjustment revenue projections and actuarial pricing decisions."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor (RAF) across the subscriber population. Directly informs CMS risk adjustment payment calculations and financial forecasting."
    - name: "total_annual_income_sum"
      expr: SUM(CAST(annual_income AS DOUBLE))
      comment: "Sum of reported annual income across subscribers. Used for subsidy eligibility analysis, income-based premium tier modeling, and Medicaid/CHIP threshold reporting."
    - name: "avg_annual_income"
      expr: AVG(CAST(annual_income AS DOUBLE))
      comment: "Average annual income of subscribers. Supports actuarial segmentation, subsidy program design, and social determinants of health (SDOH) analysis."
    - name: "deceased_subscriber_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_deceased = TRUE THEN subscriber_id END) / NULLIF(COUNT(subscriber_id), 0), 2)
      comment: "Percentage of subscriber records flagged as deceased. Monitors data quality and supports timely disenrollment processing to prevent improper payments."
    - name: "electronic_communication_consent_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_to_electronic_communication = TRUE THEN subscriber_id END) / NULLIF(COUNT(subscriber_id), 0), 2)
      comment: "Percentage of subscribers who have consented to electronic communication. Drives digital engagement strategy and cost-to-serve reduction initiatives."
    - name: "veteran_subscriber_count"
      expr: COUNT(CASE WHEN veteran_status = TRUE THEN subscriber_id END)
      comment: "Count of subscribers identified as veterans. Supports targeted care management programs and VA coordination-of-benefits reporting."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across subscriber records. Monitors master data integrity and triggers remediation workflows when below threshold."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy-level financial and coverage KPIs tracking premium revenue, deductible exposure, out-of-pocket liability, and renewal health. Used by CFO, Chief Actuary, and VP of Product for pricing, renewal, and financial risk decisions."
  source: "`vibe_health_insurance_v1`.`member`.`policy`"
  dimensions:
    - name: "policy_status"
      expr: policy_status
      comment: "Current status of the policy (e.g., Active, Terminated, Lapsed) for portfolio health monitoring."
    - name: "policy_type"
      expr: policy_type
      comment: "Type of policy (e.g., Individual, Group, Family) for product mix and actuarial segmentation."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage type (e.g., HMO, PPO, HDHP) for plan design performance analysis."
    - name: "coverage_status"
      expr: coverage_status
      comment: "Current coverage status for active membership and lapse rate tracking."
    - name: "coverage_limit_type"
      expr: coverage_limit_type
      comment: "Type of coverage limit applied to the policy for benefit design analysis."
    - name: "premium_frequency"
      expr: premium_frequency
      comment: "Frequency of premium billing (e.g., Monthly, Quarterly, Annual) for cash flow and billing operations analysis."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Renewal status of the policy for retention and lapse forecasting."
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for policy termination for churn root-cause analysis and retention strategy."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the policy is currently active."
    - name: "coverage_start_date_month"
      expr: DATE_TRUNC('MONTH', coverage_start_date)
      comment: "Month of coverage start for enrollment cohort and seasonality analysis."
    - name: "coverage_end_date_month"
      expr: DATE_TRUNC('MONTH', coverage_end_date)
      comment: "Month of coverage end for lapse and termination trend analysis."
    - name: "renewal_date_month"
      expr: DATE_TRUNC('MONTH', renewal_date)
      comment: "Month of policy renewal for renewal pipeline and retention forecasting."
  measures:
    - name: "total_active_policies"
      expr: COUNT(CASE WHEN is_active = TRUE THEN policy_id END)
      comment: "Total count of currently active policies. Core portfolio census KPI for revenue forecasting and capacity planning."
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium amount across all policies. Primary revenue KPI used in financial reporting, board decks, and actuarial pricing reviews."
    - name: "avg_premium_amount"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium per policy. Tracks pricing trends and supports competitive benchmarking and rate adequacy analysis."
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible exposure across all policies. Informs member cost-sharing liability and actuarial loss ratio projections."
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average deductible per policy. Supports plan design benchmarking and member affordability analysis."
    - name: "total_out_of_pocket_max"
      expr: SUM(CAST(out_of_pocket_max_amount AS DOUBLE))
      comment: "Total out-of-pocket maximum exposure across all policies. Critical for actuarial stop-loss modeling and catastrophic risk assessment."
    - name: "avg_out_of_pocket_max"
      expr: AVG(CAST(out_of_pocket_max_amount AS DOUBLE))
      comment: "Average out-of-pocket maximum per policy. Benchmarks member financial protection levels across plan types."
    - name: "total_coverage_limit_amount"
      expr: SUM(CAST(coverage_limit_amount AS DOUBLE))
      comment: "Total coverage limit amount across all policies. Supports aggregate liability exposure reporting and reinsurance threshold analysis."
    - name: "total_renewal_premium_amount"
      expr: SUM(CAST(renewal_premium_amount AS DOUBLE))
      comment: "Total renewal premium amount across policies up for renewal. Drives renewal revenue forecasting and retention investment decisions."
    - name: "avg_renewal_premium_amount"
      expr: AVG(CAST(renewal_premium_amount AS DOUBLE))
      comment: "Average renewal premium per policy. Tracks year-over-year premium trend and rate change impact."
    - name: "renewal_deductible_change_avg"
      expr: AVG(CAST(renewal_deductible_amount AS DOUBLE) - CAST(deductible_amount AS DOUBLE))
      comment: "Average change in deductible amount at renewal. Monitors benefit design shifts and member cost-sharing trend at renewal cycle."
    - name: "policy_termination_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN policy_status = 'Terminated' THEN policy_id END) / NULLIF(COUNT(policy_id), 0), 2)
      comment: "Percentage of policies in terminated status. Key retention and churn KPI used in executive dashboards and renewal strategy reviews."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_eligibility_span`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Eligibility span KPIs measuring coverage continuity, active eligibility volume, and data quality across member eligibility periods. Used by VP of Enrollment Operations and Compliance for CMS eligibility reporting and gap analysis."
  source: "`vibe_health_insurance_v1`.`member`.`eligibility_span`"
  dimensions:
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the eligibility span is currently active."
    - name: "record_status"
      expr: record_status
      comment: "Processing status of the eligibility span record for operational data quality monitoring."
    - name: "record_source_system"
      expr: record_source_system
      comment: "Source system that originated the eligibility span record for data lineage and reconciliation."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month of eligibility span start for enrollment trend and seasonality analysis."
    - name: "effective_end_date_month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
      comment: "Month of eligibility span end for coverage termination trend analysis."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year of eligibility span start for annual enrollment cohort reporting."
  measures:
    - name: "total_active_eligibility_spans"
      expr: COUNT(CASE WHEN is_active = TRUE THEN eligibility_span_id END)
      comment: "Total count of currently active eligibility spans. Core operational KPI for CMS eligibility file reconciliation and enrollment census validation."
    - name: "avg_eligibility_span_duration_days"
      expr: AVG(DATEDIFF(effective_end_date, effective_start_date))
      comment: "Average duration in days of eligibility spans. Measures coverage continuity and identifies short-term enrollment patterns that may indicate churn risk."
    - name: "eligibility_span_active_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_active = TRUE THEN eligibility_span_id END) / NULLIF(COUNT(eligibility_span_id), 0), 2)
      comment: "Percentage of eligibility spans that are currently active. Monitors enrollment health and identifies data reconciliation gaps between source systems."
    - name: "distinct_members_with_active_eligibility"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN subscriber_id END)
      comment: "Count of distinct subscribers with at least one active eligibility span. True active membership census used for CMS enrollment reporting and premium billing reconciliation."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_disenrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disenrollment KPIs tracking member attrition volume, termination reasons, refund financial exposure, and appeal notification compliance. Used by VP of Membership, CFO, and Compliance for churn management, financial reconciliation, and regulatory adherence."
  source: "`vibe_health_insurance_v1`.`member`.`disenrollment`"
  dimensions:
    - name: "disenrollment_status"
      expr: disenrollment_status
      comment: "Current status of the disenrollment record (e.g., Pending, Approved, Denied) for operational pipeline monitoring."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for disenrollment (e.g., Voluntary, Non-Payment, Death) for churn root-cause analysis."
    - name: "reason_description"
      expr: reason_description
      comment: "Descriptive reason for disenrollment for qualitative churn analysis and member experience reporting."
    - name: "termination_type"
      expr: termination_type
      comment: "Type of termination (e.g., Voluntary, Involuntary, Administrative) for regulatory reporting and retention strategy segmentation."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the disenrollment record is currently active/in-process."
    - name: "appeal_rights_notified"
      expr: appeal_rights_notified
      comment: "Boolean flag indicating whether the member was notified of appeal rights. Critical for CMS compliance and grievance/appeal regulatory reporting."
    - name: "eligibility_loss_indicator"
      expr: eligibility_loss_indicator
      comment: "Boolean flag indicating whether disenrollment resulted in eligibility loss for downstream benefits coordination."
    - name: "cobro_eligibility"
      expr: cobro_eligibility
      comment: "Boolean flag indicating COBRA eligibility for the disenrolled member for benefits continuation compliance."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month of disenrollment effective start for attrition trend analysis."
    - name: "notice_sent_date_month"
      expr: DATE_TRUNC('MONTH', notice_sent_date)
      comment: "Month the disenrollment notice was sent for compliance timeliness monitoring."
    - name: "source"
      expr: source
      comment: "Source system or channel that initiated the disenrollment for operational attribution."
  measures:
    - name: "total_disenrollments"
      expr: COUNT(disenrollment_id)
      comment: "Total count of disenrollment events. Primary attrition volume KPI used in membership retention dashboards and executive churn reporting."
    - name: "total_refund_gross_amount"
      expr: SUM(CAST(refund_gross_amount AS DOUBLE))
      comment: "Total gross refund amount issued upon disenrollment. Tracks financial liability from member terminations for CFO cash flow and premium reconciliation reporting."
    - name: "total_refund_net_amount"
      expr: SUM(CAST(refund_net_amount AS DOUBLE))
      comment: "Total net refund amount after adjustments. Represents actual cash outflow from disenrollments for financial close and accounts payable reporting."
    - name: "total_refund_adjustment_amount"
      expr: SUM(CAST(refund_adjustment_amount AS DOUBLE))
      comment: "Total refund adjustment amount applied during disenrollment processing. Monitors billing correction volume and financial reconciliation accuracy."
    - name: "avg_refund_net_amount"
      expr: AVG(CAST(refund_net_amount AS DOUBLE))
      comment: "Average net refund per disenrollment event. Benchmarks per-member financial exposure at termination for actuarial and financial planning."
    - name: "appeal_rights_notification_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_rights_notified = TRUE THEN disenrollment_id END) / NULLIF(COUNT(disenrollment_id), 0), 2)
      comment: "Percentage of disenrollments where appeal rights notification was sent. Critical CMS regulatory compliance KPI — failure triggers audit findings and civil monetary penalties."
    - name: "eligibility_loss_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN eligibility_loss_indicator = TRUE THEN disenrollment_id END) / NULLIF(COUNT(disenrollment_id), 0), 2)
      comment: "Percentage of disenrollments resulting in eligibility loss. Informs care transition planning and downstream coordination-of-benefits risk."
    - name: "cobra_eligible_disenrollment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cobro_eligibility = TRUE THEN disenrollment_id END) / NULLIF(COUNT(disenrollment_id), 0), 2)
      comment: "Percentage of disenrollments where the member is COBRA-eligible. Drives COBRA administration workload forecasting and compliance staffing decisions."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_pcp_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Primary Care Provider (PCP) assignment KPIs tracking assignment coverage, panel status, network tier distribution, and assignment change velocity. Used by CMO, VP of Network Management, and Care Management leadership for network adequacy and care coordination decisions."
  source: "`vibe_health_insurance_v1`.`member`.`pcp_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the PCP assignment (e.g., Active, Pending, Terminated) for assignment pipeline monitoring."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of PCP assignment (e.g., Member-Selected, Auto-Assigned, Plan-Assigned) for assignment method analysis."
    - name: "assignment_reason"
      expr: assignment_reason
      comment: "Reason for the PCP assignment for care coordination and network adequacy root-cause analysis."
    - name: "change_reason"
      expr: change_reason
      comment: "Reason for PCP assignment change for member satisfaction and network stability analysis."
    - name: "panel_status"
      expr: panel_status
      comment: "Panel status of the assigned PCP (e.g., Open, Closed, Restricted) for network capacity and access monitoring."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier of the assigned PCP for cost-tier utilization and member steerage analysis."
    - name: "pcp_specialty_code"
      expr: pcp_specialty_code
      comment: "Specialty code of the assigned PCP for care model and specialty mix analysis."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the PCP assignment is currently active."
    - name: "is_primary"
      expr: is_primary
      comment: "Boolean flag indicating whether this is the member's primary PCP assignment."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month of PCP assignment effective start for assignment trend and network adequacy reporting."
  measures:
    - name: "total_active_pcp_assignments"
      expr: COUNT(CASE WHEN is_active = TRUE THEN pcp_assignment_id END)
      comment: "Total count of currently active PCP assignments. Core network adequacy KPI — measures how many members have an assigned PCP, directly tied to HEDIS and CMS quality scores."
    - name: "distinct_members_with_pcp"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN member_subscriber_id END)
      comment: "Count of distinct members with at least one active PCP assignment. Measures PCP attribution coverage rate, a key managed care quality and cost-efficiency driver."
    - name: "distinct_pcps_assigned"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN pcp_provider_id END)
      comment: "Count of distinct PCPs with at least one active member assignment. Monitors network utilization concentration and identifies over-burdened or under-utilized providers."
    - name: "avg_members_per_pcp"
      expr: ROUND(COUNT(CASE WHEN is_active = TRUE THEN pcp_assignment_id END) / NULLIF(COUNT(DISTINCT CASE WHEN is_active = TRUE THEN pcp_provider_id END), 0), 1)
      comment: "Average number of active member assignments per PCP. Monitors panel size and provider capacity — a critical network adequacy and access-to-care KPI."
    - name: "pcp_assignment_change_count"
      expr: COUNT(CASE WHEN change_reason IS NOT NULL THEN pcp_assignment_id END)
      comment: "Count of PCP assignment change events. Tracks member-initiated and plan-initiated PCP changes as a proxy for member satisfaction and network stability."
    - name: "auto_assigned_pcp_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN assignment_type = 'Auto-Assigned' THEN pcp_assignment_id END) / NULLIF(COUNT(pcp_assignment_id), 0), 2)
      comment: "Percentage of PCP assignments that were auto-assigned by the plan rather than member-selected. High rates may indicate member engagement gaps and are monitored by CMS for managed care compliance."
    - name: "closed_panel_assignment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN panel_status = 'Closed' THEN pcp_assignment_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN pcp_assignment_id END), 0), 2)
      comment: "Percentage of active PCP assignments where the provider panel is closed. Signals network access risk and triggers network adequacy remediation actions."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_lob_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-of-business assignment KPIs tracking risk stratification, dual eligibility, chronic condition prevalence, care management eligibility, and SDOH risk distribution across the member population. Used by CMO, VP of Care Management, and Chief Actuary for population health and risk-based contracting decisions."
  source: "`vibe_health_insurance_v1`.`member`.`lob_assignment`"
  dimensions:
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code (e.g., MA, Medicaid, Commercial) for population segmentation and program-level reporting."
    - name: "lob_description"
      expr: lob_description
      comment: "Descriptive name of the line of business for business-user-friendly reporting."
    - name: "lob_assignment_status"
      expr: lob_assignment_status
      comment: "Current status of the LOB assignment for active population census and data quality monitoring."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier classification of the member (e.g., Low, Medium, High, Rising) for care management prioritization and cost forecasting."
    - name: "hcc_risk_score_tier"
      expr: hcc_risk_score_tier
      comment: "HCC risk score tier for CMS risk adjustment revenue segmentation and population health stratification."
    - name: "snp_type"
      expr: snp_type
      comment: "Special Needs Plan type (e.g., D-SNP, C-SNP, I-SNP) for Medicare SNP population reporting and CMS compliance."
    - name: "star_rating_cohort"
      expr: star_rating_cohort
      comment: "Star rating cohort assignment for CMS Medicare Advantage quality performance tracking."
    - name: "cms_region"
      expr: cms_region
      comment: "CMS region for geographic risk adjustment and regulatory reporting segmentation."
    - name: "state_code"
      expr: state_code
      comment: "State code for geographic population health and regulatory reporting."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the LOB assignment is currently active."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month of LOB assignment effective start for enrollment cohort and risk trend analysis."
  measures:
    - name: "total_active_lob_assignments"
      expr: COUNT(CASE WHEN is_active = TRUE THEN lob_assignment_id END)
      comment: "Total count of active LOB assignments. Core population census KPI for CMS enrollment reporting and capitation payment reconciliation."
    - name: "dual_eligible_member_count"
      expr: COUNT(CASE WHEN dual_eligible_flag = TRUE AND is_active = TRUE THEN lob_assignment_id END)
      comment: "Count of active members flagged as dual-eligible (Medicare and Medicaid). Critical for D-SNP program management, CMS reporting, and high-cost member identification."
    - name: "dual_eligible_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dual_eligible_flag = TRUE AND is_active = TRUE THEN lob_assignment_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN lob_assignment_id END), 0), 2)
      comment: "Percentage of active members who are dual-eligible. Drives D-SNP program investment decisions and CMS coordination-of-benefits compliance strategy."
    - name: "chronic_condition_member_count"
      expr: COUNT(CASE WHEN chronic_condition_flag = TRUE AND is_active = TRUE THEN lob_assignment_id END)
      comment: "Count of active members with a chronic condition flag. Drives disease management program enrollment, care management staffing, and medical cost forecasting."
    - name: "chronic_condition_prevalence_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN chronic_condition_flag = TRUE AND is_active = TRUE THEN lob_assignment_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN lob_assignment_id END), 0), 2)
      comment: "Percentage of active members with chronic conditions. Key population health KPI used in actuarial pricing, care management ROI analysis, and value-based contract performance."
    - name: "care_management_eligible_count"
      expr: COUNT(CASE WHEN care_management_eligibility_flag = TRUE AND is_active = TRUE THEN lob_assignment_id END)
      comment: "Count of active members eligible for care management programs. Drives care management program capacity planning and outreach prioritization."
    - name: "care_management_eligibility_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN care_management_eligibility_flag = TRUE AND is_active = TRUE THEN lob_assignment_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN lob_assignment_id END), 0), 2)
      comment: "Percentage of active members eligible for care management. Informs care management program investment and staffing decisions at the executive level."
    - name: "sdoh_risk_member_count"
      expr: COUNT(CASE WHEN sdoh_risk_flag = TRUE AND is_active = TRUE THEN lob_assignment_id END)
      comment: "Count of active members with identified Social Determinants of Health (SDOH) risk. Drives community health worker program investment and SDOH intervention targeting."
    - name: "sdoh_risk_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sdoh_risk_flag = TRUE AND is_active = TRUE THEN lob_assignment_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN lob_assignment_id END), 0), 2)
      comment: "Percentage of active members with SDOH risk flags. Strategic KPI for health equity program design, CMS SDOH reporting, and value-based care contract performance."
    - name: "rising_risk_member_count"
      expr: COUNT(CASE WHEN rising_risk_indicator = TRUE AND is_active = TRUE THEN lob_assignment_id END)
      comment: "Count of active members identified as rising risk. Enables proactive care management intervention before members escalate to high-cost status, directly impacting medical loss ratio."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_dependent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dependent member KPIs tracking covered dependent population size, age-out risk, disability and Medicaid eligibility, and coverage continuity. Used by VP of Membership, Chief Actuary, and Compliance for family coverage management and regulatory eligibility reporting."
  source: "`vibe_health_insurance_v1`.`member`.`dependent`"
  dimensions:
    - name: "coverage_status"
      expr: coverage_status
      comment: "Current coverage status of the dependent (e.g., Active, Terminated) for dependent census and eligibility monitoring."
    - name: "relationship_type"
      expr: relationship_type
      comment: "Relationship of the dependent to the subscriber (e.g., Spouse, Child, Domestic Partner) for family structure and benefit design analysis."
    - name: "gender"
      expr: gender
      comment: "Dependent gender for demographic and health equity reporting."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the dependent record is currently active."
    - name: "disability_status"
      expr: disability_status
      comment: "Boolean flag indicating disability status of the dependent for special eligibility and care management program targeting."
    - name: "student_status"
      expr: student_status
      comment: "Boolean flag indicating student status of the dependent for age-out eligibility extension tracking (ACA dependent coverage to age 26)."
    - name: "language_preference"
      expr: language_preference
      comment: "Preferred language of the dependent for member communication and health literacy program planning."
    - name: "coverage_start_date_month"
      expr: DATE_TRUNC('MONTH', coverage_start_date)
      comment: "Month of dependent coverage start for enrollment trend analysis."
    - name: "coverage_end_date_month"
      expr: DATE_TRUNC('MONTH', coverage_end_date)
      comment: "Month of dependent coverage end for attrition and age-out trend analysis."
  measures:
    - name: "total_active_dependents"
      expr: COUNT(CASE WHEN is_active = TRUE THEN dependent_id END)
      comment: "Total count of currently active dependents. Core family coverage census KPI for premium billing, capitation, and enrollment reporting."
    - name: "age_out_risk_dependent_count"
      expr: COUNT(CASE WHEN age_out_eligibility_flag = TRUE AND is_active = TRUE THEN dependent_id END)
      comment: "Count of active dependents flagged for age-out eligibility risk. Drives proactive outreach for ACA age-26 transitions and prevents coverage gap compliance issues."
    - name: "age_out_risk_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN age_out_eligibility_flag = TRUE AND is_active = TRUE THEN dependent_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN dependent_id END), 0), 2)
      comment: "Percentage of active dependents at risk of aging out of coverage. Informs enrollment operations staffing for transition outreach and ACA compliance monitoring."
    - name: "medicaid_eligible_dependent_count"
      expr: COUNT(CASE WHEN medicaid_eligibility_flag = TRUE AND is_active = TRUE THEN dependent_id END)
      comment: "Count of active dependents with Medicaid eligibility. Supports coordination-of-benefits, CHIP/Medicaid transition management, and premium tax credit reconciliation."
    - name: "chip_eligible_dependent_count"
      expr: COUNT(CASE WHEN chip_eligibility_flag = TRUE AND is_active = TRUE THEN dependent_id END)
      comment: "Count of active dependents eligible for CHIP. Drives CHIP enrollment outreach, state reporting, and coordination-of-benefits compliance."
    - name: "disabled_dependent_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN disability_status = TRUE AND is_active = TRUE THEN dependent_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN dependent_id END), 0), 2)
      comment: "Percentage of active dependents with disability status. Informs special needs care management program sizing and ADA compliance planning."
    - name: "avg_dependent_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across dependent records. Monitors master data integrity for dependent eligibility files submitted to CMS and state agencies."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_identity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member identity KPIs tracking verified member population, risk score distribution, eligibility status, and demographic completeness. Used by VP of Member Experience, Chief Actuary, and Compliance for identity governance, risk stratification, and regulatory member reporting."
  source: "`vibe_health_insurance_v1`.`member`.`identity`"
  dimensions:
    - name: "member_status"
      expr: member_status
      comment: "Current status of the member identity record (e.g., Active, Inactive, Deceased) for population census and lifecycle tracking."
    - name: "member_type"
      expr: member_type
      comment: "Type of member (e.g., Subscriber, Dependent) for population segmentation."
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Current eligibility status of the member for enrollment and benefits access monitoring."
    - name: "lob"
      expr: lob
      comment: "Line of business associated with the member identity for product-level population reporting."
    - name: "gender"
      expr: gender
      comment: "Member gender for demographic and health equity reporting."
    - name: "race"
      expr: race
      comment: "Member race for health equity, HEDIS, and CMS demographic reporting."
    - name: "ethnicity"
      expr: ethnicity
      comment: "Member ethnicity for health equity and CMS demographic reporting."
    - name: "verification_status"
      expr: verification_status
      comment: "Identity verification status for fraud prevention and eligibility integrity monitoring."
    - name: "relationship_to_subscriber"
      expr: relationship_to_subscriber
      comment: "Member relationship to the subscriber for family structure and dependent coverage analysis."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the member identity record is currently active."
    - name: "enrollment_effective_date_month"
      expr: DATE_TRUNC('MONTH', enrollment_effective_date)
      comment: "Month of enrollment effective date for enrollment cohort and trend analysis."
    - name: "coverage_start_date_month"
      expr: DATE_TRUNC('MONTH', coverage_start_date)
      comment: "Month of coverage start for enrollment trend and seasonality analysis."
  measures:
    - name: "total_active_member_identities"
      expr: COUNT(CASE WHEN is_active = TRUE THEN identity_id END)
      comment: "Total count of active member identity records. Core membership census KPI for CMS enrollment reporting, premium billing, and capitation reconciliation."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across member identities. Drives risk adjustment revenue projections, actuarial pricing, and care management program investment decisions."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across member identity records. Monitors master data integrity for regulatory submissions and downstream system reliability."
    - name: "identity_verification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'Verified' THEN identity_id END) / NULLIF(COUNT(identity_id), 0), 2)
      comment: "Percentage of member identities with verified status. Critical fraud prevention and eligibility integrity KPI — low rates trigger identity governance remediation."
    - name: "distinct_verified_members"
      expr: COUNT(DISTINCT CASE WHEN verification_status = 'Verified' AND is_active = TRUE THEN identity_id END)
      comment: "Count of distinct active members with verified identity. Supports CMS eligibility file accuracy and fraud/waste/abuse prevention program reporting."
    - name: "high_risk_member_count"
      expr: COUNT(CASE WHEN CAST(risk_score AS DOUBLE) >= 2.0 AND is_active = TRUE THEN identity_id END)
      comment: "Count of active members with a risk score at or above 2.0 (high-risk threshold). Drives care management program enrollment, medical cost forecasting, and value-based contract performance monitoring."
$$;