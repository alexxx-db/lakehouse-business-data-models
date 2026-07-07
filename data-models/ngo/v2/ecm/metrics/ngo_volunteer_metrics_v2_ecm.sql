-- Metric views for domain: volunteer | Business: Ngo | Version: 2 | Generated on: 2026-07-03 05:04:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core volunteer roster KPIs tracking workforce capacity, availability, and engagement depth. Sourced from the volunteer master record (equivalent to the People module in SAP HR or a volunteer CRM). PII sensitivity: first_name, last_name, email_address, mobile_number, date_of_birth are pii_staff-classified and must be masked in non-prod per the masking-policy set."
  source: "`vibe_ngo_v1`.`volunteer`.`volunteer`"
  dimensions:
    - name: "volunteer_type"
      expr: volunteer_type
      comment: "Classifies volunteers by engagement model (community, professional, corporate, etc.) for workforce segmentation."
    - name: "availability_status"
      expr: availability_status
      comment: "Current availability state (active, on-leave, inactive) used to filter deployable capacity."
    - name: "country_code"
      expr: country_code
      comment: "ISO country code of the volunteer's geographic base, enabling country-level workforce planning."
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Onboarding pipeline stage — used to track pipeline conversion from recruited to deployment-ready."
    - name: "background_check_status"
      expr: background_check_status
      comment: "Safeguarding compliance gate: whether background check is cleared, pending, or failed."
    - name: "gender"
      expr: gender
      comment: "Gender dimension for diversity and inclusion reporting required by many institutional donors."
    - name: "recognition_level"
      expr: recognition_level
      comment: "Volunteer recognition tier (bronze/silver/gold/etc.) used to track retention and engagement depth."
    - name: "willing_to_travel"
      expr: willing_to_travel
      comment: "Boolean flag indicating travel availability — critical for emergency deployment surge planning."
  measures:
    - name: "total_active_volunteers"
      expr: COUNT(DISTINCT CASE WHEN availability_status = 'active' THEN volunteer_id END)
      comment: "Count of volunteers currently marked active. Headline workforce capacity KPI for operational planning and donor reporting."
    - name: "total_volunteers"
      expr: COUNT(DISTINCT volunteer_id)
      comment: "Total registered volunteer roster size. Baseline for pipeline conversion and retention rate calculations."
    - name: "avg_availability_hours_per_week"
      expr: AVG(CAST(availability_hours_per_week AS DOUBLE))
      comment: "Average weekly hours volunteers are available. Drives capacity planning for program delivery and distribution events."
    - name: "total_volunteer_hours_contributed"
      expr: SUM(CAST(total_volunteer_hours AS DOUBLE))
      comment: "Cumulative volunteer hours across the roster. Key in-kind contribution metric reported to donors and boards as equivalent FTE value."
    - name: "avg_volunteer_hours_per_volunteer"
      expr: AVG(CAST(total_volunteer_hours AS DOUBLE))
      comment: "Average lifetime hours per volunteer. Measures engagement depth and identifies high-value volunteers for retention focus."
    - name: "safeguarding_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN background_check_status = 'cleared' THEN volunteer_id END) / NULLIF(COUNT(DISTINCT volunteer_id), 0), 2)
      comment: "Percentage of volunteers with cleared background checks. Critical safeguarding KPI required for CHS compliance and donor audits."
    - name: "onboarding_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN onboarding_status = 'completed' THEN volunteer_id END) / NULLIF(COUNT(DISTINCT volunteer_id), 0), 2)
      comment: "Percentage of volunteers who have completed onboarding. Measures pipeline efficiency from recruitment to deployment-ready status."
    - name: "travel_ready_volunteer_count"
      expr: COUNT(DISTINCT CASE WHEN willing_to_travel = TRUE THEN volunteer_id END)
      comment: "Number of volunteers willing to travel. Surge deployment capacity indicator for emergency response planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deployment lifecycle KPIs measuring volunteer utilization, hours delivery, and deployment performance. Equivalent to assignment tracking in SAP HR or eTools partner management. Drives operational efficiency and donor in-kind contribution reporting."
  source: "`vibe_ngo_v1`.`volunteer`.`volunteer_deployment`"
  dimensions:
    - name: "deployment_status"
      expr: deployment_status
      comment: "Current lifecycle state of the deployment (planned, active, completed, withdrawn) for pipeline tracking."
    - name: "deployment_type"
      expr: deployment_type
      comment: "Type of deployment (field, remote, surge, regular) for capacity mix analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of deployment for geographic distribution of volunteer effort."
    - name: "region"
      expr: region
      comment: "Regional grouping for portfolio-level workforce planning."
    - name: "remote_deployment_flag"
      expr: remote_deployment_flag
      comment: "Distinguishes remote vs. in-person deployments — relevant for cost and risk analysis."
    - name: "priority"
      expr: priority
      comment: "Deployment priority level used to triage resource allocation during surge operations."
    - name: "security_clearance_level"
      expr: security_clearance_level
      comment: "Security clearance required for the deployment — used for access-constraint and risk management reporting."
  measures:
    - name: "total_deployments"
      expr: COUNT(DISTINCT volunteer_deployment_id)
      comment: "Total number of volunteer deployments. Headline throughput metric for operational capacity reporting."
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours AS DOUBLE))
      comment: "Total planned volunteer hours across all deployments. Used to project in-kind contribution value for grant budgets."
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual hours delivered. Core in-kind contribution metric reported to institutional donors (USAID, ECHO, UN agencies)."
    - name: "hours_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_hours AS DOUBLE)) / NULLIF(SUM(CAST(planned_hours AS DOUBLE)), 0), 2)
      comment: "Ratio of actual to planned hours as a percentage. Measures deployment execution efficiency and identifies under-delivery risk."
    - name: "avg_fte_equivalent"
      expr: AVG(CAST(fte_equivalent AS DOUBLE))
      comment: "Average FTE equivalent per deployment. Translates volunteer effort into staffing equivalents for workforce planning and cost reporting."
    - name: "total_fte_equivalent"
      expr: SUM(CAST(fte_equivalent AS DOUBLE))
      comment: "Total FTE equivalent across all deployments. Used in board reporting to quantify volunteer workforce scale relative to paid staff."
    - name: "avg_performance_rating"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average deployment performance rating. Quality indicator for volunteer management and recognition program targeting."
    - name: "withdrawal_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN deployment_status = 'withdrawn' THEN volunteer_deployment_id END) / NULLIF(COUNT(DISTINCT volunteer_deployment_id), 0), 2)
      comment: "Percentage of deployments that ended in withdrawal. Retention and attrition risk indicator for program continuity planning."
    - name: "total_hours_contributed"
      expr: SUM(CAST(hours_contributed AS DOUBLE))
      comment: "Sum of hours_contributed field — may differ from actual_hours where partial credit is applied. Used for in-kind valuation reconciliation."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_hour_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular volunteer hour logging KPIs for in-kind contribution valuation, donor reporting eligibility, and cost allocation. Equivalent to timesheet data in SAP CATS or eZHACT. Drives NICRA in-kind cost share calculations and grant financial reporting."
  source: "`vibe_ngo_v1`.`volunteer`.`hour_log`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of volunteer activity (distribution, health outreach, WASH, training, etc.) for programmatic attribution."
    - name: "approval_status"
      expr: approval_status
      comment: "Hour log approval state (submitted, approved, rejected) — only approved hours are eligible for donor reporting."
    - name: "donor_report_eligible"
      expr: donor_report_eligible
      comment: "Boolean flag indicating whether hours qualify for donor in-kind reporting — critical for grant compliance."
    - name: "is_group_activity"
      expr: is_group_activity
      comment: "Distinguishes individual vs. group activities for beneficiary reach estimation."
    - name: "is_virtual"
      expr: is_virtual
      comment: "Remote vs. in-person activity flag for cost and modality analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the fair market value rate for multi-currency in-kind valuation."
    - name: "log_date"
      expr: DATE_TRUNC('month', log_date)
      comment: "Month bucket of the log date for trend analysis of volunteer effort over time."
  measures:
    - name: "total_hours_claimed"
      expr: SUM(CAST(hours_claimed AS DOUBLE))
      comment: "Total volunteer hours submitted. Gross pipeline of in-kind contribution before verification."
    - name: "total_hours_verified"
      expr: SUM(CAST(hours_verified AS DOUBLE))
      comment: "Total verified volunteer hours. The auditable in-kind contribution figure used in donor financial reports and NICRA cost-share calculations."
    - name: "hour_verification_rate"
      expr: ROUND(100.0 * SUM(CAST(hours_verified AS DOUBLE)) / NULLIF(SUM(CAST(hours_claimed AS DOUBLE)), 0), 2)
      comment: "Percentage of claimed hours that pass verification. Data quality and compliance KPI — low rates signal timesheet fraud risk or process gaps."
    - name: "total_in_kind_value"
      expr: SUM(CAST(in_kind_value AS DOUBLE))
      comment: "Total monetary value of volunteer in-kind contributions. Key cost-share metric for USAID, EU, and UN grant compliance reporting."
    - name: "avg_fair_market_value_rate"
      expr: AVG(CAST(fair_market_value_rate AS DOUBLE))
      comment: "Average fair market value rate per hour. Used to validate that in-kind rates are consistent with donor-approved schedules."
    - name: "donor_reportable_hours"
      expr: SUM(CASE WHEN donor_report_eligible = TRUE THEN hours_verified ELSE 0 END)
      comment: "Verified hours flagged as donor-reportable. The precise figure submitted in grant financial reports as in-kind cost share."
    - name: "donor_reportable_in_kind_value"
      expr: SUM(CASE WHEN donor_report_eligible = TRUE THEN in_kind_value ELSE 0 END)
      comment: "In-kind value of donor-reportable hours. Direct input to grant financial reporting and cost-share compliance calculations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer recruitment pipeline KPIs tracking conversion, screening compliance, and onboarding throughput. Equivalent to recruitment funnel analytics in SAP SuccessFactors or Primero. Drives safeguarding compliance and workforce pipeline management."
  source: "`vibe_ngo_v1`.`volunteer`.`application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current pipeline stage of the application (submitted, screening, interview, approved, rejected, withdrawn)."
    - name: "decision_status"
      expr: decision_status
      comment: "Final decision outcome for closed applications — used for acceptance rate and rejection reason analysis."
    - name: "recruitment_channel"
      expr: recruitment_channel
      comment: "Source channel (social media, referral, event, partner, etc.) for cost-per-acquisition and channel effectiveness analysis."
    - name: "background_check_status"
      expr: background_check_status
      comment: "Safeguarding compliance gate status for the application — required for CHS and donor audit reporting."
    - name: "screening_status"
      expr: screening_status
      comment: "Screening pipeline status for funnel conversion tracking."
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Onboarding completion state — measures pipeline throughput from approved to deployment-ready."
    - name: "application_date"
      expr: DATE_TRUNC('month', application_date)
      comment: "Month of application submission for recruitment trend analysis."
  measures:
    - name: "total_applications"
      expr: COUNT(DISTINCT application_id)
      comment: "Total applications received. Top-of-funnel recruitment volume metric for workforce pipeline planning."
    - name: "acceptance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN decision_status = 'approved' THEN application_id END) / NULLIF(COUNT(DISTINCT application_id), 0), 2)
      comment: "Percentage of applications resulting in approval. Measures recruitment selectivity and pipeline quality."
    - name: "background_check_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN background_check_completed_date IS NOT NULL THEN application_id END) / NULLIF(COUNT(DISTINCT CASE WHEN background_check_required = TRUE THEN application_id END), 0), 2)
      comment: "Percentage of applications requiring background checks that have completed them. Critical safeguarding compliance KPI for CHS and donor audits."
    - name: "avg_hours_per_week_committed"
      expr: AVG(CAST(hours_per_week AS DOUBLE))
      comment: "Average weekly hours commitment offered by applicants. Used to project incoming volunteer capacity from the pipeline."
    - name: "onboarding_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN onboarding_status = 'completed' THEN application_id END) / NULLIF(COUNT(DISTINCT CASE WHEN decision_status = 'approved' THEN application_id END), 0), 2)
      comment: "Percentage of approved applicants who completed onboarding. Measures pipeline conversion efficiency from approval to deployment-ready."
    - name: "safeguarding_policy_acknowledgment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN safeguarding_policy_acknowledged = TRUE THEN application_id END) / NULLIF(COUNT(DISTINCT application_id), 0), 2)
      comment: "Percentage of applicants who have acknowledged the safeguarding policy. Mandatory compliance metric for PSEA and CHS accountability frameworks."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_training_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer training pipeline KPIs measuring completion rates, certification outcomes, and compliance training coverage. Sourced from training enrollment records equivalent to LMS data in SAP SuccessFactors or Moodle. Drives CHS compliance, safeguarding training mandates, and capacity building reporting."
  source: "`vibe_ngo_v1`.`volunteer`.`training_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment state (enrolled, in-progress, completed, withdrawn, failed) for pipeline tracking."
    - name: "training_delivery_mode"
      expr: training_delivery_mode
      comment: "Delivery modality (in-person, e-learning, blended) for cost and reach analysis."
    - name: "compliance_training_category"
      expr: compliance_training_category
      comment: "Compliance category (safeguarding, PSEA, CHS, security) for mandatory training coverage reporting."
    - name: "mandatory_training_flag"
      expr: mandatory_training_flag
      comment: "Distinguishes mandatory from optional training for compliance gap analysis."
    - name: "certification_issued_flag"
      expr: certification_issued_flag
      comment: "Whether a certificate was issued upon completion — used for credentialing and donor reporting."
    - name: "enrollment_date"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of enrollment for training throughput trend analysis."
    - name: "training_language"
      expr: training_language
      comment: "Language of training delivery — used for localization coverage and language equity analysis."
  measures:
    - name: "total_enrollments"
      expr: COUNT(DISTINCT training_enrollment_id)
      comment: "Total training enrollments. Baseline capacity building throughput metric for program and donor reporting."
    - name: "training_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN enrollment_status = 'completed' THEN training_enrollment_id END) / NULLIF(COUNT(DISTINCT training_enrollment_id), 0), 2)
      comment: "Percentage of enrollments resulting in completion. Core learning effectiveness KPI for CHS self-assessment and capacity building plans."
    - name: "mandatory_training_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN mandatory_training_flag = TRUE AND enrollment_status = 'completed' THEN training_enrollment_id END) / NULLIF(COUNT(DISTINCT CASE WHEN mandatory_training_flag = TRUE THEN training_enrollment_id END), 0), 2)
      comment: "Completion rate for mandatory training only. Critical compliance KPI — gaps trigger safeguarding and donor audit findings."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across enrollments. Measures training quality and knowledge retention — low scores indicate curriculum gaps."
    - name: "certification_issuance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN certification_issued_flag = TRUE THEN training_enrollment_id END) / NULLIF(COUNT(DISTINCT CASE WHEN enrollment_status = 'completed' THEN training_enrollment_id END), 0), 2)
      comment: "Percentage of completed enrollments resulting in certification. Measures credentialing pipeline efficiency."
    - name: "total_training_hours_delivered"
      expr: SUM(CAST(training_hours AS DOUBLE))
      comment: "Total training hours delivered across all enrollments. Capacity building investment metric reported to donors and boards."
    - name: "total_enrollment_cost"
      expr: SUM(CAST(enrollment_cost AS DOUBLE))
      comment: "Total cost of training enrollments. Budget utilization metric for capacity building program management."
    - name: "avg_cost_per_enrollment"
      expr: AVG(CAST(enrollment_cost AS DOUBLE))
      comment: "Average cost per training enrollment. Efficiency metric for comparing delivery modalities and optimizing training investment."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_stipend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer stipend financial KPIs tracking disbursement volumes, compliance, and tax reporting obligations. Equivalent to payroll/allowance data in SAP FI or eZHACT. Drives grant budget utilization, donor financial reporting, and tax compliance (1099/W-2 equivalent in-country)."
  source: "`vibe_ngo_v1`.`volunteer`.`stipend`"
  dimensions:
    - name: "stipend_type"
      expr: stipend_type
      comment: "Type of stipend (transport, subsistence, skills-based, emergency) for budget category analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval pipeline state (pending, approved, rejected, paid) for disbursement tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Disbursement currency for multi-currency financial reporting and exchange rate risk analysis."
    - name: "donor_reportable_flag"
      expr: donor_reportable_flag
      comment: "Whether the stipend is chargeable to a donor grant — critical for grant financial reporting."
    - name: "tax_reportable_flag"
      expr: tax_reportable_flag
      comment: "Whether the stipend triggers tax reporting obligations — drives statutory compliance."
    - name: "compliance_check_status"
      expr: compliance_check_status
      comment: "Compliance review status for the stipend — flags potential regulatory or donor policy violations."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the stipend for annual budget and audit reporting."
  measures:
    - name: "total_stipend_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total stipend disbursements. Headline financial metric for volunteer program cost management and grant budget utilization."
    - name: "total_donor_reportable_stipend_amount"
      expr: SUM(CASE WHEN donor_reportable_flag = TRUE THEN amount ELSE 0 END)
      comment: "Total stipend amount chargeable to donor grants. Direct input to grant financial reports and budget burn-rate analysis."
    - name: "total_reporting_currency_amount"
      expr: SUM(CAST(reporting_currency_amount AS DOUBLE))
      comment: "Total stipend value in reporting currency after exchange rate conversion. Used for consolidated financial reporting across multi-currency programs."
    - name: "avg_stipend_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average stipend amount per record. Benchmarking metric for equity analysis and budget planning across country programs."
    - name: "stipend_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN compliance_check_status = 'passed' THEN stipend_id END) / NULLIF(COUNT(DISTINCT stipend_id), 0), 2)
      comment: "Percentage of stipends passing compliance checks. Regulatory and donor audit risk indicator — low rates signal disbursement control failures."
    - name: "total_stipends_disbursed"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'paid' THEN stipend_id END)
      comment: "Count of stipends actually disbursed. Operational throughput metric for volunteer finance team performance."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_feedback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer and beneficiary feedback KPIs measuring satisfaction, safety perception, and escalation rates. Aligned with CHS Commitment 5 (complaints and feedback mechanisms) and SPHERE accountability standards. Drives program quality improvement and accountability to affected populations."
  source: "`vibe_ngo_v1`.`volunteer`.`feedback`"
  dimensions:
    - name: "feedback_type"
      expr: CAST(feedback_type AS STRING)
      comment: "Category of feedback (satisfaction, complaint, suggestion, safety concern) for issue triage and routing."
    - name: "channel"
      expr: channel
      comment: "Feedback submission channel (hotline, in-person, digital, community meeting) for accessibility analysis."
    - name: "escalation_required"
      expr: escalation_required
      comment: "Whether the feedback requires escalation — used to track serious complaints and protection concerns."
    - name: "is_sensitive"
      expr: is_sensitive
      comment: "Sensitive feedback flag (e.g., PSEA, protection) requiring confidential handling and safeguarding response."
    - name: "follow_up_status"
      expr: follow_up_status
      comment: "Resolution status of follow-up actions — measures accountability loop closure rate."
    - name: "country_code"
      expr: country_code
      comment: "Country of feedback submission for geographic quality monitoring."
    - name: "submission_date"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of submission for trend analysis of feedback volumes and satisfaction over time."
  measures:
    - name: "total_feedback_submissions"
      expr: COUNT(DISTINCT feedback_id)
      comment: "Total feedback records received. Baseline accountability mechanism utilization metric required for CHS Commitment 5 reporting."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN escalation_required = TRUE THEN feedback_id END) / NULLIF(COUNT(DISTINCT feedback_id), 0), 2)
      comment: "Percentage of feedback requiring escalation. Risk indicator for serious complaints, protection concerns, and PSEA incidents."
    - name: "sensitive_feedback_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_sensitive = TRUE THEN feedback_id END) / NULLIF(COUNT(DISTINCT feedback_id), 0), 2)
      comment: "Percentage of feedback flagged as sensitive. Safeguarding and protection monitoring KPI for PSEA compliance."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across feedback submissions. Aggregate satisfaction signal for program quality steering."
    - name: "follow_up_closure_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN follow_up_status = 'closed' THEN feedback_id END) / NULLIF(COUNT(DISTINCT CASE WHEN follow_up_status IS NOT NULL THEN feedback_id END), 0), 2)
      comment: "Percentage of feedback requiring follow-up that has been closed. Accountability loop closure rate — a CHS and donor audit requirement."
    - name: "would_volunteer_again_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN would_volunteer_again = TRUE THEN feedback_id END) / NULLIF(COUNT(DISTINCT feedback_id), 0), 2)
      comment: "Percentage of volunteers indicating they would volunteer again. Retention intent and volunteer satisfaction KPI for program quality management."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_incident_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer incident KPIs tracking safety, investigation outcomes, and resolution timeliness. Aligned with duty-of-care obligations and safeguarding frameworks (CHS, PSEA). Drives risk management, insurance reporting, and organizational learning."
  source: "`vibe_ngo_v1`.`volunteer`.`incident_report`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of incident (safety, health, security, safeguarding, operational) for risk categorization."
    - name: "severity_level"
      expr: severity_level
      comment: "Incident severity (low/medium/high/critical) for prioritization and escalation management."
    - name: "incident_report_status"
      expr: incident_report_status
      comment: "Current status of the incident report (open, under investigation, resolved, closed) for pipeline tracking."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Investigation pipeline state — used to track safeguarding and compliance investigation throughput."
    - name: "country_code"
      expr: country_code
      comment: "Country where the incident occurred for geographic risk analysis."
    - name: "insurance_claim_filed"
      expr: insurance_claim_filed
      comment: "Whether an insurance claim was filed — used for duty-of-care cost tracking."
    - name: "incident_date"
      expr: DATE_TRUNC('month', incident_date)
      comment: "Month of incident for trend analysis and seasonal risk pattern identification."
  measures:
    - name: "total_incidents"
      expr: COUNT(DISTINCT incident_report_id)
      comment: "Total incidents reported. Baseline safety and risk monitoring metric for duty-of-care and donor reporting."
    - name: "high_severity_incident_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN severity_level IN ('high', 'critical') THEN incident_report_id END) / NULLIF(COUNT(DISTINCT incident_report_id), 0), 2)
      comment: "Percentage of incidents classified as high or critical severity. Risk escalation KPI for board-level safety reporting."
    - name: "investigation_required_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN investigation_required = TRUE THEN incident_report_id END) / NULLIF(COUNT(DISTINCT incident_report_id), 0), 2)
      comment: "Percentage of incidents requiring formal investigation. Safeguarding and compliance workload indicator."
    - name: "investigation_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN investigation_completion_date IS NOT NULL THEN incident_report_id END) / NULLIF(COUNT(DISTINCT CASE WHEN investigation_required = TRUE THEN incident_report_id END), 0), 2)
      comment: "Percentage of required investigations that have been completed. Accountability and compliance KPI for safeguarding governance."
    - name: "resolution_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN incident_report_status = 'resolved' THEN incident_report_id END) / NULLIF(COUNT(DISTINCT incident_report_id), 0), 2)
      comment: "Percentage of incidents that have been resolved. Operational effectiveness metric for incident management process quality."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer certification portfolio KPIs tracking compliance coverage, expiry risk, and credentialing investment. Equivalent to qualification management in SAP HR. Drives deployment eligibility gating, safeguarding compliance, and capacity building investment reporting."
  source: "`vibe_ngo_v1`.`volunteer`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (safeguarding, first aid, technical, language, etc.) for compliance coverage analysis."
    - name: "skill_category"
      expr: skill_category
      comment: "Skill domain of the certification for workforce capability mapping."
    - name: "verification_status"
      expr: verification_status
      comment: "Whether the certification has been verified by the organization — required for deployment eligibility."
    - name: "deployment_eligible"
      expr: deployment_eligible
      comment: "Whether the certification makes the volunteer eligible for deployment — key gating dimension."
    - name: "mandatory_for_role"
      expr: mandatory_for_role
      comment: "Whether the certification is mandatory for the assigned role — drives compliance gap analysis."
    - name: "renewal_required"
      expr: renewal_required
      comment: "Whether the certification requires periodic renewal — used for expiry risk management."
    - name: "country_of_issue"
      expr: country_of_issue
      comment: "Country where the certification was issued — relevant for cross-border recognition and equivalency analysis."
  measures:
    - name: "total_certifications"
      expr: COUNT(DISTINCT certification_id)
      comment: "Total certifications held across the volunteer workforce. Baseline capability inventory metric."
    - name: "verified_certification_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN verification_status = 'verified' THEN certification_id END) / NULLIF(COUNT(DISTINCT certification_id), 0), 2)
      comment: "Percentage of certifications that have been verified. Compliance quality KPI — unverified certifications create deployment eligibility and audit risk."
    - name: "expiring_certifications_count"
      expr: COUNT(DISTINCT CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND expiry_date >= CURRENT_DATE() THEN certification_id END)
      comment: "Number of certifications expiring within 90 days. Proactive risk management KPI for maintaining deployment-eligible workforce."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total organizational investment in volunteer certifications. Capacity building cost metric for budget planning and donor reporting."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score at certification. Quality indicator for training effectiveness and credentialing standards."
    - name: "reimbursement_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN reimbursed_by_organization = TRUE THEN certification_id END) / NULLIF(COUNT(DISTINCT certification_id), 0), 2)
      comment: "Percentage of certifications reimbursed by the organization. Financial equity and volunteer retention investment metric."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_team`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer team performance and capacity KPIs for field operations management. Teams are the primary operational unit for distribution events, WASH interventions, and community outreach. Drives field team sizing, performance management, and budget allocation decisions."
  source: "`vibe_ngo_v1`.`volunteer`.`volunteer_team`"
  dimensions:
    - name: "team_type"
      expr: team_type
      comment: "Type of volunteer team (distribution, health, WASH, protection, community) for programmatic segmentation."
    - name: "volunteer_team_status"
      expr: volunteer_team_status
      comment: "Operational status of the team (active, forming, dissolved) for capacity planning."
    - name: "geographic_area"
      expr: geographic_area
      comment: "Geographic coverage area of the team for spatial resource allocation analysis."
    - name: "training_completion_required"
      expr: training_completion_required
      comment: "Whether the team requires training completion before deployment — compliance gating dimension."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary operating language of the team — used for language equity and community accessibility analysis."
  measures:
    - name: "total_active_teams"
      expr: COUNT(DISTINCT CASE WHEN volunteer_team_status = 'active' THEN volunteer_team_id END)
      comment: "Number of currently active volunteer teams. Operational capacity headline metric for field operations planning."
    - name: "total_volunteer_hours_by_team"
      expr: SUM(CAST(total_volunteer_hours AS DOUBLE))
      comment: "Total volunteer hours contributed across all teams. Aggregate effort metric for program delivery reporting."
    - name: "avg_performance_rating"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average team performance rating. Quality management KPI for identifying high-performing and at-risk teams."
    - name: "total_budget_allocation"
      expr: SUM(CAST(budget_allocation AS DOUBLE))
      comment: "Total budget allocated to volunteer teams. Financial planning metric for field operations cost management."
    - name: "avg_budget_per_team"
      expr: AVG(CAST(budget_allocation AS DOUBLE))
      comment: "Average budget allocation per team. Equity and efficiency metric for resource distribution across field teams."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_redeployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer redeployment KPIs tracking transition efficiency, approval throughput, and handover quality. Redeployments represent reassignment of volunteers from one deployment to another — critical for surge response and program continuity. Sourced from the renamed volunteer_redeployment product (formerly volunteer_deployment2, per VREQ-034)."
  source: "`vibe_ngo_v1`.`volunteer`.`volunteer_redeployment`"
  dimensions:
    - name: "redeployment_status"
      expr: redeployment_status
      comment: "Current state of the redeployment (pending, approved, active, completed, cancelled) for pipeline tracking."
    - name: "redeployment_reason"
      expr: redeployment_reason
      comment: "Reason for redeployment (surge, program end, performance, volunteer request) for root cause analysis."
    - name: "handover_completed_flag"
      expr: handover_completed_flag
      comment: "Whether a formal handover was completed — measures transition quality and program continuity risk."
    - name: "redeployment_date"
      expr: DATE_TRUNC('month', redeployment_date)
      comment: "Month of redeployment for surge and transition trend analysis."
  measures:
    - name: "total_redeployments"
      expr: COUNT(DISTINCT volunteer_redeployment_id)
      comment: "Total volunteer redeployments. Measures workforce flexibility and surge response capacity utilization."
    - name: "approved_redeployment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN redeployment_status = 'approved' THEN volunteer_redeployment_id END) / NULLIF(COUNT(DISTINCT volunteer_redeployment_id), 0), 2)
      comment: "Percentage of redeployments that received approval. Process efficiency KPI for volunteer management operations."
    - name: "handover_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN handover_completed_flag = TRUE THEN volunteer_redeployment_id END) / NULLIF(COUNT(DISTINCT volunteer_redeployment_id), 0), 2)
      comment: "Percentage of redeployments with completed handovers. Program continuity quality KPI — incomplete handovers create knowledge loss and service disruption risk."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_deployment2`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Extended redeployment analytics KPIs using the full attribute set of the volunteer_deployment2 product (stub product populated per VREQ-032). Provides richer redeployment performance, skills matching, and transition quality metrics not available in the core volunteer_redeployment product."
  source: "`vibe_ngo_v1`.`volunteer`.`volunteer_deployment2`"
  dimensions:
    - name: "redeployment_status"
      expr: redeployment_status
      comment: "Lifecycle state of the redeployment record for pipeline and throughput analysis."
    - name: "redeployment_type"
      expr: redeployment_type
      comment: "Type of redeployment (lateral, promotion, emergency surge, program transfer) for workforce mobility analysis."
    - name: "redeployment_reason"
      expr: redeployment_reason
      comment: "Business reason driving the redeployment — used for root cause and attrition analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the new deployment for geographic workforce flow analysis."
    - name: "remote_deployment_flag"
      expr: remote_deployment_flag
      comment: "Whether the redeployment is remote — used for cost and modality mix analysis."
    - name: "security_clearance_verified_flag"
      expr: security_clearance_verified_flag
      comment: "Whether security clearance was verified before redeployment — safeguarding and access control compliance gate."
    - name: "continuity_flag"
      expr: continuity_flag
      comment: "Whether the redeployment maintains program continuity — used to assess transition risk."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval pipeline state for the redeployment record."
  measures:
    - name: "total_redeployment_records"
      expr: COUNT(DISTINCT volunteer_deployment2_id)
      comment: "Total redeployment records in this extended product. Baseline for redeployment volume and workforce mobility reporting."
    - name: "avg_skills_match_score"
      expr: AVG(CAST(skills_match_score AS DOUBLE))
      comment: "Average skills match score between volunteer profile and new deployment role. Quality KPI for redeployment decision-making — low scores predict performance risk."
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours AS DOUBLE))
      comment: "Total planned hours for redeployments. Capacity planning input for program delivery projections."
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual hours delivered in redeployments. In-kind contribution metric for grant financial reporting."
    - name: "hours_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_hours AS DOUBLE)) / NULLIF(SUM(CAST(planned_hours AS DOUBLE)), 0), 2)
      comment: "Ratio of actual to planned hours for redeployments. Execution efficiency KPI for redeployment program management."
    - name: "avg_performance_rating"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average performance rating for redeployed volunteers. Quality indicator for redeployment selection criteria effectiveness."
    - name: "avg_previous_deployment_performance"
      expr: AVG(CAST(previous_deployment_performance_rating AS DOUBLE))
      comment: "Average performance rating from the prior deployment. Baseline for measuring performance change post-redeployment."
    - name: "security_clearance_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN security_clearance_verified_flag = TRUE THEN volunteer_deployment2_id END) / NULLIF(COUNT(DISTINCT volunteer_deployment2_id), 0), 2)
      comment: "Percentage of redeployments with verified security clearance. Safeguarding and access control compliance KPI."
    - name: "handover_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN handover_completed_flag = TRUE THEN volunteer_deployment2_id END) / NULLIF(COUNT(DISTINCT volunteer_deployment2_id), 0), 2)
      comment: "Percentage of redeployments with completed handovers. Program continuity quality metric."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_recognition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer recognition program KPIs measuring award distribution, monetary investment, and retention impact. Recognition programs are a primary lever for volunteer retention and engagement — critical for organizations dependent on volunteer labor for program delivery."
  source: "`vibe_ngo_v1`.`volunteer`.`recognition`"
  dimensions:
    - name: "recognition_type"
      expr: recognition_type
      comment: "Type of recognition (milestone, performance, peer nomination, leadership) for program mix analysis."
    - name: "recognition_status"
      expr: recognition_status
      comment: "Current status of the recognition (nominated, approved, awarded, declined) for pipeline tracking."
    - name: "channel"
      expr: channel
      comment: "Recognition delivery channel (public ceremony, digital, newsletter, in-person) for engagement effectiveness analysis."
    - name: "public_acknowledgment_flag"
      expr: public_acknowledgment_flag
      comment: "Whether the recognition was publicly acknowledged — used for community visibility and volunteer motivation analysis."
    - name: "skills_category"
      expr: skills_category
      comment: "Skill domain recognized — used to identify and celebrate high-value capability areas."
    - name: "award_date"
      expr: DATE_TRUNC('month', award_date)
      comment: "Month of award for recognition program cadence and trend analysis."
  measures:
    - name: "total_recognitions_awarded"
      expr: COUNT(DISTINCT CASE WHEN recognition_status = 'awarded' THEN recognition_id END)
      comment: "Total recognitions awarded. Headline volunteer engagement and retention investment metric."
    - name: "total_monetary_value_awarded"
      expr: SUM(CASE WHEN recognition_status = 'awarded' THEN monetary_value ELSE 0 END)
      comment: "Total monetary value of recognition awards. Financial investment in volunteer retention — benchmarked against turnover cost."
    - name: "avg_monetary_value_per_recognition"
      expr: AVG(CAST(monetary_value AS DOUBLE))
      comment: "Average monetary value per recognition. Equity and consistency metric for recognition program management."
    - name: "public_recognition_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN public_acknowledgment_flag = TRUE THEN recognition_id END) / NULLIF(COUNT(DISTINCT recognition_id), 0), 2)
      comment: "Percentage of recognitions that include public acknowledgment. Community visibility metric for volunteer motivation and recruitment brand."
    - name: "certificate_issuance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN certificate_issued_flag = TRUE THEN recognition_id END) / NULLIF(COUNT(DISTINCT recognition_id), 0), 2)
      comment: "Percentage of recognitions accompanied by a certificate. Credentialing and formal acknowledgment rate for volunteer portfolio building."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_policy_acknowledgment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy acknowledgment compliance KPIs tracking PSEA and safeguarding policy sign-off rates across the volunteer workforce. Mandatory for CHS Commitment 3, PSEA network membership, and donor safeguarding audits. PII note: acknowledged_by_name and witness_name are pii_staff-classified per VREQ-055 and must be masked in non-prod."
  source: "`vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment`"
  dimensions:
    - name: "acknowledgment_status"
      expr: acknowledgment_status
      comment: "Current status of the policy acknowledgment (pending, acknowledged, expired, withdrawn) for compliance gap tracking."
    - name: "acknowledgment_method"
      expr: acknowledgment_method
      comment: "Method of acknowledgment (digital signature, paper, in-person) for audit trail quality analysis."
    - name: "training_completion_flag"
      expr: training_completion_flag
      comment: "Whether associated training was completed alongside the acknowledgment — measures depth of compliance."
    - name: "acknowledgment_date"
      expr: DATE_TRUNC('month', acknowledgment_date)
      comment: "Month of acknowledgment for compliance campaign tracking and renewal cycle management."
  measures:
    - name: "total_acknowledgments"
      expr: COUNT(DISTINCT volunteer_policy_acknowledgment_id)
      comment: "Total policy acknowledgments on record. Baseline compliance coverage metric for PSEA and safeguarding governance."
    - name: "acknowledgment_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN acknowledgment_status = 'acknowledged' THEN volunteer_policy_acknowledgment_id END) / NULLIF(COUNT(DISTINCT volunteer_policy_acknowledgment_id), 0), 2)
      comment: "Percentage of policy acknowledgments completed. Critical safeguarding compliance KPI — gaps trigger donor audit findings and CHS non-conformities."
    - name: "training_with_acknowledgment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN training_completion_flag = TRUE THEN volunteer_policy_acknowledgment_id END) / NULLIF(COUNT(DISTINCT volunteer_policy_acknowledgment_id), 0), 2)
      comment: "Percentage of acknowledgments accompanied by training completion. Measures depth of safeguarding compliance beyond checkbox acknowledgment."
    - name: "expiring_acknowledgments_count"
      expr: COUNT(DISTINCT CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND expiry_date >= CURRENT_DATE() THEN volunteer_policy_acknowledgment_id END)
      comment: "Number of policy acknowledgments expiring within 90 days. Proactive compliance management KPI for renewal campaign targeting."
$$;