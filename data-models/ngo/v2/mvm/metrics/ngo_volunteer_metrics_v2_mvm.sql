-- Metric views for domain: volunteer | Business: Ngo | Version: 2 | Generated on: 2026-07-10 20:18:10

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for volunteer recruitment pipeline health — tracks application conversion, screening throughput, onboarding efficiency, and background check compliance across the volunteer intake funnel."
  source: "`vibe_ngo_v1`.`volunteer`.`application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the volunteer application (e.g., Submitted, Under Review, Approved, Rejected) — primary funnel stage dimension."
    - name: "decision_status"
      expr: decision_status
      comment: "Final decision outcome on the application — used to segment approved vs. rejected vs. pending cohorts."
    - name: "recruitment_channel"
      expr: recruitment_channel
      comment: "Channel through which the volunteer was recruited (e.g., social media, referral, event) — critical for channel effectiveness analysis."
    - name: "screening_status"
      expr: screening_status
      comment: "Current screening stage status — used to identify bottlenecks in the pre-approval pipeline."
    - name: "background_check_outcome"
      expr: background_check_outcome
      comment: "Outcome of the background check (e.g., Clear, Flagged, Pending) — compliance and risk dimension."
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current onboarding stage of the applicant — tracks readiness to deploy."
    - name: "application_month"
      expr: DATE_TRUNC('MONTH', application_date)
      comment: "Month of application submission — enables trend analysis of recruitment volume over time."
    - name: "commitment_duration_months"
      expr: commitment_duration_months
      comment: "Volunteer's stated commitment duration in months — used to segment short-term vs. long-term volunteer pipelines."
    - name: "background_check_required"
      expr: background_check_required
      comment: "Whether a background check is required for this application — used to filter compliance-sensitive roles."
    - name: "interview_outcome"
      expr: interview_outcome
      comment: "Outcome of the volunteer interview — used to assess interview-to-approval conversion quality."
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of volunteer applications submitted — baseline pipeline volume metric for recruitment capacity planning."
    - name: "approved_applications"
      expr: COUNT(CASE WHEN decision_status = 'Approved' THEN 1 END)
      comment: "Count of applications with an Approved decision status — measures recruitment success throughput."
    - name: "rejected_applications"
      expr: COUNT(CASE WHEN decision_status = 'Rejected' THEN 1 END)
      comment: "Count of applications with a Rejected decision status — used to monitor rejection rates and identify screening quality issues."
    - name: "application_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN decision_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications that result in approval — key funnel conversion KPI for recruitment effectiveness."
    - name: "background_check_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN background_check_completed_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN background_check_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of required background checks that have been completed — compliance health KPI for safeguarding obligations."
    - name: "onboarding_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN onboarding_completed_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN decision_status = 'Approved' THEN 1 END), 0), 2)
      comment: "Percentage of approved applicants who have completed onboarding — measures readiness-to-deploy efficiency."
    - name: "avg_committed_hours_per_week"
      expr: AVG(CAST(hours_per_week AS DOUBLE))
      comment: "Average weekly hours committed by applicants — used to estimate total volunteer capacity entering the pipeline."
    - name: "code_of_conduct_signed_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN code_of_conduct_signed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applicants who have signed the code of conduct — governance and compliance KPI for safeguarding standards."
    - name: "interview_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN interview_completed_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN interview_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of required interviews that have been completed — operational efficiency KPI for the recruitment process."
    - name: "orientation_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN orientation_completed = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN decision_status = 'Approved' THEN 1 END), 0), 2)
      comment: "Percentage of approved volunteers who have completed orientation — readiness and compliance metric before deployment."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_hour_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and strategic KPIs for volunteer time contribution — tracks verified hours, in-kind value, approval rates, and activity throughput to inform resource allocation and donor reporting."
  source: "`vibe_ngo_v1`.`volunteer`.`hour_log`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of volunteer activity performed — primary dimension for understanding how volunteer time is allocated across program activities."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the hour log entry (e.g., Pending, Approved, Rejected) — used to filter verified vs. unverified contributions."
    - name: "hour_log_month"
      expr: DATE_TRUNC('MONTH', hour_log_date)
      comment: "Month of the logged volunteer hours — enables trend analysis of volunteer engagement over time."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the hour log (e.g., mobile app, web portal, paper) — used to assess digital adoption and data quality."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify the hours (e.g., supervisor sign-off, GPS, system) — quality and audit dimension."
    - name: "is_virtual"
      expr: is_virtual
      comment: "Whether the activity was performed virtually — used to track remote vs. in-person volunteer engagement."
    - name: "is_group_activity"
      expr: is_group_activity
      comment: "Whether the activity was a group activity — used to distinguish individual vs. team-based contributions."
    - name: "donor_report_eligible"
      expr: donor_report_eligible
      comment: "Whether the hour log entry is eligible for donor reporting — critical for grant compliance and in-kind contribution reporting."
    - name: "cost_center"
      expr: cost_center
      comment: "Cost center associated with the volunteer activity — used for financial allocation and budget tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for in-kind value calculations — required for multi-currency financial reporting."
  measures:
    - name: "total_hours_claimed"
      expr: SUM(CAST(hours_claimed AS DOUBLE))
      comment: "Total volunteer hours claimed across all log entries — primary volume metric for volunteer time contribution."
    - name: "total_hours_verified"
      expr: SUM(CAST(hours_verified AS DOUBLE))
      comment: "Total volunteer hours that have been verified and approved — the authoritative measure of confirmed volunteer contribution."
    - name: "hour_verification_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(hours_verified AS DOUBLE)) / NULLIF(SUM(CAST(hours_claimed AS DOUBLE)), 0), 2)
      comment: "Percentage of claimed hours that have been verified — data quality and operational efficiency KPI for hour log management."
    - name: "total_in_kind_value"
      expr: SUM(CAST(in_kind_value AS DOUBLE))
      comment: "Total monetary in-kind value of volunteer hours contributed — critical for donor reporting, grant compliance, and cost-sharing calculations."
    - name: "avg_fair_market_value_rate"
      expr: AVG(CAST(fair_market_value_rate AS DOUBLE))
      comment: "Average fair market value rate applied to volunteer hours — used to assess consistency of in-kind valuation methodology."
    - name: "total_log_entries"
      expr: COUNT(1)
      comment: "Total number of hour log entries submitted — baseline activity volume metric for volunteer engagement tracking."
    - name: "approved_log_entries"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Count of hour log entries with Approved status — measures the volume of confirmed volunteer contributions."
    - name: "donor_reportable_hours"
      expr: SUM(CASE WHEN donor_report_eligible = TRUE THEN CAST(hours_verified AS DOUBLE) ELSE 0 END)
      comment: "Total verified hours eligible for donor reporting — directly supports grant compliance and donor stewardship reporting."
    - name: "donor_reportable_in_kind_value"
      expr: SUM(CASE WHEN donor_report_eligible = TRUE THEN CAST(in_kind_value AS DOUBLE) ELSE 0 END)
      comment: "Total in-kind value of donor-reportable volunteer hours — key metric for grant financial reporting and cost-sharing obligations."
    - name: "avg_hours_per_log_entry"
      expr: AVG(CAST(hours_claimed AS DOUBLE))
      comment: "Average hours claimed per log entry — used to assess typical volunteer session length and identify outliers."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for volunteer deployment effectiveness — tracks planned vs. actual hours, FTE utilization, deployment completion rates, and performance ratings to inform operational planning and resource allocation."
  source: "`vibe_ngo_v1`.`volunteer`.`volunteer_deployment`"
  dimensions:
    - name: "volunteer_deployment_status"
      expr: volunteer_deployment_status
      comment: "Current status of the deployment (e.g., Active, Completed, Withdrawn, Planned) — primary lifecycle dimension for deployment pipeline analysis."
    - name: "volunteer_deployment_type"
      expr: volunteer_deployment_type
      comment: "Type of deployment (e.g., Emergency Response, Development, Capacity Building) — used to segment deployments by programmatic purpose."
    - name: "deployment_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the deployment was scheduled to start — enables trend analysis of deployment volume over time."
    - name: "region"
      expr: region
      comment: "Geographic region of the deployment — used for geographic distribution analysis of volunteer resources."
    - name: "remote_deployment_flag"
      expr: remote_deployment_flag
      comment: "Whether the deployment is remote — used to track the split between in-person and remote volunteer deployments."
    - name: "priority"
      expr: priority
      comment: "Priority level of the deployment — used to ensure high-priority deployments are adequately resourced."
    - name: "security_clearance_level"
      expr: security_clearance_level
      comment: "Security clearance level required for the deployment — used for risk and compliance segmentation."
    - name: "orientation_completed_flag"
      expr: orientation_completed_flag
      comment: "Whether orientation was completed before deployment — compliance and readiness dimension."
    - name: "recognition_awarded_flag"
      expr: recognition_awarded_flag
      comment: "Whether a recognition award was given for this deployment — used to track volunteer recognition program reach."
  measures:
    - name: "total_deployments"
      expr: COUNT(1)
      comment: "Total number of volunteer deployments — baseline volume metric for operational capacity planning."
    - name: "active_deployments"
      expr: COUNT(CASE WHEN volunteer_deployment_status = 'Active' THEN 1 END)
      comment: "Count of currently active deployments — real-time operational capacity metric for field management."
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours AS DOUBLE))
      comment: "Total planned volunteer hours across all deployments — used for capacity planning and resource forecasting."
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual volunteer hours delivered across all deployments — the authoritative measure of volunteer time contribution."
    - name: "hours_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_hours AS DOUBLE)) / NULLIF(SUM(CAST(planned_hours AS DOUBLE)), 0), 2)
      comment: "Percentage of planned hours that were actually delivered — key operational efficiency KPI for deployment planning accuracy."
    - name: "total_hours_contributed"
      expr: SUM(CAST(hours_contributed AS DOUBLE))
      comment: "Total hours contributed as recorded on the deployment record — used for program-level volunteer contribution reporting."
    - name: "total_fte_equivalent"
      expr: SUM(CAST(fte_equivalent AS DOUBLE))
      comment: "Total FTE equivalent of all volunteer deployments — translates volunteer time into staffing equivalents for budget and capacity analysis."
    - name: "avg_performance_rating"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average performance rating across deployments — quality KPI for volunteer effectiveness and program delivery standards."
    - name: "deployment_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN volunteer_deployment_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deployments that reached Completed status — measures program delivery reliability and volunteer retention through deployment."
    - name: "withdrawal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN withdrawal_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deployments that ended in withdrawal — risk and retention KPI; high rates signal volunteer experience or program design issues."
    - name: "orientation_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN orientation_completed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deployments where orientation was completed — safeguarding and compliance KPI for pre-deployment readiness."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_training_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for volunteer training program effectiveness — tracks completion rates, certification issuance, assessment performance, training costs, and compliance training coverage."
  source: "`vibe_ngo_v1`.`volunteer`.`training_enrollment`"
  dimensions:
    - name: "training_enrollment_status"
      expr: training_enrollment_status
      comment: "Current enrollment status (e.g., Enrolled, Completed, Withdrawn, Failed) — primary lifecycle dimension for training pipeline analysis."
    - name: "training_delivery_mode"
      expr: training_delivery_mode
      comment: "Mode of training delivery (e.g., In-Person, Online, Blended) — used to assess effectiveness and cost efficiency by modality."
    - name: "compliance_training_category"
      expr: compliance_training_category
      comment: "Category of compliance training (e.g., Safeguarding, PSEA, Security) — critical for regulatory and donor compliance reporting."
    - name: "mandatory_training_flag"
      expr: mandatory_training_flag
      comment: "Whether the training is mandatory — used to prioritize compliance tracking for required vs. optional training."
    - name: "certification_issued_flag"
      expr: certification_issued_flag
      comment: "Whether a certification was issued upon completion — used to track credentialing outcomes."
    - name: "recertification_required_flag"
      expr: recertification_required_flag
      comment: "Whether recertification is required — used to proactively manage certification expiry and compliance risk."
    - name: "training_enrollment_month"
      expr: DATE_TRUNC('MONTH', training_enrollment_date)
      comment: "Month of training enrollment — enables trend analysis of training uptake over time."
    - name: "training_language"
      expr: training_language
      comment: "Language in which the training was delivered — used to assess language accessibility and inclusion in training programs."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for training cost reporting — required for multi-currency financial analysis."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total number of training enrollments — baseline volume metric for training program reach and capacity utilization."
    - name: "training_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN training_enrollment_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments that resulted in completion — primary KPI for training program effectiveness and volunteer engagement."
    - name: "certification_issuance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_issued_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN training_enrollment_status = 'Completed' THEN 1 END), 0), 2)
      comment: "Percentage of completed enrollments that resulted in certification issuance — measures credentialing program effectiveness."
    - name: "mandatory_training_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mandatory_training_flag = TRUE AND training_enrollment_status = 'Completed' THEN 1 END) / NULLIF(COUNT(CASE WHEN mandatory_training_flag = TRUE THEN 1 END), 0), 2)
      comment: "Completion rate for mandatory training — critical compliance KPI for safeguarding, PSEA, and donor requirements."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across all enrollments — measures knowledge retention and training quality outcomes."
    - name: "total_training_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total cost of training enrollments — financial KPI for training budget management and cost-per-volunteer analysis."
    - name: "total_training_hours_delivered"
      expr: SUM(CAST(training_hours AS DOUBLE))
      comment: "Total training hours delivered across all enrollments — measures the scale of capacity building investment in volunteers."
    - name: "total_continuing_education_credits"
      expr: SUM(CAST(continuing_education_credits AS DOUBLE))
      comment: "Total continuing education credits earned by volunteers — used to track professional development outcomes and donor reporting on capacity building."
    - name: "withdrawal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN training_withdrawal_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments that ended in withdrawal — quality signal for training relevance, accessibility, and volunteer experience."
    - name: "avg_cost_per_enrollment"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per training enrollment — efficiency KPI for training budget optimization and cost benchmarking across modalities."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for volunteer workforce composition and capacity — tracks active volunteer pool size, availability, onboarding status, geographic distribution, and cumulative contribution to inform talent management decisions."
  source: "`vibe_ngo_v1`.`volunteer`.`volunteer`"
  dimensions:
    - name: "volunteer_type"
      expr: volunteer_type
      comment: "Type of volunteer (e.g., Individual, Corporate, Pro-Bono Professional) — primary segmentation dimension for volunteer workforce analysis."
    - name: "availability_status"
      expr: availability_status
      comment: "Current availability status of the volunteer (e.g., Available, Deployed, On Leave) — operational dimension for capacity planning."
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current onboarding status of the volunteer — used to track pipeline readiness and identify bottlenecks in volunteer activation."
    - name: "gender"
      expr: gender
      comment: "Gender of the volunteer — used for diversity, equity, and inclusion (DEI) reporting and donor compliance on gender balance."
    - name: "nationality"
      expr: nationality
      comment: "Nationality of the volunteer — used for geographic diversity analysis and visa/compliance planning."
    - name: "country_code"
      expr: country_code
      comment: "Country of residence of the volunteer — used for geographic distribution analysis of the volunteer workforce."
    - name: "recognition_level"
      expr: recognition_level
      comment: "Recognition tier of the volunteer (e.g., Bronze, Silver, Gold) — used to track volunteer retention and loyalty program effectiveness."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the volunteer — used for language capacity planning and program accessibility analysis."
    - name: "background_check_status"
      expr: background_check_status
      comment: "Current background check status of the volunteer — compliance dimension for safeguarding and risk management."
    - name: "willing_to_travel"
      expr: willing_to_travel
      comment: "Whether the volunteer is willing to travel — used to segment deployable vs. local volunteer capacity."
  measures:
    - name: "total_volunteers"
      expr: COUNT(DISTINCT volunteer_id)
      comment: "Total number of unique volunteers in the system — baseline workforce size metric for capacity planning and program scaling decisions."
    - name: "available_volunteers"
      expr: COUNT(CASE WHEN availability_status = 'Available' THEN 1 END)
      comment: "Count of volunteers currently available for deployment — real-time capacity metric for operational planning."
    - name: "onboarded_volunteers"
      expr: COUNT(CASE WHEN onboarding_completion_date IS NOT NULL THEN 1 END)
      comment: "Count of volunteers who have completed onboarding — measures the deployable volunteer pool size."
    - name: "onboarding_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN onboarding_completion_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of volunteers who have completed onboarding — activation efficiency KPI for volunteer management."
    - name: "total_cumulative_volunteer_hours"
      expr: SUM(CAST(total_volunteer_hours AS DOUBLE))
      comment: "Sum of total volunteer hours across all volunteers — aggregate contribution metric for program impact reporting and donor communications."
    - name: "avg_volunteer_hours_per_volunteer"
      expr: AVG(CAST(total_volunteer_hours AS DOUBLE))
      comment: "Average total hours contributed per volunteer — engagement depth metric; low averages signal retention or activation issues."
    - name: "avg_availability_hours_per_week"
      expr: AVG(CAST(availability_hours_per_week AS DOUBLE))
      comment: "Average weekly hours volunteers are available — used to estimate total available volunteer capacity for program planning."
    - name: "background_check_cleared_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN background_check_status = 'Cleared' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of volunteers with a cleared background check — safeguarding compliance KPI for organizational risk management."
    - name: "travel_willing_volunteers"
      expr: COUNT(CASE WHEN willing_to_travel = TRUE THEN 1 END)
      comment: "Count of volunteers willing to travel — deployable field capacity metric for emergency response and remote program planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_team`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for volunteer team performance and capacity — tracks team size, budget utilization, total hours contributed, and operational status to inform team management and program delivery decisions."
  source: "`vibe_ngo_v1`.`volunteer`.`volunteer_team`"
  dimensions:
    - name: "volunteer_team_status"
      expr: volunteer_team_status
      comment: "Current operational status of the team (e.g., Active, Dissolved, Forming) — primary lifecycle dimension for team portfolio management."
    - name: "volunteer_team_type"
      expr: volunteer_team_type
      comment: "Type of volunteer team (e.g., Emergency Response, Community Outreach, Technical) — used to segment teams by programmatic function."
    - name: "geographic_area"
      expr: geographic_area
      comment: "Geographic area of team operations — used for geographic distribution analysis of volunteer team capacity."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary operating language of the team — used for language capacity and inclusion analysis."
    - name: "meeting_frequency"
      expr: meeting_frequency
      comment: "How frequently the team meets — used to assess team cohesion and operational engagement levels."
    - name: "training_completion_required"
      expr: training_completion_required
      comment: "Whether training completion is required for team membership — compliance dimension for team readiness standards."
    - name: "formation_month"
      expr: DATE_TRUNC('MONTH', formation_date)
      comment: "Month the team was formed — enables cohort analysis of team performance over time."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for budget reporting — required for multi-currency financial analysis."
  measures:
    - name: "total_teams"
      expr: COUNT(1)
      comment: "Total number of volunteer teams — baseline portfolio size metric for organizational capacity planning."
    - name: "active_teams"
      expr: COUNT(CASE WHEN volunteer_team_status = 'Active' THEN 1 END)
      comment: "Count of currently active volunteer teams — real-time operational capacity metric for program management."
    - name: "total_budget_allocation"
      expr: SUM(CAST(budget_allocation AS DOUBLE))
      comment: "Total budget allocated across all volunteer teams — financial planning KPI for volunteer program investment management."
    - name: "avg_budget_per_team"
      expr: AVG(CAST(budget_allocation AS DOUBLE))
      comment: "Average budget allocated per volunteer team — used to assess equity of resource distribution and identify under-resourced teams."
    - name: "total_team_volunteer_hours"
      expr: SUM(CAST(total_volunteer_hours AS DOUBLE))
      comment: "Total volunteer hours contributed across all teams — aggregate impact metric for program delivery reporting."
    - name: "avg_team_volunteer_hours"
      expr: AVG(CAST(total_volunteer_hours AS DOUBLE))
      comment: "Average volunteer hours contributed per team — team productivity benchmark for performance management."
    - name: "team_dissolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dissolution_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of teams that have been dissolved — organizational health KPI; high rates may signal structural or programmatic issues."
$$;