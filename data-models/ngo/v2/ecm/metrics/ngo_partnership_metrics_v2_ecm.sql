-- Metric views for domain: partnership | Business: Ngo | Version: 2 | Generated on: 2026-07-03 05:04:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over partnership agreements — the primary contractual instrument between the NGO and implementing partners. Covers agreement portfolio value, disbursement efficiency, and outstanding cash-transfer exposure. Relevant to HACT assurance frameworks (UNICEF/UNDP) and eTools partnership management. Sensitive fields (signatory names) carry pii_staff classification per VREQ-055."
  source: "`vibe_ngo_v1`.`partnership`.`partnership_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: partnership_agreement_status
      comment: "Lifecycle status of the partnership agreement (e.g. Active, Closed, Suspended). Primary filter for portfolio health dashboards."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of agreement (e.g. Sub-Award, MOU, Grant Agreement). Drives compliance and reporting obligations."
    - name: "ip_transfer_modality"
      expr: ip_transfer_modality
      comment: "Implementing partner transfer modality (e.g. Direct Cash Transfer, Reimbursement). Key HACT dimension for assurance planning."
    - name: "hact_risk_rating"
      expr: hact_risk_rating
      comment: "HACT risk rating assigned to the partner for this agreement. Drives frequency of spot checks and programme visits."
    - name: "operational_country_code"
      expr: operational_country_code
      comment: "Country where the agreement is operationally implemented. Enables geographic portfolio analysis."
    - name: "program_sector"
      expr: program_sector
      comment: "Humanitarian/development sector (e.g. WASH, Nutrition, Protection). Enables sector-level portfolio analysis."
    - name: "is_consortium_agreement"
      expr: is_consortium_agreement
      comment: "Flags whether this is a consortium-level agreement. Consortium agreements carry additional governance complexity."
    - name: "is_sub_award"
      expr: is_sub_award
      comment: "Flags sub-award agreements, which require additional donor compliance tracking (e.g. 2 CFR 200 flow-down clauses)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the agreement. Required for multi-currency portfolio consolidation."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the agreement became effective. Enables cohort and vintage analysis of the partnership portfolio."
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total number of partnership agreements. Baseline portfolio size metric for executive dashboards and donor reporting."
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Sum of total budgeted amounts across all partnership agreements. Represents the full financial commitment of the partnership portfolio."
    - name: "total_disbursed_amount"
      expr: SUM(CAST(disbursed_amount AS DOUBLE))
      comment: "Total cash transferred to implementing partners. Measures financial execution pace against budget commitments."
    - name: "total_liquidated_amount"
      expr: SUM(CAST(liquidated_amount AS DOUBLE))
      comment: "Total amount liquidated (reported and accepted) by partners. Measures financial accountability and reporting compliance."
    - name: "total_outstanding_dct"
      expr: SUM(CAST(outstanding_dct_amount AS DOUBLE))
      comment: "Total outstanding Direct Cash Transfer (DCT) balance across all agreements. High outstanding DCT is a key HACT risk indicator requiring management attention."
    - name: "avg_budget_per_agreement"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average budget size per partnership agreement. Informs partner capacity planning and sub-award sizing decisions."
    - name: "disbursement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(disbursed_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total budget that has been disbursed to partners. A key financial execution KPI — low rates signal implementation delays; high rates with low liquidation signal DCT risk."
    - name: "liquidation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(liquidated_amount AS DOUBLE)) / NULLIF(SUM(CAST(disbursed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of disbursed funds that have been liquidated by partners. Low liquidation rates indicate reporting backlogs or potential financial irregularities."
    - name: "indirect_cost_rate_avg"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate (ICR/NICRA) across agreements. Informs overhead cost management and donor negotiation strategy."
    - name: "funding_ceiling_total"
      expr: SUM(CAST(funding_ceiling_amount AS DOUBLE))
      comment: "Total funding ceiling across all agreements. Represents the maximum authorized financial exposure of the partnership portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partner_org`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner organization portfolio KPIs — master registry of implementing partners. Covers financial scale, capacity, due diligence status, and sanctions compliance. Relevant to HACT macro/micro assessment frameworks and eTools partner management. PII fields (primary_contact_name, authorized_rep_name) carry pii_staff sensitivity per VREQ-055."
  source: "`vibe_ngo_v1`.`partnership`.`partner_org`"
  dimensions:
    - name: "org_type"
      expr: org_type
      comment: "Type of partner organization (e.g. NNGO, INGO, UN Agency, Government). Fundamental segmentation for partnership strategy."
    - name: "partnership_status"
      expr: partnership_status
      comment: "Current partnership status (e.g. Active, Inactive, Suspended). Primary filter for active portfolio management."
    - name: "hact_risk_rating"
      expr: hact_risk_rating
      comment: "HACT risk rating of the partner organization. Drives assurance activity planning (spot checks, audits, programme visits)."
    - name: "due_diligence_status"
      expr: due_diligence_status
      comment: "Current due diligence status. Partners with expired or failed due diligence cannot receive new funding."
    - name: "chs_certified"
      expr: chs_certified
      comment: "Whether the partner holds Core Humanitarian Standard (CHS) certification. Key quality indicator for humanitarian partnerships."
    - name: "sanctions_screened"
      expr: sanctions_screened
      comment: "Whether the partner has been screened against sanctions lists (OFAC, UN, EU). Mandatory compliance gate for all partnerships."
    - name: "hq_country"
      expr: hq_country
      comment: "Country of the partner headquarters. Enables geographic analysis of the partner portfolio and localization tracking."
    - name: "ip_transfer_modality"
      expr: ip_transfer_modality
      comment: "Preferred cash transfer modality for this partner. Informs HACT assurance planning and financial risk management."
  measures:
    - name: "total_partners"
      expr: COUNT(1)
      comment: "Total number of partner organizations in the registry. Baseline portfolio size for partnership strategy reviews."
    - name: "active_partners"
      expr: COUNT(CASE WHEN partnership_status = 'Active' THEN 1 END)
      comment: "Number of currently active partner organizations. Core operational portfolio metric for resource planning."
    - name: "chs_certified_partners"
      expr: COUNT(CASE WHEN chs_certified = TRUE THEN 1 END)
      comment: "Number of partners with Core Humanitarian Standard certification. Measures quality standards adoption across the partner portfolio."
    - name: "chs_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN chs_certified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners holding CHS certification. A strategic localization and quality KPI tracked by Grand Bargain commitments."
    - name: "sanctions_screened_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sanctions_screened = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners with current sanctions screening. A mandatory compliance KPI — any gap exposes the organization to donor audit findings."
    - name: "due_diligence_compliant_partners"
      expr: COUNT(CASE WHEN due_diligence_status = 'Completed' THEN 1 END)
      comment: "Number of partners with completed due diligence. Partners without completed due diligence cannot receive new sub-awards."
    - name: "avg_capacity_assessment_score"
      expr: AVG(CAST(capacity_assessment_score AS DOUBLE))
      comment: "Average capacity assessment score across all partners. Tracks overall partner capacity health and informs capacity building investment decisions."
    - name: "total_annual_budget_usd"
      expr: SUM(CAST(annual_budget_usd AS DOUBLE))
      comment: "Sum of annual budgets across all partner organizations. Indicates the total financial scale of the partner ecosystem."
    - name: "avg_annual_budget_usd"
      expr: AVG(CAST(annual_budget_usd AS DOUBLE))
      comment: "Average annual budget of partner organizations. Informs partner tiering and capacity-appropriate sub-award sizing."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_capacity_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner capacity assessment KPIs — measures organizational capacity across financial management, governance, HR, procurement, MEL, and IT systems. Used to determine sub-award eligibility, payment modality, and capacity building investment. Aligned with HACT micro-assessment methodology and eTools capacity assessment module. Lead assessor name carries pii_staff sensitivity per VREQ-055."
  source: "`vibe_ngo_v1`.`partnership`.`capacity_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of capacity assessment (e.g. HACT Micro-Assessment, Organizational Capacity Assessment). Determines methodology and scoring framework."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (e.g. Completed, In Progress, Overdue). Tracks assessment pipeline health."
    - name: "overall_risk_rating"
      expr: overall_risk_rating
      comment: "Overall risk rating derived from the assessment (e.g. Low, Medium, High, Significant). Primary risk segmentation dimension."
    - name: "financial_risk_rating"
      expr: financial_risk_rating
      comment: "Financial management risk rating. Drives HACT assurance activity frequency and payment modality decisions."
    - name: "assessment_location_country"
      expr: assessment_location_country
      comment: "Country where the assessment was conducted. Enables geographic analysis of partner capacity levels."
    - name: "capacity_building_plan_required"
      expr: capacity_building_plan_required
      comment: "Whether a capacity building plan is required based on assessment findings. Drives capacity building resource allocation."
    - name: "enhanced_monitoring_required"
      expr: enhanced_monitoring_required
      comment: "Whether enhanced monitoring is required. Triggers additional assurance activities and resource allocation."
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year the assessment was conducted. Enables trend analysis of partner capacity over time."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of capacity assessments conducted. Baseline metric for assurance activity tracking."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall capacity score across all assessments. Tracks aggregate partner capacity health across the portfolio."
    - name: "avg_financial_mgmt_score"
      expr: AVG(CAST(financial_mgmt_score AS DOUBLE))
      comment: "Average financial management score. The most critical capacity domain for sub-award risk management and HACT compliance."
    - name: "avg_governance_score"
      expr: AVG(CAST(governance_score AS DOUBLE))
      comment: "Average governance score across assessments. Governance weakness is a leading indicator of fiduciary risk."
    - name: "avg_mel_score"
      expr: AVG(CAST(mel_score AS DOUBLE))
      comment: "Average MEL (Monitoring, Evaluation, Learning) score. Indicates partner ability to report on program results and donor KPIs."
    - name: "avg_procurement_score"
      expr: AVG(CAST(procurement_score AS DOUBLE))
      comment: "Average procurement score. Procurement weaknesses are a primary source of audit findings and questioned costs."
    - name: "high_risk_assessments"
      expr: COUNT(CASE WHEN overall_risk_rating IN ('High', 'Significant') THEN 1 END)
      comment: "Number of assessments resulting in High or Significant risk ratings. Drives enhanced monitoring and capacity building prioritization."
    - name: "high_risk_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_risk_rating IN ('High', 'Significant') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments resulting in high or significant risk. A portfolio-level risk KPI for executive and donor reporting."
    - name: "capacity_building_plan_required_count"
      expr: COUNT(CASE WHEN capacity_building_plan_required = TRUE THEN 1 END)
      comment: "Number of partners requiring a capacity building plan. Drives capacity building budget and resource planning."
    - name: "avg_partner_self_assessment_score"
      expr: AVG(CAST(partner_self_assessment_score AS DOUBLE))
      comment: "Average partner self-assessment score. Comparing self-assessment vs. external assessment scores reveals partner self-awareness and transparency."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_capacity_building_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity building plan KPIs — tracks investment in partner organizational development. Measures budget utilization, progress toward capacity targets, and alignment with Grand Bargain localization commitments. Relevant to INGO localization strategies and donor reporting on partner strengthening."
  source: "`vibe_ngo_v1`.`partnership`.`capacity_building_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the capacity building plan (e.g. Active, Completed, On Hold). Primary filter for active plan management."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of capacity building plan (e.g. Organizational, Technical, Financial). Enables thematic analysis of capacity investments."
    - name: "overall_progress_status"
      expr: overall_progress_status
      comment: "Overall implementation progress status. Tracks whether plans are on track, delayed, or completed."
    - name: "country_code"
      expr: country_code
      comment: "Country where the capacity building plan is implemented. Enables geographic analysis of capacity investments."
    - name: "localization_strategy_aligned"
      expr: localization_strategy_aligned
      comment: "Whether the plan is aligned with the organization's localization strategy. Tracks Grand Bargain commitment implementation."
    - name: "safeguarding_component_included"
      expr: safeguarding_component_included
      comment: "Whether the plan includes a safeguarding component. Mandatory for organizations with PSEA commitments."
    - name: "gender_mainstreaming_included"
      expr: gender_mainstreaming_included
      comment: "Whether gender mainstreaming is included in the plan. Tracks gender equality commitments in partner development."
    - name: "plan_start_year"
      expr: YEAR(start_date)
      comment: "Year the capacity building plan started. Enables cohort analysis of capacity building investments."
  measures:
    - name: "total_plans"
      expr: COUNT(1)
      comment: "Total number of capacity building plans. Baseline metric for capacity building portfolio management."
    - name: "total_budget_usd"
      expr: SUM(CAST(total_budget_usd AS DOUBLE))
      comment: "Total budget allocated to capacity building plans. Measures the organization's financial investment in partner strengthening."
    - name: "total_expenditure_to_date_usd"
      expr: SUM(CAST(expenditure_to_date_usd AS DOUBLE))
      comment: "Total expenditure to date across all capacity building plans. Tracks financial execution of capacity building investments."
    - name: "budget_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(expenditure_to_date_usd AS DOUBLE)) / NULLIF(SUM(CAST(total_budget_usd AS DOUBLE)), 0), 2)
      comment: "Percentage of capacity building budget utilized. Low utilization indicates implementation delays; high utilization with low progress indicates cost overruns."
    - name: "avg_baseline_capacity_score"
      expr: AVG(CAST(baseline_capacity_score AS DOUBLE))
      comment: "Average baseline capacity score at plan inception. Establishes the starting point for measuring capacity improvement."
    - name: "avg_current_capacity_score"
      expr: AVG(CAST(current_capacity_score AS DOUBLE))
      comment: "Average current capacity score. Tracks real-time capacity improvement across the partner portfolio."
    - name: "avg_target_capacity_score"
      expr: AVG(CAST(target_capacity_score AS DOUBLE))
      comment: "Average target capacity score. Benchmarks ambition level of capacity building investments."
    - name: "capacity_improvement_avg"
      expr: AVG(CAST(current_capacity_score AS DOUBLE) - CAST(baseline_capacity_score AS DOUBLE))
      comment: "Average capacity score improvement (current minus baseline). The primary outcome KPI for capacity building investment effectiveness."
    - name: "localization_aligned_plans"
      expr: COUNT(CASE WHEN localization_strategy_aligned = TRUE THEN 1 END)
      comment: "Number of plans aligned with localization strategy. Tracks Grand Bargain commitment implementation progress."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_capacity_building_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity building activity KPIs — measures delivery effectiveness of individual training and organizational development activities. Tracks cost efficiency, participant satisfaction, and pre/post assessment score improvements. Facilitator name carries pii_staff sensitivity per VREQ-055."
  source: "`vibe_ngo_v1`.`partnership`.`capacity_building_activity`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of capacity building activity (e.g. Training, Coaching, Mentoring, Workshop). Enables analysis by delivery modality."
    - name: "activity_status"
      expr: activity_status
      comment: "Current status of the activity (e.g. Planned, Completed, Cancelled). Tracks delivery pipeline."
    - name: "delivery_mode"
      expr: delivery_mode
      comment: "Delivery mode (e.g. In-Person, Virtual, Blended). Enables cost and effectiveness comparison across modalities."
    - name: "capacity_domain"
      expr: capacity_domain
      comment: "Organizational capacity domain addressed (e.g. Financial Management, Procurement, MEL). Enables thematic analysis of capacity investments."
    - name: "country_code"
      expr: country_code
      comment: "Country where the activity was delivered. Enables geographic analysis of capacity building reach."
    - name: "is_certified"
      expr: is_certified
      comment: "Whether the activity results in a certification. Certified activities carry higher value for partner accreditation."
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Whether follow-up is required after the activity. Tracks post-activity support obligations."
    - name: "activity_year"
      expr: YEAR(start_date)
      comment: "Year the activity was delivered. Enables trend analysis of capacity building delivery over time."
  measures:
    - name: "total_activities"
      expr: COUNT(1)
      comment: "Total number of capacity building activities. Baseline delivery volume metric."
    - name: "total_activity_cost_usd"
      expr: SUM(CAST(activity_cost_usd AS DOUBLE))
      comment: "Total cost of all capacity building activities. Measures financial investment in partner capacity development."
    - name: "avg_activity_cost_usd"
      expr: AVG(CAST(activity_cost_usd AS DOUBLE))
      comment: "Average cost per capacity building activity. Enables cost benchmarking and efficiency analysis across delivery modalities."
    - name: "avg_completion_rate_pct"
      expr: AVG(CAST(completion_rate_pct AS DOUBLE))
      comment: "Average activity completion rate. Low completion rates indicate engagement or logistics challenges."
    - name: "avg_participant_satisfaction_score"
      expr: AVG(CAST(participant_satisfaction_score AS DOUBLE))
      comment: "Average participant satisfaction score. Key quality indicator for capacity building delivery effectiveness."
    - name: "avg_pre_assessment_score"
      expr: AVG(CAST(pre_assessment_score AS DOUBLE))
      comment: "Average pre-activity assessment score. Establishes baseline knowledge/skill level before intervention."
    - name: "avg_post_assessment_score"
      expr: AVG(CAST(post_assessment_score AS DOUBLE))
      comment: "Average post-activity assessment score. Measures knowledge/skill acquisition from the activity."
    - name: "avg_score_improvement"
      expr: AVG(CAST(post_assessment_score AS DOUBLE) - CAST(pre_assessment_score AS DOUBLE))
      comment: "Average improvement in assessment score (post minus pre). The primary learning effectiveness KPI — directly measures knowledge transfer."
    - name: "total_duration_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total hours of capacity building delivered. Measures the volume of learning investment across the partner portfolio."
    - name: "avg_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average duration per activity in hours. Informs activity design and scheduling decisions."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_due_diligence_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Due diligence KPIs — tracks partner vetting and compliance verification status. Covers sanctions screening, CHS certification, financial audit review, and legal registration. Critical for donor compliance (USAID, ECHO, UN agencies) and anti-terrorism financing requirements. Reviewer notes carry pii_staff sensitivity per VREQ-055."
  source: "`vibe_ngo_v1`.`partnership`.`due_diligence_record`"
  dimensions:
    - name: "diligence_type"
      expr: diligence_type
      comment: "Type of due diligence conducted (e.g. Initial, Renewal, Enhanced). Determines scope and depth of vetting."
    - name: "diligence_status"
      expr: diligence_status
      comment: "Current status of the due diligence process (e.g. Completed, In Progress, Expired). Primary compliance gate status."
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Overall due diligence outcome (e.g. Approved, Approved with Conditions, Rejected). Determines partnership eligibility."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned based on due diligence findings (e.g. Low, Medium, High). Drives monitoring intensity."
    - name: "chs_certification_status"
      expr: chs_certification_status
      comment: "CHS certification status of the partner. Key quality gate for humanitarian partnerships."
    - name: "debarment_check_status"
      expr: debarment_check_status
      comment: "Status of debarment check against government and donor exclusion lists. Mandatory compliance requirement."
    - name: "aml_cft_check_status"
      expr: aml_cft_check_status
      comment: "Anti-Money Laundering / Counter-Financing of Terrorism check status. Required by most institutional donors."
    - name: "ngo_registration_country"
      expr: ngo_registration_country
      comment: "Country of NGO legal registration. Enables geographic analysis of partner legal compliance."
  measures:
    - name: "total_due_diligence_records"
      expr: COUNT(1)
      comment: "Total number of due diligence records. Baseline metric for compliance pipeline management."
    - name: "completed_due_diligence"
      expr: COUNT(CASE WHEN diligence_status = 'Completed' THEN 1 END)
      comment: "Number of completed due diligence records. Partners without completed due diligence cannot receive new funding."
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN diligence_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of due diligence records completed. A critical compliance KPI — gaps expose the organization to donor audit findings."
    - name: "anti_terrorism_certified_count"
      expr: COUNT(CASE WHEN anti_terrorism_certification = TRUE THEN 1 END)
      comment: "Number of partners with valid anti-terrorism certification. Mandatory for US government-funded programs (USAID, State Dept)."
    - name: "financial_audit_reviewed_count"
      expr: COUNT(CASE WHEN financial_audit_reviewed = TRUE THEN 1 END)
      comment: "Number of partners whose financial audit has been reviewed. Financial audit review is a core fiduciary risk management activity."
    - name: "safeguarding_policy_verified_count"
      expr: COUNT(CASE WHEN safeguarding_policy_verified = TRUE THEN 1 END)
      comment: "Number of partners with verified safeguarding policies. Required by most institutional donors and CHS standards."
    - name: "safeguarding_verification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN safeguarding_policy_verified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners with verified safeguarding policies. A key PSEA compliance KPI for donor reporting."
    - name: "high_risk_partners"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Number of partners assessed as high risk through due diligence. Drives enhanced monitoring and management attention."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partner_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner performance review KPIs — measures programmatic quality, financial accountability, reporting compliance, and safeguarding adherence across implementing partners. Used for partnership renewal decisions, capacity building prioritization, and donor reporting. Aligned with HACT assurance and eTools partner performance management."
  source: "`vibe_ngo_v1`.`partnership`.`partner_performance_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of performance review (e.g. Annual, Mid-Term, Final). Determines scope and reporting obligations."
    - name: "review_status"
      expr: review_status
      comment: "Current status of the review (e.g. Completed, In Progress, Overdue). Tracks review pipeline health."
    - name: "overall_performance_rating"
      expr: overall_performance_rating
      comment: "Overall performance rating (e.g. Excellent, Satisfactory, Unsatisfactory). Primary KPI for partnership renewal decisions."
    - name: "financial_accountability_rating"
      expr: financial_accountability_rating
      comment: "Financial accountability rating. Drives HACT assurance planning and payment modality decisions."
    - name: "safeguarding_compliance_rating"
      expr: safeguarding_compliance_rating
      comment: "Safeguarding compliance rating. Non-compliance triggers mandatory escalation and potential partnership suspension."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether a corrective action plan is required. Flags partners needing intensive management support."
    - name: "capacity_building_recommended"
      expr: capacity_building_recommended
      comment: "Whether capacity building is recommended based on review findings. Drives capacity building resource allocation."
    - name: "review_year"
      expr: YEAR(review_date)
      comment: "Year the review was conducted. Enables trend analysis of partner performance over time."
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of partner performance reviews. Baseline metric for assurance activity tracking."
    - name: "avg_overall_performance_score"
      expr: AVG(CAST(overall_performance_score AS DOUBLE))
      comment: "Average overall performance score across all reviews. Portfolio-level partner performance KPI for executive reporting."
    - name: "avg_budget_utilisation_rate"
      expr: AVG(CAST(budget_utilisation_rate AS DOUBLE))
      comment: "Average budget utilization rate across partner reviews. Low utilization indicates implementation challenges; very high rates may indicate poor planning."
    - name: "avg_milestone_achievement_rate"
      expr: AVG(CAST(milestone_achievement_rate AS DOUBLE))
      comment: "Average milestone achievement rate. Measures programmatic delivery performance against agreed implementation plans."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of reviews requiring corrective action plans. High counts signal systemic partner performance issues requiring management intervention."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews resulting in corrective action requirements. A portfolio risk KPI — high rates indicate systemic partner quality issues."
    - name: "beneficiary_feedback_incorporated_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN beneficiary_feedback_incorporated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews incorporating beneficiary feedback. Measures accountability to affected populations — a CHS and Grand Bargain commitment."
    - name: "field_visit_conducted_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN field_visit_conducted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews that included a field visit. Field visits provide higher-quality evidence than desk reviews alone."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partner_report_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner report submission KPIs — tracks timeliness, quality, and completeness of partner narrative and financial reporting. Late or poor-quality reports are a leading indicator of implementation problems and create donor compliance risk. Relevant to eTools reporting module and HACT assurance frameworks."
  source: "`vibe_ngo_v1`.`partnership`.`partner_report_submission`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of report (e.g. Narrative, Financial, Combined). Different report types have different compliance implications."
    - name: "review_status"
      expr: review_status
      comment: "Current review status of the submission (e.g. Accepted, Under Review, Revision Required). Tracks report processing pipeline."
    - name: "is_late_submission"
      expr: is_late_submission
      comment: "Whether the report was submitted after the due date. Late submissions are a key compliance risk indicator."
    - name: "donor_reporting_obligation"
      expr: donor_reporting_obligation
      comment: "Whether this report fulfills a donor reporting obligation. Donor reports carry higher compliance stakes than internal reports."
    - name: "mel_indicators_reported"
      expr: mel_indicators_reported
      comment: "Whether MEL indicators were reported. Missing indicator data creates gaps in program performance evidence."
    - name: "financial_documentation_attached"
      expr: financial_documentation_attached
      comment: "Whether financial documentation was attached. Missing financial documentation is a common audit finding."
    - name: "report_period_frequency"
      expr: report_period_frequency
      comment: "Reporting frequency (e.g. Monthly, Quarterly, Annual). Enables analysis by reporting cycle."
    - name: "country_code"
      expr: country_code
      comment: "Country of the reporting partner. Enables geographic analysis of reporting compliance."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of partner report submissions. Baseline reporting volume metric."
    - name: "late_submissions"
      expr: COUNT(CASE WHEN is_late_submission = TRUE THEN 1 END)
      comment: "Number of late report submissions. Late submissions create donor compliance risk and signal implementation challenges."
    - name: "on_time_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_late_submission = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports submitted on time. A key partner accountability KPI tracked in HACT assurance and donor reporting."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average report quality score. Low quality scores indicate partner reporting capacity gaps requiring targeted support."
    - name: "total_expenditure_reported"
      expr: SUM(CAST(total_expenditure_reported AS DOUBLE))
      comment: "Total expenditure reported across all partner submissions. Tracks financial accountability and liquidation progress."
    - name: "avg_approved_budget_amount"
      expr: AVG(CAST(approved_budget_amount AS DOUBLE))
      comment: "Average approved budget amount per reporting period. Provides context for expenditure analysis."
    - name: "mel_reporting_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mel_indicators_reported = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports including MEL indicator data. Missing indicator data creates gaps in program performance evidence for donor reporting."
    - name: "financial_documentation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN financial_documentation_attached = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports with financial documentation attached. Missing documentation is a primary source of audit findings and questioned costs."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_field_monitoring_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field monitoring visit KPIs — measures quality and outcomes of partner field monitoring activities. Tracks findings severity, corrective action requirements, and compliance ratings. Aligned with HACT assurance planning (programme visits, spot checks) and eTools field monitoring module. Partner rep name carries pii_staff sensitivity per VREQ-055."
  source: "`vibe_ngo_v1`.`partnership`.`field_monitoring_visit`"
  dimensions:
    - name: "visit_type"
      expr: visit_type
      comment: "Type of monitoring visit (e.g. Programme Visit, Spot Check, Joint Visit). Determines scope and HACT assurance category."
    - name: "visit_status"
      expr: visit_status
      comment: "Current status of the visit (e.g. Completed, Planned, Overdue). Tracks assurance activity pipeline."
    - name: "overall_compliance_rating"
      expr: overall_compliance_rating
      comment: "Overall compliance rating from the visit (e.g. Satisfactory, Partially Satisfactory, Unsatisfactory). Primary outcome KPI."
    - name: "hact_assurance_category"
      expr: hact_assurance_category
      comment: "HACT assurance category of the visit. Determines how the visit contributes to the annual HACT assurance plan."
    - name: "corrective_action_plan_required"
      expr: corrective_action_plan_required
      comment: "Whether a corrective action plan is required based on findings. Flags partners needing follow-up management."
    - name: "donor_notification_required"
      expr: donor_notification_required
      comment: "Whether the donor must be notified of findings. Donor notification triggers formal compliance reporting obligations."
    - name: "site_country_code"
      expr: site_country_code
      comment: "Country where the monitoring visit was conducted. Enables geographic analysis of assurance activities."
    - name: "program_sector"
      expr: program_sector
      comment: "Program sector monitored during the visit. Enables sector-level compliance analysis."
  measures:
    - name: "total_visits"
      expr: COUNT(1)
      comment: "Total number of field monitoring visits conducted. Baseline assurance activity volume metric."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_plan_required = TRUE THEN 1 END)
      comment: "Number of visits resulting in corrective action plan requirements. High counts signal systemic partner compliance issues."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_plan_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits requiring corrective action plans. A portfolio compliance risk KPI for executive and donor reporting."
    - name: "donor_notification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN donor_notification_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits requiring donor notification. High rates indicate serious compliance issues with donor reporting implications."
    - name: "avg_site_latitude"
      expr: AVG(CAST(site_latitude AS DOUBLE))
      comment: "Average latitude of monitored sites. Supports geographic clustering analysis of monitoring coverage."
    - name: "follow_up_visit_required_count"
      expr: COUNT(CASE WHEN follow_up_visit_required = TRUE THEN 1 END)
      comment: "Number of visits requiring follow-up visits. Tracks the pipeline of outstanding assurance obligations."
    - name: "assets_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN assets_verified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits where assets were verified. Asset verification is a key fiduciary control in HACT assurance."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_consortium`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consortium KPIs — measures the scale, composition, and financial structure of multi-partner consortia. Tracks localization progress, funding allocation, and governance compliance. Relevant to Grand Bargain localization commitments, OCHA cluster coordination, and IATI transparency reporting."
  source: "`vibe_ngo_v1`.`partnership`.`consortium`"
  dimensions:
    - name: "consortium_type"
      expr: consortium_type
      comment: "Type of consortium (e.g. Humanitarian Response, Development, Research). Determines governance and reporting requirements."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the consortium (e.g. Active, Closed, Forming). Primary filter for active portfolio management."
    - name: "ngo_role"
      expr: ngo_role
      comment: "Role of the NGO within the consortium (e.g. Lead, Member, Technical Advisor). Determines governance responsibilities."
    - name: "country_code"
      expr: country_code
      comment: "Country of consortium operations. Enables geographic analysis of consortium portfolio."
    - name: "ocha_cluster_alignment"
      expr: ocha_cluster_alignment
      comment: "OCHA humanitarian cluster alignment. Tracks coordination with the UN-led cluster system."
    - name: "grand_bargain_localization"
      expr: grand_bargain_localization
      comment: "Whether the consortium is aligned with Grand Bargain localization commitments. Tracks progress on the 25% localization target."
    - name: "due_diligence_status"
      expr: due_diligence_status
      comment: "Due diligence status of the consortium. Consortia with incomplete due diligence cannot receive new funding."
    - name: "consortium_start_year"
      expr: YEAR(start_date)
      comment: "Year the consortium was established. Enables cohort analysis of consortium portfolio."
  measures:
    - name: "total_consortia"
      expr: COUNT(1)
      comment: "Total number of consortia. Baseline portfolio size metric for partnership strategy reviews."
    - name: "total_funding_amount"
      expr: SUM(CAST(total_funding_amount AS DOUBLE))
      comment: "Total funding amount across all consortia. Measures the financial scale of the consortium portfolio."
    - name: "avg_funding_per_consortium"
      expr: AVG(CAST(total_funding_amount AS DOUBLE))
      comment: "Average funding amount per consortium. Informs consortium sizing and resource allocation decisions."
    - name: "avg_localization_percentage"
      expr: AVG(CAST(localization_percentage AS DOUBLE))
      comment: "Average localization percentage across consortia. Tracks progress toward Grand Bargain 25% localization commitment — a strategic KPI for INGO accountability."
    - name: "avg_ngo_funding_share"
      expr: AVG(CAST(ngo_funding_share AS DOUBLE))
      comment: "Average NGO funding share within consortia. Measures the organization's financial contribution relative to consortium partners."
    - name: "grand_bargain_aligned_count"
      expr: COUNT(CASE WHEN grand_bargain_localization = TRUE THEN 1 END)
      comment: "Number of consortia aligned with Grand Bargain localization commitments. Tracks implementation of the organization's localization strategy."
    - name: "grand_bargain_alignment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN grand_bargain_localization = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consortia aligned with Grand Bargain localization. A strategic accountability KPI for board and donor reporting."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_consortium_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consortium member KPIs — measures funding allocation, cost-sharing, and performance across consortium member organizations. Tracks financial contributions, capacity assessment scores, and governance participation. Signing authority name carries pii_staff sensitivity per VREQ-055."
  source: "`vibe_ngo_v1`.`partnership`.`consortium_member`"
  dimensions:
    - name: "member_role"
      expr: member_role
      comment: "Role of the member within the consortium (e.g. Lead, Co-Implementer, Technical Partner). Determines governance rights and responsibilities."
    - name: "membership_status"
      expr: membership_status
      comment: "Current membership status (e.g. Active, Suspended, Withdrawn). Primary filter for active member management."
    - name: "sub_award_type"
      expr: sub_award_type
      comment: "Type of sub-award instrument used for the member (e.g. Grant, Contract, MOU). Determines compliance and reporting requirements."
    - name: "due_diligence_status"
      expr: due_diligence_status
      comment: "Due diligence status of the consortium member. Members with incomplete due diligence cannot receive funding allocations."
    - name: "cost_share_required"
      expr: cost_share_required
      comment: "Whether cost-sharing is required from this member. Cost-share requirements affect member financial planning."
    - name: "voting_rights"
      expr: voting_rights
      comment: "Whether the member has voting rights in consortium governance. Tracks governance structure and decision-making power distribution."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the consortium member. Drives monitoring intensity and capacity building prioritization."
  measures:
    - name: "total_members"
      expr: COUNT(1)
      comment: "Total number of consortium member records. Baseline metric for consortium composition analysis."
    - name: "total_funding_allocation"
      expr: SUM(CAST(funding_allocation_amount AS DOUBLE))
      comment: "Total funding allocated across all consortium members. Measures the financial distribution of consortium resources."
    - name: "avg_funding_allocation"
      expr: AVG(CAST(funding_allocation_amount AS DOUBLE))
      comment: "Average funding allocation per consortium member. Informs equitable resource distribution analysis."
    - name: "avg_funding_allocation_percentage"
      expr: AVG(CAST(funding_allocation_percentage AS DOUBLE))
      comment: "Average funding allocation percentage per member. Tracks concentration risk — high concentration in one member increases fiduciary risk."
    - name: "avg_capacity_assessment_score"
      expr: AVG(CAST(capacity_assessment_score AS DOUBLE))
      comment: "Average capacity assessment score across consortium members. Tracks aggregate capacity health of the consortium."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate across consortium members. Informs overhead cost management and donor negotiation."
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost-share percentage across members with cost-share requirements. Tracks cost-share commitment fulfillment."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_mou_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MOU obligation KPIs — tracks compliance with specific obligations defined in Memoranda of Understanding and partnership agreements. Measures achievement rates, financial values, and overdue obligations. Critical for donor reporting and partnership accountability. Responsible focal point name carries pii_staff sensitivity per VREQ-055."
  source: "`vibe_ngo_v1`.`partnership`.`mou_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of obligation (e.g. Reporting, Financial, Programmatic, Safeguarding). Enables analysis by obligation category."
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the obligation (e.g. Completed, Overdue, In Progress). Primary compliance tracking dimension."
    - name: "is_critical_obligation"
      expr: is_critical_obligation
      comment: "Whether this is a critical obligation. Critical obligations require escalation if overdue."
    - name: "is_donor_reportable"
      expr: is_donor_reportable
      comment: "Whether this obligation must be reported to the donor. Donor-reportable obligations carry higher compliance stakes."
    - name: "escalation_status"
      expr: escalation_status
      comment: "Current escalation status of overdue obligations. Tracks management response to compliance gaps."
    - name: "operational_country_code"
      expr: operational_country_code
      comment: "Country where the obligation applies. Enables geographic analysis of compliance performance."
    - name: "program_sector"
      expr: program_sector
      comment: "Program sector of the obligation. Enables sector-level compliance analysis."
    - name: "recurrence_frequency"
      expr: recurrence_frequency
      comment: "Frequency of recurring obligations (e.g. Monthly, Quarterly). Informs compliance calendar management."
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of MOU obligations. Baseline compliance portfolio metric."
    - name: "total_financial_value"
      expr: SUM(CAST(financial_value_amount AS DOUBLE))
      comment: "Total financial value of all MOU obligations. Measures the financial stakes of the obligation portfolio."
    - name: "total_achieved_value"
      expr: SUM(CAST(achieved_value AS DOUBLE))
      comment: "Total achieved value across all obligations. Measures financial delivery against obligation commitments."
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Total target value across all obligations. Establishes the aggregate performance target for the obligation portfolio."
    - name: "achievement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(achieved_value AS DOUBLE)) / NULLIF(SUM(CAST(target_value AS DOUBLE)), 0), 2)
      comment: "Percentage of target value achieved across all obligations. The primary obligation performance KPI for donor and management reporting."
    - name: "critical_obligations_overdue"
      expr: COUNT(CASE WHEN is_critical_obligation = TRUE AND obligation_status = 'Overdue' THEN 1 END)
      comment: "Number of critical obligations that are overdue. Critical overdue obligations require immediate management escalation."
    - name: "donor_reportable_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_donor_reportable = TRUE AND obligation_status = 'Completed' THEN 1 END) / NULLIF(COUNT(CASE WHEN is_donor_reportable = TRUE THEN 1 END), 0), 2)
      comment: "Completion rate for donor-reportable obligations. Directly impacts donor compliance ratings and future funding decisions."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partner_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner risk register KPIs — tracks financial exposure, risk materialization, and mitigation effectiveness across the partner risk portfolio. Covers fiduciary, safeguarding, and operational risks. Critical for donor compliance and organizational risk management. Risk owner field carries pii_staff sensitivity per VREQ-055."
  source: "`vibe_ngo_v1`.`partnership`.`partner_risk_register`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Category of risk (e.g. Fiduciary, Safeguarding, Operational, Reputational). Enables risk portfolio analysis by type."
    - name: "risk_level"
      expr: risk_level
      comment: "Current risk level (e.g. Low, Medium, High, Critical). Primary risk severity dimension for management dashboards."
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk (e.g. Open, Mitigated, Closed, Escalated). Tracks risk management lifecycle."
    - name: "fiduciary_risk_flag"
      expr: fiduciary_risk_flag
      comment: "Whether this is a fiduciary risk. Fiduciary risks require donor notification and enhanced monitoring."
    - name: "safeguarding_risk_flag"
      expr: safeguarding_risk_flag
      comment: "Whether this is a safeguarding risk. Safeguarding risks require mandatory escalation and investigation protocols."
    - name: "donor_notification_required"
      expr: donor_notification_required
      comment: "Whether the donor must be notified of this risk. Donor notification triggers formal compliance reporting obligations."
    - name: "escalation_required"
      expr: escalation_required
      comment: "Whether escalation is required. Tracks management response obligations for high-severity risks."
    - name: "risk_identification_year"
      expr: YEAR(risk_identification_date)
      comment: "Year the risk was identified. Enables trend analysis of risk emergence over time."
  measures:
    - name: "total_risks"
      expr: COUNT(1)
      comment: "Total number of partner risks in the register. Baseline risk portfolio size metric."
    - name: "total_financial_exposure_usd"
      expr: SUM(CAST(financial_exposure_usd AS DOUBLE))
      comment: "Total financial exposure across all partner risks. The primary financial risk KPI — directly informs reserve and contingency planning."
    - name: "avg_financial_exposure_usd"
      expr: AVG(CAST(financial_exposure_usd AS DOUBLE))
      comment: "Average financial exposure per risk. Informs risk prioritization and mitigation resource allocation."
    - name: "open_high_risks"
      expr: COUNT(CASE WHEN risk_level IN ('High', 'Critical') AND risk_status = 'Open' THEN 1 END)
      comment: "Number of open high or critical risks. A key management attention metric — high counts require immediate executive action."
    - name: "fiduciary_risk_count"
      expr: COUNT(CASE WHEN fiduciary_risk_flag = TRUE THEN 1 END)
      comment: "Number of fiduciary risks. Fiduciary risks directly threaten donor funding and organizational reputation."
    - name: "safeguarding_risk_count"
      expr: COUNT(CASE WHEN safeguarding_risk_flag = TRUE THEN 1 END)
      comment: "Number of safeguarding risks. Safeguarding risks require mandatory escalation and are tracked by donors and oversight bodies."
    - name: "risk_materialization_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_materialised = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of identified risks that have materialized. High materialization rates indicate inadequate risk mitigation or early warning systems."
    - name: "donor_notification_required_count"
      expr: COUNT(CASE WHEN donor_notification_required = TRUE THEN 1 END)
      comment: "Number of risks requiring donor notification. Tracks formal compliance reporting obligations arising from partner risks."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_scheduled_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Scheduled audit KPIs — tracks financial audit outcomes for implementing partners. Measures questioned costs, ineligible expenditures, and audit opinion quality. Critical for HACT assurance compliance and donor financial accountability reporting. Aligned with UNICEF HACT audit requirements and USAID single audit standards."
  source: "`vibe_ngo_v1`.`partnership`.`scheduled_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g. Financial, Compliance, Performance). Determines scope and reporting requirements."
    - name: "audit_opinion"
      expr: audit_opinion
      comment: "Audit opinion issued (e.g. Unqualified, Qualified, Adverse, Disclaimer). Primary quality indicator for partner financial management."
    - name: "opinion_type"
      expr: opinion_type
      comment: "Categorized opinion type. Enables standardized analysis across different audit frameworks."
    - name: "scheduled_audit_status"
      expr: scheduled_audit_status
      comment: "Current status of the scheduled audit (e.g. Planned, In Progress, Completed). Tracks audit pipeline."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the audit amounts. Required for multi-currency financial analysis."
    - name: "audit_period_end_year"
      expr: YEAR(audit_period_end_date)
      comment: "Year of the audit period end. Enables trend analysis of audit outcomes over time."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of scheduled audits. Baseline assurance activity metric."
    - name: "total_questioned_costs"
      expr: SUM(CAST(questioned_cost_amount AS DOUBLE))
      comment: "Total questioned costs identified across all audits. Questioned costs represent potential financial losses and donor recovery obligations."
    - name: "avg_questioned_costs"
      expr: AVG(CAST(questioned_cost_amount AS DOUBLE))
      comment: "Average questioned costs per audit. Benchmarks financial irregularity levels across the partner portfolio."
    - name: "unqualified_opinion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN audit_opinion = 'Unqualified' THEN 1 END) / NULLIF(COUNT(CASE WHEN scheduled_audit_status = 'Completed' THEN 1 END), 0), 2)
      comment: "Percentage of completed audits receiving unqualified (clean) opinions. The primary financial accountability KPI for the partner portfolio."
    - name: "adverse_or_disclaimer_count"
      expr: COUNT(CASE WHEN audit_opinion IN ('Adverse', 'Disclaimer') THEN 1 END)
      comment: "Number of audits with adverse or disclaimer opinions. These represent the most serious financial accountability failures requiring immediate management action."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_spot_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spot check KPIs — measures financial compliance through unannounced or scheduled spot checks on partner expenditures. Tracks amounts reviewed, ineligible findings, and financial findings ratings. Core HACT assurance activity for medium and high-risk partners. Aligned with UNICEF HACT spot check methodology."
  source: "`vibe_ngo_v1`.`partnership`.`spot_check`"
  dimensions:
    - name: "spot_check_status"
      expr: spot_check_status
      comment: "Current status of the spot check (e.g. Completed, Planned, In Progress). Tracks assurance activity pipeline."
    - name: "financial_findings_rating"
      expr: financial_findings_rating
      comment: "Financial findings rating from the spot check (e.g. Satisfactory, Partially Satisfactory, Unsatisfactory). Primary quality outcome indicator."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of spot check amounts. Required for multi-currency financial analysis."
    - name: "check_year"
      expr: YEAR(check_date)
      comment: "Year the spot check was conducted. Enables trend analysis of spot check outcomes over time."
  measures:
    - name: "total_spot_checks"
      expr: COUNT(1)
      comment: "Total number of spot checks conducted. Baseline HACT assurance activity volume metric."
    - name: "total_amount_reviewed"
      expr: SUM(CAST(amount_reviewed AS DOUBLE))
      comment: "Total financial amount reviewed through spot checks. Measures the financial coverage of spot check assurance activities."
    - name: "avg_amount_reviewed"
      expr: AVG(CAST(amount_reviewed AS DOUBLE))
      comment: "Average amount reviewed per spot check. Informs spot check scope planning and resource allocation."
    - name: "unsatisfactory_findings_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN financial_findings_rating = 'Unsatisfactory' THEN 1 END) / NULLIF(COUNT(CASE WHEN spot_check_status = 'Completed' THEN 1 END), 0), 2)
      comment: "Percentage of completed spot checks with unsatisfactory financial findings. High rates indicate systemic financial management weaknesses requiring escalation."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_agreement_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agreement Amendment business metrics"
  source: "`vibe_ngo_v1`.`partnership`.`agreement_amendment`"
  dimensions:
    - name: "Amendment Number"
      expr: amendment_number
    - name: "Amendment Status"
      expr: amendment_status
    - name: "Amendment Title"
      expr: amendment_title
    - name: "Amendment Type"
      expr: amendment_type
    - name: "Approval Authority"
      expr: approval_authority
    - name: "Approved Date"
      expr: approved_date
    - name: "Beneficiary Target Change"
      expr: beneficiary_target_change
    - name: "Clauses Modified"
      expr: clauses_modified
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Document Reference"
      expr: document_reference
    - name: "Donor Approval Reference"
      expr: donor_approval_reference
    - name: "Donor Prior Approval Required"
      expr: donor_prior_approval_required
    - name: "Effective Date"
      expr: effective_date
    - name: "Execution Date"
      expr: execution_date
    - name: "Extension Duration Days"
      expr: extension_duration_days
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Agreement Amendment"
      expr: COUNT(DISTINCT agreement_amendment_id)
    - name: "Total Budget Change Amount"
      expr: SUM(budget_change_amount)
    - name: "Average Budget Change Amount"
      expr: AVG(budget_change_amount)
    - name: "Total Original Budget Amount"
      expr: SUM(original_budget_amount)
    - name: "Average Original Budget Amount"
      expr: AVG(original_budget_amount)
    - name: "Total Revised Budget Amount"
      expr: SUM(revised_budget_amount)
    - name: "Average Revised Budget Amount"
      expr: AVG(revised_budget_amount)
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_campaign_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign Participation business metrics"
  source: "`vibe_ngo_v1`.`partnership`.`campaign_participation`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Contribution Type"
      expr: contribution_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Participation End Date"
      expr: participation_end_date
    - name: "Participation Start Date"
      expr: participation_start_date
    - name: "Partner Role"
      expr: partner_role
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Visibility Level"
      expr: visibility_level
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Participation End Date Month"
      expr: DATE_TRUNC('MONTH', participation_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Campaign Participation"
      expr: COUNT(DISTINCT campaign_participation_id)
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_consortium_communication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consortium Communication business metrics"
  source: "`vibe_ngo_v1`.`partnership`.`consortium_communication`"
  dimensions:
    - name: "Approval Authority"
      expr: approval_authority
    - name: "Assigned Date"
      expr: assigned_date
    - name: "Branding Guidelines"
      expr: branding_guidelines
    - name: "Consortium Role"
      expr: consortium_role
    - name: "Review Completed Date"
      expr: review_completed_date
    - name: "Review Deadline"
      expr: review_deadline
    - name: "Review Notes"
      expr: review_notes
    - name: "Review Status"
      expr: review_status
    - name: "Visibility Requirements"
      expr: visibility_requirements
    - name: "Assigned Date Month"
      expr: DATE_TRUNC('MONTH', assigned_date)
    - name: "Review Completed Date Month"
      expr: DATE_TRUNC('MONTH', review_completed_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Consortium Communication"
      expr: COUNT(DISTINCT consortium_communication_id)
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_coordination_meeting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coordination Meeting business metrics"
  source: "`vibe_ngo_v1`.`partnership`.`coordination_meeting`"
  dimensions:
    - name: "Action Items Summary"
      expr: action_items_summary
    - name: "Agenda Document Url"
      expr: agenda_document_url
    - name: "Agenda Summary"
      expr: agenda_summary
    - name: "Associated Response Plan"
      expr: associated_response_plan
    - name: "City"
      expr: city
    - name: "Cluster Sector"
      expr: cluster_sector
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Duration Minutes"
      expr: duration_minutes
    - name: "End Time"
      expr: end_time
    - name: "Follow Up Status"
      expr: follow_up_status
    - name: "Hosting Organization"
      expr: hosting_organization
    - name: "Humanitarian Context"
      expr: humanitarian_context
    - name: "Is Recurring"
      expr: is_recurring
    - name: "Key Decisions"
      expr: key_decisions
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Coordination Meeting"
      expr: COUNT(DISTINCT coordination_meeting_id)
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partner_accreditation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner Accreditation business metrics"
  source: "`vibe_ngo_v1`.`partnership`.`partner_accreditation`"
  dimensions:
    - name: "Accreditation Code"
      expr: accreditation_code
    - name: "Accreditation Name"
      expr: accreditation_name
    - name: "Accreditation Status"
      expr: accreditation_status
    - name: "Accreditation Type"
      expr: accreditation_type
    - name: "Accrediting Body Country Code"
      expr: accrediting_body_country_code
    - name: "Accrediting Body Name"
      expr: accrediting_body_name
    - name: "Applicable Standard Version"
      expr: applicable_standard_version
    - name: "Assessment Level"
      expr: assessment_level
    - name: "Certificate Number"
      expr: certificate_number
    - name: "Chs Commitment Level"
      expr: chs_commitment_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Document Reference"
      expr: document_reference
    - name: "Document Upload Date"
      expr: document_upload_date
    - name: "Donor Reference"
      expr: donor_reference
    - name: "Donor Required"
      expr: donor_required
    - name: "Expiry Date"
      expr: expiry_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partner Accreditation"
      expr: COUNT(DISTINCT partner_accreditation_id)
    - name: "Total Accreditation Score"
      expr: SUM(accreditation_score)
    - name: "Average Accreditation Score"
      expr: AVG(accreditation_score)
    - name: "Total Due Diligence Weight"
      expr: SUM(due_diligence_weight)
    - name: "Average Due Diligence Weight"
      expr: AVG(due_diligence_weight)
    - name: "Total Max Possible Score"
      expr: SUM(max_possible_score)
    - name: "Average Max Possible Score"
      expr: AVG(max_possible_score)
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partner_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner Compliance business metrics"
  source: "`vibe_ngo_v1`.`partnership`.`partner_compliance`"
  dimensions:
    - name: "Assigned Date"
      expr: assigned_date
    - name: "Completion Date"
      expr: completion_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Due Date"
      expr: due_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Notes"
      expr: notes
    - name: "Partner Compliance Status"
      expr: partner_compliance_status
    - name: "Responsible Focal Point"
      expr: responsible_focal_point
    - name: "Waiver Status"
      expr: waiver_status
    - name: "Assigned Date Month"
      expr: DATE_TRUNC('MONTH', assigned_date)
    - name: "Completion Date Month"
      expr: DATE_TRUNC('MONTH', completion_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partner Compliance"
      expr: COUNT(DISTINCT partner_compliance_id)
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partner_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner Contact business metrics"
  source: "`vibe_ngo_v1`.`partnership`.`partner_contact`"
  dimensions:
    - name: "Cluster Membership"
      expr: cluster_membership
    - name: "Consent Date"
      expr: consent_date
    - name: "Contact Status"
      expr: contact_status
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Sharing Consent"
      expr: data_sharing_consent
    - name: "Department"
      expr: department
    - name: "Do Not Contact"
      expr: do_not_contact
    - name: "Duty Station"
      expr: duty_station
    - name: "End Date"
      expr: end_date
    - name: "First Name"
      expr: first_name
    - name: "Gender"
      expr: gender
    - name: "Is Authorized Signatory"
      expr: is_authorized_signatory
    - name: "Is Financial Authorized"
      expr: is_financial_authorized
    - name: "Is Primary Contact"
      expr: is_primary_contact
    - name: "Job Title"
      expr: job_title
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partner Contact"
      expr: COUNT(DISTINCT partner_contact_id)
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partnership_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partnership Agreement business metrics"
  source: "`vibe_ngo_v1`.`partnership`.`partnership_agreement`"
  dimensions:
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Amendment Date"
      expr: amendment_date
    - name: "Amendment Description"
      expr: amendment_description
    - name: "Amendment Number"
      expr: amendment_number
    - name: "Capacity Assessment Date"
      expr: capacity_assessment_date
    - name: "Capacity Assessment Status"
      expr: capacity_assessment_status
    - name: "Cluster Lead Agency"
      expr: cluster_lead_agency
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Resolution Mechanism"
      expr: dispute_resolution_mechanism
    - name: "Due Diligence Risk Rating"
      expr: due_diligence_risk_rating
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Execution Date"
      expr: execution_date
    - name: "Geographic Scope"
      expr: geographic_scope
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partnership Agreement"
      expr: COUNT(DISTINCT partnership_agreement_id)
    - name: "Total Funding Ceiling Amount"
      expr: SUM(funding_ceiling_amount)
    - name: "Average Funding Ceiling Amount"
      expr: AVG(funding_ceiling_amount)
    - name: "Total Indirect Cost Rate"
      expr: SUM(indirect_cost_rate)
    - name: "Average Indirect Cost Rate"
      expr: AVG(indirect_cost_rate)
$$;