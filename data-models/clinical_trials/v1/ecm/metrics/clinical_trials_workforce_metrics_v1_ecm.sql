-- Metric views for domain: workforce | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-06 23:23:25

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`workforce_study_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key workforce allocation metrics for clinical study assignments, measuring utilization, billing rates, and assignment effectiveness across studies and therapeutic areas."
  source: "`clinical_trials_ecm`.`workforce`.`study_assignment`"
  dimensions:
    - name: "assigned_role"
      expr: assigned_role
      comment: "The clinical role assigned to the employee on the study (e.g., CRA, CRD, PM)."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the study assignment (e.g., Active, Completed, On Hold)."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the assigned study for portfolio analysis."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the assignment for regional workforce planning."
    - name: "phase"
      expr: phase
      comment: "Clinical trial phase (I, II, III, IV) for phase-based resource analysis."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (e.g., full-time, part-time, contract)."
    - name: "country_code"
      expr: country_code
      comment: "Country where the assignment is based."
    - name: "gcp_certified"
      expr: gcp_certified
      comment: "Whether the assigned employee holds current GCP certification."
    - name: "start_year_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month when the assignment started for trend analysis."
  measures:
    - name: "total_active_assignments"
      expr: COUNT(CASE WHEN assignment_status = 'Active' THEN 1 END)
      comment: "Total number of currently active study assignments indicating current workforce deployment."
    - name: "avg_fte_allocation_pct"
      expr: AVG(CAST(fte_allocation_pct AS DOUBLE))
      comment: "Average FTE allocation percentage across assignments, indicating workforce utilization intensity."
    - name: "total_fte_deployed"
      expr: SUM(CAST(fte_allocation_pct AS DOUBLE)) / 100.0
      comment: "Total FTE equivalents deployed across all assignments (sum of allocation percentages / 100)."
    - name: "avg_billing_rate"
      expr: AVG(CAST(billing_rate AS DOUBLE))
      comment: "Average billing rate across assignments for revenue and margin analysis."
    - name: "total_billable_value"
      expr: SUM(CAST(billing_rate AS DOUBLE))
      comment: "Sum of billing rates across assignments as a proxy for total billable workforce value."
    - name: "fte_planning_variance"
      expr: AVG(CAST(fte_allocation_pct AS DOUBLE) - CAST(planned_fte_allocation_pct AS DOUBLE))
      comment: "Average variance between actual and planned FTE allocation, indicating resource planning accuracy."
    - name: "gcp_certified_assignment_count"
      expr: COUNT(CASE WHEN gcp_certified = true THEN 1 END)
      comment: "Number of assignments staffed with GCP-certified personnel for compliance monitoring."
    - name: "distinct_studies_staffed"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with workforce assignments for portfolio coverage analysis."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`workforce_payroll_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce compensation and labor cost metrics for clinical trials operations, tracking total compensation, overtime, and cost allocation."
  source: "`clinical_trials_ecm`.`workforce`.`payroll_record`"
  dimensions:
    - name: "department"
      expr: department
      comment: "Department for cost allocation and departmental budget analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (full-time, part-time, contractor) for labor mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Payment currency for multi-currency cost reporting."
    - name: "work_country_code"
      expr: work_country_code
      comment: "Country where work is performed for geographic cost analysis."
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay frequency (monthly, bi-weekly) for normalization."
    - name: "payroll_run_type"
      expr: payroll_run_type
      comment: "Type of payroll run (regular, off-cycle, bonus) for cost categorization."
    - name: "payment_period_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Payment month for time-series labor cost trending."
    - name: "is_reversal"
      expr: is_reversal
      comment: "Whether the record is a reversal for data quality filtering."
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay AS DOUBLE))
      comment: "Total gross compensation paid, the primary labor cost metric for budgeting and forecasting."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay AS DOUBLE))
      comment: "Total net pay disbursed to employees after all deductions."
    - name: "total_overtime_amount"
      expr: SUM(CAST(overtime_amount AS DOUBLE))
      comment: "Total overtime costs indicating workload pressure and potential burnout risk."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked across the workforce for capacity planning."
    - name: "avg_gross_pay_per_record"
      expr: AVG(CAST(gross_pay AS DOUBLE))
      comment: "Average gross pay per payroll record for compensation benchmarking."
    - name: "total_employer_burden"
      expr: SUM(CAST(employer_benefits_contribution AS DOUBLE) + CAST(employer_retirement_contribution AS DOUBLE) + CAST(employer_tax_contribution AS DOUBLE))
      comment: "Total employer-side burden (benefits + retirement + taxes) for fully-loaded cost analysis."
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus payments for incentive compensation tracking."
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total hours worked for productivity and utilization analysis."
    - name: "distinct_employees_paid"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees receiving pay in the period for headcount validation."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`workforce_training_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training compliance and effectiveness metrics for clinical trials workforce, measuring completion rates, overdue training, and assessment performance critical for regulatory readiness."
  source: "`clinical_trials_ecm`.`workforce`.`training_record`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Training assignment status (Completed, In Progress, Overdue, Waived) for compliance tracking."
    - name: "training_category"
      expr: training_category
      comment: "Category of training (GCP, SOP, Protocol, System) for compliance reporting."
    - name: "training_method"
      expr: training_method
      comment: "Delivery method (eLearning, classroom, on-the-job) for training effectiveness analysis."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Assessment outcome for training quality measurement."
    - name: "department"
      expr: department
      comment: "Department of the trainee for departmental compliance dashboards."
    - name: "job_role"
      expr: job_role
      comment: "Job role of the trainee for role-based compliance analysis."
    - name: "recurrence_required"
      expr: recurrence_required
      comment: "Whether the training requires periodic recertification."
    - name: "completion_month"
      expr: DATE_TRUNC('month', completion_date)
      comment: "Month of training completion for trend analysis."
  measures:
    - name: "total_training_completions"
      expr: COUNT(CASE WHEN assignment_status = 'Completed' THEN 1 END)
      comment: "Total number of completed training assignments indicating workforce readiness."
    - name: "total_overdue_trainings"
      expr: COUNT(CASE WHEN assignment_status = 'Overdue' THEN 1 END)
      comment: "Number of overdue training assignments representing compliance risk exposure."
    - name: "total_training_assignments"
      expr: COUNT(1)
      comment: "Total training assignments for compliance rate denominator calculation."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across training completions for quality of learning measurement."
    - name: "training_pass_count"
      expr: COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END)
      comment: "Number of training assessments passed for first-time pass rate calculation."
    - name: "distinct_employees_trained"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees with training records for coverage analysis."
    - name: "waiver_count"
      expr: COUNT(CASE WHEN waiver_reason IS NOT NULL THEN 1 END)
      comment: "Number of training waivers granted, indicating potential compliance gaps requiring oversight."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`workforce_resource_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce planning and capacity metrics for clinical trials, measuring FTE demand vs supply, labor cost forecasting, and resource gaps critical for study delivery."
  source: "`clinical_trials_ecm`.`workforce`.`workforce_resource_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the resource plan (Draft, Approved, Active, Closed) for planning lifecycle tracking."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of resource plan for categorization (study-level, program-level, functional)."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area for TA-based resource demand analysis."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region for regional capacity planning."
    - name: "study_phase"
      expr: study_phase
      comment: "Clinical trial phase for phase-based resourcing patterns."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual workforce budget planning."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for quarterly resource reviews."
    - name: "hiring_urgency"
      expr: hiring_urgency
      comment: "Urgency level for open positions to prioritize recruitment efforts."
    - name: "country_code"
      expr: country_code
      comment: "Country for country-level workforce planning."
  measures:
    - name: "total_planned_fte_demand"
      expr: SUM(CAST(planned_fte_demand AS DOUBLE))
      comment: "Total planned FTE demand across all resource plans for capacity forecasting."
    - name: "total_actual_fte"
      expr: SUM(CAST(actual_fte AS DOUBLE))
      comment: "Total actual FTE deployed against plans for supply-demand gap analysis."
    - name: "total_fte_gap"
      expr: SUM(CAST(fte_gap AS DOUBLE))
      comment: "Total FTE gap (demand minus supply) indicating understaffing risk to study delivery."
    - name: "total_planned_labor_cost"
      expr: SUM(CAST(planned_labor_cost AS DOUBLE))
      comment: "Total planned labor cost for workforce budget forecasting."
    - name: "total_actual_labor_cost"
      expr: SUM(CAST(actual_labor_cost AS DOUBLE))
      comment: "Total actual labor cost incurred for budget variance analysis."
    - name: "avg_capacity_utilization_target"
      expr: AVG(CAST(capacity_utilization_target_pct AS DOUBLE))
      comment: "Average target utilization percentage for workforce efficiency benchmarking."
    - name: "total_contractor_fte_planned"
      expr: SUM(CAST(contractor_fte_planned AS DOUBLE))
      comment: "Total contractor FTE planned indicating reliance on external workforce."
    - name: "total_internal_fte_planned"
      expr: SUM(CAST(internal_fte_planned AS DOUBLE))
      comment: "Total internal FTE planned for insource vs outsource workforce mix analysis."
    - name: "distinct_studies_planned"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with resource plans for portfolio planning coverage."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`workforce_capa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce corrective and preventive action metrics for clinical trials quality management, measuring non-compliance events, resolution timeliness, and inspection readiness."
  source: "`clinical_trials_ecm`.`workforce`.`workforce_capa`"
  dimensions:
    - name: "capa_status"
      expr: capa_status
      comment: "Current CAPA status (Open, In Progress, Closed, Overdue) for quality pipeline tracking."
    - name: "capa_type"
      expr: capa_type
      comment: "Type of CAPA (Corrective, Preventive, Combined) for categorization."
    - name: "severity"
      expr: severity
      comment: "Severity level of the non-compliance for risk prioritization."
    - name: "priority"
      expr: priority
      comment: "Priority level for CAPA resolution urgency."
    - name: "non_compliance_category"
      expr: non_compliance_category
      comment: "Category of non-compliance (training gap, documentation, protocol deviation) for root cause trending."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for systemic issue identification."
    - name: "inspection_ready"
      expr: inspection_ready
      comment: "Whether the CAPA documentation is inspection-ready for regulatory preparedness."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this is a recurring issue indicating systemic problems."
    - name: "initiation_month"
      expr: DATE_TRUNC('month', initiation_date)
      comment: "Month of CAPA initiation for trend analysis."
  measures:
    - name: "total_open_capas"
      expr: COUNT(CASE WHEN capa_status = 'Open' OR capa_status = 'In Progress' THEN 1 END)
      comment: "Total open/in-progress CAPAs representing current quality risk exposure."
    - name: "total_capas_initiated"
      expr: COUNT(1)
      comment: "Total CAPAs initiated for quality event volume trending."
    - name: "closed_capas"
      expr: COUNT(CASE WHEN capa_status = 'Closed' THEN 1 END)
      comment: "Number of closed CAPAs for resolution throughput measurement."
    - name: "recurring_capas"
      expr: COUNT(CASE WHEN recurrence_flag = true THEN 1 END)
      comment: "Number of recurring CAPAs indicating systemic quality failures requiring escalation."
    - name: "inspection_ready_count"
      expr: COUNT(CASE WHEN inspection_ready = true THEN 1 END)
      comment: "Number of CAPAs marked inspection-ready for regulatory audit preparedness assessment."
    - name: "high_severity_capas"
      expr: COUNT(CASE WHEN severity = 'Critical' OR severity = 'High' THEN 1 END)
      comment: "Number of high/critical severity CAPAs requiring immediate leadership attention."
    - name: "distinct_employees_with_capas"
      expr: COUNT(DISTINCT primary_workforce_employee_id)
      comment: "Number of distinct employees with CAPAs for workforce quality risk distribution analysis."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`workforce_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Professional certification and credential management metrics for clinical trials workforce, tracking certification currency, compliance costs, and regulatory readiness."
  source: "`clinical_trials_ecm`.`workforce`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (GCP, therapeutic, regulatory) for compliance categorization."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (Active, Expired, Pending Renewal)."
    - name: "issuing_body"
      expr: issuing_body
      comment: "Organization that issued the certification for credentialing source analysis."
    - name: "specialty_area"
      expr: specialty_area
      comment: "Clinical specialty area of the certification."
    - name: "is_gcp_required"
      expr: is_gcp_required
      comment: "Whether the certification is GCP-required for regulatory compliance filtering."
    - name: "is_regulatory_required"
      expr: is_regulatory_required
      comment: "Whether the certification is required by regulatory authorities."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Renewal status for proactive credential management."
    - name: "issuing_body_country"
      expr: issuing_body_country
      comment: "Country of the issuing body for geographic credential analysis."
  measures:
    - name: "total_active_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN 1 END)
      comment: "Total active certifications indicating current workforce qualification level."
    - name: "total_expired_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Expired' THEN 1 END)
      comment: "Total expired certifications representing compliance gaps requiring immediate action."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of certifications for training budget management."
    - name: "avg_exam_score"
      expr: AVG(CAST(exam_score AS DOUBLE))
      comment: "Average exam score across certifications for workforce competency benchmarking."
    - name: "total_ce_credits_earned"
      expr: SUM(CAST(ce_credits_earned AS DOUBLE))
      comment: "Total continuing education credits earned for professional development tracking."
    - name: "ce_credits_gap"
      expr: SUM(CAST(ce_credits_required AS DOUBLE) - CAST(ce_credits_earned AS DOUBLE))
      comment: "Total gap between required and earned CE credits indicating renewal risk."
    - name: "distinct_certified_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees holding certifications for workforce qualification coverage."
    - name: "regulatory_required_certifications"
      expr: COUNT(CASE WHEN is_regulatory_required = true THEN 1 END)
      comment: "Count of regulatory-required certifications for compliance reporting."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`workforce_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Position management and workforce planning metrics for clinical trials, tracking vacancy rates, time-to-fill, and organizational capacity."
  source: "`clinical_trials_ecm`.`workforce`.`position`"
  dimensions:
    - name: "incumbency_status"
      expr: incumbency_status
      comment: "Whether the position is filled, vacant, or frozen for capacity analysis."
    - name: "clinical_role_category"
      expr: clinical_role_category
      comment: "Clinical role category (monitoring, data management, regulatory) for functional planning."
    - name: "job_family"
      expr: job_family
      comment: "Job family for workforce composition analysis."
    - name: "job_level"
      expr: job_level
      comment: "Job level for seniority distribution analysis."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region for regional staffing analysis."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area focus of the position."
    - name: "position_type"
      expr: position_type
      comment: "Position type (permanent, contract, temporary) for workforce mix analysis."
    - name: "is_gcp_required"
      expr: is_gcp_required
      comment: "Whether the position requires GCP certification."
    - name: "country_code"
      expr: country_code
      comment: "Country where the position is located."
  measures:
    - name: "total_positions"
      expr: COUNT(1)
      comment: "Total number of positions in the organization for headcount planning."
    - name: "vacant_positions"
      expr: COUNT(CASE WHEN incumbency_status = 'Vacant' THEN 1 END)
      comment: "Number of vacant positions indicating hiring demand and potential delivery risk."
    - name: "filled_positions"
      expr: COUNT(CASE WHEN incumbency_status = 'Filled' THEN 1 END)
      comment: "Number of filled positions for current staffing level assessment."
    - name: "frozen_positions"
      expr: COUNT(CASE WHEN incumbency_status = 'Frozen' THEN 1 END)
      comment: "Number of frozen positions indicating budget constraints or organizational changes."
    - name: "total_budgeted_fte"
      expr: SUM(CAST(budgeted_fte AS DOUBLE))
      comment: "Total budgeted FTE across all positions for capacity planning."
    - name: "avg_salary_range_midpoint"
      expr: AVG((CAST(salary_range_min AS DOUBLE) + CAST(salary_range_max AS DOUBLE)) / 2.0)
      comment: "Average salary midpoint across positions for compensation benchmarking."
    - name: "gcp_required_positions"
      expr: COUNT(CASE WHEN is_gcp_required = true THEN 1 END)
      comment: "Number of positions requiring GCP certification for compliance workforce planning."
$$;
