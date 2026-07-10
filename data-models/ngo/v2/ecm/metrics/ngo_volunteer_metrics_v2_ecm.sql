-- Metric views for domain: volunteer | Business: Ngo | Version: 2 | Generated on: 2026-07-10 18:25:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core volunteer roster metrics tracking workforce size, availability, engagement depth, and demographic composition to steer recruitment, retention, and capacity planning decisions."
  source: "`vibe_ngo_v1`.`volunteer`.`volunteer`"
  dimensions:
    - name: "volunteer_type"
      expr: volunteer_type
      comment: "Category of volunteer (e.g. community, professional, corporate) for segmenting workforce composition."
    - name: "availability_status"
      expr: availability_status
      comment: "Current availability status of the volunteer, used to identify active vs. inactive capacity."
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Stage of onboarding completion, enabling pipeline tracking from recruitment to deployment-ready."
    - name: "gender"
      expr: gender
      comment: "Gender identity of the volunteer for diversity and inclusion reporting."
    - name: "nationality"
      expr: nationality
      comment: "Nationality of the volunteer for geographic diversity analysis and compliance with local staffing requirements."
    - name: "country_code"
      expr: country_code
      comment: "Country where the volunteer is based, enabling geographic distribution analysis."
    - name: "background_check_status"
      expr: background_check_status
      comment: "Status of background check screening, critical for safeguarding compliance monitoring."
    - name: "recognition_level"
      expr: recognition_level
      comment: "Current recognition tier of the volunteer, used to assess engagement and retention program effectiveness."
    - name: "willing_to_travel"
      expr: willing_to_travel
      comment: "Whether the volunteer is willing to travel, informing deployment planning for field operations."
  measures:
    - name: "total_active_volunteers"
      expr: COUNT(DISTINCT CASE WHEN availability_status = 'active' THEN volunteer_id END)
      comment: "Count of distinct volunteers currently marked active — the primary workforce capacity indicator for operational planning."
    - name: "total_volunteers"
      expr: COUNT(DISTINCT volunteer_id)
      comment: "Total registered volunteer headcount across all statuses, used to measure overall program reach and growth."
    - name: "avg_availability_hours_per_week"
      expr: AVG(CAST(availability_hours_per_week AS DOUBLE))
      comment: "Average weekly hours volunteers are available to contribute, informing capacity planning and deployment scheduling."
    - name: "total_cumulative_volunteer_hours"
      expr: SUM(CAST(total_volunteer_hours AS DOUBLE))
      comment: "Sum of all lifetime volunteer hours contributed across the roster — a headline impact metric for donor reporting and program evaluation."
    - name: "avg_volunteer_hours_per_volunteer"
      expr: AVG(CAST(total_volunteer_hours AS DOUBLE))
      comment: "Average lifetime hours per volunteer, indicating depth of engagement and identifying high-commitment cohorts."
    - name: "background_check_compliant_count"
      expr: COUNT(DISTINCT CASE WHEN background_check_status = 'completed' THEN volunteer_id END)
      comment: "Number of volunteers with completed background checks — a safeguarding compliance KPI that leadership monitors to ensure duty-of-care obligations are met."
    - name: "onboarding_complete_count"
      expr: COUNT(DISTINCT CASE WHEN onboarding_status = 'completed' THEN volunteer_id END)
      comment: "Count of volunteers who have fully completed onboarding, representing deployment-ready capacity."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deployment-level metrics tracking planned vs. actual hours, performance, and deployment pipeline health to optimize field operations and volunteer utilization."
  source: "`vibe_ngo_v1`.`volunteer`.`volunteer_deployment`"
  dimensions:
    - name: "volunteer_deployment_status"
      expr: volunteer_deployment_status
      comment: "Current status of the deployment (e.g. active, completed, withdrawn) for pipeline and completion analysis."
    - name: "volunteer_deployment_type"
      expr: volunteer_deployment_type
      comment: "Type of deployment (e.g. field, remote, emergency) for segmenting operational patterns."
    - name: "country_code"
      expr: country_code
      comment: "Country of deployment for geographic distribution and resource allocation analysis."
    - name: "region"
      expr: region
      comment: "Regional grouping of deployments for portfolio-level operational oversight."
    - name: "remote_deployment_flag"
      expr: remote_deployment_flag
      comment: "Indicates whether the deployment is remote, enabling comparison of remote vs. in-person deployment effectiveness."
    - name: "priority"
      expr: priority
      comment: "Deployment priority level for triage and resource allocation decisions."
    - name: "security_clearance_level"
      expr: security_clearance_level
      comment: "Security clearance required for the deployment, used for compliance and risk management reporting."
    - name: "start_date"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month of deployment start date for trend analysis of deployment pipeline over time."
  measures:
    - name: "total_deployments"
      expr: COUNT(DISTINCT volunteer_deployment_id)
      comment: "Total number of volunteer deployments — the primary throughput metric for field operations capacity."
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours AS DOUBLE))
      comment: "Sum of all planned volunteer hours across deployments, used for capacity planning and donor reporting."
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Sum of all actual hours contributed across deployments — the realized volunteer labor input metric."
    - name: "total_hours_contributed"
      expr: SUM(CAST(hours_contributed AS DOUBLE))
      comment: "Total hours contributed as recorded on deployment records, used for impact reporting and in-kind valuation."
    - name: "avg_fte_equivalent"
      expr: AVG(CAST(fte_equivalent AS DOUBLE))
      comment: "Average FTE equivalent per deployment, enabling comparison of volunteer labor to paid staff capacity."
    - name: "avg_performance_rating"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average volunteer performance rating across deployments — a quality indicator for volunteer management and recognition programs."
    - name: "recognition_awarded_deployments"
      expr: COUNT(DISTINCT CASE WHEN recognition_awarded_flag = TRUE THEN volunteer_deployment_id END)
      comment: "Number of deployments where recognition was awarded, measuring the reach of volunteer recognition programs."
    - name: "withdrawn_deployments"
      expr: COUNT(DISTINCT CASE WHEN volunteer_deployment_status = 'withdrawn' THEN volunteer_deployment_id END)
      comment: "Count of deployments that ended in withdrawal — an attrition risk indicator for volunteer retention strategy."
    - name: "orientation_completed_deployments"
      expr: COUNT(DISTINCT CASE WHEN orientation_completed_flag = TRUE THEN volunteer_deployment_id END)
      comment: "Number of deployments where orientation was completed, a safeguarding and readiness compliance metric."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruitment funnel metrics tracking application volume, conversion rates, screening outcomes, and onboarding pipeline to optimize volunteer acquisition and reduce time-to-deployment."
  source: "`vibe_ngo_v1`.`volunteer`.`application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the application (e.g. submitted, approved, rejected) for funnel stage analysis."
    - name: "decision_status"
      expr: decision_status
      comment: "Final decision outcome on the application for conversion rate and rejection analysis."
    - name: "recruitment_channel"
      expr: recruitment_channel
      comment: "Channel through which the volunteer was recruited, enabling ROI analysis by acquisition source."
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Onboarding pipeline stage for tracking post-approval conversion to deployment-ready status."
    - name: "background_check_status"
      expr: background_check_status
      comment: "Background check status for safeguarding compliance monitoring across the applicant pool."
    - name: "screening_status"
      expr: screening_status
      comment: "Screening stage status for pipeline bottleneck identification."
    - name: "application_date"
      expr: DATE_TRUNC('month', application_date)
      comment: "Month of application submission for trend analysis of recruitment pipeline volume."
    - name: "interview_outcome"
      expr: interview_outcome
      comment: "Outcome of the interview stage for quality-of-hire and selection process analysis."
  measures:
    - name: "total_applications"
      expr: COUNT(DISTINCT application_id)
      comment: "Total number of volunteer applications received — the top-of-funnel recruitment volume metric."
    - name: "approved_applications"
      expr: COUNT(DISTINCT CASE WHEN decision_status = 'approved' THEN application_id END)
      comment: "Number of applications approved — the primary conversion metric for the recruitment funnel."
    - name: "rejected_applications"
      expr: COUNT(DISTINCT CASE WHEN decision_status = 'rejected' THEN application_id END)
      comment: "Number of applications rejected, used to assess selection rigor and identify channel quality issues."
    - name: "background_check_completed_count"
      expr: COUNT(DISTINCT CASE WHEN background_check_status = 'completed' THEN application_id END)
      comment: "Applications with completed background checks — a safeguarding compliance throughput metric."
    - name: "onboarding_completed_count"
      expr: COUNT(DISTINCT CASE WHEN onboarding_status = 'completed' THEN application_id END)
      comment: "Applications that progressed to completed onboarding, measuring end-to-end recruitment funnel conversion."
    - name: "avg_hours_per_week_committed"
      expr: AVG(CAST(hours_per_week AS DOUBLE))
      comment: "Average weekly hours committed by applicants, informing capacity planning and role-fit assessment."
    - name: "safeguarding_acknowledged_count"
      expr: COUNT(DISTINCT CASE WHEN safeguarding_policy_acknowledged = TRUE THEN application_id END)
      comment: "Number of applicants who acknowledged the safeguarding policy — a mandatory compliance metric for duty-of-care obligations."
    - name: "code_of_conduct_signed_count"
      expr: COUNT(DISTINCT CASE WHEN code_of_conduct_signed = TRUE THEN application_id END)
      comment: "Number of applicants who signed the code of conduct, a governance and accountability compliance metric."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_hour_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer time contribution metrics tracking verified hours, in-kind value, and activity patterns to support donor reporting, grant compliance, and operational efficiency analysis."
  source: "`vibe_ngo_v1`.`volunteer`.`hour_log`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of volunteer activity performed, enabling analysis of time allocation across program areas."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the hour log entry for compliance and audit reporting."
    - name: "hour_log_date"
      expr: DATE_TRUNC('month', hour_log_date)
      comment: "Month of the hour log entry for trend analysis of volunteer time contributions."
    - name: "is_overtime"
      expr: is_overtime
      comment: "Indicates overtime hours for workload management and volunteer welfare monitoring."
    - name: "is_virtual"
      expr: is_virtual
      comment: "Indicates virtual vs. in-person activity for remote engagement analysis."
    - name: "is_group_activity"
      expr: is_group_activity
      comment: "Indicates whether the activity was group-based, enabling collective vs. individual contribution analysis."
    - name: "donor_report_eligible"
      expr: donor_report_eligible
      comment: "Flags hours eligible for donor reporting, critical for grant compliance and in-kind contribution documentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the fair market value rate for multi-currency in-kind valuation analysis."
  measures:
    - name: "total_hours_claimed"
      expr: SUM(CAST(hours_claimed AS DOUBLE))
      comment: "Total volunteer hours claimed across all log entries — the primary labor input metric for program delivery reporting."
    - name: "total_hours_verified"
      expr: SUM(CAST(hours_verified AS DOUBLE))
      comment: "Total verified volunteer hours — the audited, donor-reportable labor contribution metric."
    - name: "total_in_kind_value"
      expr: SUM(CAST(in_kind_value AS DOUBLE))
      comment: "Total in-kind monetary value of volunteer hours contributed, used for grant compliance and co-financing reporting."
    - name: "avg_fair_market_value_rate"
      expr: AVG(CAST(fair_market_value_rate AS DOUBLE))
      comment: "Average fair market value rate applied to volunteer hours, used to benchmark in-kind valuation methodology."
    - name: "donor_reportable_hours"
      expr: SUM(CASE WHEN donor_report_eligible = TRUE THEN hours_verified ELSE 0 END)
      comment: "Verified hours eligible for donor reporting — a critical grant compliance metric for demonstrating co-financing contributions."
    - name: "recognition_milestone_triggered_count"
      expr: COUNT(DISTINCT CASE WHEN recognition_milestone_triggered = TRUE THEN hour_log_id END)
      comment: "Number of hour log entries that triggered a recognition milestone, measuring the cadence of volunteer recognition events."
    - name: "avg_hours_claimed_per_log"
      expr: AVG(CAST(hours_claimed AS DOUBLE))
      comment: "Average hours claimed per log entry, used to detect anomalies and assess typical volunteer session duration."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_training_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training pipeline metrics tracking enrollment volume, completion rates, certification outcomes, and compliance training coverage to ensure volunteer readiness and regulatory adherence."
  source: "`vibe_ngo_v1`.`volunteer`.`training_enrollment`"
  dimensions:
    - name: "training_enrollment_status"
      expr: training_enrollment_status
      comment: "Current enrollment status (e.g. enrolled, completed, withdrawn) for pipeline and completion analysis."
    - name: "training_delivery_mode"
      expr: training_delivery_mode
      comment: "Delivery modality (e.g. in-person, online, blended) for effectiveness and cost comparison."
    - name: "mandatory_training_flag"
      expr: mandatory_training_flag
      comment: "Indicates mandatory vs. optional training for compliance coverage analysis."
    - name: "compliance_training_category"
      expr: compliance_training_category
      comment: "Compliance category of the training for regulatory and donor requirement tracking."
    - name: "training_language"
      expr: training_language
      comment: "Language of training delivery for accessibility and inclusion analysis."
    - name: "training_enrollment_date"
      expr: DATE_TRUNC('month', training_enrollment_date)
      comment: "Month of enrollment for trend analysis of training pipeline volume."
    - name: "recertification_required_flag"
      expr: recertification_required_flag
      comment: "Indicates whether recertification is required, for proactive compliance renewal planning."
  measures:
    - name: "total_enrollments"
      expr: COUNT(DISTINCT training_enrollment_id)
      comment: "Total training enrollments — the primary throughput metric for volunteer capacity building programs."
    - name: "completed_enrollments"
      expr: COUNT(DISTINCT CASE WHEN training_enrollment_status = 'completed' THEN training_enrollment_id END)
      comment: "Number of training enrollments completed — the key outcome metric for training program effectiveness."
    - name: "mandatory_training_completions"
      expr: COUNT(DISTINCT CASE WHEN mandatory_training_flag = TRUE AND training_enrollment_status = 'completed' THEN training_enrollment_id END)
      comment: "Completions of mandatory training — a compliance KPI ensuring volunteers meet required readiness standards."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across training enrollments, measuring knowledge acquisition and training quality."
    - name: "total_training_hours_delivered"
      expr: SUM(CAST(training_hours AS DOUBLE))
      comment: "Total training hours delivered across all enrollments — an investment and capacity building impact metric."
    - name: "total_training_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total cost of training enrollments, enabling cost-per-completion and training ROI analysis."
    - name: "avg_training_cost_per_enrollment"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per training enrollment for budget efficiency benchmarking."
    - name: "certifications_issued_count"
      expr: COUNT(DISTINCT CASE WHEN certification_issued_flag = TRUE THEN training_enrollment_id END)
      comment: "Number of certifications issued through training completions, measuring credentialing program output."
    - name: "total_continuing_education_credits"
      expr: SUM(CAST(continuing_education_credits AS DOUBLE))
      comment: "Total continuing education credits earned across enrollments, supporting professional development reporting."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_team`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Team-level metrics tracking size, capacity, performance, and budget utilization of volunteer teams to support operational planning and team effectiveness decisions."
  source: "`vibe_ngo_v1`.`volunteer`.`volunteer_team`"
  dimensions:
    - name: "volunteer_team_status"
      expr: volunteer_team_status
      comment: "Current operational status of the team (e.g. active, dissolved) for portfolio management."
    - name: "volunteer_team_type"
      expr: volunteer_team_type
      comment: "Type of volunteer team for segmenting operational patterns and resource allocation."
    - name: "geographic_area"
      expr: geographic_area
      comment: "Geographic area of team operations for regional capacity and coverage analysis."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary operating language of the team for accessibility and community engagement analysis."
    - name: "training_completion_required"
      expr: training_completion_required
      comment: "Whether training completion is required for team membership, for compliance readiness tracking."
    - name: "formation_date"
      expr: DATE_TRUNC('year', formation_date)
      comment: "Year of team formation for cohort analysis of team longevity and performance trends."
  measures:
    - name: "total_teams"
      expr: COUNT(DISTINCT volunteer_team_id)
      comment: "Total number of volunteer teams — the primary organizational capacity metric for field operations."
    - name: "total_volunteer_hours_by_teams"
      expr: SUM(CAST(total_volunteer_hours AS DOUBLE))
      comment: "Total volunteer hours contributed across all teams — the aggregate labor impact metric for team-based operations."
    - name: "total_budget_allocation"
      expr: SUM(CAST(budget_allocation AS DOUBLE))
      comment: "Total budget allocated across volunteer teams, enabling financial planning and cost-per-team analysis."
    - name: "avg_budget_per_team"
      expr: AVG(CAST(budget_allocation AS DOUBLE))
      comment: "Average budget allocation per team for equity and efficiency benchmarking across the portfolio."
    - name: "avg_performance_rating_teams"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average performance rating across teams — a quality indicator for team management and intervention prioritization."
    - name: "total_recognition_awards"
      expr: SUM(CAST(recognition_awards_count AS DOUBLE))
      comment: "Total recognition awards earned across teams, measuring the reach and impact of volunteer recognition programs."
    - name: "total_safety_incidents"
      expr: SUM(CAST(safety_incidents_count AS DOUBLE))
      comment: "Total safety incidents reported across teams — a critical risk and duty-of-care metric for leadership oversight."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_stipend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stipend disbursement metrics tracking financial obligations, payment compliance, and cost distribution for volunteer stipend programs to support budget management and donor reporting."
  source: "`vibe_ngo_v1`.`volunteer`.`stipend`"
  dimensions:
    - name: "stipend_type"
      expr: stipend_type
      comment: "Type of stipend (e.g. transport, subsistence, in-kind) for cost category analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the stipend for payment pipeline and compliance monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the stipend for multi-currency financial reporting."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g. bank transfer, mobile money) for operational efficiency and inclusion analysis."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of stipend payments for cash flow planning."
    - name: "tax_reportable_flag"
      expr: tax_reportable_flag
      comment: "Indicates tax-reportable stipends for regulatory compliance tracking."
    - name: "donor_reportable_flag"
      expr: donor_reportable_flag
      comment: "Indicates stipends reportable to donors for grant compliance and co-financing documentation."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the stipend for annual budget and expenditure analysis."
    - name: "disbursement_date"
      expr: DATE_TRUNC('month', disbursement_date)
      comment: "Month of disbursement for cash flow trend analysis."
  measures:
    - name: "total_stipend_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total stipend amount disbursed — the primary financial obligation metric for volunteer compensation programs."
    - name: "avg_stipend_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average stipend amount per record for benchmarking and equity analysis across volunteer cohorts."
    - name: "total_reporting_currency_amount"
      expr: SUM(CAST(reporting_currency_amount AS DOUBLE))
      comment: "Total stipend value in reporting currency for consolidated financial and donor reporting."
    - name: "total_stipends_disbursed"
      expr: COUNT(DISTINCT stipend_id)
      comment: "Total number of stipend payments processed — a throughput metric for the volunteer compensation program."
    - name: "donor_reportable_stipend_amount"
      expr: SUM(CASE WHEN donor_reportable_flag = TRUE THEN amount ELSE 0 END)
      comment: "Total stipend amount reportable to donors — a grant compliance metric for co-financing and in-kind contribution documentation."
    - name: "tax_reportable_stipend_amount"
      expr: SUM(CASE WHEN tax_reportable_flag = TRUE THEN amount ELSE 0 END)
      comment: "Total stipend amount subject to tax reporting — a regulatory compliance metric for statutory obligations."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to stipend conversions, used to monitor currency risk exposure in multi-country programs."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer certification metrics tracking credential coverage, compliance, cost, and expiry risk to ensure volunteers meet role requirements and organizational standards."
  source: "`vibe_ngo_v1`.`volunteer`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification for segmenting credential portfolio by category."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the certification for compliance and audit reporting."
    - name: "skill_category"
      expr: skill_category
      comment: "Skill category associated with the certification for workforce capability analysis."
    - name: "mandatory_for_role"
      expr: mandatory_for_role
      comment: "Indicates whether the certification is mandatory for the assigned role — critical for deployment eligibility compliance."
    - name: "deployment_eligible"
      expr: deployment_eligible
      comment: "Whether the certification makes the volunteer eligible for deployment, a key readiness metric."
    - name: "renewal_required"
      expr: renewal_required
      comment: "Indicates certifications requiring renewal for proactive expiry risk management."
    - name: "reimbursed_by_organization"
      expr: reimbursed_by_organization
      comment: "Whether the organization reimbursed the certification cost, for financial planning and volunteer support analysis."
    - name: "issue_date"
      expr: DATE_TRUNC('year', issue_date)
      comment: "Year of certification issuance for cohort and trend analysis."
  measures:
    - name: "total_certifications"
      expr: COUNT(DISTINCT certification_id)
      comment: "Total certifications held across the volunteer workforce — a headline capability and compliance metric."
    - name: "verified_certifications"
      expr: COUNT(DISTINCT CASE WHEN verification_status = 'verified' THEN certification_id END)
      comment: "Number of certifications that have been formally verified — the audited credential compliance metric."
    - name: "deployment_eligible_certifications"
      expr: COUNT(DISTINCT CASE WHEN deployment_eligible = TRUE THEN certification_id END)
      comment: "Certifications that qualify volunteers for deployment, measuring deployment-ready credential coverage."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of certifications across the volunteer workforce for budget planning and ROI analysis."
    - name: "avg_certification_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per certification for benchmarking and cost management decisions."
    - name: "total_training_hours_for_certifications"
      expr: SUM(CAST(training_hours AS DOUBLE))
      comment: "Total training hours invested in achieving certifications — an input metric for capability building investment analysis."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across certifications, measuring the quality of volunteer knowledge acquisition."
    - name: "expiring_certifications_count"
      expr: COUNT(DISTINCT CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND expiry_date >= CURRENT_DATE() THEN certification_id END)
      comment: "Certifications expiring within 90 days — a proactive risk metric for maintaining deployment eligibility and compliance."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_incident_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer incident metrics tracking safety events, investigation outcomes, and severity patterns to support duty-of-care obligations, risk management, and safeguarding compliance."
  source: "`vibe_ngo_v1`.`volunteer`.`incident_report`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of incident for categorizing safety events and identifying systemic risk patterns."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the incident for prioritizing response and escalation decisions."
    - name: "incident_report_status"
      expr: incident_report_status
      comment: "Current status of the incident report for pipeline and resolution tracking."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the investigation for accountability and compliance monitoring."
    - name: "country_code"
      expr: country_code
      comment: "Country where the incident occurred for geographic risk analysis."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the incident report for data governance and access control."
    - name: "incident_date"
      expr: DATE_TRUNC('month', incident_date)
      comment: "Month of incident occurrence for trend analysis of safety event frequency."
    - name: "medical_attention_required"
      expr: medical_attention_required
      comment: "Indicates incidents requiring medical attention — a critical severity and welfare metric."
  measures:
    - name: "total_incidents"
      expr: COUNT(DISTINCT incident_report_id)
      comment: "Total number of volunteer incidents reported — the primary safety and risk monitoring metric."
    - name: "open_incidents"
      expr: COUNT(DISTINCT CASE WHEN incident_report_status NOT IN ('closed', 'resolved') THEN incident_report_id END)
      comment: "Number of incidents not yet resolved — an operational risk metric requiring leadership attention."
    - name: "investigation_required_count"
      expr: COUNT(DISTINCT CASE WHEN investigation_required = TRUE THEN incident_report_id END)
      comment: "Incidents requiring formal investigation — a governance and accountability compliance metric."
    - name: "medical_attention_incidents"
      expr: COUNT(DISTINCT CASE WHEN medical_attention_required = TRUE THEN incident_report_id END)
      comment: "Incidents requiring medical attention — a critical volunteer welfare and duty-of-care metric."
    - name: "insurance_claims_filed"
      expr: COUNT(DISTINCT CASE WHEN insurance_claim_filed = TRUE THEN incident_report_id END)
      comment: "Number of incidents resulting in insurance claims — a financial risk and liability exposure metric."
    - name: "police_reports_filed"
      expr: COUNT(DISTINCT CASE WHEN police_report_filed = TRUE THEN incident_report_id END)
      comment: "Number of incidents escalated to police reporting — a serious safeguarding and legal compliance metric."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_redeployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Redeployment metrics tracking the volume and patterns of volunteer redeployments to assess workforce flexibility, retention, and operational continuity."
  source: "`vibe_ngo_v1`.`volunteer`.`volunteer_redeployment`"
  dimensions:
    - name: "volunteer_redeployment_id"
      expr: volunteer_redeployment_id
      comment: "Primary key of the redeployment record, used as a grain identifier for redeployment event analysis."
  measures:
    - name: "total_redeployments"
      expr: COUNT(DISTINCT volunteer_redeployment_id)
      comment: "Total number of volunteer redeployments — measures workforce flexibility and the organization's ability to redeploy volunteers across programs and geographies."
    - name: "unique_volunteers_redeployed"
      expr: COUNT(DISTINCT volunteer_id)
      comment: "Number of distinct volunteers who have been redeployed at least once — indicates the depth of the redeployable volunteer pool."
    - name: "unique_deployments_with_redeployment"
      expr: COUNT(DISTINCT volunteer_deployment_id)
      comment: "Number of distinct original deployments that generated a redeployment, measuring the breadth of redeployment activity across the deployment portfolio."
$$;