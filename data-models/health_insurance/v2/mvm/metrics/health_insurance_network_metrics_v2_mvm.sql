-- Metric views for domain: network | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-27 10:36:42

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_adequacy_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network adequacy assessment KPIs tracking compliance rates, gap severity, time-distance standards, and remediation performance across provider networks and health plans. Used by network management and regulatory affairs teams to monitor and steer adequacy compliance."
  source: "`vibe_health_insurance_v1`.`network`.`adequacy_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of adequacy assessment performed (e.g., initial, periodic, triggered) — used to segment compliance metrics by assessment category."
    - name: "network_type_code"
      expr: network_type_code
      comment: "Code identifying the network type (e.g., HMO, PPO, EPO) — enables adequacy analysis by network product type."
    - name: "specialty_type"
      expr: specialty_type
      comment: "Provider specialty category assessed — critical for identifying specialty-specific adequacy gaps."
    - name: "compliance_outcome"
      expr: compliance_outcome
      comment: "Regulatory compliance determination from the assessment (e.g., compliant, non-compliant, conditional) — primary dimension for compliance reporting."
    - name: "gap_severity"
      expr: gap_severity
      comment: "Severity classification of identified adequacy gaps (e.g., critical, moderate, minor) — used to prioritize remediation actions."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Current status of remediation actions for identified gaps — tracks operational follow-through on compliance failures."
    - name: "regulatory_submission_type"
      expr: regulatory_submission_type
      comment: "Type of regulatory submission associated with the assessment — used for regulatory reporting segmentation."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility covered by the adequacy assessment — enables facility-level adequacy analysis."
    - name: "assessment_year_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month of assessment date — enables trend analysis of adequacy compliance over time."
    - name: "submission_status"
      expr: submission_status
      comment: "Status of the regulatory submission for this assessment — tracks filing completeness."
    - name: "telehealth_offered"
      expr: CASE WHEN telehealth_offered_flag = TRUE THEN 'Telehealth Offered' ELSE 'No Telehealth' END
      comment: "Whether telehealth was offered as part of the assessed network — used to evaluate telehealth adequacy contributions."
    - name: "time_distance_compliant"
      expr: CASE WHEN time_distance_compliant_flag = TRUE THEN 'Compliant' ELSE 'Non-Compliant' END
      comment: "Whether the assessment met time-distance standards — key regulatory compliance dimension."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of adequacy assessments conducted — baseline volume metric for network adequacy program activity."
    - name: "compliant_assessment_count"
      expr: COUNT(CASE WHEN compliance_outcome = 'compliant' THEN 1 END)
      comment: "Number of assessments with a compliant outcome — numerator for compliance rate calculation."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_outcome = 'compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments resulting in a compliant outcome — primary regulatory KPI for network adequacy. Executives use this to gauge regulatory risk exposure."
    - name: "gap_identified_count"
      expr: COUNT(CASE WHEN gap_identified_flag = TRUE THEN 1 END)
      comment: "Number of assessments where an adequacy gap was identified — drives remediation workload and regulatory risk tracking."
    - name: "gap_identification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gap_identified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments that identified a network adequacy gap — key indicator of network health and regulatory exposure."
    - name: "time_distance_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN time_distance_compliant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments meeting time-distance access standards — critical regulatory metric for CMS and state DOI filings."
    - name: "avg_time_distance_compliance_pct"
      expr: ROUND(AVG(CAST(time_distance_compliance_percentage AS DOUBLE)), 2)
      comment: "Average time-distance compliance percentage across all assessments — measures how close the network is to meeting geographic access standards on average."
    - name: "avg_member_to_provider_ratio"
      expr: ROUND(AVG(CAST(member_to_provider_ratio AS DOUBLE)), 2)
      comment: "Average member-to-provider ratio across assessments — indicates provider capacity relative to membership; high ratios signal access risk."
    - name: "avg_member_to_pcp_ratio"
      expr: ROUND(AVG(CAST(member_to_pcp_ratio AS DOUBLE)), 2)
      comment: "Average member-to-PCP ratio across assessments — primary care access indicator; elevated ratios trigger network expansion decisions."
    - name: "avg_time_distance_standard_miles"
      expr: ROUND(AVG(CAST(time_distance_standard_miles AS DOUBLE)), 2)
      comment: "Average time-distance standard in miles applied across assessments — contextualizes compliance rates against the stringency of applicable standards."
    - name: "remediation_pending_count"
      expr: COUNT(CASE WHEN gap_identified_flag = TRUE AND remediation_status NOT IN ('completed', 'resolved') THEN 1 END)
      comment: "Number of assessments with open gaps awaiting remediation — operational metric for network management teams to prioritize corrective actions."
    - name: "gold_card_provider_total"
      expr: SUM(CAST(gold_card_provider_count AS DOUBLE))
      comment: "Total count of gold-card designated providers across all assessments — tracks high-quality provider participation in the network."
    - name: "telehealth_offered_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN telehealth_offered_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments where telehealth was offered — measures telehealth network penetration, relevant for regulatory telehealth equivalency credit."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_adequacy_standard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network adequacy standard configuration metrics tracking regulatory thresholds, telehealth allowances, and standard coverage by line of business and geography. Used by regulatory affairs and network strategy teams to manage compliance frameworks."
  source: "`vibe_health_insurance_v1`.`network`.`adequacy_standard`"
  dimensions:
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business the adequacy standard applies to (e.g., Medicaid, Medicare, Commercial) — primary segmentation for regulatory standard analysis."
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type covered by the standard (e.g., HMO, PPO) — used to segment standards by product type."
    - name: "geographic_classification"
      expr: geographic_classification
      comment: "Geographic classification (e.g., urban, rural, frontier) — standards vary significantly by geography; critical for compliance analysis."
    - name: "specialty_category"
      expr: specialty_category
      comment: "Specialty category the standard governs — enables specialty-level adequacy standard tracking."
    - name: "standard_category"
      expr: standard_category
      comment: "Broad category of the adequacy standard (e.g., time-distance, ratio, wait-time) — used to group standards by type for compliance program management."
    - name: "regulatory_source"
      expr: regulatory_source
      comment: "Regulatory body or rule that mandates the standard (e.g., CMS, state DOI) — used to track compliance obligations by regulatory authority."
    - name: "adequacy_standard_status"
      expr: adequacy_standard_status
      comment: "Current status of the adequacy standard (e.g., active, superseded, draft) — used to filter to operative standards."
    - name: "telehealth_equivalency_allowed"
      expr: CASE WHEN telehealth_equivalency_allowed = TRUE THEN 'Telehealth Equivalency Allowed' ELSE 'Not Allowed' END
      comment: "Whether telehealth counts toward adequacy compliance under this standard — key dimension for telehealth network strategy."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the adequacy standard became effective — used to track evolution of regulatory requirements over time."
  measures:
    - name: "total_active_standards"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Total number of active adequacy standards in force — baseline measure of regulatory compliance framework scope."
    - name: "avg_maximum_distance_miles"
      expr: ROUND(AVG(CAST(maximum_distance_miles AS DOUBLE)), 2)
      comment: "Average maximum distance standard in miles across all active standards — benchmarks the stringency of geographic access requirements."
    - name: "avg_threshold_percentage"
      expr: ROUND(AVG(CAST(threshold_percentage AS DOUBLE)), 2)
      comment: "Average compliance threshold percentage required across standards — indicates the overall stringency of adequacy requirements the network must meet."
    - name: "avg_telehealth_percentage_cap"
      expr: ROUND(AVG(CAST(telehealth_percentage_cap AS DOUBLE)), 2)
      comment: "Average telehealth percentage cap allowed across standards — informs network strategy on how much telehealth can substitute for in-person access."
    - name: "telehealth_equivalency_allowed_count"
      expr: COUNT(CASE WHEN telehealth_equivalency_allowed = TRUE THEN 1 END)
      comment: "Number of standards that allow telehealth equivalency credit — measures the breadth of telehealth flexibility in the regulatory framework."
    - name: "after_hours_required_count"
      expr: COUNT(CASE WHEN after_hours_availability_required = TRUE THEN 1 END)
      comment: "Number of standards requiring after-hours provider availability — quantifies the scope of after-hours access obligations across the network."
    - name: "standards_with_penalty_count"
      expr: COUNT(CASE WHEN penalty_for_non_compliance IS NOT NULL AND penalty_for_non_compliance <> '' THEN 1 END)
      comment: "Number of standards that carry explicit penalties for non-compliance — used by executives to prioritize high-risk compliance areas."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_par_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Participating provider agreement KPIs covering agreement lifecycle, credentialing status, amendment activity, and termination risk. Used by network contracting and credentialing teams to manage provider participation and contract compliance."
  source: "`vibe_health_insurance_v1`.`network`.`par_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of participation agreement (e.g., individual, group, facility) — primary segmentation for contract portfolio analysis."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the agreement (e.g., active, terminated, pending) — used to filter and segment the active contract portfolio."
    - name: "lob"
      expr: lob
      comment: "Line of business covered by the agreement (e.g., Commercial, Medicare, Medicaid) — enables contract analysis by business segment."
    - name: "participation_status"
      expr: participation_status
      comment: "Provider participation status under the agreement — tracks whether providers are actively participating."
    - name: "provider_credentialing_status"
      expr: provider_credentialing_status
      comment: "Credentialing status of the provider under this agreement — critical for network quality and regulatory compliance."
    - name: "reimbursement_methodology"
      expr: reimbursement_methodology
      comment: "Reimbursement methodology specified in the agreement (e.g., fee-for-service, capitation, VBC) — used to analyze contract mix by payment model."
    - name: "termination_reason_code"
      expr: termination_reason_code
      comment: "Reason code for agreement termination — used to analyze patterns in provider departures from the network."
    - name: "provider_participation_role"
      expr: provider_participation_role
      comment: "Role of the provider under the agreement (e.g., PCP, specialist, facility) — enables role-based contract analysis."
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the agreement became effective — used for cohort and vintage analysis of the contract portfolio."
    - name: "amendment_flag_label"
      expr: CASE WHEN amendment_flag = TRUE THEN 'Amended' ELSE 'Original' END
      comment: "Whether the agreement has been amended — used to track contract modification activity."
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total number of participation agreements — baseline measure of network contracting portfolio size."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'active' AND is_active = TRUE THEN 1 END)
      comment: "Number of currently active participation agreements — measures the live contracted provider base."
    - name: "active_agreement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN agreement_status = 'active' AND is_active = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements that are currently active — indicates the health and retention rate of the contracted network."
    - name: "terminated_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'terminated' OR termination_date IS NOT NULL THEN 1 END)
      comment: "Number of terminated agreements — tracks provider attrition from the network; rising terminations signal network stability risk."
    - name: "termination_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN agreement_status = 'terminated' OR termination_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements that have been terminated — key network retention KPI; high rates indicate contracting or relationship issues."
    - name: "credentialed_provider_count"
      expr: COUNT(CASE WHEN provider_credentialing_status = 'credentialed' THEN 1 END)
      comment: "Number of agreements with fully credentialed providers — measures the credentialed network size, a regulatory and quality requirement."
    - name: "credentialing_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN provider_credentialing_status = 'credentialed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements with completed provider credentialing — critical quality and compliance KPI; uncredentialed providers create regulatory and liability risk."
    - name: "amendment_count"
      expr: COUNT(CASE WHEN amendment_flag = TRUE THEN 1 END)
      comment: "Number of agreements that have been amended — high amendment rates may indicate contract instability or frequent renegotiation."
    - name: "amendment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN amendment_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements that have been amended — measures contract modification frequency; used to assess contracting complexity and stability."
    - name: "directory_listed_count"
      expr: COUNT(CASE WHEN provider_directory_listing_flag = TRUE THEN 1 END)
      comment: "Number of agreements where the provider is listed in the provider directory — measures directory completeness, a CMS and state regulatory requirement."
    - name: "directory_listing_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN provider_directory_listing_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of active agreements with provider directory listings — regulatory compliance KPI; low rates trigger CMS and state enforcement actions."
    - name: "recredentialing_due_count"
      expr: COUNT(CASE WHEN provider_recredentialing_due_date <= CURRENT_DATE() AND provider_credentialing_status <> 'recredentialed' THEN 1 END)
      comment: "Number of agreements where provider recredentialing is past due — operational risk metric; overdue recredentialing creates regulatory and quality exposure."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_provider_network`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider network portfolio KPIs covering network status, accreditation, adequacy filing, and quality ratings. Used by network strategy, regulatory affairs, and executive leadership to manage the network portfolio and regulatory standing."
  source: "`vibe_health_insurance_v1`.`network`.`provider_network`"
  dimensions:
    - name: "network_type"
      expr: network_type
      comment: "Type of provider network (e.g., HMO, PPO, EPO, POS) — primary segmentation for network portfolio analysis."
    - name: "network_status"
      expr: network_status
      comment: "Current operational status of the network (e.g., active, inactive, pending) — used to filter to live networks."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business the network serves (e.g., Commercial, Medicare, Medicaid) — enables network analysis by business segment."
    - name: "network_adequacy_status"
      expr: network_adequacy_status
      comment: "Current adequacy compliance status of the network — key regulatory dimension for network management."
    - name: "ncqa_accreditation_status"
      expr: ncqa_accreditation_status
      comment: "NCQA accreditation status of the network — quality and market differentiation dimension used in competitive positioning."
    - name: "service_area_type"
      expr: service_area_type
      comment: "Type of service area (e.g., statewide, regional, county) — used to analyze network coverage scope."
    - name: "tier_classification"
      expr: tier_classification
      comment: "Tier classification of the network — used to segment networks by quality or cost-sharing tier."
    - name: "vbc_arrangement"
      expr: CASE WHEN vbc_arrangement_flag = TRUE THEN 'VBC Network' ELSE 'Traditional Network' END
      comment: "Whether the network has a value-based care arrangement — used to track VBC network penetration across the portfolio."
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the network became effective — used for portfolio vintage and cohort analysis."
  measures:
    - name: "total_networks"
      expr: COUNT(1)
      comment: "Total number of provider networks in the portfolio — baseline measure of network portfolio breadth."
    - name: "active_network_count"
      expr: COUNT(CASE WHEN is_active = TRUE AND network_status = 'active' THEN 1 END)
      comment: "Number of currently active provider networks — measures the live network portfolio size available to members."
    - name: "adequacy_compliant_network_count"
      expr: COUNT(CASE WHEN network_adequacy_status = 'compliant' THEN 1 END)
      comment: "Number of networks with compliant adequacy status — measures regulatory compliance across the network portfolio."
    - name: "adequacy_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN network_adequacy_status = 'compliant' THEN 1 END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active networks with compliant adequacy status — top-line regulatory KPI for executive and board reporting."
    - name: "ncqa_accredited_network_count"
      expr: COUNT(CASE WHEN ncqa_accreditation_status = 'accredited' THEN 1 END)
      comment: "Number of NCQA-accredited networks — quality credential metric used in competitive positioning and employer contracting."
    - name: "ncqa_accreditation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ncqa_accreditation_status = 'accredited' THEN 1 END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active networks with NCQA accreditation — quality KPI used in market differentiation and employer RFP responses."
    - name: "avg_star_rating"
      expr: ROUND(AVG(CAST(star_rating AS DOUBLE)), 2)
      comment: "Average star rating across provider networks — quality performance KPI directly tied to CMS bonus payments and member plan selection."
    - name: "vbc_network_count"
      expr: COUNT(CASE WHEN vbc_arrangement_flag = TRUE THEN 1 END)
      comment: "Number of networks with value-based care arrangements — tracks VBC strategy execution across the network portfolio."
    - name: "vbc_network_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN vbc_arrangement_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active networks with VBC arrangements — strategic KPI measuring progress toward value-based care transformation goals."
    - name: "out_of_network_coverage_count"
      expr: COUNT(CASE WHEN out_of_network_coverage_flag = TRUE THEN 1 END)
      comment: "Number of networks offering out-of-network coverage — measures product flexibility across the network portfolio."
    - name: "adequacy_filing_pending_count"
      expr: COUNT(CASE WHEN network_adequacy_filing_date IS NULL AND is_active = TRUE THEN 1 END)
      comment: "Number of active networks without a completed adequacy filing — regulatory risk metric; unfiled networks face regulatory sanctions."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_provider_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider network assignment KPIs covering panel capacity, credentialing status, telehealth availability, and access attributes. Used by network operations and access management teams to monitor provider participation quality and capacity."
  source: "`vibe_health_insurance_v1`.`network`.`provider_assignment`"
  dimensions:
    - name: "network_participation_type"
      expr: network_participation_type
      comment: "Type of network participation (e.g., in-network, preferred, tiered) — primary segmentation for assignment analysis."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status of the provider assignment — used to track quality and compliance of the assigned provider base."
    - name: "panel_status"
      expr: panel_status
      comment: "Status of the provider's patient panel (e.g., open, closed, limited) — critical for member access and PCP assignment operations."
    - name: "network_adequacy_category"
      expr: network_adequacy_category
      comment: "Adequacy category assigned to this provider (e.g., PCP, specialist, behavioral health) — used to track adequacy contributions by provider type."
    - name: "quality_tier_designation"
      expr: quality_tier_designation
      comment: "Quality tier designation of the provider — used to analyze quality distribution across the network."
    - name: "geographic_service_area"
      expr: geographic_service_area
      comment: "Geographic service area of the provider assignment — enables geographic access analysis."
    - name: "pcp_flag_label"
      expr: CASE WHEN pcp_flag = TRUE THEN 'PCP' ELSE 'Non-PCP' END
      comment: "Whether the provider is assigned as a primary care provider — used to segment PCP vs. specialist network metrics."
    - name: "telehealth_available_label"
      expr: CASE WHEN telehealth_available_flag = TRUE THEN 'Telehealth Available' ELSE 'In-Person Only' END
      comment: "Whether the provider offers telehealth services — used to measure telehealth network penetration."
    - name: "vbc_participant_label"
      expr: CASE WHEN vbc_participant_flag = TRUE THEN 'VBC Participant' ELSE 'Non-VBC' END
      comment: "Whether the provider participates in a value-based care arrangement — tracks VBC provider penetration in the network."
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the provider assignment became effective — used for cohort analysis of network composition over time."
  measures:
    - name: "total_provider_assignments"
      expr: COUNT(1)
      comment: "Total number of provider network assignments — baseline measure of network provider roster size."
    - name: "active_assignment_count"
      expr: COUNT(CASE WHEN is_active = TRUE AND participation_status = 'active' THEN 1 END)
      comment: "Number of currently active provider assignments — measures the live provider roster available to members."
    - name: "accepting_new_patients_count"
      expr: COUNT(CASE WHEN accepting_new_patients_flag = TRUE AND is_active = TRUE THEN 1 END)
      comment: "Number of active providers accepting new patients — critical access metric; low counts indicate member access barriers."
    - name: "accepting_new_patients_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN accepting_new_patients_flag = TRUE AND is_active = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active providers accepting new patients — top-line access KPI; declining rates trigger network expansion actions."
    - name: "credentialed_assignment_count"
      expr: COUNT(CASE WHEN credentialing_status = 'credentialed' AND is_active = TRUE THEN 1 END)
      comment: "Number of active assignments with fully credentialed providers — quality and compliance measure for the active network."
    - name: "credentialing_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN credentialing_status = 'credentialed' AND is_active = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active assignments with credentialed providers — regulatory compliance KPI; non-credentialed providers create liability and regulatory risk."
    - name: "telehealth_available_count"
      expr: COUNT(CASE WHEN telehealth_available_flag = TRUE AND is_active = TRUE THEN 1 END)
      comment: "Number of active providers offering telehealth — measures telehealth network capacity for member access and adequacy credit."
    - name: "telehealth_penetration_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN telehealth_available_flag = TRUE AND is_active = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active providers offering telehealth — strategic KPI for digital access and adequacy strategy; tracked by executives for member experience goals."
    - name: "vbc_participant_count"
      expr: COUNT(CASE WHEN vbc_participant_flag = TRUE AND is_active = TRUE THEN 1 END)
      comment: "Number of active providers participating in VBC arrangements — measures VBC network penetration, a key strategic transformation metric."
    - name: "vbc_participation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN vbc_participant_flag = TRUE AND is_active = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active providers in VBC arrangements — strategic KPI for value-based care transformation progress."
    - name: "pcp_count"
      expr: COUNT(CASE WHEN pcp_flag = TRUE AND is_active = TRUE THEN 1 END)
      comment: "Number of active primary care providers in the network — foundational adequacy metric; PCP shortages directly impact member access and regulatory compliance."
    - name: "recredentialing_overdue_count"
      expr: COUNT(CASE WHEN recredentialing_due_date <= CURRENT_DATE() AND is_active = TRUE THEN 1 END)
      comment: "Number of active providers with overdue recredentialing — operational risk metric; overdue recredentialing creates regulatory and quality exposure requiring immediate action."
    - name: "after_hours_available_count"
      expr: COUNT(CASE WHEN after_hours_availability_flag = TRUE AND is_active = TRUE THEN 1 END)
      comment: "Number of active providers offering after-hours availability — access quality metric tied to adequacy standards requiring after-hours care."
    - name: "after_hours_availability_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN after_hours_availability_flag = TRUE AND is_active = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active providers offering after-hours availability — access quality KPI relevant to adequacy standard compliance and member satisfaction."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_provider_directory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider directory accuracy and verification KPIs tracking listing completeness, verification currency, and telehealth availability. Used by network operations and compliance teams to maintain CMS-mandated directory accuracy requirements."
  source: "`vibe_health_insurance_v1`.`network`.`provider_directory`"
  dimensions:
    - name: "directory_status"
      expr: directory_status
      comment: "Current status of the directory listing (e.g., active, inactive, pending) — primary filter dimension for directory analysis."
    - name: "directory_publication_channel"
      expr: directory_publication_channel
      comment: "Channel through which the directory listing is published (e.g., web, print, API) — used to analyze directory coverage by publication method."
    - name: "last_verification_method"
      expr: last_verification_method
      comment: "Method used for the most recent directory verification (e.g., phone, mail, portal) — used to assess verification process quality."
    - name: "last_verification_outcome"
      expr: last_verification_outcome
      comment: "Outcome of the most recent verification attempt (e.g., confirmed, unresponsive, incorrect) — key dimension for directory accuracy analysis."
    - name: "board_certification_status"
      expr: board_certification_status
      comment: "Board certification status of the listed provider — quality dimension for directory completeness and accuracy."
    - name: "gender"
      expr: gender
      comment: "Gender of the listed provider — used for network diversity and member preference matching analysis."
    - name: "county"
      expr: county
      comment: "County of the provider's practice location — geographic dimension for directory coverage analysis."
    - name: "telehealth_available_label"
      expr: CASE WHEN telehealth_available_flag = TRUE THEN 'Telehealth Available' ELSE 'In-Person Only' END
      comment: "Whether the listed provider offers telehealth — used to measure telehealth directory coverage."
    - name: "verification_year_month"
      expr: DATE_TRUNC('month', last_verified_date)
      comment: "Month of last directory verification — used to trend verification activity and identify aging listings."
  measures:
    - name: "total_directory_listings"
      expr: COUNT(1)
      comment: "Total number of provider directory listings — baseline measure of directory size and coverage."
    - name: "active_listing_count"
      expr: COUNT(CASE WHEN is_active = TRUE AND directory_status = 'active' THEN 1 END)
      comment: "Number of currently active directory listings — measures the live published provider directory size."
    - name: "verified_listing_count"
      expr: COUNT(CASE WHEN last_verification_outcome = 'confirmed' AND is_active = TRUE THEN 1 END)
      comment: "Number of active listings with confirmed verification — measures directory accuracy, a CMS regulatory requirement with financial penalties for non-compliance."
    - name: "directory_accuracy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN last_verification_outcome = 'confirmed' AND is_active = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active listings with confirmed accuracy — primary CMS directory compliance KPI; rates below 95% trigger regulatory enforcement actions."
    - name: "avg_data_quality_score"
      expr: ROUND(AVG(CAST(data_quality_score AS DOUBLE)), 2)
      comment: "Average data quality score across directory listings — measures overall directory data integrity; low scores indicate systemic data quality issues requiring remediation."
    - name: "overdue_verification_count"
      expr: COUNT(CASE WHEN next_verification_due_date <= CURRENT_DATE() AND is_active = TRUE THEN 1 END)
      comment: "Number of active listings with overdue verification — operational compliance metric; CMS requires directory verification within 90 days; overdue listings create regulatory risk."
    - name: "overdue_verification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN next_verification_due_date <= CURRENT_DATE() AND is_active = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active listings with overdue verification — regulatory risk KPI; high rates indicate systemic verification process failures requiring executive intervention."
    - name: "telehealth_listed_count"
      expr: COUNT(CASE WHEN telehealth_available_flag = TRUE AND is_active = TRUE THEN 1 END)
      comment: "Number of active directory listings indicating telehealth availability — measures telehealth directory coverage for member access and adequacy credit."
    - name: "telehealth_directory_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN telehealth_available_flag = TRUE AND is_active = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active directory listings with telehealth availability — strategic access KPI measuring telehealth network visibility to members."
    - name: "ada_compliant_listing_count"
      expr: COUNT(CASE WHEN ada_compliant_flag = TRUE AND is_active = TRUE THEN 1 END)
      comment: "Number of active directory listings for ADA-compliant facilities — accessibility compliance metric relevant to CMS and state accessibility requirements."
    - name: "ada_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ada_compliant_flag = TRUE AND is_active = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active directory listings for ADA-compliant facilities — accessibility KPI used in regulatory filings and member accessibility reporting."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_plan_association`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health plan to provider network association KPIs covering network adequacy certification, VBC arrangement penetration, and plan-network linkage quality. Used by product management and network strategy teams to manage plan-network relationships."
  source: "`vibe_health_insurance_v1`.`network`.`plan_association`"
  dimensions:
    - name: "association_type"
      expr: association_type
      comment: "Type of plan-network association (e.g., primary, supplemental, exclusive) — primary segmentation for plan-network relationship analysis."
    - name: "lob"
      expr: lob
      comment: "Line of business for the plan-network association (e.g., Commercial, Medicare, Medicaid) — enables analysis by business segment."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment of the health plan (e.g., individual, small group, large group) — used to analyze network associations by market."
    - name: "network_adequacy_status"
      expr: network_adequacy_status
      comment: "Adequacy status of the network for this plan association — regulatory compliance dimension."
    - name: "network_tier"
      expr: network_tier
      comment: "Tier designation of the network within the plan (e.g., preferred, standard) — used to analyze tiered network strategy."
    - name: "plan_association_status"
      expr: plan_association_status
      comment: "Current status of the plan-network association — used to filter to active associations."
    - name: "vbc_arrangement_label"
      expr: CASE WHEN vbc_arrangement_flag = TRUE THEN 'VBC Arrangement' ELSE 'Traditional' END
      comment: "Whether the plan-network association includes a VBC arrangement — tracks VBC strategy execution at the plan-network level."
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the plan-network association became effective — used for portfolio vintage analysis."
  measures:
    - name: "total_plan_associations"
      expr: COUNT(1)
      comment: "Total number of plan-network associations — baseline measure of plan-network linkage portfolio size."
    - name: "active_association_count"
      expr: COUNT(CASE WHEN is_active = TRUE AND plan_association_status = 'active' THEN 1 END)
      comment: "Number of currently active plan-network associations — measures the live plan-network portfolio."
    - name: "adequacy_certified_count"
      expr: COUNT(CASE WHEN adequacy_certification_date IS NOT NULL AND is_active = TRUE THEN 1 END)
      comment: "Number of active plan-network associations with completed adequacy certification — regulatory compliance measure for plan filings."
    - name: "adequacy_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN adequacy_certification_date IS NOT NULL AND is_active = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active plan-network associations with adequacy certification — top-line regulatory compliance KPI for plan filings with CMS and state regulators."
    - name: "vbc_association_count"
      expr: COUNT(CASE WHEN vbc_arrangement_flag = TRUE AND is_active = TRUE THEN 1 END)
      comment: "Number of active plan-network associations with VBC arrangements — measures VBC strategy penetration at the plan-network level."
    - name: "vbc_association_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN vbc_arrangement_flag = TRUE AND is_active = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active plan-network associations with VBC arrangements — strategic KPI for value-based care transformation progress at the plan level."
    - name: "directory_published_count"
      expr: COUNT(CASE WHEN directory_publication_flag = TRUE AND is_active = TRUE THEN 1 END)
      comment: "Number of active plan-network associations with published provider directories — regulatory compliance measure; unpublished directories violate CMS transparency requirements."
    - name: "directory_publication_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN directory_publication_flag = TRUE AND is_active = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active plan-network associations with published directories — CMS transparency compliance KPI; low rates trigger regulatory enforcement."
    - name: "aco_participation_count"
      expr: COUNT(CASE WHEN aco_participation_flag = TRUE AND is_active = TRUE THEN 1 END)
      comment: "Number of active plan-network associations with ACO participation — measures ACO strategy penetration across the plan portfolio."
    - name: "star_rating_impact_count"
      expr: COUNT(CASE WHEN star_rating_impact_flag = TRUE AND is_active = TRUE THEN 1 END)
      comment: "Number of active plan-network associations flagged as impacting star ratings — used to prioritize network management actions that affect CMS star rating performance and bonus payments."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_tier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network tier configuration and cost-sharing differential KPIs used to analyze tiered network design, member steerage incentives, and VBC eligibility. Used by product management and actuarial teams to design and evaluate tiered network benefit structures."
  source: "`vibe_health_insurance_v1`.`network`.`tier`"
  dimensions:
    - name: "tier_type"
      expr: tier_type
      comment: "Type of network tier (e.g., preferred, standard, out-of-network) — primary segmentation for tier analysis."
    - name: "tier_status"
      expr: tier_status
      comment: "Current status of the tier configuration (e.g., active, inactive) — used to filter to operative tiers."
    - name: "cost_share_differential_type"
      expr: cost_share_differential_type
      comment: "Type of cost-sharing differential applied to this tier (e.g., copay, coinsurance, deductible) — used to analyze benefit design by differential type."
    - name: "specialty_applicability"
      expr: specialty_applicability
      comment: "Specialty types to which the tier applies — used to analyze tier design by specialty category."
    - name: "facility_type_applicability"
      expr: facility_type_applicability
      comment: "Facility types to which the tier applies — used to analyze tier design by facility category."
    - name: "quality_tier_flag_label"
      expr: CASE WHEN quality_tier_flag = TRUE THEN 'Quality Tier' ELSE 'Standard Tier' END
      comment: "Whether the tier is designated as a quality tier — used to segment quality-based tiering from cost-based tiering."
    - name: "vbc_arrangement_eligible_label"
      expr: CASE WHEN vbc_arrangement_eligible_flag = TRUE THEN 'VBC Eligible' ELSE 'Not VBC Eligible' END
      comment: "Whether the tier is eligible for VBC arrangements — used to track VBC-aligned tier design."
    - name: "prior_authorization_required_label"
      expr: CASE WHEN prior_authorization_required_flag = TRUE THEN 'PA Required' ELSE 'No PA Required' END
      comment: "Whether prior authorization is required for this tier — used to analyze utilization management design across tiers."
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the tier configuration became effective — used for benefit design evolution analysis."
  measures:
    - name: "total_tiers"
      expr: COUNT(1)
      comment: "Total number of network tier configurations — baseline measure of tiered network design complexity."
    - name: "active_tier_count"
      expr: COUNT(CASE WHEN is_active = TRUE AND tier_status = 'active' THEN 1 END)
      comment: "Number of currently active tier configurations — measures the live tiered network benefit structure."
    - name: "avg_copay_differential_amount"
      expr: ROUND(AVG(CAST(copay_differential_amount AS DOUBLE)), 2)
      comment: "Average copay differential amount across tiers — measures the financial steerage incentive built into tiered network design; higher differentials drive stronger member steerage."
    - name: "avg_coinsurance_differential_pct"
      expr: ROUND(AVG(CAST(coinsurance_differential_percentage AS DOUBLE)), 2)
      comment: "Average coinsurance differential percentage across tiers — measures the coinsurance-based steerage incentive; used by actuarial teams to calibrate benefit design."
    - name: "quality_tier_count"
      expr: COUNT(CASE WHEN quality_tier_flag = TRUE AND is_active = TRUE THEN 1 END)
      comment: "Number of active quality-designated tiers — measures the breadth of quality-based tiering in the network benefit design."
    - name: "quality_tier_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_tier_flag = TRUE AND is_active = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active tiers with quality designation — measures quality-based tiering penetration; used to assess alignment of benefit design with quality improvement goals."
    - name: "vbc_eligible_tier_count"
      expr: COUNT(CASE WHEN vbc_arrangement_eligible_flag = TRUE AND is_active = TRUE THEN 1 END)
      comment: "Number of active tiers eligible for VBC arrangements — measures VBC-aligned benefit design scope."
    - name: "vbc_eligible_tier_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN vbc_arrangement_eligible_flag = TRUE AND is_active = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active tiers eligible for VBC arrangements — strategic KPI for value-based benefit design transformation."
    - name: "prior_auth_required_tier_count"
      expr: COUNT(CASE WHEN prior_authorization_required_flag = TRUE AND is_active = TRUE THEN 1 END)
      comment: "Number of active tiers requiring prior authorization — measures utilization management burden in the tiered network design; high counts may impact member experience."
    - name: "network_adequacy_credit_tier_count"
      expr: COUNT(CASE WHEN network_adequacy_credit_flag = TRUE AND is_active = TRUE THEN 1 END)
      comment: "Number of active tiers that qualify for network adequacy credit — measures the scope of adequacy-credited tier configurations, relevant for regulatory adequacy filings."
$$;