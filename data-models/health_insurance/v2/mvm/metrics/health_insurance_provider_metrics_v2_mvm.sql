-- Metric views for domain: provider | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-27 10:36:42

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_network_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks provider network participation health, panel status, credentialing pipeline, and telehealth enablement across health plans and lines of business. Core KPI surface for network adequacy and access management."
  source: "`vibe_health_insurance_v1`.`provider`.`participation_status`"
  dimensions:
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code (e.g., Commercial, Medicare, Medicaid) enabling participation analysis by product line."
    - name: "participation_category"
      expr: participation_category
      comment: "Broad category of participation (e.g., in-network, out-of-network, preferred) for network tier analysis."
    - name: "panel_status"
      expr: panel_status
      comment: "Provider panel status (open, closed, restricted) — key driver of member access and network adequacy."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Current credentialing status of the participation record, used to track pipeline and compliance."
    - name: "pcp_flag"
      expr: pcp_flag
      comment: "Indicates whether the participation record is for a Primary Care Provider, enabling PCP vs specialist segmentation."
    - name: "specialist_flag"
      expr: specialist_flag
      comment: "Indicates specialist participation, enabling specialist network adequacy analysis."
    - name: "telehealth_enabled_flag"
      expr: telehealth_enabled_flag
      comment: "Whether the provider has telehealth enabled under this participation record."
    - name: "termination_reason_code"
      expr: termination_reason_code
      comment: "Reason code for participation termination, used to analyze voluntary vs involuntary attrition."
    - name: "risk_arrangement_code"
      expr: risk_arrangement_code
      comment: "Risk arrangement type (e.g., FFS, capitation, value-based) for financial model segmentation."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month of participation effective start date for trend analysis of network growth."
    - name: "termination_date"
      expr: DATE_TRUNC('month', termination_date)
      comment: "Month of participation termination for attrition trend analysis."
  measures:
    - name: "total_participation_records"
      expr: COUNT(1)
      comment: "Total number of provider participation records. Baseline volume metric for network size tracking."
    - name: "active_participation_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN participation_status_id END)
      comment: "Count of currently active provider participation records. Core network adequacy KPI — tracks live in-network provider count."
    - name: "open_panel_provider_count"
      expr: COUNT(CASE WHEN panel_status = 'open' AND is_active = TRUE THEN participation_status_id END)
      comment: "Count of providers with open panels accepting new patients. Directly measures member access capacity."
    - name: "pcp_active_count"
      expr: COUNT(CASE WHEN pcp_flag = TRUE AND is_active = TRUE THEN participation_status_id END)
      comment: "Count of active Primary Care Provider participation records. Critical for PCP network adequacy and member-to-PCP ratio reporting."
    - name: "telehealth_enabled_count"
      expr: COUNT(CASE WHEN telehealth_enabled_flag = TRUE AND is_active = TRUE THEN participation_status_id END)
      comment: "Count of active providers with telehealth enabled. Tracks virtual care network capacity — a strategic access and cost KPI."
    - name: "terminated_participation_count"
      expr: COUNT(CASE WHEN termination_date IS NOT NULL THEN participation_status_id END)
      comment: "Count of terminated participation records. Tracks network attrition volume for retention and adequacy risk management."
    - name: "credentialing_pending_count"
      expr: COUNT(CASE WHEN credentialing_status NOT IN ('approved', 'active') AND is_active = TRUE THEN participation_status_id END)
      comment: "Count of active participation records with non-approved credentialing status. Flags compliance risk and pipeline bottlenecks."
    - name: "regulatory_sanction_count"
      expr: COUNT(CASE WHEN regulatory_sanction_flag = TRUE THEN participation_status_id END)
      comment: "Count of participation records with active regulatory sanctions. Critical compliance and risk KPI for regulatory reporting."
    - name: "accepting_new_patients_count"
      expr: COUNT(CASE WHEN accepting_new_patients_flag = TRUE AND is_active = TRUE THEN participation_status_id END)
      comment: "Count of active providers accepting new patients. Directly measures member access availability across the network."
    - name: "distinct_providers_in_network"
      expr: COUNT(DISTINCT provider_id)
      comment: "Count of distinct providers with at least one participation record. True network size metric used in adequacy filings."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_directory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures provider directory accuracy, completeness, telehealth availability, and attestation compliance. Supports CMS directory accuracy mandates and member-facing access transparency."
  source: "`vibe_health_insurance_v1`.`provider`.`directory_entry`"
  dimensions:
    - name: "provider_type"
      expr: provider_type
      comment: "Type of provider (e.g., MD, DO, NP, PA) for directory composition analysis."
    - name: "gender"
      expr: gender
      comment: "Provider gender for member preference matching and diversity reporting."
    - name: "pcp_flag"
      expr: pcp_flag
      comment: "Indicates PCP designation in the directory — key for member PCP assignment workflows."
    - name: "telehealth_available_flag"
      expr: telehealth_available_flag
      comment: "Whether the provider offers telehealth services as listed in the directory."
    - name: "attestation_status"
      expr: attestation_status
      comment: "Current attestation status of the directory entry — drives CMS directory accuracy compliance."
    - name: "accepting_new_patients_flag"
      expr: accepting_new_patients_flag
      comment: "Whether the provider is accepting new patients per the directory listing."
    - name: "directory_publication_date"
      expr: DATE_TRUNC('month', directory_publication_date)
      comment: "Month the directory entry was published, for freshness and update cadence analysis."
    - name: "last_verified_date"
      expr: DATE_TRUNC('month', last_verified_date)
      comment: "Month of last directory verification, used to identify stale entries requiring re-attestation."
  measures:
    - name: "total_directory_entries"
      expr: COUNT(1)
      comment: "Total directory entries. Baseline for directory size and coverage reporting."
    - name: "active_directory_entries"
      expr: COUNT(CASE WHEN is_active = TRUE THEN directory_entry_id END)
      comment: "Count of active directory entries. Core metric for live directory size reported to CMS and members."
    - name: "attested_entry_count"
      expr: COUNT(CASE WHEN attestation_status = 'attested' AND is_active = TRUE THEN directory_entry_id END)
      comment: "Count of directory entries with confirmed attestation. Measures compliance with CMS provider directory accuracy rules."
    - name: "telehealth_listed_count"
      expr: COUNT(CASE WHEN telehealth_available_flag = TRUE AND is_active = TRUE THEN directory_entry_id END)
      comment: "Count of directory entries listing telehealth availability. Tracks virtual care access transparency for members."
    - name: "accepting_new_patients_directory_count"
      expr: COUNT(CASE WHEN accepting_new_patients_flag = TRUE AND is_active = TRUE THEN directory_entry_id END)
      comment: "Count of active directory entries where provider is accepting new patients. Directly informs member access and PCP assignment capacity."
    - name: "pcp_directory_count"
      expr: COUNT(CASE WHEN pcp_flag = TRUE AND is_active = TRUE THEN directory_entry_id END)
      comment: "Count of active PCP directory entries. Used in PCP network adequacy and member-to-PCP ratio calculations."
    - name: "overdue_verification_count"
      expr: COUNT(CASE WHEN next_verification_due_date < CURRENT_DATE() AND is_active = TRUE THEN directory_entry_id END)
      comment: "Count of active directory entries past their verification due date. Flags directory accuracy risk and CMS compliance exposure."
    - name: "distinct_providers_in_directory"
      expr: COUNT(DISTINCT provider_id)
      comment: "Count of distinct providers with active directory listings. True directory breadth metric for network transparency reporting."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_credentialing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks provider specialty credentialing status, board certification rates, fellowship completion, and recredentialing pipeline. Supports quality, compliance, and network adequacy governance."
  source: "`vibe_health_insurance_v1`.`provider`.`specialty`"
  dimensions:
    - name: "specialty_type"
      expr: specialty_type
      comment: "Broad specialty type (e.g., primary care, surgical, behavioral health) for network composition analysis."
    - name: "category"
      expr: category
      comment: "Specialty category for grouping related specialties in adequacy and quality reporting."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Current credentialing status of the specialty record — core compliance dimension."
    - name: "network_adequacy_category"
      expr: network_adequacy_category
      comment: "Network adequacy classification for the specialty — used in state and federal adequacy filings."
    - name: "pcp_eligible_flag"
      expr: pcp_eligible_flag
      comment: "Whether this specialty qualifies the provider as a PCP — key for member assignment and adequacy."
    - name: "board_certified_flag"
      expr: board_certified_flag
      comment: "Whether the provider is board certified in this specialty — quality and credentialing KPI."
    - name: "primary_specialty_flag"
      expr: primary_specialty_flag
      comment: "Indicates the primary specialty designation for multi-specialty providers."
    - name: "telehealth_enabled_flag"
      expr: telehealth_enabled_flag
      comment: "Whether telehealth is enabled for this specialty — virtual care network composition."
    - name: "hedis_specialty_flag"
      expr: hedis_specialty_flag
      comment: "Whether this specialty is relevant to HEDIS measure reporting — quality program alignment."
    - name: "credentialing_review_date"
      expr: DATE_TRUNC('month', credentialing_review_date)
      comment: "Month of credentialing review for pipeline and workload trend analysis."
    - name: "next_credentialing_review_date"
      expr: DATE_TRUNC('month', next_credentialing_review_date)
      comment: "Month of next scheduled credentialing review — used to forecast credentialing workload."
  measures:
    - name: "total_specialty_records"
      expr: COUNT(1)
      comment: "Total specialty credentialing records. Baseline for credentialing pipeline volume."
    - name: "active_specialty_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN specialty_id END)
      comment: "Count of active specialty records. Measures live credentialed specialty coverage across the network."
    - name: "board_certified_count"
      expr: COUNT(CASE WHEN board_certified_flag = TRUE AND is_active = TRUE THEN specialty_id END)
      comment: "Count of active specialties with board certification. Key quality and credentialing KPI for network quality reporting."
    - name: "credentialing_approved_count"
      expr: COUNT(CASE WHEN credentialing_status = 'approved' AND is_active = TRUE THEN specialty_id END)
      comment: "Count of active specialties with approved credentialing status. Measures compliant credentialing pipeline throughput."
    - name: "credentialing_pending_count"
      expr: COUNT(CASE WHEN credentialing_status NOT IN ('approved', 'active') AND is_active = TRUE THEN specialty_id END)
      comment: "Count of active specialties with non-approved credentialing. Flags pipeline backlog and compliance risk."
    - name: "overdue_recredentialing_count"
      expr: COUNT(CASE WHEN next_credentialing_review_date < CURRENT_DATE() AND is_active = TRUE THEN specialty_id END)
      comment: "Count of active specialties past their recredentialing due date. Critical compliance KPI — overdue recredentialing creates regulatory and liability exposure."
    - name: "fellowship_completed_count"
      expr: COUNT(CASE WHEN fellowship_completed_flag = TRUE AND is_active = TRUE THEN specialty_id END)
      comment: "Count of active specialties where provider completed a fellowship. Quality indicator for subspecialty network depth."
    - name: "hedis_relevant_specialty_count"
      expr: COUNT(CASE WHEN hedis_specialty_flag = TRUE AND is_active = TRUE THEN specialty_id END)
      comment: "Count of active HEDIS-relevant specialty records. Tracks quality program provider coverage for HEDIS measure performance."
    - name: "distinct_credentialed_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Count of distinct providers with at least one specialty record. True credentialed provider headcount for network adequacy filings."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures facility network composition, quality ratings, credentialing status, and service capability (emergency, telehealth, trauma). Supports network adequacy, quality contracting, and regulatory compliance for facility providers."
  source: "`vibe_health_insurance_v1`.`provider`.`facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (e.g., hospital, ASC, SNF, urgent care) for network composition and adequacy analysis."
    - name: "state_code"
      expr: state_code
      comment: "State where the facility is located — essential for geographic network adequacy and regulatory reporting."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Current credentialing status of the facility — compliance and contracting pipeline dimension."
    - name: "participation_status"
      expr: participation_status
      comment: "Network participation status of the facility (in-network, out-of-network, etc.)."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier designation for the facility — drives member cost-sharing and benefit design."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Facility ownership type (e.g., for-profit, non-profit, government) for contracting and quality analysis."
    - name: "trauma_level"
      expr: trauma_level
      comment: "Trauma center designation level — critical for network adequacy in emergency and high-acuity care."
    - name: "teaching_hospital_flag"
      expr: teaching_hospital_flag
      comment: "Whether the facility is a teaching hospital — quality and academic medical center network tracking."
    - name: "critical_access_hospital_flag"
      expr: critical_access_hospital_flag
      comment: "Whether the facility is a Critical Access Hospital — rural network adequacy and CMS compliance dimension."
    - name: "medicare_certified_flag"
      expr: medicare_certified_flag
      comment: "Whether the facility is Medicare certified — required for Medicare Advantage network adequacy."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the facility became effective in the network — for network growth trend analysis."
  measures:
    - name: "total_facility_count"
      expr: COUNT(1)
      comment: "Total facility records. Baseline for facility network size reporting."
    - name: "active_facility_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN facility_id END)
      comment: "Count of currently active facilities in the network. Core network adequacy KPI for facility access."
    - name: "emergency_services_facility_count"
      expr: COUNT(CASE WHEN emergency_services_flag = TRUE AND is_active = TRUE THEN facility_id END)
      comment: "Count of active facilities with emergency services. Critical network adequacy metric for emergency care access."
    - name: "telehealth_enabled_facility_count"
      expr: COUNT(CASE WHEN telehealth_enabled_flag = TRUE AND is_active = TRUE THEN facility_id END)
      comment: "Count of active facilities with telehealth enabled. Tracks virtual care infrastructure across the facility network."
    - name: "medicare_certified_facility_count"
      expr: COUNT(CASE WHEN medicare_certified_flag = TRUE AND is_active = TRUE THEN facility_id END)
      comment: "Count of Medicare-certified active facilities. Required for Medicare Advantage network adequacy filings."
    - name: "credentialing_approved_facility_count"
      expr: COUNT(CASE WHEN credentialing_status = 'approved' AND is_active = TRUE THEN facility_id END)
      comment: "Count of active facilities with approved credentialing. Measures compliant facility credentialing pipeline."
    - name: "credentialing_expiring_soon_count"
      expr: COUNT(CASE WHEN credentialing_expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) AND is_active = TRUE THEN facility_id END)
      comment: "Count of active facilities with credentialing expiring within 90 days. Proactive compliance risk KPI for credentialing renewal management."
    - name: "avg_facility_quality_rating"
      expr: AVG(CAST(quality_rating AS DOUBLE))
      comment: "Average quality rating across facilities. Strategic KPI for network quality management and value-based contracting decisions."
    - name: "accepting_new_patients_facility_count"
      expr: COUNT(CASE WHEN accepting_new_patients_flag = TRUE AND is_active = TRUE THEN facility_id END)
      comment: "Count of active facilities accepting new patients. Measures facility-level access capacity for member assignment."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks provider license compliance, expiration risk, disciplinary actions, and telemedicine authorization across states. Supports credentialing, regulatory compliance, and multi-state practice governance."
  source: "`vibe_health_insurance_v1`.`provider`.`license`"
  dimensions:
    - name: "license_type"
      expr: license_type
      comment: "Type of license (e.g., MD, RN, LCSW) for license portfolio composition analysis."
    - name: "license_status"
      expr: license_status
      comment: "Current status of the license (active, expired, suspended, revoked) — core compliance dimension."
    - name: "issuing_state"
      expr: issuing_state
      comment: "State that issued the license — essential for multi-state practice and network adequacy by state."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Licensing authority (e.g., state medical board) for regulatory source tracking."
    - name: "telemedicine_authorized_flag"
      expr: telemedicine_authorized_flag
      comment: "Whether the license authorizes telemedicine practice — critical for virtual care network compliance."
    - name: "compact_participation_flag"
      expr: compact_participation_flag
      comment: "Whether the license participates in an interstate compact (e.g., NLC, IMLC) — enables multi-state practice tracking."
    - name: "disciplinary_action_flag"
      expr: disciplinary_action_flag
      comment: "Whether a disciplinary action is on record for this license — key risk and compliance dimension."
    - name: "continuing_education_required_flag"
      expr: continuing_education_required_flag
      comment: "Whether continuing education is required for license renewal — compliance pipeline dimension."
    - name: "expiration_date"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month of license expiration for renewal pipeline and compliance risk forecasting."
    - name: "issue_date"
      expr: DATE_TRUNC('year', issue_date)
      comment: "Year of license issuance for license tenure and cohort analysis."
  measures:
    - name: "total_license_count"
      expr: COUNT(1)
      comment: "Total license records. Baseline for license portfolio size and multi-state coverage reporting."
    - name: "active_license_count"
      expr: COUNT(CASE WHEN is_active = TRUE AND license_status = 'active' THEN license_id END)
      comment: "Count of currently active licenses. Core compliance KPI — active license count must meet network adequacy thresholds."
    - name: "expiring_within_90_days_count"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) AND is_active = TRUE THEN license_id END)
      comment: "Count of active licenses expiring within 90 days. Proactive compliance risk KPI — drives renewal outreach and credentialing action."
    - name: "expired_license_count"
      expr: COUNT(CASE WHEN expiration_date < CURRENT_DATE() AND is_active = TRUE THEN license_id END)
      comment: "Count of licenses that have expired but remain active in the system. Critical compliance gap metric — expired licenses create regulatory and liability risk."
    - name: "disciplinary_action_count"
      expr: COUNT(CASE WHEN disciplinary_action_flag = TRUE THEN license_id END)
      comment: "Count of licenses with disciplinary actions on record. Risk and quality KPI — disciplinary actions trigger credentialing review and potential network removal."
    - name: "telemedicine_authorized_license_count"
      expr: COUNT(CASE WHEN telemedicine_authorized_flag = TRUE AND is_active = TRUE THEN license_id END)
      comment: "Count of active licenses with telemedicine authorization. Measures virtual care practice compliance capacity across the network."
    - name: "compact_participation_license_count"
      expr: COUNT(CASE WHEN compact_participation_flag = TRUE AND is_active = TRUE THEN license_id END)
      comment: "Count of active licenses participating in interstate compacts. Tracks multi-state practice enablement — strategic for telehealth and cross-state network expansion."
    - name: "distinct_licensed_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Count of distinct providers with at least one license record. True licensed provider headcount for network compliance reporting."
    - name: "avg_continuing_education_hours_required"
      expr: AVG(CAST(continuing_education_hours_required AS DOUBLE))
      comment: "Average continuing education hours required per license. Informs CE compliance program design and provider education investment."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_practice_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures practice location network coverage, accessibility, geographic distribution, and telehealth availability. Supports network adequacy filings, member access analysis, and ADA compliance reporting."
  source: "`vibe_health_insurance_v1`.`provider`.`practice_location`"
  dimensions:
    - name: "state_code"
      expr: state_code
      comment: "State of the practice location — primary geographic dimension for network adequacy by state."
    - name: "location_type"
      expr: location_type
      comment: "Type of practice location (e.g., office, hospital outpatient, urgent care) for access point composition."
    - name: "participation_status"
      expr: participation_status
      comment: "Network participation status of the practice location."
    - name: "accepting_new_patients_flag"
      expr: accepting_new_patients_flag
      comment: "Whether the location is accepting new patients — direct member access capacity indicator."
    - name: "telehealth_available_flag"
      expr: telehealth_available_flag
      comment: "Whether telehealth is available at this location — virtual care access point tracking."
    - name: "wheelchair_accessible_flag"
      expr: wheelchair_accessible_flag
      comment: "Whether the location is wheelchair accessible — ADA compliance and member accessibility reporting."
    - name: "ada_compliant_flag"
      expr: ada_compliant_flag
      comment: "Whether the location is ADA compliant — regulatory compliance and member accessibility KPI."
    - name: "public_transportation_access_flag"
      expr: public_transportation_access_flag
      comment: "Whether the location is accessible by public transportation — social determinants of health and access equity dimension."
    - name: "zip_code"
      expr: zip_code
      comment: "ZIP code of the practice location for sub-state geographic access analysis."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the practice location became effective — for network growth trend analysis."
  measures:
    - name: "total_practice_location_count"
      expr: COUNT(1)
      comment: "Total practice location records. Baseline for network access point volume."
    - name: "active_practice_location_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN practice_location_id END)
      comment: "Count of currently active practice locations. Core network adequacy KPI — measures live access points for member care."
    - name: "accepting_new_patients_location_count"
      expr: COUNT(CASE WHEN accepting_new_patients_flag = TRUE AND is_active = TRUE THEN practice_location_id END)
      comment: "Count of active locations accepting new patients. Directly measures member access capacity across the network."
    - name: "telehealth_available_location_count"
      expr: COUNT(CASE WHEN telehealth_available_flag = TRUE AND is_active = TRUE THEN practice_location_id END)
      comment: "Count of active locations offering telehealth. Tracks virtual care access point density for member convenience and cost management."
    - name: "ada_compliant_location_count"
      expr: COUNT(CASE WHEN ada_compliant_flag = TRUE AND is_active = TRUE THEN practice_location_id END)
      comment: "Count of ADA-compliant active locations. Regulatory compliance KPI — ADA compliance is a federal requirement for network adequacy."
    - name: "wheelchair_accessible_location_count"
      expr: COUNT(CASE WHEN wheelchair_accessible_flag = TRUE AND is_active = TRUE THEN practice_location_id END)
      comment: "Count of wheelchair-accessible active locations. Member accessibility and equity KPI for disability access reporting."
    - name: "public_transit_accessible_location_count"
      expr: COUNT(CASE WHEN public_transportation_access_flag = TRUE AND is_active = TRUE THEN practice_location_id END)
      comment: "Count of active locations accessible by public transit. Social determinants of health access equity metric."
    - name: "overdue_verification_location_count"
      expr: COUNT(CASE WHEN last_verified_date < DATE_ADD(CURRENT_DATE(), -180) AND is_active = TRUE THEN practice_location_id END)
      comment: "Count of active locations not verified in the last 180 days. Directory accuracy and CMS compliance risk KPI."
    - name: "avg_latitude"
      expr: AVG(CAST(latitude AS DOUBLE))
      comment: "Average latitude of active practice locations. Used as a geographic centroid proxy for network distribution analysis."
    - name: "distinct_states_covered"
      expr: COUNT(DISTINCT state_code)
      comment: "Count of distinct states with active practice locations. Measures geographic network breadth for multi-state plan adequacy."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_affiliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks provider-facility and provider-group affiliations, credentialing verification status, and network participation linkages. Supports network integrity, directory accuracy, and credentialing governance."
  source: "`vibe_health_insurance_v1`.`provider`.`affiliation`"
  dimensions:
    - name: "affiliation_type"
      expr: affiliation_type
      comment: "Type of affiliation (e.g., admitting, consulting, employed, contracted) for network relationship analysis."
    - name: "affiliation_status"
      expr: affiliation_status
      comment: "Current status of the affiliation record — active, terminated, pending — for pipeline and compliance tracking."
    - name: "medical_staff_category"
      expr: medical_staff_category
      comment: "Medical staff category (e.g., active, courtesy, consulting) for hospital affiliation governance."
    - name: "admitting_privileges_flag"
      expr: admitting_privileges_flag
      comment: "Whether the provider has admitting privileges at the affiliated facility — critical for inpatient network adequacy."
    - name: "primary_affiliation_flag"
      expr: primary_affiliation_flag
      comment: "Whether this is the provider's primary affiliation — used to identify primary practice relationships."
    - name: "network_participation_flag"
      expr: network_participation_flag
      comment: "Whether the affiliation includes network participation — links affiliation to in-network status."
    - name: "directory_display_flag"
      expr: directory_display_flag
      comment: "Whether the affiliation is displayed in the provider directory — directory accuracy dimension."
    - name: "credentialing_verification_date"
      expr: DATE_TRUNC('month', credentialing_verification_date)
      comment: "Month of credentialing verification for the affiliation — pipeline and compliance trend analysis."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the affiliation became effective — for network relationship growth trend analysis."
  measures:
    - name: "total_affiliation_count"
      expr: COUNT(1)
      comment: "Total affiliation records. Baseline for provider-facility and provider-group relationship volume."
    - name: "active_affiliation_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN affiliation_id END)
      comment: "Count of currently active affiliations. Core network integrity KPI — active affiliations define the provider-facility relationship map."
    - name: "admitting_privileges_count"
      expr: COUNT(CASE WHEN admitting_privileges_flag = TRUE AND is_active = TRUE THEN affiliation_id END)
      comment: "Count of active affiliations with admitting privileges. Measures inpatient care access capacity — critical for hospital network adequacy."
    - name: "network_participating_affiliation_count"
      expr: COUNT(CASE WHEN network_participation_flag = TRUE AND is_active = TRUE THEN affiliation_id END)
      comment: "Count of active affiliations with network participation. Measures the depth of in-network provider-facility linkages."
    - name: "credentialing_overdue_affiliation_count"
      expr: COUNT(CASE WHEN next_credentialing_due_date < CURRENT_DATE() AND is_active = TRUE THEN affiliation_id END)
      comment: "Count of active affiliations with overdue credentialing. Compliance risk KPI — overdue credentialing at affiliated facilities creates liability exposure."
    - name: "directory_displayed_affiliation_count"
      expr: COUNT(CASE WHEN directory_display_flag = TRUE AND is_active = TRUE THEN affiliation_id END)
      comment: "Count of active affiliations displayed in the provider directory. Measures directory completeness for member-facing network transparency."
    - name: "distinct_affiliated_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Count of distinct providers with at least one active affiliation. Measures breadth of provider-facility network relationships."
    - name: "distinct_affiliated_facilities"
      expr: COUNT(DISTINCT facility_id)
      comment: "Count of distinct facilities with at least one active provider affiliation. Measures facility network engagement depth."
$$;