-- Metric views for domain: provider | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 20:04:11

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core provider master metrics tracking network composition, credentialing health, and participation status across the provider population. Used by network management, credentialing operations, and executive leadership to steer provider strategy."
  source: "`vibe_health_insurance_v1`.`provider`.`provider`"
  dimensions:
    - name: "provider_type"
      expr: provider_type
      comment: "Classification of the provider (e.g. MD, DO, NP, PA, facility) for network composition analysis."
    - name: "primary_specialty"
      expr: primary_specialty
      comment: "Provider primary specialty used to assess specialty mix and adequacy gaps."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Current credentialing status (e.g. Active, Pending, Expired) to monitor credentialing pipeline health."
    - name: "participation_status"
      expr: participation_status
      comment: "Network participation status (e.g. In-Network, Terminated) for network size tracking."
    - name: "network_participation_flag"
      expr: network_participation_flag
      comment: "Boolean flag indicating whether the provider is currently participating in the network."
    - name: "state"
      expr: state
      comment: "State where the provider is located, used for geographic network adequacy analysis."
    - name: "provider_category"
      expr: provider_category
      comment: "Broad category of provider (e.g. Individual, Group, Facility) for segmentation."
    - name: "effective_start_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the provider became effective in the network, used for cohort and tenure analysis."
    - name: "malpractice_coverage_flag"
      expr: malpractice_coverage_flag
      comment: "Indicates whether the provider has active malpractice coverage — a credentialing risk signal."
    - name: "status_flag"
      expr: status_flag
      comment: "Active/inactive status flag for the provider record."
  measures:
    - name: "total_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Total number of unique providers in the network. Baseline KPI for network size and growth tracking used in executive dashboards."
    - name: "active_providers"
      expr: COUNT(DISTINCT CASE WHEN status_flag = TRUE THEN provider_id END)
      comment: "Count of providers with an active status flag. Drives network adequacy assessments and capacity planning."
    - name: "credentialed_providers"
      expr: COUNT(DISTINCT CASE WHEN credentialing_status = 'Active' THEN provider_id END)
      comment: "Count of providers with active credentialing status. Critical compliance KPI — regulators require minimum credentialing thresholds."
    - name: "network_participating_providers"
      expr: COUNT(DISTINCT CASE WHEN network_participation_flag = TRUE THEN provider_id END)
      comment: "Count of providers actively participating in the network. Core network adequacy metric used in regulatory filings and plan design."
    - name: "providers_with_malpractice_coverage"
      expr: COUNT(DISTINCT CASE WHEN malpractice_coverage_flag = TRUE THEN provider_id END)
      comment: "Count of providers with active malpractice coverage. Credentialing risk KPI — gaps trigger immediate remediation actions."
    - name: "providers_missing_malpractice_coverage"
      expr: COUNT(DISTINCT CASE WHEN malpractice_coverage_flag = FALSE OR malpractice_coverage_flag IS NULL THEN provider_id END)
      comment: "Count of providers lacking malpractice coverage. Elevated values signal credentialing compliance risk requiring urgent intervention."
    - name: "terminated_providers"
      expr: COUNT(DISTINCT CASE WHEN termination_date IS NOT NULL THEN provider_id END)
      comment: "Count of providers with a recorded termination date. Tracks network attrition and informs retention strategy."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_credentialing_pipeline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider license and credentialing pipeline metrics tracking expiration risk, verification compliance, and disciplinary actions. Used by credentialing operations and compliance teams to manage license lifecycle and regulatory risk."
  source: "`vibe_health_insurance_v1`.`provider`.`license`"
  dimensions:
    - name: "license_type"
      expr: license_type
      comment: "Type of license (e.g. Medical, DEA, State) for segmenting credentialing workload."
    - name: "license_status"
      expr: license_status
      comment: "Current status of the license (e.g. Active, Expired, Suspended) for pipeline health monitoring."
    - name: "issuing_state"
      expr: issuing_state
      comment: "State that issued the license, used for geographic compliance analysis."
    - name: "disciplinary_action_flag"
      expr: disciplinary_action_flag
      comment: "Indicates whether a disciplinary action has been recorded against this license — a critical risk signal."
    - name: "continuing_education_required_flag"
      expr: continuing_education_required_flag
      comment: "Whether continuing education is required for this license type."
    - name: "compact_participation_flag"
      expr: compact_participation_flag
      comment: "Whether the provider participates in a multi-state compact, relevant for telehealth network adequacy."
    - name: "record_current_flag"
      expr: record_current_flag
      comment: "Indicates whether this is the current active license record."
    - name: "expiration_year"
      expr: DATE_TRUNC('YEAR', expiration_date)
      comment: "Year the license expires, used for renewal workload forecasting."
    - name: "primary_source_verification_method"
      expr: primary_source_verification_method
      comment: "Method used for primary source verification (e.g. NPDB, State Board) for audit and compliance reporting."
    - name: "telemedicine_authorized_flag"
      expr: telemedicine_authorized_flag
      comment: "Whether the license authorizes telemedicine practice — relevant for telehealth network capacity."
  measures:
    - name: "total_active_licenses"
      expr: COUNT(DISTINCT CASE WHEN license_status = 'Active' AND record_current_flag = TRUE THEN license_id END)
      comment: "Total active, current licenses across the provider population. Baseline credentialing compliance KPI."
    - name: "licenses_with_disciplinary_actions"
      expr: COUNT(DISTINCT CASE WHEN disciplinary_action_flag = TRUE THEN license_id END)
      comment: "Count of licenses with recorded disciplinary actions. Elevated values trigger credentialing committee review and potential network termination."
    - name: "licenses_expiring_within_90_days"
      expr: COUNT(DISTINCT CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN license_id END)
      comment: "Licenses expiring within 90 days. Operational KPI driving renewal outreach prioritization to prevent credentialing lapses."
    - name: "licenses_expired"
      expr: COUNT(DISTINCT CASE WHEN expiration_date < CURRENT_DATE AND record_current_flag = TRUE THEN license_id END)
      comment: "Count of currently expired licenses. Critical compliance risk — expired licenses must be remediated immediately to avoid regulatory penalties."
    - name: "licenses_pending_primary_source_verification"
      expr: COUNT(DISTINCT CASE WHEN primary_source_verification_date IS NULL AND record_current_flag = TRUE THEN license_id END)
      comment: "Licenses lacking primary source verification. NCQA/URAC credentialing standards require PSV — gaps represent accreditation risk."
    - name: "avg_continuing_education_hours_required"
      expr: AVG(CAST(continuing_education_hours_required AS DOUBLE))
      comment: "Average continuing education hours required across licenses. Informs workforce development planning and credentialing program design."
    - name: "total_continuing_education_hours_required"
      expr: SUM(CAST(continuing_education_hours_required AS DOUBLE))
      comment: "Total continuing education hours required across all licenses. Used for workforce training capacity planning."
    - name: "providers_with_disciplinary_actions"
      expr: COUNT(DISTINCT CASE WHEN disciplinary_action_flag = TRUE THEN provider_id END)
      comment: "Distinct providers with at least one disciplinary action on record. Executive risk KPI for network quality and liability exposure."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_exclusion_sanctions`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider exclusion screening and compliance metrics tracking OIG/SAM exclusion results, screening frequency, and resolution actions. Used by compliance and credentialing teams to manage regulatory exclusion risk and CMS reporting obligations."
  source: "`vibe_health_insurance_v1`.`provider`.`exclusion_screening`"
  dimensions:
    - name: "screening_result"
      expr: screening_result
      comment: "Result of the exclusion screening (e.g. Clear, Match, Pending Review) for compliance status segmentation."
    - name: "exclusion_type"
      expr: exclusion_type
      comment: "Type of exclusion (e.g. OIG, SAM, State) for regulatory reporting categorization."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status of the screening record for executive risk dashboards."
    - name: "screening_source"
      expr: screening_source
      comment: "Source database used for screening (e.g. OIG LEIE, SAM.gov) for audit trail purposes."
    - name: "screening_method"
      expr: screening_method
      comment: "Method used for screening (e.g. Automated, Manual) for operational efficiency analysis."
    - name: "cms_reporting_flag"
      expr: cms_reporting_flag
      comment: "Whether this screening result requires CMS reporting — drives regulatory filing workload."
    - name: "state_reporting_flag"
      expr: state_reporting_flag
      comment: "Whether this screening result requires state-level reporting."
    - name: "audit_flag"
      expr: audit_flag
      comment: "Whether this record has been flagged for audit review."
    - name: "screening_year"
      expr: DATE_TRUNC('YEAR', screening_date)
      comment: "Year of screening for trend analysis and annual compliance reporting."
    - name: "screening_frequency"
      expr: screening_frequency
      comment: "Frequency at which this provider is screened (e.g. Monthly, Quarterly) for compliance program design."
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total exclusion screenings performed. Baseline compliance program activity metric used in regulatory audits."
    - name: "exclusion_matches"
      expr: COUNT(DISTINCT CASE WHEN screening_result = 'Match' THEN exclusion_screening_id END)
      comment: "Count of screenings resulting in an exclusion match. Critical compliance KPI — any match requires immediate network action and CMS reporting."
    - name: "providers_with_active_exclusions"
      expr: COUNT(DISTINCT CASE WHEN exclusion_effective_date IS NOT NULL AND (exclusion_end_date IS NULL OR exclusion_end_date > CURRENT_DATE) THEN provider_id END)
      comment: "Providers with currently active exclusions. Must be zero for CMS compliance — any value triggers emergency network termination."
    - name: "screenings_requiring_cms_reporting"
      expr: COUNT(DISTINCT CASE WHEN cms_reporting_flag = TRUE THEN exclusion_screening_id END)
      comment: "Screenings that require CMS reporting. Drives regulatory filing workload and compliance calendar management."
    - name: "screenings_pending_resolution"
      expr: COUNT(DISTINCT CASE WHEN screening_result = 'Match' AND resolution_date IS NULL THEN exclusion_screening_id END)
      comment: "Matched screenings without a recorded resolution. Operational backlog KPI — unresolved matches represent active compliance risk."
    - name: "providers_screened"
      expr: COUNT(DISTINCT provider_id)
      comment: "Total distinct providers screened. Used to calculate screening coverage rate against total network size."
    - name: "screenings_overdue"
      expr: COUNT(DISTINCT CASE WHEN next_screening_due_date < CURRENT_DATE THEN exclusion_screening_id END)
      comment: "Screenings past their due date. Compliance gap KPI — CMS requires monthly screening of all network providers."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_sanctions`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider sanction tracking metrics covering severity, reportability, and resolution status. Used by compliance and network management to monitor regulatory risk exposure and ensure timely remediation of sanctioned providers."
  source: "`vibe_health_insurance_v1`.`provider`.`sanction`"
  dimensions:
    - name: "sanction_type"
      expr: sanction_type
      comment: "Type of sanction (e.g. Exclusion, Suspension, Civil Monetary Penalty) for risk categorization."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the sanction for prioritizing remediation actions."
    - name: "cms_reportable_flag"
      expr: cms_reportable_flag
      comment: "Whether the sanction must be reported to CMS — drives regulatory filing obligations."
    - name: "ncqa_reportable_flag"
      expr: ncqa_reportable_flag
      comment: "Whether the sanction must be reported to NCQA — relevant for accreditation compliance."
    - name: "participation_impact"
      expr: participation_impact
      comment: "Impact of the sanction on network participation status (e.g. Terminated, Suspended, No Impact)."
    - name: "current_record_flag"
      expr: current_record_flag
      comment: "Whether this is the current active sanction record."
    - name: "notification_sent_flag"
      expr: notification_sent_flag
      comment: "Whether required notifications have been sent — compliance process adherence indicator."
    - name: "sanction_year"
      expr: DATE_TRUNC('YEAR', sanction_date)
      comment: "Year the sanction was issued for trend analysis."
    - name: "exclusion_waiver_flag"
      expr: exclusion_waiver_flag
      comment: "Whether a waiver has been granted for this exclusion — relevant for network continuity decisions."
  measures:
    - name: "total_active_sanctions"
      expr: COUNT(DISTINCT CASE WHEN current_record_flag = TRUE THEN sanction_id END)
      comment: "Total active sanctions across the provider network. Executive risk KPI — elevated values signal network quality and liability exposure."
    - name: "sanctions_requiring_cms_reporting"
      expr: COUNT(DISTINCT CASE WHEN cms_reportable_flag = TRUE THEN sanction_id END)
      comment: "Sanctions requiring CMS reporting. Drives regulatory filing workload and ensures CMS compliance obligations are met."
    - name: "sanctions_pending_notification"
      expr: COUNT(DISTINCT CASE WHEN notification_sent_flag = FALSE OR notification_sent_flag IS NULL THEN sanction_id END)
      comment: "Sanctions where required notifications have not been sent. Process compliance gap — unnotified sanctions create regulatory liability."
    - name: "sanctions_pending_resolution"
      expr: COUNT(DISTINCT CASE WHEN resolution_date IS NULL AND current_record_flag = TRUE THEN sanction_id END)
      comment: "Active sanctions without a recorded resolution. Operational backlog KPI driving compliance team prioritization."
    - name: "providers_with_active_sanctions"
      expr: COUNT(DISTINCT CASE WHEN current_record_flag = TRUE THEN provider_id END)
      comment: "Distinct providers with active sanctions. Network quality KPI used in board-level risk reporting."
    - name: "high_severity_sanctions"
      expr: COUNT(DISTINCT CASE WHEN severity_level IN ('High', 'Critical') THEN sanction_id END)
      comment: "Count of high or critical severity sanctions. Triggers immediate executive escalation and network action."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_participation_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider network participation status metrics tracking in-network composition, credentialing approval rates, and panel status by health plan and network. Used by network management and actuarial teams for adequacy reporting and plan design."
  source: "`vibe_health_insurance_v1`.`provider`.`participation_status`"
  dimensions:
    - name: "participation_status_name"
      expr: participation_status_name
      comment: "Human-readable participation status (e.g. Active In-Network, Terminated) for network composition analysis."
    - name: "participation_status_code"
      expr: participation_status_code
      comment: "Coded participation status for system-level filtering and reporting."
    - name: "network_tier_code"
      expr: network_tier_code
      comment: "Network tier (e.g. Tier 1, Tier 2) for tiered network design and member cost-sharing analysis."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business (e.g. Commercial, Medicare, Medicaid) for cross-LOB network adequacy analysis."
    - name: "pcp_flag"
      expr: pcp_flag
      comment: "Whether the provider serves as a PCP — critical for member attribution and access standard compliance."
    - name: "specialist_flag"
      expr: specialist_flag
      comment: "Whether the provider is a specialist — used for specialty network adequacy assessment."
    - name: "accepting_new_patients_flag"
      expr: accepting_new_patients_flag
      comment: "Whether the provider is accepting new patients — key access metric for member experience and adequacy."
    - name: "telehealth_enabled_flag"
      expr: telehealth_enabled_flag
      comment: "Whether the provider offers telehealth — relevant for access standard compliance and member convenience."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status at the participation level for compliance monitoring."
    - name: "current_record_flag"
      expr: current_record_flag
      comment: "Whether this is the current active participation record."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the participation became effective for cohort and trend analysis."
    - name: "regulatory_sanction_flag"
      expr: regulatory_sanction_flag
      comment: "Whether a regulatory sanction is associated with this participation record — risk signal."
  measures:
    - name: "total_active_participations"
      expr: COUNT(DISTINCT CASE WHEN current_record_flag = TRUE THEN participation_status_id END)
      comment: "Total active provider-network participation records. Core network size KPI for adequacy reporting and regulatory filings."
    - name: "providers_accepting_new_patients"
      expr: COUNT(DISTINCT CASE WHEN accepting_new_patients_flag = TRUE AND current_record_flag = TRUE THEN provider_id END)
      comment: "Providers currently accepting new patients. Access KPI — low values trigger network adequacy interventions and member complaints."
    - name: "pcp_providers_in_network"
      expr: COUNT(DISTINCT CASE WHEN pcp_flag = TRUE AND current_record_flag = TRUE THEN provider_id END)
      comment: "Active PCPs in the network. Critical adequacy metric — regulators mandate minimum PCP-to-member ratios."
    - name: "telehealth_enabled_providers"
      expr: COUNT(DISTINCT CASE WHEN telehealth_enabled_flag = TRUE AND current_record_flag = TRUE THEN provider_id END)
      comment: "Providers offering telehealth services. Strategic KPI for digital access strategy and member satisfaction."
    - name: "participations_with_regulatory_sanctions"
      expr: COUNT(DISTINCT CASE WHEN regulatory_sanction_flag = TRUE AND current_record_flag = TRUE THEN participation_status_id END)
      comment: "Active participations with regulatory sanctions. Compliance risk KPI — sanctioned providers in-network create CMS liability."
    - name: "terminated_participations"
      expr: COUNT(DISTINCT CASE WHEN termination_date IS NOT NULL AND termination_date <= CURRENT_DATE THEN participation_status_id END)
      comment: "Provider participations that have been terminated. Network attrition KPI used to assess retention and adequacy risk."
    - name: "credentialing_approved_participations"
      expr: COUNT(DISTINCT CASE WHEN credentialing_status = 'Approved' AND current_record_flag = TRUE THEN participation_status_id END)
      comment: "Participations with approved credentialing status. Credentialing throughput KPI for operations management."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_directory_accuracy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider directory verification metrics tracking accuracy, verification outcomes, and overdue verifications. Used by network operations and compliance teams to meet CMS and state directory accuracy mandates (e.g. 90-day verification cycles)."
  source: "`vibe_health_insurance_v1`.`provider`.`provider_directory_verification`"
  dimensions:
    - name: "verification_status"
      expr: verification_status
      comment: "Status of the directory verification (e.g. Verified, Failed, Pending) for accuracy monitoring."
    - name: "verification_outcome"
      expr: verification_outcome
      comment: "Outcome of the verification attempt (e.g. Confirmed, Updated, Unable to Reach) for operational analysis."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used for verification (e.g. Phone, Mail, Online Portal) for channel effectiveness analysis."
    - name: "current_record_flag"
      expr: current_record_flag
      comment: "Whether this is the current active verification record."
    - name: "verification_year"
      expr: DATE_TRUNC('YEAR', record_effective_date)
      comment: "Year of verification for trend and compliance cycle analysis."
    - name: "verification_quarter"
      expr: DATE_TRUNC('QUARTER', record_effective_date)
      comment: "Quarter of verification for quarterly compliance reporting cycles."
  measures:
    - name: "total_verifications"
      expr: COUNT(1)
      comment: "Total directory verifications performed. Baseline compliance activity metric for CMS directory accuracy reporting."
    - name: "successful_verifications"
      expr: COUNT(DISTINCT CASE WHEN verification_outcome = 'Confirmed' THEN provider_directory_verification_id END)
      comment: "Verifications resulting in confirmed accurate directory data. Numerator for directory accuracy rate calculation."
    - name: "failed_verifications"
      expr: COUNT(DISTINCT CASE WHEN verification_outcome IN ('Failed', 'Unable to Reach', 'Inaccurate') THEN provider_directory_verification_id END)
      comment: "Verifications resulting in failure or inaccuracy. Elevated values trigger directory update workflows and CMS penalty risk."
    - name: "providers_verified"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct providers with at least one verification record. Used to calculate verification coverage rate."
    - name: "verifications_overdue"
      expr: COUNT(DISTINCT CASE WHEN next_verification_date < CURRENT_DATE AND current_record_flag = TRUE THEN provider_directory_verification_id END)
      comment: "Verifications past their due date. CMS mandates 90-day verification cycles — overdue records represent regulatory non-compliance."
    - name: "providers_overdue_for_verification"
      expr: COUNT(DISTINCT CASE WHEN next_verification_date < CURRENT_DATE AND current_record_flag = TRUE THEN provider_id END)
      comment: "Distinct providers overdue for directory verification. Executive compliance KPI — CMS can impose fines for directory inaccuracy."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_npi_sync`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NPI registry synchronization metrics tracking data discrepancies, manual review backlog, and sync quality. Used by provider data management and compliance teams to maintain NPPES alignment and prevent claims adjudication failures."
  source: "`vibe_health_insurance_v1`.`provider`.`npi_registry_sync`"
  dimensions:
    - name: "sync_status"
      expr: sync_status
      comment: "Status of the NPI registry sync run (e.g. Success, Error, Partial) for data pipeline health monitoring."
    - name: "match_status"
      expr: match_status
      comment: "Match status between internal records and NPPES (e.g. Matched, Unmatched, Partial) for data quality analysis."
    - name: "address_discrepancy_flag"
      expr: address_discrepancy_flag
      comment: "Whether an address discrepancy was detected — impacts directory accuracy and claims routing."
    - name: "name_discrepancy_flag"
      expr: name_discrepancy_flag
      comment: "Whether a name discrepancy was detected — impacts provider identity matching and claims adjudication."
    - name: "taxonomy_discrepancy_flag"
      expr: taxonomy_discrepancy_flag
      comment: "Whether a taxonomy discrepancy was detected — impacts specialty routing and network adequacy calculations."
    - name: "credential_discrepancy_flag"
      expr: credential_discrepancy_flag
      comment: "Whether a credential discrepancy was detected — credentialing compliance risk signal."
    - name: "manual_review_required_flag"
      expr: manual_review_required_flag
      comment: "Whether manual review is required for this sync record — drives operational workload planning."
    - name: "directory_accuracy_impact_flag"
      expr: directory_accuracy_impact_flag
      comment: "Whether the discrepancy impacts directory accuracy — CMS compliance risk indicator."
    - name: "claims_submission_risk_flag"
      expr: claims_submission_risk_flag
      comment: "Whether the discrepancy creates claims submission risk — financial impact indicator."
    - name: "auto_applied_update_flag"
      expr: auto_applied_update_flag
      comment: "Whether the sync update was automatically applied — automation efficiency metric."
    - name: "sync_run_year"
      expr: DATE_TRUNC('YEAR', sync_run_date)
      comment: "Year of the sync run for trend analysis."
  measures:
    - name: "total_sync_records"
      expr: COUNT(1)
      comment: "Total NPI registry sync records processed. Baseline data pipeline activity metric."
    - name: "providers_with_any_discrepancy"
      expr: COUNT(DISTINCT CASE WHEN address_discrepancy_flag = TRUE OR name_discrepancy_flag = TRUE OR taxonomy_discrepancy_flag = TRUE OR credential_discrepancy_flag = TRUE THEN provider_id END)
      comment: "Providers with at least one NPPES discrepancy. Data quality KPI — high values indicate systemic provider data management issues."
    - name: "records_requiring_manual_review"
      expr: COUNT(DISTINCT CASE WHEN manual_review_required_flag = TRUE AND manual_review_completed_date IS NULL THEN npi_registry_sync_id END)
      comment: "Sync records requiring manual review that have not yet been completed. Operational backlog KPI for provider data team capacity planning."
    - name: "records_with_claims_submission_risk"
      expr: COUNT(DISTINCT CASE WHEN claims_submission_risk_flag = TRUE THEN npi_registry_sync_id END)
      comment: "Sync records flagged as creating claims submission risk. Financial risk KPI — unresolved records can cause claim denials and revenue loss."
    - name: "records_with_directory_accuracy_impact"
      expr: COUNT(DISTINCT CASE WHEN directory_accuracy_impact_flag = TRUE THEN npi_registry_sync_id END)
      comment: "Sync records impacting directory accuracy. CMS compliance KPI — directory inaccuracies trigger regulatory penalties."
    - name: "auto_applied_updates"
      expr: COUNT(DISTINCT CASE WHEN auto_applied_update_flag = TRUE THEN npi_registry_sync_id END)
      comment: "Sync updates automatically applied without manual intervention. Automation efficiency KPI for provider data operations."
    - name: "sync_error_records"
      expr: COUNT(DISTINCT CASE WHEN sync_status = 'Error' THEN npi_registry_sync_id END)
      comment: "Sync records with errors. Data pipeline reliability KPI — elevated error rates indicate integration issues requiring engineering intervention."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_specialty_mix`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider specialty composition and credentialing metrics tracking board certification rates, specialty mix, and credentialing cycle health. Used by network management and HEDIS reporting teams to assess specialty adequacy and quality."
  source: "`vibe_health_insurance_v1`.`provider`.`specialty`"
  dimensions:
    - name: "specialty_name"
      expr: specialty_name
      comment: "Name of the specialty for network composition and adequacy analysis."
    - name: "specialty_type"
      expr: specialty_type
      comment: "Type of specialty (e.g. Primary Care, Specialty, Subspecialty) for tiered adequacy assessment."
    - name: "specialty_category"
      expr: specialty_category
      comment: "Broad specialty category for network adequacy reporting and regulatory filings."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status for this specialty record — compliance monitoring."
    - name: "board_certified_flag"
      expr: board_certified_flag
      comment: "Whether the provider is board certified in this specialty — quality indicator."
    - name: "pcp_eligible_flag"
      expr: pcp_eligible_flag
      comment: "Whether this specialty qualifies the provider as a PCP — critical for member attribution."
    - name: "hedis_specialty_flag"
      expr: hedis_specialty_flag
      comment: "Whether this specialty is relevant for HEDIS measure calculation — quality reporting indicator."
    - name: "accepting_new_patients_flag"
      expr: accepting_new_patients_flag
      comment: "Whether the provider is accepting new patients in this specialty — access metric."
    - name: "telehealth_enabled_flag"
      expr: telehealth_enabled_flag
      comment: "Whether telehealth is available for this specialty — digital access metric."
    - name: "current_record_flag"
      expr: current_record_flag
      comment: "Whether this is the current active specialty record."
    - name: "network_adequacy_category"
      expr: network_adequacy_category
      comment: "Network adequacy category for this specialty — used in regulatory adequacy filings."
  measures:
    - name: "total_active_specialty_records"
      expr: COUNT(DISTINCT CASE WHEN current_record_flag = TRUE THEN specialty_id END)
      comment: "Total active specialty records across the provider network. Baseline specialty mix KPI for adequacy analysis."
    - name: "board_certified_providers"
      expr: COUNT(DISTINCT CASE WHEN board_certified_flag = TRUE AND current_record_flag = TRUE THEN provider_id END)
      comment: "Providers with board certification in their specialty. Quality KPI — board certification rates are reported to NCQA and used in plan marketing."
    - name: "providers_accepting_new_patients_by_specialty"
      expr: COUNT(DISTINCT CASE WHEN accepting_new_patients_flag = TRUE AND current_record_flag = TRUE THEN provider_id END)
      comment: "Providers accepting new patients by specialty. Access adequacy KPI — low values in key specialties trigger network recruitment actions."
    - name: "hedis_relevant_specialty_providers"
      expr: COUNT(DISTINCT CASE WHEN hedis_specialty_flag = TRUE AND current_record_flag = TRUE THEN provider_id END)
      comment: "Providers in HEDIS-relevant specialties. Quality program KPI — adequate HEDIS specialty coverage is required for star ratings."
    - name: "specialties_with_expired_credentialing"
      expr: COUNT(DISTINCT CASE WHEN credentialing_status = 'Expired' AND current_record_flag = TRUE THEN specialty_id END)
      comment: "Specialty records with expired credentialing. Compliance risk KPI — expired credentialing in active specialties creates liability."
    - name: "pcp_eligible_providers"
      expr: COUNT(DISTINCT CASE WHEN pcp_eligible_flag = TRUE AND current_record_flag = TRUE THEN provider_id END)
      comment: "Providers eligible to serve as PCPs. Critical adequacy metric — regulators mandate minimum PCP-to-member ratios."
    - name: "telehealth_enabled_specialty_providers"
      expr: COUNT(DISTINCT CASE WHEN telehealth_enabled_flag = TRUE AND current_record_flag = TRUE THEN provider_id END)
      comment: "Providers offering telehealth in their specialty. Strategic access KPI for digital health program design."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility network metrics tracking accreditation status, credentialing health, and facility capabilities. Used by network management and compliance teams to manage facility contracting, adequacy, and quality reporting."
  source: "`vibe_health_insurance_v1`.`provider`.`facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (e.g. Hospital, SNF, ASC, Urgent Care) for network composition analysis."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status of the facility for compliance monitoring."
    - name: "participation_status"
      expr: participation_status
      comment: "Network participation status of the facility."
    - name: "accreditation_body"
      expr: accreditation_body
      comment: "Accrediting body (e.g. The Joint Commission, DNV) for quality tier analysis."
    - name: "state_code"
      expr: state_code
      comment: "State where the facility is located for geographic adequacy analysis."
    - name: "emergency_services_flag"
      expr: emergency_services_flag
      comment: "Whether the facility provides emergency services — critical for network adequacy and member access."
    - name: "critical_access_hospital_flag"
      expr: critical_access_hospital_flag
      comment: "Whether the facility is a Critical Access Hospital — relevant for rural adequacy and CMS reimbursement."
    - name: "teaching_hospital_flag"
      expr: teaching_hospital_flag
      comment: "Whether the facility is a teaching hospital — quality and cost indicator."
    - name: "telehealth_enabled_flag"
      expr: telehealth_enabled_flag
      comment: "Whether the facility offers telehealth services."
    - name: "medicare_certified_flag"
      expr: medicare_certified_flag
      comment: "Whether the facility is Medicare certified — required for Medicare Advantage network participation."
    - name: "medicaid_certified_flag"
      expr: medicaid_certified_flag
      comment: "Whether the facility is Medicaid certified — required for Medicaid managed care network participation."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (e.g. Non-Profit, For-Profit, Government) for contracting strategy analysis."
  measures:
    - name: "total_facilities"
      expr: COUNT(DISTINCT facility_id)
      comment: "Total facilities in the network. Baseline facility network size KPI for adequacy reporting."
    - name: "active_credentialed_facilities"
      expr: COUNT(DISTINCT CASE WHEN credentialing_status = 'Active' THEN facility_id END)
      comment: "Facilities with active credentialing status. Compliance KPI — all contracted facilities must maintain active credentialing."
    - name: "facilities_with_emergency_services"
      expr: COUNT(DISTINCT CASE WHEN emergency_services_flag = TRUE THEN facility_id END)
      comment: "Facilities providing emergency services. Network adequacy KPI — regulators mandate minimum emergency service access within geographic standards."
    - name: "facilities_with_expiring_accreditation"
      expr: COUNT(DISTINCT CASE WHEN accreditation_expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN facility_id END)
      comment: "Facilities with accreditation expiring within 90 days. Operational KPI driving credentialing renewal outreach."
    - name: "avg_facility_quality_rating"
      expr: AVG(CAST(quality_rating AS DOUBLE))
      comment: "Average quality rating across network facilities. Strategic KPI for network quality management and member communication."
    - name: "medicare_certified_facilities"
      expr: COUNT(DISTINCT CASE WHEN medicare_certified_flag = TRUE THEN facility_id END)
      comment: "Medicare-certified facilities in the network. Required for Medicare Advantage adequacy filings."
    - name: "facilities_with_credentialing_expiring_90_days"
      expr: COUNT(DISTINCT CASE WHEN credentialing_expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN facility_id END)
      comment: "Facilities with credentialing expiring within 90 days. Proactive compliance KPI to prevent credentialing lapses."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_outreach_effectiveness`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider outreach effectiveness metrics tracking contact rates, attestation completion, and data verification outcomes. Used by provider relations and directory compliance teams to manage outreach campaigns and meet CMS directory accuracy requirements."
  source: "`vibe_health_insurance_v1`.`provider`.`provider_outreach`"
  dimensions:
    - name: "provider_outreach_type"
      expr: provider_outreach_type
      comment: "Type of outreach (e.g. Directory Verification, Credentialing, Attestation) for campaign effectiveness analysis."
    - name: "provider_outreach_status"
      expr: provider_outreach_status
      comment: "Status of the outreach record (e.g. Complete, Pending, Failed) for pipeline monitoring."
    - name: "method"
      expr: method
      comment: "Outreach method (e.g. Phone, Email, Mail) for channel effectiveness analysis."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the outreach attempt for conversion and effectiveness measurement."
    - name: "contact_reached_flag"
      expr: contact_reached_flag
      comment: "Whether the provider contact was successfully reached — contact rate numerator."
    - name: "attestation_received_flag"
      expr: attestation_received_flag
      comment: "Whether attestation was received — CMS directory compliance completion indicator."
    - name: "data_verified_flag"
      expr: data_verified_flag
      comment: "Whether provider data was verified during the outreach — directory accuracy outcome."
    - name: "data_updated_flag"
      expr: data_updated_flag
      comment: "Whether provider data was updated as a result of outreach — data quality improvement indicator."
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Whether follow-up is required — drives outreach workload forecasting."
    - name: "compliance_quarter"
      expr: compliance_quarter
      comment: "Compliance quarter for which the outreach was performed — regulatory cycle tracking."
    - name: "outreach_year"
      expr: DATE_TRUNC('YEAR', provider_outreach_date)
      comment: "Year of outreach for trend analysis."
    - name: "current_record_flag"
      expr: current_record_flag
      comment: "Whether this is the current active outreach record."
  measures:
    - name: "total_outreach_attempts"
      expr: COUNT(1)
      comment: "Total outreach attempts performed. Baseline activity metric for provider relations capacity planning."
    - name: "providers_contacted"
      expr: COUNT(DISTINCT CASE WHEN contact_reached_flag = TRUE THEN provider_id END)
      comment: "Distinct providers successfully contacted. Contact coverage KPI for CMS directory verification compliance."
    - name: "attestations_received"
      expr: COUNT(DISTINCT CASE WHEN attestation_received_flag = TRUE THEN provider_outreach_id END)
      comment: "Outreach records where attestation was received. CMS compliance KPI — attestation completion rates are reported to regulators."
    - name: "data_verifications_completed"
      expr: COUNT(DISTINCT CASE WHEN data_verified_flag = TRUE THEN provider_outreach_id END)
      comment: "Outreach records resulting in verified provider data. Directory accuracy KPI for CMS compliance."
    - name: "data_updates_triggered"
      expr: COUNT(DISTINCT CASE WHEN data_updated_flag = TRUE THEN provider_outreach_id END)
      comment: "Outreach records resulting in data updates. Data quality improvement KPI — high values indicate directory was previously inaccurate."
    - name: "outreach_requiring_follow_up"
      expr: COUNT(DISTINCT CASE WHEN follow_up_required_flag = TRUE THEN provider_outreach_id END)
      comment: "Outreach records requiring follow-up. Operational backlog KPI for provider relations team workload management."
    - name: "providers_with_directory_removal_flagged"
      expr: COUNT(DISTINCT CASE WHEN directory_removal_flag = TRUE THEN provider_id END)
      comment: "Providers flagged for directory removal during outreach. Network attrition signal requiring immediate network management action."
$$;