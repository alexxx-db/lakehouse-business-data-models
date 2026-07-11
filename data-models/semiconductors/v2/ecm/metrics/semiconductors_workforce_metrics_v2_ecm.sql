-- Metric views for domain: workforce | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 11:52:05

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core workforce headcount and compensation metrics for executive workforce planning, cost management, and talent strategy decisions."
  source: "`vibe_semiconductors_v1`.`workforce`.`employee`"
  dimensions:
    - name: "employment_type"
      expr: employment_type
      comment: "Full-time, part-time, contract classification for workforce mix analysis."
    - name: "employee_status"
      expr: employee_status
      comment: "Active, terminated, on-leave status for headcount reporting."
    - name: "department"
      expr: department
      comment: "Organizational department for cost and headcount allocation."
    - name: "job_title"
      expr: job_title
      comment: "Job title for role-level workforce analysis."
    - name: "salary_grade"
      expr: salary_grade
      comment: "Salary grade band for compensation benchmarking."
    - name: "location"
      expr: location
      comment: "Physical work location for geographic workforce distribution."
    - name: "education_level"
      expr: education_level
      comment: "Highest education attained for talent pipeline analysis."
    - name: "organization_level"
      expr: organization_level
      comment: "Hierarchy level (IC, manager, director, VP) for span-of-control analysis."
    - name: "hire_date_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month of hire for cohort and attrition trend analysis."
    - name: "termination_date_month"
      expr: DATE_TRUNC('MONTH', termination_date)
      comment: "Month of termination for attrition trend analysis."
    - name: "overtime_eligible"
      expr: overtime_eligible
      comment: "Whether the employee is eligible for overtime pay."
    - name: "union_member_flag"
      expr: union_member_flag
      comment: "Union membership flag for labor relations reporting."
    - name: "itar_eligibility"
      expr: itar_eligibility
      comment: "ITAR eligibility flag critical for export-controlled fab operations."
    - name: "ear_eligibility"
      expr: ear_eligibility
      comment: "EAR eligibility flag for export control compliance workforce planning."
  measures:
    - name: "total_headcount"
      expr: COUNT(DISTINCT employee_id)
      comment: "Total distinct employee headcount. Primary workforce sizing KPI used in every executive workforce review."
    - name: "active_headcount"
      expr: COUNT(DISTINCT CASE WHEN employee_status = 'Active' THEN employee_id END)
      comment: "Count of currently active employees. Drives capacity planning and fab staffing decisions."
    - name: "total_compensation_amount"
      expr: SUM(CAST(compensation_amount AS DOUBLE))
      comment: "Total annualized compensation cost across all employees. Key input to workforce cost budgeting and P&L."
    - name: "avg_compensation_amount"
      expr: AVG(CAST(compensation_amount AS DOUBLE))
      comment: "Average compensation per employee. Used for benchmarking against industry and identifying pay equity gaps."
    - name: "terminated_headcount"
      expr: COUNT(DISTINCT CASE WHEN termination_date IS NOT NULL THEN employee_id END)
      comment: "Count of terminated employees in the period. Numerator for voluntary/involuntary attrition rate."
    - name: "itar_eligible_headcount"
      expr: COUNT(DISTINCT CASE WHEN itar_eligibility = TRUE THEN employee_id END)
      comment: "Count of ITAR-eligible employees. Critical for export-controlled semiconductor fab capacity planning."
    - name: "manager_headcount"
      expr: COUNT(DISTINCT CASE WHEN manager_employee_id IS NOT NULL THEN manager_employee_id END)
      comment: "Count of distinct managers in the organization. Used to compute span of control."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_compensation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation cost, structure, and equity metrics for total rewards strategy, budget management, and pay equity analysis in semiconductor operations."
  source: "`vibe_semiconductors_v1`.`workforce`.`compensation`"
  dimensions:
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation (base, bonus, equity, shift differential) for total rewards decomposition."
    - name: "compensation_status"
      expr: compensation_status
      comment: "Active/inactive status of the compensation record."
    - name: "employment_type"
      expr: employment_type
      comment: "Full-time vs part-time classification for compensation mix analysis."
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade band for compensation equity and benchmarking analysis."
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Payroll frequency (weekly, bi-weekly, monthly) for payroll operations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of compensation for multi-currency global workforce cost consolidation."
    - name: "department_code"
      expr: department_code
      comment: "Department cost center for compensation cost allocation."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type (day, night, rotating) for fab shift differential cost analysis."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month compensation became effective for trend and cycle analysis."
    - name: "is_current"
      expr: is_current
      comment: "Flag indicating whether this is the current active compensation record."
    - name: "equity_grant_eligibility"
      expr: equity_grant_eligibility
      comment: "Whether the employee is eligible for equity grants — key for retention program analysis."
    - name: "overtime_eligible"
      expr: overtime_eligible
      comment: "Overtime eligibility flag for labor cost risk assessment."
  measures:
    - name: "total_base_amount"
      expr: SUM(CAST(base_amount AS DOUBLE))
      comment: "Total base salary cost across all compensation records. Primary input to workforce cost budgeting."
    - name: "avg_base_amount"
      expr: AVG(CAST(base_amount AS DOUBLE))
      comment: "Average base salary per compensation record. Used for pay equity analysis and market benchmarking."
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus payout cost. Key metric for variable compensation budget management."
    - name: "avg_bonus_target_percent"
      expr: AVG(CAST(bonus_target_percent AS DOUBLE))
      comment: "Average bonus target as a percentage of base. Indicates incentive intensity across the workforce."
    - name: "total_equity_grant_amount"
      expr: SUM(CAST(equity_grant_amount AS DOUBLE))
      comment: "Total equity grant value. Critical for retention cost and dilution planning in semiconductor talent competition."
    - name: "total_shift_differential_amount"
      expr: SUM(CAST(shift_differential_amount AS DOUBLE))
      comment: "Total shift differential cost. Fab operations run 24/7 shifts; this drives fab labor cost premium."
    - name: "total_variable_compensation_actual"
      expr: SUM(CAST(variable_compensation_actual AS DOUBLE))
      comment: "Total actual variable compensation paid. Compared against target to assess incentive plan effectiveness."
    - name: "total_variable_compensation_target"
      expr: SUM(CAST(variable_compensation_target AS DOUBLE))
      comment: "Total targeted variable compensation. Denominator for variable pay attainment rate."
    - name: "total_overtime_rate_multiplier_avg"
      expr: AVG(CAST(overtime_rate_multiplier AS DOUBLE))
      comment: "Average overtime rate multiplier across eligible employees. Informs fab shift scheduling cost decisions."
    - name: "compensation_record_count"
      expr: COUNT(1)
      comment: "Total compensation records. Used to validate completeness of compensation data for audit purposes."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_employment_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce movement and change event metrics for attrition analysis, promotion velocity, and organizational change management in semiconductor operations."
  source: "`vibe_semiconductors_v1`.`workforce`.`employment_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of employment event (hire, termination, promotion, transfer, leave) for workforce movement analysis."
    - name: "event_status"
      expr: event_status
      comment: "Status of the employment event (pending, approved, completed) for workflow tracking."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the event (voluntary resignation, involuntary, retirement) for attrition root cause analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for compensation change amounts in multi-currency global operations."
    - name: "new_organization"
      expr: new_organization
      comment: "Destination organization for transfer events — tracks internal mobility patterns."
    - name: "new_position"
      expr: new_position
      comment: "New position after the event for promotion and transfer analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the employment event took effect for trend analysis."
    - name: "effective_date_quarter"
      expr: DATE_TRUNC('QUARTER', effective_date)
      comment: "Quarter the employment event took effect for quarterly workforce review."
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total employment events in the period. Baseline for workforce movement volume."
    - name: "total_compensation_change_amount"
      expr: SUM(CAST(compensation_change_amount AS DOUBLE))
      comment: "Total compensation change value across all events. Measures total cost impact of workforce changes."
    - name: "avg_compensation_change_amount"
      expr: AVG(CAST(compensation_change_amount AS DOUBLE))
      comment: "Average compensation change per event. Benchmarks raise/promotion increments against policy targets."
    - name: "hire_event_count"
      expr: COUNT(CASE WHEN event_type = 'Hire' THEN 1 END)
      comment: "Count of new hire events. Tracks recruiting throughput against headcount plan."
    - name: "termination_event_count"
      expr: COUNT(CASE WHEN event_type = 'Termination' THEN 1 END)
      comment: "Count of termination events. Primary input to attrition rate calculation."
    - name: "promotion_event_count"
      expr: COUNT(CASE WHEN event_type = 'Promotion' THEN 1 END)
      comment: "Count of promotion events. Tracks internal career progression velocity."
    - name: "approved_event_count"
      expr: COUNT(CASE WHEN event_status = 'Approved' THEN 1 END)
      comment: "Count of approved employment events. Measures HR workflow throughput and approval cycle efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor hours, cost, and productivity metrics for fab operations scheduling, overtime management, and labor cost control in semiconductor manufacturing."
  source: "`vibe_semiconductors_v1`.`workforce`.`time_entry`"
  dimensions:
    - name: "time_entry_type"
      expr: time_entry_type
      comment: "Type of time entry (regular, overtime, absence) for labor category analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the time entry for payroll readiness and compliance."
    - name: "labor_category"
      expr: labor_category
      comment: "Labor category (direct, indirect, overhead) for cost allocation to fab cost centers."
    - name: "labor_grade"
      expr: labor_grade
      comment: "Labor grade for cost rate analysis and workforce mix optimization."
    - name: "absence_type"
      expr: absence_type
      comment: "Type of absence (sick, vacation, FMLA) for absence management and capacity planning."
    - name: "is_billable"
      expr: is_billable
      comment: "Whether the time is billable to a customer or project — critical for NRE project cost recovery."
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status for billable time entries — tracks revenue recognition readiness."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for labor cost allocation to fab departments."
    - name: "work_date_month"
      expr: DATE_TRUNC('MONTH', work_date)
      comment: "Month of work for labor cost trend analysis."
    - name: "work_date_week"
      expr: DATE_TRUNC('WEEK', work_date)
      comment: "Week of work for operational scheduling and overtime monitoring."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift code for fab shift-level labor analysis."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating a compliance issue with the time entry — drives labor law risk management."
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours worked. Primary measure of productive labor capacity utilization."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours. Key metric for fab staffing adequacy and labor cost risk."
    - name: "total_absence_duration_hours"
      expr: SUM(CAST(absence_duration_hours AS DOUBLE))
      comment: "Total absence hours. Drives capacity planning adjustments and absence cost quantification."
    - name: "total_shift_differential_hours"
      expr: SUM(CAST(shift_differential_hours AS DOUBLE))
      comment: "Total hours attracting shift differential pay. Quantifies fab 24/7 operations premium labor cost."
    - name: "total_labor_amount"
      expr: SUM(CAST(labor_amount AS DOUBLE))
      comment: "Total labor cost amount. Primary input to fab cost-of-goods-sold and operational expense reporting."
    - name: "avg_labor_rate"
      expr: AVG(CAST(labor_rate AS DOUBLE))
      comment: "Average labor rate per hour. Used for standard cost setting and variance analysis."
    - name: "avg_overtime_multiplier"
      expr: AVG(CAST(overtime_multiplier AS DOUBLE))
      comment: "Average overtime rate multiplier. Informs shift scheduling decisions to minimize premium labor cost."
    - name: "compliance_flagged_entries"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Count of time entries with compliance flags. Drives labor law risk remediation actions."
    - name: "billable_hours"
      expr: SUM(CASE WHEN is_billable = TRUE THEN CAST(regular_hours AS DOUBLE) ELSE 0 END)
      comment: "Total billable regular hours. Tracks NRE and customer project labor cost recovery."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_training`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training completion, compliance, and effectiveness metrics for workforce development, regulatory compliance, and fab operator qualification management."
  source: "`vibe_semiconductors_v1`.`workforce`.`training`"
  dimensions:
    - name: "training_status"
      expr: training_status
      comment: "Status of the training record (enrolled, completed, failed, expired) for compliance tracking."
    - name: "training_category"
      expr: training_category
      comment: "Category of training (safety, technical, compliance, leadership) for program investment analysis."
    - name: "delivery_mode"
      expr: delivery_mode
      comment: "Training delivery mode (in-person, e-learning, OJT) for cost and effectiveness analysis."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail outcome for training assessments — drives retraining decisions."
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Whether the training is mandatory for regulatory or safety compliance."
    - name: "compliance_requirement"
      expr: compliance_requirement
      comment: "Specific compliance regulation driving the training requirement (OSHA, ITAR, EHS)."
    - name: "completion_date_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month of training completion for compliance deadline tracking."
    - name: "compliance_deadline_month"
      expr: DATE_TRUNC('MONTH', compliance_deadline)
      comment: "Month of compliance deadline for overdue training identification."
    - name: "recurrence_interval"
      expr: recurrence_interval
      comment: "How often the training must be repeated — drives training schedule planning."
  measures:
    - name: "total_training_records"
      expr: COUNT(1)
      comment: "Total training enrollment records. Baseline for training program volume and coverage."
    - name: "completed_training_count"
      expr: COUNT(CASE WHEN training_status = 'Completed' THEN 1 END)
      comment: "Count of completed training records. Numerator for training completion rate."
    - name: "mandatory_overdue_count"
      expr: COUNT(CASE WHEN mandatory_flag = TRUE AND training_status != 'Completed' AND compliance_deadline < CURRENT_DATE() THEN 1 END)
      comment: "Count of overdue mandatory training records. Critical compliance risk metric — drives immediate remediation."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across training completions. Measures training effectiveness and knowledge retention."
    - name: "avg_assessment_pass_threshold"
      expr: AVG(CAST(assessment_pass_threshold AS DOUBLE))
      comment: "Average passing threshold across training programs. Benchmarks rigor of training standards."
    - name: "passed_training_count"
      expr: COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END)
      comment: "Count of passed training assessments. Numerator for first-pass training pass rate."
    - name: "failed_training_count"
      expr: COUNT(CASE WHEN pass_fail_status = 'Fail' THEN 1 END)
      comment: "Count of failed training assessments. Triggers retraining and competency gap analysis."
    - name: "distinct_trained_employees"
      expr: COUNT(DISTINCT primary_training_employee_id)
      comment: "Count of distinct employees who have training records. Measures training program reach."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_fab_operator_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fab operator qualification coverage, expiry, and compliance metrics critical for semiconductor manufacturing line readiness and regulatory compliance."
  source: "`vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status (qualified, expired, suspended, pending) for line readiness assessment."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (tool, process, safety) for coverage analysis by category."
    - name: "qualification_level"
      expr: qualification_level
      comment: "Proficiency level of the qualification for advanced operator identification."
    - name: "skill_category"
      expr: skill_category
      comment: "Skill category associated with the qualification for workforce capability mapping."
    - name: "suspension_flag"
      expr: suspension_flag
      comment: "Whether the qualification is currently suspended — directly impacts fab line staffing."
    - name: "qualification_date_month"
      expr: DATE_TRUNC('MONTH', qualification_date)
      comment: "Month qualification was granted for qualification throughput trend analysis."
    - name: "requalification_due_date_month"
      expr: DATE_TRUNC('MONTH', requalification_due_date)
      comment: "Month requalification is due for proactive scheduling of requalification events."
    - name: "shift_qualification"
      expr: shift_qualification
      comment: "Shift for which the qualification applies — critical for 24/7 fab shift coverage planning."
  measures:
    - name: "total_qualifications"
      expr: COUNT(1)
      comment: "Total operator qualification records. Baseline for qualification coverage assessment."
    - name: "active_qualifications"
      expr: COUNT(CASE WHEN qualification_status = 'Qualified' THEN 1 END)
      comment: "Count of currently active qualifications. Measures available qualified operator capacity."
    - name: "expired_qualifications"
      expr: COUNT(CASE WHEN qualification_status = 'Expired' THEN 1 END)
      comment: "Count of expired qualifications. Drives urgent requalification scheduling to maintain line readiness."
    - name: "suspended_qualifications"
      expr: COUNT(CASE WHEN suspension_flag = TRUE THEN 1 END)
      comment: "Count of suspended qualifications. Directly impacts available staffing for affected tools/processes."
    - name: "distinct_qualified_operators"
      expr: COUNT(DISTINCT employee_id)
      comment: "Count of distinct qualified operators. Measures breadth of qualified workforce for fab capacity planning."
    - name: "distinct_qualified_tools"
      expr: COUNT(DISTINCT fab_tool_id)
      comment: "Count of distinct fab tools with at least one qualified operator. Measures tool coverage completeness."
    - name: "requalification_due_within_30_days"
      expr: COUNT(CASE WHEN requalification_due_date <= DATE_ADD(CURRENT_DATE(), 30) AND qualification_status = 'Qualified' THEN 1 END)
      comment: "Qualifications expiring within 30 days. Proactive risk metric for fab line continuity planning."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_safety_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "EHS safety incident metrics for OSHA compliance, fab safety culture measurement, and risk management in semiconductor cleanroom operations."
  source: "`vibe_semiconductors_v1`.`workforce`.`safety_event`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of safety incident (injury, near-miss, chemical exposure, equipment) for root cause categorization."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the incident (minor, moderate, serious, critical) for risk prioritization."
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident investigation for closure tracking."
    - name: "osha_recordable_flag"
      expr: osha_recordable_flag
      comment: "Whether the incident is OSHA recordable — directly impacts regulatory reporting obligations."
    - name: "near_miss_flag"
      expr: near_miss_flag
      comment: "Whether the event was a near-miss — leading indicator of future incidents."
    - name: "injury_type"
      expr: injury_type
      comment: "Type of injury sustained for medical and safety program analysis."
    - name: "exposure_chemical"
      expr: exposure_chemical
      comment: "Chemical involved in exposure incidents — critical for cleanroom chemical safety management."
    - name: "regulatory_reporting_status"
      expr: regulatory_reporting_status
      comment: "Status of regulatory reporting for the incident — tracks compliance with OSHA reporting deadlines."
    - name: "report_date_month"
      expr: DATE_TRUNC('MONTH', report_date)
      comment: "Month the incident was reported for trend analysis and safety performance tracking."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the root cause investigation for corrective action management."
  measures:
    - name: "total_safety_events"
      expr: COUNT(1)
      comment: "Total safety events recorded. Primary safety performance indicator for executive EHS dashboards."
    - name: "osha_recordable_count"
      expr: COUNT(CASE WHEN osha_recordable_flag = TRUE THEN 1 END)
      comment: "Count of OSHA recordable incidents. Directly drives OSHA 300 log and regulatory reporting obligations."
    - name: "near_miss_count"
      expr: COUNT(CASE WHEN near_miss_flag = TRUE THEN 1 END)
      comment: "Count of near-miss events. Leading safety indicator — high near-miss rates predict future injuries."
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of safety incidents. Quantifies financial impact of safety failures for ROI of safety investments."
    - name: "avg_cost_estimate"
      expr: AVG(CAST(cost_estimate AS DOUBLE))
      comment: "Average cost per safety incident. Benchmarks incident cost for insurance and safety program investment decisions."
    - name: "open_investigations"
      expr: COUNT(CASE WHEN investigation_status != 'Closed' THEN 1 END)
      comment: "Count of safety events with open investigations. Tracks corrective action backlog and closure velocity."
    - name: "distinct_affected_employees"
      expr: COUNT(DISTINCT affected_employee_id)
      comment: "Count of distinct employees affected by safety events. Measures breadth of safety impact on workforce."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_competency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce competency and skill proficiency metrics for talent development, critical skill gap identification, and succession planning in semiconductor R&D and fab operations."
  source: "`vibe_semiconductors_v1`.`workforce`.`competency`"
  dimensions:
    - name: "proficiency_level"
      expr: proficiency_level
      comment: "Proficiency level (novice, intermediate, expert) for skill depth analysis."
    - name: "certification_status"
      expr: certification_status
      comment: "Status of associated certification (active, expired, pending) for compliance tracking."
    - name: "record_status"
      expr: record_status
      comment: "Status of the competency record for data quality filtering."
    - name: "skill_criticality"
      expr: skill_criticality
      comment: "Criticality of the skill to operations (critical, important, nice-to-have) for gap prioritization."
    - name: "skill_required_for_role"
      expr: skill_required_for_role
      comment: "Whether the skill is required for the employee's current role — drives gap analysis."
    - name: "assessment_method"
      expr: assessment_method
      comment: "Method used to assess competency (test, observation, certification) for validity analysis."
    - name: "skill_training_method"
      expr: skill_training_method
      comment: "Training method used to develop the skill for program effectiveness analysis."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of competency assessment for skill development trend analysis."
    - name: "certification_required"
      expr: certification_required
      comment: "Whether a formal certification is required for this competency."
  measures:
    - name: "total_competency_records"
      expr: COUNT(1)
      comment: "Total competency records. Baseline for workforce skill coverage measurement."
    - name: "avg_proficiency_score"
      expr: AVG(CAST(proficiency_score AS DOUBLE))
      comment: "Average proficiency score across all competency assessments. Measures overall workforce skill level."
    - name: "total_skill_training_hours"
      expr: SUM(CAST(skill_training_hours AS DOUBLE))
      comment: "Total training hours invested in skill development. Quantifies workforce development investment."
    - name: "avg_skill_training_hours"
      expr: AVG(CAST(skill_training_hours AS DOUBLE))
      comment: "Average training hours per competency record. Benchmarks training intensity per skill."
    - name: "critical_skill_gaps"
      expr: COUNT(CASE WHEN skill_criticality = 'Critical' AND skill_required_for_role = 'Yes' AND proficiency_level IN ('Novice', 'None') THEN 1 END)
      comment: "Count of critical skill gaps where required skills are at low proficiency. Drives urgent talent development actions."
    - name: "expired_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Expired' THEN 1 END)
      comment: "Count of expired certifications. Compliance risk metric for regulated semiconductor processes."
    - name: "distinct_skilled_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Count of distinct employees with competency records. Measures skill assessment program coverage."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_contractor_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contractor workforce cost, compliance, and risk metrics for contingent labor management, supplier performance, and export control compliance in semiconductor operations."
  source: "`vibe_semiconductors_v1`.`workforce`.`contractor_engagement`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Status of the contractor engagement (active, expired, terminated) for contingent workforce management."
    - name: "contractor_type"
      expr: contractor_type
      comment: "Type of contractor (staff augmentation, SOW, consulting) for spend category analysis."
    - name: "engagement_type"
      expr: engagement_type
      comment: "Engagement model for the contractor for procurement and compliance classification."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract for multi-currency spend consolidation."
    - name: "headcount_classification"
      expr: headcount_classification
      comment: "Whether the contractor counts toward headcount for workforce planning purposes."
    - name: "export_control_status"
      expr: export_control_status
      comment: "Export control compliance status — critical for ITAR/EAR compliance in semiconductor fab access."
    - name: "nda_status"
      expr: nda_status
      comment: "NDA execution status for IP protection compliance."
    - name: "is_ear_contract"
      expr: is_ear_contract
      comment: "Whether the contract involves EAR-controlled technology — drives export compliance requirements."
    - name: "is_it_ar_contract"
      expr: is_it_ar_contract
      comment: "Whether the contract involves ITAR-controlled technology — highest export control risk category."
    - name: "invoice_frequency"
      expr: invoice_frequency
      comment: "Billing frequency for cash flow and accounts payable planning."
    - name: "contract_start_date_month"
      expr: DATE_TRUNC('MONTH', contract_start_date)
      comment: "Month contract started for contingent workforce trend analysis."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total value of all contractor engagements. Primary contingent labor spend metric for budget management."
    - name: "avg_billing_rate"
      expr: AVG(CAST(billing_rate AS DOUBLE))
      comment: "Average contractor billing rate. Benchmarks contingent labor cost against market rates."
    - name: "active_contractor_count"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN 1 END)
      comment: "Count of active contractor engagements. Measures current contingent workforce size."
    - name: "itar_contract_count"
      expr: COUNT(CASE WHEN is_it_ar_contract = TRUE THEN 1 END)
      comment: "Count of ITAR-controlled contractor engagements. Drives export compliance audit scope."
    - name: "export_control_non_compliant_count"
      expr: COUNT(CASE WHEN export_control_status != 'Compliant' THEN 1 END)
      comment: "Count of contractor engagements with non-compliant export control status. Critical compliance risk metric."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Count of distinct staffing suppliers. Measures supplier concentration risk in contingent labor."
    - name: "total_engagements"
      expr: COUNT(1)
      comment: "Total contractor engagement records. Baseline for contingent workforce program scope."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_shift_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fab shift scheduling, labor cost, and overtime metrics for 24/7 semiconductor manufacturing operations management and workforce capacity planning."
  source: "`vibe_semiconductors_v1`.`workforce`.`shift_schedule`"
  dimensions:
    - name: "shift_schedule_status"
      expr: shift_schedule_status
      comment: "Status of the shift schedule (active, cancelled, completed) for operational planning."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type (day, night, swing, rotating) for fab coverage analysis."
    - name: "work_area"
      expr: work_area
      comment: "Fab work area or bay for area-level staffing analysis."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for shift labor cost allocation."
    - name: "overtime_authorized"
      expr: overtime_authorized
      comment: "Whether overtime was authorized for this shift — tracks overtime approval compliance."
    - name: "start_timestamp_date"
      expr: DATE_TRUNC('DAY', start_timestamp)
      comment: "Date of shift start for daily staffing level analysis."
    - name: "start_timestamp_week"
      expr: DATE_TRUNC('WEEK', start_timestamp)
      comment: "Week of shift start for weekly staffing trend analysis."
  measures:
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost across all scheduled shifts. Primary fab direct labor cost metric."
    - name: "avg_labor_cost_per_shift"
      expr: AVG(CAST(labor_cost AS DOUBLE))
      comment: "Average labor cost per shift. Benchmarks shift cost efficiency across fab areas."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours scheduled. Measures fab overtime burden and associated premium cost risk."
    - name: "overtime_authorized_shifts"
      expr: COUNT(CASE WHEN overtime_authorized = TRUE THEN 1 END)
      comment: "Count of shifts with authorized overtime. Tracks overtime approval rate for labor cost governance."
    - name: "total_shifts_scheduled"
      expr: COUNT(1)
      comment: "Total shift schedule records. Baseline for fab staffing coverage analysis."
    - name: "distinct_employees_scheduled"
      expr: COUNT(DISTINCT primary_shift_employee_id)
      comment: "Count of distinct employees scheduled. Measures workforce utilization breadth across shifts."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_talent_acquisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruiting pipeline, time-to-fill, and talent acquisition cost metrics for workforce planning and hiring effectiveness in semiconductor talent competition."
  source: "`vibe_semiconductors_v1`.`workforce`.`talent_acquisition`"
  dimensions:
    - name: "talent_acquisition_status"
      expr: talent_acquisition_status
      comment: "Status of the requisition (open, filled, cancelled, on-hold) for pipeline management."
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of requisition (backfill, new headcount, NRE project) for demand categorization."
    - name: "priority"
      expr: priority
      comment: "Requisition priority (critical, high, medium, low) for recruiting resource allocation."
    - name: "source_channel"
      expr: source_channel
      comment: "Recruiting source channel (referral, agency, job board, campus) for sourcing effectiveness analysis."
    - name: "is_confidential"
      expr: is_confidential
      comment: "Whether the requisition is confidential — impacts recruiting strategy and disclosure."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for budget amounts in global recruiting."
    - name: "posted_timestamp_month"
      expr: DATE_TRUNC('MONTH', posted_timestamp)
      comment: "Month requisition was posted for recruiting pipeline trend analysis."
    - name: "target_start_date_month"
      expr: DATE_TRUNC('MONTH', target_start_date)
      comment: "Target start month for workforce planning alignment."
  measures:
    - name: "total_requisitions"
      expr: COUNT(1)
      comment: "Total talent acquisition requisitions. Baseline for recruiting pipeline volume."
    - name: "open_requisitions"
      expr: COUNT(CASE WHEN talent_acquisition_status = 'Open' THEN 1 END)
      comment: "Count of open requisitions. Measures current recruiting backlog and hiring demand."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total recruiting budget committed. Tracks talent acquisition spend against workforce plan."
    - name: "avg_budget_per_requisition"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per requisition. Benchmarks recruiting cost efficiency."
    - name: "critical_open_requisitions"
      expr: COUNT(CASE WHEN talent_acquisition_status = 'Open' AND priority = 'Critical' THEN 1 END)
      comment: "Count of critical open requisitions. Drives immediate recruiting resource prioritization."
    - name: "distinct_org_units_hiring"
      expr: COUNT(DISTINCT primary_talent_org_unit_id)
      comment: "Count of distinct org units with active requisitions. Measures breadth of hiring demand across the organization."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce certification and qualification compliance metrics for regulatory adherence, fab operator readiness, and quality system compliance in semiconductor manufacturing."
  source: "`vibe_semiconductors_v1`.`workforce`.`workforce_qualification`"
  dimensions:
    - name: "workforce_qualification_status"
      expr: workforce_qualification_status
      comment: "Status of the qualification (active, expired, revoked, pending) for compliance tracking."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (safety, process, quality, regulatory) for compliance category analysis."
    - name: "issuing_body"
      expr: issuing_body
      comment: "Organization that issued the certification for credential validity assessment."
    - name: "regulatory_mandate_flag"
      expr: regulatory_mandate_flag
      comment: "Whether the qualification is mandated by regulation — highest priority for compliance management."
    - name: "renewal_required"
      expr: renewal_required
      comment: "Whether the qualification requires periodic renewal for proactive expiry management."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the qualification is currently in compliance — direct compliance risk indicator."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of qualification expiry for proactive renewal scheduling."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month qualification was issued for qualification throughput trend analysis."
  measures:
    - name: "total_qualifications"
      expr: COUNT(1)
      comment: "Total workforce qualification records. Baseline for qualification program coverage."
    - name: "active_qualifications"
      expr: COUNT(CASE WHEN workforce_qualification_status = 'Active' THEN 1 END)
      comment: "Count of currently active qualifications. Measures compliant qualified workforce size."
    - name: "expired_qualifications"
      expr: COUNT(CASE WHEN workforce_qualification_status = 'Expired' THEN 1 END)
      comment: "Count of expired qualifications. Drives urgent renewal actions to maintain compliance."
    - name: "regulatory_mandated_non_compliant"
      expr: COUNT(CASE WHEN regulatory_mandate_flag = TRUE AND compliance_flag = FALSE THEN 1 END)
      comment: "Count of regulatory-mandated qualifications that are non-compliant. Highest-priority compliance risk metric."
    - name: "expiring_within_60_days"
      expr: COUNT(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 60) AND workforce_qualification_status = 'Active' THEN 1 END)
      comment: "Qualifications expiring within 60 days. Proactive compliance risk metric for renewal planning."
    - name: "distinct_qualified_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Count of distinct employees with qualification records. Measures qualification program reach."
    - name: "expiration_notice_pending"
      expr: COUNT(CASE WHEN expiration_notice_sent = FALSE AND expiry_date <= DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Count of qualifications expiring within 90 days where expiration notice has not been sent. Drives notification workflow actions."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_org_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Organizational structure, headcount capacity, and budget metrics for workforce planning, cost center management, and organizational design in semiconductor operations."
  source: "`vibe_semiconductors_v1`.`workforce`.`org_unit`"
  dimensions:
    - name: "org_unit_type"
      expr: org_unit_type
      comment: "Type of org unit (department, division, team, cost center) for organizational hierarchy analysis."
    - name: "org_unit_status"
      expr: org_unit_status
      comment: "Active/inactive status of the org unit for current structure reporting."
    - name: "functional_area"
      expr: functional_area
      comment: "Functional area (engineering, manufacturing, finance, HR) for cross-functional workforce analysis."
    - name: "is_cost_center"
      expr: is_cost_center
      comment: "Whether the org unit is a cost center for financial reporting alignment."
    - name: "is_profit_center"
      expr: is_profit_center
      comment: "Whether the org unit is a profit center for P&L responsibility tracking."
    - name: "is_global"
      expr: is_global
      comment: "Whether the org unit operates globally for international workforce planning."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the organizational hierarchy for span-of-control analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the org unit for regional workforce distribution analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Operating currency of the org unit for multi-currency budget consolidation."
  measures:
    - name: "total_org_units"
      expr: COUNT(1)
      comment: "Total org units in the organizational hierarchy. Baseline for organizational complexity measurement."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget across all org units. Measures total organizational resource allocation."
    - name: "avg_budget_per_org_unit"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per org unit. Benchmarks resource allocation equity across the organization."
    - name: "cost_center_count"
      expr: COUNT(CASE WHEN is_cost_center = TRUE THEN 1 END)
      comment: "Count of cost center org units. Measures financial reporting granularity."
    - name: "active_org_unit_count"
      expr: COUNT(CASE WHEN org_unit_status = 'Active' THEN 1 END)
      comment: "Count of active org units. Measures current organizational footprint."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_export_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Export control compliance metrics for ITAR/EAR workforce screening, risk management, and regulatory compliance in semiconductor technology access control."
  source: "`vibe_semiconductors_v1`.`workforce`.`export_control`"
  dimensions:
    - name: "export_control_status"
      expr: export_control_status
      comment: "Overall export control compliance status for workforce access risk assessment."
    - name: "itar_authorization_status"
      expr: itar_authorization_status
      comment: "ITAR authorization status — critical for access to controlled semiconductor technology."
    - name: "ear_license_status"
      expr: ear_license_status
      comment: "EAR license status for dual-use technology access control."
    - name: "ear_license_required"
      expr: ear_license_required
      comment: "Whether an EAR license is required for this employee's technology access."
    - name: "screening_outcome"
      expr: screening_outcome
      comment: "Outcome of the export control screening (cleared, denied, pending review)."
    - name: "visa_type"
      expr: visa_type
      comment: "Visa type for foreign national employees — determines export control requirements."
    - name: "screening_date_month"
      expr: DATE_TRUNC('MONTH', screening_date)
      comment: "Month of export control screening for compliance program activity tracking."
    - name: "periodic_rescreening_due_date_month"
      expr: DATE_TRUNC('MONTH', periodic_rescreening_due_date)
      comment: "Month rescreening is due for proactive compliance management."
  measures:
    - name: "total_export_control_records"
      expr: COUNT(1)
      comment: "Total export control screening records. Baseline for export compliance program coverage."
    - name: "non_compliant_count"
      expr: COUNT(CASE WHEN export_control_status != 'Compliant' THEN 1 END)
      comment: "Count of non-compliant export control records. Critical risk metric — non-compliance can result in severe regulatory penalties."
    - name: "itar_authorized_count"
      expr: COUNT(CASE WHEN itar_authorization_status = 'Authorized' THEN 1 END)
      comment: "Count of ITAR-authorized employees. Measures available workforce for controlled technology programs."
    - name: "rescreening_overdue_count"
      expr: COUNT(CASE WHEN periodic_rescreening_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of employees with overdue periodic rescreening. Drives immediate compliance remediation actions."
    - name: "ear_license_required_count"
      expr: COUNT(CASE WHEN ear_license_required = TRUE THEN 1 END)
      comment: "Count of employees requiring EAR licenses. Measures export license management workload."
$$;