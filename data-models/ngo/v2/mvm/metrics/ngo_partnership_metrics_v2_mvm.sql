-- Metric views for domain: partnership | Business: Ngo | Version: 2 | Generated on: 2026-07-03 06:15:30

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over partnership agreements — tracks financial exposure, disbursement efficiency, and portfolio composition to guide partnership investment decisions."
  source: "`vibe_ngo_v1`.`partnership`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current lifecycle status of the agreement (e.g., Active, Closed, Suspended) — primary filter for portfolio health analysis."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of partnership agreement (e.g., Grant, MOU, Sub-award) — used to segment financial exposure by instrument type."
    - name: "transfer_modality"
      expr: transfer_modality
      comment: "Mechanism by which funds are transferred to the partner — key for cash-flow and risk segmentation."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic coverage of the agreement — enables regional portfolio analysis."
    - name: "operational_country_code"
      expr: operational_country_code
      comment: "Country where the agreement is operationally active — supports country-level portfolio reporting."
    - name: "program_sector"
      expr: program_sector
      comment: "Thematic sector of the agreement (e.g., Health, Education, WASH) — enables sector-level investment analysis."
    - name: "hact_risk_rating"
      expr: hact_risk_rating
      comment: "HACT risk rating assigned to the agreement — critical for risk-based portfolio segmentation."
    - name: "due_diligence_risk_rating"
      expr: due_diligence_risk_rating
      comment: "Risk rating from due diligence process — used to flag high-risk agreements for oversight."
    - name: "is_consortium_agreement"
      expr: is_consortium_agreement
      comment: "Indicates whether the agreement is part of a consortium — supports consortium vs. bilateral portfolio split."
    - name: "is_sub_award"
      expr: is_sub_award
      comment: "Indicates whether the agreement is a sub-award — used to distinguish prime vs. sub-award financial flows."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the agreement became effective — enables cohort and trend analysis by agreement vintage."
    - name: "effective_end_year"
      expr: YEAR(effective_end_date)
      comment: "Year the agreement is scheduled to end — supports pipeline and expiry forecasting."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency at which the partner must report (e.g., Monthly, Quarterly) — used to assess reporting burden distribution."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the agreement — required for multi-currency portfolio analysis."
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total number of partnership agreements — baseline portfolio size metric for executive dashboards."
    - name: "total_budget_committed"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total budget committed across all agreements — primary financial exposure KPI for resource allocation decisions."
    - name: "total_disbursed_amount"
      expr: SUM(CAST(disbursed_amount AS DOUBLE))
      comment: "Total funds disbursed to partners — measures actual cash outflow and implementation momentum."
    - name: "total_outstanding_dct"
      expr: SUM(CAST(outstanding_dct_amount AS DOUBLE))
      comment: "Total outstanding Direct Cash Transfer (DCT) balance — critical liquidity and accountability risk indicator."
    - name: "total_liquidated_amount"
      expr: SUM(CAST(liquidated_amount AS DOUBLE))
      comment: "Total amount liquidated (accounted for) by partners — measures financial accountability completion."
    - name: "avg_disbursement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(disbursed_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_budget_amount AS DOUBLE)), 0), 2)
      comment: "Average disbursement rate as a percentage of total budget — measures implementation pace and financial absorption capacity across the portfolio."
    - name: "avg_liquidation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(liquidated_amount AS DOUBLE)) / NULLIF(SUM(CAST(disbursed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of disbursed funds that have been liquidated — key accountability metric; low rates signal financial management risk."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate across agreements — informs cost efficiency benchmarking and negotiation strategy."
    - name: "total_funding_ceiling"
      expr: SUM(CAST(funding_ceiling_amount AS DOUBLE))
      comment: "Total funding ceiling across all agreements — represents the maximum authorized financial exposure for the partnership portfolio."
    - name: "consortium_agreement_count"
      expr: COUNT(CASE WHEN is_consortium_agreement = TRUE THEN 1 END)
      comment: "Number of consortium agreements — tracks the scale of multi-partner programming, a key localization and collaboration indicator."
    - name: "sub_award_count"
      expr: COUNT(CASE WHEN is_sub_award = TRUE THEN 1 END)
      comment: "Number of sub-award agreements — measures the depth of sub-contracting within the partnership portfolio."
    - name: "distinct_partner_orgs"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of distinct partner organizations engaged — measures breadth of the partnership network."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partner_org`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner organization portfolio health metrics — tracks due diligence status, risk ratings, financial scale, and capacity to support partner selection and oversight decisions."
  source: "`vibe_ngo_v1`.`partnership`.`partner_org`"
  dimensions:
    - name: "partner_org_status"
      expr: partner_org_status
      comment: "Current status of the partner organization (e.g., Active, Inactive, Suspended) — primary filter for active partner portfolio analysis."
    - name: "org_type"
      expr: org_type
      comment: "Type of organization (e.g., NGO, CBO, UN Agency, Government) — enables portfolio segmentation by partner category."
    - name: "due_diligence_status"
      expr: due_diligence_status
      comment: "Current due diligence status of the partner — critical for compliance and risk management oversight."
    - name: "hact_risk_rating"
      expr: hact_risk_rating
      comment: "HACT risk rating of the partner organization — used to segment partners by financial management risk level."
    - name: "hq_country"
      expr: hq_country
      comment: "Country where the partner organization is headquartered — supports geographic portfolio analysis."
    - name: "ip_transfer_modality"
      expr: ip_transfer_modality
      comment: "Implementing partner transfer modality (e.g., Direct Cash Transfer, Reimbursement) — informs cash management strategy."
    - name: "chs_certified"
      expr: chs_certified
      comment: "Whether the partner holds Core Humanitarian Standard (CHS) certification — quality and accountability benchmark."
    - name: "sanctions_screened"
      expr: sanctions_screened
      comment: "Whether the partner has been screened against sanctions lists — mandatory compliance indicator."
    - name: "partnership_status"
      expr: partnership_status
      comment: "Overall partnership engagement status — used to track active vs. pipeline vs. closed partner relationships."
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Accreditation status of the partner organization — used to filter for accredited partners in high-value programming."
    - name: "capacity_assessment_year"
      expr: YEAR(capacity_assessment_date)
      comment: "Year of the most recent capacity assessment — enables cohort analysis of assessment currency."
    - name: "due_diligence_expiry_year"
      expr: YEAR(due_diligence_expiry_date)
      comment: "Year the due diligence expires — used to identify partners requiring renewal and manage compliance pipeline."
  measures:
    - name: "total_partner_orgs"
      expr: COUNT(1)
      comment: "Total number of partner organizations in the registry — baseline measure of partnership network scale."
    - name: "active_partner_orgs"
      expr: COUNT(CASE WHEN partner_org_status = 'Active' THEN 1 END)
      comment: "Number of currently active partner organizations — measures the operational partnership base for resource planning."
    - name: "chs_certified_partners"
      expr: COUNT(CASE WHEN chs_certified = TRUE THEN 1 END)
      comment: "Number of CHS-certified partners — measures quality standards compliance across the partner portfolio."
    - name: "chs_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN chs_certified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners holding CHS certification — strategic quality benchmark; low rates indicate accountability gaps."
    - name: "sanctions_screened_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sanctions_screened = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners that have been sanctions-screened — critical compliance KPI; any gap below 100% is a regulatory risk."
    - name: "avg_capacity_assessment_score"
      expr: AVG(CAST(capacity_assessment_score AS DOUBLE))
      comment: "Average capacity assessment score across partner organizations — measures overall partner capability level for programming decisions."
    - name: "total_annual_budget_usd"
      expr: SUM(CAST(annual_budget_usd AS DOUBLE))
      comment: "Total annual budget (USD) across all partner organizations — measures the aggregate financial scale of the partner network."
    - name: "avg_annual_budget_usd"
      expr: AVG(CAST(annual_budget_usd AS DOUBLE))
      comment: "Average annual budget (USD) per partner organization — used to benchmark partner financial capacity and inform sub-award sizing."
    - name: "high_hact_risk_partners"
      expr: COUNT(CASE WHEN hact_risk_rating = 'High' THEN 1 END)
      comment: "Number of partners rated High HACT risk — directly triggers enhanced monitoring and assurance activities."
    - name: "due_diligence_compliant_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN due_diligence_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners with completed due diligence — measures compliance readiness of the partner portfolio; gaps block new agreements."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_capacity_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner capacity assessment KPIs — tracks assessment scores, risk ratings, and capacity building needs to guide partner development investment and risk-based programming decisions."
  source: "`vibe_ngo_v1`.`partnership`.`capacity_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of capacity assessment conducted (e.g., HACT Micro-assessment, Programmatic) — used to segment results by assessment methodology."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (e.g., Completed, In Progress, Pending) — used to filter for finalized assessments."
    - name: "overall_risk_rating"
      expr: overall_risk_rating
      comment: "Overall risk rating assigned by the assessment — primary dimension for risk-based partner segmentation."
    - name: "financial_risk_rating"
      expr: financial_risk_rating
      comment: "Financial management risk rating — used to identify partners requiring financial capacity building."
    - name: "assessment_methodology"
      expr: assessment_methodology
      comment: "Methodology used for the assessment — enables comparison of results across different assessment approaches."
    - name: "assessment_location_country"
      expr: assessment_location_country
      comment: "Country where the assessment was conducted — supports geographic risk analysis."
    - name: "capacity_building_plan_required"
      expr: capacity_building_plan_required
      comment: "Whether a capacity building plan is required based on assessment findings — used to size the capacity development pipeline."
    - name: "enhanced_monitoring_required"
      expr: enhanced_monitoring_required
      comment: "Whether enhanced monitoring is required — directly drives assurance resource allocation decisions."
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year the assessment was conducted — enables trend analysis of partner capacity over time."
    - name: "assessment_tool_version"
      expr: assessment_tool_version
      comment: "Version of the assessment tool used — ensures comparability of scores across tool versions."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of capacity assessments conducted — baseline measure of assessment program scale."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall capacity score across all assessments — headline KPI for partner portfolio capability level."
    - name: "avg_financial_mgmt_score"
      expr: AVG(CAST(financial_mgmt_score AS DOUBLE))
      comment: "Average financial management score — measures partner financial accountability capability; low scores drive enhanced assurance."
    - name: "avg_governance_score"
      expr: AVG(CAST(governance_score AS DOUBLE))
      comment: "Average governance score — measures organizational governance quality across the partner portfolio."
    - name: "avg_program_mgmt_score"
      expr: AVG(CAST(program_mgmt_score AS DOUBLE))
      comment: "Average program management score — measures partner delivery capability for programming decisions."
    - name: "avg_mel_score"
      expr: AVG(CAST(mel_score AS DOUBLE))
      comment: "Average Monitoring, Evaluation and Learning (MEL) score — measures partner data quality and accountability capacity."
    - name: "capacity_building_plan_required_count"
      expr: COUNT(CASE WHEN capacity_building_plan_required = TRUE THEN 1 END)
      comment: "Number of assessments requiring a capacity building plan — sizes the capacity development investment pipeline."
    - name: "enhanced_monitoring_required_count"
      expr: COUNT(CASE WHEN enhanced_monitoring_required = TRUE THEN 1 END)
      comment: "Number of partners requiring enhanced monitoring — directly drives assurance resource planning and budget allocation."
    - name: "high_risk_assessment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_risk_rating = 'High' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments resulting in a High risk rating — strategic risk portfolio indicator; high rates trigger escalation to leadership."
    - name: "avg_partner_self_assessment_score"
      expr: AVG(CAST(partner_self_assessment_score AS DOUBLE))
      comment: "Average partner self-assessment score — compared against assessor scores to identify perception gaps and capacity building priorities."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_due_diligence_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Due diligence compliance KPIs — tracks screening completeness, certification status, and risk levels to ensure partners meet regulatory and organizational standards before engagement."
  source: "`vibe_ngo_v1`.`partnership`.`due_diligence_record`"
  dimensions:
    - name: "diligence_type"
      expr: diligence_type
      comment: "Type of due diligence conducted (e.g., Financial, Legal, Safeguarding) — used to segment compliance coverage by category."
    - name: "diligence_status"
      expr: diligence_status
      comment: "Current status of the due diligence process — primary filter for compliance pipeline management."
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Final outcome of the due diligence review (e.g., Approved, Rejected, Conditional) — key decision gate metric."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned by the due diligence review — used to segment partners by compliance risk for oversight prioritization."
    - name: "chs_certification_status"
      expr: chs_certification_status
      comment: "CHS certification status at time of due diligence — quality accountability benchmark."
    - name: "debarment_check_status"
      expr: debarment_check_status
      comment: "Status of debarment list check — mandatory compliance gate; any non-cleared status blocks partnership."
    - name: "aml_cft_check_status"
      expr: aml_cft_check_status
      comment: "Anti-Money Laundering / Counter-Financing of Terrorism check status — regulatory compliance requirement."
    - name: "financial_audit_opinion"
      expr: financial_audit_opinion
      comment: "External audit opinion on partner financials — key financial accountability indicator."
    - name: "initiation_year"
      expr: YEAR(initiation_date)
      comment: "Year the due diligence was initiated — enables trend analysis of compliance pipeline throughput."
    - name: "sphere_compliance_status"
      expr: sphere_compliance_status
      comment: "Sphere humanitarian standards compliance status — quality benchmark for humanitarian programming partners."
  measures:
    - name: "total_due_diligence_records"
      expr: COUNT(1)
      comment: "Total number of due diligence records — baseline measure of compliance review pipeline volume."
    - name: "approved_due_diligence_count"
      expr: COUNT(CASE WHEN overall_outcome = 'Approved' THEN 1 END)
      comment: "Number of due diligence reviews with an Approved outcome — measures the volume of partners cleared for engagement."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_outcome = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of due diligence reviews resulting in approval — measures partner quality pipeline conversion rate."
    - name: "legal_registration_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN legal_registration_verified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners with verified legal registration — mandatory compliance baseline; gaps represent legal engagement risk."
    - name: "safeguarding_policy_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN safeguarding_policy_verified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners with verified safeguarding policies — critical PSEA and child protection compliance indicator."
    - name: "anti_terrorism_certified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN anti_terrorism_certification = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners with valid anti-terrorism certification — regulatory compliance requirement for most institutional donors."
    - name: "financial_audit_reviewed_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN financial_audit_reviewed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners whose financial audit has been reviewed — measures financial accountability assurance coverage."
    - name: "high_risk_partners_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Number of partners assessed as high risk in due diligence — triggers enhanced oversight and conditional approval processes."
    - name: "governance_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN governance_verified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners with verified governance structures — measures organizational accountability compliance across the partner portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partner_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner performance review KPIs — tracks programmatic quality, financial accountability, milestone achievement, and reporting compliance to drive partnership renewal and corrective action decisions."
  source: "`vibe_ngo_v1`.`partnership`.`partner_performance_review`"
  dimensions:
    - name: "overall_performance_rating"
      expr: overall_performance_rating
      comment: "Overall performance rating assigned in the review (e.g., Excellent, Satisfactory, Unsatisfactory) — primary KPI for partner portfolio health."
    - name: "review_type"
      expr: review_type
      comment: "Type of performance review (e.g., Annual, Mid-term, Final) — used to segment results by review stage."
    - name: "financial_accountability_rating"
      expr: financial_accountability_rating
      comment: "Rating for financial accountability — key indicator for disbursement and liquidation decisions."
    - name: "programmatic_quality_rating"
      expr: programmatic_quality_rating
      comment: "Rating for programmatic quality — measures delivery effectiveness for program steering decisions."
    - name: "reporting_compliance_rating"
      expr: reporting_compliance_rating
      comment: "Rating for reporting compliance — measures partner adherence to reporting obligations."
    - name: "safeguarding_compliance_rating"
      expr: safeguarding_compliance_rating
      comment: "Rating for safeguarding compliance — critical risk indicator; poor ratings trigger immediate escalation."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned in the performance review — used to prioritize oversight and support interventions."
    - name: "partnership_renewal_recommendation"
      expr: partnership_renewal_recommendation
      comment: "Recommendation on whether to renew the partnership — direct input to partnership pipeline and budget planning."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required — flags partners needing immediate management intervention."
    - name: "review_year"
      expr: YEAR(review_date)
      comment: "Year the performance review was conducted — enables year-over-year partner performance trend analysis."
    - name: "capacity_building_recommended"
      expr: capacity_building_recommended
      comment: "Whether capacity building is recommended — used to size the partner development investment pipeline."
  measures:
    - name: "total_performance_reviews"
      expr: COUNT(1)
      comment: "Total number of partner performance reviews conducted — baseline measure of review program coverage."
    - name: "avg_overall_performance_score"
      expr: AVG(CAST(overall_performance_score AS DOUBLE))
      comment: "Average overall performance score across all reviews — headline KPI for partner portfolio performance quality."
    - name: "avg_budget_utilisation_rate"
      expr: AVG(CAST(budget_utilisation_rate AS DOUBLE))
      comment: "Average budget utilisation rate across partner reviews — measures financial absorption efficiency; low rates indicate implementation bottlenecks."
    - name: "avg_milestone_achievement_rate"
      expr: AVG(CAST(milestone_achievement_rate AS DOUBLE))
      comment: "Average milestone achievement rate — measures programmatic delivery effectiveness across the partner portfolio."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of reviews requiring corrective action — directly triggers management intervention and resource reallocation decisions."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews resulting in corrective action — portfolio-level risk indicator; high rates signal systemic partner quality issues."
    - name: "renewal_recommended_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN partnership_renewal_recommendation = 'Recommended' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews recommending partnership renewal — measures partner retention quality and informs pipeline planning."
    - name: "field_visit_conducted_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN field_visit_conducted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews that included a field visit — measures assurance depth; low rates indicate remote-only oversight gaps."
    - name: "beneficiary_feedback_incorporated_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN beneficiary_feedback_incorporated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews incorporating beneficiary feedback — measures accountability to affected populations, a core humanitarian standard."
    - name: "capacity_building_recommended_count"
      expr: COUNT(CASE WHEN capacity_building_recommended = TRUE THEN 1 END)
      comment: "Number of partners recommended for capacity building — sizes the partner development investment pipeline for budget planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partner_report_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner reporting compliance and quality KPIs — tracks submission timeliness, quality scores, and financial documentation to manage donor obligations and partner accountability."
  source: "`vibe_ngo_v1`.`partnership`.`partner_report_submission`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of report submitted (e.g., Financial, Narrative, Progress) — used to segment compliance by reporting obligation type."
    - name: "partner_report_submission_status"
      expr: partner_report_submission_status
      comment: "Current status of the report submission (e.g., Submitted, Accepted, Rejected) — primary filter for reporting pipeline management."
    - name: "review_status"
      expr: review_status
      comment: "Status of the review process for the submitted report — tracks review pipeline throughput."
    - name: "is_late_submission"
      expr: is_late_submission
      comment: "Whether the report was submitted after the due date — key compliance indicator for donor relationship management."
    - name: "report_period_frequency"
      expr: report_period_frequency
      comment: "Frequency of the reporting period (e.g., Monthly, Quarterly, Annual) — used to segment compliance by reporting cycle."
    - name: "country_code"
      expr: country_code
      comment: "Country associated with the report submission — enables geographic compliance analysis."
    - name: "cluster_sector"
      expr: cluster_sector
      comment: "Humanitarian cluster or sector of the report — supports sector-level reporting compliance analysis."
    - name: "donor_reporting_obligation"
      expr: donor_reporting_obligation
      comment: "Whether the submission fulfills a donor reporting obligation — used to prioritize compliance tracking for donor-facing reports."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the report was submitted — enables year-over-year reporting compliance trend analysis."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the report (e.g., Email, Portal, In-person) — used to track digital adoption and process efficiency."
  measures:
    - name: "total_report_submissions"
      expr: COUNT(1)
      comment: "Total number of partner report submissions — baseline measure of reporting pipeline volume."
    - name: "on_time_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_late_submission = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports submitted on time — primary reporting compliance KPI; low rates risk donor relationship and funding continuity."
    - name: "late_submission_count"
      expr: COUNT(CASE WHEN is_late_submission = TRUE THEN 1 END)
      comment: "Number of late report submissions — operational metric for compliance follow-up and partner accountability management."
    - name: "avg_report_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score of submitted reports — measures reporting quality across the partner portfolio; low scores drive capacity building."
    - name: "total_expenditure_reported"
      expr: SUM(CAST(total_expenditure_reported AS DOUBLE))
      comment: "Total expenditure reported by partners across all submissions — measures financial accountability coverage and burn rate."
    - name: "financial_documentation_attached_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN financial_documentation_attached = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions with financial documentation attached — measures financial accountability compliance; gaps trigger audit flags."
    - name: "mel_indicators_reported_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mel_indicators_reported = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions including MEL indicator data — measures results reporting compliance; critical for donor accountability and program learning."
    - name: "total_approved_budget_reported"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved budget amount covered by report submissions — measures financial reporting coverage against authorized budgets."
    - name: "distinct_reporting_partners"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of distinct partner organizations that have submitted reports — measures reporting network breadth and identifies non-reporting partners."
    - name: "accepted_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN partner_report_submission_status = 'Accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions accepted without revision — measures first-pass quality rate; low rates indicate systemic reporting quality issues."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_consortium`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consortium portfolio KPIs — tracks funding scale, localization progress, membership composition, and operational status to guide multi-partner programming and localization strategy decisions."
  source: "`vibe_ngo_v1`.`partnership`.`consortium`"
  dimensions:
    - name: "consortium_status"
      expr: consortium_status
      comment: "Current status of the consortium (e.g., Active, Closed, Pipeline) — primary filter for active portfolio analysis."
    - name: "consortium_type"
      expr: consortium_type
      comment: "Type of consortium (e.g., Humanitarian, Development, Mixed) — used to segment portfolio by programming modality."
    - name: "country_code"
      expr: country_code
      comment: "Country of consortium operations — enables geographic portfolio analysis."
    - name: "ngo_role"
      expr: ngo_role
      comment: "Role of the NGO within the consortium (e.g., Lead, Member) — used to analyze leadership vs. participation portfolio split."
    - name: "ocha_cluster_alignment"
      expr: ocha_cluster_alignment
      comment: "OCHA humanitarian cluster the consortium is aligned to — enables cluster-level portfolio analysis."
    - name: "grand_bargain_localization"
      expr: grand_bargain_localization
      comment: "Whether the consortium is aligned to Grand Bargain localization commitments — tracks localization agenda progress."
    - name: "chs_compliance_status"
      expr: chs_compliance_status
      comment: "CHS compliance status of the consortium — quality accountability benchmark for multi-partner programming."
    - name: "thematic_focus"
      expr: thematic_focus
      comment: "Thematic focus area of the consortium (e.g., Food Security, Protection) — enables thematic portfolio analysis."
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the consortium was established — enables cohort and vintage analysis of the consortium portfolio."
    - name: "funding_currency"
      expr: funding_currency
      comment: "Currency of consortium funding — required for multi-currency portfolio analysis."
  measures:
    - name: "total_consortia"
      expr: COUNT(1)
      comment: "Total number of consortia — baseline measure of multi-partner programming portfolio scale."
    - name: "total_consortium_funding"
      expr: SUM(CAST(total_funding_amount AS DOUBLE))
      comment: "Total funding mobilized across all consortia — measures the financial scale of multi-partner programming."
    - name: "avg_localization_percentage"
      expr: AVG(CAST(localization_percentage AS DOUBLE))
      comment: "Average localization percentage across consortia — measures progress against Grand Bargain localization commitments; strategic NGO accountability KPI."
    - name: "avg_ngo_funding_share"
      expr: AVG(CAST(ngo_funding_share AS DOUBLE))
      comment: "Average NGO funding share within consortia — measures the financial weight of NGO leadership in multi-partner programming."
    - name: "grand_bargain_aligned_count"
      expr: COUNT(CASE WHEN grand_bargain_localization = TRUE THEN 1 END)
      comment: "Number of consortia aligned to Grand Bargain localization commitments — tracks progress on the sector-wide localization agenda."
    - name: "grand_bargain_alignment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN grand_bargain_localization = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consortia aligned to Grand Bargain localization — strategic KPI for donor reporting on localization commitments."
    - name: "total_ngo_funding_share_amount"
      expr: SUM(CAST(ngo_funding_share AS DOUBLE))
      comment: "Total NGO funding share across all consortia — measures aggregate NGO financial contribution to multi-partner programming."
    - name: "distinct_lead_partners"
      expr: COUNT(DISTINCT lead_partner_org_id)
      comment: "Number of distinct organizations leading consortia — measures diversity of consortium leadership across the portfolio."
$$;