-- Metric views for domain: workforce | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-10 19:05:00

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core workforce headcount and composition metrics for strategic HR planning, regulatory staffing compliance, and operational readiness reporting."
  source: "`vibe_water_utilities_v1`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (Active, Terminated, On Leave, etc.) for headcount segmentation."
    - name: "employment_type"
      expr: employment_type
      comment: "Full-time, part-time, contract, or seasonal classification for workforce composition analysis."
    - name: "department_name"
      expr: department_name
      comment: "Department name for organizational drill-down of workforce metrics."
    - name: "job_classification"
      expr: job_classification
      comment: "Job classification code for role-based workforce analysis and compensation benchmarking."
    - name: "union_membership_flag"
      expr: union_membership_flag
      comment: "Whether the employee is a union member, enabling union vs. non-union workforce segmentation."
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade band for compensation distribution analysis."
    - name: "hire_date_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month of hire for cohort-based retention and attrition trend analysis."
    - name: "termination_date_month"
      expr: DATE_TRUNC('MONTH', termination_date)
      comment: "Month of termination for attrition trend analysis."
    - name: "operator_license_type"
      expr: operator_license_type
      comment: "Type of operator license held, for regulatory staffing compliance reporting."
    - name: "hazmat_certified_flag"
      expr: hazmat_certified_flag
      comment: "Whether the employee holds hazmat certification, for safety-critical staffing analysis."
  measures:
    - name: "total_active_employees"
      expr: COUNT(CASE WHEN employment_status = 'Active' THEN employee_id END)
      comment: "Total count of currently active employees. Core headcount KPI for executive workforce dashboards and regulatory staffing compliance."
    - name: "total_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Total distinct employee count across all statuses. Baseline denominator for workforce ratio calculations."
    - name: "operator_licensed_employee_count"
      expr: COUNT(CASE WHEN operator_license_number IS NOT NULL AND employment_status = 'Active' THEN employee_id END)
      comment: "Count of active employees holding a state operator license. Critical for regulatory compliance — water utilities must maintain minimum licensed operator ratios per state primacy requirements."
    - name: "osha_current_employee_count"
      expr: COUNT(CASE WHEN osha_training_current_flag = TRUE AND employment_status = 'Active' THEN employee_id END)
      comment: "Count of active employees with current OSHA training. Drives safety compliance reporting and identifies retraining needs."
    - name: "osha_training_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN osha_training_current_flag = TRUE AND employment_status = 'Active' THEN employee_id END) / NULLIF(COUNT(CASE WHEN employment_status = 'Active' THEN employee_id END), 0), 2)
      comment: "Percentage of active employees with current OSHA training. A drop below threshold triggers mandatory retraining programs and may indicate regulatory exposure."
    - name: "hazmat_certified_employee_count"
      expr: COUNT(CASE WHEN hazmat_certified_flag = TRUE AND employment_status = 'Active' THEN employee_id END)
      comment: "Count of active employees with hazmat certification. Required for chemical handling operations at treatment facilities."
    - name: "union_membership_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN union_membership_flag = TRUE AND employment_status = 'Active' THEN employee_id END) / NULLIF(COUNT(CASE WHEN employment_status = 'Active' THEN employee_id END), 0), 2)
      comment: "Percentage of active employees who are union members. Informs labor relations strategy and collective bargaining planning."
    - name: "operator_license_expiring_30d_count"
      expr: COUNT(CASE WHEN operator_license_expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 30) AND employment_status = 'Active' THEN employee_id END)
      comment: "Count of active employees whose operator license expires within 30 days. Triggers renewal workflows to prevent regulatory staffing violations."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`workforce_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce certification compliance and cost metrics. Tracks regulatory certification coverage, renewal risk, and training investment for water utility operator licensing requirements."
  source: "`vibe_water_utilities_v1`.`workforce`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (operator license, safety, technical, etc.) for compliance category analysis."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (Active, Expired, Pending, Revoked) for compliance tracking."
    - name: "certifying_body"
      expr: certifying_body
      comment: "Issuing organization for the certification, enabling vendor/agency performance analysis."
    - name: "is_regulatory_required"
      expr: is_regulatory_required
      comment: "Whether the certification is mandated by regulation, for prioritizing compliance gap remediation."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the certification is mandatory per utility policy, for internal compliance tracking."
    - name: "reimbursement_status"
      expr: reimbursement_status
      comment: "Reimbursement status for certification costs, for HR cost recovery analysis."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month of certification expiration for renewal pipeline planning."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month certification was issued for cohort-based compliance trend analysis."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the certification for audit readiness assessment."
  measures:
    - name: "total_certifications"
      expr: COUNT(DISTINCT certification_id)
      comment: "Total number of certification records. Baseline for certification portfolio sizing."
    - name: "active_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN certification_id END)
      comment: "Count of currently active certifications. Core compliance KPI — utilities must maintain minimum certified operator counts per state regulations."
    - name: "regulatory_required_active_count"
      expr: COUNT(CASE WHEN is_regulatory_required = TRUE AND certification_status = 'Active' THEN certification_id END)
      comment: "Count of active certifications that are regulatory requirements. Direct measure of regulatory compliance posture."
    - name: "expiring_30d_count"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 30) AND certification_status = 'Active' THEN certification_id END)
      comment: "Certifications expiring within 30 days. Triggers renewal workflows to prevent compliance gaps that could result in regulatory violations."
    - name: "expiring_90d_count"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) AND certification_status = 'Active' THEN certification_id END)
      comment: "Certifications expiring within 90 days. Provides a forward-looking compliance risk pipeline for workforce planning."
    - name: "expired_regulatory_count"
      expr: COUNT(CASE WHEN certification_status = 'Expired' AND is_regulatory_required = TRUE THEN certification_id END)
      comment: "Count of expired regulatory-required certifications. A non-zero value represents active compliance violations requiring immediate remediation."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total spend on certifications. Informs HR training budget allocation and cost recovery decisions."
    - name: "avg_certification_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per certification. Benchmarks training investment efficiency and supports vendor negotiation."
    - name: "total_ceu_earned"
      expr: SUM(CAST(ceu_earned AS DOUBLE))
      comment: "Total continuing education units earned across all certifications. Measures workforce professional development investment."
    - name: "ceu_fulfillment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(ceu_earned AS DOUBLE)) / NULLIF(SUM(CAST(ceu_required AS DOUBLE)), 0), 2)
      comment: "Percentage of required CEUs fulfilled. Regulatory-required metric for operator license renewal compliance — falling below 100% risks license revocation."
    - name: "avg_training_hours_per_cert"
      expr: AVG(CAST(training_hours AS DOUBLE))
      comment: "Average training hours invested per certification. Supports workforce development planning and training program design."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`workforce_operator_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operator license compliance metrics for water utility regulatory requirements. Tracks license coverage, expiration risk, and renewal pipeline — critical for maintaining state-mandated operator-in-responsible-charge (ORC) requirements."
  source: "`vibe_water_utilities_v1`.`workforce`.`operator_license`"
  dimensions:
    - name: "license_type"
      expr: license_type
      comment: "Type of operator license (Water Treatment, Distribution, Wastewater, etc.) for regulatory category analysis."
    - name: "license_grade"
      expr: license_grade
      comment: "License grade/class (Grade 1-4, Class A/B/C/D) for staffing compliance against facility classification requirements."
    - name: "license_status"
      expr: license_status
      comment: "Current license status (Active, Expired, Suspended, Revoked) for compliance monitoring."
    - name: "issuing_state"
      expr: issuing_state
      comment: "State that issued the license for multi-state utility compliance tracking."
    - name: "operator_in_responsible_charge_flag"
      expr: operator_in_responsible_charge_flag
      comment: "Whether the license holder is designated as Operator in Responsible Charge — the most critical regulatory staffing requirement."
    - name: "backup_operator_flag"
      expr: backup_operator_flag
      comment: "Whether the operator is designated as backup ORC, for succession and coverage planning."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month of license expiration for renewal pipeline management."
    - name: "facility_classification_authorized"
      expr: facility_classification_authorized
      comment: "Facility classification the operator is authorized to operate, for staffing compliance matching."
  measures:
    - name: "total_active_licenses"
      expr: COUNT(CASE WHEN license_status = 'Active' THEN operator_license_id END)
      comment: "Total count of active operator licenses. Core regulatory compliance KPI — utilities must maintain minimum licensed operator counts per state primacy requirements."
    - name: "orc_designated_count"
      expr: COUNT(CASE WHEN operator_in_responsible_charge_flag = TRUE AND license_status = 'Active' THEN operator_license_id END)
      comment: "Count of active Operators in Responsible Charge. The most critical regulatory staffing metric — each permitted facility must have a qualified ORC at all times."
    - name: "licenses_expiring_30d"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 30) AND license_status = 'Active' THEN operator_license_id END)
      comment: "Active licenses expiring within 30 days. Triggers urgent renewal actions to prevent regulatory staffing violations."
    - name: "licenses_expiring_90d"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) AND license_status = 'Active' THEN operator_license_id END)
      comment: "Active licenses expiring within 90 days. Forward-looking compliance risk pipeline for workforce planning."
    - name: "expired_license_count"
      expr: COUNT(CASE WHEN license_status = 'Expired' THEN operator_license_id END)
      comment: "Count of expired licenses. Non-zero values represent active regulatory compliance violations requiring immediate remediation."
    - name: "suspended_or_revoked_count"
      expr: COUNT(CASE WHEN license_status IN ('Suspended', 'Revoked') THEN operator_license_id END)
      comment: "Count of suspended or revoked licenses. Indicates serious compliance events requiring HR and legal response."
    - name: "renewal_application_pending_count"
      expr: COUNT(CASE WHEN renewal_application_submitted_date IS NOT NULL AND license_status = 'Active' AND expiration_date <= DATE_ADD(CURRENT_DATE, 90) THEN operator_license_id END)
      comment: "Count of licenses with renewal applications submitted and pending. Measures proactive renewal management effectiveness."
    - name: "total_renewal_fees"
      expr: SUM(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Total renewal fees paid or due for operator licenses. Informs HR budget planning for regulatory compliance costs."
    - name: "avg_exam_score"
      expr: AVG(CAST(exam_score AS DOUBLE))
      comment: "Average operator exam score. Measures training program effectiveness and identifies knowledge gaps requiring remediation."
    - name: "avg_continuing_education_completion_pct"
      expr: ROUND(100.0 * AVG(CAST(continuing_education_hours_completed AS DOUBLE)) / NULLIF(AVG(CAST(continuing_education_hours_required AS DOUBLE)), 0), 2)
      comment: "Average continuing education completion rate across all licenses. Regulatory requirement for license renewal — below 100% indicates renewal risk."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`workforce_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce safety performance metrics for OSHA compliance, risk management, and operational safety culture assessment. Tracks incident rates, severity, and corrective action effectiveness."
  source: "`vibe_water_utilities_v1`.`workforce`.`safety_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of safety incident (injury, near-miss, property damage, environmental release) for risk categorization."
    - name: "injury_severity"
      expr: injury_severity
      comment: "Severity classification of the injury for risk stratification and OSHA recordability determination."
    - name: "osha_recordable_flag"
      expr: osha_recordable_flag
      comment: "Whether the incident is OSHA recordable — the primary regulatory compliance dimension for safety reporting."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for systemic safety improvement analysis."
    - name: "incident_date_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of incident for trend analysis and seasonal safety pattern identification."
    - name: "incident_date_year"
      expr: DATE_TRUNC('YEAR', incident_date)
      comment: "Year of incident for annual OSHA 300 log reporting and year-over-year safety performance comparison."
    - name: "location_type"
      expr: location_type
      comment: "Location type where incident occurred (field, facility, office) for targeted safety intervention."
    - name: "environmental_release_flag"
      expr: environmental_release_flag
      comment: "Whether the incident involved an environmental release, triggering regulatory notification requirements."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the incident investigation for corrective action pipeline management."
  measures:
    - name: "total_incidents"
      expr: COUNT(DISTINCT safety_incident_id)
      comment: "Total safety incidents recorded. Baseline KPI for safety performance trending and OSHA 300 log compliance."
    - name: "osha_recordable_incident_count"
      expr: COUNT(CASE WHEN osha_recordable_flag = TRUE THEN safety_incident_id END)
      comment: "Count of OSHA recordable incidents. The primary regulatory safety metric — drives OSHA 300 log entries and public disclosure requirements."
    - name: "environmental_release_incident_count"
      expr: COUNT(CASE WHEN environmental_release_flag = TRUE THEN safety_incident_id END)
      comment: "Count of incidents involving environmental releases. Triggers regulatory notification requirements and environmental liability tracking."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN safety_incident_id END)
      comment: "Count of incidents requiring corrective action. Measures the volume of safety improvement actions needed."
    - name: "corrective_action_overdue_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE AND corrective_action_completed_date IS NULL AND corrective_action_due_date < CURRENT_DATE THEN safety_incident_id END)
      comment: "Count of overdue corrective actions. Non-zero values indicate safety management failures and potential repeat incident risk."
    - name: "corrective_action_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required_flag = TRUE AND corrective_action_completed_date IS NOT NULL THEN safety_incident_id END) / NULLIF(COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN safety_incident_id END), 0), 2)
      comment: "Percentage of required corrective actions completed. Measures safety management system effectiveness — low rates indicate systemic follow-through failures."
    - name: "total_property_damage_amount"
      expr: SUM(CAST(property_damage_amount AS DOUBLE))
      comment: "Total property damage cost from safety incidents. Quantifies financial impact of safety failures for insurance and risk management decisions."
    - name: "total_environmental_release_volume"
      expr: SUM(CAST(environmental_release_volume AS DOUBLE))
      comment: "Total volume of environmental releases from incidents. Regulatory reporting metric for environmental compliance and permit condition tracking."
    - name: "regulatory_notification_required_count"
      expr: COUNT(CASE WHEN regulatory_notification_required_flag = TRUE THEN safety_incident_id END)
      comment: "Count of incidents requiring regulatory notification. Tracks regulatory reporting obligations and ensures timely agency notifications."
    - name: "open_investigation_count"
      expr: COUNT(CASE WHEN investigation_status NOT IN ('Closed', 'Complete') AND investigation_status IS NOT NULL THEN safety_incident_id END)
      comment: "Count of incidents with open investigations. Measures investigation backlog and timeliness of root cause analysis."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`workforce_labor_timesheet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor cost, utilization, and productivity metrics for workforce cost management, project cost allocation, and operational efficiency analysis."
  source: "`vibe_water_utilities_v1`.`workforce`.`labor_timesheet`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of work activity performed for labor cost categorization and productivity analysis."
    - name: "pay_code"
      expr: pay_code
      comment: "Payroll pay code (regular, overtime, standby, call-out) for labor cost type analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Timesheet approval status for payroll processing pipeline monitoring."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Whether the labor is billable to a project or customer, for cost recovery analysis."
    - name: "timesheet_date_month"
      expr: DATE_TRUNC('MONTH', timesheet_date)
      comment: "Month of timesheet for labor cost trend analysis and budget variance reporting."
    - name: "timesheet_date_year"
      expr: DATE_TRUNC('YEAR', timesheet_date)
      comment: "Year of timesheet for annual labor cost reporting and budget comparison."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type (day, evening, night, weekend) for shift differential cost analysis."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Whether a safety incident occurred during this timesheet period, for safety-labor correlation analysis."
    - name: "payroll_period"
      expr: payroll_period
      comment: "Payroll period for payroll cycle cost aggregation and variance analysis."
  measures:
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total hours worked across all employees. Core labor utilization metric for workforce capacity planning."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular (straight-time) hours worked. Baseline for overtime ratio calculation and staffing adequacy assessment."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked. High overtime indicates understaffing or workload spikes requiring resource reallocation."
    - name: "overtime_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(hours_worked AS DOUBLE)), 0), 2)
      comment: "Overtime as a percentage of total hours worked. Exceeding target thresholds triggers staffing review and budget escalation."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost across all timesheet entries. Primary cost management KPI for operational budget control and project cost tracking."
    - name: "avg_labor_rate"
      expr: AVG(CAST(labor_rate AS DOUBLE))
      comment: "Average labor rate per hour. Benchmarks workforce cost efficiency and informs rate-setting for billable work."
    - name: "total_standby_hours"
      expr: SUM(CAST(standby_hours AS DOUBLE))
      comment: "Total standby/on-call hours. Standby costs are a significant operational expense for 24/7 water utility operations."
    - name: "total_call_out_hours"
      expr: SUM(CAST(call_out_hours AS DOUBLE))
      comment: "Total emergency call-out hours. Measures unplanned labor demand from emergency response events."
    - name: "total_training_hours"
      expr: SUM(CAST(training_hours AS DOUBLE))
      comment: "Total training hours recorded on timesheets. Measures workforce development investment and regulatory training compliance."
    - name: "billable_hours"
      expr: SUM(CASE WHEN billable_flag = TRUE THEN CAST(hours_worked AS DOUBLE) ELSE 0 END)
      comment: "Total billable labor hours. Measures cost recovery potential and project labor allocation."
    - name: "billable_labor_cost"
      expr: SUM(CASE WHEN billable_flag = TRUE THEN CAST(labor_cost AS DOUBLE) ELSE 0 END)
      comment: "Total labor cost for billable work. Informs project cost recovery and customer billing accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`workforce_training_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce training compliance, completion, and investment metrics. Tracks regulatory training mandates, completion rates, and training cost efficiency for water utility operator development."
  source: "`vibe_water_utilities_v1`.`workforce`.`training_record`"
  dimensions:
    - name: "training_type"
      expr: training_type
      comment: "Type of training (safety, regulatory, technical, leadership) for training portfolio analysis."
    - name: "training_category"
      expr: training_category
      comment: "Training category for program-level compliance and investment analysis."
    - name: "training_status"
      expr: training_status
      comment: "Completion status of the training record (Completed, In Progress, Enrolled, Failed) for pipeline management."
    - name: "training_result"
      expr: training_result
      comment: "Pass/fail result of the training for effectiveness measurement."
    - name: "is_regulatory_required"
      expr: is_regulatory_required
      comment: "Whether the training is mandated by regulation, for compliance gap prioritization."
    - name: "is_compliance_required"
      expr: is_compliance_required
      comment: "Whether the training is required for internal compliance, for policy adherence tracking."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Training delivery method (classroom, online, on-the-job, simulation) for modality effectiveness analysis."
    - name: "completion_date_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month of training completion for trend analysis and compliance deadline tracking."
    - name: "completion_date_year"
      expr: DATE_TRUNC('YEAR', completion_date)
      comment: "Year of training completion for annual compliance reporting."
  measures:
    - name: "total_training_records"
      expr: COUNT(DISTINCT training_record_id)
      comment: "Total training records. Baseline for training activity volume and compliance coverage assessment."
    - name: "completed_training_count"
      expr: COUNT(CASE WHEN training_status = 'Completed' THEN training_record_id END)
      comment: "Count of completed training records. Core training compliance KPI for regulatory and policy adherence."
    - name: "regulatory_training_completion_count"
      expr: COUNT(CASE WHEN is_regulatory_required = TRUE AND training_status = 'Completed' THEN training_record_id END)
      comment: "Count of completed regulatory-required training records. Direct measure of regulatory compliance — gaps can result in permit violations."
    - name: "regulatory_training_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_regulatory_required = TRUE AND training_status = 'Completed' THEN training_record_id END) / NULLIF(COUNT(CASE WHEN is_regulatory_required = TRUE THEN training_record_id END), 0), 2)
      comment: "Percentage of regulatory-required training completed. Below-target rates indicate compliance risk requiring immediate remediation."
    - name: "training_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN training_result = 'Pass' THEN training_record_id END) / NULLIF(COUNT(CASE WHEN training_result IS NOT NULL THEN training_record_id END), 0), 2)
      comment: "Percentage of assessed training records with a passing result. Measures training program effectiveness and identifies knowledge gaps."
    - name: "total_training_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total training expenditure. Primary KPI for HR training budget management and cost-per-employee benchmarking."
    - name: "avg_training_cost_per_record"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average training cost per training record. Benchmarks training investment efficiency and supports vendor contract negotiations."
    - name: "total_ceu_credits_earned"
      expr: SUM(CAST(ceu_credits_earned AS DOUBLE))
      comment: "Total continuing education units earned. Measures workforce professional development progress toward license renewal requirements."
    - name: "total_training_hours"
      expr: SUM(CAST(training_hours AS DOUBLE))
      comment: "Total training hours invested. Measures workforce development effort and supports per-employee training hour benchmarking."
    - name: "avg_training_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average assessment score across training records. Measures training program quality and identifies courses needing content improvement."
    - name: "certification_expiring_30d_count"
      expr: COUNT(CASE WHEN certification_expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 30) THEN training_record_id END)
      comment: "Count of training-linked certifications expiring within 30 days. Triggers renewal enrollment workflows to prevent compliance gaps."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee performance metrics for talent management, succession planning, and organizational effectiveness. Tracks performance ratings, merit decisions, and development pipeline for water utility workforce."
  source: "`vibe_water_utilities_v1`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of performance review (annual, mid-year, probationary, 360) for review cycle analysis."
    - name: "review_status"
      expr: review_status
      comment: "Current status of the review (Draft, Submitted, Acknowledged, Closed) for completion pipeline management."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating category (Exceeds, Meets, Below Expectations) for talent segmentation."
    - name: "merit_increase_recommended_flag"
      expr: merit_increase_recommended_flag
      comment: "Whether a merit increase was recommended, for compensation planning analysis."
    - name: "promotion_recommended_flag"
      expr: promotion_recommended_flag
      comment: "Whether a promotion was recommended, for succession pipeline analysis."
    - name: "succession_planning_candidate_flag"
      expr: succession_planning_candidate_flag
      comment: "Whether the employee is identified as a succession planning candidate, for leadership pipeline tracking."
    - name: "review_date_year"
      expr: DATE_TRUNC('YEAR', review_date)
      comment: "Year of review for annual performance cycle analysis and year-over-year trend comparison."
    - name: "review_period_end_month"
      expr: DATE_TRUNC('MONTH', review_period_end_date)
      comment: "Month the review period ended for performance cycle alignment analysis."
  measures:
    - name: "total_reviews"
      expr: COUNT(DISTINCT performance_review_id)
      comment: "Total performance reviews conducted. Baseline for review cycle completion tracking."
    - name: "completed_review_count"
      expr: COUNT(CASE WHEN review_status = 'Closed' THEN performance_review_id END)
      comment: "Count of completed performance reviews. Measures HR process compliance — incomplete reviews indicate management accountability gaps."
    - name: "merit_increase_recommended_count"
      expr: COUNT(CASE WHEN merit_increase_recommended_flag = TRUE THEN performance_review_id END)
      comment: "Count of employees recommended for merit increases. Informs compensation budget planning and equity analysis."
    - name: "merit_increase_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN merit_increase_recommended_flag = TRUE THEN performance_review_id END) / NULLIF(COUNT(DISTINCT performance_review_id), 0), 2)
      comment: "Percentage of reviewed employees recommended for merit increases. Informs compensation budget sizing and retention strategy."
    - name: "avg_merit_increase_pct"
      expr: AVG(CAST(merit_increase_percentage AS DOUBLE))
      comment: "Average merit increase percentage recommended. Benchmarks compensation competitiveness and informs salary budget planning."
    - name: "succession_candidate_count"
      expr: COUNT(CASE WHEN succession_planning_candidate_flag = TRUE THEN performance_review_id END)
      comment: "Count of employees identified as succession planning candidates. Measures leadership pipeline depth — critical for utility continuity planning."
    - name: "avg_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average overall performance rating score. Tracks organizational performance trends and identifies departments needing management intervention."
    - name: "avg_safety_compliance_score"
      expr: AVG(CAST(safety_compliance_score AS DOUBLE))
      comment: "Average safety compliance performance score. Safety performance is a critical dimension for water utility operators — low scores trigger targeted safety training."
    - name: "avg_regulatory_knowledge_score"
      expr: AVG(CAST(regulatory_knowledge_score AS DOUBLE))
      comment: "Average regulatory knowledge score. Measures workforce competency in regulatory requirements — essential for maintaining compliance culture."
    - name: "avg_technical_skills_score"
      expr: AVG(CAST(technical_skills_score AS DOUBLE))
      comment: "Average technical skills score. Measures workforce technical competency for operational effectiveness and training needs identification."
    - name: "promotion_recommended_count"
      expr: COUNT(CASE WHEN promotion_recommended_flag = TRUE THEN performance_review_id END)
      comment: "Count of employees recommended for promotion. Measures internal talent pipeline health and career development program effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave management metrics for workforce availability planning, FMLA compliance, and operational coverage risk assessment. Critical for 24/7 water utility operations where staffing gaps create regulatory risk."
  source: "`vibe_water_utilities_v1`.`workforce`.`leave_request`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (FMLA, PTO, Sick, Military, Bereavement) for leave portfolio analysis."
    - name: "leave_subtype"
      expr: leave_subtype
      comment: "Leave subtype for detailed categorization within leave type."
    - name: "request_status"
      expr: request_status
      comment: "Current status of the leave request (Pending, Approved, Denied, Cancelled) for pipeline management."
    - name: "is_fmla_eligible"
      expr: is_fmla_eligible
      comment: "Whether the leave qualifies under FMLA, for federal compliance tracking."
    - name: "is_emergency_leave"
      expr: is_emergency_leave
      comment: "Whether the leave is emergency/unplanned, for operational disruption analysis."
    - name: "is_paid"
      expr: is_paid
      comment: "Whether the leave is paid, for payroll cost impact analysis."
    - name: "requested_start_date_month"
      expr: DATE_TRUNC('MONTH', requested_start_date)
      comment: "Month leave was requested for seasonal absence pattern analysis."
    - name: "requested_start_date_year"
      expr: DATE_TRUNC('YEAR', requested_start_date)
      comment: "Year leave was requested for annual absence trend reporting."
  measures:
    - name: "total_leave_requests"
      expr: COUNT(DISTINCT leave_request_id)
      comment: "Total leave requests submitted. Baseline for absence management volume tracking."
    - name: "approved_leave_count"
      expr: COUNT(CASE WHEN request_status = 'Approved' THEN leave_request_id END)
      comment: "Count of approved leave requests. Measures approved absence volume for workforce availability planning."
    - name: "fmla_leave_count"
      expr: COUNT(CASE WHEN is_fmla_eligible = TRUE THEN leave_request_id END)
      comment: "Count of FMLA-eligible leave requests. Tracks federal FMLA compliance obligations and associated workforce availability impact."
    - name: "emergency_leave_count"
      expr: COUNT(CASE WHEN is_emergency_leave = TRUE THEN leave_request_id END)
      comment: "Count of emergency/unplanned leave requests. High rates indicate workforce health issues or morale problems requiring HR intervention."
    - name: "total_hours_approved"
      expr: SUM(CAST(hours_approved AS DOUBLE))
      comment: "Total approved leave hours. Quantifies workforce availability reduction for operational capacity planning."
    - name: "total_hours_requested"
      expr: SUM(CAST(hours_requested AS DOUBLE))
      comment: "Total leave hours requested. Measures gross absence demand for staffing coverage planning."
    - name: "leave_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN request_status = 'Approved' THEN leave_request_id END) / NULLIF(COUNT(DISTINCT leave_request_id), 0), 2)
      comment: "Percentage of leave requests approved. Measures leave policy consistency and manager approval patterns."
    - name: "avg_accrual_balance_before"
      expr: AVG(CAST(accrual_balance_before AS DOUBLE))
      comment: "Average leave accrual balance before the request. Measures workforce leave liability and identifies employees at risk of forced leave."
    - name: "certification_required_leave_count"
      expr: COUNT(CASE WHEN certification_required = TRUE THEN leave_request_id END)
      comment: "Count of leave requests requiring medical or other certification. Tracks FMLA documentation compliance obligations."
    - name: "certification_received_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_required = TRUE AND certification_received = TRUE THEN leave_request_id END) / NULLIF(COUNT(CASE WHEN certification_required = TRUE THEN leave_request_id END), 0), 2)
      comment: "Percentage of certification-required leave requests where certification was received. Measures FMLA documentation compliance — gaps create legal exposure."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`workforce_crew`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field crew readiness, capacity, and safety metrics for operational planning and emergency response management. Tracks crew certifications, response performance, and safety compliance for water utility field operations."
  source: "`vibe_water_utilities_v1`.`workforce`.`crew`"
  dimensions:
    - name: "crew_type"
      expr: crew_type
      comment: "Type of crew (maintenance, emergency response, installation, inspection) for operational capacity analysis."
    - name: "crew_status"
      expr: crew_status
      comment: "Current operational status of the crew (Active, Inactive, Deployed) for availability tracking."
    - name: "certification_level"
      expr: certification_level
      comment: "Crew certification level for matching crew capability to work order requirements."
    - name: "emergency_response_qualified"
      expr: emergency_response_qualified
      comment: "Whether the crew is qualified for emergency response, for emergency dispatch planning."
    - name: "hazmat_certified"
      expr: hazmat_certified
      comment: "Whether the crew holds hazmat certification, for chemical incident response capability tracking."
    - name: "confined_space_certified"
      expr: confined_space_certified
      comment: "Whether the crew is certified for confined space entry, for work order assignment eligibility."
    - name: "union_affiliation"
      expr: union_affiliation
      comment: "Union affiliation of the crew for labor relations and contract compliance analysis."
    - name: "shift_schedule"
      expr: shift_schedule
      comment: "Crew shift schedule for coverage gap analysis and 24/7 operational planning."
  measures:
    - name: "total_active_crews"
      expr: COUNT(CASE WHEN crew_status = 'Active' THEN crew_id END)
      comment: "Total active field crews. Core operational capacity KPI for work order scheduling and emergency response planning."
    - name: "emergency_response_qualified_crew_count"
      expr: COUNT(CASE WHEN emergency_response_qualified = TRUE AND crew_status = 'Active' THEN crew_id END)
      comment: "Count of active crews qualified for emergency response. Critical for emergency preparedness planning — utilities must maintain minimum emergency response capacity."
    - name: "hazmat_certified_crew_count"
      expr: COUNT(CASE WHEN hazmat_certified = TRUE AND crew_status = 'Active' THEN crew_id END)
      comment: "Count of active hazmat-certified crews. Required for chemical spill response and treatment chemical handling operations."
    - name: "avg_response_time_minutes"
      expr: AVG(CAST(average_response_time_minutes AS DOUBLE))
      comment: "Average crew response time in minutes. Key operational SLA metric — exceeding targets triggers crew deployment strategy review."
    - name: "avg_hourly_labor_rate"
      expr: AVG(CAST(hourly_labor_rate AS DOUBLE))
      comment: "Average hourly labor rate across crews. Informs work order cost estimation and budget planning for field operations."
    - name: "gps_tracking_enabled_count"
      expr: COUNT(CASE WHEN gps_tracking_enabled = TRUE AND crew_status = 'Active' THEN crew_id END)
      comment: "Count of active crews with GPS tracking enabled. Measures field operations visibility and dispatch optimization capability."
    - name: "safety_training_current_crew_count"
      expr: COUNT(CASE WHEN last_safety_training_date >= DATE_ADD(CURRENT_DATE, -365) AND crew_status = 'Active' THEN crew_id END)
      comment: "Count of active crews with safety training completed within the last year. Measures field safety compliance and identifies crews requiring retraining."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`workforce_shift_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift coverage, overtime, and labor cost metrics for 24/7 water utility operations management. Tracks shift compliance, emergency callouts, and labor cost by shift type."
  source: "`vibe_water_utilities_v1`.`workforce`.`shift_assignment`"
  dimensions:
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (day, evening, night, weekend, holiday) for shift differential cost and coverage analysis."
    - name: "shift_role"
      expr: shift_role
      comment: "Role assigned during the shift (operator, supervisor, on-call) for staffing adequacy analysis."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the shift assignment (Scheduled, Completed, Absent, Swapped) for coverage tracking."
    - name: "overtime_flag"
      expr: overtime_flag
      comment: "Whether the shift involved overtime, for overtime cost and staffing adequacy analysis."
    - name: "emergency_callout_flag"
      expr: emergency_callout_flag
      comment: "Whether the shift was an emergency callout, for unplanned labor cost tracking."
    - name: "on_call_flag"
      expr: on_call_flag
      comment: "Whether the employee was on-call during this assignment, for on-call cost analysis."
    - name: "assigned_date_month"
      expr: DATE_TRUNC('MONTH', assigned_date)
      comment: "Month of shift assignment for trend analysis and seasonal staffing pattern identification."
    - name: "certification_verified_flag"
      expr: certification_verified_flag
      comment: "Whether required certifications were verified for this shift, for regulatory compliance tracking."
  measures:
    - name: "total_shift_assignments"
      expr: COUNT(DISTINCT shift_assignment_id)
      comment: "Total shift assignments. Baseline for shift coverage volume and scheduling completeness analysis."
    - name: "overtime_shift_count"
      expr: COUNT(CASE WHEN overtime_flag = TRUE THEN shift_assignment_id END)
      comment: "Count of shifts involving overtime. High counts indicate chronic understaffing requiring workforce planning intervention."
    - name: "emergency_callout_count"
      expr: COUNT(CASE WHEN emergency_callout_flag = TRUE THEN shift_assignment_id END)
      comment: "Count of emergency callout shifts. Measures unplanned operational demand and associated premium labor cost exposure."
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total scheduled shift hours. Measures planned workforce capacity for operational coverage planning."
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual hours worked across all shift assignments. Measures realized workforce utilization."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours across all shift assignments. Quantifies overtime cost exposure and staffing gap magnitude."
    - name: "overtime_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(actual_hours AS DOUBLE)), 0), 2)
      comment: "Overtime as a percentage of total actual hours. Exceeding utility benchmarks (typically 5-10%) triggers staffing review and budget escalation."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost across all shift assignments. Primary cost management KPI for operational budget control."
    - name: "avg_labor_cost_per_shift"
      expr: AVG(CAST(labor_cost_amount AS DOUBLE))
      comment: "Average labor cost per shift assignment. Benchmarks shift cost efficiency and informs scheduling optimization decisions."
    - name: "certification_unverified_shift_count"
      expr: COUNT(CASE WHEN certification_verified_flag = FALSE AND certification_required IS NOT NULL THEN shift_assignment_id END)
      comment: "Count of shifts where required certifications were not verified. Represents regulatory compliance risk — uncertified operators on regulated equipment is a permit violation."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`workforce_employee_headcount`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core headcount and tenure metrics for workforce planning"
  source: "`vibe_water_utilities_v1`.`workforce`.`employee`"
  dimensions:
    - name: "department_code"
      expr: department_code
      comment: "Department code the employee belongs to"
    - name: "job_title"
      expr: job_title
      comment: "Job title of the employee"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (e.g., Full-Time, Part-Time)"
    - name: "hire_date"
      expr: hire_date
      comment: "Date the employee was hired"
    - name: "union_membership_flag"
      expr: union_membership_flag
      comment: "Indicates if employee is a union member"
  measures:
    - name: "total_headcount"
      expr: COUNT(DISTINCT employee_id)
      comment: "Total number of unique employees in the workforce"
    - name: "active_employee_count"
      expr: SUM(CASE WHEN employment_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of employees whose employment status is Active"
    - name: "average_years_of_service"
      expr: AVG(DATEDIFF(current_date(), hire_date) / 365.0)
      comment: "Average tenure of employees in years"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`workforce_labor_timesheet_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor cost and productivity metrics derived from timesheets"
  source: "`vibe_water_utilities_v1`.`workforce`.`labor_timesheet`"
  dimensions:
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center associated with the labor"
    - name: "employee_id"
      expr: employee_id
      comment: "Employee who logged the timesheet"
    - name: "activity_type"
      expr: activity_type
      comment: "Type of labor activity"
    - name: "payroll_period"
      expr: payroll_period
      comment: "Payroll period for the timesheet"
    - name: "timesheet_date"
      expr: timesheet_date
      comment: "Date of the timesheet entry"
  measures:
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total labor hours recorded"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours recorded"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost incurred"
    - name: "average_labor_rate"
      expr: AVG(CAST(labor_rate AS DOUBLE))
      comment: "Average labor rate per hour"
    - name: "timesheet_record_count"
      expr: COUNT(1)
      comment: "Number of timesheet records"
$$;