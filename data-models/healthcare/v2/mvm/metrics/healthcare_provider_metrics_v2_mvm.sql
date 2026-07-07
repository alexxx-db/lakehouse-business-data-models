-- Metric views for domain: provider | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 09:11:47

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_clinician`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core clinician workforce metrics tracking credentialing status, board certification, enrollment, and employment lifecycle for provider network management and regulatory compliance."
  source: "`vibe_healthcare_v1`.`provider`.`clinician`"
  dimensions:
    - name: "clinician_status"
      expr: clinician_status
      comment: "Current status of the clinician (active, inactive, terminated, etc.)"
    - name: "clinician_type"
      expr: clinician_type
      comment: "Type of clinician (physician, nurse practitioner, physician assistant, etc.)"
    - name: "employment_status"
      expr: employment_status
      comment: "Employment status (full-time, part-time, per diem, contractor, etc.)"
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment arrangement"
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Current credentialing status for payer enrollment and privileging"
    - name: "board_certified"
      expr: board_certified
      comment: "Whether the clinician holds current board certification"
    - name: "medicare_enrolled"
      expr: medicare_enrolled
      comment: "Whether the clinician is enrolled in Medicare"
    - name: "medicaid_enrolled"
      expr: medicaid_enrolled
      comment: "Whether the clinician is enrolled in Medicaid"
    - name: "payer_enrollment_status"
      expr: payer_enrollment_status
      comment: "Overall payer enrollment status"
    - name: "oig_exclusion_checked"
      expr: oig_exclusion_checked
      comment: "Whether OIG exclusion screening has been completed"
    - name: "primary_source_verified"
      expr: primary_source_verified
      comment: "Whether credentials have been primary source verified per NCQA standards"
    - name: "gender"
      expr: gender
      comment: "Clinician gender for workforce diversity and patient preference matching"
    - name: "license_state"
      expr: license_state
      comment: "State where primary medical license is held"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year the clinician was hired for cohort analysis"
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month the clinician was hired for trend analysis"
  measures:
    - name: "total_clinicians"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Total unique clinicians in the provider network"
    - name: "board_certified_clinicians"
      expr: COUNT(DISTINCT CASE WHEN board_certified = TRUE THEN clinician_id END)
      comment: "Number of clinicians holding current board certification"
    - name: "board_certification_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN board_certified = TRUE THEN clinician_id END) / NULLIF(COUNT(DISTINCT clinician_id), 0), 2)
      comment: "Percentage of clinicians who are board certified - key quality indicator for network adequacy and accreditation"
    - name: "credentialed_clinicians"
      expr: COUNT(DISTINCT CASE WHEN credentialing_status = 'Active' THEN clinician_id END)
      comment: "Number of clinicians with active credentialing status"
    - name: "credentialing_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN credentialing_status = 'Active' THEN clinician_id END) / NULLIF(COUNT(DISTINCT clinician_id), 0), 2)
      comment: "Percentage of clinicians with active credentialing - critical for payer contracting and regulatory compliance"
    - name: "medicare_enrolled_clinicians"
      expr: COUNT(DISTINCT CASE WHEN medicare_enrolled = TRUE THEN clinician_id END)
      comment: "Number of clinicians enrolled in Medicare"
    - name: "medicare_enrollment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN medicare_enrolled = TRUE THEN clinician_id END) / NULLIF(COUNT(DISTINCT clinician_id), 0), 2)
      comment: "Percentage of clinicians enrolled in Medicare - drives revenue capture for Medicare patient population"
    - name: "medicaid_enrolled_clinicians"
      expr: COUNT(DISTINCT CASE WHEN medicaid_enrolled = TRUE THEN clinician_id END)
      comment: "Number of clinicians enrolled in Medicaid"
    - name: "medicaid_enrollment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN medicaid_enrolled = TRUE THEN clinician_id END) / NULLIF(COUNT(DISTINCT clinician_id), 0), 2)
      comment: "Percentage of clinicians enrolled in Medicaid - impacts access for Medicaid beneficiaries and DSH eligibility"
    - name: "oig_screened_clinicians"
      expr: COUNT(DISTINCT CASE WHEN oig_exclusion_checked = TRUE THEN clinician_id END)
      comment: "Number of clinicians who have completed OIG exclusion screening"
    - name: "oig_screening_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN oig_exclusion_checked = TRUE THEN clinician_id END) / NULLIF(COUNT(DISTINCT clinician_id), 0), 2)
      comment: "Percentage of clinicians with completed OIG screening - mandatory for federal program participation and compliance"
    - name: "primary_source_verified_clinicians"
      expr: COUNT(DISTINCT CASE WHEN primary_source_verified = TRUE THEN clinician_id END)
      comment: "Number of clinicians with primary source verified credentials"
    - name: "psv_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN primary_source_verified = TRUE THEN clinician_id END) / NULLIF(COUNT(DISTINCT clinician_id), 0), 2)
      comment: "Percentage of clinicians with primary source verification - required for NCQA accreditation and payer credentialing"
    - name: "active_clinicians"
      expr: COUNT(DISTINCT CASE WHEN clinician_status = 'Active' THEN clinician_id END)
      comment: "Number of clinicians with active status"
    - name: "clinician_retention_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN clinician_status = 'Active' THEN clinician_id END) / NULLIF(COUNT(DISTINCT clinician_id), 0), 2)
      comment: "Percentage of clinicians currently active - key workforce stability and retention metric"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_board_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Board certification lifecycle metrics tracking specialty certification status, expiration risk, and compliance for quality assurance and credentialing requirements."
  source: "`vibe_healthcare_v1`.`provider`.`board_certification`"
  dimensions:
    - name: "board_certification_status"
      expr: board_certification_status
      comment: "Current status of the board certification"
    - name: "certification_status"
      expr: certification_status
      comment: "Detailed certification status"
    - name: "board_name"
      expr: board_name
      comment: "Name of the certifying board (ABMS member board)"
    - name: "certification_year"
      expr: YEAR(certification_date)
      comment: "Year the certification was granted"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the certification expires"
    - name: "expiration_quarter"
      expr: DATE_TRUNC('QUARTER', expiration_date)
      comment: "Quarter when certification expires for proactive renewal planning"
  measures:
    - name: "total_certifications"
      expr: COUNT(DISTINCT board_certification_id)
      comment: "Total unique board certifications on record"
    - name: "active_certifications"
      expr: COUNT(DISTINCT CASE WHEN board_certification_status = 'Active' THEN board_certification_id END)
      comment: "Number of active board certifications"
    - name: "expired_certifications"
      expr: COUNT(DISTINCT CASE WHEN board_certification_status = 'Expired' THEN board_certification_id END)
      comment: "Number of expired board certifications"
    - name: "certifications_expiring_soon"
      expr: COUNT(DISTINCT CASE WHEN expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN board_certification_id END)
      comment: "Number of certifications expiring within 90 days - early warning for renewal action"
    - name: "certification_expiration_risk_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN board_certification_id END) / NULLIF(COUNT(DISTINCT CASE WHEN board_certification_status = 'Active' THEN board_certification_id END), 0), 2)
      comment: "Percentage of active certifications expiring within 90 days - operational risk metric for credentialing continuity"
    - name: "certified_clinicians"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Number of unique clinicians holding board certifications"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_credential`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Comprehensive credential lifecycle metrics covering licenses, DEA registrations, CME credits, and verification status for regulatory compliance and credentialing operations."
  source: "`vibe_healthcare_v1`.`provider`.`credential`"
  dimensions:
    - name: "credential_type"
      expr: credential_type
      comment: "Type of credential (license, DEA, board certification, etc.)"
    - name: "credential_status"
      expr: credential_status
      comment: "Current status of the credential"
    - name: "issuing_state"
      expr: issuing_state
      comment: "State that issued the credential"
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the credential"
    - name: "primary_source_verified"
      expr: primary_source_verified
      comment: "Whether the credential has been primary source verified"
    - name: "oig_exclusion_checked"
      expr: oig_exclusion_checked
      comment: "Whether OIG exclusion check has been completed"
    - name: "npdb_queried"
      expr: npdb_queried
      comment: "Whether National Practitioner Data Bank has been queried"
    - name: "caqh_submitted"
      expr: caqh_submitted
      comment: "Whether credential has been submitted to CAQH"
    - name: "payer_enrollment_relevant"
      expr: payer_enrollment_relevant
      comment: "Whether this credential is relevant for payer enrollment"
    - name: "privileging_relevant"
      expr: privileging_relevant
      comment: "Whether this credential is relevant for hospital privileging"
    - name: "cme_category"
      expr: cme_category
      comment: "Category of CME activity (Category 1, 2, etc.)"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the credential expires"
    - name: "expiration_quarter"
      expr: DATE_TRUNC('QUARTER', expiration_date)
      comment: "Quarter when credential expires"
  measures:
    - name: "total_credentials"
      expr: COUNT(DISTINCT credential_id)
      comment: "Total unique credentials on record"
    - name: "active_credentials"
      expr: COUNT(DISTINCT CASE WHEN credential_status = 'Active' THEN credential_id END)
      comment: "Number of active credentials"
    - name: "expired_credentials"
      expr: COUNT(DISTINCT CASE WHEN credential_status = 'Expired' THEN credential_id END)
      comment: "Number of expired credentials"
    - name: "credentials_expiring_soon"
      expr: COUNT(DISTINCT CASE WHEN expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 60) THEN credential_id END)
      comment: "Number of credentials expiring within 60 days"
    - name: "credential_expiration_risk_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 60) THEN credential_id END) / NULLIF(COUNT(DISTINCT CASE WHEN credential_status = 'Active' THEN credential_id END), 0), 2)
      comment: "Percentage of active credentials expiring within 60 days - operational risk for provider network continuity"
    - name: "psv_compliant_credentials"
      expr: COUNT(DISTINCT CASE WHEN primary_source_verified = TRUE THEN credential_id END)
      comment: "Number of credentials with primary source verification"
    - name: "psv_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN primary_source_verified = TRUE THEN credential_id END) / NULLIF(COUNT(DISTINCT credential_id), 0), 2)
      comment: "Percentage of credentials with primary source verification - NCQA accreditation requirement"
    - name: "oig_screened_credentials"
      expr: COUNT(DISTINCT CASE WHEN oig_exclusion_checked = TRUE THEN credential_id END)
      comment: "Number of credentials with completed OIG screening"
    - name: "oig_screening_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN oig_exclusion_checked = TRUE THEN credential_id END) / NULLIF(COUNT(DISTINCT credential_id), 0), 2)
      comment: "Percentage of credentials with OIG screening - mandatory compliance metric"
    - name: "npdb_queried_credentials"
      expr: COUNT(DISTINCT CASE WHEN npdb_queried = TRUE THEN credential_id END)
      comment: "Number of credentials with NPDB query completed"
    - name: "npdb_query_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN npdb_queried = TRUE THEN credential_id END) / NULLIF(COUNT(DISTINCT credential_id), 0), 2)
      comment: "Percentage of credentials with NPDB query - required for credentialing and privileging"
    - name: "total_cme_credits"
      expr: SUM(CAST(cme_credit_hours AS DOUBLE))
      comment: "Total CME credit hours earned across all credentials"
    - name: "avg_cme_credits_per_credential"
      expr: AVG(CAST(cme_credit_hours AS DOUBLE))
      comment: "Average CME credit hours per credential record"
    - name: "credentialed_clinicians"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Number of unique clinicians with credentials on record"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_network_affiliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider network participation metrics tracking payer network affiliations, panel capacity, credentialing status, and network adequacy for contract management and access optimization."
  source: "`vibe_healthcare_v1`.`provider`.`network_affiliation`"
  dimensions:
    - name: "network_affiliation_status"
      expr: network_affiliation_status
      comment: "Current status of the network affiliation"
    - name: "affiliation_status"
      expr: affiliation_status
      comment: "Detailed affiliation status"
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier (Tier 1, Tier 2, etc.) affecting patient cost-sharing"
    - name: "participation_type"
      expr: participation_type
      comment: "Type of network participation (participating, non-participating, etc.)"
    - name: "panel_status"
      expr: panel_status
      comment: "Status of the provider panel (open, closed, limited)"
    - name: "accepts_new_patients"
      expr: accepts_new_patients
      comment: "Whether the provider is accepting new patients"
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status for this network affiliation"
    - name: "primary_care_designation"
      expr: primary_care_designation
      comment: "Whether designated as primary care provider"
    - name: "telehealth_eligible"
      expr: telehealth_eligible
      comment: "Whether eligible to provide telehealth services in this network"
    - name: "mips_eligible"
      expr: mips_eligible
      comment: "Whether eligible for MIPS quality reporting"
    - name: "aco_participant_flag"
      expr: aco_participant_flag
      comment: "Whether participating in an Accountable Care Organization"
    - name: "directory_published_flag"
      expr: directory_published_flag
      comment: "Whether affiliation is published in provider directory"
    - name: "network_adequacy_category"
      expr: network_adequacy_category
      comment: "Network adequacy category for regulatory compliance"
    - name: "reimbursement_model"
      expr: reimbursement_model
      comment: "Reimbursement model (FFS, capitation, value-based, etc.)"
    - name: "service_area_state"
      expr: service_area_state
      comment: "State where services are provided"
  measures:
    - name: "total_network_affiliations"
      expr: COUNT(DISTINCT network_affiliation_id)
      comment: "Total unique network affiliations"
    - name: "active_network_affiliations"
      expr: COUNT(DISTINCT CASE WHEN network_affiliation_status = 'Active' THEN network_affiliation_id END)
      comment: "Number of active network affiliations"
    - name: "affiliations_accepting_new_patients"
      expr: COUNT(DISTINCT CASE WHEN accepts_new_patients = TRUE THEN network_affiliation_id END)
      comment: "Number of affiliations accepting new patients"
    - name: "new_patient_access_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN accepts_new_patients = TRUE THEN network_affiliation_id END) / NULLIF(COUNT(DISTINCT CASE WHEN network_affiliation_status = 'Active' THEN network_affiliation_id END), 0), 2)
      comment: "Percentage of active affiliations accepting new patients - key network access metric for member satisfaction and regulatory adequacy"
    - name: "credentialed_affiliations"
      expr: COUNT(DISTINCT CASE WHEN credentialing_status = 'Active' THEN network_affiliation_id END)
      comment: "Number of affiliations with active credentialing"
    - name: "network_credentialing_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN credentialing_status = 'Active' THEN network_affiliation_id END) / NULLIF(COUNT(DISTINCT network_affiliation_id), 0), 2)
      comment: "Percentage of affiliations with active credentialing - operational readiness for claims processing"
    - name: "telehealth_enabled_affiliations"
      expr: COUNT(DISTINCT CASE WHEN telehealth_eligible = TRUE THEN network_affiliation_id END)
      comment: "Number of affiliations enabled for telehealth"
    - name: "telehealth_penetration_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN telehealth_eligible = TRUE THEN network_affiliation_id END) / NULLIF(COUNT(DISTINCT CASE WHEN network_affiliation_status = 'Active' THEN network_affiliation_id END), 0), 2)
      comment: "Percentage of active affiliations with telehealth capability - strategic metric for virtual care expansion"
    - name: "mips_eligible_affiliations"
      expr: COUNT(DISTINCT CASE WHEN mips_eligible = TRUE THEN network_affiliation_id END)
      comment: "Number of affiliations eligible for MIPS reporting"
    - name: "mips_participation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN mips_eligible = TRUE THEN network_affiliation_id END) / NULLIF(COUNT(DISTINCT CASE WHEN network_affiliation_status = 'Active' THEN network_affiliation_id END), 0), 2)
      comment: "Percentage of active affiliations eligible for MIPS - impacts Medicare quality payment adjustments"
    - name: "aco_participating_affiliations"
      expr: COUNT(DISTINCT CASE WHEN aco_participant_flag = TRUE THEN network_affiliation_id END)
      comment: "Number of affiliations participating in ACOs"
    - name: "aco_participation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN aco_participant_flag = TRUE THEN network_affiliation_id END) / NULLIF(COUNT(DISTINCT CASE WHEN network_affiliation_status = 'Active' THEN network_affiliation_id END), 0), 2)
      comment: "Percentage of active affiliations in ACO arrangements - value-based care strategy metric"
    - name: "directory_published_affiliations"
      expr: COUNT(DISTINCT CASE WHEN directory_published_flag = TRUE THEN network_affiliation_id END)
      comment: "Number of affiliations published in provider directory"
    - name: "directory_accuracy_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN directory_published_flag = TRUE THEN network_affiliation_id END) / NULLIF(COUNT(DISTINCT CASE WHEN network_affiliation_status = 'Active' THEN network_affiliation_id END), 0), 2)
      comment: "Percentage of active affiliations published in directory - regulatory compliance metric for CMS directory accuracy requirements"
    - name: "affiliated_clinicians"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Number of unique clinicians with network affiliations"
    - name: "affiliated_groups"
      expr: COUNT(DISTINCT group_id)
      comment: "Number of unique provider groups with network affiliations"
    - name: "affiliated_payers"
      expr: COUNT(DISTINCT payer_id)
      comment: "Number of unique payers with provider affiliations"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_group`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider group organization metrics tracking credentialing, network participation, Medicare/Medicaid enrollment, and value-based care program eligibility for contract management and network strategy."
  source: "`vibe_healthcare_v1`.`provider`.`group`"
  dimensions:
    - name: "group_status"
      expr: group_status
      comment: "Current status of the provider group"
    - name: "group_type"
      expr: group_type
      comment: "Type of provider group (single specialty, multi-specialty, etc.)"
    - name: "organization_type"
      expr: group_type
      comment: "Organizational structure type"
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status of the group"
    - name: "network_participation_status"
      expr: network_participation_status
      comment: "Network participation status"
    - name: "payer_enrollment_status"
      expr: payer_enrollment_status
      comment: "Payer enrollment status"
    - name: "medicare_enrollment_status"
      expr: medicare_enrollment_status
      comment: "Medicare enrollment status"
    - name: "medicaid_enrollment_status"
      expr: medicaid_enrollment_status
      comment: "Medicaid enrollment status"
    - name: "accepts_new_patients"
      expr: accepts_new_patients
      comment: "Whether the group is accepting new patients"
    - name: "mips_eligible"
      expr: mips_eligible
      comment: "Whether the group is eligible for MIPS reporting"
    - name: "mips_group_reporting"
      expr: mips_group_reporting
      comment: "Whether the group reports MIPS at group level"
    - name: "aco_participant"
      expr: aco_participant
      comment: "Whether the group participates in an ACO"
    - name: "fqhc_designation"
      expr: fqhc_designation
      comment: "Whether designated as Federally Qualified Health Center"
    - name: "rhc_designation"
      expr: rhc_designation
      comment: "Whether designated as Rural Health Clinic"
    - name: "telehealth_capable"
      expr: telehealth_capable
      comment: "Whether the group has telehealth capability"
    - name: "size"
      expr: size
      comment: "Size category of the provider group"
  measures:
    - name: "total_groups"
      expr: COUNT(DISTINCT group_id)
      comment: "Total unique provider groups"
    - name: "active_groups"
      expr: COUNT(DISTINCT CASE WHEN group_status = 'Active' THEN group_id END)
      comment: "Number of active provider groups"
    - name: "credentialed_groups"
      expr: COUNT(DISTINCT CASE WHEN credentialing_status = 'Active' THEN group_id END)
      comment: "Number of groups with active credentialing"
    - name: "group_credentialing_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN credentialing_status = 'Active' THEN group_id END) / NULLIF(COUNT(DISTINCT group_id), 0), 2)
      comment: "Percentage of groups with active credentialing - operational readiness for network participation"
    - name: "groups_accepting_new_patients"
      expr: COUNT(DISTINCT CASE WHEN accepts_new_patients = TRUE THEN group_id END)
      comment: "Number of groups accepting new patients"
    - name: "group_access_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN accepts_new_patients = TRUE THEN group_id END) / NULLIF(COUNT(DISTINCT CASE WHEN group_status = 'Active' THEN group_id END), 0), 2)
      comment: "Percentage of active groups accepting new patients - network access and capacity metric"
    - name: "mips_eligible_groups"
      expr: COUNT(DISTINCT CASE WHEN mips_eligible = TRUE THEN group_id END)
      comment: "Number of groups eligible for MIPS"
    - name: "mips_group_reporting_groups"
      expr: COUNT(DISTINCT CASE WHEN mips_group_reporting = TRUE THEN group_id END)
      comment: "Number of groups reporting MIPS at group level"
    - name: "mips_group_reporting_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN mips_group_reporting = TRUE THEN group_id END) / NULLIF(COUNT(DISTINCT CASE WHEN mips_eligible = TRUE THEN group_id END), 0), 2)
      comment: "Percentage of MIPS-eligible groups using group reporting - impacts Medicare payment adjustments and administrative efficiency"
    - name: "aco_participating_groups"
      expr: COUNT(DISTINCT CASE WHEN aco_participant = TRUE THEN group_id END)
      comment: "Number of groups participating in ACOs"
    - name: "aco_group_participation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN aco_participant = TRUE THEN group_id END) / NULLIF(COUNT(DISTINCT CASE WHEN group_status = 'Active' THEN group_id END), 0), 2)
      comment: "Percentage of active groups in ACO arrangements - value-based care strategy penetration"
    - name: "fqhc_groups"
      expr: COUNT(DISTINCT CASE WHEN fqhc_designation = TRUE THEN group_id END)
      comment: "Number of groups with FQHC designation"
    - name: "rhc_groups"
      expr: COUNT(DISTINCT CASE WHEN rhc_designation = TRUE THEN group_id END)
      comment: "Number of groups with Rural Health Clinic designation"
    - name: "safety_net_group_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN fqhc_designation = TRUE OR rhc_designation = TRUE THEN group_id END) / NULLIF(COUNT(DISTINCT CASE WHEN group_status = 'Active' THEN group_id END), 0), 2)
      comment: "Percentage of active groups with FQHC or RHC designation - safety net provider coverage for underserved populations"
    - name: "telehealth_capable_groups"
      expr: COUNT(DISTINCT CASE WHEN telehealth_capable = TRUE THEN group_id END)
      comment: "Number of groups with telehealth capability"
    - name: "telehealth_group_penetration_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN telehealth_capable = TRUE THEN group_id END) / NULLIF(COUNT(DISTINCT CASE WHEN group_status = 'Active' THEN group_id END), 0), 2)
      comment: "Percentage of active groups with telehealth capability - digital health transformation metric"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_privileging`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hospital privileging metrics tracking clinical privilege grants, FPPE/OPPE requirements, peer review, and privilege lifecycle for medical staff credentialing and quality assurance."
  source: "`vibe_healthcare_v1`.`provider`.`privileging`"
  dimensions:
    - name: "privilege_status"
      expr: privilege_status
      comment: "Current status of the clinical privilege"
    - name: "privileging_status"
      expr: privileging_status
      comment: "Overall privileging status"
    - name: "privilege_type"
      expr: privilege_type
      comment: "Type of clinical privilege"
    - name: "privilege_category"
      expr: privilege_category
      comment: "Category of clinical privilege"
    - name: "is_provisional"
      expr: is_provisional
      comment: "Whether the privilege is provisional (requires FPPE)"
    - name: "fppe_required"
      expr: fppe_required
      comment: "Whether Focused Professional Practice Evaluation is required"
    - name: "board_certification_required"
      expr: board_certification_required
      comment: "Whether board certification is required for this privilege"
    - name: "telemedicine_authorized"
      expr: telemedicine_authorized
      comment: "Whether privilege is authorized for telemedicine delivery"
    - name: "emtala_covered"
      expr: emtala_covered
      comment: "Whether privilege covers EMTALA on-call obligations"
    - name: "training_requirement_met"
      expr: training_requirement_met
      comment: "Whether required training has been completed"
    - name: "malpractice_verified"
      expr: malpractice_verified
      comment: "Whether malpractice insurance has been verified"
    - name: "npdb_report_required"
      expr: npdb_report_required
      comment: "Whether NPDB reporting is required for this privilege"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the privilege was approved"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the privilege expires"
  measures:
    - name: "total_privileges"
      expr: COUNT(DISTINCT privileging_id)
      comment: "Total unique clinical privileges granted"
    - name: "active_privileges"
      expr: COUNT(DISTINCT CASE WHEN privilege_status = 'Active' THEN privileging_id END)
      comment: "Number of active clinical privileges"
    - name: "provisional_privileges"
      expr: COUNT(DISTINCT CASE WHEN is_provisional = TRUE THEN privileging_id END)
      comment: "Number of provisional privileges requiring FPPE"
    - name: "provisional_privilege_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_provisional = TRUE THEN privileging_id END) / NULLIF(COUNT(DISTINCT CASE WHEN privilege_status = 'Active' THEN privileging_id END), 0), 2)
      comment: "Percentage of active privileges that are provisional - indicates new practitioner onboarding volume"
    - name: "fppe_required_privileges"
      expr: COUNT(DISTINCT CASE WHEN fppe_required = TRUE THEN privileging_id END)
      comment: "Number of privileges requiring FPPE"
    - name: "fppe_completed_privileges"
      expr: COUNT(DISTINCT CASE WHEN fppe_completion_date IS NOT NULL THEN privileging_id END)
      comment: "Number of privileges with completed FPPE"
    - name: "fppe_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN fppe_completion_date IS NOT NULL THEN privileging_id END) / NULLIF(COUNT(DISTINCT CASE WHEN fppe_required = TRUE THEN privileging_id END), 0), 2)
      comment: "Percentage of FPPE-required privileges with completed evaluation - quality assurance and medical staff compliance metric"
    - name: "telemedicine_authorized_privileges"
      expr: COUNT(DISTINCT CASE WHEN telemedicine_authorized = TRUE THEN privileging_id END)
      comment: "Number of privileges authorized for telemedicine"
    - name: "telemedicine_privilege_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN telemedicine_authorized = TRUE THEN privileging_id END) / NULLIF(COUNT(DISTINCT CASE WHEN privilege_status = 'Active' THEN privileging_id END), 0), 2)
      comment: "Percentage of active privileges authorized for telemedicine - virtual care capability metric"
    - name: "emtala_covered_privileges"
      expr: COUNT(DISTINCT CASE WHEN emtala_covered = TRUE THEN privileging_id END)
      comment: "Number of privileges covering EMTALA on-call obligations"
    - name: "emtala_coverage_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN emtala_covered = TRUE THEN privileging_id END) / NULLIF(COUNT(DISTINCT CASE WHEN privilege_status = 'Active' THEN privileging_id END), 0), 2)
      comment: "Percentage of active privileges covering EMTALA obligations - emergency department on-call adequacy metric"
    - name: "training_compliant_privileges"
      expr: COUNT(DISTINCT CASE WHEN training_requirement_met = TRUE THEN privileging_id END)
      comment: "Number of privileges with completed training requirements"
    - name: "training_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN training_requirement_met = TRUE THEN privileging_id END) / NULLIF(COUNT(DISTINCT CASE WHEN privilege_status = 'Active' THEN privileging_id END), 0), 2)
      comment: "Percentage of active privileges with completed training - quality and safety compliance metric"
    - name: "avg_peer_review_score"
      expr: AVG(CAST(peer_review_score AS DOUBLE))
      comment: "Average peer review score across all privileges"
$$;