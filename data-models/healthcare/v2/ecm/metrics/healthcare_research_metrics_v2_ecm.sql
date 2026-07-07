-- Metric views for domain: research | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 07:21:53

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_subject_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subject enrollment KPIs for clinical trial operations: enrollment volume, screen-to-enrollment yield, adverse event burden, protocol deviation and withdrawal rates that steer study feasibility and site management decisions."
  source: "`vibe_healthcare_v1`.`research`.`subject_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment lifecycle status (screened, enrolled, withdrawn, completed) used to segment funnel analysis."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Channel by which the subject was recruited, used to evaluate recruitment strategy effectiveness."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment for trending enrollment velocity over time."
    - name: "eligibility_confirmed_flag"
      expr: eligibility_confirmed_flag
      comment: "Whether eligibility was confirmed, used to assess screening quality."
  measures:
    - name: "Enrolled Subject Count"
      expr: COUNT(1)
      comment: "Total number of subject enrollment records; the core recruitment volume KPI leadership tracks against enrollment targets."
    - name: "Distinct Enrolled Patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients enrolled across studies; informs unique-participant reach and cross-study burden."
    - name: "Subjects With Adverse Event"
      expr: SUM(CASE WHEN adverse_event_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of subjects flagged with an adverse event; drives safety monitoring and DSMB escalation."
    - name: "Adverse Event Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN adverse_event_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of enrolled subjects with an adverse event; a key safety signal for trial risk review."
    - name: "Protocol Deviation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN protocol_deviation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of subjects with a protocol deviation; indicates site compliance and data integrity risk."
    - name: "Withdrawal Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN withdrawal_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of subjects who withdrew; retention KPI signaling protocol burden or safety concerns."
    - name: "Serious Adverse Event Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN serious_adverse_event_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of subjects with a serious adverse event; drives expedited safety reporting and stopping-rule review."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_adverse_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adverse event surveillance KPIs: seriousness, expedited reporting compliance, IRB reportability and resolution to steer patient-safety governance and regulatory reporting."
  source: "`vibe_healthcare_v1`.`research`.`adverse_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of adverse event for categorizing the safety profile."
    - name: "severity_grade"
      expr: severity_grade
      comment: "Clinical severity grade of the event used to prioritize review."
    - name: "causality_assessment"
      expr: causality_assessment
      comment: "Assessed relationship of the event to the study intervention."
    - name: "adverse_event_status"
      expr: adverse_event_status
      comment: "Current status of the adverse event record for open/closed tracking."
    - name: "onset_month"
      expr: DATE_TRUNC('MONTH', onset_date)
      comment: "Month of event onset for temporal safety trending."
  measures:
    - name: "Adverse Event Count"
      expr: COUNT(1)
      comment: "Total adverse events reported; the base safety volume KPI for study oversight."
    - name: "Serious Event Count"
      expr: SUM(CASE WHEN seriousness_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of serious adverse events; central to safety escalation and stopping decisions."
    - name: "Serious Event Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN seriousness_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of events classified serious; a headline safety indicator for governance committees."
    - name: "Expedited Reporting Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN expedited_reporting_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of events requiring expedited reporting; monitors regulatory timeliness obligations."
    - name: "IRB Reportable Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN irb_reportable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of events reportable to the IRB; ensures compliance oversight coverage."
    - name: "Follow Up Required Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of events needing follow-up; sizes the open safety workload for coordinators."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_study_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site performance KPIs: enrollment achievement, deviation and adverse-event burden, data-query load and risk rating used to steer multi-site trial management and site remediation."
  source: "`vibe_healthcare_v1`.`research`.`study_site`"
  dimensions:
    - name: "site_status"
      expr: site_status
      comment: "Operational status of the study site (active, closed) for portfolio segmentation."
    - name: "site_risk_rating"
      expr: site_risk_rating
      comment: "Assigned risk tier of the site used to prioritize monitoring resources."
    - name: "regulatory_binder_status"
      expr: regulatory_binder_status
      comment: "Completeness status of the site regulatory binder for compliance readiness."
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_date)
      comment: "Month the site was activated for startup timeline analysis."
  measures:
    - name: "Site Count"
      expr: COUNT(1)
      comment: "Total number of study sites; base footprint KPI for study operations."
    - name: "Avg Enrollment Rate Per Month"
      expr: ROUND(AVG(CAST(enrollment_rate_per_month AS DOUBLE)), 2)
      comment: "Average monthly enrollment rate across sites; measures recruitment productivity to steer site investment."
    - name: "Avg Site Performance Score"
      expr: ROUND(AVG(CAST(site_performance_score AS DOUBLE)), 2)
      comment: "Mean composite performance score; a leadership-facing site-quality indicator."
    - name: "High Risk Site Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN site_risk_rating = 'High' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of sites rated high risk; drives monitoring resource allocation."
    - name: "Sites Requiring CAPA Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_plan_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of sites requiring a corrective action plan; a compliance-remediation KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_study_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Study financial KPIs: budget totals, spend, per-patient economics and burn rate used to steer research financial planning and sponsor negotiations."
  source: "`vibe_healthcare_v1`.`research`.`study_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Approval/lifecycle status of the budget for financial pipeline segmentation."
    - name: "budget_version"
      expr: budget_version
      comment: "Budget version identifier for tracking negotiation iterations."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', budget_approval_date)
      comment: "Month the budget was approved for finance trending."
  measures:
    - name: "Total Approved Amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Sum of approved study budget; core research funding commitment KPI."
    - name: "Total Spent Amount"
      expr: SUM(CAST(spent_amount AS DOUBLE))
      comment: "Sum of spend to date across budgets; the financial burn KPI for portfolio oversight."
    - name: "Avg Per Patient Amount"
      expr: ROUND(AVG(CAST(per_patient_amount AS DOUBLE)), 2)
      comment: "Average per-patient reimbursement; drives feasibility and sponsor negotiation decisions."
    - name: "Total Startup Cost Amount"
      expr: SUM(CAST(startup_cost_amount AS DOUBLE))
      comment: "Sum of one-time startup costs; informs go/no-go decisions for new studies."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_grant_expenditure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant spend KPIs: expenditure totals, cost-share, direct vs indirect allowability and audit exposure used to steer sponsored-programs financial compliance."
  source: "`vibe_healthcare_v1`.`research`.`grant_expenditure`"
  dimensions:
    - name: "expense_category"
      expr: expense_category
      comment: "Category of grant expense for cost-composition analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the transaction for annual budget reporting."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the expenditure for pipeline monitoring."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of the transaction for spend trending."
  measures:
    - name: "Total Expenditure Amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Sum of grant expenditures; the primary spend KPI for grant financial management."
    - name: "Total Cost Share Amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Sum of institutional cost-share; tracks matching obligations against awards."
    - name: "Avg Effort Percentage"
      expr: ROUND(AVG(CAST(effort_percentage AS DOUBLE)), 2)
      comment: "Average committed effort percentage; supports effort certification compliance."
    - name: "Unallowable Cost Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN allowable_flag = FALSE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of expenditures flagged unallowable; a direct audit-risk indicator for compliance."
    - name: "Audit Flagged Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN audit_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of expenditures flagged for audit; sizes financial-review exposure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_protocol_deviation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Protocol deviation KPIs: volume, severity mix and IRB reportability used to steer study quality and compliance interventions."
  source: "`vibe_healthcare_v1`.`research`.`protocol_deviation`"
  dimensions:
    - name: "deviation_type"
      expr: deviation_type
      comment: "Category of protocol deviation for root-cause segmentation."
    - name: "deviation_severity"
      expr: deviation_severity
      comment: "Severity classification of the deviation to prioritize remediation."
    - name: "protocol_deviation_status"
      expr: protocol_deviation_status
      comment: "Resolution status of the deviation for open workload tracking."
    - name: "deviation_month"
      expr: DATE_TRUNC('MONTH', deviation_date)
      comment: "Month the deviation occurred for quality trending."
  measures:
    - name: "Deviation Count"
      expr: COUNT(1)
      comment: "Total protocol deviations; base study-quality volume KPI."
    - name: "IRB Reportable Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN irb_reportable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of deviations reportable to the IRB; compliance-escalation KPI."
    - name: "Major Deviation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN deviation_severity = 'Major' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of deviations classified major; signals significant protocol-adherence risk."
    - name: "Distinct Affected Subjects"
      expr: COUNT(DISTINCT subject_enrollment_id)
      comment: "Distinct subjects affected by deviations; sizes patient-level quality impact."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_ip_dispensation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Investigational product dispensation KPIs: quantities dispensed and returned, compliance and accountability used to steer IP supply and drug-accountability governance."
  source: "`vibe_healthcare_v1`.`research`.`ip_dispensation`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "IP accountability compliance status for the dispensation."
    - name: "accountability_status"
      expr: accountability_status
      comment: "Accountability reconciliation status of dispensed product."
    - name: "blinding_status"
      expr: blinding_status
      comment: "Blinding state of the dispensed product for integrity tracking."
    - name: "dispensation_month"
      expr: DATE_TRUNC('MONTH', dispensation_date)
      comment: "Month of dispensation for supply trending."
  measures:
    - name: "Dispensation Count"
      expr: COUNT(1)
      comment: "Total dispensation events; base IP supply-activity KPI."
    - name: "Total Quantity Dispensed"
      expr: SUM(CAST(quantity_dispensed AS DOUBLE))
      comment: "Sum of IP quantity dispensed; central to inventory and supply planning."
    - name: "Total Quantity Returned"
      expr: SUM(CAST(quantity_returned AS DOUBLE))
      comment: "Sum of IP quantity returned; supports drug-accountability reconciliation."
    - name: "Non Compliant Dispensation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of dispensations flagged non-compliant; an IP-governance risk KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_informed_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Informed consent KPIs: consent completeness, HIPAA authorization, LAR/interpreter use and re-consent used to steer human-subjects protection compliance."
  source: "`vibe_healthcare_v1`.`research`.`informed_consent`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Status of the informed consent record for compliance monitoring."
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent obtained for segmentation."
    - name: "consent_method"
      expr: consent_method
      comment: "Method used to obtain consent (in-person, electronic)."
    - name: "consent_month"
      expr: DATE_TRUNC('MONTH', consent_date)
      comment: "Month consent was obtained for consenting-activity trending."
  measures:
    - name: "Consent Count"
      expr: COUNT(1)
      comment: "Total informed consent records; base human-subjects activity KPI."
    - name: "HIPAA Authorization Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN hipaa_authorization_included = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of consents including HIPAA authorization; a privacy-compliance KPI."
    - name: "LAR Consent Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN lar_consent_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent obtained via legally authorized representative; flags vulnerable-population burden."
    - name: "Interpreter Used Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN interpreter_used_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of consents using an interpreter; supports language-access equity monitoring."
    - name: "Withdrawal Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN withdrawal_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of consents subsequently withdrawn; a retention/consent-integrity KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_study_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Study visit execution KPIs: protocol compliance, missed assessments, source-data verification and open queries used to steer data quality and site monitoring."
  source: "`vibe_healthcare_v1`.`research`.`study_visit`"
  dimensions:
    - name: "visit_status"
      expr: visit_status
      comment: "Status of the study visit for completion tracking."
    - name: "visit_type"
      expr: visit_type
      comment: "Type of protocol visit for scheduling analysis."
    - name: "visit_window_status"
      expr: visit_window_status
      comment: "Whether the visit fell within the protocol window; adherence indicator."
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Scheduled month of the visit for activity trending."
  measures:
    - name: "Study Visit Count"
      expr: COUNT(1)
      comment: "Total study visits; base operational-activity KPI."
    - name: "Avg Compliance Percentage"
      expr: ROUND(AVG(CAST(compliance_percentage AS DOUBLE)), 2)
      comment: "Average protocol compliance percent per visit; a headline data-quality KPI."
    - name: "Source Data Verified Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN source_data_verified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of visits with source-data verification complete; monitors monitoring throughput."
    - name: "Protocol Deviation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN protocol_deviation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of visits with a protocol deviation; site-quality indicator."
    - name: "Data Entry Complete Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN data_entry_complete_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of visits with data entry complete; measures data-timeliness at sites."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_biospecimen`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Biospecimen management KPIs: collection volume, consent-for-future-use, deviation and disposition used to steer biobank operations and consent governance."
  source: "`vibe_healthcare_v1`.`research`.`biospecimen`"
  dimensions:
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of biospecimen for inventory segmentation."
    - name: "specimen_status"
      expr: specimen_status
      comment: "Lifecycle status of the specimen for availability tracking."
    - name: "deidentification_status"
      expr: deidentification_status
      comment: "De-identification state of the specimen for privacy governance."
    - name: "collection_month"
      expr: DATE_TRUNC('MONTH', collection_date)
      comment: "Month of collection for biobank activity trending."
  measures:
    - name: "Biospecimen Count"
      expr: COUNT(1)
      comment: "Total biospecimens; base biobank inventory KPI."
    - name: "Total Collection Volume"
      expr: SUM(CAST(collection_volume AS DOUBLE))
      comment: "Sum of collected specimen volume; supports biobank capacity planning."
    - name: "Consent For Future Use Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_for_future_use = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of specimens with future-use consent; determines reusable-research asset base."
    - name: "Protocol Deviation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN protocol_deviation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of specimens with a collection/handling deviation; a quality-risk KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_irb_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IRB submission KPIs: submission volume, approval outcomes, action-required and risk level used to steer regulatory throughput and compliance timelines."
  source: "`vibe_healthcare_v1`.`research`.`irb_submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of IRB submission for workload segmentation."
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission for pipeline monitoring."
    - name: "review_type"
      expr: review_type
      comment: "Level of IRB review (full board, expedited, exempt)."
    - name: "risk_level"
      expr: risk_level
      comment: "Assessed risk level of the study submission."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of submission for regulatory activity trending."
  measures:
    - name: "Submission Count"
      expr: COUNT(1)
      comment: "Total IRB submissions; base regulatory-workload KPI."
    - name: "Action Required Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN action_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of submissions requiring further action; sizes regulatory rework burden."
    - name: "Vulnerable Population Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN vulnerable_population_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of submissions involving vulnerable populations; heightens ethics oversight."
    - name: "Distinct Studies Submitted"
      expr: COUNT(DISTINCT research_study_id)
      comment: "Distinct studies with IRB submissions; portfolio-coverage KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_investigational_product_training`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IP training compliance KPIs: completion, competency pass rates, certification currency and recertification due used to steer GCP/IP handling readiness across study teams."
  source: "`vibe_healthcare_v1`.`research`.`investigational_product_training`"
  dimensions:
    - name: "training_type"
      expr: training_type
      comment: "Type of IP training delivered for compliance segmentation."
    - name: "training_status"
      expr: training_status
      comment: "Current status of the training record."
    - name: "completion_status"
      expr: completion_status
      comment: "Completion state of the training for readiness tracking."
    - name: "training_month"
      expr: DATE_TRUNC('MONTH', training_date)
      comment: "Month of training delivery for compliance trending."
  measures:
    - name: "Training Record Count"
      expr: COUNT(1)
      comment: "Total IP training records; base training-activity KPI."
    - name: "Completion Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN completion_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of training completed; a readiness-compliance KPI for study staff."
    - name: "Competency Pass Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN competency_assessment_passed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent passing the competency assessment; measures effective staff qualification."
    - name: "Avg Assessment Score"
      expr: ROUND(AVG(CAST(assessment_score AS DOUBLE)), 2)
      comment: "Average assessment score; quality indicator for training effectiveness."
    - name: "GCP Certified Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN gcp_certified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent GCP-certified; a regulatory-readiness KPI for the study team."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_coverage_analysis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical research billing coverage-analysis KPIs: analysis throughput, sponsor coverage determinations used to steer research-billing compliance (Medicare CTP) and risk."
  source: "`vibe_healthcare_v1`.`research`.`coverage_analysis`"
  dimensions:
    - name: "analysis_status"
      expr: analysis_status
      comment: "Status of the coverage analysis for pipeline monitoring."
    - name: "coverage_determination"
      expr: coverage_determination
      comment: "Determination outcome (routine care vs research) for billing routing."
    - name: "service_type"
      expr: service_type
      comment: "Service type analyzed for coverage segmentation."
    - name: "analysis_month"
      expr: DATE_TRUNC('MONTH', analysis_date)
      comment: "Month the analysis was performed for throughput trending."
  measures:
    - name: "Coverage Analysis Count"
      expr: COUNT(1)
      comment: "Total coverage analyses; base research-billing compliance workload KPI."
    - name: "Sponsor Coverage Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sponsor_coverage_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of items designated sponsor-covered; drives research-billing revenue segregation."
    - name: "Distinct Studies Analyzed"
      expr: COUNT(DISTINCT research_study_id)
      comment: "Distinct studies with completed coverage analysis; compliance-coverage KPI."
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
    - name: "All Records"
      expr: "1"
  measures:
    - name: "dataset_count"
      expr: COUNT(1)
      comment: "Total number of de‑identified datasets created"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`research_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Portfolio‑level overview of research studies for executive steering"
  source: "`vibe_healthcare_v1`.`research`.`research_study`"
  dimensions:
    - name: "phase"
      expr: phase
      comment: "Clinical trial phase (e.g., Phase I, II, III)"
  measures:
    - name: "study_count"
      expr: COUNT(1)
      comment: "Total number of research studies in the portfolio"
    - name: "active_studies"
      expr: SUM(CASE WHEN study_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of studies currently active"
$$;