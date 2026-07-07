-- Metric views for domain: provider | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 07:21:53

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_clinician`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core clinician master KPIs for network capacity, credentialing readiness, and compliance risk. Used by CMO/VP Medical Affairs to steer provider onboarding, active roster health, and exclusion/expiration risk."
  source: "`vibe_healthcare_v1`.`provider`.`clinician`"
  dimensions:
    - name: "clinician_status"
      expr: clinician_status
      comment: "Lifecycle status of the clinician (active, inactive, terminated) for roster health analysis."
    - name: "clinician_type"
      expr: clinician_type
      comment: "Clinician classification (physician, APP, etc.) for provider-mix analysis."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Current credentialing state used to segment credentialing pipeline and readiness."
    - name: "employment_status"
      expr: employment_status
      comment: "Employment status for employed vs. affiliated workforce planning."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (full-time, part-time, contract) for capacity planning."
    - name: "license_state"
      expr: license_state
      comment: "State of licensure for geographic coverage and network adequacy."
    - name: "payer_enrollment_status"
      expr: payer_enrollment_status
      comment: "Payer enrollment status for revenue-cycle readiness segmentation."
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month of hire for onboarding-trend analysis."
  measures:
    - name: "Total Clinicians"
      expr: COUNT(1)
      comment: "Count of clinician records; baseline network size for capacity and roster steering."
    - name: "Active Clinicians"
      expr: COUNT(DISTINCT CASE WHEN clinician_status = 'active' THEN clinician_id END)
      comment: "Distinct active clinicians; the deployable capacity leadership plans around."
    - name: "Board Certified Clinicians"
      expr: COUNT(DISTINCT CASE WHEN board_certified = TRUE THEN clinician_id END)
      comment: "Distinct board-certified clinicians; quality and payer-contracting differentiator."
    - name: "Board Certified Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN board_certified = TRUE THEN clinician_id END) / NULLIF(COUNT(DISTINCT clinician_id), 0), 2)
      comment: "Share of clinicians board-certified; quality benchmark for medical staff steering."
    - name: "Primary Source Verified Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN primary_source_verified = TRUE THEN clinician_id END) / NULLIF(COUNT(DISTINCT clinician_id), 0), 2)
      comment: "Share with completed primary source verification; direct credentialing-compliance KPI."
    - name: "OIG Exclusion Checked Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN oig_exclusion_checked = TRUE THEN clinician_id END) / NULLIF(COUNT(DISTINCT clinician_id), 0), 2)
      comment: "Share screened against OIG exclusion list; HIPAA/fraud-abuse compliance risk indicator."
    - name: "Expired License Clinicians"
      expr: COUNT(DISTINCT CASE WHEN license_expiration_date < CURRENT_DATE THEN clinician_id END)
      comment: "Clinicians with lapsed licenses; direct compliance and billing-risk trigger."
    - name: "License Expiring 90 Days"
      expr: COUNT(DISTINCT CASE WHEN license_expiration_date >= CURRENT_DATE AND license_expiration_date <= DATE_ADD(CURRENT_DATE, 90) THEN clinician_id END)
      comment: "Clinicians whose license expires within 90 days; proactive renewal action list."
    - name: "Credentialing Expiring 90 Days"
      expr: COUNT(DISTINCT CASE WHEN credentialing_expiration_date >= CURRENT_DATE AND credentialing_expiration_date <= DATE_ADD(CURRENT_DATE, 90) THEN clinician_id END)
      comment: "Clinicians due for recredentialing within 90 days; prevents network drop-off."
    - name: "Medicare Enrolled Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN medicare_enrolled = TRUE THEN clinician_id END) / NULLIF(COUNT(DISTINCT clinician_id), 0), 2)
      comment: "Share Medicare-enrolled; payer-mix and reimbursement-readiness KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_credentialing_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credentialing pipeline throughput, cycle-time, and approval-quality KPIs. Used by Medical Staff Office and VP Medical Affairs to steer time-to-credential, denial rates, and NPDB risk."
  source: "`vibe_healthcare_v1`.`provider`.`credentialing_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current pipeline stage for work-in-progress and bottleneck analysis."
    - name: "application_type"
      expr: application_type
      comment: "Initial vs. reappointment application type for pipeline segmentation."
    - name: "decision_type"
      expr: decision_type
      comment: "Approval/denial decision outcome for approval-quality analysis."
    - name: "medical_staff_category"
      expr: medical_staff_category
      comment: "Medical staff category granted, for privileging-mix steering."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of submission for pipeline-volume trending."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month of decision for throughput trending."
  measures:
    - name: "Total Applications"
      expr: COUNT(1)
      comment: "Credentialing application volume; baseline pipeline load."
    - name: "Approved Applications"
      expr: COUNT(DISTINCT CASE WHEN decision_type = 'approved' THEN credentialing_application_id END)
      comment: "Distinct approved applications; core throughput outcome."
    - name: "Denied Applications"
      expr: COUNT(DISTINCT CASE WHEN decision_type = 'denied' THEN credentialing_application_id END)
      comment: "Distinct denied applications; quality/risk trigger for review."
    - name: "Denial Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN decision_type = 'denied' THEN credentialing_application_id END) / NULLIF(COUNT(DISTINCT CASE WHEN decision_type IN ('approved','denied') THEN credentialing_application_id END), 0), 2)
      comment: "Share of decided applications denied; medical-staff quality and process KPI."
    - name: "Avg Days To Decision"
      expr: ROUND(AVG(DATEDIFF(decision_date, submission_date)), 1)
      comment: "Average submission-to-decision cycle time; primary credentialing throughput KPI."
    - name: "NPDB Adverse Action Applications"
      expr: COUNT(DISTINCT CASE WHEN npdb_adverse_action_flag = TRUE THEN credentialing_application_id END)
      comment: "Applications with NPDB adverse actions; direct patient-safety and liability risk signal."
    - name: "Provisional Privileges Applications"
      expr: COUNT(DISTINCT CASE WHEN provisional_privileges_flag = TRUE THEN credentialing_application_id END)
      comment: "Applications granted provisional privileges; monitors interim-access exposure."
    - name: "In Process Applications"
      expr: COUNT(DISTINCT CASE WHEN decision_date IS NULL THEN credentialing_application_id END)
      comment: "Undecided applications; active work-in-progress backlog for staffing decisions."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_malpractice_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Malpractice coverage adequacy, lapse risk, and open-claims exposure KPIs. Used by Risk Management and Medical Affairs to steer coverage compliance and liability exposure."
  source: "`vibe_healthcare_v1`.`provider`.`malpractice_coverage`"
  dimensions:
    - name: "coverage_status"
      expr: coverage_status
      comment: "Coverage status (active, lapsed) for compliance segmentation."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of malpractice coverage for portfolio analysis."
    - name: "coverage_state"
      expr: coverage_state
      comment: "State of coverage for geographic risk analysis."
    - name: "carrier_name"
      expr: carrier_name
      comment: "Insurance carrier for carrier-concentration risk analysis."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of coverage for credentialing readiness."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month of coverage expiration for renewal planning."
  measures:
    - name: "Total Coverage Records"
      expr: COUNT(1)
      comment: "Malpractice coverage records; baseline for coverage-portfolio steering."
    - name: "Total Aggregate Limit"
      expr: SUM(CAST(aggregate_limit AS DOUBLE))
      comment: "Total aggregate coverage limit across policies; portfolio-level protection level."
    - name: "Avg Per Occurrence Limit"
      expr: ROUND(AVG(CAST(per_occurrence_limit AS DOUBLE)), 2)
      comment: "Average per-occurrence limit; adequacy benchmark against required minimums."
    - name: "Coverage Lapse Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN coverage_lapse_indicator = TRUE THEN malpractice_coverage_id END) / NULLIF(COUNT(DISTINCT malpractice_coverage_id), 0), 2)
      comment: "Share of policies with a coverage lapse; direct compliance-risk KPI."
    - name: "Coverage Expiring 90 Days"
      expr: COUNT(DISTINCT CASE WHEN expiration_date >= CURRENT_DATE AND expiration_date <= DATE_ADD(CURRENT_DATE, 90) THEN malpractice_coverage_id END)
      comment: "Policies expiring within 90 days; proactive renewal action list."
    - name: "Verified Coverage Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN verification_status = 'verified' THEN malpractice_coverage_id END) / NULLIF(COUNT(DISTINCT malpractice_coverage_id), 0), 2)
      comment: "Share of coverage records verified; credentialing-file completeness KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_sanction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider sanction, exclusion, and monetary-penalty exposure KPIs. Used by Compliance Officer and General Counsel to steer exclusion screening and fraud/abuse liability."
  source: "`vibe_healthcare_v1`.`provider`.`sanction`"
  dimensions:
    - name: "sanction_status"
      expr: sanction_status
      comment: "Status of the sanction for active-exposure segmentation."
    - name: "sanction_type"
      expr: sanction_type
      comment: "Type of sanction for risk-category analysis."
    - name: "issuing_authority_type"
      expr: issuing_authority_type
      comment: "Type of issuing authority (federal, state, board) for source analysis."
    - name: "sanction_month"
      expr: DATE_TRUNC('MONTH', sanction_date)
      comment: "Month the sanction occurred for trend monitoring."
  measures:
    - name: "Total Sanctions"
      expr: COUNT(1)
      comment: "Sanction records; baseline compliance-risk volume."
    - name: "Federal Program Exclusions"
      expr: COUNT(DISTINCT CASE WHEN federal_program_exclusion = TRUE THEN sanction_id END)
      comment: "Providers with federal program exclusions; billing prohibition and fraud-liability trigger."
    - name: "Medicare Exclusions"
      expr: COUNT(DISTINCT CASE WHEN medicare_exclusion = TRUE THEN sanction_id END)
      comment: "Medicare-excluded providers; direct claims-denial and OIG-liability risk."
    - name: "Total Civil Monetary Penalties"
      expr: SUM(CAST(civil_monetary_penalty_amount AS DOUBLE))
      comment: "Total civil monetary penalties; quantified financial-liability exposure."
    - name: "Total Settlement Amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amounts; quantified resolution-cost exposure."
    - name: "Credentialing Hold Sanctions"
      expr: COUNT(DISTINCT CASE WHEN credentialing_hold = TRUE THEN sanction_id END)
      comment: "Sanctions triggering credentialing holds; operational impact on network availability."
    - name: "Reported To NPDB Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN reported_to_npdb = TRUE THEN sanction_id END) / NULLIF(COUNT(DISTINCT sanction_id), 0), 2)
      comment: "Share of sanctions reported to NPDB; regulatory-reporting compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_payer_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payer enrollment readiness, revalidation risk, and network-status KPIs. Used by Revenue Cycle and Payer Enrollment teams to steer billing readiness and prevent claim denials."
  source: "`vibe_healthcare_v1`.`provider`.`provider_payer_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Enrollment status for billing-readiness segmentation."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Enrollment type (individual, group) for enrollment-mix analysis."
    - name: "network_status"
      expr: network_status
      comment: "In/out of network status for reimbursement-tier analysis."
    - name: "payer_type"
      expr: payer_type
      comment: "Payer type (commercial, Medicare, Medicaid) for payer-mix analysis."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status for enrollment gating analysis."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month enrollment became effective for trend tracking."
  measures:
    - name: "Total Enrollments"
      expr: COUNT(1)
      comment: "Provider-payer enrollment records; baseline enrollment volume."
    - name: "Active Enrollments"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'active' THEN provider_payer_enrollment_id END)
      comment: "Distinct active enrollments; billable provider-payer relationships."
    - name: "EFT Enrolled Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN eft_enrolled = TRUE THEN provider_payer_enrollment_id END) / NULLIF(COUNT(DISTINCT provider_payer_enrollment_id), 0), 2)
      comment: "Share enrolled for electronic funds transfer; cash-flow efficiency KPI."
    - name: "Revalidation Due 90 Days"
      expr: COUNT(DISTINCT CASE WHEN revalidation_due_date >= CURRENT_DATE AND revalidation_due_date <= DATE_ADD(CURRENT_DATE, 90) THEN provider_payer_enrollment_id END)
      comment: "Enrollments needing revalidation within 90 days; prevents lapse-driven denials."
    - name: "Terminated Enrollments"
      expr: COUNT(DISTINCT CASE WHEN termination_date IS NOT NULL THEN provider_payer_enrollment_id END)
      comment: "Terminated enrollments; network-attrition and revenue-loss signal."
    - name: "Avg Days To Approval"
      expr: ROUND(AVG(DATEDIFF(approval_date, application_submitted_date)), 1)
      comment: "Average submission-to-approval cycle time; enrollment throughput KPI driving time-to-bill."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_privileging`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical privileging status, FPPE/OPPE compliance, and revocation/suspension exposure KPIs. Used by Medical Staff Office and CMO to steer privilege currency and patient-safety readiness."
  source: "`vibe_healthcare_v1`.`provider`.`privileging`"
  dimensions:
    - name: "privilege_status"
      expr: privilege_status
      comment: "Privilege status for active-privilege segmentation."
    - name: "privilege_type"
      expr: privilege_type
      comment: "Type of privilege for scope analysis."
    - name: "privilege_category"
      expr: privilege_category
      comment: "Privilege category for clinical-scope grouping."
    - name: "granted_month"
      expr: DATE_TRUNC('MONTH', granted_date)
      comment: "Month privilege was granted for trend analysis."
  measures:
    - name: "Total Privileges"
      expr: COUNT(1)
      comment: "Privilege records; baseline clinical-privilege footprint."
    - name: "Provisional Privileges"
      expr: COUNT(DISTINCT CASE WHEN is_provisional = TRUE THEN privileging_id END)
      comment: "Provisional privileges outstanding; interim-access oversight KPI."
    - name: "Privileges Expiring 90 Days"
      expr: COUNT(DISTINCT CASE WHEN expiration_date >= CURRENT_DATE AND expiration_date <= DATE_ADD(CURRENT_DATE, 90) THEN privileging_id END)
      comment: "Privileges expiring within 90 days; prevents unauthorized-practice risk."
    - name: "Revoked Or Suspended Privileges"
      expr: COUNT(DISTINCT CASE WHEN privilege_status IN ('revoked','suspended') THEN privileging_id END)
      comment: "Revoked/suspended privileges; patient-safety and quality-action signal."
    - name: "FPPE Required Pending Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN fppe_required = TRUE AND fppe_completion_date IS NULL THEN privileging_id END) / NULLIF(COUNT(DISTINCT CASE WHEN fppe_required = TRUE THEN privileging_id END), 0), 2)
      comment: "Share of FPPE-required privileges still pending completion; Joint Commission compliance KPI."
    - name: "Avg Peer Review Score"
      expr: ROUND(AVG(CAST(peer_review_score AS DOUBLE)), 2)
      comment: "Average peer-review score; ongoing professional practice quality signal."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_network_affiliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider network participation, panel capacity, and directory-accuracy KPIs. Used by Network Management and Payer Strategy to steer network adequacy and access."
  source: "`vibe_healthcare_v1`.`provider`.`network_affiliation`"
  dimensions:
    - name: "affiliation_status"
      expr: affiliation_status
      comment: "Network affiliation status for participation segmentation."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier for reimbursement and access analysis."
    - name: "participation_type"
      expr: participation_type
      comment: "Type of participation for contract-mix analysis."
    - name: "network_adequacy_category"
      expr: network_adequacy_category
      comment: "Network adequacy category for CMS adequacy compliance."
    - name: "service_area_state"
      expr: service_area_state
      comment: "Service area state for geographic access analysis."
  measures:
    - name: "Total Affiliations"
      expr: COUNT(1)
      comment: "Network affiliation records; baseline network breadth."
    - name: "Accepting New Patients Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN accepts_new_patients = TRUE THEN network_affiliation_id END) / NULLIF(COUNT(DISTINCT network_affiliation_id), 0), 2)
      comment: "Share accepting new patients; patient-access and adequacy KPI."
    - name: "Directory Published Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN directory_published_flag = TRUE THEN network_affiliation_id END) / NULLIF(COUNT(DISTINCT network_affiliation_id), 0), 2)
      comment: "Share published in directory; No Surprises Act directory-accuracy compliance KPI."
    - name: "Primary Care Designated Affiliations"
      expr: COUNT(DISTINCT CASE WHEN primary_care_designation = TRUE THEN network_affiliation_id END)
      comment: "Primary-care-designated affiliations; PCP-access adequacy signal."
    - name: "Terminated Affiliations"
      expr: COUNT(DISTINCT CASE WHEN termination_date IS NOT NULL THEN network_affiliation_id END)
      comment: "Terminated affiliations; network-attrition and adequacy-risk signal."
    - name: "Telehealth Eligible Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN telehealth_eligible = TRUE THEN network_affiliation_id END) / NULLIF(COUNT(DISTINCT network_affiliation_id), 0), 2)
      comment: "Share telehealth-eligible; virtual-access strategy KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_npdb_query`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NPDB query turnaround, adverse-action detection, and continuous-query enrollment KPIs. Used by Compliance and Medical Staff Office to steer query timeliness and risk detection."
  source: "`vibe_healthcare_v1`.`provider`.`npdb_query`"
  dimensions:
    - name: "query_status"
      expr: query_status
      comment: "Status of the NPDB query for workflow segmentation."
    - name: "query_type"
      expr: query_type
      comment: "Type of NPDB query for query-mix analysis."
    - name: "response_status"
      expr: response_status
      comment: "Response status for query-outcome analysis."
    - name: "query_month"
      expr: DATE_TRUNC('MONTH', query_date)
      comment: "Month the query was submitted for volume trending."
  measures:
    - name: "Total Queries"
      expr: COUNT(1)
      comment: "NPDB query volume; baseline credentialing-screening activity."
    - name: "Adverse Action Queries"
      expr: COUNT(DISTINCT CASE WHEN adverse_action_flag = TRUE THEN npdb_query_id END)
      comment: "Queries returning adverse actions; patient-safety risk-detection KPI."
    - name: "Malpractice Payment Queries"
      expr: COUNT(DISTINCT CASE WHEN malpractice_payment_flag = TRUE THEN npdb_query_id END)
      comment: "Queries returning malpractice payments; liability risk-detection signal."
    - name: "Avg Response Turnaround Days"
      expr: ROUND(AVG(DATEDIFF(response_date, query_date)), 1)
      comment: "Average query-to-response turnaround; credentialing-timeliness KPI."
    - name: "Continuous Query Enrollment Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN continuous_query_enrollment_flag = TRUE THEN npdb_query_id END) / NULLIF(COUNT(DISTINCT npdb_query_id), 0), 2)
      comment: "Share enrolled in NPDB continuous query; ongoing-monitoring compliance KPI."
    - name: "Review Required Pending"
      expr: COUNT(DISTINCT CASE WHEN review_required_flag = TRUE AND review_completed_date IS NULL THEN npdb_query_id END)
      comment: "Queries flagged for review but not completed; open compliance-work backlog."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_reappointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reappointment cycle timeliness KPIs. Used by Medical Staff Office to steer on-time reappointment and prevent privilege lapses."
  source: "`vibe_healthcare_v1`.`provider`.`reappointment`"
  dimensions:
    - name: "reappointment_status"
      expr: reappointment_status
      comment: "Status of the reappointment cycle for workflow segmentation."
    - name: "cycle"
      expr: cycle
      comment: "Reappointment cycle identifier for cycle-cohort analysis."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month reappointment is due for renewal planning."
  measures:
    - name: "Total Reappointments"
      expr: COUNT(1)
      comment: "Reappointment records; baseline reappointment workload."
    - name: "Overdue Reappointments"
      expr: COUNT(DISTINCT CASE WHEN due_date < CURRENT_DATE AND decision_date IS NULL THEN reappointment_id END)
      comment: "Reappointments past due without a decision; direct privilege-lapse risk trigger."
    - name: "Due 90 Days Reappointments"
      expr: COUNT(DISTINCT CASE WHEN due_date >= CURRENT_DATE AND due_date <= DATE_ADD(CURRENT_DATE, 90) THEN reappointment_id END)
      comment: "Reappointments due within 90 days; proactive action list."
    - name: "Avg Days To Decision"
      expr: ROUND(AVG(DATEDIFF(decision_date, due_date)), 1)
      comment: "Average due-date-to-decision days; reappointment timeliness KPI (negative = ahead of schedule)."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_dea_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DEA registration currency KPIs for controlled-substance prescribing compliance. Used by Compliance and Pharmacy leadership to prevent lapsed prescribing authority."
  source: "`vibe_healthcare_v1`.`provider`.`dea_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "DEA registration status for compliance segmentation."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "Authorized DEA schedule for controlled-substance scope analysis."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month of DEA expiration for renewal planning."
  measures:
    - name: "Total DEA Registrations"
      expr: COUNT(1)
      comment: "DEA registration records; baseline prescribing-authority footprint."
    - name: "Active DEA Registrations"
      expr: COUNT(DISTINCT CASE WHEN registration_status = 'active' THEN dea_registration_id END)
      comment: "Distinct active DEA registrations; deployable controlled-substance prescribers."
    - name: "Expired DEA Registrations"
      expr: COUNT(DISTINCT CASE WHEN expiration_date < CURRENT_DATE THEN dea_registration_id END)
      comment: "Lapsed DEA registrations; direct prescribing-compliance risk trigger."
    - name: "DEA Expiring 90 Days"
      expr: COUNT(DISTINCT CASE WHEN expiration_date >= CURRENT_DATE AND expiration_date <= DATE_ADD(CURRENT_DATE, 90) THEN dea_registration_id END)
      comment: "DEA registrations expiring within 90 days; proactive renewal action list."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_board_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Board certification currency KPIs supporting medical-staff quality and payer-contracting. Used by Medical Affairs to steer certification maintenance."
  source: "`vibe_healthcare_v1`.`provider`.`board_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Board certification status for currency segmentation."
    - name: "board_name"
      expr: board_name
      comment: "Certifying board for board-mix analysis."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month of certification expiration for renewal planning."
  measures:
    - name: "Total Certifications"
      expr: COUNT(1)
      comment: "Board certification records; baseline certification footprint."
    - name: "Active Certifications"
      expr: COUNT(DISTINCT CASE WHEN certification_status = 'active' THEN board_certification_id END)
      comment: "Distinct active certifications; current quality-credential inventory."
    - name: "Certifications Expiring 90 Days"
      expr: COUNT(DISTINCT CASE WHEN expiration_date >= CURRENT_DATE AND expiration_date <= DATE_ADD(CURRENT_DATE, 90) THEN board_certification_id END)
      comment: "Certifications expiring within 90 days; MOC-renewal action list."
    - name: "Certified Clinicians"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Distinct clinicians with board certifications; medical-staff quality-coverage KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_cme_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Continuing Medical Education engagement KPIs supporting licensure-maintenance compliance. Used by Medical Education leadership to steer CME completion."
  source: "`vibe_healthcare_v1`.`provider`.`cme_activity`"
  dimensions:
    - name: "cme_activity_status"
      expr: cme_activity_status
      comment: "CME activity status for completion segmentation."
    - name: "provider_organization"
      expr: provider_organization
      comment: "CME provider organization for source analysis."
    - name: "activity_month"
      expr: DATE_TRUNC('MONTH', activity_date)
      comment: "Month of CME activity for engagement trending."
  measures:
    - name: "Total CME Activities"
      expr: COUNT(1)
      comment: "CME activity records; baseline education engagement."
    - name: "Total Credit Hours"
      expr: SUM(CAST(credit_hours AS DOUBLE))
      comment: "Total CME credit hours earned; licensure-maintenance compliance KPI."
    - name: "Avg Credit Hours Per Activity"
      expr: ROUND(AVG(CAST(credit_hours AS DOUBLE)), 2)
      comment: "Average credit hours per activity; CME-program efficiency signal."
    - name: "Participating Clinicians"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Distinct clinicians completing CME; education-engagement coverage KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_group`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider group master KPIs for network composition, value-based-care participation, and access. Used by Network Strategy to steer group-level contracting and access."
  source: "`vibe_healthcare_v1`.`provider`.`group`"
  dimensions:
    - name: "group_status"
      expr: group_status
      comment: "Group lifecycle status for active-group segmentation."
    - name: "group_type"
      expr: group_type
      comment: "Group type for composition analysis."
    - name: "network_participation_status"
      expr: network_participation_status
      comment: "Network participation status for contracting analysis."
    - name: "primary_service_state"
      expr: primary_service_state
      comment: "Primary service state for geographic access analysis."
  measures:
    - name: "Total Groups"
      expr: COUNT(1)
      comment: "Provider group records; baseline group inventory."
    - name: "ACO Participating Groups"
      expr: COUNT(DISTINCT CASE WHEN aco_participant = TRUE THEN group_id END)
      comment: "Groups participating in ACOs; value-based-care strategy KPI."
    - name: "MIPS Eligible Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN mips_eligible = TRUE THEN group_id END) / NULLIF(COUNT(DISTINCT group_id), 0), 2)
      comment: "Share of MIPS-eligible groups; quality-payment-program readiness KPI."
    - name: "Accepting New Patients Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN accepts_new_patients = TRUE THEN group_id END) / NULLIF(COUNT(DISTINCT group_id), 0), 2)
      comment: "Share of groups accepting new patients; patient-access KPI."
    - name: "Telehealth Capable Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN telehealth_capable = TRUE THEN group_id END) / NULLIF(COUNT(DISTINCT group_id), 0), 2)
      comment: "Share telehealth-capable; virtual-access strategy KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_network_affiliation_active`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Active participation in provider networks"
  source: "`vibe_healthcare_v1`.`provider`.`network_affiliation`"
  dimensions:
    - name: "network_tier"
      expr: network_tier
      comment: "Tier level of the network participation"
    - name: "provider_network_id"
      expr: provider_network_id
      comment: "Identifier of the provider network"
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year of affiliation effectiveness"
  measures:
    - name: "active_network_affiliation_count"
      expr: COUNT(1)
      comment: "Count of active network affiliations"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_location_access`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Access availability of provider locations"
  source: "`vibe_healthcare_v1`.`provider`.`provider_location`"
  dimensions:
    - name: "location_type"
      expr: location_type
      comment: "Type of location (e.g., clinic, hospital)"
  measures:
    - name: "accepting_location_count"
      expr: COUNT(1)
      comment: "Count of provider locations currently accepting new patients"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_reappointment_pending`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pending reappointments by specialty"
  source: "`vibe_healthcare_v1`.`provider`.`reappointment`"
  filter: reappointment_status = 'Pending'
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "pending_reappointment_count"
      expr: COUNT(1)
      comment: "Number of pending reappointments"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_active_sanctions`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Active sanctions impacting providers"
  source: "`vibe_healthcare_v1`.`provider`.`sanction`"
  filter: sanction_status = 'Active'
  dimensions:
    - name: "sanction_type"
      expr: sanction_type
      comment: "Type/category of the sanction"
    - name: "sanction_status"
      expr: sanction_status
      comment: "Current status of the sanction"
    - name: "effective_year"
      expr: DATE_TRUNC('year', sanction_date)
      comment: "Year the sanction was recorded"
  measures:
    - name: "active_sanction_count"
      expr: COUNT(1)
      comment: "Count of sanctions currently active"
$$;