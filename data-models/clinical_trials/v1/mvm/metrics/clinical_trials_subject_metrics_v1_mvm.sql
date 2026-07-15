-- Metric views for domain: subject | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-07 02:29:00

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`subject_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enrollment funnel and population quality metrics tracking subject progression from screening through randomization, including screen failure rates, ITT/PP/safety population flags, and visit compliance. Used by clinical operations and biostatistics to monitor trial health and enrollment velocity."
  source: "`clinical_trials_ecm`.`subject`.`enrollment`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Foreign key to the study — enables slicing all enrollment KPIs by individual clinical trial."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Foreign key to the study site — enables site-level enrollment performance benchmarking."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status of the subject (e.g. Screened, Enrolled, Withdrawn, Completed) — primary funnel dimension."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment (e.g. Standard, Re-screen) — distinguishes first-time vs. repeat screening attempts."
    - name: "arm_id"
      expr: arm_id
      comment: "Treatment arm assignment — enables per-arm enrollment balance monitoring."
    - name: "cohort_code"
      expr: cohort_code
      comment: "Cohort identifier — supports sub-group enrollment tracking in adaptive or multi-cohort trials."
    - name: "screen_failure_reason"
      expr: screen_failure_reason
      comment: "Reason a subject failed screening — identifies dominant eligibility barriers for protocol optimization."
    - name: "withdrawal_reason"
      expr: withdrawal_reason
      comment: "Reason for subject withdrawal — critical for retention analysis and protocol amendment decisions."
    - name: "blinding_status"
      expr: blinding_status
      comment: "Blinding status of the enrollment record — used to segregate unblinded from blinded analyses."
    - name: "stratification_factor_1"
      expr: stratification_factor_1
      comment: "Primary stratification factor used at randomization — enables balance checks across strata."
    - name: "stratification_factor_2"
      expr: stratification_factor_2
      comment: "Secondary stratification factor — supports multi-factor balance analysis."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Calendar month of enrollment — enables enrollment velocity trending over time."
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', screening_date)
      comment: "Calendar month of screening — supports screening funnel trend analysis."
    - name: "source_system"
      expr: source_system
      comment: "Source EDC or CTMS system that originated the enrollment record — useful for data quality audits."
    - name: "icf_version"
      expr: icf_version
      comment: "Informed consent form version signed by the subject — tracks consent version compliance across the trial."
  measures:
    - name: "total_screened_subjects"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Total unique subjects who entered the screening process. Baseline enrollment funnel metric used by clinical operations to track site productivity and trial progress against enrollment targets."
    - name: "total_enrolled_subjects"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'Enrolled' THEN trial_subject_id END)
      comment: "Total unique subjects who achieved enrolled status. Core KPI for trial milestone tracking and site performance dashboards."
    - name: "total_screen_failures"
      expr: COUNT(DISTINCT CASE WHEN screen_failure_reason IS NOT NULL AND screen_failure_reason <> '' THEN trial_subject_id END)
      comment: "Total subjects who failed screening. Drives protocol amendment decisions and eligibility criterion review when failure rates are high."
    - name: "total_withdrawn_subjects"
      expr: COUNT(DISTINCT CASE WHEN withdrawal_date IS NOT NULL THEN trial_subject_id END)
      comment: "Total subjects who withdrew from the trial. Retention KPI that triggers site support interventions and protocol feasibility reviews."
    - name: "total_completed_subjects"
      expr: COUNT(DISTINCT CASE WHEN completion_date IS NOT NULL THEN trial_subject_id END)
      comment: "Total subjects who completed the trial per protocol. Primary endpoint population size metric used in statistical power assessments."
    - name: "itt_population_count"
      expr: COUNT(DISTINCT CASE WHEN itt_flag = TRUE THEN trial_subject_id END)
      comment: "Number of subjects in the Intent-to-Treat (ITT) analysis population. Directly informs primary efficacy analysis feasibility and regulatory submission readiness."
    - name: "pp_population_count"
      expr: COUNT(DISTINCT CASE WHEN pp_flag = TRUE THEN trial_subject_id END)
      comment: "Number of subjects in the Per-Protocol (PP) analysis population. Used by biostatistics to assess sensitivity analysis population size."
    - name: "safety_population_count"
      expr: COUNT(DISTINCT CASE WHEN safety_population_flag = TRUE THEN trial_subject_id END)
      comment: "Number of subjects in the safety analysis population. Critical for safety reporting to regulators and Data Safety Monitoring Boards."
    - name: "randomization_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN randomization_eligible = TRUE THEN trial_subject_id END)
      comment: "Number of subjects confirmed eligible for randomization. Measures the effective yield of the screening process and informs enrollment projections."
    - name: "avg_visit_compliance_pct"
      expr: AVG(CAST(visit_compliance_pct AS DOUBLE))
      comment: "Average visit compliance percentage across enrolled subjects. Operational quality KPI — low compliance triggers site monitoring visits and subject retention interventions."
    - name: "days_screening_to_enrollment_avg"
      expr: AVG(CAST(DATEDIFF(enrollment_date, screening_date) AS DOUBLE))
      comment: "Average number of days from screening to enrollment. Operational efficiency metric — prolonged screening-to-enrollment cycles indicate eligibility or consent process bottlenecks."
    - name: "days_enrollment_to_first_dose_avg"
      expr: AVG(CAST(DATEDIFF(first_dose_date, enrollment_date) AS DOUBLE))
      comment: "Average days from enrollment to first investigational product dose. Measures site readiness and treatment initiation efficiency — a key operational KPI for clinical operations leadership."
    - name: "days_enrollment_to_completion_avg"
      expr: AVG(CAST(DATEDIFF(completion_date, enrollment_date) AS DOUBLE))
      comment: "Average trial duration per subject from enrollment to completion. Informs trial timeline forecasting and resource planning."
    - name: "eligibility_confirmed_count"
      expr: COUNT(DISTINCT CASE WHEN eligibility_confirmed = TRUE THEN trial_subject_id END)
      comment: "Number of subjects with confirmed eligibility. Measures protocol compliance at the eligibility gate — deviations here carry regulatory risk."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`subject_trial_subject`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Master subject-level demographic and lifecycle metrics providing a single source of truth for subject counts, population flags, and protocol compliance indicators across the trial. Used by clinical operations, biostatistics, and regulatory teams."
  source: "`clinical_trials_ecm`.`subject`.`trial_subject`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Clinical trial identifier — primary slicing dimension for all subject-level KPIs."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Study site identifier — enables site-level subject performance benchmarking."
    - name: "arm_id"
      expr: arm_id
      comment: "Treatment arm — supports per-arm subject count and demographic balance analysis."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status of the subject — primary funnel dimension for subject lifecycle tracking."
    - name: "sex"
      expr: sex
      comment: "Biological sex of the subject — required demographic dimension for regulatory submissions and safety analyses."
    - name: "race"
      expr: race
      comment: "Subject race — required by FDA diversity guidance for demographic representation reporting."
    - name: "ethnicity"
      expr: ethnicity
      comment: "Subject ethnicity — required demographic dimension for regulatory diversity reporting."
    - name: "country"
      expr: country
      comment: "Country of the subject — enables geographic distribution analysis for multi-national trials."
    - name: "withdrawal_reason"
      expr: withdrawal_reason
      comment: "Reason for subject withdrawal — identifies retention risk patterns across sites and demographics."
    - name: "screen_failure_reason"
      expr: screen_failure_reason
      comment: "Reason for screen failure — drives eligibility criterion review and protocol amendment decisions."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment — supports enrollment velocity trending."
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', screening_date)
      comment: "Month of screening — supports screening funnel trend analysis."
    - name: "randomization_month"
      expr: DATE_TRUNC('MONTH', randomization_date)
      comment: "Month of randomization — tracks randomization velocity over time."
  measures:
    - name: "total_subjects"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Total unique trial subjects across all statuses. Master headcount KPI used in all trial progress reports and regulatory submissions."
    - name: "itt_subjects"
      expr: COUNT(DISTINCT CASE WHEN itt_flag = TRUE THEN trial_subject_id END)
      comment: "Subjects in the Intent-to-Treat population. Directly determines primary efficacy analysis feasibility — a core regulatory KPI."
    - name: "pp_subjects"
      expr: COUNT(DISTINCT CASE WHEN pp_flag = TRUE THEN trial_subject_id END)
      comment: "Subjects in the Per-Protocol population. Used by biostatistics for sensitivity analyses and regulatory submissions."
    - name: "safety_population_subjects"
      expr: COUNT(DISTINCT CASE WHEN safety_population_flag = TRUE THEN trial_subject_id END)
      comment: "Subjects in the safety analysis population. Critical for DSMB safety reviews and regulatory safety reporting."
    - name: "subjects_with_sae"
      expr: COUNT(DISTINCT CASE WHEN serious_adverse_event_flag = TRUE THEN trial_subject_id END)
      comment: "Number of subjects who experienced at least one serious adverse event. Primary patient safety KPI — triggers DSMB review and regulatory expedited reporting when elevated."
    - name: "subjects_with_protocol_deviation"
      expr: COUNT(DISTINCT CASE WHEN protocol_deviation_flag = TRUE THEN trial_subject_id END)
      comment: "Number of subjects with at least one protocol deviation. Compliance KPI — high rates trigger site audits and potential regulatory action."
    - name: "eligible_subjects"
      expr: COUNT(DISTINCT CASE WHEN eligible_flag = TRUE THEN trial_subject_id END)
      comment: "Subjects confirmed as protocol-eligible. Measures the effective yield of the screening process."
    - name: "randomized_subjects"
      expr: COUNT(DISTINCT CASE WHEN randomization_date IS NOT NULL THEN trial_subject_id END)
      comment: "Subjects who have been randomized. Key milestone metric for trial progress tracking and statistical power monitoring."
    - name: "withdrawn_subjects"
      expr: COUNT(DISTINCT CASE WHEN withdrawal_date IS NOT NULL THEN trial_subject_id END)
      comment: "Subjects who withdrew from the trial. Retention KPI — elevated withdrawal rates trigger protocol and site-level interventions."
    - name: "completed_subjects"
      expr: COUNT(DISTINCT CASE WHEN completion_date IS NOT NULL THEN trial_subject_id END)
      comment: "Subjects who completed the trial. Primary endpoint population completeness metric used in statistical power and regulatory readiness assessments."
    - name: "data_locked_subjects"
      expr: COUNT(DISTINCT CASE WHEN data_lock_flag = TRUE THEN trial_subject_id END)
      comment: "Subjects whose data has been locked. Database lock readiness KPI — tracks progress toward statistical analysis and regulatory submission milestones."
    - name: "avg_days_screening_to_randomization"
      expr: AVG(CAST(DATEDIFF(randomization_date, screening_date) AS DOUBLE))
      comment: "Average days from screening to randomization. Operational efficiency KPI — prolonged cycles indicate eligibility or consent bottlenecks that delay trial timelines."
    - name: "avg_days_first_to_last_dose"
      expr: AVG(CAST(DATEDIFF(last_dose_date, first_dose_date) AS DOUBLE))
      comment: "Average treatment exposure duration per subject. Informs dosing compliance and treatment duration analysis for efficacy and safety assessments."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`subject_disposition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subject disposition metrics tracking trial completion, early termination, and discontinuation patterns. Critical for CONSORT flow reporting, regulatory submissions, and understanding the reasons subjects leave the trial. Used by biostatistics, clinical operations, and regulatory affairs."
  source: "`clinical_trials_ecm`.`subject`.`disposition`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Clinical trial identifier — primary slicing dimension for disposition KPIs."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Study site — enables site-level discontinuation rate benchmarking."
    - name: "arm_id"
      expr: arm_id
      comment: "Treatment arm — enables per-arm discontinuation analysis, critical for safety and tolerability assessments."
    - name: "disposition_status"
      expr: disposition_status
      comment: "Final disposition status of the subject (e.g. Completed, Discontinued, Screen Failed) — primary CONSORT flow dimension."
    - name: "milestone_category"
      expr: milestone_category
      comment: "High-level milestone category (e.g. Screening, Treatment, Follow-up) — supports CONSORT diagram construction."
    - name: "milestone_subcategory"
      expr: milestone_subcategory
      comment: "Detailed milestone subcategory — enables granular disposition reason analysis."
    - name: "coded_reason"
      expr: coded_reason
      comment: "Standardized coded reason for disposition — enables cross-trial discontinuation reason benchmarking."
    - name: "meddra_soc"
      expr: meddra_soc
      comment: "MedDRA System Organ Class for AE-related discontinuations — supports safety signal detection by organ system."
    - name: "meddra_pt"
      expr: meddra_pt
      comment: "MedDRA Preferred Term for AE-related discontinuations — granular safety-driven discontinuation analysis."
    - name: "screen_failure_reason"
      expr: screen_failure_reason
      comment: "Reason for screen failure — identifies dominant eligibility barriers for protocol optimization."
    - name: "disposition_month"
      expr: DATE_TRUNC('MONTH', disposition_date)
      comment: "Month of disposition event — enables temporal trending of discontinuation rates."
    - name: "source_system"
      expr: source_system
      comment: "Source system for the disposition record — supports data quality and reconciliation audits."
  measures:
    - name: "total_disposition_records"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Total unique subjects with a disposition record. Baseline CONSORT flow denominator used in all regulatory submission tables."
    - name: "study_completers"
      expr: COUNT(DISTINCT CASE WHEN study_completion_flag = TRUE THEN trial_subject_id END)
      comment: "Subjects who completed the study per protocol. Primary trial success metric — directly determines whether the trial meets its statistical power requirements."
    - name: "early_terminations"
      expr: COUNT(DISTINCT CASE WHEN early_termination_flag = TRUE THEN trial_subject_id END)
      comment: "Subjects who terminated the trial early. Retention and tolerability KPI — high rates trigger protocol review, DSMB escalation, and potential regulatory action."
    - name: "ae_related_discontinuations"
      expr: COUNT(DISTINCT CASE WHEN ae_related_discontinuation = TRUE THEN trial_subject_id END)
      comment: "Subjects who discontinued due to an adverse event. Critical safety KPI — elevated rates trigger expedited safety reporting and DSMB review."
    - name: "safety_followup_required_count"
      expr: COUNT(DISTINCT CASE WHEN safety_followup_required = TRUE THEN trial_subject_id END)
      comment: "Subjects requiring post-discontinuation safety follow-up. Operational compliance KPI — ensures all safety obligations are tracked and fulfilled per protocol."
    - name: "itt_population_dispositions"
      expr: COUNT(DISTINCT CASE WHEN analysis_population_itt = TRUE THEN trial_subject_id END)
      comment: "Subjects in the ITT population per disposition records. Cross-validates ITT population size for biostatistics and regulatory submissions."
    - name: "pp_population_dispositions"
      expr: COUNT(DISTINCT CASE WHEN analysis_population_pp = TRUE THEN trial_subject_id END)
      comment: "Subjects in the Per-Protocol population per disposition records. Supports sensitivity analysis population validation."
    - name: "safety_population_dispositions"
      expr: COUNT(DISTINCT CASE WHEN analysis_population_safety = TRUE THEN trial_subject_id END)
      comment: "Subjects in the safety population per disposition records. Validates safety population size for regulatory safety reporting."
    - name: "avg_days_to_disposition"
      expr: AVG(CAST(DATEDIFF(disposition_date, last_visit_date) AS DOUBLE))
      comment: "Average days between last visit and formal disposition. Operational efficiency metric — long gaps indicate data entry delays that risk database lock timelines."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`subject_deviation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Protocol deviation metrics tracking compliance quality, regulatory reportability, and corrective action status at the subject and site level. Used by quality assurance, clinical operations, and regulatory affairs to manage GCP compliance and inspection readiness."
  source: "`clinical_trials_ecm`.`subject`.`deviation`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Clinical trial identifier — primary slicing dimension for deviation KPIs."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Study site — enables site-level deviation rate benchmarking and risk-based monitoring prioritization."
    - name: "deviation_category"
      expr: deviation_category
      comment: "High-level category of the deviation (e.g. Eligibility, Consent, Dosing) — identifies systemic compliance gaps."
    - name: "type_code"
      expr: type_code
      comment: "Coded deviation type — enables cross-site and cross-study deviation pattern analysis."
    - name: "deviation_status"
      expr: deviation_status
      comment: "Current resolution status of the deviation (e.g. Open, Closed, Pending) — tracks remediation progress."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the deviation — drives CAPA design and process improvement initiatives."
    - name: "subject_safety_impact"
      expr: subject_safety_impact
      comment: "Assessment of whether the deviation impacted subject safety — critical for regulatory reportability decisions."
    - name: "subject_rights_impact"
      expr: subject_rights_impact
      comment: "Assessment of whether the deviation impacted subject rights — required for IRB/IEC reporting decisions."
    - name: "data_integrity_impact"
      expr: data_integrity_impact
      comment: "Assessment of data integrity impact — informs statistical analysis exclusion decisions."
    - name: "occurrence_month"
      expr: DATE_TRUNC('MONTH', occurrence_date)
      comment: "Month the deviation occurred — enables temporal trending of deviation rates."
    - name: "source_system"
      expr: source_system
      comment: "Source system for the deviation record — supports data quality audits."
  measures:
    - name: "total_deviations"
      expr: COUNT(deviation_id)
      comment: "Total number of protocol deviations recorded. Primary GCP compliance KPI — high counts trigger site audits and regulatory inspection risk escalation."
    - name: "subjects_with_deviations"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of unique subjects with at least one protocol deviation. Subject-level compliance KPI used in CONSORT flow and regulatory submission tables."
    - name: "regulatory_reportable_deviations"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN deviation_id END)
      comment: "Number of deviations requiring regulatory reporting. Critical compliance KPI — missed reportable deviations constitute a GCP violation and inspection finding."
    - name: "irb_iec_reportable_deviations"
      expr: COUNT(CASE WHEN irb_iec_reportable_flag = TRUE THEN deviation_id END)
      comment: "Number of deviations requiring IRB/IEC reporting. Ethics compliance KPI — tracks obligations to ethics committees across all sites."
    - name: "open_deviations"
      expr: COUNT(CASE WHEN deviation_status = 'Open' THEN deviation_id END)
      comment: "Number of currently open (unresolved) deviations. Operational quality KPI — high open counts indicate remediation backlogs that increase inspection risk."
    - name: "deviations_with_capa"
      expr: COUNT(CASE WHEN capa_id IS NOT NULL THEN deviation_id END)
      comment: "Number of deviations with an associated CAPA (Corrective and Preventive Action). Quality management KPI — measures the organization's systematic response to compliance failures."
    - name: "pi_aware_deviations"
      expr: COUNT(CASE WHEN pi_aware_flag = TRUE THEN deviation_id END)
      comment: "Number of deviations where the Principal Investigator has been notified. Site oversight KPI — unaware PIs represent a GCP compliance gap."
    - name: "sponsor_notified_deviations"
      expr: COUNT(CASE WHEN sponsor_notified_flag = TRUE THEN deviation_id END)
      comment: "Number of deviations where the sponsor has been formally notified. Regulatory compliance KPI — tracks sponsor oversight obligations."
    - name: "avg_days_to_deviation_resolution"
      expr: AVG(CAST(DATEDIFF(resolution_date, occurrence_date) AS DOUBLE))
      comment: "Average days from deviation occurrence to resolution. Quality efficiency KPI — prolonged resolution cycles increase regulatory inspection risk and indicate systemic process failures."
    - name: "avg_days_to_pi_awareness"
      expr: AVG(CAST(DATEDIFF(pi_aware_date, occurrence_date) AS DOUBLE))
      comment: "Average days from deviation occurrence to PI awareness. Site oversight timeliness KPI — delays in PI notification are a GCP finding category."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`subject_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subject visit execution and compliance metrics tracking scheduled vs. actual visit adherence, window compliance, and data entry quality. Used by clinical operations and data management to monitor protocol adherence and site performance."
  source: "`clinical_trials_ecm`.`subject`.`subject_visit`"
  dimensions:
    - name: "study_site_id"
      expr: study_site_id
      comment: "Study site — primary dimension for site-level visit compliance benchmarking."
    - name: "enrollment_id"
      expr: enrollment_id
      comment: "Enrollment record — links visits to the subject enrollment context for per-subject compliance analysis."
    - name: "visit_type"
      expr: visit_type
      comment: "Type of visit (e.g. Screening, Treatment, Follow-up, Unscheduled) — enables visit-type-specific compliance analysis."
    - name: "visit_status"
      expr: visit_status
      comment: "Current status of the visit (e.g. Completed, Missed, Pending) — primary visit execution dimension."
    - name: "window_compliance_status"
      expr: window_compliance_status
      comment: "Whether the visit occurred within the protocol-defined visit window — key protocol adherence dimension."
    - name: "data_entry_status"
      expr: data_entry_status
      comment: "Data entry completion status for the visit — tracks EDC data entry backlog."
    - name: "visit_month"
      expr: DATE_TRUNC('MONTH', actual_visit_date)
      comment: "Month of actual visit — enables temporal trending of visit execution rates."
    - name: "epoch_id"
      expr: epoch_id
      comment: "Study epoch (e.g. Screening, Treatment, Follow-up) — enables epoch-level visit compliance analysis."
    - name: "is_scheduled"
      expr: is_scheduled
      comment: "Whether the visit was a scheduled protocol visit — distinguishes planned from unscheduled visits."
    - name: "protocol_deviation_flag"
      expr: protocol_deviation_flag
      comment: "Whether the visit generated a protocol deviation — links visit execution quality to compliance outcomes."
  measures:
    - name: "total_scheduled_visits"
      expr: COUNT(CASE WHEN is_scheduled = TRUE THEN subject_visit_id END)
      comment: "Total number of scheduled protocol visits. Denominator for visit compliance rate calculations — baseline operational metric."
    - name: "completed_visits"
      expr: COUNT(CASE WHEN visit_status = 'Completed' THEN subject_visit_id END)
      comment: "Total visits with completed status. Numerator for visit completion rate — core operational KPI for site performance monitoring."
    - name: "missed_visits"
      expr: COUNT(CASE WHEN visit_status = 'Missed' THEN subject_visit_id END)
      comment: "Total missed visits. Retention and compliance KPI — high missed visit rates indicate subject dropout risk and protocol adherence failures."
    - name: "visits_within_window"
      expr: COUNT(CASE WHEN window_compliance_status = 'In Window' THEN subject_visit_id END)
      comment: "Visits conducted within the protocol-defined visit window. Protocol adherence KPI — out-of-window visits are protocol deviations that affect data quality and regulatory submissions."
    - name: "visits_with_protocol_deviation"
      expr: COUNT(CASE WHEN protocol_deviation_flag = TRUE THEN subject_visit_id END)
      comment: "Visits that generated a protocol deviation. Quality KPI — high rates at specific visit types identify systemic protocol execution failures."
    - name: "unscheduled_visits"
      expr: COUNT(CASE WHEN is_scheduled = FALSE THEN subject_visit_id END)
      comment: "Total unscheduled visits. Safety and tolerability signal — elevated unscheduled visit rates may indicate adverse events or subject health concerns requiring protocol review."
    - name: "avg_days_from_planned_visit"
      expr: AVG(CAST(DATEDIFF(actual_visit_date, planned_visit_date) AS DOUBLE))
      comment: "Average deviation in days between planned and actual visit date. Visit window compliance metric — large average deviations indicate scheduling or subject adherence issues."
    - name: "avg_visit_duration_minutes"
      expr: AVG(CAST(DATEDIFF(actual_visit_end_date, actual_visit_date) AS DOUBLE) * 1440)
      comment: "Average visit duration in minutes (derived from start and end dates). Site capacity planning metric — informs resource allocation and scheduling optimization."
    - name: "subjects_with_missed_visits"
      expr: COUNT(DISTINCT CASE WHEN visit_status = 'Missed' THEN trial_subject_id END)
      comment: "Number of unique subjects with at least one missed visit. Subject-level retention risk KPI — used to prioritize subject outreach and site support interventions."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`subject_demographic`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subject demographic profile metrics supporting regulatory diversity reporting, population balance analysis, and baseline characteristic summaries. Used by biostatistics, regulatory affairs, and clinical operations for FDA diversity guidance compliance and trial population characterization."
  source: "`clinical_trials_ecm`.`subject`.`demographic`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Clinical trial identifier — primary slicing dimension for demographic KPIs."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Study site — enables site-level demographic distribution analysis."
    - name: "arm_id"
      expr: arm_id
      comment: "Treatment arm — enables per-arm demographic balance assessment required for randomization quality review."
    - name: "sex"
      expr: sex
      comment: "Biological sex — required demographic dimension for FDA diversity reporting and safety subgroup analyses."
    - name: "race"
      expr: race
      comment: "Subject race — required by FDA diversity guidance for demographic representation reporting."
    - name: "ethnicity"
      expr: ethnicity
      comment: "Subject ethnicity — required demographic dimension for regulatory diversity reporting."
    - name: "country"
      expr: country
      comment: "Country of the subject — enables geographic demographic distribution analysis."
    - name: "epoch"
      expr: epoch
      comment: "Study epoch at time of demographic assessment — contextualizes baseline measurements."
    - name: "gender_identity"
      expr: gender_identity
      comment: "Subject gender identity — supports inclusive demographic reporting per evolving regulatory guidance."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', informed_consent_date)
      comment: "Month of informed consent — enables temporal demographic enrollment trend analysis."
    - name: "data_entry_status"
      expr: data_entry_status
      comment: "Data entry completion status — used to filter analyses to verified demographic records."
  measures:
    - name: "total_subjects_with_demographics"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Total unique subjects with a demographic record. Baseline population characterization metric — denominator for all demographic distribution analyses."
    - name: "avg_bmi"
      expr: AVG(CAST(bmi AS DOUBLE))
      comment: "Average Body Mass Index across subjects. Baseline characteristic KPI — BMI distribution informs eligibility criterion design and safety subgroup analyses."
    - name: "avg_height_cm"
      expr: AVG(CAST(height_cm AS DOUBLE))
      comment: "Average subject height in centimeters. Baseline anthropometric metric used in pharmacokinetic and dosing analyses."
    - name: "avg_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average subject weight in kilograms. Baseline anthropometric metric — weight-based dosing trials require this for dose calculation validation."
    - name: "max_bmi"
      expr: MAX(CAST(bmi AS DOUBLE))
      comment: "Maximum BMI observed in the study population. Safety boundary metric — extreme BMI values may indicate eligibility criterion violations or outlier subjects requiring review."
    - name: "min_bmi"
      expr: MIN(CAST(bmi AS DOUBLE))
      comment: "Minimum BMI observed in the study population. Safety boundary metric — used alongside max BMI to characterize the full range of the enrolled population."
    - name: "subjects_with_open_queries"
      expr: COUNT(DISTINCT CASE WHEN query_open_flag = TRUE THEN trial_subject_id END)
      comment: "Number of subjects with open data queries on their demographic record. Data quality KPI — unresolved queries block database lock and regulatory submission."
    - name: "avg_days_screening_to_consent"
      expr: AVG(CAST(DATEDIFF(informed_consent_date, reference_start_date) AS DOUBLE))
      comment: "Average days from reference start date to informed consent. Consent process efficiency metric — prolonged consent timelines indicate site training or process gaps."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`subject_randomization_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Randomization quality and balance metrics tracking assignment status, re-randomization rates, and stratification adherence. Used by biostatistics and clinical operations to ensure randomization integrity and detect IRT system issues."
  source: "`clinical_trials_ecm`.`subject`.`randomization_assignment`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Clinical trial identifier — primary slicing dimension for randomization KPIs."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Study site — enables site-level randomization quality monitoring."
    - name: "arm_id"
      expr: arm_id
      comment: "Treatment arm — primary dimension for randomization balance analysis."
    - name: "treatment_arm_id"
      expr: treatment_arm_id
      comment: "Randomization treatment arm — enables comparison of planned vs. actual arm assignments."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the randomization assignment (e.g. Active, Cancelled, Superseded) — tracks assignment validity."
    - name: "blinding_status"
      expr: blinding_status
      comment: "Blinding status of the assignment — critical for maintaining trial integrity in blinded studies."
    - name: "randomization_method"
      expr: randomization_method
      comment: "Method used for randomization (e.g. Block, Minimization) — contextualizes balance analysis."
    - name: "cohort_code"
      expr: cohort_code
      comment: "Cohort identifier — supports multi-cohort randomization balance analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of randomization — enables geographic randomization balance analysis for multi-national trials."
    - name: "randomization_month"
      expr: DATE_TRUNC('MONTH', randomization_date)
      comment: "Month of randomization — enables randomization velocity trending."
    - name: "stratification_factor_3_code"
      expr: stratification_factor_3_code
      comment: "Third stratification factor code — supports multi-factor randomization balance verification."
    - name: "irt_system_name"
      expr: irt_system_name
      comment: "IRT system used for randomization — enables system-level quality monitoring."
  measures:
    - name: "total_randomized_subjects"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Total unique subjects who received a randomization assignment. Primary randomization milestone KPI — directly determines statistical power and regulatory submission readiness."
    - name: "confirmed_randomizations"
      expr: COUNT(CASE WHEN randomization_confirmed_flag = TRUE THEN randomization_assignment_id END)
      comment: "Number of confirmed randomization assignments. Quality KPI — unconfirmed randomizations indicate IRT system or site process failures."
    - name: "re_randomizations"
      expr: COUNT(CASE WHEN re_randomization_flag = TRUE THEN randomization_assignment_id END)
      comment: "Number of re-randomization events. Protocol compliance KPI — unexpected re-randomizations may indicate eligibility or IRT system issues requiring investigation."
    - name: "cancelled_randomizations"
      expr: COUNT(CASE WHEN assignment_status = 'Cancelled' THEN randomization_assignment_id END)
      comment: "Number of cancelled randomization assignments. Quality and compliance KPI — cancellations may indicate protocol deviations or IRT errors."
    - name: "unblinded_subjects"
      expr: COUNT(DISTINCT CASE WHEN unblinding_timestamp IS NOT NULL THEN trial_subject_id END)
      comment: "Number of subjects whose randomization assignment has been unblinded. Trial integrity KPI — unexpected unblinding events require immediate investigation and regulatory notification."
    - name: "avg_days_to_randomization_confirmation"
      expr: AVG(CAST(DATEDIFF(CAST(randomization_timestamp AS DATE), randomization_date) AS DOUBLE))
      comment: "Average days between randomization date and IRT confirmation timestamp. IRT system efficiency metric — delays indicate system integration or site process issues."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`subject_eligibility_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Eligibility assessment quality and waiver metrics tracking screen failure patterns, eligibility criterion compliance, and waiver rates. Used by clinical operations and regulatory affairs to optimize protocol eligibility criteria and manage compliance risk."
  source: "`clinical_trials_ecm`.`subject`.`eligibility_assessment`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Clinical trial identifier — primary slicing dimension for eligibility KPIs."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Study site — enables site-level eligibility assessment quality benchmarking."
    - name: "overall_eligibility_status"
      expr: overall_eligibility_status
      comment: "Overall eligibility determination (e.g. Eligible, Not Eligible, Pending) — primary eligibility funnel dimension."
    - name: "assessment_result"
      expr: assessment_result
      comment: "Result of the individual eligibility criterion assessment — enables criterion-level failure analysis."
    - name: "screen_failure_reason"
      expr: screen_failure_reason
      comment: "Reason for screen failure — identifies dominant eligibility barriers for protocol amendment decisions."
    - name: "waiver_status"
      expr: waiver_status
      comment: "Status of eligibility waiver request (e.g. Approved, Denied, Pending) — tracks protocol flexibility and compliance risk."
    - name: "assessor_role"
      expr: assessor_role
      comment: "Role of the person performing the eligibility assessment — supports quality oversight by assessor type."
    - name: "re_screening_flag"
      expr: re_screening_flag
      comment: "Whether this is a re-screening assessment — distinguishes first-time from repeat eligibility evaluations."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of eligibility assessment — enables temporal trending of screen failure rates."
    - name: "sdv_status"
      expr: sdv_status
      comment: "Source data verification status — tracks data quality and monitoring completion for eligibility records."
  measures:
    - name: "total_eligibility_assessments"
      expr: COUNT(eligibility_assessment_id)
      comment: "Total eligibility assessments performed. Screening activity volume metric — baseline denominator for all eligibility rate calculations."
    - name: "eligible_subjects"
      expr: COUNT(DISTINCT CASE WHEN overall_eligibility_status = 'Eligible' THEN trial_subject_id END)
      comment: "Unique subjects confirmed as eligible. Screening yield metric — directly informs enrollment projections and site feasibility assessments."
    - name: "screen_failures"
      expr: COUNT(DISTINCT CASE WHEN overall_eligibility_status = 'Not Eligible' THEN trial_subject_id END)
      comment: "Unique subjects who failed eligibility screening. Protocol optimization KPI — high screen failure rates trigger eligibility criterion review and potential protocol amendments."
    - name: "waiver_requests"
      expr: COUNT(CASE WHEN waiver_requested = TRUE THEN eligibility_assessment_id END)
      comment: "Number of eligibility waiver requests submitted. Compliance risk KPI — high waiver rates indicate overly restrictive eligibility criteria or site non-compliance."
    - name: "approved_waivers"
      expr: COUNT(CASE WHEN waiver_status = 'Approved' THEN eligibility_assessment_id END)
      comment: "Number of approved eligibility waivers. Regulatory risk KPI — approved waivers represent protocol deviations that must be disclosed in regulatory submissions."
    - name: "re_screening_assessments"
      expr: COUNT(CASE WHEN re_screening_flag = TRUE THEN eligibility_assessment_id END)
      comment: "Number of re-screening eligibility assessments. Enrollment efficiency metric — high re-screening rates indicate initial screening process quality issues."
    - name: "assessments_with_protocol_deviation"
      expr: COUNT(CASE WHEN protocol_deviation_flag = TRUE THEN eligibility_assessment_id END)
      comment: "Eligibility assessments that generated a protocol deviation. Compliance KPI — eligibility deviations carry high regulatory risk and must be tracked for inspection readiness."
    - name: "open_query_assessments"
      expr: COUNT(CASE WHEN query_open_flag = TRUE THEN eligibility_assessment_id END)
      comment: "Eligibility assessments with open data queries. Data quality KPI — unresolved eligibility queries block database lock and may invalidate subject inclusion."
    - name: "avg_days_assessment_to_sdv"
      expr: AVG(CAST(DATEDIFF(sdv_date, assessment_date) AS DOUBLE))
      comment: "Average days from eligibility assessment to source data verification. Monitoring efficiency KPI — prolonged SDV cycles indicate monitoring resource constraints or site access issues."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`subject_concomitant_medication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Concomitant medication usage metrics tracking prohibited medication exposure, AE-related medication patterns, and coding quality. Used by safety, clinical operations, and data management to monitor drug interaction risks and protocol compliance."
  source: "`clinical_trials_ecm`.`subject`.`concomitant_medication`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Clinical trial identifier — primary slicing dimension for concomitant medication KPIs."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Study site — enables site-level concomitant medication pattern analysis."
    - name: "concomitant_medication_category"
      expr: concomitant_medication_category
      comment: "Therapeutic category of the concomitant medication — enables drug class-level exposure analysis."
    - name: "subcategory"
      expr: subcategory
      comment: "Medication subcategory — supports granular drug class analysis."
    - name: "whodb_atc_code"
      expr: whodb_atc_code
      comment: "WHO Drug ATC code — standardized drug classification for cross-study concomitant medication analysis."
    - name: "dose_route"
      expr: dose_route
      comment: "Route of administration — contextualizes drug exposure for pharmacokinetic interaction analysis."
    - name: "dose_form"
      expr: dose_form
      comment: "Dosage form of the concomitant medication — supports formulation-level analysis."
    - name: "ongoing_flag"
      expr: ongoing_flag
      comment: "Whether the concomitant medication is ongoing at data cut — distinguishes current from historical exposures."
    - name: "prohibited_medication_flag"
      expr: prohibited_medication_flag
      comment: "Whether the medication is protocol-prohibited — primary compliance dimension for concomitant medication analysis."
    - name: "ae_related_flag"
      expr: ae_related_flag
      comment: "Whether the medication is related to an adverse event — links concomitant medication to safety outcomes."
    - name: "rescue_medication_flag"
      expr: rescue_medication_flag
      comment: "Whether the medication is a rescue medication — tracks rescue medication usage as a secondary efficacy endpoint proxy."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month concomitant medication was started — enables temporal exposure trend analysis."
  measures:
    - name: "total_concomitant_medication_records"
      expr: COUNT(concomitant_medication_id)
      comment: "Total concomitant medication records. Baseline exposure volume metric — denominator for all concomitant medication rate calculations."
    - name: "subjects_with_concomitant_medications"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Unique subjects with at least one concomitant medication. Population-level exposure metric — high rates may indicate complex patient populations with drug interaction risks."
    - name: "prohibited_medication_exposures"
      expr: COUNT(CASE WHEN prohibited_medication_flag = TRUE THEN concomitant_medication_id END)
      comment: "Number of prohibited medication exposures. Critical protocol compliance KPI — each prohibited medication exposure is a protocol deviation requiring regulatory disclosure."
    - name: "subjects_with_prohibited_medications"
      expr: COUNT(DISTINCT CASE WHEN prohibited_medication_flag = TRUE THEN trial_subject_id END)
      comment: "Unique subjects exposed to prohibited medications. Subject-level compliance KPI — drives per-protocol population exclusion decisions and regulatory reporting."
    - name: "ae_related_medication_records"
      expr: COUNT(CASE WHEN ae_related_flag = TRUE THEN concomitant_medication_id END)
      comment: "Concomitant medications recorded as AE-related. Safety signal metric — high AE-related medication rates indicate treatment tolerability issues."
    - name: "rescue_medication_uses"
      expr: COUNT(CASE WHEN rescue_medication_flag = TRUE THEN concomitant_medication_id END)
      comment: "Number of rescue medication administrations. Secondary efficacy endpoint proxy — elevated rescue medication use may indicate insufficient primary treatment effect."
    - name: "subjects_using_rescue_medication"
      expr: COUNT(DISTINCT CASE WHEN rescue_medication_flag = TRUE THEN trial_subject_id END)
      comment: "Unique subjects who used rescue medication. Efficacy signal KPI — used in sensitivity analyses and as a secondary endpoint in many therapeutic areas."
    - name: "open_query_medication_records"
      expr: COUNT(CASE WHEN query_open_flag = TRUE THEN concomitant_medication_id END)
      comment: "Concomitant medication records with open data queries. Data quality KPI — unresolved queries block database lock and may affect safety analysis completeness."
    - name: "avg_dose"
      expr: AVG(CAST(dose AS DOUBLE))
      comment: "Average dose of concomitant medications. Pharmacological exposure metric — used in drug interaction and safety analyses to characterize exposure levels."
$$;


CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`subject_population_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Analysis population assignment metrics tracking ITT, PP, safety, and sensitivity analysis population composition, exclusion rates, and amendment-driven changes. Used by biostatistics and regulatory affairs to validate analysis populations for regulatory submissions."
  source: "`clinical_trials_ecm`.`subject`.`population_assignment`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Clinical trial identifier — primary slicing dimension for population assignment KPIs."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Study site — enables site-level population assignment quality analysis."
    - name: "arm_id"
      expr: arm_id
      comment: "Treatment arm — enables per-arm population composition analysis."
    - name: "population_code"
      expr: population_code
      comment: "Standardized population code (e.g. ITT, PP, SAF) — primary dimension for population-level KPIs."
    - name: "population_name"
      expr: population_name
      comment: "Human-readable population name — supports business-friendly population analysis."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the population assignment (e.g. Active, Superseded) — tracks assignment validity."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the population assignment — tracks biostatistics sign-off on population definitions."
    - name: "consort_flow_category"
      expr: consort_flow_category
      comment: "CONSORT flow category — enables automated CONSORT diagram generation from population assignment data."
    - name: "amendment_driven_flag"
      expr: amendment_driven_flag
      comment: "Whether the assignment was driven by a protocol amendment — tracks amendment impact on analysis populations."
    - name: "interim_analysis_flag"
      expr: interim_analysis_flag
      comment: "Whether this assignment is for an interim analysis — segregates interim from final analysis populations."
    - name: "sensitivity_analysis_flag"
      expr: sensitivity_analysis_flag
      comment: "Whether this is a sensitivity analysis population — supports sensitivity analysis population tracking."
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', assignment_date)
      comment: "Month of population assignment — enables temporal tracking of population finalization progress."
  measures:
    - name: "total_population_assignments"
      expr: COUNT(population_assignment_id)
      comment: "Total population assignment records. Baseline metric for population definition completeness — denominator for all population assignment rate calculations."
    - name: "included_subjects"
      expr: COUNT(DISTINCT CASE WHEN inclusion_flag = TRUE THEN trial_subject_id END)
      comment: "Unique subjects included in at least one analysis population. Core biostatistics KPI — determines the analyzable population size for regulatory submissions."
    - name: "excluded_subjects"
      expr: COUNT(DISTINCT CASE WHEN exclusion_flag = TRUE THEN trial_subject_id END)
      comment: "Unique subjects excluded from at least one analysis population. Regulatory risk KPI — high exclusion rates may indicate protocol compliance issues or eligibility criterion problems."
    - name: "amendment_driven_assignments"
      expr: COUNT(CASE WHEN amendment_driven_flag = TRUE THEN population_assignment_id END)
      comment: "Population assignments driven by protocol amendments. Regulatory impact KPI — tracks how protocol changes affect analysis population composition."
    - name: "interim_analysis_assignments"
      expr: COUNT(CASE WHEN interim_analysis_flag = TRUE THEN population_assignment_id END)
      comment: "Population assignments for interim analyses. Biostatistics milestone KPI — tracks interim analysis population readiness."
    - name: "approved_assignments"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN population_assignment_id END)
      comment: "Number of approved population assignments. Database lock readiness KPI — all assignments must be approved before statistical analysis can begin."
    - name: "avg_adam_flag_value"
      expr: AVG(CAST(adam_flag_value AS DOUBLE))
      comment: "Average ADaM population flag value. Biostatistics data quality metric — validates that ADaM flag values are correctly populated for CDISC-compliant analysis datasets."
$$;
