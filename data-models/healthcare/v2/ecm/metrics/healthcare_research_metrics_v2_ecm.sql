-- Metric views for domain: research | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 14:53:25

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical research study portfolio KPIs: enrollment attainment, study status mix, regulatory profile. Steers research portfolio investment and enrollment risk management."
  source: "`vibe_healthcare_v1`.`research`.`research_study`"
  dimensions:
    - name: "study_status"
      expr: study_status
      comment: "Lifecycle status of the study (active, completed, terminated, etc.)."
    - name: "study_type"
      expr: study_type
      comment: "Type of study (interventional, observational, etc.)."
    - name: "phase"
      expr: phase
      comment: "Clinical trial phase (I, II, III, IV)."
    - name: "sponsor_type"
      expr: sponsor_type
      comment: "Type of sponsor (industry, federal, investigator-initiated)."
    - name: "funding_source"
      expr: funding_source
      comment: "Primary funding source category for the study."
    - name: "blinding_type"
      expr: blinding_type
      comment: "Blinding design of the study."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Study start month for enrollment cohort trend analysis."
  measures:
    - name: "Study Count"
      expr: COUNT(1)
      comment: "Total number of research studies in scope; portfolio size indicator."
    - name: "Distinct Sponsors"
      expr: COUNT(DISTINCT sponsor_name)
      comment: "Number of distinct sponsors funding studies; diversification of funding base."
    - name: "Total Target Enrollment"
      expr: SUM(CAST(target_enrollment AS DOUBLE))
      comment: "Sum of planned target enrollment across studies; capacity planning input."
    - name: "Total Actual Enrollment"
      expr: SUM(CAST(actual_enrollment AS DOUBLE))
      comment: "Sum of actual enrollment achieved across studies; enrollment performance."
    - name: "Avg Target Enrollment"
      expr: AVG(CAST(target_enrollment AS DOUBLE))
      comment: "Average planned enrollment per study; sizing benchmark."
    - name: "FDA Regulated Drug Study Count"
      expr: COUNT(CASE WHEN fda_regulated_drug_flag = TRUE THEN 1 END)
      comment: "Number of FDA-regulated drug studies; regulatory oversight burden."
    - name: "Part 11 Compliant Study Count"
      expr: COUNT(CASE WHEN cfr_part_11_compliant_flag = TRUE THEN 1 END)
      comment: "Studies compliant with 21 CFR Part 11; compliance posture."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_subject_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subject enrollment operational KPIs: enrollment volume, eligibility, withdrawals, and safety flags. Drives recruitment performance and retention monitoring."
  source: "`vibe_healthcare_v1`.`research`.`subject_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status of the subject."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source/channel through which the subject was recruited."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment for recruitment trend analysis."
    - name: "withdrawal_reason"
      expr: withdrawal_reason
      comment: "Reason for subject withdrawal; retention insight."
  measures:
    - name: "Enrollment Count"
      expr: COUNT(1)
      comment: "Total subject enrollments; recruitment volume."
    - name: "Distinct Enrolled Subjects"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients enrolled; true recruited population."
    - name: "Eligibility Confirmed Count"
      expr: COUNT(CASE WHEN eligibility_confirmed_flag = TRUE THEN 1 END)
      comment: "Enrollments with confirmed eligibility; screening quality."
    - name: "Withdrawn Count"
      expr: COUNT(CASE WHEN withdrawal_date IS NOT NULL THEN 1 END)
      comment: "Number of withdrawn subjects; attrition tracking."
    - name: "Withdrawal Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN withdrawal_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of enrollments that withdrew; retention risk KPI."
    - name: "Serious Adverse Event Count"
      expr: COUNT(CASE WHEN serious_adverse_event_flag = TRUE THEN 1 END)
      comment: "Enrollments flagged with a serious adverse event; safety signal."
    - name: "Protocol Deviation Count"
      expr: COUNT(CASE WHEN protocol_deviation_flag = TRUE THEN 1 END)
      comment: "Enrollments with a protocol deviation; compliance risk."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_adverse_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adverse event safety KPIs: seriousness, expedited reporting timeliness, and outcomes. Central to patient safety governance and regulatory reporting compliance."
  source: "`vibe_healthcare_v1`.`research`.`adverse_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Category/type of the adverse event."
    - name: "event_status"
      expr: event_status
      comment: "Processing/resolution status of the event."
    - name: "severity_grade"
      expr: severity_grade
      comment: "CTCAE-style severity grade of the event."
    - name: "causality_assessment"
      expr: causality_assessment
      comment: "Assessed causality relationship to study product."
    - name: "outcome"
      expr: outcome
      comment: "Clinical outcome of the adverse event."
    - name: "report_month"
      expr: DATE_TRUNC('MONTH', report_date)
      comment: "Month the event was reported; trend monitoring."
  measures:
    - name: "Adverse Event Count"
      expr: COUNT(1)
      comment: "Total adverse events; overall safety burden."
    - name: "Serious Event Count"
      expr: COUNT(CASE WHEN seriousness_flag = TRUE THEN 1 END)
      comment: "Number of serious adverse events; primary safety escalation metric."
    - name: "Serious Event Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN seriousness_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of events classified serious; safety risk KPI."
    - name: "Expedited Report Count"
      expr: COUNT(CASE WHEN expedited_reporting_flag = TRUE THEN 1 END)
      comment: "Events requiring expedited regulatory reporting."
    - name: "IRB Reportable Count"
      expr: COUNT(CASE WHEN irb_reportable_flag = TRUE THEN 1 END)
      comment: "Events reportable to the IRB; oversight workload."
    - name: "Follow Up Required Count"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END)
      comment: "Events with open follow-up obligations."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_protocol_deviation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Protocol deviation KPIs: severity mix, reportability, and CAPA closure. Steers GCP compliance and site quality oversight."
  source: "`vibe_healthcare_v1`.`research`.`protocol_deviation`"
  dimensions:
    - name: "deviation_category"
      expr: deviation_category
      comment: "Category of the protocol deviation."
    - name: "deviation_severity"
      expr: deviation_severity
      comment: "Severity classification of the deviation."
    - name: "deviation_status"
      expr: deviation_status
      comment: "Current status of the deviation record."
    - name: "deviation_month"
      expr: DATE_TRUNC('MONTH', deviation_date)
      comment: "Month of the deviation; trend tracking."
  measures:
    - name: "Deviation Count"
      expr: COUNT(1)
      comment: "Total protocol deviations; compliance workload."
    - name: "FDA Reportable Count"
      expr: COUNT(CASE WHEN fda_reportable_flag = TRUE THEN 1 END)
      comment: "Deviations reportable to the FDA; regulatory exposure."
    - name: "IRB Reportable Count"
      expr: COUNT(CASE WHEN irb_reportable_flag = TRUE THEN 1 END)
      comment: "Deviations reportable to the IRB."
    - name: "Closed Deviation Count"
      expr: COUNT(CASE WHEN closure_date IS NOT NULL THEN 1 END)
      comment: "Deviations with a closure date; resolution progress."
    - name: "Closure Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN closure_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of deviations closed; CAPA effectiveness KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_study_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Study site performance KPIs: enrollment attainment, monitoring quality, and data query burden. Drives site selection and risk-based monitoring decisions."
  source: "`vibe_healthcare_v1`.`research`.`study_site`"
  dimensions:
    - name: "site_status"
      expr: site_status
      comment: "Operational status of the study site."
    - name: "site_risk_rating"
      expr: site_risk_rating
      comment: "Assigned risk rating for the site."
    - name: "regulatory_binder_status"
      expr: regulatory_binder_status
      comment: "Completeness status of the site regulatory binder."
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_date)
      comment: "Site activation month for startup timeline analysis."
  measures:
    - name: "Site Count"
      expr: COUNT(1)
      comment: "Total number of study sites; network footprint."
    - name: "Total Actual Enrollment"
      expr: SUM(CAST(actual_enrollment_count AS DOUBLE))
      comment: "Total subjects enrolled across sites; recruitment output."
    - name: "Avg Enrollment Rate Per Month"
      expr: AVG(CAST(enrollment_rate_per_month AS DOUBLE))
      comment: "Average monthly enrollment rate across sites; recruitment velocity KPI."
    - name: "Avg Site Performance Score"
      expr: AVG(CAST(site_performance_score AS DOUBLE))
      comment: "Average site performance score; overall quality benchmark."
    - name: "Total Open Data Queries"
      expr: SUM(CAST(open_data_query_count AS DOUBLE))
      comment: "Total open data queries across sites; data-cleaning backlog."
    - name: "CAPA Required Site Count"
      expr: COUNT(CASE WHEN corrective_action_plan_required_flag = TRUE THEN 1 END)
      comment: "Sites requiring corrective action plans; quality escalation."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_study_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Study budget financial KPIs: total and per-patient budget, overhead recovery, and coverage analysis coverage. Steers research financial sustainability."
  source: "`vibe_healthcare_v1`.`research`.`study_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget."
    - name: "budget_type"
      expr: budget_type
      comment: "Type/classification of the budget."
    - name: "payment_schedule_type"
      expr: payment_schedule_type
      comment: "Payment schedule structure for the budget."
    - name: "budget_effective_month"
      expr: DATE_TRUNC('MONTH', budget_effective_date)
      comment: "Effective month of the budget for period analysis."
  measures:
    - name: "Budget Count"
      expr: COUNT(1)
      comment: "Number of study budgets in scope."
    - name: "Total Budget Amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Sum of total budget amounts; portfolio funding size."
    - name: "Total Overhead Amount"
      expr: SUM(CAST(overhead_amount AS DOUBLE))
      comment: "Sum of overhead/indirect recovery; institutional revenue driver."
    - name: "Avg Per Patient Budget"
      expr: AVG(CAST(per_patient_budget_amount AS DOUBLE))
      comment: "Average per-patient budget; negotiation benchmark."
    - name: "Avg Overhead Rate Pct"
      expr: AVG(CAST(overhead_rate_percentage AS DOUBLE))
      comment: "Average overhead rate percentage; indirect cost recovery KPI."
    - name: "Total Research Only Cost"
      expr: SUM(CAST(research_only_cost_amount AS DOUBLE))
      comment: "Sum of research-only costs; sponsor-billable exposure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_grant_expenditure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant expenditure KPIs: spend by category, cost-sharing, and allowability. Drives grant compliance and burn-rate monitoring."
  source: "`vibe_healthcare_v1`.`research`.`grant_expenditure`"
  dimensions:
    - name: "expense_category"
      expr: expense_category
      comment: "Category of the grant expenditure."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the expenditure."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the expenditure."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of the transaction for burn-rate trends."
  measures:
    - name: "Expenditure Count"
      expr: COUNT(1)
      comment: "Number of expenditure transactions."
    - name: "Total Expenditure Amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Sum of expenditure amounts; grant burn tracking."
    - name: "Total Cost Share Amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Sum of committed cost-share; institutional contribution."
    - name: "Avg Effort Percentage"
      expr: AVG(CAST(effort_percentage AS DOUBLE))
      comment: "Average committed effort percentage; personnel allocation KPI."
    - name: "Unallowable Expenditure Count"
      expr: COUNT(CASE WHEN allowable_flag = FALSE THEN 1 END)
      comment: "Expenditures flagged unallowable; audit risk."
    - name: "Audit Flagged Count"
      expr: COUNT(CASE WHEN audit_flag = TRUE THEN 1 END)
      comment: "Expenditures flagged for audit; compliance exposure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_grant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research grant portfolio KPIs: award value, indirect cost recovery, and remaining balance. Steers sponsored-programs financial performance."
  source: "`vibe_healthcare_v1`.`research`.`research_grant`"
  dimensions:
    - name: "grant_status"
      expr: grant_status
      comment: "Current status of the grant."
    - name: "grant_type"
      expr: grant_type
      comment: "Type of grant award."
    - name: "funding_agency"
      expr: funding_agency
      comment: "Funding agency providing the grant."
    - name: "project_start_month"
      expr: DATE_TRUNC('MONTH', project_start_date)
      comment: "Project start month for award trend analysis."
  measures:
    - name: "Grant Count"
      expr: COUNT(1)
      comment: "Number of grants in the portfolio."
    - name: "Total Award Amount"
      expr: SUM(CAST(award_amount AS DOUBLE))
      comment: "Sum of award amounts; total funding secured."
    - name: "Total Direct Costs"
      expr: SUM(CAST(direct_costs AS DOUBLE))
      comment: "Sum of direct costs across grants."
    - name: "Total Indirect Costs"
      expr: SUM(CAST(indirect_costs AS DOUBLE))
      comment: "Sum of indirect/F&A costs; institutional revenue."
    - name: "Total Remaining Balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Sum of remaining balances; unspent funds at risk."
    - name: "Avg F&A Rate"
      expr: AVG(CAST(fa_rate AS DOUBLE))
      comment: "Average facilities & administrative rate; recovery efficiency KPI."
    - name: "Clinical Trial Grant Count"
      expr: COUNT(CASE WHEN clinical_trial_flag = TRUE THEN 1 END)
      comment: "Grants supporting clinical trials."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_monitoring_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site monitoring visit KPIs: findings burden, SDV coverage, and CAPA follow-up. Drives risk-based monitoring and data integrity oversight."
  source: "`vibe_healthcare_v1`.`research`.`monitoring_visit`"
  dimensions:
    - name: "visit_type"
      expr: visit_type
      comment: "Type of monitoring visit."
    - name: "visit_status"
      expr: visit_status
      comment: "Status of the monitoring visit."
    - name: "monitor_type"
      expr: monitor_type
      comment: "Type of monitor conducting the visit."
    - name: "visit_month"
      expr: DATE_TRUNC('MONTH', visit_date)
      comment: "Month of the monitoring visit."
  measures:
    - name: "Monitoring Visit Count"
      expr: COUNT(1)
      comment: "Number of monitoring visits conducted."
    - name: "Total Major Findings"
      expr: SUM(CAST(major_findings_count AS DOUBLE))
      comment: "Sum of major findings; site quality risk."
    - name: "Total Minor Findings"
      expr: SUM(CAST(minor_findings_count AS DOUBLE))
      comment: "Sum of minor findings across visits."
    - name: "Avg SDV Percentage"
      expr: AVG(CAST(sdv_percentage AS DOUBLE))
      comment: "Average source data verification coverage; data integrity KPI."
    - name: "CAPA Required Visit Count"
      expr: COUNT(CASE WHEN corrective_action_plan_required_flag = TRUE THEN 1 END)
      comment: "Visits requiring corrective action plans."
    - name: "Follow Up Required Count"
      expr: COUNT(CASE WHEN follow_up_visit_required_flag = TRUE THEN 1 END)
      comment: "Visits triggering a follow-up visit; escalation workload."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_study_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Protocol study visit KPIs: visit compliance, window adherence, and data completeness. Drives protocol adherence and data-lock readiness."
  source: "`vibe_healthcare_v1`.`research`.`study_visit`"
  dimensions:
    - name: "visit_status"
      expr: visit_status
      comment: "Status of the study visit."
    - name: "visit_type"
      expr: visit_type
      comment: "Type of study visit."
    - name: "visit_window_status"
      expr: visit_window_status
      comment: "Whether the visit fell within its protocol window."
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Scheduled month of the visit."
  measures:
    - name: "Study Visit Count"
      expr: COUNT(1)
      comment: "Total study visits; protocol activity volume."
    - name: "Avg Compliance Percentage"
      expr: AVG(CAST(compliance_percentage AS DOUBLE))
      comment: "Average visit compliance percentage; protocol adherence KPI."
    - name: "Data Complete Visit Count"
      expr: COUNT(CASE WHEN data_entry_complete_flag = TRUE THEN 1 END)
      comment: "Visits with complete data entry; data-lock readiness."
    - name: "SDV Verified Count"
      expr: COUNT(CASE WHEN source_data_verified_flag = TRUE THEN 1 END)
      comment: "Visits with source data verified."
    - name: "Protocol Deviation Visit Count"
      expr: COUNT(CASE WHEN protocol_deviation_flag = TRUE THEN 1 END)
      comment: "Visits with a protocol deviation; compliance risk."
    - name: "Missed Assessment Total"
      expr: SUM(CAST(assessments_missed_count AS DOUBLE))
      comment: "Total missed assessments; data completeness gap."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_ip_dispensation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Investigational product dispensation KPIs: quantities dispensed/returned, accountability, and compliance. Drives drug accountability and supply oversight."
  source: "`vibe_healthcare_v1`.`research`.`ip_dispensation`"
  dimensions:
    - name: "accountability_status"
      expr: accountability_status
      comment: "Drug accountability status of the dispensation."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the dispensation."
    - name: "blinding_status"
      expr: blinding_status
      comment: "Blinding status at dispensation."
    - name: "dispensation_month"
      expr: DATE_TRUNC('MONTH', dispensation_date)
      comment: "Month of dispensation."
  measures:
    - name: "Dispensation Count"
      expr: COUNT(1)
      comment: "Number of dispensation events."
    - name: "Total Quantity Dispensed"
      expr: SUM(CAST(quantity_dispensed AS DOUBLE))
      comment: "Total investigational product dispensed; supply consumption."
    - name: "Total Quantity Returned"
      expr: SUM(CAST(quantity_returned AS DOUBLE))
      comment: "Total product returned; accountability reconciliation."
    - name: "Total Missed Doses"
      expr: SUM(CAST(missed_doses AS DOUBLE))
      comment: "Total missed doses; adherence risk KPI."
    - name: "Distinct Subjects Dispensed"
      expr: COUNT(DISTINCT subject_enrollment_id)
      comment: "Distinct subjects receiving product; reach."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_irb_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IRB/regulatory submission KPIs: submission volume, outcomes, and action-required backlog. Drives regulatory affairs throughput and turnaround."
  source: "`vibe_healthcare_v1`.`research`.`irb_submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of IRB submission."
    - name: "review_type"
      expr: review_type
      comment: "Type of IRB review conducted."
    - name: "risk_level"
      expr: risk_level
      comment: "Assessed risk level of the submission."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of submission for throughput trend."
  measures:
    - name: "Submission Count"
      expr: COUNT(1)
      comment: "Number of IRB submissions; regulatory workload."
    - name: "Action Required Count"
      expr: COUNT(CASE WHEN action_required_flag = TRUE THEN 1 END)
      comment: "Submissions with pending required actions; backlog."
    - name: "Approved Count"
      expr: COUNT(CASE WHEN approval_date IS NOT NULL THEN 1 END)
      comment: "Submissions with a recorded approval date."
    - name: "Approval Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of submissions approved; regulatory success KPI."
    - name: "Vulnerable Population Count"
      expr: COUNT(CASE WHEN vulnerable_population_flag = TRUE THEN 1 END)
      comment: "Submissions involving vulnerable populations; heightened oversight."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_informed_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Informed consent KPIs: consent completion, HIPAA authorization, and interpreter/LAR use. Drives consent compliance and equity monitoring."
  source: "`vibe_healthcare_v1`.`research`.`informed_consent`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Status of the informed consent."
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent obtained."
    - name: "consent_method"
      expr: consent_method
      comment: "Method used to obtain consent."
    - name: "language_code"
      expr: language_code
      comment: "Language in which consent was obtained; equity dimension."
    - name: "consent_month"
      expr: DATE_TRUNC('MONTH', consent_date)
      comment: "Month consent was obtained."
  measures:
    - name: "Consent Count"
      expr: COUNT(1)
      comment: "Number of informed consents recorded."
    - name: "HIPAA Authorized Count"
      expr: COUNT(CASE WHEN hipaa_authorization_included = TRUE THEN 1 END)
      comment: "Consents including HIPAA authorization; compliance completeness."
    - name: "Interpreter Used Count"
      expr: COUNT(CASE WHEN interpreter_used_flag = TRUE THEN 1 END)
      comment: "Consents requiring an interpreter; language access KPI."
    - name: "LAR Consent Count"
      expr: COUNT(CASE WHEN lar_consent_indicator = TRUE THEN 1 END)
      comment: "Consents obtained via legally authorized representative."
    - name: "Withdrawn Consent Count"
      expr: COUNT(CASE WHEN withdrawal_date IS NOT NULL THEN 1 END)
      comment: "Consents subsequently withdrawn; retention insight."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_coverage_analysis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medicare Coverage Analysis KPIs: routine cost coverage determinations and investigational flags. Drives research billing compliance risk."
  source: "`vibe_healthcare_v1`.`research`.`coverage_analysis`"
  dimensions:
    - name: "analysis_status"
      expr: analysis_status
      comment: "Status of the coverage analysis."
    - name: "payer_type"
      expr: payer_type
      comment: "Payer type covered by the analysis."
    - name: "medicare_coverage_determination"
      expr: medicare_coverage_determination
      comment: "Medicare coverage determination outcome."
    - name: "analysis_month"
      expr: DATE_TRUNC('MONTH', analysis_date)
      comment: "Month the analysis was performed."
  measures:
    - name: "Coverage Analysis Count"
      expr: COUNT(1)
      comment: "Number of coverage analyses completed."
    - name: "Routine Cost Coverage Count"
      expr: COUNT(CASE WHEN routine_cost_coverage_flag = TRUE THEN 1 END)
      comment: "Analyses confirming routine cost coverage; billing eligibility."
    - name: "Investigational Drug Count"
      expr: COUNT(CASE WHEN investigational_drug_flag = TRUE THEN 1 END)
      comment: "Analyses involving investigational drugs; billing exclusion risk."
    - name: "Off Label Use Count"
      expr: COUNT(CASE WHEN off_label_use_flag = TRUE THEN 1 END)
      comment: "Analyses involving off-label use; compliance flag."
    - name: "CTA Flagged Count"
      expr: COUNT(CASE WHEN clinical_trial_agreement_flag = TRUE THEN 1 END)
      comment: "Analyses tied to a clinical trial agreement."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_billing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and compliance metrics for research‑related billing activities"
  source: "`vibe_healthcare_v1`.`research`.`billing_event`"
  dimensions:
    - name: "billing_status"
      expr: billing_status
      comment: "Current status of the billing event (e.g., Submitted, Approved)"
  measures:
    - name: "billing_event_count"
      expr: COUNT(1)
      comment: "Total number of billing events captured"
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Aggregate charge amount across all billing events"
    - name: "average_charge_amount"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge amount per billing event"
    - name: "compliant_billing_events"
      expr: SUM(CASE WHEN compliance_flag THEN 1 ELSE 0 END)
      comment: "Number of billing events flagged as compliance‑checked"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_deidentified_dataset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data governance metrics for de‑identified research datasets"
  source: "`vibe_healthcare_v1`.`research`.`deidentified_dataset`"
  dimensions:
    - name: "dataset_type"
      expr: dataset_type
      comment: "Logical classification of the dataset (e.g., Clinical, Genomic)"
  measures:
    - name: "dataset_count"
      expr: COUNT(1)
      comment: "Total number of de‑identified datasets created"
    - name: "total_dataset_size_mb"
      expr: SUM(CAST(dataset_size_mb AS DOUBLE))
      comment: "Cumulative size of all datasets in megabytes"
    - name: "average_dataset_size_mb"
      expr: AVG(CAST(dataset_size_mb AS DOUBLE))
      comment: "Average size per dataset"
    - name: "cfr_part_11_compliant_datasets"
      expr: SUM(CASE WHEN cfr_part_11_compliant_flag THEN 1 ELSE 0 END)
      comment: "Count of datasets that are CFR Part 11 compliant"
$$;