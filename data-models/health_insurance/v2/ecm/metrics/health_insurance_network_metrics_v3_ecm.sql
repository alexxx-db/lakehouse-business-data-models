-- Metric views for domain: network | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 20:04:11

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_provider_network`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core network performance and adequacy metrics for provider networks, including provider counts, member enrollment, and quality ratings"
  source: "`vibe_health_insurance_v1`.`network`.`provider_network`"
  dimensions:
    - name: "network_code"
      expr: network_code
      comment: "Unique identifier code for the provider network"
    - name: "network_name"
      expr: network_name
      comment: "Business name of the provider network"
    - name: "network_type"
      expr: network_type
      comment: "Classification of network (e.g., HMO, PPO, EPO)"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business served by the network (e.g., Commercial, Medicare, Medicaid)"
    - name: "network_status"
      expr: network_status
      comment: "Current operational status of the network"
    - name: "tier_classification"
      expr: tier_classification
      comment: "Tier level classification for cost-sharing purposes"
    - name: "service_area_type"
      expr: service_area_type
      comment: "Geographic service area classification"
    - name: "ncqa_accreditation_status"
      expr: ncqa_accreditation_status
      comment: "NCQA accreditation status indicating quality certification"
    - name: "network_adequacy_status"
      expr: network_adequacy_status
      comment: "Regulatory adequacy compliance status"
    - name: "aco_participation_flag"
      expr: aco_participation_flag
      comment: "Indicates if network participates in Accountable Care Organization arrangements"
    - name: "vbc_arrangement_flag"
      expr: vbc_arrangement_flag
      comment: "Indicates if network has value-based care arrangements"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the network became effective"
    - name: "effective_quarter"
      expr: CONCAT('Q', QUARTER(effective_date), '-', YEAR(effective_date))
      comment: "Quarter and year the network became effective"
  measures:
    - name: "total_networks"
      expr: COUNT(1)
      comment: "Total count of provider networks"
    - name: "total_providers"
      expr: SUM(CAST(provider_count AS BIGINT))
      comment: "Total number of providers across all networks"
    - name: "total_pcps"
      expr: SUM(CAST(pcp_count AS BIGINT))
      comment: "Total number of primary care physicians"
    - name: "total_specialists"
      expr: SUM(CAST(specialist_count AS BIGINT))
      comment: "Total number of specialist physicians"
    - name: "total_facilities"
      expr: SUM(CAST(facility_count AS BIGINT))
      comment: "Total number of facilities in networks"
    - name: "total_enrolled_members"
      expr: SUM(CAST(member_enrollment_count AS BIGINT))
      comment: "Total number of members enrolled across networks"
    - name: "avg_star_rating"
      expr: AVG(CAST(star_rating AS DOUBLE))
      comment: "Average CMS star rating across networks, key quality indicator"
    - name: "avg_providers_per_network"
      expr: AVG(CAST(provider_count AS DOUBLE))
      comment: "Average number of providers per network, indicates network breadth"
    - name: "avg_members_per_network"
      expr: AVG(CAST(member_enrollment_count AS DOUBLE))
      comment: "Average member enrollment per network, indicates network scale"
    - name: "pcp_to_specialist_ratio"
      expr: ROUND(100.0 * SUM(CAST(pcp_count AS DOUBLE)) / NULLIF(SUM(CAST(specialist_count AS DOUBLE)), 0), 2)
      comment: "Ratio of PCPs to specialists as percentage, indicates care model balance"
    - name: "members_per_pcp"
      expr: ROUND(SUM(CAST(member_enrollment_count AS DOUBLE)) / NULLIF(SUM(CAST(pcp_count AS DOUBLE)), 0), 1)
      comment: "Average members per PCP, key capacity and access metric"
    - name: "aco_participation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN aco_participation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of networks with ACO participation, indicates value-based care adoption"
    - name: "vbc_arrangement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN vbc_arrangement_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of networks with value-based care arrangements, strategic transformation indicator"
    - name: "ncqa_accredited_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN ncqa_accreditation_status = 'Accredited' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of networks with NCQA accreditation, quality certification metric"
    - name: "adequacy_compliant_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN network_adequacy_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of networks meeting adequacy standards, regulatory compliance metric"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_adequacy_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network adequacy compliance and gap analysis metrics for regulatory reporting and network planning"
  source: "`vibe_health_insurance_v1`.`network`.`adequacy_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of adequacy assessment performed"
    - name: "compliance_outcome"
      expr: compliance_outcome
      comment: "Result of compliance assessment (e.g., Compliant, Non-Compliant)"
    - name: "specialty_type"
      expr: specialty_type
      comment: "Medical specialty being assessed for adequacy"
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility assessed"
    - name: "appointment_type_requested"
      expr: appointment_type_requested
      comment: "Type of appointment assessed (e.g., routine, urgent)"
    - name: "gap_identified_flag"
      expr: gap_identified_flag
      comment: "Indicates if adequacy gap was identified"
    - name: "gap_severity"
      expr: gap_severity
      comment: "Severity level of identified gap"
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation efforts for identified gaps"
    - name: "regulatory_submission_type"
      expr: regulatory_submission_type
      comment: "Type of regulatory submission required"
    - name: "submission_status"
      expr: submission_status
      comment: "Status of regulatory submission"
    - name: "survey_method"
      expr: survey_method
      comment: "Method used to conduct adequacy survey"
    - name: "assessor_organization"
      expr: assessor_organization
      comment: "Organization conducting the assessment"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year the assessment was conducted"
    - name: "assessment_quarter"
      expr: CONCAT('Q', QUARTER(assessment_date), '-', YEAR(assessment_date))
      comment: "Quarter and year of assessment"
    - name: "assessment_period_months"
      expr: CONCAT(DATE_FORMAT(assessment_period_start_date, 'yyyy-MM'), ' to ', DATE_FORMAT(assessment_period_end_date, 'yyyy-MM'))
      comment: "Assessment period range in months"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of adequacy assessments conducted"
    - name: "total_gaps_identified"
      expr: SUM(CASE WHEN gap_identified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of adequacy gaps identified"
    - name: "gap_identification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gap_identified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments that identified gaps, indicates network adequacy challenges"
    - name: "compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_outcome = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments with compliant outcome, key regulatory metric"
    - name: "avg_member_to_provider_ratio"
      expr: AVG(CAST(member_to_provider_ratio AS DOUBLE))
      comment: "Average member-to-provider ratio across assessments, capacity indicator"
    - name: "avg_time_distance_compliance_pct"
      expr: AVG(CAST(time_distance_compliance_percentage AS DOUBLE))
      comment: "Average time/distance standard compliance percentage, access metric"
    - name: "avg_time_distance_standard_miles"
      expr: AVG(CAST(time_distance_standard_miles AS DOUBLE))
      comment: "Average distance standard in miles"
    - name: "provider_gap_total"
      expr: SUM((CAST(provider_count_required AS BIGINT)) - (CAST(provider_count_available AS BIGINT)))
      comment: "Total provider shortfall across all assessments, critical capacity gap metric"
    - name: "avg_provider_gap"
      expr: AVG(CAST(provider_count_required AS DOUBLE) - CAST(provider_count_available AS DOUBLE))
      comment: "Average provider shortfall per assessment"
    - name: "provider_fill_rate"
      expr: ROUND(100.0 * SUM(CAST(provider_count_available AS DOUBLE)) / NULLIF(SUM(CAST(provider_count_required AS DOUBLE)), 0), 2)
      comment: "Percentage of required providers available, network capacity utilization metric"
    - name: "remediation_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN remediation_status = 'Completed' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN gap_identified_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of identified gaps with completed remediation, operational effectiveness metric"
    - name: "regulatory_submission_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN submission_status = 'Submitted' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments with completed regulatory submissions, compliance metric"
    - name: "telehealth_offering_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN telehealth_offered_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments where telehealth was offered, access innovation metric"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_vbc_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Value-based care arrangement performance and financial metrics for risk-sharing and quality-based reimbursement"
  source: "`vibe_health_insurance_v1`.`network`.`vbc_arrangement`"
  dimensions:
    - name: "arrangement_type"
      expr: arrangement_type
      comment: "Type of value-based care arrangement (e.g., shared savings, bundled payment)"
    - name: "arrangement_status"
      expr: arrangement_status
      comment: "Current status of the VBC arrangement"
    - name: "record_type"
      expr: record_type
      comment: "Classification of the VBC record"
    - name: "risk_model"
      expr: risk_model
      comment: "Risk adjustment model used in the arrangement"
    - name: "attribution_methodology"
      expr: attribution_methodology
      comment: "Method used to attribute members to providers"
    - name: "benchmark_methodology"
      expr: benchmark_methodology
      comment: "Methodology for calculating performance benchmarks"
    - name: "quality_measure_set"
      expr: quality_measure_set
      comment: "Set of quality measures used for performance evaluation"
    - name: "reconciliation_frequency"
      expr: reconciliation_frequency
      comment: "Frequency of financial reconciliation (e.g., quarterly, annual)"
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for the arrangement"
    - name: "cms_reporting_required_flag"
      expr: cms_reporting_required_flag
      comment: "Indicates if CMS reporting is required"
    - name: "care_coordination_required_flag"
      expr: care_coordination_required_flag
      comment: "Indicates if care coordination is required"
    - name: "data_sharing_agreement_flag"
      expr: data_sharing_agreement_flag
      comment: "Indicates if data sharing agreement is in place"
    - name: "arrangement_year"
      expr: YEAR(effective_start_date)
      comment: "Year the arrangement became effective"
  measures:
    - name: "total_vbc_arrangements"
      expr: COUNT(1)
      comment: "Total count of value-based care arrangements"
    - name: "total_attributed_members"
      expr: SUM(CAST(attributed_member_count AS BIGINT))
      comment: "Total members attributed to VBC arrangements"
    - name: "total_participating_providers"
      expr: SUM(CAST(participating_provider_count AS BIGINT))
      comment: "Total providers participating in VBC arrangements"
    - name: "total_pcps_in_vbc"
      expr: SUM(CAST(primary_care_physician_count AS BIGINT))
      comment: "Total primary care physicians in VBC arrangements"
    - name: "total_specialists_in_vbc"
      expr: SUM(CAST(specialist_physician_count AS BIGINT))
      comment: "Total specialists in VBC arrangements"
    - name: "avg_attributed_members_per_arrangement"
      expr: AVG(CAST(attributed_member_count AS DOUBLE))
      comment: "Average members per VBC arrangement, indicates arrangement scale"
    - name: "avg_providers_per_arrangement"
      expr: AVG(CAST(participating_provider_count AS DOUBLE))
      comment: "Average providers per arrangement, indicates network breadth"
    - name: "total_benchmark_amount"
      expr: SUM(CAST(benchmark_amount AS DOUBLE))
      comment: "Total benchmark amount across all arrangements, financial target metric"
    - name: "avg_benchmark_amount"
      expr: AVG(CAST(benchmark_amount AS DOUBLE))
      comment: "Average benchmark amount per arrangement"
    - name: "total_performance_guarantee"
      expr: SUM(CAST(performance_guarantee_amount AS DOUBLE))
      comment: "Total performance guarantee amounts, financial risk metric"
    - name: "avg_shared_savings_rate"
      expr: AVG(CAST(shared_savings_rate AS DOUBLE))
      comment: "Average shared savings rate percentage, upside incentive metric"
    - name: "avg_shared_loss_rate"
      expr: AVG(CAST(shared_loss_rate AS DOUBLE))
      comment: "Average shared loss rate percentage, downside risk metric"
    - name: "avg_minimum_savings_rate"
      expr: AVG(CAST(minimum_savings_rate AS DOUBLE))
      comment: "Average minimum savings rate threshold"
    - name: "avg_minimum_loss_rate"
      expr: AVG(CAST(minimum_loss_rate AS DOUBLE))
      comment: "Average minimum loss rate threshold"
    - name: "avg_quality_performance_threshold"
      expr: AVG(CAST(quality_performance_threshold AS DOUBLE))
      comment: "Average quality performance threshold, quality gate metric"
    - name: "total_stop_loss_limit"
      expr: SUM(CAST(stop_loss_limit AS DOUBLE))
      comment: "Total stop-loss limits, risk protection metric"
    - name: "avg_stop_loss_limit"
      expr: AVG(CAST(stop_loss_limit AS DOUBLE))
      comment: "Average stop-loss limit per arrangement"
    - name: "care_coordination_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN care_coordination_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of arrangements requiring care coordination, care model sophistication metric"
    - name: "cms_reporting_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cms_reporting_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of arrangements with CMS reporting requirements"
    - name: "data_sharing_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN data_sharing_agreement_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of arrangements with data sharing agreements, collaboration metric"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_provider_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider network assignment and panel management metrics for capacity planning and access optimization"
  source: "`vibe_health_insurance_v1`.`network`.`provider_assignment`"
  dimensions:
    - name: "participation_status"
      expr: participation_status
      comment: "Current participation status of the provider"
    - name: "network_participation_type"
      expr: network_participation_type
      comment: "Type of network participation (e.g., full, limited)"
    - name: "panel_status"
      expr: panel_status
      comment: "Status of provider panel (e.g., open, closed)"
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Current credentialing status"
    - name: "tier_assignment"
      expr: tier_assignment
      comment: "Cost-sharing tier assignment"
    - name: "quality_tier_designation"
      expr: quality_tier_designation
      comment: "Quality-based tier designation"
    - name: "network_adequacy_category"
      expr: network_adequacy_category
      comment: "Adequacy category classification"
    - name: "termination_reason_code"
      expr: termination_reason_code
      comment: "Reason code for termination if applicable"
    - name: "pcp_flag"
      expr: pcp_flag
      comment: "Indicates if provider is a primary care physician"
    - name: "specialist_flag"
      expr: specialist_flag
      comment: "Indicates if provider is a specialist"
    - name: "accepting_new_patients_flag"
      expr: accepting_new_patients_flag
      comment: "Indicates if provider is accepting new patients"
    - name: "telehealth_available_flag"
      expr: telehealth_available_flag
      comment: "Indicates if telehealth services are available"
    - name: "vbc_participant_flag"
      expr: vbc_participant_flag
      comment: "Indicates if provider participates in value-based care"
    - name: "aco_participant_flag"
      expr: aco_participant_flag
      comment: "Indicates if provider participates in ACO"
    - name: "directory_listing_flag"
      expr: directory_listing_flag
      comment: "Indicates if provider is listed in directory"
    - name: "assignment_year"
      expr: YEAR(effective_date)
      comment: "Year the assignment became effective"
  measures:
    - name: "total_provider_assignments"
      expr: COUNT(1)
      comment: "Total count of provider network assignments"
    - name: "active_assignments"
      expr: SUM(CASE WHEN participation_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of active provider assignments"
    - name: "total_pcps"
      expr: SUM(CASE WHEN pcp_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total primary care physicians assigned"
    - name: "total_specialists"
      expr: SUM(CASE WHEN specialist_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total specialists assigned"
    - name: "accepting_new_patients_count"
      expr: SUM(CASE WHEN accepting_new_patients_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of providers accepting new patients"
    - name: "open_panel_count"
      expr: SUM(CASE WHEN panel_status = 'Open' THEN 1 ELSE 0 END)
      comment: "Count of providers with open panels"
    - name: "closed_panel_count"
      expr: SUM(CASE WHEN panel_status = 'Closed' THEN 1 ELSE 0 END)
      comment: "Count of providers with closed panels"
    - name: "total_current_panel_size"
      expr: SUM(CAST(current_panel_size AS BIGINT))
      comment: "Total current panel size across all providers"
    - name: "total_panel_capacity"
      expr: SUM(CAST(panel_capacity AS BIGINT))
      comment: "Total panel capacity across all providers"
    - name: "avg_panel_size"
      expr: AVG(CAST(current_panel_size AS DOUBLE))
      comment: "Average panel size per provider"
    - name: "avg_panel_capacity"
      expr: AVG(CAST(panel_capacity AS DOUBLE))
      comment: "Average panel capacity per provider"
    - name: "panel_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(current_panel_size AS DOUBLE)) / NULLIF(SUM(CAST(panel_capacity AS DOUBLE)), 0), 2)
      comment: "Percentage of panel capacity utilized, critical capacity planning metric"
    - name: "open_panel_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN panel_status = 'Open' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers with open panels, access availability metric"
    - name: "accepting_new_patients_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN accepting_new_patients_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers accepting new patients, member access metric"
    - name: "credentialed_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN credentialing_status = 'Credentialed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers fully credentialed, quality assurance metric"
    - name: "telehealth_availability_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN telehealth_available_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers offering telehealth, access innovation metric"
    - name: "vbc_participation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN vbc_participant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers in value-based care, strategic transformation metric"
    - name: "aco_participation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN aco_participant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers in ACO arrangements"
    - name: "directory_listing_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN directory_listing_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers listed in directory, member access transparency metric"
    - name: "in_network_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN in_network_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers with in-network status"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_recruitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider recruitment effectiveness and adequacy gap remediation metrics for network development"
  source: "`vibe_health_insurance_v1`.`network`.`recruitment`"
  dimensions:
    - name: "recruitment_status"
      expr: recruitment_status
      comment: "Current status of recruitment effort"
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of recruitment effort"
    - name: "disposition_reason"
      expr: disposition_reason
      comment: "Reason for recruitment disposition"
    - name: "adequacy_gap_type"
      expr: adequacy_gap_type
      comment: "Type of adequacy gap being addressed"
    - name: "target_specialty"
      expr: target_specialty
      comment: "Medical specialty being recruited"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of recruitment effort"
    - name: "outreach_method"
      expr: outreach_method
      comment: "Method used for provider outreach"
    - name: "provider_response"
      expr: provider_response
      comment: "Provider response to recruitment outreach"
    - name: "lob"
      expr: lob
      comment: "Line of business for recruitment"
    - name: "target_geographic_area"
      expr: target_geographic_area
      comment: "Geographic area targeted for recruitment"
    - name: "regulatory_filing_required_flag"
      expr: regulatory_filing_required_flag
      comment: "Indicates if regulatory filing is required"
    - name: "recruitment_year"
      expr: YEAR(outreach_date)
      comment: "Year recruitment outreach occurred"
    - name: "recruitment_quarter"
      expr: CONCAT('Q', QUARTER(outreach_date), '-', YEAR(outreach_date))
      comment: "Quarter and year of recruitment outreach"
  measures:
    - name: "total_recruitment_efforts"
      expr: COUNT(1)
      comment: "Total count of recruitment efforts"
    - name: "successful_recruitments"
      expr: SUM(CASE WHEN disposition = 'Contracted' THEN 1 ELSE 0 END)
      comment: "Count of successful recruitments resulting in contracts"
    - name: "recruitment_success_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN disposition = 'Contracted' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recruitment efforts resulting in contracts, key effectiveness metric"
    - name: "in_progress_recruitments"
      expr: SUM(CASE WHEN recruitment_status = 'In Progress' THEN 1 ELSE 0 END)
      comment: "Count of active recruitment efforts"
    - name: "declined_recruitments"
      expr: SUM(CASE WHEN disposition = 'Declined' THEN 1 ELSE 0 END)
      comment: "Count of declined recruitment offers"
    - name: "total_estimated_claims_volume"
      expr: SUM(CAST(estimated_annual_claims_volume AS DOUBLE))
      comment: "Total estimated annual claims volume from recruitment targets, financial impact metric"
    - name: "avg_estimated_claims_volume"
      expr: AVG(CAST(estimated_annual_claims_volume AS DOUBLE))
      comment: "Average estimated claims volume per recruitment target"
    - name: "total_estimated_member_impact"
      expr: SUM(CAST(estimated_member_impact AS BIGINT))
      comment: "Total estimated member impact from recruitment efforts"
    - name: "avg_estimated_member_impact"
      expr: AVG(CAST(estimated_member_impact AS DOUBLE))
      comment: "Average estimated member impact per recruitment"
    - name: "high_priority_recruitment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN priority_level = 'High' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of high-priority recruitment efforts, urgency indicator"
    - name: "regulatory_filing_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_filing_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recruitments requiring regulatory filing"
    - name: "positive_response_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN provider_response = 'Interested' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers expressing interest, pipeline health metric"
    - name: "avg_days_to_disposition"
      expr: AVG(DATEDIFF(disposition_date, outreach_date))
      comment: "Average days from outreach to disposition, recruitment cycle time metric"
    - name: "avg_days_to_contract"
      expr: AVG(CASE WHEN disposition = 'Contracted' THEN DATEDIFF(contracting_referral_date, outreach_date) END)
      comment: "Average days from outreach to contract for successful recruitments, efficiency metric"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_termination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider network termination and member impact metrics for continuity of care and network stability analysis"
  source: "`vibe_health_insurance_v1`.`network`.`termination`"
  dimensions:
    - name: "termination_type"
      expr: termination_type
      comment: "Type of termination (e.g., voluntary, involuntary)"
    - name: "termination_status"
      expr: termination_status
      comment: "Current status of termination process"
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for termination"
    - name: "reason_description"
      expr: reason_description
      comment: "Detailed description of termination reason"
    - name: "for_cause_flag"
      expr: for_cause_flag
      comment: "Indicates if termination was for cause"
    - name: "credentialing_related_flag"
      expr: credentialing_related_flag
      comment: "Indicates if termination was credentialing-related"
    - name: "appeals_filed_flag"
      expr: appeals_filed_flag
      comment: "Indicates if appeals were filed"
    - name: "appeal_outcome"
      expr: appeal_outcome
      comment: "Outcome of appeal if filed"
    - name: "member_notification_required_flag"
      expr: member_notification_required_flag
      comment: "Indicates if member notification was required"
    - name: "member_notification_method"
      expr: member_notification_method
      comment: "Method used for member notification"
    - name: "network_adequacy_impact_flag"
      expr: network_adequacy_impact_flag
      comment: "Indicates if termination impacted network adequacy"
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Indicates if regulatory reporting was required"
    - name: "financial_settlement_required_flag"
      expr: financial_settlement_required_flag
      comment: "Indicates if financial settlement was required"
    - name: "replacement_provider_required_flag"
      expr: replacement_provider_required_flag
      comment: "Indicates if replacement provider was required"
    - name: "termination_year"
      expr: YEAR(effective_date)
      comment: "Year termination became effective"
    - name: "termination_quarter"
      expr: CONCAT('Q', QUARTER(effective_date), '-', YEAR(effective_date))
      comment: "Quarter and year of termination"
  measures:
    - name: "total_terminations"
      expr: COUNT(1)
      comment: "Total count of provider terminations"
    - name: "for_cause_terminations"
      expr: SUM(CASE WHEN for_cause_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of for-cause terminations"
    - name: "credentialing_terminations"
      expr: SUM(CASE WHEN credentialing_related_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of credentialing-related terminations"
    - name: "total_member_impact"
      expr: SUM(CAST(member_impact_count AS BIGINT))
      comment: "Total members impacted by terminations, critical continuity of care metric"
    - name: "avg_member_impact_per_termination"
      expr: AVG(CAST(member_impact_count AS DOUBLE))
      comment: "Average members impacted per termination"
    - name: "total_active_treatments_impacted"
      expr: SUM(CAST(active_treatment_count AS BIGINT))
      comment: "Total active treatments impacted by terminations, care disruption metric"
    - name: "avg_active_treatments_per_termination"
      expr: AVG(CAST(active_treatment_count AS DOUBLE))
      comment: "Average active treatments per termination"
    - name: "for_cause_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN for_cause_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminations that were for cause, quality indicator"
    - name: "credentialing_termination_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN credentialing_related_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminations related to credentialing issues"
    - name: "appeal_filing_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN appeals_filed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminations with appeals filed, dispute indicator"
    - name: "network_adequacy_impact_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN network_adequacy_impact_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminations impacting network adequacy, regulatory risk metric"
    - name: "member_notification_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN member_notification_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminations requiring member notification"
    - name: "regulatory_reporting_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminations requiring regulatory reporting, compliance metric"
    - name: "financial_settlement_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN financial_settlement_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminations requiring financial settlement"
    - name: "replacement_provider_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN replacement_provider_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminations requiring replacement providers, adequacy impact metric"
    - name: "avg_claims_runout_days"
      expr: AVG(CAST(claims_runout_period_days AS DOUBLE))
      comment: "Average claims runout period in days"
    - name: "avg_continuity_of_care_days"
      expr: AVG(DATEDIFF(continuity_of_care_end_date, effective_date))
      comment: "Average continuity of care period in days, member protection metric"
$$;