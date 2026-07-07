-- Metric views for domain: network | Business: Health Insurance | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_access_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring member access to network providers through survey data, including appointment availability, wait times, and access standard compliance. Used by quality and network teams for HEDIS, CAHPS, and CMS star rating management."
  source: "`vibe_health_insurance_v1`.`network`.`access_survey`"
  dimensions:
    - name: "provider_network_id"
      expr: provider_network_id
      comment: "Provider network surveyed for access compliance."
    - name: "specialty_code"
      expr: specialty_code
      comment: "Provider specialty for access analysis by specialty type."
    - name: "survey_method"
      expr: survey_method
      comment: "Survey methodology (phone, online, in-person) for data quality segmentation."
    - name: "survey_cycle"
      expr: survey_cycle
      comment: "Survey cycle (annual, quarterly) for temporal compliance tracking."
    - name: "access_standard_met_flag"
      expr: access_standard_met_flag
      comment: "Whether the access standard was met for this survey record — core compliance dimension."
    - name: "appointment_type_requested"
      expr: appointment_type_requested
      comment: "Type of appointment requested (routine, urgent, preventive) for access analysis by care type."
    - name: "telehealth_offered_flag"
      expr: telehealth_offered_flag
      comment: "Whether telehealth was offered as an access option."
    - name: "survey_date"
      expr: DATE_TRUNC('month', survey_date)
      comment: "Month of survey for access trend analysis over time."
    - name: "hedis_measure_applicable_flag"
      expr: hedis_measure_applicable_flag
      comment: "Whether the survey record is applicable to a HEDIS measure for quality reporting segmentation."
  measures:
    - name: "total_surveys"
      expr: COUNT(1)
      comment: "Total access surveys conducted. Baseline volume for survey program coverage analysis."
    - name: "access_standard_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN access_standard_met_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of surveys where the access standard was met. Primary KPI for regulatory access compliance and CMS star rating impact."
    - name: "appointment_scheduled_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN appointment_scheduled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of survey contacts resulting in a scheduled appointment. Measures effective member access to care."
    - name: "accepting_new_patients_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN accepting_new_patients_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of surveyed providers accepting new patients. Access capacity metric directly tied to member experience and adequacy compliance."
    - name: "telehealth_offered_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN telehealth_offered_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of surveyed providers offering telehealth. Informs access modality strategy and CMS telehealth equivalency reporting."
    - name: "language_services_available_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN language_services_available_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers offering language services. Health equity and CLAS standards compliance metric."
    - name: "cms_star_applicable_survey_count"
      expr: COUNT(CASE WHEN cms_star_rating_applicable_flag = TRUE THEN 1 END)
      comment: "Number of surveys applicable to CMS star rating calculations. Scopes the quality measurement population for star rating management."
    - name: "non_compliant_survey_count"
      expr: COUNT(CASE WHEN access_standard_met_flag = FALSE THEN 1 END)
      comment: "Number of surveys where access standard was not met. Drives targeted provider outreach and network adequacy remediation."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_aco_provider`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring ACO provider participation quality, performance scores, and shared savings eligibility. Used by VBC program management and finance to evaluate ACO provider contribution to total cost of care goals."
  source: "`vibe_health_insurance_v1`.`network`.`aco_provider`"
  dimensions:
    - name: "vbc_arrangement_id"
      expr: vbc_arrangement_id
      comment: "VBC arrangement the ACO provider participates in."
    - name: "participation_status"
      expr: participation_status
      comment: "Current participation status of the ACO provider."
    - name: "participation_type"
      expr: participation_type
      comment: "Type of ACO participation (primary care, specialist, facility) for role-based analysis."
    - name: "vbc_track"
      expr: vbc_track
      comment: "VBC track (one-sided, two-sided, enhanced) for risk model segmentation."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status of the ACO provider for compliance analysis."
    - name: "primary_care_flag"
      expr: primary_care_flag
      comment: "Whether the provider is a primary care provider — key for ACO attribution and care coordination."
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for year-over-year ACO performance comparison."
    - name: "shared_savings_eligible_flag"
      expr: shared_savings_eligible_flag
      comment: "Whether the provider is eligible for shared savings distribution."
  measures:
    - name: "total_aco_providers"
      expr: COUNT(1)
      comment: "Total ACO provider participation records. Baseline ACO network size metric."
    - name: "active_aco_provider_count"
      expr: COUNT(CASE WHEN participation_status = 'Active' AND is_active = TRUE THEN 1 END)
      comment: "Number of currently active ACO providers. Core ACO program scale metric."
    - name: "shared_savings_eligible_count"
      expr: COUNT(CASE WHEN shared_savings_eligible_flag = TRUE AND participation_status = 'Active' THEN 1 END)
      comment: "Number of active ACO providers eligible for shared savings. Financial distribution planning metric."
    - name: "avg_quality_score"
      expr: ROUND(AVG(CAST(quality_score AS DOUBLE)), 2)
      comment: "Average quality score across ACO providers. Composite quality metric determining shared savings eligibility and amount."
    - name: "avg_cost_efficiency_score"
      expr: ROUND(AVG(CAST(cost_efficiency_score AS DOUBLE)), 2)
      comment: "Average cost efficiency score across ACO providers. Total cost of care management metric for VBC program performance."
    - name: "avg_risk_sharing_percentage"
      expr: ROUND(AVG(CAST(risk_sharing_percentage AS DOUBLE)), 2)
      comment: "Average risk-sharing percentage across ACO providers. Financial risk distribution metric for VBC arrangement design."
    - name: "quality_reporting_compliant_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_reporting_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN participation_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active ACO providers meeting quality reporting requirements. Compliance metric — non-reporting providers jeopardize shared savings eligibility."
    - name: "ehr_integrated_provider_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ehr_integration_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN participation_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active ACO providers with EHR integration. Data interoperability metric for care coordination and quality measurement."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_adequacy_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs measuring network adequacy compliance, time-distance performance, and remediation status across health plans and service areas. Used by network executives to monitor regulatory compliance posture and identify adequacy gaps requiring intervention."
  source: "`vibe_health_insurance_v1`.`network`.`adequacy_assessment`"
  dimensions:
    - name: "health_plan_id"
      expr: health_plan_id
      comment: "Health plan scoping dimension for adequacy assessment results."
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of adequacy assessment (e.g., initial, annual, triggered) for segmenting compliance posture."
    - name: "network_type_code"
      expr: network_type_code
      comment: "Network type (HMO, PPO, EPO, etc.) to compare adequacy outcomes across network structures."
    - name: "specialty_type"
      expr: specialty_type
      comment: "Provider specialty category assessed, enabling gap analysis by specialty."
    - name: "compliance_outcome"
      expr: compliance_outcome
      comment: "Regulatory compliance result of the assessment (compliant, deficient, exception granted) for executive dashboards."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Current remediation status for non-compliant assessments, driving operational follow-up."
    - name: "assessment_period_start_date"
      expr: DATE_TRUNC('month', assessment_period_start_date)
      comment: "Month bucket of assessment period start for trend analysis."
    - name: "gap_severity"
      expr: gap_severity
      comment: "Severity classification of identified adequacy gaps for prioritization."
    - name: "is_active"
      expr: is_active
      comment: "Active record flag to filter current vs. historical assessments."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of adequacy assessments conducted. Baseline volume metric for regulatory reporting cadence."
    - name: "compliant_assessment_count"
      expr: COUNT(CASE WHEN compliance_outcome = 'Compliant' THEN 1 END)
      comment: "Number of assessments resulting in a compliant outcome. Executives use this to gauge overall network regulatory health."
    - name: "non_compliant_assessment_count"
      expr: COUNT(CASE WHEN compliance_outcome != 'Compliant' AND compliance_outcome IS NOT NULL THEN 1 END)
      comment: "Number of assessments with non-compliant outcomes. Triggers remediation investment and regulatory risk escalation."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_outcome = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments achieving compliant status. Core KPI for network adequacy regulatory scorecards and CMS reporting."
    - name: "gap_identified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gap_identified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments where an adequacy gap was identified. Drives network recruitment prioritization and exception filing decisions."
    - name: "avg_time_distance_compliance_pct"
      expr: ROUND(AVG(CAST(time_distance_compliance_percentage AS DOUBLE)), 2)
      comment: "Average time-distance compliance percentage across assessments. Measures how well the network meets geographic access standards for members."
    - name: "avg_member_to_provider_ratio"
      expr: ROUND(AVG(CAST(member_to_provider_ratio AS DOUBLE)), 2)
      comment: "Average member-to-provider ratio across assessed networks. Indicates provider capacity relative to enrolled membership — a key adequacy signal."
    - name: "avg_member_to_pcp_ratio"
      expr: ROUND(AVG(CAST(member_to_pcp_ratio AS DOUBLE)), 2)
      comment: "Average member-to-PCP ratio. Directly informs PCP recruitment strategy and access standard compliance for primary care."
    - name: "time_distance_compliant_assessment_count"
      expr: COUNT(CASE WHEN time_distance_compliant_flag = TRUE THEN 1 END)
      comment: "Number of assessments meeting time-distance standards. Used to demonstrate geographic access compliance to regulators."
    - name: "remediation_pending_count"
      expr: COUNT(CASE WHEN gap_identified_flag = TRUE AND remediation_status NOT IN ('Completed', 'Closed') THEN 1 END)
      comment: "Number of assessments with open gaps awaiting remediation. Operational metric driving network development resource allocation."
    - name: "avg_time_distance_standard_miles"
      expr: ROUND(AVG(CAST(time_distance_standard_miles AS DOUBLE)), 2)
      comment: "Average time-distance standard in miles across assessments. Contextualizes compliance percentages against the applicable geographic threshold."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_adequacy_gap`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and strategic KPIs tracking open network adequacy gaps, their severity, geographic distribution, and resolution progress. Used by network development and compliance teams to prioritize recruitment and exception filings."
  source: "`vibe_health_insurance_v1`.`network`.`adequacy_gap`"
  dimensions:
    - name: "health_plan_id"
      expr: health_plan_id
      comment: "Health plan dimension for gap analysis by plan."
    - name: "gap_type"
      expr: gap_type
      comment: "Type of adequacy gap (time-distance, provider count, specialty) for targeted remediation planning."
    - name: "gap_severity"
      expr: gap_severity
      comment: "Severity of the gap (critical, moderate, minor) for executive prioritization."
    - name: "gap_status"
      expr: gap_status
      comment: "Current status of the gap (open, in remediation, resolved) for operational tracking."
    - name: "specialty_code"
      expr: specialty_code
      comment: "Provider specialty with the gap, enabling specialty-specific recruitment targeting."
    - name: "geographic_area_type"
      expr: geographic_area_type
      comment: "Geographic classification (urban, rural, frontier) of the gap area for access equity analysis."
    - name: "lob"
      expr: lob
      comment: "Line of business (Medicare, Medicaid, Commercial) affected by the gap."
    - name: "identified_date"
      expr: DATE_TRUNC('month', identified_date)
      comment: "Month the gap was identified, enabling trend analysis of gap emergence over time."
    - name: "exception_granted_flag"
      expr: exception_granted_flag
      comment: "Whether a regulatory exception was granted for this gap, segmenting managed vs. unresolved gaps."
  measures:
    - name: "total_gaps"
      expr: COUNT(1)
      comment: "Total number of adequacy gaps identified. Baseline metric for network adequacy risk exposure."
    - name: "open_gap_count"
      expr: COUNT(CASE WHEN gap_status NOT IN ('Resolved', 'Closed', 'Exception Granted') AND gap_status IS NOT NULL THEN 1 END)
      comment: "Number of currently open adequacy gaps. Directly drives network recruitment urgency and regulatory risk posture."
    - name: "critical_gap_count"
      expr: COUNT(CASE WHEN gap_severity = 'Critical' THEN 1 END)
      comment: "Number of critical severity gaps. Triggers immediate executive escalation and potential regulatory penalty exposure."
    - name: "exception_granted_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_granted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of gaps resolved via regulatory exception rather than provider recruitment. High rates signal structural network adequacy challenges."
    - name: "regulatory_filing_required_count"
      expr: COUNT(CASE WHEN regulatory_filing_required_flag = TRUE THEN 1 END)
      comment: "Number of gaps requiring regulatory filing. Drives compliance workload planning and filing deadline management."
    - name: "distinct_specialty_gaps"
      expr: COUNT(DISTINCT specialty_code)
      comment: "Number of distinct specialties with adequacy gaps. Breadth indicator for network development investment decisions."
    - name: "distinct_geographic_areas_with_gaps"
      expr: COUNT(DISTINCT geographic_area_code)
      comment: "Number of distinct geographic areas with open gaps. Informs service area expansion and provider recruitment geography."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_change_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network change event KPIs measuring provider roster changes, member impact, regulatory filing requirements, and continuity of care obligations."
  source: "`vibe_health_insurance_v1`.`network`.`change_event`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of network change (addition, termination, tier change, etc.)."
    - name: "change_status"
      expr: change_status
      comment: "Current status of the change event."
    - name: "change_reason_code"
      expr: change_reason_code
      comment: "Reason code for the network change."
    - name: "specialty_type"
      expr: specialty_type
      comment: "Specialty type affected by the change."
    - name: "facility_type"
      expr: facility_type
      comment: "Facility type affected by the change."
    - name: "lob_applicability"
      expr: lob_applicability
      comment: "Line of business applicability of the change."
    - name: "termination_type"
      expr: termination_type
      comment: "Type of termination if applicable."
    - name: "network_adequacy_impact_flag"
      expr: network_adequacy_impact_flag
      comment: "Whether the change impacts network adequacy."
    - name: "member_notification_required_flag"
      expr: member_notification_required_flag
      comment: "Whether member notification is required."
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Whether regulatory reporting is required."
    - name: "vbc_arrangement_flag"
      expr: vbc_arrangement_flag
      comment: "Whether the change involves a VBC arrangement."
    - name: "change_effective_year"
      expr: YEAR(change_effective_date)
      comment: "Year of change effective date for trend analysis."
  measures:
    - name: "total_change_events"
      expr: COUNT(1)
      comment: "Total count of network change events."
    - name: "changes_impacting_adequacy"
      expr: COUNT(CASE WHEN network_adequacy_impact_flag = true THEN 1 END)
      comment: "Count of changes impacting network adequacy — regulatory risk indicator."
    - name: "changes_requiring_member_notification"
      expr: COUNT(CASE WHEN member_notification_required_flag = true THEN 1 END)
      comment: "Count of changes requiring member notification — operational workload indicator."
    - name: "changes_requiring_regulatory_reporting"
      expr: COUNT(CASE WHEN regulatory_reporting_required_flag = true THEN 1 END)
      comment: "Count of changes requiring regulatory reporting."
    - name: "changes_requiring_transition_plan"
      expr: COUNT(CASE WHEN member_transition_plan_required_flag = true THEN 1 END)
      comment: "Count of changes requiring member transition plans — continuity of care indicator."
    - name: "vbc_related_changes"
      expr: COUNT(CASE WHEN vbc_arrangement_flag = true THEN 1 END)
      comment: "Count of changes related to value-based care arrangements."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network adequacy exception KPIs measuring exception volume, approval rates, appeal outcomes, and regulatory compliance for adequacy standard waivers."
  source: "`vibe_health_insurance_v1`.`network`.`exception`"
  dimensions:
    - name: "exception_type"
      expr: exception_type
      comment: "Type of adequacy exception requested."
    - name: "exception_status"
      expr: exception_status
      comment: "Current status of the exception."
    - name: "lob"
      expr: lob
      comment: "Line of business for the exception."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body granting the exception."
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Jurisdiction for the exception."
    - name: "specialty_name"
      expr: specialty_name
      comment: "Specialty for which the exception is requested."
    - name: "appeal_decision"
      expr: appeal_decision
      comment: "Decision on any appeal filed."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Whether an appeal was filed."
    - name: "member_notification_flag"
      expr: member_notification_flag
      comment: "Whether members were notified of the exception."
  measures:
    - name: "total_exceptions"
      expr: COUNT(1)
      comment: "Total count of network adequacy exceptions."
    - name: "approved_exceptions"
      expr: COUNT(CASE WHEN exception_status = 'Approved' THEN 1 END)
      comment: "Count of approved exceptions — regulatory flexibility indicator."
    - name: "denied_exceptions"
      expr: COUNT(CASE WHEN exception_status = 'Denied' THEN 1 END)
      comment: "Count of denied exceptions — areas requiring network investment."
    - name: "exceptions_with_appeals"
      expr: COUNT(CASE WHEN appeal_filed_flag = true THEN 1 END)
      comment: "Count of exceptions where appeals were filed."
    - name: "distinct_specialties_with_exceptions"
      expr: COUNT(DISTINCT specialty_code)
      comment: "Number of distinct specialties with exceptions — breadth of adequacy challenges."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring network adequacy regulatory filing compliance, submission timeliness, and deficiency rates. Used by regulatory affairs and network compliance teams to manage CMS and state DOI filing obligations."
  source: "`vibe_health_insurance_v1`.`network`.`filing`"
  dimensions:
    - name: "provider_network_id"
      expr: provider_network_id
      comment: "Provider network associated with the regulatory filing."
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing (adequacy, exception, annual) for compliance category analysis."
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the filing (submitted, approved, rejected, pending) for pipeline management."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body receiving the filing (CMS, state DOI) for jurisdiction-specific compliance tracking."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business covered by the filing."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year of the filing for annual compliance cycle tracking."
    - name: "submission_date"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of filing submission for timeliness trend analysis."
  measures:
    - name: "total_filings"
      expr: COUNT(1)
      comment: "Total regulatory filings submitted. Baseline compliance activity volume."
    - name: "approved_filing_count"
      expr: COUNT(CASE WHEN filing_status = 'Approved' THEN 1 END)
      comment: "Number of filings receiving regulatory approval. Core compliance success metric."
    - name: "filing_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN filing_status = 'Approved' THEN 1 END) / NULLIF(COUNT(CASE WHEN filing_status IN ('Approved', 'Rejected') THEN 1 END), 0), 2)
      comment: "Percentage of decided filings that were approved. Regulatory quality metric — low rates signal systemic adequacy or documentation issues."
    - name: "deficiency_issued_count"
      expr: COUNT(CASE WHEN deficiency_issued_flag = TRUE THEN 1 END)
      comment: "Number of filings resulting in a regulatory deficiency notice. Compliance risk metric requiring immediate remediation response."
    - name: "deficiency_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN deficiency_issued_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings resulting in deficiency notices. Elevated rates trigger executive escalation and regulatory relationship management."
    - name: "adequacy_standard_met_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN adequacy_standard_met_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings where the adequacy standard was certified as met. Primary network adequacy compliance KPI for regulatory reporting."
    - name: "exception_approved_count"
      expr: COUNT(CASE WHEN exception_approved_flag = TRUE THEN 1 END)
      comment: "Number of filings with approved exceptions. Tracks regulatory accommodation of network gaps — high counts signal structural adequacy challenges."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_directory_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring provider directory accuracy, verification compliance, and CMS reporting readiness. Used by network operations and compliance teams to meet CMS quarterly directory accuracy requirements and avoid penalties."
  source: "`vibe_health_insurance_v1`.`network`.`network_directory_verification`"
  dimensions:
    - name: "provider_network_id"
      expr: provider_network_id
      comment: "Provider network for directory verification segmentation."
    - name: "verification_status"
      expr: verification_status
      comment: "Outcome of the verification attempt (verified, unverified, unreachable) for compliance reporting."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used for verification (phone, mail, portal) for operational efficiency analysis."
    - name: "compliance_quarter"
      expr: compliance_quarter
      comment: "CMS compliance quarter for quarterly directory accuracy reporting."
    - name: "compliance_year"
      expr: compliance_year
      comment: "Compliance year for annual directory accuracy trend analysis."
    - name: "cms_reportable"
      expr: cms_reportable
      comment: "Whether the verification is subject to CMS reporting requirements."
    - name: "changes_identified"
      expr: changes_identified
      comment: "Whether the verification identified directory inaccuracies requiring updates."
    - name: "verification_date"
      expr: DATE_TRUNC('month', verification_date)
      comment: "Month of verification for trend analysis of directory maintenance activity."
  measures:
    - name: "total_verifications"
      expr: COUNT(1)
      comment: "Total directory verification attempts. Baseline compliance activity volume metric."
    - name: "verified_count"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END)
      comment: "Number of successfully verified directory entries. Core CMS directory accuracy compliance metric."
    - name: "directory_accuracy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of directory entries verified as accurate. CMS requires 95%+ accuracy — this KPI directly drives penalty avoidance."
    - name: "changes_identified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN changes_identified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of verifications identifying directory inaccuracies. High rates signal systemic data quality issues requiring process improvement."
    - name: "avg_accuracy_score"
      expr: ROUND(AVG(CAST(accuracy_score AS DOUBLE)), 2)
      comment: "Average directory accuracy score across verifications. Composite quality metric for provider directory data governance."
    - name: "avg_provider_response_time_hours"
      expr: ROUND(AVG(CAST(provider_response_time_hours AS DOUBLE)), 2)
      comment: "Average hours for provider to respond to verification outreach. Operational efficiency metric for directory maintenance workflows."
    - name: "directory_updated_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN directory_updated = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN changes_identified = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of identified changes that resulted in a directory update. Measures operational follow-through on verification findings."
    - name: "overdue_verification_count"
      expr: COUNT(CASE WHEN next_verification_due_date < CURRENT_DATE() AND is_active = TRUE THEN 1 END)
      comment: "Number of provider directory entries with overdue verification. Compliance risk metric for CMS quarterly reporting deadlines."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_par_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring participating provider agreement health, credentialing compliance, and network participation status. Used by contracting and network operations to manage provider agreement lifecycle and compliance."
  source: "`vibe_health_insurance_v1`.`network`.`par_agreement`"
  dimensions:
    - name: "provider_network_id"
      expr: provider_network_id
      comment: "Provider network associated with the PAR agreement."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the PAR agreement (active, pending, terminated) for portfolio management."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of participation agreement for segmenting by contract structure."
    - name: "lob"
      expr: lob
      comment: "Line of business covered by the agreement."
    - name: "provider_credentialing_status"
      expr: provider_credentialing_status
      comment: "Credentialing status of the provider under this agreement — compliance critical."
    - name: "reimbursement_methodology"
      expr: reimbursement_methodology
      comment: "Payment methodology (FFS, capitation, VBC) for financial analysis of network cost structure."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of agreement effective date for contract portfolio trend analysis."
    - name: "amendment_flag"
      expr: amendment_flag
      comment: "Whether the agreement has been amended, for contract change management tracking."
  measures:
    - name: "total_par_agreements"
      expr: COUNT(1)
      comment: "Total PAR agreements in the portfolio. Baseline network contracting volume metric."
    - name: "active_par_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' AND is_active = TRUE THEN 1 END)
      comment: "Number of currently active PAR agreements. Core network contracting health metric."
    - name: "credentialing_compliant_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN provider_credentialing_status = 'Credentialed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PAR agreements with credentialed providers. Compliance KPI — non-credentialed providers under active agreements create regulatory and payment risk."
    - name: "recredentialing_overdue_count"
      expr: COUNT(CASE WHEN provider_recredentialing_due_date < CURRENT_DATE() AND agreement_status = 'Active' THEN 1 END)
      comment: "Number of active agreements with overdue provider recredentialing. Immediate compliance action trigger."
    - name: "amended_agreement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN amendment_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements that have been amended. High rates may indicate contract instability or frequent regulatory changes."
    - name: "terminating_within_90_days_count"
      expr: COUNT(CASE WHEN termination_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) AND agreement_status = 'Active' THEN 1 END)
      comment: "Number of active agreements terminating within 90 days. Drives proactive renewal and network continuity planning."
    - name: "distinct_providers_under_agreement"
      expr: COUNT(DISTINCT provider_id)
      comment: "Number of distinct providers with PAR agreements. Network breadth metric for adequacy and access reporting."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_provider_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring provider participation health, panel capacity, credentialing status, and network composition. Used by network management to monitor provider availability, access, and quality tier distribution."
  source: "`vibe_health_insurance_v1`.`network`.`provider_assignment`"
  dimensions:
    - name: "provider_network_id"
      expr: provider_network_id
      comment: "Provider network for segmenting participation metrics by network."
    - name: "participation_status"
      expr: participation_status
      comment: "Provider participation status (active, pending, terminated) for network composition analysis."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status of the provider assignment, critical for compliance and quality reporting."
    - name: "pcp_flag"
      expr: pcp_flag
      comment: "Whether the provider is a primary care physician, enabling PCP-specific capacity analysis."
    - name: "specialist_flag"
      expr: specialist_flag
      comment: "Whether the provider is a specialist, for specialty access analysis."
    - name: "tier_assignment"
      expr: tier_assignment
      comment: "Quality/cost tier assignment for value-based network steerage analysis."
    - name: "telehealth_available_flag"
      expr: telehealth_available_flag
      comment: "Whether the provider offers telehealth, for access modality reporting."
    - name: "accepting_new_patients_flag"
      expr: accepting_new_patients_flag
      comment: "Whether the provider is accepting new patients — directly impacts member access and adequacy compliance."
    - name: "vbc_participant_flag"
      expr: vbc_participant_flag
      comment: "Whether the provider participates in value-based care arrangements."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of provider assignment effective date for network growth trend analysis."
  measures:
    - name: "total_provider_assignments"
      expr: COUNT(1)
      comment: "Total provider-network assignment records. Baseline network size metric."
    - name: "active_provider_count"
      expr: COUNT(CASE WHEN participation_status = 'Active' AND is_active = TRUE THEN 1 END)
      comment: "Number of currently active provider assignments. Core network size KPI for adequacy and access reporting."
    - name: "accepting_new_patients_count"
      expr: COUNT(CASE WHEN accepting_new_patients_flag = TRUE AND participation_status = 'Active' THEN 1 END)
      comment: "Number of active providers accepting new patients. Directly measures member access capacity and drives adequacy compliance."
    - name: "accepting_new_patients_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN accepting_new_patients_flag = TRUE AND participation_status = 'Active' THEN 1 END) / NULLIF(COUNT(CASE WHEN participation_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active providers accepting new patients. Key access metric for member experience and regulatory compliance."
    - name: "credentialed_provider_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN credentialing_status = 'Credentialed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of provider assignments with completed credentialing. Compliance quality metric — uncredentialed providers create regulatory and liability risk."
    - name: "telehealth_enabled_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN telehealth_available_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN participation_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active providers offering telehealth. Informs access modality strategy and CMS telehealth equivalency compliance."
    - name: "vbc_participant_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN vbc_participant_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN participation_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active providers in value-based care arrangements. Strategic KPI for VBC program penetration and total cost of care management."
    - name: "recredentialing_overdue_count"
      expr: COUNT(CASE WHEN recredentialing_due_date < CURRENT_DATE() AND participation_status = 'Active' THEN 1 END)
      comment: "Number of active providers with overdue recredentialing. Compliance risk metric requiring immediate operational action."
    - name: "distinct_active_networks"
      expr: COUNT(DISTINCT provider_network_id)
      comment: "Number of distinct networks with active provider assignments. Network breadth indicator for market coverage analysis."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_provider_network`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs measuring network portfolio health, NCQA accreditation status, adequacy compliance, and VBC participation across the provider network master. Used by network strategy and executive leadership for portfolio-level decisions."
  source: "`vibe_health_insurance_v1`.`network`.`provider_network`"
  dimensions:
    - name: "network_type"
      expr: network_type
      comment: "Network type (HMO, PPO, EPO, POS) for portfolio segmentation by network structure."
    - name: "network_status"
      expr: network_status
      comment: "Current operational status of the network for active portfolio management."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business served by the network for LOB-specific performance analysis."
    - name: "ncqa_accreditation_status"
      expr: ncqa_accreditation_status
      comment: "NCQA accreditation status — quality credential affecting plan marketability and regulatory standing."
    - name: "network_adequacy_status"
      expr: network_adequacy_status
      comment: "Current adequacy compliance status for regulatory risk segmentation."
    - name: "vbc_arrangement_flag"
      expr: vbc_arrangement_flag
      comment: "Whether the network has VBC arrangements — strategic transformation indicator."
    - name: "effective_date"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year of network effective date for portfolio vintage analysis."
  measures:
    - name: "total_networks"
      expr: COUNT(1)
      comment: "Total provider networks in the portfolio. Baseline network portfolio scale metric."
    - name: "active_network_count"
      expr: COUNT(CASE WHEN network_status = 'Active' AND is_active = TRUE THEN 1 END)
      comment: "Number of currently active provider networks. Core portfolio health metric for executive reporting."
    - name: "ncqa_accredited_network_count"
      expr: COUNT(CASE WHEN ncqa_accreditation_status = 'Accredited' THEN 1 END)
      comment: "Number of NCQA-accredited networks. Quality credential metric affecting plan star ratings and market competitiveness."
    - name: "ncqa_accreditation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ncqa_accreditation_status = 'Accredited' THEN 1 END) / NULLIF(COUNT(CASE WHEN network_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active networks with NCQA accreditation. Strategic quality KPI for plan competitiveness and regulatory standing."
    - name: "adequacy_compliant_network_count"
      expr: COUNT(CASE WHEN network_adequacy_status = 'Compliant' AND network_status = 'Active' THEN 1 END)
      comment: "Number of active networks meeting adequacy standards. Regulatory compliance portfolio metric."
    - name: "adequacy_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN network_adequacy_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(CASE WHEN network_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active networks with compliant adequacy status. Executive-level regulatory risk KPI."
    - name: "vbc_enabled_network_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN vbc_arrangement_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN network_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active networks with VBC arrangements. Strategic transformation metric for value-based care program penetration."
    - name: "avg_star_rating"
      expr: ROUND(AVG(CAST(star_rating AS DOUBLE)), 2)
      comment: "Average star rating across provider networks. Quality composite metric directly tied to CMS bonus payments and plan marketability."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_recruitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs tracking provider recruitment pipeline performance, conversion rates, and adequacy gap closure. Used by network development leadership to manage recruitment ROI and adequacy remediation effectiveness."
  source: "`vibe_health_insurance_v1`.`network`.`recruitment`"
  dimensions:
    - name: "provider_network_id"
      expr: provider_network_id
      comment: "Target network for the recruitment effort."
    - name: "recruitment_status"
      expr: recruitment_status
      comment: "Current status of the recruitment (outreach, negotiating, contracted, declined) for pipeline stage analysis."
    - name: "target_specialty"
      expr: target_specialty
      comment: "Specialty being recruited to close adequacy gaps."
    - name: "lob"
      expr: lob
      comment: "Line of business driving the recruitment need."
    - name: "priority_level"
      expr: priority_level
      comment: "Recruitment priority level for resource allocation decisions."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the recruitment effort (contracted, declined, no response) for conversion analysis."
    - name: "outreach_date"
      expr: DATE_TRUNC('month', outreach_date)
      comment: "Month of initial outreach for recruitment pipeline trend analysis."
    - name: "adequacy_gap_type"
      expr: adequacy_gap_type
      comment: "Type of adequacy gap driving the recruitment, linking effort to compliance need."
  measures:
    - name: "total_recruitment_efforts"
      expr: COUNT(1)
      comment: "Total provider recruitment efforts initiated. Baseline pipeline volume metric."
    - name: "contracted_provider_count"
      expr: COUNT(CASE WHEN disposition = 'Contracted' OR recruitment_status = 'Contracted' THEN 1 END)
      comment: "Number of recruitment efforts resulting in a contract. Primary success metric for network development ROI."
    - name: "recruitment_conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN disposition = 'Contracted' OR recruitment_status = 'Contracted' THEN 1 END) / NULLIF(COUNT(CASE WHEN disposition IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of completed recruitment efforts resulting in a contract. Efficiency KPI for network development team performance."
    - name: "regulatory_filing_required_count"
      expr: COUNT(CASE WHEN regulatory_filing_required_flag = TRUE THEN 1 END)
      comment: "Number of recruitment efforts tied to regulatory filing requirements. Compliance urgency indicator for prioritization."
    - name: "avg_estimated_annual_claims_volume"
      expr: ROUND(AVG(CAST(estimated_annual_claims_volume AS DOUBLE)), 2)
      comment: "Average estimated annual claims volume for recruited providers. Financial impact metric for network investment decisions."
    - name: "total_estimated_annual_claims_volume"
      expr: SUM(CAST(estimated_annual_claims_volume AS DOUBLE))
      comment: "Total estimated annual claims volume across all recruitment efforts. Aggregate financial impact of network development pipeline."
    - name: "distinct_specialties_recruited"
      expr: COUNT(DISTINCT target_specialty)
      comment: "Number of distinct specialties targeted in recruitment. Breadth of adequacy gap remediation effort."
    - name: "declined_recruitment_count"
      expr: COUNT(CASE WHEN disposition = 'Declined' THEN 1 END)
      comment: "Number of providers who declined to join the network. High rates signal competitive or contractual barriers requiring strategic response."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_termination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring provider termination volume, member impact, regulatory reporting compliance, and network continuity risk. Used by network operations and compliance leadership to manage provider exits and protect member access."
  source: "`vibe_health_insurance_v1`.`network`.`termination`"
  dimensions:
    - name: "provider_network_id"
      expr: provider_network_id
      comment: "Network from which the provider is terminating."
    - name: "termination_type"
      expr: termination_type
      comment: "Type of termination (voluntary, involuntary, for-cause) for risk classification."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for termination to identify systemic patterns driving provider exits."
    - name: "for_cause_flag"
      expr: for_cause_flag
      comment: "Whether the termination is for cause — triggers additional regulatory reporting and member notification requirements."
    - name: "network_adequacy_impact_flag"
      expr: network_adequacy_impact_flag
      comment: "Whether the termination creates a network adequacy gap — drives immediate recruitment response."
    - name: "termination_status"
      expr: termination_status
      comment: "Current status of the termination process for operational tracking."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of termination effective date for trend analysis of network attrition."
    - name: "credentialing_related_flag"
      expr: credentialing_related_flag
      comment: "Whether the termination is credentialing-related — compliance and quality signal."
  measures:
    - name: "total_terminations"
      expr: COUNT(1)
      comment: "Total provider terminations. Baseline network attrition metric."
    - name: "for_cause_termination_count"
      expr: COUNT(CASE WHEN for_cause_flag = TRUE THEN 1 END)
      comment: "Number of for-cause terminations. Regulatory reporting trigger and quality risk indicator requiring executive awareness."
    - name: "for_cause_termination_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN for_cause_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminations that are for-cause. Elevated rates signal provider quality or compliance issues in the network."
    - name: "adequacy_impacting_termination_count"
      expr: COUNT(CASE WHEN network_adequacy_impact_flag = TRUE THEN 1 END)
      comment: "Number of terminations creating network adequacy gaps. Drives immediate recruitment response and potential exception filing."
    - name: "member_notification_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN member_notification_required_flag = TRUE AND member_notification_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN member_notification_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of required member notifications sent for terminations. Regulatory compliance metric — failure triggers CMS penalties."
    - name: "regulatory_reporting_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_reporting_required_flag = TRUE AND regulatory_report_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of required regulatory reports filed for terminations. Compliance KPI for CMS and state DOI reporting obligations."
    - name: "replacement_provider_required_count"
      expr: COUNT(CASE WHEN replacement_provider_required_flag = TRUE THEN 1 END)
      comment: "Number of terminations requiring replacement provider recruitment. Drives network development prioritization and adequacy gap prevention."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_vbc_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring value-based care arrangement performance, financial benchmarks, and quality thresholds. Used by VBC program leadership and finance to evaluate shared savings potential and arrangement portfolio health."
  source: "`vibe_health_insurance_v1`.`network`.`vbc_arrangement`"
  dimensions:
    - name: "arrangement_type"
      expr: arrangement_type
      comment: "Type of VBC arrangement (MSSP, REACH, commercial ACO) for portfolio segmentation."
    - name: "arrangement_status"
      expr: arrangement_status
      comment: "Current status of the arrangement for active portfolio management."
    - name: "risk_model"
      expr: risk_model
      comment: "Risk model (one-sided, two-sided) for financial risk exposure analysis."
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for year-over-year VBC performance comparison."
    - name: "cms_reporting_required_flag"
      expr: cms_reporting_required_flag
      comment: "Whether CMS reporting is required for this arrangement — compliance scope indicator."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year of arrangement start for portfolio vintage analysis."
  measures:
    - name: "total_vbc_arrangements"
      expr: COUNT(1)
      comment: "Total VBC arrangements in the portfolio. Baseline VBC program scale metric."
    - name: "active_arrangement_count"
      expr: COUNT(CASE WHEN arrangement_status = 'Active' AND is_active = TRUE THEN 1 END)
      comment: "Number of currently active VBC arrangements. Core VBC program portfolio metric for executive reporting."
    - name: "avg_benchmark_amount"
      expr: ROUND(AVG(CAST(benchmark_amount AS DOUBLE)), 2)
      comment: "Average benchmark amount across VBC arrangements. Financial baseline for shared savings/loss calculations."
    - name: "total_benchmark_amount"
      expr: SUM(CAST(benchmark_amount AS DOUBLE))
      comment: "Total benchmark amount across all VBC arrangements. Aggregate financial exposure metric for VBC program portfolio."
    - name: "avg_shared_savings_rate"
      expr: ROUND(AVG(CAST(shared_savings_rate AS DOUBLE)), 2)
      comment: "Average shared savings rate across arrangements. Informs financial modeling for VBC program economics."
    - name: "avg_quality_performance_threshold"
      expr: ROUND(AVG(CAST(quality_performance_threshold AS DOUBLE)), 2)
      comment: "Average quality performance threshold required for shared savings eligibility. Benchmarks quality gate stringency across the VBC portfolio."
    - name: "avg_minimum_savings_rate"
      expr: ROUND(AVG(CAST(minimum_savings_rate AS DOUBLE)), 2)
      comment: "Average minimum savings rate required before shared savings apply. Financial risk parameter for VBC arrangement design."
    - name: "avg_stop_loss_limit"
      expr: ROUND(AVG(CAST(stop_loss_limit AS DOUBLE)), 2)
      comment: "Average stop-loss limit across two-sided risk arrangements. Downside risk management metric for VBC financial exposure."
    - name: "total_performance_guarantee_amount"
      expr: SUM(CAST(performance_guarantee_amount AS DOUBLE))
      comment: "Total performance guarantee amounts at risk across VBC arrangements. Aggregate financial accountability metric for VBC program leadership."
$$;
