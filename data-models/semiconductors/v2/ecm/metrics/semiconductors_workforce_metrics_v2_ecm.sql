-- Metric views for domain: workforce | Business: Semiconductors | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_cleanroom_access`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cleanroom access authorization and compliance metrics for fab security and contamination control"
  source: "`vibe_semiconductors_v1`.`workforce`.`cleanroom_access`"
  dimensions:
    - name: "access_status"
      expr: access_status
      comment: "Current access authorization status"
    - name: "cleanroom_access_status"
      expr: cleanroom_access_status
      comment: "Detailed cleanroom access status for compliance tracking"
    - name: "access_level"
      expr: access_level
      comment: "Level of cleanroom access granted"
    - name: "cleanroom_class"
      expr: cleanroom_class
      comment: "ISO cleanroom classification for contamination control"
    - name: "cleanroom_zone"
      expr: cleanroom_zone
      comment: "Specific cleanroom zone for area-based access control"
    - name: "gowning_certification_status"
      expr: gowning_certification_status
      comment: "Status of gowning certification for contamination prevention"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Overall qualification status for access eligibility"
    - name: "foreign_national_flag"
      expr: CASE WHEN foreign_national THEN 'Foreign National' ELSE 'Domestic' END
      comment: "Foreign national status for export control compliance"
    - name: "is_temporary_flag"
      expr: CASE WHEN is_temporary THEN 'Temporary' ELSE 'Permanent' END
      comment: "Whether access is temporary for visitor management"
  measures:
    - name: "total_access_records"
      expr: COUNT(DISTINCT cleanroom_access_id)
      comment: "Total cleanroom access records for access management tracking"
    - name: "active_access_count"
      expr: COUNT(DISTINCT CASE WHEN access_status = 'Active' THEN cleanroom_access_id END)
      comment: "Count of active access authorizations for current capacity planning"
    - name: "gowning_certified_count"
      expr: COUNT(DISTINCT CASE WHEN gowning_certification_flag THEN cleanroom_access_id END)
      comment: "Count of gowning-certified personnel for contamination control compliance"
    - name: "gowning_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN gowning_certification_flag THEN cleanroom_access_id END) / NULLIF(COUNT(DISTINCT cleanroom_access_id), 0), 2)
      comment: "Percentage of personnel with gowning certification for quality assurance"
    - name: "foreign_national_count"
      expr: COUNT(DISTINCT CASE WHEN foreign_national THEN cleanroom_access_id END)
      comment: "Count of foreign national access records for export control monitoring"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_compensation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation and total rewards metrics for budget planning and equity analysis"
  source: "`vibe_semiconductors_v1`.`workforce`.`compensation`"
  dimensions:
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation (base, bonus, equity)"
    - name: "compensation_status"
      expr: compensation_status
      comment: "Status of compensation record (active, pending, historical)"
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade level for equity analysis"
    - name: "salary_grade"
      expr: salary_grade
      comment: "Salary grade classification"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type for compensation segmentation"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of compensation for multi-currency reporting"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year compensation became effective for trend analysis"
    - name: "is_current_flag"
      expr: CASE WHEN is_current THEN 'Current' ELSE 'Historical' END
      comment: "Whether compensation record is currently active"
  measures:
    - name: "total_base_salary"
      expr: SUM(CAST(base_salary AS DOUBLE))
      comment: "Total base salary expense for budget planning"
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus payout for variable compensation analysis"
    - name: "total_equity_amount"
      expr: SUM(CAST(equity_amount AS DOUBLE))
      comment: "Total equity grant value for long-term incentive tracking"
    - name: "avg_base_salary"
      expr: AVG(CAST(base_salary AS DOUBLE))
      comment: "Average base salary for market competitiveness analysis"
    - name: "avg_bonus_target_pct"
      expr: AVG(CAST(bonus_target_percent AS DOUBLE))
      comment: "Average bonus target percentage for incentive plan design"
    - name: "total_compensation_records"
      expr: COUNT(DISTINCT compensation_id)
      comment: "Count of compensation records for data quality monitoring"
    - name: "equity_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN equity_grant_eligibility THEN compensation_id END)
      comment: "Count of equity-eligible compensation records for equity program sizing"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_competency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce competency and skills proficiency metrics. Used by HR and operations leadership to identify skills gaps, manage certification compliance, and ensure the workforce has the technical competencies required for advanced semiconductor manufacturing."
  source: "`vibe_semiconductors_v1`.`workforce`.`competency`"
  dimensions:
    - name: "competency_status"
      expr: competency_status
      comment: "Current status of the competency record (Active, Expired, In Progress) for competency coverage analysis."
    - name: "competency_category"
      expr: competency_category
      comment: "Category of competency (Technical, Safety, Leadership, Process) for skills portfolio analysis."
    - name: "competency_level"
      expr: competency_level
      comment: "Level of competency achieved (Awareness, Practitioner, Expert) for skills depth analysis."
    - name: "certification_status"
      expr: certification_status
      comment: "Status of the associated certification (Valid, Expired, Pending) for certification compliance tracking."
    - name: "skill_criticality"
      expr: skill_criticality
      comment: "Criticality of the skill (Critical, High, Medium, Low) for workforce risk and succession planning."
    - name: "export_control_relevant"
      expr: export_control_relevant
      comment: "Whether the competency is relevant to export-controlled technology, requiring additional access controls."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of competency assessment for trend analysis of skills development velocity."
    - name: "record_status"
      expr: record_status
      comment: "Record-level status for data quality and active record filtering."
  measures:
    - name: "total_competency_records"
      expr: COUNT(1)
      comment: "Total number of competency records. Baseline metric for competency program coverage."
    - name: "active_competencies"
      expr: COUNT(CASE WHEN competency_status = 'Active' THEN 1 END)
      comment: "Count of currently active competency records. Primary metric for workforce skills coverage."
    - name: "expired_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Expired' THEN 1 END)
      comment: "Count of competency records with expired certifications. Compliance risk metric requiring renewal action."
    - name: "avg_proficiency_score"
      expr: AVG(CAST(proficiency_score AS DOUBLE))
      comment: "Average proficiency score across all competency assessments. Used to benchmark workforce skills level against targets."
    - name: "total_skill_training_hours"
      expr: SUM(CAST(skill_training_hours AS DOUBLE))
      comment: "Total training hours invested in skill development. Used for training ROI and L&D budget effectiveness analysis."
    - name: "export_control_relevant_competencies"
      expr: COUNT(CASE WHEN export_control_relevant = TRUE THEN 1 END)
      comment: "Count of competencies relevant to export-controlled technology. Used for access control and compliance program scoping."
    - name: "unique_employees_with_competencies"
      expr: COUNT(DISTINCT employee_id)
      comment: "Count of distinct employees with competency records. Measures competency program reach across the workforce."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_contractor_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contractor and contingent workforce metrics for flexible capacity management and cost control"
  source: "`vibe_semiconductors_v1`.`workforce`.`contractor_engagement`"
  dimensions:
    - name: "engagement_status"
      expr: engagement_status
      comment: "Status of contractor engagement (active, completed, terminated)"
    - name: "contractor_engagement_status"
      expr: contractor_engagement_status
      comment: "Detailed engagement status for lifecycle tracking"
    - name: "contractor_type"
      expr: contractor_type
      comment: "Type of contractor (individual, agency, consulting firm)"
    - name: "engagement_type"
      expr: engagement_type
      comment: "Type of engagement (project-based, staff augmentation)"
    - name: "contract_status"
      expr: contract_status
      comment: "Status of contract for compliance tracking"
    - name: "export_control_status"
      expr: export_control_status
      comment: "Export control clearance status for compliance"
    - name: "background_check_status"
      expr: background_check_status
      comment: "Background check status for security compliance"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year engagement started for trend analysis"
  measures:
    - name: "total_engagements"
      expr: COUNT(DISTINCT contractor_engagement_id)
      comment: "Total contractor engagements for contingent workforce sizing"
    - name: "active_engagement_count"
      expr: COUNT(DISTINCT CASE WHEN engagement_status = 'Active' THEN contractor_engagement_id END)
      comment: "Count of active engagements for current contingent capacity"
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total contract value for contingent workforce spend analysis"
    - name: "avg_bill_rate"
      expr: AVG(CAST(bill_rate AS DOUBLE))
      comment: "Average bill rate for cost benchmarking"
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate for rate card management"
    - name: "export_control_cleared_count"
      expr: COUNT(DISTINCT CASE WHEN export_control_cleared THEN contractor_engagement_id END)
      comment: "Count of export-control-cleared contractors for compliance capacity"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core employee headcount and demographic metrics for workforce planning and compliance reporting"
  source: "`vibe_semiconductors_v1`.`workforce`.`employee`"
  dimensions:
    - name: "employee_status"
      expr: employee_status
      comment: "Current employment status (active, terminated, on leave)"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment classification (full-time, part-time, contractor)"
    - name: "department"
      expr: department
      comment: "Department assignment for organizational analysis"
    - name: "location"
      expr: location
      comment: "Geographic location of employee"
    - name: "job_title"
      expr: job_title
      comment: "Current job title"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year employee was hired for tenure analysis"
    - name: "clearance_level"
      expr: clearance_level
      comment: "Security clearance level for export control compliance"
    - name: "ear_eligibility_flag"
      expr: CASE WHEN ear_eligibility THEN 'Eligible' ELSE 'Not Eligible' END
      comment: "Export Administration Regulations eligibility status"
    - name: "itar_eligibility_flag"
      expr: CASE WHEN itar_eligibility THEN 'Eligible' ELSE 'Not Eligible' END
      comment: "International Traffic in Arms Regulations eligibility status"
    - name: "overtime_eligible_flag"
      expr: CASE WHEN overtime_eligible THEN 'Eligible' ELSE 'Not Eligible' END
      comment: "Overtime eligibility for labor cost planning"
  measures:
    - name: "total_headcount"
      expr: COUNT(DISTINCT employee_id)
      comment: "Total unique employee count for workforce capacity planning"
    - name: "active_headcount"
      expr: COUNT(DISTINCT CASE WHEN employee_status = 'Active' THEN employee_id END)
      comment: "Count of active employees for operational capacity analysis"
    - name: "avg_tenure_years"
      expr: AVG(DATEDIFF(CURRENT_DATE(), hire_date) / 365.25)
      comment: "Average employee tenure in years for retention analysis"
    - name: "avg_compensation_amount"
      expr: AVG(CAST(compensation_amount AS DOUBLE))
      comment: "Average compensation per employee for budget planning"
    - name: "total_compensation_cost"
      expr: SUM(CAST(compensation_amount AS DOUBLE))
      comment: "Total compensation expense for financial planning"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_employee_turnover`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Turnover and tenure metrics to assess workforce stability and retention effectiveness"
  source: "`vibe_semiconductors_v1`.`workforce`.`employee`"
  dimensions:
    - name: "department"
      expr: department
      comment: "Department of the employee"
    - name: "location"
      expr: location
      comment: "Geographic location of the employee"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire"
    - name: "termination_year"
      expr: YEAR(termination_date)
      comment: "Year of termination (if applicable)"
  measures:
    - name: "total_employees"
      expr: COUNT(1)
      comment: "Total number of employee records"
    - name: "terminated_employees"
      expr: COUNT(CASE WHEN termination_date IS NOT NULL THEN 1 END)
      comment: "Count of employees who have terminated"
    - name: "avg_tenure_days"
      expr: AVG(CASE WHEN termination_date IS NOT NULL THEN DATEDIFF(termination_date, hire_date) END)
      comment: "Average tenure in days for terminated employees"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_employment_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce movement and lifecycle event metrics including hires, terminations, promotions, and transfers. Used by HR leadership to monitor attrition, internal mobility, and organizational change velocity."
  source: "`vibe_semiconductors_v1`.`workforce`.`employment_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of employment event (Hire, Termination, Promotion, Transfer, Leave) for event-level segmentation."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the employment event (Pending, Approved, Completed) for pipeline tracking."
    - name: "event_reason"
      expr: event_reason
      comment: "Business reason for the employment event, used for root-cause attrition and mobility analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the event, enabling consistent cross-period trend analysis."
    - name: "new_location"
      expr: new_location
      comment: "New location after the event, used for geographic workforce flow analysis."
    - name: "new_organization"
      expr: new_organization
      comment: "New organizational unit after the event, used for internal mobility and org health metrics."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the employment event became effective, used for trend and seasonality analysis."
    - name: "event_date_quarter"
      expr: DATE_TRUNC('QUARTER', event_date)
      comment: "Quarter of the employment event for quarterly workforce movement reporting."
  measures:
    - name: "total_employment_events"
      expr: COUNT(1)
      comment: "Total number of employment events. Baseline measure for workforce movement volume."
    - name: "hire_events"
      expr: COUNT(CASE WHEN event_type = 'Hire' THEN 1 END)
      comment: "Count of hire events. Used to track recruiting throughput and workforce growth rate."
    - name: "termination_events"
      expr: COUNT(CASE WHEN event_type = 'Termination' THEN 1 END)
      comment: "Count of termination events. Primary input to voluntary and involuntary attrition rate calculations."
    - name: "promotion_events"
      expr: COUNT(CASE WHEN event_type = 'Promotion' THEN 1 END)
      comment: "Count of promotion events. Measures internal career progression velocity and talent development effectiveness."
    - name: "transfer_events"
      expr: COUNT(CASE WHEN event_type = 'Transfer' THEN 1 END)
      comment: "Count of transfer events. Indicates internal mobility and organizational agility."
    - name: "total_compensation_change_amount"
      expr: SUM(CAST(compensation_change_amount AS DOUBLE))
      comment: "Total compensation change amount across all employment events. Measures total payroll impact of workforce movements."
    - name: "avg_compensation_change_amount"
      expr: AVG(CAST(compensation_change_amount AS DOUBLE))
      comment: "Average compensation change per employment event. Used to benchmark promotion and merit increase levels."
    - name: "pending_approval_events"
      expr: COUNT(CASE WHEN event_status = 'Pending' THEN 1 END)
      comment: "Count of employment events awaiting approval. Operational metric for HR process cycle time and bottleneck identification."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_export_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Export control compliance metrics for the workforce. Used by legal, compliance, and HR leadership to ensure all employees with access to controlled semiconductor technology have valid authorizations, preventing regulatory violations."
  source: "`vibe_semiconductors_v1`.`workforce`.`export_control`"
  dimensions:
    - name: "export_control_status"
      expr: export_control_status
      comment: "Current export control status of the employee record (Cleared, Pending, Expired, Restricted)."
    - name: "control_status"
      expr: control_status
      comment: "Detailed control status for export compliance workflow tracking."
    - name: "citizenship_country"
      expr: citizenship_country
      comment: "Employee citizenship country for deemed export analysis and license requirement determination."
    - name: "nationality"
      expr: nationality
      comment: "Employee nationality for export control screening and deemed export license assessment."
    - name: "visa_type"
      expr: visa_type
      comment: "Visa type for foreign national employees, critical for deemed export license requirement determination."
    - name: "itar_eligible"
      expr: itar_eligible
      comment: "Whether the employee is ITAR-eligible. Critical for access control to ITAR-controlled semiconductor technology."
    - name: "ear_eligible"
      expr: ear_eligible
      comment: "Whether the employee is EAR-eligible. Required for access to EAR-controlled technology and equipment."
    - name: "deemed_export_flag"
      expr: deemed_export_flag
      comment: "Whether the employee is subject to deemed export rules, requiring a license for technology access."
    - name: "screening_status"
      expr: screening_status
      comment: "Status of the export control screening (Pending, Cleared, Flagged) for compliance pipeline management."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of authorization expiry for proactive renewal planning and compliance risk management."
  measures:
    - name: "total_export_control_records"
      expr: COUNT(1)
      comment: "Total number of export control records. Baseline metric for export control program coverage."
    - name: "itar_eligible_employees"
      expr: COUNT(CASE WHEN itar_eligible = TRUE THEN 1 END)
      comment: "Count of ITAR-eligible employees. Critical for staffing ITAR-controlled semiconductor programs and facilities."
    - name: "ear_eligible_employees"
      expr: COUNT(CASE WHEN ear_eligible = TRUE THEN 1 END)
      comment: "Count of EAR-eligible employees. Required for EAR-controlled technology access planning."
    - name: "deemed_export_employees"
      expr: COUNT(CASE WHEN deemed_export_flag = TRUE THEN 1 END)
      comment: "Count of employees subject to deemed export rules. Measures compliance exposure requiring active license management."
    - name: "license_required_employees"
      expr: COUNT(CASE WHEN license_required_flag = TRUE THEN 1 END)
      comment: "Count of employees requiring an export license. Directly measures compliance workload and regulatory risk."
    - name: "ear_license_required_employees"
      expr: COUNT(CASE WHEN ear_license_required = TRUE THEN 1 END)
      comment: "Count of employees requiring an EAR license. Used for EAR compliance program scope and resource planning."
    - name: "pending_screening_employees"
      expr: COUNT(CASE WHEN screening_status = 'Pending' THEN 1 END)
      comment: "Count of employees with pending export control screening. Operational metric for compliance backlog management."
    - name: "unique_screened_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Count of distinct employees with export control records. Measures export control program coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_fab_operator_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fab operator qualification and certification metrics for production readiness and compliance"
  source: "`vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Status of operator qualification (qualified, pending, expired)"
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification for skill segmentation"
    - name: "qualification_level"
      expr: qualification_level
      comment: "Level of qualification (basic, intermediate, advanced)"
    - name: "process_area"
      expr: process_area
      comment: "Process area for which operator is qualified"
    - name: "equipment_group_code"
      expr: equipment_group_code
      comment: "Equipment group for tool-specific qualification tracking"
    - name: "skill_category"
      expr: skill_category
      comment: "Category of skill for competency mapping"
    - name: "qualification_year"
      expr: YEAR(qualification_date)
      comment: "Year qualification was achieved for trend analysis"
    - name: "recertification_required_flag"
      expr: CASE WHEN recertification_required_flag THEN 'Recertification Required' ELSE 'No Recertification' END
      comment: "Whether recertification is required for compliance tracking"
  measures:
    - name: "total_qualifications"
      expr: COUNT(DISTINCT fab_operator_qualification_id)
      comment: "Total operator qualifications for workforce capability assessment"
    - name: "active_qualification_count"
      expr: COUNT(DISTINCT CASE WHEN qualification_status = 'Active' THEN fab_operator_qualification_id END)
      comment: "Count of active qualifications for current production capacity"
    - name: "expired_qualification_count"
      expr: COUNT(DISTINCT CASE WHEN qualification_status = 'Expired' THEN fab_operator_qualification_id END)
      comment: "Count of expired qualifications for recertification planning"
    - name: "qualification_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN qualification_status = 'Active' THEN fab_operator_qualification_id END) / NULLIF(COUNT(DISTINCT fab_operator_qualification_id), 0), 2)
      comment: "Percentage of qualifications that are active for readiness assessment"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_org_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Organizational unit structure and headcount budget metrics. Used by HR, finance, and executive leadership to monitor organizational design, headcount budget adherence, and cost center efficiency."
  source: "`vibe_semiconductors_v1`.`workforce`.`org_unit`"
  dimensions:
    - name: "org_unit_status"
      expr: org_unit_status
      comment: "Current status of the org unit (Active, Inactive, Restructuring) for organizational health monitoring."
    - name: "org_unit_type"
      expr: org_unit_type
      comment: "Type of org unit (Department, Division, Team, Business Unit) for organizational structure analysis."
    - name: "functional_area"
      expr: functional_area
      comment: "Functional area (Engineering, Operations, Finance, HR) for cross-functional headcount and cost analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the org unit for regional workforce distribution and cost analysis."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Hierarchical level of the org unit for span-of-control and organizational depth analysis."
    - name: "is_cost_center"
      expr: is_cost_center
      comment: "Whether the org unit is a cost center, used for financial reporting and cost allocation."
    - name: "is_global"
      expr: is_global
      comment: "Whether the org unit operates globally, used for international workforce and compliance analysis."
  measures:
    - name: "total_org_units"
      expr: COUNT(1)
      comment: "Total number of organizational units. Baseline metric for organizational complexity and span-of-control analysis."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated across all org units. Primary financial metric for organizational cost management."
    - name: "avg_budget_per_org_unit"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per org unit. Used for budget equity analysis and resource allocation benchmarking."
    - name: "cost_center_org_units"
      expr: COUNT(CASE WHEN is_cost_center = TRUE THEN 1 END)
      comment: "Count of org units designated as cost centers. Used for financial reporting structure and cost allocation planning."
    - name: "global_org_units"
      expr: COUNT(CASE WHEN is_global = TRUE THEN 1 END)
      comment: "Count of globally operating org units. Used for international workforce compliance and governance planning."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_shift_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift scheduling and labor cost metrics for fab operations. Used by operations management to monitor shift coverage, overtime exposure, and labor cost efficiency in 24/7 semiconductor manufacturing environments."
  source: "`vibe_semiconductors_v1`.`workforce`.`shift_schedule`"
  dimensions:
    - name: "shift_schedule_status"
      expr: shift_schedule_status
      comment: "Current status of the shift schedule (Active, Draft, Cancelled) for operational schedule management."
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (Day, Night, Swing, Weekend) for shift-level labor cost and coverage analysis."
    - name: "work_area"
      expr: work_area
      comment: "Work area associated with the shift schedule for area-level staffing coverage analysis."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for shift labor cost attribution and departmental budget tracking."
    - name: "overtime_authorized"
      expr: overtime_authorized
      comment: "Whether overtime is authorized for this schedule, used for overtime cost control and approval compliance."
    - name: "schedule_date_month"
      expr: DATE_TRUNC('MONTH', schedule_date)
      comment: "Month of the schedule date for monthly labor planning and cost trend analysis."
    - name: "rotation_group"
      expr: rotation_group
      comment: "Rotation group for shift rotation analysis and equitable schedule distribution."
  measures:
    - name: "total_shift_schedules"
      expr: COUNT(1)
      comment: "Total number of shift schedule records. Baseline metric for scheduling volume."
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total scheduled hours across all shift records. Primary capacity planning metric for fab operations."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours scheduled. Key metric for overtime cost exposure and staffing adequacy assessment."
    - name: "total_hours_per_week"
      expr: SUM(CAST(hours_per_week AS DOUBLE))
      comment: "Total weekly hours across all scheduled employees. Used for workforce capacity and labor cost planning."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost from shift schedules. Primary financial metric for fab operations labor budget management."
    - name: "avg_labor_cost_per_schedule"
      expr: AVG(CAST(labor_cost AS DOUBLE))
      comment: "Average labor cost per shift schedule record. Used for cost efficiency benchmarking across shifts and areas."
    - name: "overtime_authorized_schedules"
      expr: COUNT(CASE WHEN overtime_authorized = TRUE THEN 1 END)
      comment: "Count of schedules with authorized overtime. Used to monitor overtime approval compliance and cost exposure."
    - name: "unique_scheduled_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Count of distinct employees with shift schedules. Measures active scheduling coverage across the workforce."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_talent_acquisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruiting and hiring metrics for talent pipeline management and time-to-fill analysis"
  source: "`vibe_semiconductors_v1`.`workforce`.`talent_acquisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Status of requisition (open, filled, cancelled)"
    - name: "talent_acquisition_status"
      expr: talent_acquisition_status
      comment: "Detailed acquisition status for pipeline tracking"
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of requisition (new hire, backfill, expansion)"
    - name: "application_stage"
      expr: application_stage
      comment: "Current stage in hiring process for funnel analysis"
    - name: "offer_status"
      expr: offer_status
      comment: "Status of offer (pending, accepted, declined)"
    - name: "source_channel"
      expr: source_channel
      comment: "Recruiting source channel for sourcing effectiveness"
    - name: "priority"
      expr: priority
      comment: "Priority level of requisition for resource allocation"
    - name: "open_year"
      expr: YEAR(open_date)
      comment: "Year requisition was opened for trend analysis"
    - name: "open_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month requisition was opened for monthly hiring reporting"
  measures:
    - name: "total_requisitions"
      expr: COUNT(DISTINCT talent_acquisition_id)
      comment: "Total requisitions for hiring volume tracking"
    - name: "open_requisition_count"
      expr: COUNT(DISTINCT CASE WHEN requisition_status = 'Open' THEN talent_acquisition_id END)
      comment: "Count of open requisitions for current hiring pipeline"
    - name: "filled_requisition_count"
      expr: COUNT(DISTINCT CASE WHEN requisition_status = 'Filled' THEN talent_acquisition_id END)
      comment: "Count of filled requisitions for hiring success measurement"
    - name: "offer_accepted_count"
      expr: COUNT(DISTINCT CASE WHEN offer_accepted_flag THEN talent_acquisition_id END)
      comment: "Count of accepted offers for offer acceptance rate calculation"
    - name: "offer_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN offer_accepted_flag THEN talent_acquisition_id END) / NULLIF(COUNT(DISTINCT CASE WHEN offer_extended_flag THEN talent_acquisition_id END), 0), 2)
      comment: "Offer acceptance rate for recruiting effectiveness evaluation"
    - name: "avg_time_to_fill_days"
      expr: AVG(DATEDIFF(close_date, open_date))
      comment: "Average days to fill requisition for hiring efficiency measurement"
    - name: "total_offer_amount"
      expr: SUM(CAST(offer_amount AS DOUBLE))
      comment: "Total offer amounts for hiring budget tracking"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor hours and productivity metrics for capacity planning and cost allocation"
  source: "`vibe_semiconductors_v1`.`workforce`.`time_entry`"
  dimensions:
    - name: "entry_type"
      expr: entry_type
      comment: "Type of time entry (regular, overtime, absence)"
    - name: "time_entry_type"
      expr: time_entry_type
      comment: "Classification of time entry for labor reporting"
    - name: "labor_category"
      expr: labor_category
      comment: "Labor category for cost allocation"
    - name: "cost_center"
      expr: cost_center
      comment: "Cost center for financial allocation"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of time entry for payroll processing"
    - name: "work_year"
      expr: YEAR(work_date)
      comment: "Year of work for trend analysis"
    - name: "work_month"
      expr: DATE_TRUNC('MONTH', work_date)
      comment: "Month of work for monthly labor reporting"
    - name: "is_billable_flag"
      expr: CASE WHEN is_billable THEN 'Billable' ELSE 'Non-Billable' END
      comment: "Whether time is billable to customer for revenue recognition"
    - name: "shift_code"
      expr: shift_code
      comment: "Shift identifier for shift differential analysis"
  measures:
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total labor hours for capacity utilization analysis"
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours for baseline capacity planning"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours for cost control and fatigue risk management"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_amount AS DOUBLE))
      comment: "Total labor cost for financial planning and project costing"
    - name: "avg_hours_per_entry"
      expr: AVG(CAST(hours_worked AS DOUBLE))
      comment: "Average hours per time entry for productivity benchmarking"
    - name: "overtime_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(hours_worked AS DOUBLE)), 0), 2)
      comment: "Percentage of total hours that are overtime for labor efficiency monitoring"
    - name: "total_time_entries"
      expr: COUNT(DISTINCT time_entry_id)
      comment: "Count of time entries for data quality and compliance auditing"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce qualification and certification coverage metrics. Used by HR, operations, and compliance leadership to ensure employees hold required qualifications for regulated semiconductor manufacturing and export-controlled programs."
  source: "`vibe_semiconductors_v1`.`workforce`.`workforce_qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current status of the qualification (Active, Expired, Suspended, Pending) for compliance gap analysis."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (Certification, License, Internal, Regulatory) for program-level coverage analysis."
    - name: "workforce_qualification_status"
      expr: workforce_qualification_status
      comment: "Operational status of the workforce qualification record for active qualification tracking."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification held (ISO, OSHA, EAR, ITAR, Process-Specific) for regulatory compliance mapping."
    - name: "proficiency_level"
      expr: proficiency_level
      comment: "Proficiency level achieved (Beginner, Intermediate, Advanced, Expert) for skills gap analysis."
    - name: "regulatory_mandate_flag"
      expr: regulatory_mandate_flag
      comment: "Whether the qualification is mandated by a regulatory body, used to prioritize compliance remediation."
    - name: "recertification_required"
      expr: recertification_required
      comment: "Whether recertification is required, used to forecast future qualification renewal workload."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of qualification expiry for proactive renewal planning and compliance risk management."
    - name: "qualification_date_month"
      expr: DATE_TRUNC('MONTH', qualification_date)
      comment: "Month the qualification was granted for qualification attainment trend analysis."
  measures:
    - name: "total_qualifications"
      expr: COUNT(1)
      comment: "Total number of workforce qualification records. Baseline metric for qualification program coverage."
    - name: "active_qualifications"
      expr: COUNT(CASE WHEN qualification_status = 'Active' THEN 1 END)
      comment: "Count of currently active qualifications. Primary metric for workforce compliance readiness."
    - name: "expired_qualifications"
      expr: COUNT(CASE WHEN qualification_status = 'Expired' THEN 1 END)
      comment: "Count of expired qualifications. Critical compliance risk metric requiring immediate remediation action."
    - name: "regulatory_mandated_qualifications"
      expr: COUNT(CASE WHEN regulatory_mandate_flag = TRUE THEN 1 END)
      comment: "Count of regulatory-mandated qualifications. Used to scope compliance audit exposure and remediation priority."
    - name: "qualifications_requiring_renewal"
      expr: COUNT(CASE WHEN recertification_required = TRUE THEN 1 END)
      comment: "Count of qualifications requiring recertification. Used for training capacity planning and compliance scheduling."
    - name: "unique_qualified_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Count of distinct employees holding at least one qualification. Measures qualification program reach."
    - name: "unique_qualification_types"
      expr: COUNT(DISTINCT qualification_type)
      comment: "Count of distinct qualification types in the workforce. Measures breadth of competency coverage."
    - name: "compliance_flagged_qualifications"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Count of qualifications with a compliance flag raised. Immediate action metric for compliance officers."
$$;
