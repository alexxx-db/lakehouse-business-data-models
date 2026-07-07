-- Metric views for domain: provider | Business: Health Insurance | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_audit_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring provider audit program performance, completion rates, and corrective action outcomes. Used by Compliance and Network Management to oversee provider audit program effectiveness and regulatory risk remediation."
  source: "`vibe_health_insurance_v1`.`provider`.`audit_assignment`"
  dimensions:
    - name: "audit_status_code"
      expr: audit_status_code
      comment: "Standardized audit status code (e.g., Assigned, In Progress, Completed, Overdue) — primary dimension for audit pipeline management."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., Credentialing, Billing, Quality, Compliance) — used to analyze audit outcomes by audit category."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Indicates whether a corrective action plan is required — used to track remediation workload from audit findings."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the audit assignment — used to ensure high-priority audits are completed on time."
    - name: "assigned_date_month"
      expr: DATE_TRUNC('month', assigned_date)
      comment: "Month of audit assignment — used to track audit program cadence and workload distribution."
    - name: "is_active"
      expr: is_active
      comment: "Current active record flag — filters to current audit assignments."
  measures:
    - name: "total_audit_assignments"
      expr: COUNT(1)
      comment: "Total number of provider audit assignments. Baseline measure for audit program scope and workload."
    - name: "completed_audit_count"
      expr: COUNT(CASE WHEN audit_status_code = 'Completed' THEN audit_assignment_id END)
      comment: "Number of completed provider audits. Core audit program throughput KPI used to assess program execution capacity."
    - name: "audit_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN audit_status_code = 'Completed' THEN audit_assignment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audit assignments completed. Low completion rates signal resource constraints or process failures in the audit program."
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN audit_assignment_id END) / NULLIF(COUNT(CASE WHEN audit_status_code = 'Completed' THEN audit_assignment_id END), 0), 2)
      comment: "Percentage of completed audits requiring corrective action. High rates indicate systemic provider compliance issues requiring strategic intervention."
    - name: "overdue_audit_count"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE AND audit_status_code != 'Completed' THEN audit_assignment_id END)
      comment: "Number of audit assignments past their due date and not yet completed. Overdue audits create regulatory exposure — a key operational risk KPI."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score across completed provider audits. Composite provider quality indicator used in network retention and contracting decisions."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_directory_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider directory entry metrics tracking verification status, attestation compliance, and directory accuracy for member access and regulatory compliance."
  source: "`vibe_health_insurance_v1`.`provider`.`directory_entry`"
  dimensions:
    - name: "participation_status"
      expr: participation_status
      comment: "Network participation status in the directory"
    - name: "attestation_status"
      expr: attestation_status
      comment: "Status of provider attestation for directory accuracy"
    - name: "attestation_method"
      expr: attestation_method
      comment: "Method used for provider attestation"
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier displayed in the directory"
    - name: "provider_type"
      expr: provider_type
      comment: "Type of provider in the directory"
    - name: "accepting_new_patients_flag"
      expr: accepting_new_patients_flag
      comment: "Whether the provider is accepting new patients"
    - name: "pcp_flag"
      expr: pcp_flag
      comment: "Whether the provider is designated as a primary care provider"
    - name: "telehealth_available_flag"
      expr: telehealth_available_flag
      comment: "Whether telehealth services are available"
    - name: "practice_state"
      expr: practice_state
      comment: "State where the practice is located"
    - name: "practice_county"
      expr: practice_county
      comment: "County where the practice is located"
    - name: "gender"
      expr: gender
      comment: "Provider gender displayed in directory"
    - name: "is_active"
      expr: is_active
      comment: "Whether the directory entry is currently active"
    - name: "publication_year"
      expr: YEAR(directory_publication_date)
      comment: "Year the directory was published"
    - name: "publication_month"
      expr: DATE_TRUNC('MONTH', directory_publication_date)
      comment: "Month the directory was published"
  measures:
    - name: "total_directory_entries"
      expr: COUNT(DISTINCT directory_entry_id)
      comment: "Total unique provider directory entries"
    - name: "active_directory_entries"
      expr: COUNT(DISTINCT CASE WHEN is_active = 'true' THEN directory_entry_id END)
      comment: "Count of active directory entries available to members"
    - name: "accepting_new_patients_count"
      expr: COUNT(DISTINCT CASE WHEN accepting_new_patients_flag = true THEN directory_entry_id END)
      comment: "Count of providers accepting new patients, critical for member access and network adequacy"
    - name: "pcp_directory_count"
      expr: COUNT(DISTINCT CASE WHEN pcp_flag = true THEN directory_entry_id END)
      comment: "Count of primary care providers in directory, key metric for network adequacy"
    - name: "telehealth_enabled_count"
      expr: COUNT(DISTINCT CASE WHEN telehealth_available_flag = true THEN directory_entry_id END)
      comment: "Count of providers offering telehealth, important for virtual care access"
    - name: "attested_entry_count"
      expr: COUNT(DISTINCT CASE WHEN attestation_status = 'Attested' THEN directory_entry_id END)
      comment: "Count of directory entries with completed attestation, key compliance metric for directory accuracy"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_exclusion_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring provider exclusion screening outcomes, compliance rates, and regulatory risk exposure. Used by Compliance and Network Management to ensure no excluded providers are active in the network — a CMS and OIG mandatory requirement."
  source: "`vibe_health_insurance_v1`.`provider`.`exclusion_screening`"
  dimensions:
    - name: "screening_result"
      expr: screening_result
      comment: "Outcome of the exclusion screening (e.g., Clear, Match Found, Pending Review) — primary dimension for risk segmentation."
    - name: "exclusion_type"
      expr: exclusion_type
      comment: "Type of exclusion identified (e.g., OIG, SAM, State) — used to categorize regulatory risk by exclusion source."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status of the screening record — used to track resolution of identified exclusions."
    - name: "cms_reporting_flag"
      expr: cms_reporting_flag
      comment: "Indicates whether the exclusion is reportable to CMS — critical for regulatory reporting compliance."
    - name: "state_reporting_flag"
      expr: state_reporting_flag
      comment: "Indicates whether the exclusion is reportable to state regulators — used for state-level compliance tracking."
    - name: "screening_date_month"
      expr: DATE_TRUNC('month', screening_date)
      comment: "Month of screening — enables trend analysis of screening volume and match rates over time."
    - name: "screening_source"
      expr: screening_source
      comment: "Source database used for screening (e.g., OIG LEIE, SAM.gov) — used to assess coverage and completeness of screening program."
    - name: "is_active"
      expr: is_active
      comment: "Current active record flag — filters to current screening records."
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total number of exclusion screening records. Baseline measure for screening program activity — regulators expect 100% coverage of active providers."
    - name: "exclusion_match_count"
      expr: COUNT(CASE WHEN screening_result = 'Match Found' THEN exclusion_screening_id END)
      comment: "Number of screenings resulting in an exclusion match. Each match represents a critical compliance risk — excluded providers must be immediately removed from the network."
    - name: "exclusion_match_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN screening_result = 'Match Found' THEN exclusion_screening_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings resulting in an exclusion match. Tracks network contamination risk — any non-zero rate triggers immediate executive and legal review."
    - name: "cms_reportable_exclusion_count"
      expr: COUNT(CASE WHEN cms_reporting_flag = TRUE THEN exclusion_screening_id END)
      comment: "Number of exclusions that must be reported to CMS. Directly measures regulatory reporting obligation volume — failure to report carries significant financial penalties."
    - name: "unresolved_exclusion_count"
      expr: COUNT(CASE WHEN screening_result = 'Match Found' AND compliance_status != 'Resolved' THEN exclusion_screening_id END)
      comment: "Number of exclusion matches not yet resolved. Unresolved exclusions represent active regulatory liability — a key operational risk KPI for the Compliance Officer."
    - name: "audit_flagged_count"
      expr: COUNT(CASE WHEN audit_flag = TRUE THEN exclusion_screening_id END)
      comment: "Number of screening records flagged for audit. Indicates the volume of cases requiring additional scrutiny — used to size compliance audit workload."
    - name: "overdue_screening_count"
      expr: COUNT(CASE WHEN next_screening_due_date < CURRENT_DATE AND is_active = TRUE THEN exclusion_screening_id END)
      comment: "Number of providers with overdue exclusion screenings. Overdue screenings create regulatory exposure — CMS requires periodic re-screening of all network providers."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility metrics tracking bed capacity, accreditation status, emergency services availability, and quality ratings for network adequacy and care delivery planning."
  source: "`vibe_health_insurance_v1`.`provider`.`facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (e.g., hospital, clinic, surgery center)"
    - name: "participation_status"
      expr: participation_status
      comment: "Network participation status of the facility"
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status of the facility"
    - name: "state_code"
      expr: state_code
      comment: "State where the facility is located"
    - name: "county_name"
      expr: county_name
      comment: "County where the facility is located"
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier assignment"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type of the facility"
    - name: "emergency_services_flag"
      expr: emergency_services_flag
      comment: "Whether the facility provides emergency services"
    - name: "teaching_hospital_flag"
      expr: teaching_hospital_flag
      comment: "Whether the facility is a teaching hospital"
    - name: "critical_access_hospital_flag"
      expr: critical_access_hospital_flag
      comment: "Whether the facility is designated as a critical access hospital"
    - name: "trauma_level"
      expr: trauma_level
      comment: "Trauma center designation level"
    - name: "medicare_certified_flag"
      expr: medicare_certified_flag
      comment: "Whether the facility is Medicare certified"
    - name: "medicaid_certified_flag"
      expr: medicaid_certified_flag
      comment: "Whether the facility is Medicaid certified"
    - name: "is_active"
      expr: is_active
      comment: "Whether the facility record is currently active"
  measures:
    - name: "total_facilities"
      expr: COUNT(DISTINCT facility_id)
      comment: "Total unique facilities in the network"
    - name: "active_facility_count"
      expr: COUNT(DISTINCT CASE WHEN is_active = 'true' THEN facility_id END)
      comment: "Count of active facilities available for member access"
    - name: "emergency_services_facility_count"
      expr: COUNT(DISTINCT CASE WHEN emergency_services_flag = true THEN facility_id END)
      comment: "Count of facilities providing emergency services, critical for network adequacy"
    - name: "total_bed_count"
      expr: SUM(CAST(bed_count AS DOUBLE))
      comment: "Total bed capacity across all facilities, key metric for utilization management and capacity planning"
    - name: "avg_quality_rating"
      expr: AVG(CAST(quality_rating AS DOUBLE))
      comment: "Average quality rating across facilities, used for network quality assessment and steering"
    - name: "critical_access_hospital_count"
      expr: COUNT(DISTINCT CASE WHEN critical_access_hospital_flag = true THEN facility_id END)
      comment: "Count of critical access hospitals, important for rural access and regulatory compliance"
    - name: "teaching_hospital_count"
      expr: COUNT(DISTINCT CASE WHEN teaching_hospital_flag = true THEN facility_id END)
      comment: "Count of teaching hospitals, relevant for quality and academic affiliation strategies"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider license metrics tracking expiration risk, disciplinary actions, and primary source verification compliance for credentialing and regulatory risk management."
  source: "`vibe_health_insurance_v1`.`provider`.`license`"
  dimensions:
    - name: "license_type"
      expr: license_type
      comment: "Type of professional license"
    - name: "license_status"
      expr: license_status
      comment: "Current status of the license"
    - name: "issuing_state"
      expr: issuing_state
      comment: "State that issued the license"
    - name: "compact_type"
      expr: compact_type
      comment: "Type of interstate compact participation"
    - name: "compact_participation_flag"
      expr: compact_participation_flag
      comment: "Whether the license participates in an interstate compact"
    - name: "disciplinary_action_flag"
      expr: disciplinary_action_flag
      comment: "Whether there is a disciplinary action on record"
    - name: "continuing_education_required_flag"
      expr: continuing_education_required_flag
      comment: "Whether continuing education is required for this license"
    - name: "telemedicine_authorized_flag"
      expr: telemedicine_authorized_flag
      comment: "Whether the license authorizes telemedicine practice"
    - name: "is_active"
      expr: is_active
      comment: "Whether the license record is currently active"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the license expires"
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month the license expires"
  measures:
    - name: "total_licenses"
      expr: COUNT(DISTINCT license_id)
      comment: "Total unique provider licenses on record"
    - name: "active_license_count"
      expr: COUNT(DISTINCT CASE WHEN license_status = 'Active' THEN license_id END)
      comment: "Count of active licenses, critical for provider eligibility and claims adjudication"
    - name: "disciplinary_action_count"
      expr: COUNT(DISTINCT CASE WHEN disciplinary_action_flag = true THEN license_id END)
      comment: "Count of licenses with disciplinary actions, key risk indicator for credentialing and compliance"
    - name: "compact_license_count"
      expr: COUNT(DISTINCT CASE WHEN compact_participation_flag = true THEN license_id END)
      comment: "Count of licenses participating in interstate compacts, relevant for multi-state network strategies"
    - name: "telemedicine_authorized_count"
      expr: COUNT(DISTINCT CASE WHEN telemedicine_authorized_flag = true THEN license_id END)
      comment: "Count of licenses authorized for telemedicine, critical for virtual care network adequacy"
    - name: "avg_continuing_education_hours_required"
      expr: AVG(CAST(continuing_education_hours_required AS DOUBLE))
      comment: "Average continuing education hours required across licenses"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_license_management`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring provider license status, expiration risk, and primary source verification compliance. Used by Credentialing and Network Management to prevent lapsed licenses from creating network adequacy and regulatory violations."
  source: "`vibe_health_insurance_v1`.`provider`.`license`"
  dimensions:
    - name: "license_status"
      expr: license_status
      comment: "Current status of the provider license (e.g., Active, Expired, Suspended) — primary dimension for license health monitoring."
    - name: "license_type"
      expr: license_type
      comment: "Type of license (e.g., MD, DO, NP, PA) — used to analyze credentialing requirements by provider type."
    - name: "issuing_state"
      expr: issuing_state
      comment: "State that issued the license — used for geographic compliance analysis and compact privilege tracking."
    - name: "compact_participation_flag"
      expr: compact_participation_flag
      comment: "Indicates participation in interstate compact (e.g., NLC, IMLC) — tracks multi-state practice eligibility."
    - name: "disciplinary_action_flag"
      expr: disciplinary_action_flag
      comment: "Indicates whether a disciplinary action is on record — critical risk flag for credentialing decisions."
    - name: "continuing_education_required_flag"
      expr: continuing_education_required_flag
      comment: "Indicates whether continuing education is required for renewal — used to track CE compliance risk."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month of license expiration — used to forecast upcoming renewal workload and prevent lapses."
    - name: "is_active"
      expr: is_active
      comment: "Current active record flag — filters to current license records."
  measures:
    - name: "total_licenses"
      expr: COUNT(1)
      comment: "Total number of provider license records. Baseline measure for credentialing program scope."
    - name: "active_license_count"
      expr: COUNT(CASE WHEN license_status = 'Active' AND is_active = TRUE THEN license_id END)
      comment: "Number of currently active provider licenses. Core credentialing KPI — active licenses are a prerequisite for network participation and claims payment."
    - name: "expired_license_count"
      expr: COUNT(CASE WHEN license_status = 'Expired' THEN license_id END)
      comment: "Number of expired provider licenses. Expired licenses create immediate network adequacy and regulatory risk — triggers credentialing team intervention."
    - name: "license_expiration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN license_status = 'Expired' THEN license_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of licenses in expired status. A rising expiration rate signals credentialing process failures and regulatory exposure."
    - name: "disciplinary_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN disciplinary_action_flag = TRUE THEN license_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of licenses with disciplinary actions on record. Disciplinary actions affect provider network eligibility and create liability — a key quality and risk KPI."
    - name: "licenses_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) AND license_status = 'Active' THEN license_id END)
      comment: "Number of active licenses expiring within the next 90 days. Forward-looking risk metric used to prioritize renewal outreach and prevent network adequacy gaps."
    - name: "primary_source_verification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN primary_source_verification_date IS NOT NULL THEN license_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of licenses with completed primary source verification. NCQA and URAC credentialing standards require PSV — this KPI measures accreditation compliance."
    - name: "avg_continuing_education_hours_required"
      expr: AVG(CAST(continuing_education_hours_required AS DOUBLE))
      comment: "Average continuing education hours required across licenses. Used to assess CE compliance burden and forecast renewal workload by provider type."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_npi_registry_sync`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NPI registry synchronization metrics tracking NPPES data discrepancies, sync status, and data quality for provider directory accuracy and claims submission integrity."
  source: "`vibe_health_insurance_v1`.`provider`.`npi_registry_sync`"
  dimensions:
    - name: "sync_status"
      expr: sync_status
      comment: "Status of NPI sync operation for pipeline monitoring."
    - name: "match_status"
      expr: match_status
      comment: "NPI match status for data quality tracking."
    - name: "sync_source"
      expr: sync_source
      comment: "Source of sync data for data lineage."
    - name: "name_discrepancy_flag"
      expr: CAST(name_discrepancy_flag AS STRING)
      comment: "Whether name discrepancy exists for data quality flagging."
    - name: "address_discrepancy_flag"
      expr: CAST(address_discrepancy_flag AS STRING)
      comment: "Whether address discrepancy exists for directory accuracy."
    - name: "taxonomy_discrepancy_flag"
      expr: CAST(taxonomy_discrepancy_flag AS STRING)
      comment: "Whether taxonomy discrepancy exists for specialty accuracy."
    - name: "credential_discrepancy_flag"
      expr: CAST(credential_discrepancy_flag AS STRING)
      comment: "Whether credential discrepancy exists for credentialing accuracy."
    - name: "manual_review_required_flag"
      expr: CAST(manual_review_required_flag AS STRING)
      comment: "Whether manual review is required for workload tracking."
    - name: "claims_submission_risk_flag"
      expr: CAST(claims_submission_risk_flag AS STRING)
      comment: "Whether claims submission risk exists for revenue cycle impact."
    - name: "sync_run_year"
      expr: YEAR(sync_run_date)
      comment: "Year of sync run for trend analysis."
  measures:
    - name: "total_sync_records"
      expr: COUNT(1)
      comment: "Total NPI sync records for volume tracking."
    - name: "distinct_synced_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct providers synced for coverage tracking."
    - name: "name_discrepancy_count"
      expr: COUNT(CASE WHEN name_discrepancy_flag = TRUE THEN 1 END)
      comment: "Count of name discrepancies for data quality remediation."
    - name: "address_discrepancy_count"
      expr: COUNT(CASE WHEN address_discrepancy_flag = TRUE THEN 1 END)
      comment: "Count of address discrepancies for directory accuracy remediation."
    - name: "taxonomy_discrepancy_count"
      expr: COUNT(CASE WHEN taxonomy_discrepancy_flag = TRUE THEN 1 END)
      comment: "Count of taxonomy discrepancies for specialty accuracy."
    - name: "manual_review_required_count"
      expr: COUNT(CASE WHEN manual_review_required_flag = TRUE THEN 1 END)
      comment: "Count of records requiring manual review for workload planning."
    - name: "claims_risk_count"
      expr: COUNT(CASE WHEN claims_submission_risk_flag = TRUE THEN 1 END)
      comment: "Count of records with claims submission risk for revenue cycle protection."
    - name: "any_discrepancy_count"
      expr: COUNT(CASE WHEN name_discrepancy_flag = TRUE OR address_discrepancy_flag = TRUE OR taxonomy_discrepancy_flag = TRUE OR credential_discrepancy_flag = TRUE THEN 1 END)
      comment: "Count of records with any discrepancy for overall data quality monitoring."
    - name: "auto_applied_update_count"
      expr: COUNT(CASE WHEN auto_applied_update_flag = TRUE THEN 1 END)
      comment: "Count of auto-applied updates for automation effectiveness tracking."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_npi_sync_quality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring NPI registry synchronization quality, discrepancy rates, and data accuracy between internal provider records and NPPES. Used by Network Management and Data Governance to maintain directory accuracy and prevent claims submission failures."
  source: "`vibe_health_insurance_v1`.`provider`.`npi_registry_sync`"
  dimensions:
    - name: "sync_status"
      expr: sync_status
      comment: "Status of the NPI registry sync (e.g., Matched, Discrepancy Found, Deactivated) — primary dimension for sync health monitoring."
    - name: "match_status"
      expr: match_status
      comment: "Match status between internal records and NPPES (e.g., Exact Match, Partial Match, No Match) — used to assess data alignment quality."
    - name: "address_discrepancy_flag"
      expr: address_discrepancy_flag
      comment: "Indicates an address discrepancy between internal records and NPPES — used to identify directory accuracy issues."
    - name: "name_discrepancy_flag"
      expr: name_discrepancy_flag
      comment: "Indicates a name discrepancy between internal records and NPPES — used to identify credentialing data quality issues."
    - name: "taxonomy_discrepancy_flag"
      expr: taxonomy_discrepancy_flag
      comment: "Indicates a taxonomy/specialty discrepancy between internal records and NPPES — used to identify specialty data quality issues."
    - name: "manual_review_required_flag"
      expr: manual_review_required_flag
      comment: "Indicates whether manual review is required to resolve discrepancies — used to manage data quality workload."
    - name: "claims_submission_risk_flag"
      expr: claims_submission_risk_flag
      comment: "Indicates whether the discrepancy creates claims submission risk — highest priority flag for revenue cycle protection."
    - name: "sync_run_date_month"
      expr: DATE_TRUNC('month', sync_run_date)
      comment: "Month of NPI registry sync run — used to track sync program cadence and discrepancy trends over time."
    - name: "is_active"
      expr: is_active
      comment: "Current active record flag — filters to current sync records."
  measures:
    - name: "total_npi_sync_records"
      expr: COUNT(1)
      comment: "Total number of NPI registry sync records. Baseline measure for sync program coverage."
    - name: "discrepancy_count"
      expr: COUNT(CASE WHEN address_discrepancy_flag = TRUE OR name_discrepancy_flag = TRUE OR taxonomy_discrepancy_flag = TRUE OR credential_discrepancy_flag = TRUE THEN npi_registry_sync_id END)
      comment: "Number of NPI sync records with any type of discrepancy. Core data quality KPI — discrepancies create directory inaccuracy and claims risk."
    - name: "overall_discrepancy_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN address_discrepancy_flag = TRUE OR name_discrepancy_flag = TRUE OR taxonomy_discrepancy_flag = TRUE OR credential_discrepancy_flag = TRUE THEN npi_registry_sync_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NPI sync records with any discrepancy. Rising discrepancy rates signal data governance failures — a key data quality KPI for the CDO."
    - name: "claims_submission_risk_count"
      expr: COUNT(CASE WHEN claims_submission_risk_flag = TRUE THEN npi_registry_sync_id END)
      comment: "Number of NPI discrepancies creating claims submission risk. Directly tied to revenue cycle risk — each unresolved case can result in claim denials."
    - name: "manual_review_pending_count"
      expr: COUNT(CASE WHEN manual_review_required_flag = TRUE AND manual_review_completed_date IS NULL THEN npi_registry_sync_id END)
      comment: "Number of NPI sync records requiring manual review that have not yet been completed. Operational workload KPI for data quality team capacity planning."
    - name: "auto_applied_update_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_applied_update_flag = TRUE THEN npi_registry_sync_id END) / NULLIF(COUNT(CASE WHEN address_discrepancy_flag = TRUE OR name_discrepancy_flag = TRUE OR taxonomy_discrepancy_flag = TRUE THEN npi_registry_sync_id END), 0), 2)
      comment: "Percentage of discrepancies resolved via automated update. Measures automation efficiency in the NPI sync process — higher rates reduce manual workload and resolution time."
    - name: "directory_accuracy_impact_count"
      expr: COUNT(CASE WHEN directory_accuracy_impact_flag = TRUE THEN npi_registry_sync_id END)
      comment: "Number of NPI discrepancies with direct impact on directory accuracy. Directly tied to CMS directory accuracy compliance — a regulatory reporting KPI."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_credentialing_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring provider regulatory obligation compliance status, remediation rates, and compliance scoring. Used by Compliance Officers and Network Management to manage provider credentialing obligations and regulatory risk."
  source: "`vibe_health_insurance_v1`.`provider`.`obligation_compliance`"
  dimensions:
    - name: "compliance_status_code"
      expr: compliance_status_code
      comment: "Standardized compliance status code (e.g., Compliant, Non-Compliant, Pending) — primary dimension for compliance health segmentation."
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory obligation (e.g., Credentialing, Licensing, Exclusion Screening) — used to identify which obligation categories drive non-compliance."
    - name: "finding_severity_code"
      expr: finding_severity_code
      comment: "Severity of compliance finding (e.g., Critical, Major, Minor) — used to prioritize remediation efforts and escalation decisions."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Indicates whether a corrective action plan is required — used to track remediation workload and regulatory exposure."
    - name: "is_active"
      expr: is_active
      comment: "Current active record flag — filters to current compliance assessments."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month of compliance assessment — enables trend analysis of compliance posture over time."
    - name: "obligation_category"
      expr: obligation_category
      comment: "High-level category of the obligation — used for executive-level compliance reporting by category."
  measures:
    - name: "total_compliance_assessments"
      expr: COUNT(1)
      comment: "Total number of provider compliance assessments. Baseline measure for compliance program activity volume."
    - name: "compliant_provider_obligations"
      expr: COUNT(CASE WHEN compliance_status_code = 'Compliant' THEN obligation_compliance_id END)
      comment: "Count of provider obligations assessed as compliant. Core compliance health KPI used by Compliance Officers to report regulatory standing."
    - name: "non_compliant_provider_obligations"
      expr: COUNT(CASE WHEN compliance_status_code = 'Non-Compliant' THEN obligation_compliance_id END)
      comment: "Count of provider obligations assessed as non-compliant. Directly triggers regulatory risk escalation and corrective action planning."
    - name: "compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status_code = 'Compliant' THEN obligation_compliance_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of provider obligations in compliant status. Primary compliance health KPI reported to the Board and regulators — a drop triggers immediate investigation."
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN obligation_compliance_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments requiring corrective action. High rates signal systemic compliance failures requiring resource reallocation."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across all provider obligation assessments. Composite quality indicator used in provider performance scorecards and network retention decisions."
    - name: "critical_finding_count"
      expr: COUNT(CASE WHEN finding_severity_code = 'Critical' THEN obligation_compliance_id END)
      comment: "Number of compliance assessments with critical severity findings. Critical findings carry regulatory penalty risk and require immediate executive attention."
    - name: "penalty_imposed_count"
      expr: COUNT(CASE WHEN penalty_imposed_flag = TRUE THEN obligation_compliance_id END)
      comment: "Number of provider compliance cases where a regulatory penalty was imposed. Directly measures financial and reputational risk from provider non-compliance."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_participation_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring provider network participation status distribution, panel capacity, and regulatory sanction impact. Used by Network Management and CMO to monitor network health, adequacy, and member access across plans and LOBs."
  source: "`vibe_health_insurance_v1`.`provider`.`participation_status`"
  dimensions:
    - name: "participation_status_code"
      expr: participation_status_code
      comment: "Current participation status code (e.g., Active, Terminated, Suspended) — primary dimension for network health segmentation."
    - name: "network_tier_code"
      expr: network_tier_code
      comment: "Network tier assignment — used to analyze participation distribution across tier levels for member steerage strategy."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business — enables participation analysis by product line (Commercial, Medicare, Medicaid)."
    - name: "pcp_flag"
      expr: pcp_flag
      comment: "Indicates whether the provider is a primary care provider — used for PCP panel adequacy analysis."
    - name: "specialist_flag"
      expr: specialist_flag
      comment: "Indicates whether the provider is a specialist — used for specialist access adequacy analysis."
    - name: "regulatory_sanction_flag"
      expr: regulatory_sanction_flag
      comment: "Indicates whether the provider has an active regulatory sanction — critical risk flag for network participation decisions."
    - name: "accepting_new_patients_flag"
      expr: accepting_new_patients_flag
      comment: "Indicates whether the provider is accepting new patients — key member access metric for adequacy compliance."
    - name: "telehealth_enabled_flag"
      expr: telehealth_enabled_flag
      comment: "Indicates whether the provider offers telehealth — used to track virtual care access across the network."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of participation effective date — used to track network growth and attrition trends."
  measures:
    - name: "total_participation_records"
      expr: COUNT(1)
      comment: "Total number of provider participation status records. Baseline measure for network size."
    - name: "active_provider_count"
      expr: COUNT(CASE WHEN participation_status_code = 'Active' AND current_record_flag = TRUE THEN participation_status_id END)
      comment: "Number of currently active providers in the network. Core network adequacy KPI — used in CMS and state adequacy filings."
    - name: "sanctioned_active_provider_count"
      expr: COUNT(CASE WHEN regulatory_sanction_flag = TRUE AND participation_status_code = 'Active' THEN participation_status_id END)
      comment: "Number of active providers with regulatory sanctions. Sanctioned active providers represent immediate compliance risk — any non-zero count triggers executive escalation."
    - name: "accepting_new_patients_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN accepting_new_patients_flag = TRUE AND participation_status_code = 'Active' THEN participation_status_id END) / NULLIF(COUNT(CASE WHEN participation_status_code = 'Active' THEN participation_status_id END), 0), 2)
      comment: "Percentage of active providers accepting new patients. Critical member access KPI — regulators require minimum thresholds for network adequacy certification."
    - name: "telehealth_enabled_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN telehealth_enabled_flag = TRUE AND participation_status_code = 'Active' THEN participation_status_id END) / NULLIF(COUNT(CASE WHEN participation_status_code = 'Active' THEN participation_status_id END), 0), 2)
      comment: "Percentage of active providers offering telehealth services. Tracks virtual care access expansion — a strategic priority for member satisfaction and cost management."
    - name: "termination_count"
      expr: COUNT(CASE WHEN participation_status_code = 'Terminated' THEN participation_status_id END)
      comment: "Number of provider terminations. Tracks network attrition — high termination counts signal network instability and adequacy risk."
    - name: "pcp_active_count"
      expr: COUNT(CASE WHEN pcp_flag = TRUE AND participation_status_code = 'Active' THEN participation_status_id END)
      comment: "Number of active primary care providers. PCP supply is a core adequacy metric — regulators require minimum member-to-PCP ratios."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_practice_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Practice location metrics for geographic access analysis, ADA compliance, telehealth availability, and network adequacy supporting CMS time/distance standards."
  source: "`vibe_health_insurance_v1`.`provider`.`practice_location`"
  dimensions:
    - name: "location_type"
      expr: location_type
      comment: "Type of practice location for network composition."
    - name: "participation_status"
      expr: participation_status
      comment: "Location participation status for active network tracking."
    - name: "state_code"
      expr: state_code
      comment: "State of practice location for geographic adequacy."
    - name: "city"
      expr: city
      comment: "City of practice location for local access analysis."
    - name: "county_name"
      expr: county_name
      comment: "County for rural/urban access classification."
    - name: "accepting_new_patients_flag"
      expr: CAST(accepting_new_patients_flag AS STRING)
      comment: "Whether location accepts new patients for access reporting."
    - name: "telehealth_available_flag"
      expr: CAST(telehealth_available_flag AS STRING)
      comment: "Whether telehealth is available at location for virtual care access."
    - name: "wheelchair_accessible_flag"
      expr: CAST(wheelchair_accessible_flag AS STRING)
      comment: "Whether location is wheelchair accessible for ADA compliance."
    - name: "ada_compliant_flag"
      expr: CAST(ada_compliant_flag AS STRING)
      comment: "Whether location is ADA compliant for accessibility reporting."
    - name: "record_status"
      expr: record_status
      comment: "Record status for data quality tracking."
  measures:
    - name: "total_practice_locations"
      expr: COUNT(1)
      comment: "Total practice locations for network size tracking."
    - name: "active_location_count"
      expr: COUNT(CASE WHEN participation_status = 'Active' THEN 1 END)
      comment: "Count of active practice locations for current network adequacy."
    - name: "accepting_new_patients_location_count"
      expr: COUNT(CASE WHEN accepting_new_patients_flag = TRUE THEN 1 END)
      comment: "Count of locations accepting new patients for member access."
    - name: "telehealth_available_location_count"
      expr: COUNT(CASE WHEN telehealth_available_flag = TRUE THEN 1 END)
      comment: "Count of telehealth-available locations for virtual care access."
    - name: "ada_compliant_location_count"
      expr: COUNT(CASE WHEN ada_compliant_flag = TRUE THEN 1 END)
      comment: "Count of ADA-compliant locations for accessibility compliance."
    - name: "wheelchair_accessible_location_count"
      expr: COUNT(CASE WHEN wheelchair_accessible_flag = TRUE THEN 1 END)
      comment: "Count of wheelchair-accessible locations for accessibility reporting."
    - name: "distinct_location_states"
      expr: COUNT(DISTINCT state_code)
      comment: "Number of distinct states with practice locations for geographic coverage."
    - name: "distinct_location_counties"
      expr: COUNT(DISTINCT county_name)
      comment: "Number of distinct counties for granular geographic adequacy."
    - name: "distinct_providers_at_locations"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct providers with practice locations for network headcount."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core provider master metrics tracking active provider counts, credentialing status distribution, and network participation rates."
  source: "`vibe_health_insurance_v1`.`provider`.`provider`"
  dimensions:
    - name: "is_active"
      expr: is_active
      comment: "Whether the provider record is currently active"
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the provider became effective"
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the provider became effective"
  measures:
    - name: "total_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Total unique providers in the system"
    - name: "active_provider_count"
      expr: COUNT(DISTINCT CASE WHEN is_active = 'true' THEN provider_id END)
      comment: "Count of active providers available for network participation"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_directory_accuracy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring provider directory verification outcomes, accuracy rates, and verification currency. Used by Network Management and Compliance to meet CMS and state directory accuracy mandates (No Surprises Act, 21st Century Cures Act)."
  source: "`vibe_health_insurance_v1`.`provider`.`provider_directory_verification`"
  dimensions:
    - name: "verification_status"
      expr: verification_status
      comment: "Current verification status (e.g., Verified, Failed, Pending) — primary dimension for directory accuracy health."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used for verification (e.g., Phone, Mail, Online Portal) — used to assess efficiency of verification channels."
    - name: "verification_outcome"
      expr: verification_outcome
      comment: "Outcome of the verification attempt (e.g., Confirmed, Updated, Unable to Reach) — used to track data quality improvement actions."
    - name: "is_active"
      expr: is_active
      comment: "Current active record flag — filters to current verification records."
    - name: "verification_date_month"
      expr: DATE_TRUNC('month', record_created_at)
      comment: "Month of verification record creation — used to track verification program cadence and compliance with periodic re-verification requirements."
  measures:
    - name: "total_verification_records"
      expr: COUNT(1)
      comment: "Total number of directory verification records. Baseline measure for verification program coverage."
    - name: "verified_provider_count"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN provider_directory_verification_id END)
      comment: "Number of providers with verified directory information. Core directory accuracy KPI — CMS requires 90%+ verification rates to avoid penalties."
    - name: "verification_success_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'Verified' THEN provider_directory_verification_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of verification attempts resulting in confirmed accurate data. Primary directory compliance KPI — regulators use this to assess No Surprises Act adherence."
    - name: "overdue_verification_count"
      expr: COUNT(CASE WHEN next_verification_date < CURRENT_DATE AND is_active = TRUE THEN provider_directory_verification_id END)
      comment: "Number of providers with overdue directory re-verification. Overdue verifications create regulatory non-compliance risk under CMS directory accuracy rules."
    - name: "failed_verification_count"
      expr: COUNT(CASE WHEN verification_status = 'Failed' THEN provider_directory_verification_id END)
      comment: "Number of verification attempts that failed. Failed verifications indicate inaccurate directory data — a direct regulatory and member harm risk."
    - name: "failed_verification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'Failed' THEN provider_directory_verification_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of verification attempts that failed. Rising failure rates signal systemic directory data quality issues requiring executive intervention."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_network_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs measuring provider network participation health, credentialing status distribution, and value-based care readiness across the provider network. Used by Network Management and CMO to steer adequacy and VBC strategy."
  source: "`vibe_health_insurance_v1`.`provider`.`provider_network_participation2`"
  dimensions:
    - name: "participation_status_code"
      expr: participation_status_code
      comment: "Current participation status of the provider in the network (e.g., Active, Terminated, Pending) — primary segmentation for network health analysis."
    - name: "credentialing_status_code"
      expr: credentialing_status_code
      comment: "Credentialing status of the provider at time of participation — used to identify credentialing bottlenecks affecting network adequacy."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier assignment (e.g., Tier 1, Tier 2) — drives member cost-sharing and steerage strategy."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business (e.g., Commercial, Medicare, Medicaid) — enables participation analysis by product line."
    - name: "participation_effective_date_month"
      expr: DATE_TRUNC('month', participation_effective_date)
      comment: "Month of participation effective date — used to track network growth trends over time."
    - name: "vbc_eligible_flag"
      expr: vbc_eligible_flag
      comment: "Indicates whether the provider is eligible for value-based care arrangements — key for VBC program expansion tracking."
    - name: "capitation_eligible_flag"
      expr: capitation_eligible_flag
      comment: "Indicates whether the provider is eligible for capitation payment — used in risk-based contracting strategy."
    - name: "par_indicator"
      expr: par_indicator
      comment: "Participating (PAR) indicator — distinguishes in-network from out-of-network providers for adequacy reporting."
    - name: "is_active"
      expr: is_active
      comment: "Current active record flag — used to filter to current participation snapshot."
  measures:
    - name: "total_participation_records"
      expr: COUNT(1)
      comment: "Total number of provider network participation records. Baseline measure for network size tracking used in adequacy assessments."
    - name: "active_participating_providers"
      expr: COUNT(CASE WHEN participation_status_code = 'Active' AND is_active = TRUE THEN provider_network_participation2_id END)
      comment: "Count of currently active participating providers. Core network adequacy KPI used by Network Management to ensure sufficient provider supply."
    - name: "vbc_eligible_provider_count"
      expr: COUNT(CASE WHEN vbc_eligible_flag = TRUE THEN provider_network_participation2_id END)
      comment: "Number of providers eligible for value-based care arrangements. Tracks VBC program expansion potential — a strategic priority for cost and quality improvement."
    - name: "capitation_eligible_provider_count"
      expr: COUNT(CASE WHEN capitation_eligible_flag = TRUE THEN provider_network_participation2_id END)
      comment: "Number of providers eligible for capitation payment. Informs risk-based contracting strategy and actuarial risk pool composition."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across participating providers. Used by CMO and Network Management to assess overall network quality and identify underperforming segments."
    - name: "termination_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN participation_status_code = 'Terminated' THEN provider_network_participation2_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of participation records with terminated status. High termination rates signal network instability and adequacy risk — triggers leadership intervention."
    - name: "credentialing_pending_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN credentialing_status_code = 'Pending' THEN provider_network_participation2_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of participation records with pending credentialing status. Credentialing backlogs delay provider activation and create network adequacy gaps."
    - name: "accepting_new_patients_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN accepting_new_patients = TRUE THEN provider_network_participation2_id END) / NULLIF(COUNT(CASE WHEN participation_status_code = 'Active' THEN provider_network_participation2_id END), 0), 2)
      comment: "Percentage of active participating providers accepting new patients. Critical access metric for member assignment and network adequacy compliance."
    - name: "vbc_penetration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN vbc_eligible_flag = TRUE THEN provider_network_participation2_id END) / NULLIF(COUNT(CASE WHEN participation_status_code = 'Active' THEN provider_network_participation2_id END), 0), 2)
      comment: "Percentage of active providers eligible for VBC arrangements. Tracks progress toward value-based care transformation goals — a board-level strategic KPI."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_outreach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider outreach metrics tracking contact success rates, verification completion, and attestation compliance for directory accuracy and regulatory compliance."
  source: "`vibe_health_insurance_v1`.`provider`.`provider_outreach`"
  dimensions:
    - name: "outreach_type"
      expr: outreach_type
      comment: "Type of outreach performed"
    - name: "outreach_method"
      expr: outreach_method
      comment: "Method used for outreach (e.g., phone, email, mail)"
    - name: "outreach_status"
      expr: outreach_status
      comment: "Current status of the outreach attempt"
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the outreach attempt"
    - name: "purpose"
      expr: purpose
      comment: "Purpose of the outreach"
    - name: "attestation_method"
      expr: attestation_method
      comment: "Method used for provider attestation"
    - name: "contact_reached_flag"
      expr: contact_reached_flag
      comment: "Whether the provider contact was successfully reached"
    - name: "attestation_received_flag"
      expr: attestation_received_flag
      comment: "Whether attestation was received from the provider"
    - name: "data_verified_flag"
      expr: data_verified_flag
      comment: "Whether provider data was verified during outreach"
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Whether follow-up outreach is required"
    - name: "directory_removal_flag"
      expr: directory_removal_flag
      comment: "Whether the provider should be removed from the directory"
    - name: "compliance_quarter"
      expr: compliance_quarter
      comment: "Compliance quarter for the outreach"
    - name: "outreach_year"
      expr: YEAR(outreach_date)
      comment: "Year the outreach was performed"
    - name: "outreach_month"
      expr: DATE_TRUNC('MONTH', outreach_date)
      comment: "Month the outreach was performed"
  measures:
    - name: "total_outreach_attempts"
      expr: COUNT(DISTINCT provider_outreach_id)
      comment: "Total unique provider outreach attempts"
    - name: "successful_contact_count"
      expr: COUNT(DISTINCT CASE WHEN contact_reached_flag = true THEN provider_outreach_id END)
      comment: "Count of outreach attempts where provider was successfully contacted, key efficiency metric"
    - name: "attestation_received_count"
      expr: COUNT(DISTINCT CASE WHEN attestation_received_flag = true THEN provider_outreach_id END)
      comment: "Count of outreach attempts resulting in attestation, critical compliance metric for directory accuracy"
    - name: "data_verified_count"
      expr: COUNT(DISTINCT CASE WHEN data_verified_flag = true THEN provider_outreach_id END)
      comment: "Count of outreach attempts resulting in data verification, key quality metric"
    - name: "follow_up_required_count"
      expr: COUNT(DISTINCT CASE WHEN follow_up_required_flag = true THEN provider_outreach_id END)
      comment: "Count of outreach attempts requiring follow-up, workload indicator"
    - name: "directory_removal_count"
      expr: COUNT(DISTINCT CASE WHEN directory_removal_flag = true THEN provider_outreach_id END)
      comment: "Count of providers flagged for directory removal, data quality indicator"
    - name: "providers_contacted"
      expr: COUNT(DISTINCT provider_id)
      comment: "Unique providers contacted during outreach campaigns"
    - name: "total_attempt_count"
      expr: SUM(CAST(attempt_count AS DOUBLE))
      comment: "Total number of contact attempts across all outreach records"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_outreach_effectiveness`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring provider outreach program effectiveness, contact rates, and directory data update outcomes. Used by Network Management to optimize outreach strategies and meet CMS directory accuracy requirements."
  source: "`vibe_health_insurance_v1`.`provider`.`provider_outreach`"
  dimensions:
    - name: "outreach_type"
      expr: outreach_type
      comment: "Type of outreach activity (e.g., Directory Verification, Credentialing, Recruitment) — used to analyze effectiveness by outreach purpose."
    - name: "outreach_method"
      expr: outreach_method
      comment: "Channel used for outreach (e.g., Phone, Email, Mail, Portal) — used to identify highest-performing contact channels."
    - name: "outreach_status"
      expr: outreach_status
      comment: "Current status of the outreach attempt (e.g., Completed, Pending, Failed) — primary dimension for outreach pipeline management."
    - name: "contact_reached_flag"
      expr: contact_reached_flag
      comment: "Indicates whether the provider contact was successfully reached — key effectiveness indicator."
    - name: "attestation_received_flag"
      expr: attestation_received_flag
      comment: "Indicates whether a directory attestation was received — measures outreach conversion to compliance outcome."
    - name: "data_updated_flag"
      expr: data_updated_flag
      comment: "Indicates whether provider data was updated as a result of outreach — measures data quality improvement yield."
    - name: "outreach_date_month"
      expr: DATE_TRUNC('month', outreach_date)
      comment: "Month of outreach activity — used to track outreach program cadence and seasonal patterns."
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Indicates whether follow-up is required — used to manage outreach workload and prioritize unresolved contacts."
  measures:
    - name: "total_outreach_attempts"
      expr: COUNT(1)
      comment: "Total number of provider outreach attempts. Baseline measure for outreach program activity volume."
    - name: "contact_reached_count"
      expr: COUNT(CASE WHEN contact_reached_flag = TRUE THEN provider_outreach_id END)
      comment: "Number of outreach attempts where the provider contact was successfully reached. Core outreach effectiveness KPI."
    - name: "contact_reach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN contact_reached_flag = TRUE THEN provider_outreach_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outreach attempts resulting in successful contact. Primary outreach efficiency KPI — low rates indicate need to change channels or timing strategy."
    - name: "attestation_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN attestation_received_flag = TRUE THEN provider_outreach_id END) / NULLIF(COUNT(CASE WHEN contact_reached_flag = TRUE THEN provider_outreach_id END), 0), 2)
      comment: "Percentage of successful contacts that resulted in a directory attestation. Measures outreach-to-compliance conversion — directly tied to CMS directory accuracy requirements."
    - name: "data_update_yield_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN data_updated_flag = TRUE THEN provider_outreach_id END) / NULLIF(COUNT(CASE WHEN contact_reached_flag = TRUE THEN provider_outreach_id END), 0), 2)
      comment: "Percentage of successful contacts that resulted in a data update. Measures the data quality improvement yield of the outreach program."
    - name: "pending_follow_up_count"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE AND outreach_status != 'Completed' THEN provider_outreach_id END)
      comment: "Number of outreach records requiring follow-up that are not yet completed. Operational workload KPI for outreach team capacity planning."
    - name: "directory_removal_count"
      expr: COUNT(CASE WHEN directory_removal_flag = TRUE THEN provider_outreach_id END)
      comment: "Number of outreach outcomes resulting in provider directory removal. Tracks network attrition from outreach — informs adequacy impact assessment."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_sanction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider sanction metrics tracking sanction types, severity, resolution rates, and regulatory reporting requirements for compliance and risk management."
  source: "`vibe_health_insurance_v1`.`provider`.`sanction`"
  dimensions:
    - name: "sanction_type"
      expr: sanction_type
      comment: "Type of sanction imposed"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the sanction"
    - name: "screening_result"
      expr: screening_result
      comment: "Result of the screening that identified the sanction"
    - name: "screening_source"
      expr: screening_source
      comment: "Source that identified the sanction"
    - name: "participation_impact"
      expr: participation_impact
      comment: "Impact of the sanction on network participation"
    - name: "cms_reportable_flag"
      expr: cms_reportable_flag
      comment: "Whether the sanction requires CMS reporting"
    - name: "ncqa_reportable_flag"
      expr: ncqa_reportable_flag
      comment: "Whether the sanction requires NCQA reporting"
    - name: "exclusion_waiver_flag"
      expr: exclusion_waiver_flag
      comment: "Whether an exclusion waiver was granted"
    - name: "notification_sent_flag"
      expr: notification_sent_flag
      comment: "Whether notification was sent regarding the sanction"
    - name: "sanction_year"
      expr: YEAR(sanction_date)
      comment: "Year the sanction was imposed"
    - name: "sanction_month"
      expr: DATE_TRUNC('MONTH', sanction_date)
      comment: "Month the sanction was imposed"
  measures:
    - name: "total_sanctions"
      expr: COUNT(DISTINCT sanction_id)
      comment: "Total unique sanctions on record, critical risk indicator for compliance and network quality"
    - name: "active_sanction_count"
      expr: COUNT(DISTINCT CASE WHEN is_active = 'true' THEN sanction_id END)
      comment: "Count of currently active sanctions requiring ongoing monitoring"
    - name: "cms_reportable_sanction_count"
      expr: COUNT(DISTINCT CASE WHEN cms_reportable_flag = true THEN sanction_id END)
      comment: "Count of sanctions requiring CMS reporting, key compliance metric"
    - name: "ncqa_reportable_sanction_count"
      expr: COUNT(DISTINCT CASE WHEN ncqa_reportable_flag = true THEN sanction_id END)
      comment: "Count of sanctions requiring NCQA reporting, key accreditation metric"
    - name: "sanctioned_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Unique providers with sanctions, critical for network quality and risk assessment"
    - name: "resolved_sanction_count"
      expr: COUNT(DISTINCT CASE WHEN resolution_date IS NOT NULL THEN sanction_id END)
      comment: "Count of sanctions that have been resolved"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_sanction_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring provider sanction activity, CMS/NCQA reportability, and network impact. Used by Compliance, Legal, and Network Management to manage regulatory risk from sanctioned providers and ensure timely reporting obligations are met."
  source: "`vibe_health_insurance_v1`.`provider`.`sanction`"
  dimensions:
    - name: "sanction_type"
      expr: sanction_type
      comment: "Type of sanction imposed (e.g., Exclusion, Suspension, Civil Monetary Penalty) — used to categorize regulatory risk severity."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the sanction — used to prioritize response and escalation actions."
    - name: "cms_reportable_flag"
      expr: cms_reportable_flag
      comment: "Indicates whether the sanction must be reported to CMS — tracks mandatory federal reporting obligations."
    - name: "ncqa_reportable_flag"
      expr: ncqa_reportable_flag
      comment: "Indicates whether the sanction must be reported to NCQA — tracks accreditation reporting obligations."
    - name: "notification_sent_flag"
      expr: notification_sent_flag
      comment: "Indicates whether required notifications have been sent — used to track compliance with notification timelines."
    - name: "sanction_date_month"
      expr: DATE_TRUNC('month', sanction_date)
      comment: "Month of sanction — used to trend sanction activity and identify spikes requiring investigation."
    - name: "is_active"
      expr: is_active
      comment: "Current active record flag — filters to current sanction records."
  measures:
    - name: "total_sanctions"
      expr: COUNT(1)
      comment: "Total number of provider sanction records. Baseline measure for sanction program activity volume."
    - name: "active_sanction_count"
      expr: COUNT(CASE WHEN is_active = TRUE AND current_record_flag = TRUE THEN sanction_id END)
      comment: "Number of currently active provider sanctions. Active sanctions require immediate network action — sanctioned providers cannot participate in federal programs."
    - name: "cms_reportable_sanction_count"
      expr: COUNT(CASE WHEN cms_reportable_flag = TRUE THEN sanction_id END)
      comment: "Number of sanctions requiring CMS reporting. Failure to report CMS-reportable sanctions carries significant financial penalties — a critical compliance KPI."
    - name: "notification_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN notification_sent_flag = TRUE THEN sanction_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sanctions where required notifications were sent. Notification failures create regulatory liability — this KPI measures process compliance."
    - name: "unresolved_sanction_count"
      expr: COUNT(CASE WHEN resolution_date IS NULL AND is_active = TRUE THEN sanction_id END)
      comment: "Number of sanctions without a resolution date. Unresolved sanctions represent ongoing network risk and regulatory exposure requiring leadership attention."
    - name: "exclusion_waiver_count"
      expr: COUNT(CASE WHEN exclusion_waiver_flag = TRUE THEN sanction_id END)
      comment: "Number of sanctions where an exclusion waiver was granted. Waivers require regulatory approval — tracking volume ensures waiver program is properly managed."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_specialty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider specialty metrics tracking board certification rates, PCP eligibility, and specialty distribution for network adequacy and care delivery planning."
  source: "`vibe_health_insurance_v1`.`provider`.`specialty`"
  dimensions:
    - name: "specialty_name"
      expr: specialty_name
      comment: "Name of the provider specialty"
    - name: "specialty_code"
      expr: specialty_code
      comment: "Code identifying the specialty"
    - name: "specialty_category"
      expr: specialty_category
      comment: "Category of the specialty"
    - name: "specialty_type"
      expr: specialty_type
      comment: "Type of specialty (e.g., primary, specialty)"
    - name: "subspecialty_name"
      expr: subspecialty_name
      comment: "Name of the subspecialty if applicable"
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status for this specialty"
    - name: "board_certified_flag"
      expr: board_certified_flag
      comment: "Whether the provider is board certified in this specialty"
    - name: "pcp_eligible_flag"
      expr: pcp_eligible_flag
      comment: "Whether this specialty is eligible for PCP designation"
    - name: "hedis_specialty_flag"
      expr: hedis_specialty_flag
      comment: "Whether this specialty is relevant for HEDIS reporting"
    - name: "accepting_new_patients_flag"
      expr: accepting_new_patients_flag
      comment: "Whether the provider is accepting new patients in this specialty"
    - name: "telehealth_enabled_flag"
      expr: telehealth_enabled_flag
      comment: "Whether telehealth is enabled for this specialty"
    - name: "specialist_referral_required_flag"
      expr: specialist_referral_required_flag
      comment: "Whether a referral is required for this specialty"
    - name: "fellowship_completed_flag"
      expr: fellowship_completed_flag
      comment: "Whether the provider completed a fellowship in this specialty"
    - name: "network_adequacy_category"
      expr: network_adequacy_category
      comment: "Network adequacy category for this specialty"
    - name: "is_active"
      expr: is_active
      comment: "Whether the specialty record is currently active"
  measures:
    - name: "total_specialty_records"
      expr: COUNT(DISTINCT specialty_id)
      comment: "Total unique provider-specialty records"
    - name: "board_certified_count"
      expr: COUNT(DISTINCT CASE WHEN board_certified_flag = true THEN specialty_id END)
      comment: "Count of board-certified specialty records, key quality indicator for network credentialing"
    - name: "pcp_eligible_specialty_count"
      expr: COUNT(DISTINCT CASE WHEN pcp_eligible_flag = true THEN specialty_id END)
      comment: "Count of PCP-eligible specialty records, critical for primary care network adequacy"
    - name: "hedis_specialty_count"
      expr: COUNT(DISTINCT CASE WHEN hedis_specialty_flag = true THEN specialty_id END)
      comment: "Count of HEDIS-relevant specialty records, important for quality reporting"
    - name: "accepting_new_patients_specialty_count"
      expr: COUNT(DISTINCT CASE WHEN accepting_new_patients_flag = true THEN specialty_id END)
      comment: "Count of specialty records accepting new patients, key access metric"
    - name: "telehealth_enabled_specialty_count"
      expr: COUNT(DISTINCT CASE WHEN telehealth_enabled_flag = true THEN specialty_id END)
      comment: "Count of telehealth-enabled specialty records, important for virtual care access"
    - name: "providers_with_specialty"
      expr: COUNT(DISTINCT provider_id)
      comment: "Unique providers with specialty records"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_specialty_credentialing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring provider specialty credentialing status, board certification rates, and recredentialing compliance. Used by Credentialing and Network Management to ensure specialty coverage meets NCQA standards and network adequacy requirements."
  source: "`vibe_health_insurance_v1`.`provider`.`specialty`"
  dimensions:
    - name: "specialty_category"
      expr: specialty_category
      comment: "High-level specialty category (e.g., Primary Care, Cardiology, Behavioral Health) — used for specialty mix analysis and adequacy gap identification."
    - name: "specialty_type"
      expr: specialty_type
      comment: "Specific specialty type — used for granular specialty coverage analysis."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Current credentialing status for this specialty (e.g., Approved, Pending, Denied) — primary dimension for credentialing pipeline management."
    - name: "board_certified_flag"
      expr: board_certified_flag
      comment: "Indicates whether the provider is board certified in this specialty — key quality indicator for network composition."
    - name: "primary_specialty_flag"
      expr: primary_specialty_flag
      comment: "Indicates whether this is the providers primary specialty — used to analyze primary specialty distribution across the network."
    - name: "pcp_eligible_flag"
      expr: pcp_eligible_flag
      comment: "Indicates whether this specialty qualifies for PCP designation — used in PCP panel adequacy analysis."
    - name: "hedis_specialty_flag"
      expr: hedis_specialty_flag
      comment: "Indicates whether this specialty is relevant to HEDIS measure reporting — used to ensure adequate HEDIS-relevant specialist supply."
    - name: "telehealth_enabled_flag"
      expr: telehealth_enabled_flag
      comment: "Indicates whether the provider offers telehealth for this specialty — tracks virtual specialty access."
    - name: "is_active"
      expr: is_active
      comment: "Current active record flag — filters to current specialty credentialing records."
  measures:
    - name: "total_specialty_records"
      expr: COUNT(1)
      comment: "Total number of provider specialty credentialing records. Baseline measure for specialty credentialing program scope."
    - name: "board_certified_count"
      expr: COUNT(CASE WHEN board_certified_flag = TRUE AND is_active = TRUE THEN specialty_id END)
      comment: "Number of active specialty records with board certification. Board certification is a key quality indicator — used in network quality scorecards and NCQA reporting."
    - name: "board_certification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN board_certified_flag = TRUE AND is_active = TRUE THEN specialty_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN specialty_id END), 0), 2)
      comment: "Percentage of active specialty records with board certification. NCQA and CMS use board certification rates as a network quality benchmark."
    - name: "credentialing_approved_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN credentialing_status = 'Approved' THEN specialty_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of specialty credentialing records with approved status. Measures credentialing program throughput and approval efficiency."
    - name: "certifications_expiring_within_90_days"
      expr: COUNT(CASE WHEN certification_expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) AND board_certified_flag = TRUE THEN specialty_id END)
      comment: "Number of board certifications expiring within 90 days. Forward-looking risk metric — expired certifications affect network quality scores and NCQA accreditation."
    - name: "recredentialing_required_count"
      expr: COUNT(CASE WHEN recertification_required_flag = TRUE AND is_active = TRUE THEN specialty_id END)
      comment: "Number of active specialty records requiring recertification. Tracks upcoming recredentialing workload — used for credentialing team capacity planning."
    - name: "fellowship_completed_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fellowship_completed_flag = TRUE THEN specialty_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of specialty records where fellowship training was completed. Fellowship completion is a quality differentiator for specialist network composition."
$$;
