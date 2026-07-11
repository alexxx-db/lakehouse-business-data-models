-- Metric views for domain: provider | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 14:53:25

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_clinician`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider workforce KPIs covering credentialing compliance, enrollment status, and network readiness for the active clinician population. Used by Medical Staff Office and network leadership to steer credentialing and enrollment operations."
  source: "`vibe_healthcare_v1`.`provider`.`clinician`"
  dimensions:
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Current credentialing status of the clinician (active, pending, expired), used to segment the provider panel by credentialing readiness."
    - name: "employment_status"
      expr: employment_status
      comment: "Employment status (active, terminated, leave) for workforce availability analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (employed, contracted, locum) for staffing model analysis."
    - name: "license_state"
      expr: license_state
      comment: "State of primary licensure for geographic coverage and multi-state licensing analysis."
    - name: "clinician_type"
      expr: clinician_type
      comment: "Type/category of clinician (physician, APP, allied) for provider mix analysis."
    - name: "payer_enrollment_status"
      expr: payer_enrollment_status
      comment: "Payer enrollment status used to assess billing readiness of the provider."
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year the clinician was hired, for tenure and onboarding cohort analysis."
  measures:
    - name: "Active Clinician Count"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Distinct count of clinicians; the core headcount metric leadership uses to size the provider network."
    - name: "Board Certified Count"
      expr: COUNT(DISTINCT CASE WHEN board_certified = TRUE THEN clinician_id END)
      comment: "Count of board-certified clinicians; leadership tracks this to monitor quality and payer contracting eligibility."
    - name: "Board Certified Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN board_certified = TRUE THEN clinician_id END) / NULLIF(COUNT(DISTINCT clinician_id), 0), 2)
      comment: "Percentage of clinicians who are board certified; a key quality/compliance ratio for the medical staff."
    - name: "Primary Source Verified Count"
      expr: COUNT(DISTINCT CASE WHEN primary_source_verified = TRUE THEN clinician_id END)
      comment: "Count of clinicians whose credentials are primary-source verified; drives credentialing compliance action."
    - name: "PSV Compliance Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN primary_source_verified = TRUE THEN clinician_id END) / NULLIF(COUNT(DISTINCT clinician_id), 0), 2)
      comment: "Percentage of clinicians with primary-source-verified credentials; a compliance KPI that triggers remediation when it drops."
    - name: "Medicare Enrolled Count"
      expr: COUNT(DISTINCT CASE WHEN medicare_enrolled = TRUE THEN clinician_id END)
      comment: "Count of Medicare-enrolled clinicians; directly tied to reimbursement capability."
    - name: "Medicare Enrollment Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN medicare_enrolled = TRUE THEN clinician_id END) / NULLIF(COUNT(DISTINCT clinician_id), 0), 2)
      comment: "Percentage of clinicians enrolled in Medicare; a revenue-cycle readiness KPI for leadership."
    - name: "OIG Exclusion Checked Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN oig_exclusion_checked = TRUE THEN clinician_id END) / NULLIF(COUNT(DISTINCT clinician_id), 0), 2)
      comment: "Percentage of clinicians screened against OIG exclusions; a compliance risk KPI that triggers audit when below target."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_credentialing_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credentialing application pipeline KPIs measuring throughput, decision outcomes, and turnaround for the Medical Staff Office. Used to steer credentialing capacity and identify bottlenecks."
  source: "`vibe_healthcare_v1`.`provider`.`credentialing_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the credentialing application (received, in review, decided) for pipeline stage analysis."
    - name: "application_type"
      expr: application_type
      comment: "Type of application (initial, reappointment, expedited) for workload segmentation."
    - name: "decision_type"
      expr: decision_type
      comment: "Final decision outcome (approved, denied, deferred) for approval-rate analysis."
    - name: "medical_staff_category"
      expr: medical_staff_category
      comment: "Medical staff category requested for staffing category analysis."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the application was submitted, for volume trending."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month the decision was made, for throughput trending."
  measures:
    - name: "Application Count"
      expr: COUNT(DISTINCT credentialing_application_id)
      comment: "Distinct count of credentialing applications; the baseline pipeline volume metric."
    - name: "Approved Application Count"
      expr: COUNT(DISTINCT CASE WHEN decision_type = 'Approved' THEN credentialing_application_id END)
      comment: "Count of approved applications; leadership monitors approval throughput to plan network growth."
    - name: "Denied Application Count"
      expr: COUNT(DISTINCT CASE WHEN decision_type = 'Denied' THEN credentialing_application_id END)
      comment: "Count of denied applications; a quality/risk signal that triggers review of denial reasons."
    - name: "Approval Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN decision_type = 'Approved' THEN credentialing_application_id END) / NULLIF(COUNT(DISTINCT credentialing_application_id), 0), 2)
      comment: "Percentage of applications approved; a core pipeline health KPI reviewed at operational steering meetings."
    - name: "NPDB Adverse Action Count"
      expr: COUNT(DISTINCT CASE WHEN npdb_adverse_action_flag = TRUE THEN credentialing_application_id END)
      comment: "Count of applications with NPDB adverse actions flagged; a risk KPI that drives committee escalation."
    - name: "Provisional Privileges Count"
      expr: COUNT(DISTINCT CASE WHEN provisional_privileges_flag = TRUE THEN credentialing_application_id END)
      comment: "Count of applications granted provisional privileges; tracked to manage FPPE oversight workload."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_payer_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payer enrollment KPIs measuring provider revenue-cycle readiness and network participation across payers. Used by revenue cycle and network leadership to reduce enrollment lag and denials."
  source: "`vibe_healthcare_v1`.`provider`.`provider_payer_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current payer enrollment status (approved, pending, terminated) for readiness segmentation."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment (individual, group) for enrollment workflow analysis."
    - name: "network_status"
      expr: network_status
      comment: "In/out of network status for network adequacy analysis."
    - name: "payer_type"
      expr: payer_type
      comment: "Payer category (commercial, Medicare, Medicaid) for payer-mix analysis."
    - name: "credentialing_tier"
      expr: credentialing_tier
      comment: "Credentialing tier for contracting analysis."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month enrollment was approved, for enrollment throughput trending."
  measures:
    - name: "Enrollment Count"
      expr: COUNT(DISTINCT provider_payer_enrollment_id)
      comment: "Distinct count of provider-payer enrollments; baseline volume of enrollment records."
    - name: "Approved Enrollment Count"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'Approved' THEN provider_payer_enrollment_id END)
      comment: "Count of approved enrollments; direct measure of billable payer relationships."
    - name: "Approved Enrollment Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN enrollment_status = 'Approved' THEN provider_payer_enrollment_id END) / NULLIF(COUNT(DISTINCT provider_payer_enrollment_id), 0), 2)
      comment: "Percentage of enrollments approved; a revenue-cycle readiness KPI that triggers escalation when low."
    - name: "EFT Enrolled Count"
      expr: COUNT(DISTINCT CASE WHEN eft_enrolled = TRUE THEN provider_payer_enrollment_id END)
      comment: "Count of enrollments with electronic funds transfer enabled; drives faster payment cycles."
    - name: "Enrolled Clinician Count"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Distinct clinicians with payer enrollments; measures provider coverage across payer contracts."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_privileging`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical privileging KPIs covering privilege status, provisional oversight, and FPPE compliance. Used by the Medical Staff Office and quality leadership to manage privilege lifecycle risk."
  source: "`vibe_healthcare_v1`.`provider`.`privileging`"
  dimensions:
    - name: "privilege_status"
      expr: privilege_status
      comment: "Current status of the privilege (active, expired, suspended) for lifecycle segmentation."
    - name: "privilege_type"
      expr: privilege_type
      comment: "Type of privilege (core, special, telemedicine) for privilege category analysis."
    - name: "privilege_category"
      expr: privilege_category
      comment: "Privilege category grouping for clinical service line analysis."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the privilege was approved, for privileging throughput trending."
  measures:
    - name: "Privilege Count"
      expr: COUNT(DISTINCT privileging_id)
      comment: "Distinct count of privileges granted; baseline privileging volume."
    - name: "Active Privilege Count"
      expr: COUNT(DISTINCT CASE WHEN privilege_status = 'Active' THEN privileging_id END)
      comment: "Count of active privileges; core measure of clinical authorization coverage."
    - name: "Provisional Privilege Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_provisional = TRUE THEN privileging_id END) / NULLIF(COUNT(DISTINCT privileging_id), 0), 2)
      comment: "Percentage of privileges that are provisional; drives FPPE monitoring workload and oversight staffing."
    - name: "FPPE Required Count"
      expr: COUNT(DISTINCT CASE WHEN fppe_required = TRUE THEN privileging_id END)
      comment: "Count of privileges requiring FPPE; a compliance workload KPI for the quality office."
    - name: "Avg Peer Review Score"
      expr: AVG(CAST(peer_review_score AS DOUBLE))
      comment: "Average peer review score across privileges; a clinical quality KPI reviewed by credentials committee."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_sanction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider sanction and exclusion KPIs for compliance and risk leadership. Tracks active sanctions, federal exclusions, and NPDB reporting to steer risk mitigation and credentialing holds."
  source: "`vibe_healthcare_v1`.`provider`.`provider_sanction`"
  dimensions:
    - name: "sanction_status"
      expr: sanction_status
      comment: "Current status of the sanction (active, resolved, appealed) for risk segmentation."
    - name: "sanction_type"
      expr: sanction_type
      comment: "Type of sanction for categorizing risk exposure."
    - name: "issuing_authority_type"
      expr: issuing_authority_type
      comment: "Type of authority issuing the sanction (board, federal, payer) for governance analysis."
    - name: "sanction_month"
      expr: DATE_TRUNC('MONTH', sanction_date)
      comment: "Month the sanction was issued, for trend analysis."
  measures:
    - name: "Sanction Count"
      expr: COUNT(DISTINCT provider_sanction_id)
      comment: "Distinct count of provider sanctions; baseline risk exposure metric."
    - name: "Active Sanction Count"
      expr: COUNT(DISTINCT CASE WHEN sanction_status = 'Active' THEN provider_sanction_id END)
      comment: "Count of active sanctions; a top compliance risk KPI that triggers credentialing holds."
    - name: "Federal Exclusion Count"
      expr: COUNT(DISTINCT CASE WHEN federal_program_exclusion = TRUE THEN provider_sanction_id END)
      comment: "Count of federal program exclusions; a critical risk KPI as excluded providers cannot bill federal payers."
    - name: "Credentialing Hold Count"
      expr: COUNT(DISTINCT CASE WHEN credentialing_hold = TRUE THEN provider_sanction_id END)
      comment: "Count of sanctions triggering a credentialing hold; drives immediate operational action."
    - name: "Total Settlement Amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amount from sanctions; quantifies financial risk exposure for finance and compliance leadership."
    - name: "NPDB Reported Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN reported_to_npdb = TRUE THEN provider_sanction_id END) / NULLIF(COUNT(DISTINCT provider_sanction_id), 0), 2)
      comment: "Percentage of sanctions reported to NPDB; a regulatory compliance KPI reviewed by legal/compliance."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_board_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Board certification KPIs measuring certification currency and maintenance-of-certification compliance across the medical staff. Used to protect payer contracting eligibility and clinical quality."
  source: "`vibe_healthcare_v1`.`provider`.`board_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Status of the board certification (active, expired, revoked) for currency analysis."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (initial, recertification) for lifecycle analysis."
    - name: "moc_status"
      expr: moc_status
      comment: "Maintenance-of-certification status for MOC compliance monitoring."
    - name: "certifying_board_name"
      expr: certifying_board_name
      comment: "Name of the certifying board for board-level breakdown."
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the certification expires, for renewal planning cohorts."
  measures:
    - name: "Certification Count"
      expr: COUNT(DISTINCT board_certification_id)
      comment: "Distinct count of board certifications; baseline certification inventory."
    - name: "Active Certification Count"
      expr: COUNT(DISTINCT CASE WHEN certification_status = 'Active' THEN board_certification_id END)
      comment: "Count of active certifications; core measure of clinical qualification currency."
    - name: "MOC Compliant Count"
      expr: COUNT(DISTINCT CASE WHEN moc_status = 'Compliant' THEN board_certification_id END)
      comment: "Count of MOC-compliant certifications; drives remediation outreach when trending down."
    - name: "Verified Certification Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN verification_status = 'Verified' THEN board_certification_id END) / NULLIF(COUNT(DISTINCT board_certification_id), 0), 2)
      comment: "Percentage of certifications primary-source verified; a credentialing compliance KPI."
    - name: "Certified Clinician Count"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Distinct clinicians with board certifications; measures certified provider coverage."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_cme_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Continuing medical education KPIs tracking CME credit accrual and completion for licensure and MOC compliance. Used by the Medical Staff Office to steer CME compliance and identify at-risk providers."
  source: "`vibe_healthcare_v1`.`provider`.`cme_activity`"
  dimensions:
    - name: "activity_status"
      expr: activity_status
      comment: "Status of the CME activity (completed, in progress) for completion analysis."
    - name: "activity_type"
      expr: activity_type
      comment: "Type of CME activity for delivery-mode analysis."
    - name: "cme_category"
      expr: cme_category
      comment: "CME category (Category 1, 2) for accreditation reporting."
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year of activity completion, for CME cycle cohort analysis."
  measures:
    - name: "CME Activity Count"
      expr: COUNT(DISTINCT cme_activity_id)
      comment: "Distinct count of CME activities; baseline CME engagement volume."
    - name: "Total Credit Hours"
      expr: SUM(CAST(credit_hours AS DOUBLE))
      comment: "Total CME credit hours accrued; the core input to licensure and MOC compliance evaluation."
    - name: "Avg Credit Hours Per Activity"
      expr: AVG(CAST(credit_hours AS DOUBLE))
      comment: "Average credit hours per CME activity; measures activity value for planning CME investment."
    - name: "Total MOC Points Earned"
      expr: SUM(CAST(moc_points_earned AS DOUBLE))
      comment: "Total maintenance-of-certification points earned; directly supports board certification renewal compliance."
    - name: "Verified CME Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN verification_status = 'Verified' THEN cme_activity_id END) / NULLIF(COUNT(DISTINCT cme_activity_id), 0), 2)
      comment: "Percentage of CME activities verified; a compliance KPI ensuring credit is audit-ready."
    - name: "CME Participating Clinician Count"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Distinct clinicians participating in CME; measures engagement breadth across the medical staff."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_network_affiliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network participation and directory-accuracy KPIs used by network management to steer network adequacy, panel capacity, and directory compliance (No Surprises Act)."
  source: "`vibe_healthcare_v1`.`provider`.`network_affiliation`"
  dimensions:
    - name: "affiliation_status"
      expr: affiliation_status
      comment: "Status of the network affiliation (active, terminated) for network coverage analysis."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier for tiered-network product analysis."
    - name: "participation_type"
      expr: participation_type
      comment: "Type of participation for contracting model analysis."
    - name: "panel_status"
      expr: panel_status
      comment: "Panel status (open, closed) for access and capacity analysis."
    - name: "network_adequacy_category"
      expr: network_adequacy_category
      comment: "Network adequacy category for regulatory adequacy reporting."
  measures:
    - name: "Affiliation Count"
      expr: COUNT(DISTINCT network_affiliation_id)
      comment: "Distinct count of network affiliations; baseline network coverage volume."
    - name: "Accepting New Patients Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN accepts_new_patients = TRUE THEN network_affiliation_id END) / NULLIF(COUNT(DISTINCT network_affiliation_id), 0), 2)
      comment: "Percentage of affiliations accepting new patients; a patient-access KPI critical for network adequacy."
    - name: "Directory Published Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN directory_published_flag = TRUE THEN network_affiliation_id END) / NULLIF(COUNT(DISTINCT network_affiliation_id), 0), 2)
      comment: "Percentage of affiliations published to provider directory; a No Surprises Act compliance KPI."
    - name: "Primary Care Designation Count"
      expr: COUNT(DISTINCT CASE WHEN primary_care_designation = TRUE THEN network_affiliation_id END)
      comment: "Count of primary-care-designated affiliations; measures PCP access capacity in the network."
    - name: "Networked Clinician Count"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Distinct clinicians with network affiliations; measures network provider breadth."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_reappointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reappointment (recredentialing) cycle KPIs measuring on-time completion, OPPE compliance, and decision outcomes. Used to manage recredentialing capacity and avoid privilege lapses."
  source: "`vibe_healthcare_v1`.`provider`.`reappointment`"
  dimensions:
    - name: "reappointment_status"
      expr: reappointment_status
      comment: "Status of the reappointment (in review, approved, denied) for pipeline analysis."
    - name: "decision"
      expr: decision
      comment: "Reappointment decision outcome for approval-rate analysis."
    - name: "medical_staff_category"
      expr: medical_staff_category
      comment: "Medical staff category for category-level reappointment analysis."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month of the reappointment decision, for throughput trending."
  measures:
    - name: "Reappointment Count"
      expr: COUNT(DISTINCT reappointment_id)
      comment: "Distinct count of reappointments; baseline recredentialing pipeline volume."
    - name: "Approved Reappointment Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN decision = 'Approved' THEN reappointment_id END) / NULLIF(COUNT(DISTINCT reappointment_id), 0), 2)
      comment: "Percentage of reappointments approved; a recredentialing outcome KPI reviewed by credentials committee."
    - name: "NPDB Adverse Finding Count"
      expr: COUNT(DISTINCT CASE WHEN npdb_adverse_finding = TRUE THEN reappointment_id END)
      comment: "Count of reappointments with NPDB adverse findings; a risk KPI driving committee escalation."
    - name: "Avg CME Hours Completed"
      expr: AVG(CAST(cme_hours_completed AS DOUBLE))
      comment: "Average CME hours completed at reappointment; measures ongoing education compliance for renewal."
    - name: "CME Compliant Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN cme_compliance_status = 'Compliant' THEN reappointment_id END) / NULLIF(COUNT(DISTINCT reappointment_id), 0), 2)
      comment: "Percentage of reappointments meeting CME requirements; a compliance readiness KPI for the cycle."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_dea_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DEA registration KPIs monitoring controlled-substance prescribing authority currency and expiration risk. Used by compliance and pharmacy leadership to prevent prescribing lapses."
  source: "`vibe_healthcare_v1`.`provider`.`dea_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Status of the DEA registration (active, expired, surrendered) for currency analysis."
    - name: "registration_type"
      expr: registration_type
      comment: "Type of DEA registration for authority category analysis."
    - name: "registration_state"
      expr: registration_state
      comment: "State of registration for geographic prescribing coverage."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month the registration expires, for renewal planning."
  measures:
    - name: "DEA Registration Count"
      expr: COUNT(DISTINCT dea_registration_id)
      comment: "Distinct count of DEA registrations; baseline prescribing-authority inventory."
    - name: "Active Registration Count"
      expr: COUNT(DISTINCT CASE WHEN registration_status = 'Active' THEN dea_registration_id END)
      comment: "Count of active DEA registrations; core measure of active prescribing authority."
    - name: "Expiring Alert Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN expiration_alert_sent = TRUE THEN dea_registration_id END) / NULLIF(COUNT(DISTINCT dea_registration_id), 0), 2)
      comment: "Percentage of registrations with expiration alerts sent; measures proactive renewal outreach effectiveness."
    - name: "Schedule II Authorized Count"
      expr: COUNT(DISTINCT CASE WHEN schedule_ii_authorized = TRUE THEN dea_registration_id END)
      comment: "Count of registrations authorized for Schedule II; tracks high-risk prescribing authority for compliance oversight."
    - name: "Registered Clinician Count"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Distinct clinicians with DEA registrations; measures prescribing provider base."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_malpractice_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Malpractice coverage KPIs monitoring active coverage, coverage gaps, and open claims exposure. Used by risk management and credentialing to prevent coverage lapses and quantify liability."
  source: "`vibe_healthcare_v1`.`provider`.`malpractice_coverage`"
  dimensions:
    - name: "coverage_status"
      expr: coverage_status
      comment: "Status of the malpractice coverage (active, expired) for currency analysis."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage (claims-made, occurrence) for liability model analysis."
    - name: "coverage_state"
      expr: coverage_state
      comment: "State of coverage for geographic liability analysis."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month the coverage expires, for renewal planning."
  measures:
    - name: "Coverage Record Count"
      expr: COUNT(DISTINCT malpractice_coverage_id)
      comment: "Distinct count of malpractice coverage records; baseline coverage inventory."
    - name: "Coverage Lapse Count"
      expr: COUNT(DISTINCT CASE WHEN coverage_lapse_indicator = TRUE THEN malpractice_coverage_id END)
      comment: "Count of records with a coverage lapse; a critical risk KPI that triggers credentialing action."
    - name: "Total Open Claims"
      expr: SUM(CAST(open_claims_count AS DOUBLE))
      comment: "Total open malpractice claims across coverage records; quantifies active liability exposure."
    - name: "Verified Coverage Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN verification_status = 'Verified' THEN malpractice_coverage_id END) / NULLIF(COUNT(DISTINCT malpractice_coverage_id), 0), 2)
      comment: "Percentage of coverage records verified; a credentialing compliance KPI."
    - name: "Covered Clinician Count"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Distinct clinicians with malpractice coverage; measures coverage breadth across the provider base."
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
  filter: is_accepting_new_patients = true
  dimensions:
    - name: "state_code"
      expr: state_code
      comment: "State code of the location"
    - name: "location_type"
      expr: location_type
      comment: "Type of location (e.g., clinic, hospital)"
    - name: "is_telehealth_enabled"
      expr: is_telehealth_enabled
      comment: "Whether telehealth services are enabled at the location"
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
    - name: "specialty_id"
      expr: specialty_id
      comment: "Specialty associated with the reappointment"
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year of the reappointment record"
  measures:
    - name: "pending_reappointment_count"
      expr: COUNT(1)
      comment: "Number of pending reappointments"
$$;