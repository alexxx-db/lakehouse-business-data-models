-- Metric views for domain: network | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 22:41:45

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_provider_network`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core network performance and adequacy KPIs tracking provider capacity, network composition, and regulatory compliance status across lines of business."
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
      comment: "Line of business served (e.g., Commercial, Medicare, Medicaid)"
    - name: "network_status"
      expr: network_status
      comment: "Current operational status of the network"
    - name: "network_adequacy_status"
      expr: network_adequacy_status
      comment: "Regulatory adequacy compliance status"
    - name: "service_area_type"
      expr: service_area_type
      comment: "Geographic service area classification"
    - name: "tier_classification"
      expr: tier_classification
      comment: "Tiering structure classification for cost-sharing"
    - name: "aco_participation_flag"
      expr: aco_participation_flag
      comment: "Whether network includes ACO arrangements"
    - name: "vbc_arrangement_flag"
      expr: vbc_arrangement_flag
      comment: "Whether network includes value-based care contracts"
    - name: "pcp_required_flag"
      expr: pcp_required_flag
      comment: "Whether PCP selection is required for members"
    - name: "referral_required_flag"
      expr: referral_required_flag
      comment: "Whether specialist referrals are required"
    - name: "out_of_network_coverage_flag"
      expr: out_of_network_coverage_flag
      comment: "Whether out-of-network benefits are available"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the network became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the network became effective"
  measures:
    - name: "active_network_count"
      expr: COUNT(DISTINCT CASE WHEN network_status = 'Active' THEN provider_network_id END)
      comment: "Count of active provider networks - key capacity indicator"
    - name: "total_enrolled_members"
      expr: SUM(CAST(member_enrollment_count AS BIGINT))
      comment: "Total member enrollment across networks - primary volume KPI"
    - name: "total_provider_count"
      expr: SUM(CAST(provider_count AS BIGINT))
      comment: "Total contracted providers across networks - supply capacity metric"
    - name: "total_pcp_count"
      expr: SUM(CAST(pcp_count AS BIGINT))
      comment: "Total primary care physicians - critical access metric"
    - name: "total_specialist_count"
      expr: SUM(CAST(specialist_count AS BIGINT))
      comment: "Total specialist physicians - specialty access metric"
    - name: "total_facility_count"
      expr: SUM(CAST(facility_count AS BIGINT))
      comment: "Total contracted facilities - infrastructure capacity metric"
    - name: "avg_star_rating"
      expr: AVG(CAST(star_rating AS DOUBLE))
      comment: "Average CMS star rating across networks - quality performance indicator"
    - name: "adequacy_compliant_network_count"
      expr: COUNT(DISTINCT CASE WHEN network_adequacy_status = 'Compliant' THEN provider_network_id END)
      comment: "Count of networks meeting adequacy standards - regulatory compliance KPI"
    - name: "vbc_enabled_network_count"
      expr: COUNT(DISTINCT CASE WHEN vbc_arrangement_flag = TRUE THEN provider_network_id END)
      comment: "Count of networks with value-based care arrangements - strategic transformation metric"
    - name: "aco_participating_network_count"
      expr: COUNT(DISTINCT CASE WHEN aco_participation_flag = TRUE THEN provider_network_id END)
      comment: "Count of networks with ACO participation - care coordination capability metric"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_adequacy_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network adequacy compliance and gap analysis KPIs tracking regulatory compliance, access standards, and remediation effectiveness."
  source: "`vibe_health_insurance_v1`.`network`.`adequacy_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of adequacy assessment performed"
    - name: "specialty_type"
      expr: specialty_type
      comment: "Provider specialty being assessed"
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility being assessed"
    - name: "compliance_outcome"
      expr: compliance_outcome
      comment: "Result of compliance assessment (Pass/Fail/Conditional)"
    - name: "gap_identified_flag"
      expr: gap_identified_flag
      comment: "Whether an adequacy gap was identified"
    - name: "gap_severity"
      expr: gap_severity
      comment: "Severity level of identified gap"
    - name: "remediation_status"
      expr: remediation_status
      comment: "Current status of remediation efforts"
    - name: "submission_status"
      expr: submission_status
      comment: "Status of regulatory submission"
    - name: "accepting_new_patients_flag"
      expr: accepting_new_patients_flag
      comment: "Whether providers are accepting new patients"
    - name: "telehealth_offered_flag"
      expr: telehealth_offered_flag
      comment: "Whether telehealth services are available"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of adequacy assessment"
    - name: "assessment_quarter"
      expr: DATE_TRUNC('QUARTER', assessment_date)
      comment: "Quarter of adequacy assessment"
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of adequacy assessment"
  measures:
    - name: "total_assessments"
      expr: COUNT(DISTINCT adequacy_assessment_id)
      comment: "Total number of adequacy assessments performed - activity volume metric"
    - name: "assessments_with_gaps"
      expr: COUNT(DISTINCT CASE WHEN gap_identified_flag = TRUE THEN adequacy_assessment_id END)
      comment: "Count of assessments identifying gaps - risk exposure metric"
    - name: "compliant_assessments"
      expr: COUNT(DISTINCT CASE WHEN compliance_outcome = 'Pass' THEN adequacy_assessment_id END)
      comment: "Count of assessments passing compliance - regulatory success metric"
    - name: "avg_time_distance_compliance_pct"
      expr: AVG(CAST(time_distance_compliance_percentage AS DOUBLE))
      comment: "Average time/distance standard compliance percentage - access quality indicator"
    - name: "avg_member_to_provider_ratio"
      expr: AVG(CAST(member_to_provider_ratio AS DOUBLE))
      comment: "Average member-to-provider ratio - capacity utilization metric"
    - name: "avg_time_distance_standard_miles"
      expr: AVG(CAST(time_distance_standard_miles AS DOUBLE))
      comment: "Average distance standard in miles - geographic access metric"
    - name: "critical_gap_count"
      expr: COUNT(DISTINCT CASE WHEN gap_severity = 'Critical' THEN adequacy_assessment_id END)
      comment: "Count of critical severity gaps - high-priority risk metric"
    - name: "remediation_complete_count"
      expr: COUNT(DISTINCT CASE WHEN remediation_status = 'Complete' THEN adequacy_assessment_id END)
      comment: "Count of completed remediations - resolution effectiveness metric"
    - name: "telehealth_enabled_assessment_count"
      expr: COUNT(DISTINCT CASE WHEN telehealth_offered_flag = TRUE THEN adequacy_assessment_id END)
      comment: "Count of assessments with telehealth availability - digital access metric"
    - name: "accepting_new_patients_count"
      expr: COUNT(DISTINCT CASE WHEN accepting_new_patients_flag = TRUE THEN adequacy_assessment_id END)
      comment: "Count of assessments where providers accept new patients - access availability metric"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_provider_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider network participation and panel management KPIs tracking credentialing, capacity, and value-based care engagement."
  source: "`vibe_health_insurance_v1`.`network`.`provider_assignment`"
  dimensions:
    - name: "participation_status"
      expr: participation_status
      comment: "Current participation status of provider in network"
    - name: "network_participation_type"
      expr: network_participation_type
      comment: "Type of network participation arrangement"
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Current credentialing status of provider"
    - name: "panel_status"
      expr: panel_status
      comment: "Status of provider panel (Open/Closed/Limited)"
    - name: "network_adequacy_category"
      expr: network_adequacy_category
      comment: "Adequacy category classification for provider"
    - name: "quality_tier_designation"
      expr: quality_tier_designation
      comment: "Quality-based tier designation"
    - name: "pcp_flag"
      expr: pcp_flag
      comment: "Whether provider is a primary care physician"
    - name: "specialist_flag"
      expr: specialist_flag
      comment: "Whether provider is a specialist"
    - name: "accepting_new_patients_flag"
      expr: accepting_new_patients_flag
      comment: "Whether provider is accepting new patients"
    - name: "telehealth_available_flag"
      expr: telehealth_available_flag
      comment: "Whether provider offers telehealth services"
    - name: "vbc_participant_flag"
      expr: vbc_participant_flag
      comment: "Whether provider participates in value-based care"
    - name: "aco_participant_flag"
      expr: aco_participant_flag
      comment: "Whether provider participates in ACO"
    - name: "risk_sharing_arrangement_flag"
      expr: risk_sharing_arrangement_flag
      comment: "Whether provider has risk-sharing arrangement"
    - name: "in_network_flag"
      expr: in_network_flag
      comment: "Whether provider is in-network"
    - name: "directory_listing_flag"
      expr: directory_listing_flag
      comment: "Whether provider is listed in directory"
    - name: "accessibility_ada_compliant_flag"
      expr: accessibility_ada_compliant_flag
      comment: "Whether provider location is ADA compliant"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year provider assignment became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month provider assignment became effective"
  measures:
    - name: "total_provider_assignments"
      expr: COUNT(DISTINCT provider_assignment_id)
      comment: "Total provider assignments - network size metric"
    - name: "active_provider_assignments"
      expr: COUNT(DISTINCT CASE WHEN participation_status = 'Active' THEN provider_assignment_id END)
      comment: "Active provider assignments - current network capacity"
    - name: "credentialed_provider_count"
      expr: COUNT(DISTINCT CASE WHEN credentialing_status = 'Credentialed' THEN provider_assignment_id END)
      comment: "Fully credentialed providers - quality-assured capacity metric"
    - name: "open_panel_provider_count"
      expr: COUNT(DISTINCT CASE WHEN panel_status = 'Open' THEN provider_assignment_id END)
      comment: "Providers with open panels - available access capacity"
    - name: "accepting_new_patients_count"
      expr: COUNT(DISTINCT CASE WHEN accepting_new_patients_flag = TRUE THEN provider_assignment_id END)
      comment: "Providers accepting new patients - immediate access availability"
    - name: "pcp_assignment_count"
      expr: COUNT(DISTINCT CASE WHEN pcp_flag = TRUE THEN provider_assignment_id END)
      comment: "Primary care physician assignments - foundational access metric"
    - name: "specialist_assignment_count"
      expr: COUNT(DISTINCT CASE WHEN specialist_flag = TRUE THEN provider_assignment_id END)
      comment: "Specialist assignments - specialty care capacity"
    - name: "telehealth_enabled_provider_count"
      expr: COUNT(DISTINCT CASE WHEN telehealth_available_flag = TRUE THEN provider_assignment_id END)
      comment: "Providers offering telehealth - digital access capacity"
    - name: "vbc_participating_provider_count"
      expr: COUNT(DISTINCT CASE WHEN vbc_participant_flag = TRUE THEN provider_assignment_id END)
      comment: "Providers in value-based care - strategic transformation metric"
    - name: "aco_participating_provider_count"
      expr: COUNT(DISTINCT CASE WHEN aco_participant_flag = TRUE THEN provider_assignment_id END)
      comment: "Providers in ACO arrangements - coordinated care capacity"
    - name: "risk_sharing_provider_count"
      expr: COUNT(DISTINCT CASE WHEN risk_sharing_arrangement_flag = TRUE THEN provider_assignment_id END)
      comment: "Providers with risk-sharing - financial alignment metric"
    - name: "ada_compliant_location_count"
      expr: COUNT(DISTINCT CASE WHEN accessibility_ada_compliant_flag = TRUE THEN provider_assignment_id END)
      comment: "ADA compliant locations - accessibility compliance metric"
    - name: "directory_listed_provider_count"
      expr: COUNT(DISTINCT CASE WHEN directory_listing_flag = TRUE THEN provider_assignment_id END)
      comment: "Providers listed in directory - member-facing availability"
    - name: "total_panel_capacity"
      expr: SUM(CAST(panel_capacity AS BIGINT))
      comment: "Total panel capacity across providers - maximum member capacity"
    - name: "current_panel_size_total"
      expr: SUM(CAST(current_panel_size AS BIGINT))
      comment: "Current total panel size - utilized capacity metric"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_par_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider participation agreement lifecycle and compliance KPIs tracking contract status, credentialing, and regulatory approval."
  source: "`vibe_health_insurance_v1`.`network`.`par_agreement`"
  dimensions:
    - name: "par_agreement_status"
      expr: par_agreement_status
      comment: "Current status of participation agreement"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of participation agreement"
    - name: "provider_participation_role"
      expr: provider_participation_role
      comment: "Role of provider in network (PCP, Specialist, etc.)"
    - name: "provider_network_status"
      expr: provider_network_status
      comment: "Network participation status"
    - name: "provider_credentialing_status"
      expr: provider_credentialing_status
      comment: "Credentialing status of provider"
    - name: "compliance_status_flag"
      expr: compliance_status_flag
      comment: "Whether agreement is in compliance"
    - name: "amendment_flag"
      expr: amendment_flag
      comment: "Whether agreement has been amended"
    - name: "renewal_flag"
      expr: renewal_flag
      comment: "Whether agreement is a renewal"
    - name: "provider_directory_listing_flag"
      expr: provider_directory_listing_flag
      comment: "Whether provider is listed in directory"
    - name: "electronic_signature_flag"
      expr: electronic_signature_flag
      comment: "Whether agreement was signed electronically"
    - name: "paper_signature_flag"
      expr: paper_signature_flag
      comment: "Whether agreement was signed on paper"
    - name: "termination_reason_code"
      expr: termination_reason_code
      comment: "Code for agreement termination reason"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year agreement became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month agreement became effective"
    - name: "signature_year"
      expr: YEAR(signature_date)
      comment: "Year agreement was signed"
  measures:
    - name: "total_par_agreements"
      expr: COUNT(DISTINCT par_agreement_id)
      comment: "Total participation agreements - contract portfolio size"
    - name: "active_par_agreements"
      expr: COUNT(DISTINCT CASE WHEN par_agreement_status = 'Active' THEN par_agreement_id END)
      comment: "Active participation agreements - current contracted capacity"
    - name: "compliant_agreements"
      expr: COUNT(DISTINCT CASE WHEN compliance_status_flag = TRUE THEN par_agreement_id END)
      comment: "Agreements in compliance - regulatory health metric"
    - name: "credentialed_agreements"
      expr: COUNT(DISTINCT CASE WHEN provider_credentialing_status = 'Credentialed' THEN par_agreement_id END)
      comment: "Agreements with credentialed providers - quality-assured contracts"
    - name: "amended_agreements"
      expr: COUNT(DISTINCT CASE WHEN amendment_flag = TRUE THEN par_agreement_id END)
      comment: "Agreements with amendments - contract modification activity"
    - name: "renewed_agreements"
      expr: COUNT(DISTINCT CASE WHEN renewal_flag = TRUE THEN par_agreement_id END)
      comment: "Renewed agreements - retention success metric"
    - name: "terminated_agreements"
      expr: COUNT(DISTINCT CASE WHEN par_agreement_status = 'Terminated' THEN par_agreement_id END)
      comment: "Terminated agreements - attrition metric"
    - name: "directory_listed_agreements"
      expr: COUNT(DISTINCT CASE WHEN provider_directory_listing_flag = TRUE THEN par_agreement_id END)
      comment: "Agreements with directory listing - member-visible capacity"
    - name: "electronic_signature_agreements"
      expr: COUNT(DISTINCT CASE WHEN electronic_signature_flag = TRUE THEN par_agreement_id END)
      comment: "Electronically signed agreements - digital adoption metric"
    - name: "regulatory_approved_agreements"
      expr: COUNT(DISTINCT CASE WHEN regulatory_approval_date IS NOT NULL THEN par_agreement_id END)
      comment: "Agreements with regulatory approval - compliance readiness metric"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_plan_association`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health plan and network association KPIs tracking member enrollment, adequacy certification, and value-based care arrangements."
  source: "`vibe_health_insurance_v1`.`network`.`plan_association`"
  dimensions:
    - name: "plan_association_status"
      expr: plan_association_status
      comment: "Current status of plan-network association"
    - name: "association_type"
      expr: association_type
      comment: "Type of plan-network association"
    - name: "lob"
      expr: lob
      comment: "Line of business (Commercial, Medicare, Medicaid)"
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment classification"
    - name: "network_adequacy_status"
      expr: network_adequacy_status
      comment: "Network adequacy compliance status"
    - name: "pcp_selection_required_flag"
      expr: pcp_selection_required_flag
      comment: "Whether PCP selection is required"
    - name: "referral_required_flag"
      expr: referral_required_flag
      comment: "Whether referrals are required"
    - name: "prior_authorization_required_flag"
      expr: prior_authorization_required_flag
      comment: "Whether prior authorization is required"
    - name: "out_of_network_coverage_flag"
      expr: out_of_network_coverage_flag
      comment: "Whether out-of-network coverage is available"
    - name: "vbc_arrangement_flag"
      expr: vbc_arrangement_flag
      comment: "Whether value-based care arrangement exists"
    - name: "aco_participation_flag"
      expr: aco_participation_flag
      comment: "Whether ACO participation exists"
    - name: "auto_assignment_eligible_flag"
      expr: auto_assignment_eligible_flag
      comment: "Whether auto-assignment is eligible"
    - name: "directory_publication_flag"
      expr: directory_publication_flag
      comment: "Whether published in directory"
    - name: "star_rating_impact_flag"
      expr: star_rating_impact_flag
      comment: "Whether association impacts star ratings"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year association became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month association became effective"
  measures:
    - name: "total_plan_associations"
      expr: COUNT(DISTINCT plan_association_id)
      comment: "Total plan-network associations - product portfolio breadth"
    - name: "active_plan_associations"
      expr: COUNT(DISTINCT CASE WHEN plan_association_status = 'Active' THEN plan_association_id END)
      comment: "Active plan associations - current product offerings"
    - name: "adequacy_certified_associations"
      expr: COUNT(DISTINCT CASE WHEN network_adequacy_status = 'Certified' THEN plan_association_id END)
      comment: "Adequacy-certified associations - regulatory compliance metric"
    - name: "vbc_enabled_associations"
      expr: COUNT(DISTINCT CASE WHEN vbc_arrangement_flag = TRUE THEN plan_association_id END)
      comment: "Associations with value-based care - strategic transformation metric"
    - name: "aco_participating_associations"
      expr: COUNT(DISTINCT CASE WHEN aco_participation_flag = TRUE THEN plan_association_id END)
      comment: "Associations with ACO participation - coordinated care metric"
    - name: "auto_assignment_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN auto_assignment_eligible_flag = TRUE THEN plan_association_id END)
      comment: "Auto-assignment eligible associations - member assignment capacity"
    - name: "directory_published_associations"
      expr: COUNT(DISTINCT CASE WHEN directory_publication_flag = TRUE THEN plan_association_id END)
      comment: "Directory-published associations - member-facing availability"
    - name: "star_rating_impacting_associations"
      expr: COUNT(DISTINCT CASE WHEN star_rating_impact_flag = TRUE THEN plan_association_id END)
      comment: "Associations impacting star ratings - quality performance scope"
    - name: "total_member_count"
      expr: SUM(CAST(member_count AS BIGINT))
      comment: "Total members across associations - enrollment volume metric"
    - name: "total_provider_count"
      expr: SUM(CAST(provider_count AS BIGINT))
      comment: "Total providers across associations - network capacity metric"
    - name: "regulatory_approved_associations"
      expr: COUNT(DISTINCT CASE WHEN regulatory_approval_date IS NOT NULL THEN plan_association_id END)
      comment: "Associations with regulatory approval - market readiness metric"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_tier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network tier structure and cost-sharing differential KPIs tracking member steerage incentives and value-based tier performance."
  source: "`vibe_health_insurance_v1`.`network`.`tier`"
  dimensions:
    - name: "tier_name"
      expr: name
      comment: "Name of the network tier"
    - name: "tier_code"
      expr: code
      comment: "Code identifier for the tier"
    - name: "tier_type"
      expr: tier_type
      comment: "Type of tier (Standard, Preferred, Value, etc.)"
    - name: "tier_status"
      expr: tier_status
      comment: "Current status of the tier"
    - name: "cost_share_differential_type"
      expr: cost_share_differential_type
      comment: "Type of cost-sharing differential applied"
    - name: "quality_tier_flag"
      expr: quality_tier_flag
      comment: "Whether tier is based on quality metrics"
    - name: "vbc_arrangement_eligible_flag"
      expr: vbc_arrangement_eligible_flag
      comment: "Whether tier is eligible for value-based care"
    - name: "network_adequacy_credit_flag"
      expr: network_adequacy_credit_flag
      comment: "Whether tier receives adequacy credit"
    - name: "prior_authorization_required_flag"
      expr: prior_authorization_required_flag
      comment: "Whether prior authorization is required"
    - name: "referral_required_flag"
      expr: referral_required_flag
      comment: "Whether referrals are required"
    - name: "deductible_applies_flag"
      expr: deductible_applies_flag
      comment: "Whether deductible applies to tier"
    - name: "oop_max_applies_flag"
      expr: oop_max_applies_flag
      comment: "Whether out-of-pocket maximum applies"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year tier became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month tier became effective"
  measures:
    - name: "total_tiers"
      expr: COUNT(DISTINCT tier_id)
      comment: "Total network tiers - tiering structure complexity"
    - name: "active_tiers"
      expr: COUNT(DISTINCT CASE WHEN tier_status = 'Active' THEN tier_id END)
      comment: "Active tiers - current tiering options"
    - name: "quality_based_tiers"
      expr: COUNT(DISTINCT CASE WHEN quality_tier_flag = TRUE THEN tier_id END)
      comment: "Quality-based tiers - performance-driven steerage"
    - name: "vbc_eligible_tiers"
      expr: COUNT(DISTINCT CASE WHEN vbc_arrangement_eligible_flag = TRUE THEN tier_id END)
      comment: "Value-based care eligible tiers - strategic alignment metric"
    - name: "avg_coinsurance_differential_pct"
      expr: AVG(CAST(coinsurance_differential_percentage AS DOUBLE))
      comment: "Average coinsurance differential - member cost-sharing steerage strength"
    - name: "avg_copay_differential_amount"
      expr: AVG(CAST(copay_differential_amount AS DOUBLE))
      comment: "Average copay differential - member steerage incentive magnitude"
    - name: "max_coinsurance_differential_pct"
      expr: MAX(coinsurance_differential_percentage)
      comment: "Maximum coinsurance differential - strongest steerage lever"
    - name: "max_copay_differential_amount"
      expr: MAX(copay_differential_amount)
      comment: "Maximum copay differential - highest steerage incentive"
    - name: "adequacy_credit_tiers"
      expr: COUNT(DISTINCT CASE WHEN network_adequacy_credit_flag = TRUE THEN tier_id END)
      comment: "Tiers receiving adequacy credit - regulatory benefit metric"
    - name: "prior_auth_required_tiers"
      expr: COUNT(DISTINCT CASE WHEN prior_authorization_required_flag = TRUE THEN tier_id END)
      comment: "Tiers requiring prior authorization - utilization management scope"
$$;