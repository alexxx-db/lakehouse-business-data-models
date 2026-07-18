-- Metric views for domain: studentlife | Business: Education | Version: 1 | Generated on: 2026-05-06 15:08:33

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`studentlife_campus_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for campus event portfolio management — tracks event financial performance, engagement capacity, co-curricular credit delivery, and virtual/hybrid adoption to inform Student Affairs resource allocation and programming investment decisions."
  source: "`education_ecm`.`studentlife`.`campus_event`"
  dimensions:
    - name: "event_category"
      expr: event_category
      comment: "Categorical classification of the event (e.g., Academic, Social, Athletic) used to segment programming spend and attendance patterns."
    - name: "event_type"
      expr: event_type
      comment: "Operational type of the event (e.g., Workshop, Lecture, Ceremony) enabling granular programming analysis."
    - name: "event_status"
      expr: event_status
      comment: "Current lifecycle status of the event (e.g., Scheduled, Completed, Cancelled) for pipeline and completion tracking."
    - name: "target_audience"
      expr: target_audience
      comment: "Intended student population for the event, enabling audience-segmented engagement analysis."
    - name: "is_virtual_event"
      expr: virtual_event_flag
      comment: "Indicates whether the event is delivered fully virtually, supporting modality trend analysis."
    - name: "is_hybrid_event"
      expr: hybrid_event_flag
      comment: "Indicates whether the event uses a hybrid delivery model, supporting modality mix reporting."
    - name: "is_cocurricular_credit_eligible"
      expr: cocurricular_credit_eligible_flag
      comment: "Flags events that award co-curricular credit, enabling credit-bearing programming portfolio analysis."
    - name: "registration_required"
      expr: registration_required_flag
      comment: "Indicates whether advance registration is required, relevant for capacity planning and no-show risk."
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', event_start_datetime)
      comment: "Month bucket of event start date for time-series trend analysis of programming volume and spend."
    - name: "approval_required"
      expr: approval_required_flag
      comment: "Indicates whether the event required institutional approval, useful for governance and compliance reporting."
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of campus events. Baseline volume metric for programming portfolio sizing and trend analysis."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted spend across all campus events. Core financial planning KPI for Student Affairs budget stewardship."
    - name: "total_actual_expense_amount"
      expr: SUM(CAST(actual_expense_amount AS DOUBLE))
      comment: "Total actual expenditure across all campus events. Compared against budget to assess financial discipline."
    - name: "avg_budget_per_event"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budgeted cost per event. Benchmarks programming investment intensity and informs future budget requests."
    - name: "avg_actual_expense_per_event"
      expr: AVG(CAST(actual_expense_amount AS DOUBLE))
      comment: "Average actual spend per event. Tracks cost efficiency and identifies over/under-spend patterns by event type."
    - name: "total_registration_fee_revenue"
      expr: SUM(CAST(registration_fee_amount AS DOUBLE))
      comment: "Total registration fee revenue collected across events. Measures self-funding capacity of the event portfolio."
    - name: "total_cocurricular_credit_hours"
      expr: SUM(CAST(cocurricular_credit_hours AS DOUBLE))
      comment: "Total co-curricular credit hours available across eligible events. Tracks institutional commitment to experiential learning outside the classroom."
    - name: "budget_variance_amount"
      expr: SUM(CAST(actual_expense_amount AS DOUBLE) - CAST(budget_amount AS DOUBLE))
      comment: "Aggregate budget variance (actual minus budget) across all events. Positive values indicate overspend; negative values indicate underspend. Critical for financial oversight."
    - name: "cancelled_event_count"
      expr: COUNT(CASE WHEN event_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled events. High cancellation rates signal operational or planning failures that require leadership intervention."
    - name: "virtual_event_count"
      expr: COUNT(CASE WHEN virtual_event_flag = TRUE THEN 1 END)
      comment: "Count of fully virtual events. Tracks digital programming adoption and informs technology investment decisions."
    - name: "cocurricular_eligible_event_count"
      expr: COUNT(CASE WHEN cocurricular_credit_eligible_flag = TRUE THEN 1 END)
      comment: "Number of events eligible for co-curricular credit. Measures breadth of experiential learning opportunities offered."
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`studentlife_conduct_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for student conduct program oversight — tracks case volume, resolution timelines, appeal rates, sanction outcomes, and transcript notation rates to inform Dean of Students risk management and policy effectiveness decisions."
  source: "`education_ecm`.`studentlife`.`conduct_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the conduct case (e.g., Open, Closed, Under Appeal) for pipeline and workload management."
    - name: "violation_type_primary"
      expr: violation_type_primary
      comment: "Primary category of the alleged policy violation, enabling trend analysis of misconduct patterns."
    - name: "violation_type_secondary"
      expr: violation_type_secondary
      comment: "Secondary violation category for multi-violation cases, supporting nuanced policy enforcement analysis."
    - name: "finding"
      expr: finding
      comment: "Outcome determination of the conduct hearing (e.g., Responsible, Not Responsible, Dismissed) for outcome distribution analysis."
    - name: "sanction_primary"
      expr: sanction_primary
      comment: "Primary sanction imposed (e.g., Probation, Suspension, Expulsion) for sanction severity distribution reporting."
    - name: "hearing_type"
      expr: hearing_type
      comment: "Type of hearing conducted (e.g., Administrative, Panel) for process efficiency benchmarking."
    - name: "reporting_party_type"
      expr: reporting_party_type
      comment: "Category of the reporting party (e.g., Faculty, Staff, Student, Anonymous) for referral source analysis."
    - name: "appeal_filed"
      expr: appeal_filed_flag
      comment: "Indicates whether an appeal was filed, enabling appeal rate tracking as a proxy for process fairness perception."
    - name: "transcript_notation"
      expr: transcript_notation_flag
      comment: "Indicates whether a transcript notation was applied, tracking the most consequential long-term student impact."
    - name: "incident_occurrence_month"
      expr: DATE_TRUNC('MONTH', incident_occurrence_date)
      comment: "Month of incident occurrence for seasonal misconduct trend analysis."
    - name: "sanction_completion_status"
      expr: sanction_completion_status
      comment: "Status of sanction completion (e.g., Completed, Pending, Overdue) for compliance monitoring."
  measures:
    - name: "total_conduct_cases"
      expr: COUNT(1)
      comment: "Total number of conduct cases filed. Baseline volume metric for conduct program workload and trend analysis."
    - name: "unique_students_with_cases"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct students involved in conduct cases. Measures breadth of conduct issues across the student population."
    - name: "appeal_filed_count"
      expr: COUNT(CASE WHEN appeal_filed_flag = TRUE THEN 1 END)
      comment: "Number of cases where an appeal was filed. High appeal rates may signal process fairness concerns requiring policy review."
    - name: "appeal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_filed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of conduct cases that resulted in an appeal. Key fairness and due-process indicator for conduct program evaluation."
    - name: "transcript_notation_count"
      expr: COUNT(CASE WHEN transcript_notation_flag = TRUE THEN 1 END)
      comment: "Number of cases resulting in a permanent transcript notation. Tracks the most severe long-term academic consequence imposed."
    - name: "transcript_notation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN transcript_notation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of conduct cases resulting in transcript notation. Informs severity calibration and equity review of sanction practices."
    - name: "parent_notification_count"
      expr: COUNT(CASE WHEN parent_notification_flag = TRUE THEN 1 END)
      comment: "Number of cases triggering parental notification. Relevant for FERPA compliance monitoring and family engagement policy."
    - name: "avg_investigation_duration_days"
      expr: AVG(DATEDIFF(investigation_completion_date, investigation_start_date))
      comment: "Average number of days from investigation start to completion. Measures process efficiency and compliance with institutional timelines."
    - name: "avg_case_resolution_days"
      expr: AVG(DATEDIFF(case_closure_date, incident_report_date))
      comment: "Average days from incident report to case closure. Key operational efficiency KPI for the conduct office; long durations increase institutional risk."
    - name: "sanction_completion_overdue_count"
      expr: COUNT(CASE WHEN sanction_completion_status = 'Overdue' THEN 1 END)
      comment: "Number of cases with overdue sanction completion. Directly signals compliance risk and need for follow-up intervention."
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`studentlife_conduct_sanction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for conduct sanction management — tracks restitution recovery, community service completion, sanction severity distribution, and compliance rates to support Dean of Students accountability and financial recovery reporting."
  source: "`education_ecm`.`studentlife`.`conduct_sanction`"
  dimensions:
    - name: "sanction_type"
      expr: sanction_type
      comment: "Type of sanction imposed (e.g., Community Service, Restitution, Suspension) for sanction mix analysis."
    - name: "sanction_category"
      expr: sanction_category
      comment: "Broad category grouping of sanctions for executive-level severity distribution reporting."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity tier of the sanction, enabling escalation pattern analysis and equity audits."
    - name: "sanction_status"
      expr: sanction_status
      comment: "Current completion status of the sanction (e.g., Assigned, Completed, Waived) for compliance pipeline monitoring."
    - name: "transcript_notation_applied"
      expr: transcript_notation_flag
      comment: "Indicates whether a transcript notation accompanies this sanction, tracking the most consequential academic impact."
    - name: "hold_placed"
      expr: hold_placed_flag
      comment: "Indicates whether an institutional hold was placed as part of this sanction, relevant for enrollment impact analysis."
    - name: "appeal_eligible"
      expr: appeal_eligible_flag
      comment: "Indicates whether this sanction is eligible for appeal, supporting due-process compliance reporting."
    - name: "external_agency_reported"
      expr: external_agency_reported_flag
      comment: "Indicates whether the sanction was reported to an external agency (e.g., law enforcement), tracking regulatory reporting obligations."
    - name: "assigned_month"
      expr: DATE_TRUNC('MONTH', assigned_date)
      comment: "Month the sanction was assigned for time-series trend analysis of sanction volume."
  measures:
    - name: "total_sanctions"
      expr: COUNT(1)
      comment: "Total number of conduct sanctions issued. Baseline volume metric for conduct program activity and workload."
    - name: "total_restitution_assessed"
      expr: SUM(CAST(restitution_amount AS DOUBLE))
      comment: "Total restitution amount assessed across all sanctions. Measures financial liability imposed on students for misconduct."
    - name: "total_restitution_collected"
      expr: SUM(CAST(restitution_paid_amount AS DOUBLE))
      comment: "Total restitution actually collected. Compared against assessed amount to evaluate financial recovery effectiveness."
    - name: "restitution_collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(restitution_paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(restitution_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of assessed restitution that has been collected. Key financial recovery KPI; low rates signal collection process failures."
    - name: "total_community_service_hours_required"
      expr: SUM(CAST(hours_required AS DOUBLE))
      comment: "Total community service hours required across all applicable sanctions. Measures scope of restorative justice programming."
    - name: "total_community_service_hours_completed"
      expr: SUM(CAST(hours_completed AS DOUBLE))
      comment: "Total community service hours actually completed. Compared against required hours to assess sanction compliance."
    - name: "community_service_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(hours_completed AS DOUBLE)) / NULLIF(SUM(CAST(hours_required AS DOUBLE)), 0), 2)
      comment: "Percentage of required community service hours completed. Operational compliance KPI for restorative sanction programs."
    - name: "avg_restitution_per_sanction"
      expr: AVG(CAST(restitution_amount AS DOUBLE))
      comment: "Average restitution amount per sanction. Benchmarks financial severity of misconduct outcomes over time."
    - name: "sanctions_with_holds_count"
      expr: COUNT(CASE WHEN hold_placed_flag = TRUE THEN 1 END)
      comment: "Number of sanctions that placed an institutional hold on the student. Measures enrollment-blocking enforcement activity."
    - name: "external_agency_reported_count"
      expr: COUNT(CASE WHEN external_agency_reported_flag = TRUE THEN 1 END)
      comment: "Number of sanctions reported to external agencies. Critical compliance and risk management metric for institutional legal exposure."
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`studentlife_counseling_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for student counseling services — tracks caseload volume, crisis intervention rates, hospitalization rates, external referral rates, and case duration to inform Counseling Center capacity planning, clinical risk management, and mental health resource investment."
  source: "`education_ecm`.`studentlife`.`counseling_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the counseling case (e.g., Open, Closed, On Hold) for caseload pipeline management."
    - name: "presenting_concern_primary"
      expr: presenting_concern_primary
      comment: "Primary presenting clinical concern (e.g., Anxiety, Depression, Trauma) for demand pattern and resource allocation analysis."
    - name: "presenting_concern_secondary"
      expr: presenting_concern_secondary
      comment: "Secondary presenting concern for co-occurring condition analysis and treatment planning insights."
    - name: "risk_level"
      expr: risk_level
      comment: "Clinical risk level assigned to the case (e.g., Low, Moderate, High, Crisis) for acuity-based resource prioritization."
    - name: "treatment_modality"
      expr: treatment_modality
      comment: "Treatment delivery modality (e.g., Individual, Group, Telehealth) for service mix and capacity analysis."
    - name: "treatment_approach"
      expr: treatment_approach
      comment: "Clinical treatment approach used (e.g., CBT, DBT, Supportive) for clinical program effectiveness analysis."
    - name: "is_crisis_case"
      expr: crisis_flag
      comment: "Indicates whether the case involved a crisis intervention, enabling crisis volume trend analysis."
    - name: "is_mandated_referral"
      expr: mandated_referral_flag
      comment: "Indicates whether the student was mandated to counseling (e.g., via conduct), relevant for involuntary caseload analysis."
    - name: "external_referral_made"
      expr: external_referral_made
      comment: "Indicates whether the student was referred to an external provider, tracking capacity overflow and specialty care needs."
    - name: "case_open_month"
      expr: DATE_TRUNC('MONTH', case_open_date)
      comment: "Month the counseling case was opened for seasonal demand trend analysis."
    - name: "case_closure_reason"
      expr: case_closure_reason
      comment: "Reason the case was closed (e.g., Treatment Complete, Withdrawal, No Show) for outcome quality analysis."
  measures:
    - name: "total_counseling_cases"
      expr: COUNT(1)
      comment: "Total number of counseling cases opened. Baseline demand metric for Counseling Center capacity planning."
    - name: "unique_students_served"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct students who received counseling services. Core utilization metric for mental health program reach."
    - name: "crisis_case_count"
      expr: COUNT(CASE WHEN crisis_flag = TRUE THEN 1 END)
      comment: "Number of cases involving a crisis intervention. High-priority safety metric that directly informs staffing and emergency protocol investment."
    - name: "crisis_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN crisis_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of counseling cases classified as crisis. Rising rates signal deteriorating student mental health and require immediate resource response."
    - name: "hospitalization_count"
      expr: COUNT(CASE WHEN hospitalization_flag = TRUE THEN 1 END)
      comment: "Number of cases resulting in hospitalization. Critical safety outcome metric for institutional risk management and duty-of-care reporting."
    - name: "hospitalization_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hospitalization_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of counseling cases resulting in hospitalization. Tracks most severe mental health outcomes; informs crisis prevention investment."
    - name: "external_referral_count"
      expr: COUNT(CASE WHEN external_referral_made = TRUE THEN 1 END)
      comment: "Number of cases where students were referred to external providers. Measures capacity overflow and specialty care demand."
    - name: "external_referral_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN external_referral_made = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases resulting in external referral. High rates indicate internal capacity constraints requiring staffing or service expansion."
    - name: "avg_case_duration_days"
      expr: AVG(DATEDIFF(case_close_date, case_open_date))
      comment: "Average number of days a counseling case remains open. Measures treatment throughput and identifies chronic caseload bottlenecks."
    - name: "mandated_referral_count"
      expr: COUNT(CASE WHEN mandated_referral_flag = TRUE THEN 1 END)
      comment: "Number of cases initiated through mandatory referral. Tracks involuntary caseload volume relevant to conduct-counseling integration policy."
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`studentlife_dining_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and operational KPIs for dining program management — tracks meal plan revenue, dining dollar balances, refund activity, cancellation rates, and plan mix to inform Dining Services pricing strategy, plan design, and financial performance reporting."
  source: "`education_ecm`.`studentlife`.`dining_enrollment`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of dining plan enrolled (e.g., Unlimited, Block, Commuter) for plan mix and revenue segmentation analysis."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the dining enrollment (e.g., Active, Cancelled, Pending) for active plan portfolio monitoring."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Channel through which the enrollment was initiated (e.g., Online, In-Person, Auto-Assigned) for process efficiency analysis."
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of the dining enrollment (e.g., Billed, Pending, Waived) for accounts receivable monitoring."
    - name: "is_housing_required"
      expr: housing_requirement_flag
      comment: "Indicates whether the plan is required as part of a housing contract, enabling mandatory vs. voluntary enrollment analysis."
    - name: "is_dietary_restricted"
      expr: dietary_restriction_flag
      comment: "Indicates whether the student has a dietary restriction on file, relevant for accommodation capacity planning."
    - name: "auto_renewal"
      expr: auto_renewal_flag
      comment: "Indicates whether the plan auto-renews, relevant for retention and revenue predictability analysis."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of dining plan enrollment for seasonal demand and revenue recognition trend analysis."
    - name: "exemption_status"
      expr: exemption_status
      comment: "Status of any exemption from mandatory dining requirements, tracking compliance and revenue leakage."
  measures:
    - name: "total_dining_enrollments"
      expr: COUNT(1)
      comment: "Total number of dining plan enrollments. Baseline volume metric for dining program participation and revenue forecasting."
    - name: "unique_students_enrolled"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct students enrolled in a dining plan. Measures dining program reach across the student population."
    - name: "total_plan_cost_revenue"
      expr: SUM(CAST(plan_cost_amount AS DOUBLE))
      comment: "Total dining plan cost billed to students. Primary revenue metric for Dining Services financial performance reporting."
    - name: "avg_plan_cost_per_enrollment"
      expr: AVG(CAST(plan_cost_amount AS DOUBLE))
      comment: "Average dining plan cost per enrollment. Benchmarks plan pricing effectiveness and informs annual rate-setting decisions."
    - name: "total_dining_dollar_balance"
      expr: SUM(CAST(dining_dollar_balance AS DOUBLE))
      comment: "Total remaining dining dollar balances across all active enrollments. Represents deferred revenue liability and unused purchasing power."
    - name: "total_initial_dining_dollar_amount"
      expr: SUM(CAST(initial_dining_dollar_amount AS DOUBLE))
      comment: "Total dining dollars initially loaded across all enrollments. Baseline for dining dollar utilization rate calculation."
    - name: "dining_dollar_utilization_rate_pct"
      expr: ROUND(100.0 * (SUM(CAST(initial_dining_dollar_amount AS DOUBLE)) - SUM(CAST(dining_dollar_balance AS DOUBLE))) / NULLIF(SUM(CAST(initial_dining_dollar_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of loaded dining dollars that have been spent. Measures dining dollar program engagement and informs balance rollover policy."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds issued for dining plan cancellations or adjustments. Tracks financial exposure from plan cancellation activity."
    - name: "total_rollover_balance_amount"
      expr: SUM(CAST(rollover_balance_amount AS DOUBLE))
      comment: "Total dining dollar balances rolled over from prior periods. Informs rollover policy cost and deferred revenue management."
    - name: "cancellation_count"
      expr: COUNT(CASE WHEN enrollment_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled dining enrollments. Tracks plan attrition and associated revenue loss risk."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN enrollment_status = 'Cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dining enrollments that were cancelled. Rising cancellation rates signal dissatisfaction or affordability issues requiring program response."
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`studentlife_event_attendance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engagement and financial KPIs for campus event attendance — tracks participation rates, co-curricular credit award rates, ticket revenue, no-show rates, and feedback quality to inform Student Affairs programming effectiveness and student engagement strategy."
  source: "`education_ecm`.`studentlife`.`event_attendance`"
  dimensions:
    - name: "attendance_status"
      expr: attendance_status
      comment: "Status of the attendance record (e.g., Attended, No-Show, Cancelled) for participation quality analysis."
    - name: "attendance_method"
      expr: attendance_method
      comment: "Method by which attendance was recorded (e.g., Check-In, QR Scan, Manual) for data quality and process analysis."
    - name: "participation_level"
      expr: participation_level
      comment: "Level of student participation (e.g., Attendee, Volunteer, Presenter) for engagement depth analysis."
    - name: "credit_type"
      expr: credit_type
      comment: "Type of co-curricular credit awarded (e.g., Leadership, Service, Cultural) for credit program portfolio analysis."
    - name: "co_curricular_credit_awarded"
      expr: co_curricular_credit_awarded_flag
      comment: "Indicates whether co-curricular credit was awarded for this attendance record, enabling credit award rate tracking."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status for ticketed events (e.g., Paid, Waived, Pending) for revenue collection monitoring."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for ticket purchase, relevant for payment channel optimization."
    - name: "no_show"
      expr: no_show_flag
      comment: "Indicates whether the registered attendee did not show up, enabling no-show rate analysis for capacity planning."
    - name: "feedback_submitted"
      expr: feedback_submitted_flag
      comment: "Indicates whether the attendee submitted post-event feedback, tracking engagement quality and survey response rates."
    - name: "check_in_month"
      expr: DATE_TRUNC('MONTH', check_in_timestamp)
      comment: "Month of event check-in for time-series attendance trend analysis."
  measures:
    - name: "total_attendance_records"
      expr: COUNT(1)
      comment: "Total attendance records across all events. Baseline engagement volume metric for Student Affairs programming reach."
    - name: "unique_students_attending"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct students who attended at least one event. Measures breadth of student engagement with campus programming."
    - name: "total_ticket_revenue"
      expr: SUM(CAST(ticket_cost_amount AS DOUBLE))
      comment: "Total ticket revenue collected across all attended events. Measures self-funding contribution of ticketed programming."
    - name: "avg_ticket_cost"
      expr: AVG(CAST(ticket_cost_amount AS DOUBLE))
      comment: "Average ticket cost per attendance record. Benchmarks pricing strategy for ticketed events."
    - name: "total_cocurricular_credit_awarded"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total co-curricular credit awarded across all attendance records. Measures experiential learning credit delivery through events."
    - name: "no_show_count"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Number of registered attendees who did not show up. High no-show counts indicate capacity planning inefficiency and wasted resources."
    - name: "no_show_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of registrations that resulted in no-shows. Key operational efficiency metric; high rates justify registration deposit or waitlist policies."
    - name: "cocurricular_credit_award_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN co_curricular_credit_awarded_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of attendance records where co-curricular credit was awarded. Measures experiential learning program penetration through events."
    - name: "feedback_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN feedback_submitted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of attendees who submitted post-event feedback. Measures student engagement quality and data collection effectiveness for program improvement."
    - name: "special_accommodation_request_count"
      expr: COUNT(CASE WHEN special_accommodation_requested_flag = TRUE THEN 1 END)
      comment: "Number of attendance records with special accommodation requests. Informs accessibility planning and ADA compliance for event programming."
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`studentlife_health_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for student health appointment management — tracks appointment volume, no-show rates, telehealth adoption, charge revenue, wait time efficiency, and follow-up rates to inform Health Services capacity planning and clinical operations."
  source: "`education_ecm`.`studentlife`.`health_appointment`"
  dimensions:
    - name: "appointment_type"
      expr: appointment_type
      comment: "Type of health appointment (e.g., Primary Care, Mental Health, Immunization) for service mix and demand analysis."
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the appointment (e.g., Scheduled, Completed, Cancelled, No-Show) for pipeline and utilization monitoring."
    - name: "visit_reason"
      expr: visit_reason
      comment: "Reason for the health visit, enabling demand pattern analysis by clinical need category."
    - name: "priority_level"
      expr: priority_level
      comment: "Clinical priority level of the appointment (e.g., Urgent, Routine) for acuity-based capacity analysis."
    - name: "is_telehealth"
      expr: telehealth_flag
      comment: "Indicates whether the appointment was conducted via telehealth, tracking digital health service adoption."
    - name: "telehealth_platform"
      expr: telehealth_platform
      comment: "Telehealth platform used for virtual appointments, informing technology investment and platform performance analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the appointment charge (e.g., Paid, Pending, Waived) for revenue collection monitoring."
    - name: "referral_source"
      expr: referral_source
      comment: "Source of the appointment referral (e.g., Self, Faculty, Counseling) for care coordination pathway analysis."
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Indicates whether a follow-up appointment is required, tracking continuity of care rates."
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month of scheduled appointment for seasonal demand trend analysis and staffing planning."
  measures:
    - name: "total_appointments"
      expr: COUNT(1)
      comment: "Total number of health appointments scheduled. Baseline demand metric for Health Services capacity planning."
    - name: "unique_patients"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct students who had at least one health appointment. Measures Health Services utilization breadth across the student population."
    - name: "total_charge_revenue"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charges assessed for health appointments. Primary revenue metric for Health Services financial sustainability reporting."
    - name: "total_copay_collected"
      expr: SUM(CAST(copay_amount AS DOUBLE))
      comment: "Total copay amounts collected from students. Measures patient cost-sharing contribution to Health Services revenue."
    - name: "avg_charge_per_appointment"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge per health appointment. Benchmarks service pricing and informs fee schedule review decisions."
    - name: "no_show_count"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Number of appointments where the student did not show up. No-shows represent direct capacity waste and revenue loss."
    - name: "no_show_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments resulting in no-shows. High rates signal scheduling inefficiency; informs reminder protocol and overbooking policy."
    - name: "telehealth_appointment_count"
      expr: COUNT(CASE WHEN telehealth_flag = TRUE THEN 1 END)
      comment: "Number of appointments delivered via telehealth. Tracks digital health adoption and informs technology infrastructure investment."
    - name: "telehealth_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN telehealth_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments conducted via telehealth. Strategic modality mix KPI for Health Services access and cost optimization."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_required = TRUE THEN 1 END)
      comment: "Number of appointments requiring a follow-up visit. Measures continuity-of-care demand and informs scheduling capacity for follow-up slots."
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`studentlife_health_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical and financial KPIs for student health visit outcomes — tracks visit volume, diagnosis patterns, referral rates, telehealth utilization, insurance usage, and charge recovery to support Health Services clinical quality and financial performance management."
  source: "`education_ecm`.`studentlife`.`health_visit`"
  dimensions:
    - name: "visit_type"
      expr: visit_type
      comment: "Type of health visit (e.g., Acute, Preventive, Follow-Up) for service mix and clinical demand analysis."
    - name: "visit_status"
      expr: visit_status
      comment: "Status of the health visit (e.g., Completed, No-Show, Cancelled) for utilization and throughput monitoring."
    - name: "diagnosis_code"
      expr: diagnosis_code
      comment: "ICD diagnosis code associated with the visit, enabling disease burden and population health trend analysis."
    - name: "reason_for_visit"
      expr: reason_for_visit
      comment: "Patient-reported reason for the visit, enabling demand pattern analysis by presenting complaint category."
    - name: "provider_credential_type"
      expr: provider_credential_type
      comment: "Credential type of the treating provider (e.g., MD, NP, PA) for provider mix and scope-of-practice analysis."
    - name: "insurance_used"
      expr: insurance_used_flag
      comment: "Indicates whether insurance was used for the visit, relevant for billing mix and revenue cycle analysis."
    - name: "referral_flag"
      expr: referral_flag
      comment: "Indicates whether the visit resulted in an external referral, tracking specialty care demand and capacity overflow."
    - name: "follow_up_required"
      expr: follow_up_required_flag
      comment: "Indicates whether a follow-up visit was recommended, measuring continuity-of-care demand."
    - name: "telehealth_platform"
      expr: telehealth_platform
      comment: "Telehealth platform used for virtual visits, informing technology platform performance and adoption analysis."
    - name: "visit_month"
      expr: DATE_TRUNC('MONTH', visit_date)
      comment: "Month of the health visit for seasonal demand trend analysis and staffing planning."
  measures:
    - name: "total_health_visits"
      expr: COUNT(1)
      comment: "Total number of completed health visits. Baseline utilization metric for Health Services capacity and demand planning."
    - name: "unique_patients_seen"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct students seen at Health Services. Measures population-level utilization and program reach."
    - name: "total_visit_charges"
      expr: SUM(CAST(visit_charge_amount AS DOUBLE))
      comment: "Total charges assessed for health visits. Primary revenue metric for Health Services financial sustainability."
    - name: "total_copay_collected"
      expr: SUM(CAST(copay_amount AS DOUBLE))
      comment: "Total copay amounts collected during health visits. Measures patient cost-sharing contribution to Health Services revenue."
    - name: "avg_visit_charge"
      expr: AVG(CAST(visit_charge_amount AS DOUBLE))
      comment: "Average charge per health visit. Benchmarks service pricing and informs fee schedule review."
    - name: "referral_count"
      expr: COUNT(CASE WHEN referral_flag = TRUE THEN 1 END)
      comment: "Number of visits resulting in an external referral. Measures specialty care demand and capacity overflow from Health Services."
    - name: "referral_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN referral_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of health visits resulting in external referral. High rates may indicate gaps in on-campus clinical capabilities."
    - name: "insurance_utilization_count"
      expr: COUNT(CASE WHEN insurance_used_flag = TRUE THEN 1 END)
      comment: "Number of visits where student insurance was used. Tracks insurance billing activity and informs revenue cycle management."
    - name: "insurance_utilization_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN insurance_used_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits where insurance was used. Measures insurance billing penetration and informs student insurance enrollment strategy."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END)
      comment: "Number of visits where follow-up care was recommended. Informs scheduling demand for follow-up appointment slots."
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`studentlife_housing_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for student housing application pipeline management — tracks application volume, fee collection, deposit recovery, accommodation request rates, and application status conversion to inform Housing Office capacity planning and financial operations."
  source: "`education_ecm`.`studentlife`.`housing_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the housing application (e.g., Submitted, Approved, Waitlisted, Cancelled) for pipeline conversion analysis."
    - name: "room_type_preference"
      expr: room_type_preference
      comment: "Student's preferred room type (e.g., Single, Double, Suite) for demand forecasting and inventory alignment."
    - name: "priority_group"
      expr: priority_group
      comment: "Priority group assigned to the applicant (e.g., Freshman, Returning, Honors) for equitable allocation analysis."
    - name: "gender_inclusive_housing_requested"
      expr: gender_inclusive_housing_flag
      comment: "Indicates whether the student requested gender-inclusive housing, tracking demand for inclusive housing options."
    - name: "special_accommodation_requested"
      expr: special_accommodation_requested_flag
      comment: "Indicates whether a special accommodation was requested, relevant for ADA compliance and accommodation capacity planning."
    - name: "application_fee_payment_status"
      expr: application_fee_payment_status
      comment: "Payment status of the application fee (e.g., Paid, Pending, Waived) for fee collection monitoring."
    - name: "deposit_payment_status"
      expr: deposit_payment_status
      comment: "Payment status of the housing deposit (e.g., Paid, Pending, Refunded) for deposit revenue monitoring."
    - name: "early_arrival_requested"
      expr: early_arrival_requested_flag
      comment: "Indicates whether early arrival was requested, informing move-in logistics and staffing planning."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of application submission for demand trend analysis and application cycle planning."
  measures:
    - name: "total_housing_applications"
      expr: COUNT(1)
      comment: "Total number of housing applications submitted. Baseline demand metric for Housing Office capacity planning."
    - name: "unique_applicants"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct students who submitted a housing application. Measures housing demand breadth across the student population."
    - name: "total_application_fee_revenue"
      expr: SUM(CAST(application_fee_amount AS DOUBLE))
      comment: "Total application fee revenue collected. Measures administrative cost recovery from the housing application process."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total housing deposits collected. Measures committed housing revenue and financial commitment from applicants."
    - name: "avg_deposit_amount"
      expr: AVG(CAST(deposit_amount AS DOUBLE))
      comment: "Average housing deposit per application. Benchmarks deposit policy effectiveness and student financial commitment levels."
    - name: "approved_application_count"
      expr: COUNT(CASE WHEN application_status = 'Approved' THEN 1 END)
      comment: "Number of housing applications approved. Measures housing assignment pipeline fill rate and capacity utilization."
    - name: "application_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN application_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of housing applications that were approved. Tracks housing supply-demand balance; low rates signal capacity shortfalls."
    - name: "special_accommodation_request_count"
      expr: COUNT(CASE WHEN special_accommodation_requested_flag = TRUE THEN 1 END)
      comment: "Number of applications with special accommodation requests. Informs ADA-accessible room inventory requirements and compliance planning."
    - name: "cancellation_count"
      expr: COUNT(CASE WHEN application_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled housing applications. Tracks attrition in the housing pipeline and associated deposit refund exposure."
    - name: "gender_inclusive_request_count"
      expr: COUNT(CASE WHEN gender_inclusive_housing_flag = TRUE THEN 1 END)
      comment: "Number of applications requesting gender-inclusive housing. Measures demand for inclusive housing options to inform inventory allocation decisions."
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`studentlife_housing_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and operational KPIs for student housing assignment management — tracks assignment revenue, occupancy, damage charges, deposit recovery, refund activity, and accommodation rates to inform Housing Office financial performance and facilities management decisions."
  source: "`education_ecm`.`studentlife`.`housing_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the housing assignment (e.g., Active, Cancelled, Checked-Out) for occupancy pipeline monitoring."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of housing assignment (e.g., Standard, Temporary, Medical) for assignment mix and revenue analysis."
    - name: "room_type_code"
      expr: room_type_code
      comment: "Room type code for the assigned room (e.g., Single, Double, Triple) for occupancy and revenue analysis by room type."
    - name: "occupancy_rate_code"
      expr: occupancy_rate_code
      comment: "Rate code applied to the assignment, enabling revenue analysis by pricing tier."
    - name: "special_accommodation"
      expr: special_accommodation_flag
      comment: "Indicates whether the assignment includes a special accommodation, tracking ADA and medical accommodation fulfillment."
    - name: "damage_assessed"
      expr: damage_assessment_flag
      comment: "Indicates whether damage was assessed at check-out, enabling damage charge recovery analysis."
    - name: "key_issued"
      expr: key_issued_flag
      comment: "Indicates whether a key was issued, relevant for move-in completion and security compliance tracking."
    - name: "assignment_action_code"
      expr: assignment_action_code
      comment: "Action code describing the assignment transaction (e.g., New, Transfer, Cancellation) for assignment activity analysis."
    - name: "assignment_start_month"
      expr: DATE_TRUNC('MONTH', assignment_start_date)
      comment: "Month of assignment start for occupancy trend and revenue recognition analysis."
  measures:
    - name: "total_housing_assignments"
      expr: COUNT(1)
      comment: "Total number of housing assignments. Baseline occupancy volume metric for Housing Office capacity utilization reporting."
    - name: "unique_residents_assigned"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct students assigned to housing. Measures residential population size for resource planning."
    - name: "total_assignment_fee_revenue"
      expr: SUM(CAST(assignment_fee_amount AS DOUBLE))
      comment: "Total housing assignment fees assessed. Primary revenue metric for residential housing financial performance."
    - name: "avg_assignment_fee"
      expr: AVG(CAST(assignment_fee_amount AS DOUBLE))
      comment: "Average housing assignment fee per student. Benchmarks room rate effectiveness and informs annual rate-setting decisions."
    - name: "total_damage_charges"
      expr: SUM(CAST(damage_charge_amount AS DOUBLE))
      comment: "Total damage charges assessed at check-out. Measures facilities cost recovery from resident damage and informs maintenance budget planning."
    - name: "total_deposits_collected"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total housing deposits collected across all assignments. Measures financial commitment and deposit liability on the books."
    - name: "total_refunds_issued"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds issued for housing assignment cancellations or adjustments. Tracks financial exposure from assignment attrition."
    - name: "damage_assessment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN damage_assessment_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of housing assignments that resulted in a damage assessment. Tracks facilities condition and informs residence hall maintenance investment."
    - name: "special_accommodation_count"
      expr: COUNT(CASE WHEN special_accommodation_flag = TRUE THEN 1 END)
      comment: "Number of housing assignments with special accommodations. Measures ADA and medical accommodation fulfillment capacity."
    - name: "cancellation_count"
      expr: COUNT(CASE WHEN assignment_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled housing assignments. Tracks mid-year attrition and associated revenue loss and refund exposure."
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`studentlife_immunization_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance and public health KPIs for student immunization record management — tracks compliance rates, exemption rates, hold placement rates, and enrollment/housing requirement fulfillment to support Student Health compliance reporting and regulatory obligations."
  source: "`education_ecm`.`studentlife`.`immunization_record`"
  dimensions:
    - name: "immunization_type"
      expr: immunization_type
      comment: "Type of immunization (e.g., MMR, Meningitis, COVID-19) for disease-specific compliance analysis."
    - name: "immunization_name"
      expr: immunization_name
      comment: "Specific immunization name for granular compliance tracking by vaccine."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the immunization record (e.g., Compliant, Non-Compliant, Pending) for population-level compliance monitoring."
    - name: "exemption_type"
      expr: exemption_type
      comment: "Type of exemption claimed (e.g., Medical, Religious, Philosophical) for exemption policy analysis and regulatory reporting."
    - name: "is_required_for_enrollment"
      expr: is_required_for_enrollment
      comment: "Indicates whether this immunization is required for enrollment, enabling enrollment-blocking compliance analysis."
    - name: "is_required_for_housing"
      expr: is_required_for_housing
      comment: "Indicates whether this immunization is required for housing assignment, enabling housing-blocking compliance analysis."
    - name: "compliance_hold_placed"
      expr: compliance_hold_flag
      comment: "Indicates whether a compliance hold was placed due to this immunization record, tracking enrollment impact of non-compliance."
    - name: "is_active_record"
      expr: is_active
      comment: "Indicates whether the immunization record is currently active, filtering to current compliance population."
    - name: "administration_month"
      expr: DATE_TRUNC('MONTH', administration_date)
      comment: "Month of immunization administration for seasonal compliance trend analysis."
    - name: "verification_source"
      expr: verification_source
      comment: "Source of immunization verification (e.g., Provider, Self-Report, State Registry) for data quality and verification process analysis."
  measures:
    - name: "total_immunization_records"
      expr: COUNT(1)
      comment: "Total number of immunization records on file. Baseline metric for immunization data completeness and population coverage."
    - name: "unique_students_with_records"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct students with at least one immunization record. Measures immunization data coverage across the student population."
    - name: "compliant_record_count"
      expr: COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END)
      comment: "Number of immunization records in compliant status. Core public health compliance metric for regulatory reporting."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of immunization records in compliant status. Primary regulatory compliance KPI; low rates trigger institutional intervention and potential enrollment holds."
    - name: "exemption_count"
      expr: COUNT(CASE WHEN exemption_type IS NOT NULL AND exemption_type != '' THEN 1 END)
      comment: "Number of immunization records with an exemption on file. Tracks exemption volume for public health risk assessment and policy review."
    - name: "compliance_hold_count"
      expr: COUNT(CASE WHEN compliance_hold_flag = TRUE THEN 1 END)
      comment: "Number of immunization records that triggered a compliance hold. Measures enrollment-blocking impact of immunization non-compliance."
    - name: "compliance_hold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_hold_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of immunization records that resulted in a compliance hold. Tracks enforcement intensity and enrollment disruption risk."
    - name: "enrollment_required_record_count"
      expr: COUNT(CASE WHEN is_required_for_enrollment = TRUE THEN 1 END)
      comment: "Number of immunization records tied to enrollment requirements. Scopes the enrollment-critical compliance population."
    - name: "housing_required_record_count"
      expr: COUNT(CASE WHEN is_required_for_housing = TRUE THEN 1 END)
      comment: "Number of immunization records tied to housing requirements. Scopes the housing-critical compliance population for residential life planning."
    - name: "exemption_documentation_on_file_count"
      expr: COUNT(CASE WHEN exemption_documentation_on_file = TRUE THEN 1 END)
      comment: "Number of exemption records with supporting documentation on file. Measures documentation compliance for exemption policy enforcement."
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`studentlife_org_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engagement and financial KPIs for student organization membership — tracks membership volume, dues collection, leadership development, good standing rates, conduct violation rates, and volunteer hour contribution to inform Student Activities resource allocation and co-curricular engagement strategy."
  source: "`education_ecm`.`studentlife`.`org_membership`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current status of the membership (e.g., Active, Inactive, Suspended) for active membership portfolio analysis."
    - name: "membership_role"
      expr: membership_role
      comment: "Role of the member within the organization (e.g., President, Treasurer, General Member) for leadership pipeline analysis."
    - name: "academic_year"
      expr: academic_year
      comment: "Academic year of the membership for year-over-year engagement trend analysis."
    - name: "membership_term"
      expr: membership_term
      comment: "Term period of the membership for semester-level engagement analysis."
    - name: "good_standing"
      expr: good_standing_flag
      comment: "Indicates whether the member is in good standing, enabling good-standing rate analysis as a proxy for member engagement quality."
    - name: "dues_paid"
      expr: dues_paid_flag
      comment: "Indicates whether dues have been paid, enabling dues collection rate analysis."
    - name: "dues_waived"
      expr: dues_waived_flag
      comment: "Indicates whether dues were waived, tracking financial accessibility accommodations in student organizations."
    - name: "conduct_violation"
      expr: conduct_violation_flag
      comment: "Indicates whether the member has a conduct violation on record, enabling conduct risk analysis by organization."
    - name: "transcript_eligible"
      expr: transcript_eligible_flag
      comment: "Indicates whether the membership is eligible for transcript notation, tracking co-curricular recognition program participation."
    - name: "leadership_training_completed"
      expr: leadership_training_completed_flag
      comment: "Indicates whether the member completed leadership training, measuring leadership development program penetration."
  measures:
    - name: "total_memberships"
      expr: COUNT(1)
      comment: "Total number of student organization memberships. Baseline engagement volume metric for co-curricular participation reporting."
    - name: "unique_student_members"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct students with at least one organization membership. Measures breadth of co-curricular engagement across the student population."
    - name: "total_dues_collected"
      expr: SUM(CAST(dues_amount AS DOUBLE))
      comment: "Total dues revenue collected across all memberships. Measures financial health and self-funding capacity of student organizations."
    - name: "avg_dues_per_membership"
      expr: AVG(CAST(dues_amount AS DOUBLE))
      comment: "Average dues amount per membership. Benchmarks dues pricing across organizations and informs affordability analysis."
    - name: "dues_collection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dues_paid_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN dues_waived_flag = FALSE OR dues_waived_flag IS NULL THEN 1 END), 0), 2)
      comment: "Percentage of non-waived memberships where dues were paid. Measures financial compliance and organizational revenue collection effectiveness."
    - name: "good_standing_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN good_standing_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of memberships in good standing. Proxy for overall member engagement quality and organizational health."
    - name: "total_volunteer_hours"
      expr: SUM(CAST(volunteer_hours AS DOUBLE))
      comment: "Total volunteer hours contributed by student organization members. Measures community engagement and service impact of student organizations."
    - name: "avg_volunteer_hours_per_member"
      expr: AVG(CAST(volunteer_hours AS DOUBLE))
      comment: "Average volunteer hours per membership. Benchmarks individual engagement intensity and informs recognition program thresholds."
    - name: "conduct_violation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN conduct_violation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of memberships with a conduct violation on record. Risk indicator for student organization oversight and hazing prevention program effectiveness."
    - name: "leadership_training_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN leadership_training_completed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of members who completed leadership training. Measures leadership development program reach and informs training investment decisions."
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`studentlife_service_learning_placement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for service-learning program management — tracks placement volume, service hour completion rates, co-curricular credit delivery, reflection compliance, and background check completion to inform Academic Affairs and Student Affairs investment in experiential learning programs."
  source: "`education_ecm`.`studentlife`.`service_learning_placement`"
  dimensions:
    - name: "placement_status"
      expr: placement_status
      comment: "Current status of the service-learning placement (e.g., Active, Completed, Withdrawn) for pipeline and completion analysis."
    - name: "placement_type"
      expr: placement_type
      comment: "Type of service-learning placement (e.g., Community Service, Internship, Research) for program mix analysis."
    - name: "placement_approval_status"
      expr: placement_approval_status
      comment: "Approval status of the placement (e.g., Approved, Pending, Denied) for pipeline conversion monitoring."
    - name: "site_organization_type"
      expr: site_organization_type
      comment: "Type of community partner organization (e.g., Nonprofit, Government, Healthcare) for partner portfolio analysis."
    - name: "site_state_province"
      expr: site_state_province
      comment: "State or province of the service site for geographic distribution analysis of community engagement."
    - name: "reflection_required"
      expr: reflection_required_flag
      comment: "Indicates whether a reflection submission is required, enabling reflection compliance rate analysis."
    - name: "background_check_required"
      expr: background_check_required_flag
      comment: "Indicates whether a background check is required for the placement, tracking compliance with site safety requirements."
    - name: "liability_waiver_signed"
      expr: liability_waiver_signed_flag
      comment: "Indicates whether the liability waiver was signed, tracking legal compliance for placement activation."
    - name: "placement_start_month"
      expr: DATE_TRUNC('MONTH', placement_start_date)
      comment: "Month of placement start for seasonal demand trend analysis."
    - name: "reflection_submission_status"
      expr: reflection_submission_status
      comment: "Status of the reflection submission (e.g., Submitted, Pending, Overdue) for academic compliance monitoring."
  measures:
    - name: "total_placements"
      expr: COUNT(1)
      comment: "Total number of service-learning placements. Baseline volume metric for experiential learning program scale and reach."
    - name: "unique_students_placed"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct students with a service-learning placement. Measures experiential learning program reach across the student population."
    - name: "total_required_service_hours"
      expr: SUM(CAST(required_service_hours AS DOUBLE))
      comment: "Total service hours required across all placements. Measures the institutional commitment to community engagement through service-learning."
    - name: "total_completed_service_hours"
      expr: SUM(CAST(completed_service_hours AS DOUBLE))
      comment: "Total service hours actually completed by students. Measures real community impact delivered through the service-learning program."
    - name: "service_hour_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(completed_service_hours AS DOUBLE)) / NULLIF(SUM(CAST(required_service_hours AS DOUBLE)), 0), 2)
      comment: "Percentage of required service hours that have been completed. Primary program effectiveness KPI; low rates signal student engagement or site access issues."
    - name: "total_academic_credit_hours"
      expr: SUM(CAST(academic_credit_hours AS DOUBLE))
      comment: "Total academic credit hours awarded through service-learning placements. Measures academic integration of experiential learning."
    - name: "total_cocurricular_credit_awarded"
      expr: SUM(CAST(co_curricular_credit_awarded AS DOUBLE))
      comment: "Total co-curricular credit awarded through service-learning placements. Measures non-academic recognition of community engagement."
    - name: "avg_completed_service_hours_per_placement"
      expr: AVG(CAST(completed_service_hours AS DOUBLE))
      comment: "Average service hours completed per placement. Benchmarks engagement intensity and informs minimum hour requirement calibration."
    - name: "background_check_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN background_check_completion_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN background_check_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of required background checks that have been completed. Compliance KPI for site safety requirements; incomplete checks block placement activation."
    - name: "reflection_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reflection_submission_status = 'Submitted' THEN 1 END) / NULLIF(COUNT(CASE WHEN reflection_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of required reflections that have been submitted. Academic compliance KPI for service-learning course integration; low rates risk grade and credit impacts."
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`studentlife_student_org`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for student organization portfolio management — tracks organization recognition status, financial health, risk tier distribution, compliance with re-registration and insurance requirements, and hazing prevention training to inform Student Activities governance and resource allocation."
  source: "`education_ecm`.`studentlife`.`student_org`"
  dimensions:
    - name: "org_type"
      expr: org_type
      comment: "Type of student organization (e.g., Academic, Greek, Service, Cultural) for portfolio segmentation and resource allocation analysis."
    - name: "recognition_status"
      expr: recognition_status
      comment: "Current recognition status of the organization (e.g., Recognized, Provisional, Suspended, Derecognized) for active portfolio monitoring."
    - name: "affiliation_type"
      expr: affiliation_type
      comment: "Affiliation type of the organization (e.g., National, Local, Independent) for governance and liability analysis."
    - name: "greek_council"
      expr: greek_council
      comment: "Greek council affiliation (e.g., IFC, Panhellenic, NPHC) for Greek life governance and risk management reporting."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Institutional risk tier assigned to the organization (e.g., Low, Medium, High) for risk-based oversight and insurance requirement analysis."
    - name: "insurance_required"
      expr: insurance_required_flag
      comment: "Indicates whether the organization is required to carry insurance, relevant for liability compliance monitoring."
    - name: "constitution_on_file"
      expr: constitution_on_file_flag
      comment: "Indicates whether a current constitution is on file, tracking governance documentation compliance."
    - name: "recognition_month"
      expr: DATE_TRUNC('MONTH', recognition_date)
      comment: "Month of initial recognition for cohort analysis of organization lifecycle and longevity."
  measures:
    - name: "total_student_orgs"
      expr: COUNT(1)
      comment: "Total number of student organizations. Baseline portfolio size metric for Student Activities program scope reporting."
    - name: "recognized_org_count"
      expr: COUNT(CASE WHEN recognition_status = 'Recognized' THEN 1 END)
      comment: "Number of currently recognized student organizations. Measures active co-curricular ecosystem size for institutional benchmarking."
    - name: "total_budget_allocation"
      expr: SUM(CAST(budget_allocation_amount AS DOUBLE))
      comment: "Total budget allocated across all student organizations. Primary financial stewardship metric for Student Activities budget management."
    - name: "avg_budget_per_org"
      expr: AVG(CAST(budget_allocation_amount AS DOUBLE))
      comment: "Average budget allocation per student organization. Benchmarks funding equity and informs budget allocation policy review."
    - name: "high_risk_org_count"
      expr: COUNT(CASE WHEN risk_tier = 'High' THEN 1 END)
      comment: "Number of organizations classified in the high-risk tier. Critical risk management metric for Student Affairs liability oversight and intervention prioritization."
    - name: "high_risk_org_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_tier = 'High' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of student organizations in the high-risk tier. Tracks institutional risk exposure concentration in the co-curricular portfolio."
    - name: "insurance_expired_or_missing_count"
      expr: COUNT(CASE WHEN insurance_required_flag = TRUE AND (insurance_expiration_date < CURRENT_DATE() OR insurance_expiration_date IS NULL) THEN 1 END)
      comment: "Number of organizations with required insurance that is expired or missing. Direct compliance risk metric; uninsured high-risk orgs create institutional liability exposure."
    - name: "hazing_prevention_training_completion_count"
      expr: COUNT(CASE WHEN hazing_prevention_training_date IS NOT NULL THEN 1 END)
      comment: "Number of organizations that have completed hazing prevention training. Compliance metric for hazing prevention policy; incomplete training is a regulatory and reputational risk."
    - name: "hazing_prevention_training_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hazing_prevention_training_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of student organizations that have completed hazing prevention training. Key risk mitigation KPI; low rates signal systemic compliance gaps requiring immediate intervention."
    - name: "re_registration_overdue_count"
      expr: COUNT(CASE WHEN re_registration_due_date < CURRENT_DATE() AND (last_re_registration_date IS NULL OR last_re_registration_date < re_registration_due_date) THEN 1 END)
      comment: "Number of organizations overdue for re-registration. Governance compliance metric; overdue orgs may lose recognition status and associated funding."
$$;
