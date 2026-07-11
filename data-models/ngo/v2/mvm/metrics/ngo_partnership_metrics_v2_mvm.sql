-- Metric views for domain: partnership | Business: Ngo | Version: 2 | Generated on: 2026-07-10 20:18:10

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for partnership agreements — tracks funding ceilings, agreement portfolio composition, indirect cost rates, and lifecycle status to inform partnership investment decisions and compliance oversight."
  source: "`vibe_ngo_v1`.`partnership`.`agreement`"
  dimensions:
    - name: "partnership_agreement_status"
      expr: partnership_agreement_status
      comment: "Current lifecycle status of the agreement (e.g., Active, Expired, Terminated) — primary filter for portfolio health analysis."
    - name: "partnership_agreement_type"
      expr: partnership_agreement_type
      comment: "Type of partnership agreement (e.g., MOU, Grant Agreement, Sub-Award) — used to segment portfolio by instrument type."
    - name: "program_sector"
      expr: program_sector
      comment: "Humanitarian or development sector the agreement supports — enables sector-level funding analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic coverage of the agreement — supports regional portfolio analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the agreement is denominated — relevant for multi-currency portfolio reporting."
    - name: "is_consortium_agreement"
      expr: is_consortium_agreement
      comment: "Indicates whether the agreement is part of a consortium arrangement — used to distinguish bilateral vs. consortium partnerships."
    - name: "is_sub_award"
      expr: is_sub_award
      comment: "Indicates whether the agreement is a sub-award — used to separate prime awards from sub-awards in portfolio analysis."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency at which the partner is required to report (e.g., Monthly, Quarterly) — used to assess reporting burden distribution."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the agreement became effective — used for cohort and trend analysis of new agreements."
    - name: "effective_end_year"
      expr: YEAR(effective_end_date)
      comment: "Year the agreement is scheduled to end — used for pipeline and expiry forecasting."
    - name: "governing_law_country_code"
      expr: governing_law_country_code
      comment: "Country whose law governs the agreement — relevant for legal and compliance segmentation."
  measures:
    - name: "total_funding_ceiling_amount"
      expr: SUM(CAST(funding_ceiling_amount AS DOUBLE))
      comment: "Total committed funding ceiling across all agreements — primary indicator of partnership portfolio financial scale."
    - name: "avg_funding_ceiling_amount"
      expr: AVG(CAST(funding_ceiling_amount AS DOUBLE))
      comment: "Average funding ceiling per agreement — benchmarks typical agreement size and informs resource allocation decisions."
    - name: "total_active_agreements"
      expr: COUNT(CASE WHEN partnership_agreement_status = 'Active' THEN agreement_id END)
      comment: "Count of currently active partnership agreements — core portfolio health KPI for executive dashboards."
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total number of partnership agreements in the portfolio — baseline volume metric for trend and growth analysis."
    - name: "consortium_agreement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_consortium_agreement = TRUE THEN agreement_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements that are consortium-based — tracks localization and multi-partner collaboration strategy adoption."
    - name: "sub_award_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_sub_award = TRUE THEN agreement_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements that are sub-awards — informs pass-through funding strategy and prime vs. sub-award portfolio balance."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate across agreements — used to monitor overhead burden and negotiate cost efficiency with partners."
    - name: "total_funding_ceiling_active"
      expr: SUM(CASE WHEN partnership_agreement_status = 'Active' THEN CAST(funding_ceiling_amount AS DOUBLE) ELSE 0 END)
      comment: "Total funding ceiling for active agreements only — represents live financial exposure and active partnership investment."
    - name: "renewal_option_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN renewal_option = TRUE THEN agreement_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements with a renewal option — indicates strategic partnership continuity planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_capacity_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner capacity and risk KPIs derived from capacity assessments — tracks organizational scores, risk ratings, and assessment coverage to guide capacity building investments and risk mitigation decisions."
  source: "`vibe_ngo_v1`.`partnership`.`capacity_assessment`"
  dimensions:
    - name: "capacity_assessment_type"
      expr: capacity_assessment_type
      comment: "Type of capacity assessment conducted (e.g., Full, Desk Review, Rapid) — used to segment assessment rigor and comparability."
    - name: "capacity_assessment_status"
      expr: capacity_assessment_status
      comment: "Current status of the assessment (e.g., Completed, In Progress, Pending) — used to track assessment pipeline."
    - name: "overall_risk_rating"
      expr: overall_risk_rating
      comment: "Overall risk rating assigned to the partner (e.g., Low, Medium, High) — primary risk segmentation dimension for portfolio risk management."
    - name: "financial_risk_rating"
      expr: financial_risk_rating
      comment: "Financial management risk rating — used to identify partners requiring enhanced financial oversight."
    - name: "payment_modality_recommendation"
      expr: payment_modality_recommendation
      comment: "Recommended payment modality based on assessment (e.g., Advance, Reimbursement) — informs financial control decisions."
    - name: "capacity_building_plan_required"
      expr: capacity_building_plan_required
      comment: "Indicates whether a capacity building plan is required — used to prioritize capacity development investments."
    - name: "enhanced_monitoring_required"
      expr: enhanced_monitoring_required
      comment: "Indicates whether enhanced monitoring is required — flags high-risk partners needing additional oversight resources."
    - name: "assessment_year"
      expr: YEAR(capacity_assessment_date)
      comment: "Year the capacity assessment was conducted — used for trend analysis of partner capacity improvement over time."
    - name: "methodology"
      expr: methodology
      comment: "Assessment methodology used — enables comparability analysis across different assessment approaches."
  measures:
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall capacity score across assessed partners — headline KPI for partner portfolio capacity health."
    - name: "avg_financial_mgmt_score"
      expr: AVG(CAST(financial_mgmt_score AS DOUBLE))
      comment: "Average financial management score — key indicator of partners' financial accountability and stewardship capability."
    - name: "avg_governance_score"
      expr: AVG(CAST(governance_score AS DOUBLE))
      comment: "Average governance score — measures organizational governance quality across the partner portfolio."
    - name: "avg_mel_score"
      expr: AVG(CAST(mel_score AS DOUBLE))
      comment: "Average monitoring, evaluation, and learning (MEL) score — tracks partners' data and accountability capability."
    - name: "avg_program_mgmt_score"
      expr: AVG(CAST(program_mgmt_score AS DOUBLE))
      comment: "Average program management score — assesses partners' ability to deliver programs effectively."
    - name: "high_risk_partner_count"
      expr: COUNT(CASE WHEN overall_risk_rating = 'High' THEN capacity_assessment_id END)
      comment: "Number of partners rated as high risk — critical risk management KPI that triggers enhanced oversight and mitigation actions."
    - name: "capacity_building_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN capacity_building_plan_required = TRUE THEN capacity_assessment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessed partners requiring a capacity building plan — informs capacity development investment prioritization."
    - name: "enhanced_monitoring_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN enhanced_monitoring_required = TRUE THEN capacity_assessment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners requiring enhanced monitoring — measures risk exposure requiring additional oversight resources."
    - name: "self_assessment_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN partner_self_assessment_completed = TRUE THEN capacity_assessment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments where the partner completed a self-assessment — measures partner engagement in accountability processes."
    - name: "avg_score_vs_max_ratio"
      expr: ROUND(100.0 * AVG(CAST(overall_score AS DOUBLE)) / NULLIF(AVG(CAST(score_scale_max AS DOUBLE)), 0), 2)
      comment: "Average overall score as a percentage of the maximum possible score — normalizes scores across different assessment tools for portfolio-wide benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_due_diligence_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance and risk KPIs for partner due diligence — tracks verification status, risk levels, and certification compliance to ensure regulatory adherence and safeguarding standards across the partner portfolio."
  source: "`vibe_ngo_v1`.`partnership`.`due_diligence_record`"
  dimensions:
    - name: "diligence_status"
      expr: diligence_status
      comment: "Current status of the due diligence process (e.g., Completed, Pending, In Review) — primary filter for compliance pipeline management."
    - name: "diligence_type"
      expr: diligence_type
      comment: "Type of due diligence conducted (e.g., Full, Enhanced, Simplified) — used to segment compliance rigor."
    - name: "risk_level"
      expr: risk_level
      comment: "Overall risk level assigned to the partner (e.g., Low, Medium, High, Critical) — primary risk segmentation for compliance dashboards."
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Final outcome of the due diligence review (e.g., Approved, Rejected, Conditional) — used to track approval rates and rejection reasons."
    - name: "aml_cft_check_status"
      expr: aml_cft_check_status
      comment: "Anti-money laundering and counter-financing of terrorism check status — critical compliance dimension for donor regulatory requirements."
    - name: "debarment_check_status"
      expr: debarment_check_status
      comment: "Status of debarment screening — flags partners excluded from receiving funds by major donors or governments."
    - name: "chs_certification_status"
      expr: chs_certification_status
      comment: "Core Humanitarian Standard certification status — tracks humanitarian accountability compliance."
    - name: "initiation_year"
      expr: YEAR(initiation_date)
      comment: "Year the due diligence process was initiated — used for cohort and throughput trend analysis."
    - name: "financial_audit_opinion"
      expr: financial_audit_opinion
      comment: "External audit opinion on partner financials (e.g., Unqualified, Qualified, Adverse) — key financial accountability indicator."
  measures:
    - name: "total_due_diligence_records"
      expr: COUNT(1)
      comment: "Total number of due diligence records — baseline volume metric for compliance pipeline tracking."
    - name: "approved_partner_count"
      expr: COUNT(CASE WHEN overall_outcome = 'Approved' THEN due_diligence_record_id END)
      comment: "Number of partners that passed due diligence and were approved — measures compliance throughput and partner onboarding capacity."
    - name: "approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_outcome = 'Approved' THEN due_diligence_record_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of due diligence reviews resulting in approval — key compliance quality and partner eligibility KPI."
    - name: "high_risk_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN due_diligence_record_id END)
      comment: "Number of partners assessed as high risk — triggers enhanced monitoring and escalation protocols."
    - name: "legal_registration_verified_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN legal_registration_verified = TRUE THEN due_diligence_record_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners with verified legal registration — measures foundational compliance coverage across the partner portfolio."
    - name: "safeguarding_policy_verified_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN safeguarding_policy_verified = TRUE THEN due_diligence_record_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners with a verified safeguarding policy — critical child and beneficiary protection compliance KPI."
    - name: "financial_audit_reviewed_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN financial_audit_reviewed = TRUE THEN due_diligence_record_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners whose financial audit has been reviewed — measures financial accountability verification coverage."
    - name: "anti_terrorism_certification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN anti_terrorism_certification = TRUE THEN due_diligence_record_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners with valid anti-terrorism certification — mandatory compliance metric for US government and major institutional donors."
    - name: "governance_verified_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN governance_verified = TRUE THEN due_diligence_record_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners with verified governance structures — measures organizational accountability compliance."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partner_org`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner organization portfolio KPIs — tracks partner capacity scores, financial scale, due diligence status, and CHS certification to inform strategic partner selection, investment, and risk management decisions."
  source: "`vibe_ngo_v1`.`partnership`.`partner_org`"
  dimensions:
    - name: "partner_org_type"
      expr: partner_org_type
      comment: "Type of partner organization (e.g., Local NGO, INGO, Government, UN Agency) — primary segmentation for localization and partnership strategy analysis."
    - name: "partnership_status"
      expr: partnership_status
      comment: "Current partnership engagement status (e.g., Active, Inactive, Prospective) — used to track active partner portfolio size."
    - name: "due_diligence_status"
      expr: due_diligence_status
      comment: "Current due diligence status of the partner organization — used to identify partners cleared for engagement."
    - name: "hq_country"
      expr: hq_country
      comment: "Country where the partner organization is headquartered — enables geographic portfolio analysis and localization tracking."
    - name: "chs_certified"
      expr: chs_certified
      comment: "Whether the partner holds Core Humanitarian Standard certification — key quality and accountability filter."
    - name: "sanctions_screened"
      expr: sanctions_screened
      comment: "Whether the partner has been screened against sanctions lists — compliance status dimension."
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Accreditation status of the partner organization — used to segment partners by quality assurance tier."
    - name: "thematic_focus_areas"
      expr: thematic_focus_areas
      comment: "Thematic areas the partner specializes in — used to match partner capabilities to program needs."
  measures:
    - name: "total_partner_orgs"
      expr: COUNT(1)
      comment: "Total number of partner organizations in the registry — baseline portfolio size metric for partnership strategy."
    - name: "active_partner_count"
      expr: COUNT(CASE WHEN partnership_status = 'Active' THEN partner_org_id END)
      comment: "Number of currently active partner organizations — core portfolio health KPI for executive reporting."
    - name: "chs_certified_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN chs_certified = TRUE THEN partner_org_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partner organizations holding CHS certification — measures humanitarian accountability standards adoption across the partner portfolio."
    - name: "sanctions_screened_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sanctions_screened = TRUE THEN partner_org_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners that have been screened against sanctions lists — critical compliance coverage KPI for donor requirements."
    - name: "avg_capacity_assessment_score"
      expr: AVG(CAST(capacity_assessment_score AS DOUBLE))
      comment: "Average capacity assessment score across all partner organizations — portfolio-level indicator of partner organizational capability."
    - name: "avg_annual_budget_usd"
      expr: AVG(CAST(annual_budget_usd AS DOUBLE))
      comment: "Average annual budget (USD) of partner organizations — benchmarks partner financial scale and informs appropriate funding level decisions."
    - name: "total_annual_budget_usd"
      expr: SUM(CAST(annual_budget_usd AS DOUBLE))
      comment: "Total combined annual budget of all partner organizations — measures aggregate financial capacity of the partner ecosystem."
    - name: "due_diligence_cleared_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN due_diligence_status = 'Cleared' THEN partner_org_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partner organizations cleared through due diligence — measures compliance readiness of the partner portfolio for engagement."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partner_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner performance KPIs derived from formal performance reviews — tracks programmatic quality, financial accountability, milestone achievement, and corrective action rates to steer partnership management and renewal decisions."
  source: "`vibe_ngo_v1`.`partnership`.`partner_performance_review`"
  dimensions:
    - name: "overall_performance_rating"
      expr: overall_performance_rating
      comment: "Overall performance rating assigned to the partner (e.g., Excellent, Satisfactory, Unsatisfactory) — primary KPI dimension for partner portfolio performance segmentation."
    - name: "partner_performance_review_type"
      expr: partner_performance_review_type
      comment: "Type of performance review (e.g., Mid-Term, Final, Annual) — used to segment review results by review stage."
    - name: "partner_performance_review_status"
      expr: partner_performance_review_status
      comment: "Current status of the review process (e.g., Completed, Draft, Pending Approval) — used to track review pipeline."
    - name: "financial_accountability_rating"
      expr: financial_accountability_rating
      comment: "Rating for partner financial accountability — key dimension for financial risk and compliance analysis."
    - name: "programmatic_quality_rating"
      expr: programmatic_quality_rating
      comment: "Rating for programmatic quality of delivery — used to assess program effectiveness by partner."
    - name: "safeguarding_compliance_rating"
      expr: safeguarding_compliance_rating
      comment: "Rating for partner safeguarding compliance — critical child protection and beneficiary safety dimension."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Indicates whether a corrective action plan was required — flags underperforming partners needing intervention."
    - name: "partnership_renewal_recommendation"
      expr: partnership_renewal_recommendation
      comment: "Recommendation on whether to renew the partnership — directly informs strategic partnership continuation decisions."
    - name: "review_year"
      expr: YEAR(partner_performance_review_date)
      comment: "Year the performance review was conducted — used for annual trend analysis of partner performance."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned during the performance review — used to prioritize oversight and support resources."
  measures:
    - name: "avg_overall_performance_score"
      expr: AVG(CAST(overall_performance_score AS DOUBLE))
      comment: "Average overall performance score across all reviewed partners — headline KPI for partner portfolio performance health."
    - name: "avg_milestone_achievement_rate"
      expr: AVG(CAST(milestone_achievement_rate AS DOUBLE))
      comment: "Average milestone achievement rate across partner reviews — measures programmatic delivery effectiveness against planned targets."
    - name: "avg_budget_utilisation_rate"
      expr: AVG(CAST(budget_utilisation_rate AS DOUBLE))
      comment: "Average budget utilisation rate across partner reviews — measures financial absorption capacity and spending efficiency."
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN partner_performance_review_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews resulting in a corrective action requirement — key risk indicator for partner portfolio quality management."
    - name: "field_visit_conducted_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN field_visit_conducted = TRUE THEN partner_performance_review_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews where a field visit was conducted — measures quality of oversight and direct verification of partner activities."
    - name: "beneficiary_feedback_incorporated_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN beneficiary_feedback_incorporated = TRUE THEN partner_performance_review_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews incorporating beneficiary feedback — measures accountability to affected populations, a core humanitarian principle."
    - name: "renewal_recommended_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN partnership_renewal_recommendation = 'Recommended' THEN partner_performance_review_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviewed partnerships recommended for renewal — strategic KPI for partnership continuation and portfolio planning."
    - name: "capacity_building_recommended_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN capacity_building_recommended = TRUE THEN partner_performance_review_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews recommending capacity building — informs capacity development investment prioritization across the partner portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partner_report_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner reporting compliance and quality KPIs — tracks submission timeliness, quality scores, expenditure reporting, and review cycle efficiency to manage donor obligations and partner accountability."
  source: "`vibe_ngo_v1`.`partnership`.`partner_report_submission`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of report submitted (e.g., Narrative, Financial, Combined) — used to segment reporting compliance by report category."
    - name: "review_status"
      expr: review_status
      comment: "Current review status of the submitted report (e.g., Approved, Under Review, Revision Required) — tracks review pipeline."
    - name: "is_late_submission"
      expr: is_late_submission
      comment: "Indicates whether the report was submitted after the due date — primary timeliness compliance dimension."
    - name: "report_period_frequency"
      expr: report_period_frequency
      comment: "Frequency of the reporting period (e.g., Monthly, Quarterly, Annual) — used to segment compliance by reporting cycle."
    - name: "cluster_sector"
      expr: cluster_sector
      comment: "Humanitarian cluster or sector the report covers — enables sector-level reporting compliance analysis."
    - name: "donor_reporting_obligation"
      expr: donor_reporting_obligation
      comment: "Indicates whether the report fulfills a donor reporting obligation — used to prioritize compliance tracking for donor-facing reports."
    - name: "mel_indicators_reported"
      expr: mel_indicators_reported
      comment: "Indicates whether MEL indicators were reported — tracks data and evidence quality in partner submissions."
    - name: "submission_year"
      expr: YEAR(partner_report_submission_date)
      comment: "Year the report was submitted — used for annual trend analysis of reporting compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the reported expenditure — relevant for multi-currency financial reporting analysis."
  measures:
    - name: "total_report_submissions"
      expr: COUNT(1)
      comment: "Total number of partner report submissions — baseline volume metric for reporting pipeline management."
    - name: "on_time_submission_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_late_submission = FALSE THEN partner_report_submission_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports submitted on time — primary reporting compliance KPI for donor accountability and partnership management."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score of submitted reports — measures the analytical and narrative quality of partner reporting."
    - name: "total_expenditure_reported"
      expr: SUM(CAST(total_expenditure_reported AS DOUBLE))
      comment: "Total expenditure reported by partners across all submissions — measures financial accountability and burn rate visibility."
    - name: "avg_expenditure_per_submission"
      expr: AVG(CAST(total_expenditure_reported AS DOUBLE))
      comment: "Average expenditure reported per submission — benchmarks typical financial reporting volume per partner report."
    - name: "approved_budget_utilization"
      expr: ROUND(100.0 * SUM(CAST(total_expenditure_reported AS DOUBLE)) / NULLIF(SUM(CAST(approved_budget_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of total reported expenditure to total approved budget — measures financial absorption and budget utilization at the reporting level."
    - name: "financial_documentation_attached_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN financial_documentation_attached = TRUE THEN partner_report_submission_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports with financial documentation attached — measures financial accountability compliance in partner reporting."
    - name: "mel_indicators_reported_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN mel_indicators_reported = TRUE THEN partner_report_submission_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports that include MEL indicator data — measures evidence and data quality compliance in partner reporting."
    - name: "donor_obligation_report_count"
      expr: COUNT(CASE WHEN donor_reporting_obligation = TRUE THEN partner_report_submission_id END)
      comment: "Number of reports fulfilling donor reporting obligations — tracks compliance with contractual donor reporting requirements."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_consortium`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consortium portfolio KPIs — tracks funding scale, localization percentages, member composition, and operational status to inform multi-partner collaboration strategy and Grand Bargain localization commitments."
  source: "`vibe_ngo_v1`.`partnership`.`consortium`"
  dimensions:
    - name: "consortium_type"
      expr: consortium_type
      comment: "Type of consortium arrangement (e.g., Implementing, Advocacy, Research) — used to segment consortium portfolio by purpose."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the consortium (e.g., Active, Closed, Forming) — primary filter for active portfolio analysis."
    - name: "ngo_role"
      expr: ngo_role
      comment: "Role of the NGO within the consortium (e.g., Lead, Member, Technical Advisor) — used to analyze leadership vs. participation patterns."
    - name: "grand_bargain_localization"
      expr: grand_bargain_localization
      comment: "Indicates whether the consortium is aligned with Grand Bargain localization commitments — tracks humanitarian localization agenda progress."
    - name: "ocha_cluster_alignment"
      expr: ocha_cluster_alignment
      comment: "OCHA humanitarian cluster the consortium is aligned with — enables cluster-level portfolio analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the consortium operations — used for regional portfolio analysis."
    - name: "funding_currency"
      expr: funding_currency
      comment: "Currency of consortium funding — relevant for multi-currency financial analysis."
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the consortium was established — used for cohort and portfolio vintage analysis."
  measures:
    - name: "total_consortium_funding"
      expr: SUM(CAST(total_funding_amount AS DOUBLE))
      comment: "Total funding mobilized across all consortia — measures the financial scale of multi-partner collaboration portfolio."
    - name: "avg_consortium_funding"
      expr: AVG(CAST(total_funding_amount AS DOUBLE))
      comment: "Average funding amount per consortium — benchmarks typical consortium financial scale for investment planning."
    - name: "avg_localization_percentage"
      expr: AVG(CAST(localization_percentage AS DOUBLE))
      comment: "Average localization percentage across consortia — headline KPI for Grand Bargain and localization agenda progress tracking."
    - name: "avg_ngo_funding_share"
      expr: AVG(CAST(ngo_funding_share AS DOUBLE))
      comment: "Average NGO funding share within consortia — measures the organization's financial stake and influence in multi-partner arrangements."
    - name: "active_consortium_count"
      expr: COUNT(CASE WHEN operational_status = 'Active' THEN consortium_id END)
      comment: "Number of currently active consortia — core portfolio health KPI for multi-partner collaboration strategy."
    - name: "grand_bargain_aligned_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN grand_bargain_localization = TRUE THEN consortium_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consortia aligned with Grand Bargain localization commitments — measures progress against humanitarian sector localization targets."
    - name: "total_funding_active_consortia"
      expr: SUM(CASE WHEN operational_status = 'Active' THEN CAST(total_funding_amount AS DOUBLE) ELSE 0 END)
      comment: "Total funding in active consortia — represents live multi-partner financial exposure and active collaboration investment."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_consortium_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consortium membership KPIs — tracks funding allocations, cost-sharing, indirect cost rates, and member performance ratings to optimize multi-partner resource distribution and accountability."
  source: "`vibe_ngo_v1`.`partnership`.`consortium_member`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current membership status of the consortium member (e.g., Active, Withdrawn, Suspended) — primary filter for active membership analysis."
    - name: "role"
      expr: role
      comment: "Role of the member within the consortium (e.g., Lead, Implementing Partner, Technical Advisor) — used to segment responsibilities and funding by role."
    - name: "contribution_type"
      expr: contribution_type
      comment: "Type of contribution the member provides (e.g., Financial, In-Kind, Technical) — used to analyze contribution mix across consortium members."
    - name: "performance_rating"
      expr: performance_rating
      comment: "Performance rating of the consortium member — used to identify high and low performers within multi-partner arrangements."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the consortium member — used to prioritize oversight and risk mitigation within the consortium."
    - name: "cost_share_required"
      expr: cost_share_required
      comment: "Indicates whether the member is required to provide cost-sharing — used to track co-financing commitments."
    - name: "voting_rights"
      expr: voting_rights
      comment: "Indicates whether the member has voting rights in consortium governance — used to analyze governance structure and power dynamics."
    - name: "funding_currency_code"
      expr: funding_currency_code
      comment: "Currency of the member's funding allocation — relevant for multi-currency financial analysis."
  measures:
    - name: "total_funding_allocation"
      expr: SUM(CAST(funding_allocation_amount AS DOUBLE))
      comment: "Total funding allocated across all consortium members — measures aggregate financial distribution within multi-partner arrangements."
    - name: "avg_funding_allocation"
      expr: AVG(CAST(funding_allocation_amount AS DOUBLE))
      comment: "Average funding allocation per consortium member — benchmarks typical member funding level for equitable distribution analysis."
    - name: "avg_funding_allocation_percentage"
      expr: AVG(CAST(funding_allocation_percentage AS DOUBLE))
      comment: "Average funding allocation percentage per member — measures proportional resource distribution across consortium members."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate across consortium members — used to monitor overhead burden and negotiate cost efficiency."
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost-sharing percentage across members — measures co-financing commitment levels within consortia."
    - name: "active_member_count"
      expr: COUNT(CASE WHEN membership_status = 'Active' THEN consortium_member_id END)
      comment: "Number of currently active consortium members — measures active multi-partner collaboration scale."
    - name: "cost_share_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cost_share_required = TRUE THEN consortium_member_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consortium members required to provide cost-sharing — tracks co-financing obligation coverage across the consortium portfolio."
$$;