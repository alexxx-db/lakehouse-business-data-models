-- Metric views for domain: client | Business: Construction | Version: 2 | Generated on: 2026-07-10 12:14:04

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the client account master — tracks portfolio value, credit exposure, pipeline health, and account quality across the client base."
  source: "`vibe_construction_v1`.`client`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Lifecycle status of the account (Active, Inactive, Prospect, etc.) for portfolio segmentation."
    - name: "account_type"
      expr: account_type
      comment: "Classification of the account (Client, Subcontractor, JV Partner, etc.)."
    - name: "client_tier"
      expr: client_tier
      comment: "Strategic tier assigned to the client (Tier 1, Tier 2, Tier 3) for relationship prioritisation."
    - name: "industry_sector"
      expr: industry_sector
      comment: "Industry sector of the client account for market segment analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the account for geographic revenue and risk analysis."
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Current prequalification standing of the account (Approved, Expired, Pending)."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating assigned to the account for financial risk segmentation."
    - name: "preferred_contract_type"
      expr: preferred_contract_type
      comment: "Preferred contract type (Lump Sum, GMP, Cost-Plus) for commercial strategy analysis."
    - name: "is_jv_entity"
      expr: is_jv_entity
      comment: "Flag indicating whether the account is a joint venture entity."
    - name: "relationship_start_year"
      expr: YEAR(relationship_start_date)
      comment: "Year the client relationship commenced, for cohort and tenure analysis."
    - name: "last_project_award_year"
      expr: YEAR(last_project_award_date)
      comment: "Year of the most recent project award, for recency analysis."
  measures:
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total number of client accounts in the portfolio. Baseline headcount KPI for portfolio size tracking."
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Sum of declared annual revenue across all client accounts. Indicates the total economic scale of the client portfolio."
    - name: "avg_annual_revenue_per_account"
      expr: AVG(CAST(annual_revenue AS DOUBLE))
      comment: "Average annual revenue per client account. Used to benchmark account size and identify under-served high-value segments."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all accounts. Key financial risk exposure metric for the CFO and credit committee."
    - name: "avg_credit_limit_per_account"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account. Benchmarks credit policy consistency across the portfolio."
    - name: "active_account_count"
      expr: COUNT(CASE WHEN account_status = 'Active' THEN 1 END)
      comment: "Number of accounts with Active status. Tracks the live, revenue-generating portion of the client portfolio."
    - name: "prequalified_account_count"
      expr: COUNT(CASE WHEN prequalification_status = 'Approved' THEN 1 END)
      comment: "Number of accounts with an approved prequalification. Indicates the pool of clients eligible for bid invitations."
    - name: "hse_compliant_account_count"
      expr: COUNT(CASE WHEN hse_compliance_required = TRUE THEN 1 END)
      comment: "Number of accounts flagged as requiring HSE compliance. Drives safety governance and audit prioritisation."
    - name: "jv_entity_count"
      expr: COUNT(CASE WHEN is_jv_entity = TRUE THEN 1 END)
      comment: "Number of accounts that are joint venture entities. Tracks JV partnership exposure in the client portfolio."
    - name: "do_not_contact_count"
      expr: COUNT(CASE WHEN do_not_contact = TRUE THEN 1 END)
      comment: "Number of accounts flagged as do-not-contact. Monitors compliance with communication restrictions and GDPR obligations."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_account_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk and financial exposure KPIs for client accounts — supports credit committee decisions, DSO management, and overdue balance monitoring."
  source: "`vibe_construction_v1`.`client`.`account_credit_profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the credit profile (Active, Expired, Under Review)."
    - name: "client_segment"
      expr: client_segment
      comment: "Client segment associated with this credit profile for risk segmentation."
    - name: "external_credit_rating"
      expr: external_credit_rating
      comment: "External credit rating (e.g. Moody's, S&P) for benchmarking internal risk assessments."
    - name: "external_rating_agency"
      expr: external_rating_agency
      comment: "Agency that issued the external credit rating."
    - name: "payment_history_rating"
      expr: payment_history_rating
      comment: "Historical payment behaviour rating for predicting future default risk."
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Whether the account is currently on credit hold — critical for accounts receivable and project go/no-go decisions."
    - name: "sovereign_risk_flag"
      expr: sovereign_risk_flag
      comment: "Whether the account carries sovereign risk, relevant for international project financial planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the credit profile is denominated."
    - name: "credit_review_frequency"
      expr: credit_review_frequency
      comment: "How often the credit profile is reviewed (Monthly, Quarterly, Annually)."
    - name: "credit_approved_year"
      expr: YEAR(credit_approved_date)
      comment: "Year the credit was approved, for vintage analysis of the credit book."
  measures:
    - name: "total_credit_limit_amount"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit approved across all client credit profiles. Primary financial exposure metric for the credit committee."
    - name: "total_current_exposure"
      expr: SUM(CAST(current_exposure_amount AS DOUBLE))
      comment: "Total current financial exposure across all accounts. Measures how much of the approved credit is currently drawn."
    - name: "total_overdue_balance"
      expr: SUM(CAST(overdue_balance_amount AS DOUBLE))
      comment: "Total overdue receivables across all client accounts. Critical collections KPI that triggers escalation and credit hold actions."
    - name: "total_liquidated_damages_exposure"
      expr: SUM(CAST(liquidated_damages_exposure_amount AS DOUBLE))
      comment: "Total potential liquidated damages exposure across the portfolio. Informs contract risk provisioning and legal reserves."
    - name: "avg_dso_days"
      expr: AVG(CAST(dso_days AS DOUBLE))
      comment: "Average Days Sales Outstanding across client accounts. Key cash flow efficiency metric — rising DSO signals collection problems."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage held across client accounts. Informs cash flow forecasting and contract commercial strategy."
    - name: "credit_hold_account_count"
      expr: COUNT(CASE WHEN credit_hold_flag = TRUE THEN 1 END)
      comment: "Number of accounts currently on credit hold. Directly impacts revenue recognition and project continuation decisions."
    - name: "credit_insurance_covered_count"
      expr: COUNT(CASE WHEN credit_insurance_flag = TRUE THEN 1 END)
      comment: "Number of accounts with credit insurance in place. Measures risk mitigation coverage across the receivables portfolio."
    - name: "total_credit_insurance_limit"
      expr: SUM(CAST(credit_insurance_limit_amount AS DOUBLE))
      comment: "Total credit insurance limit across insured accounts. Quantifies the insured portion of credit exposure."
    - name: "avg_credit_limit_amount"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per profile. Benchmarks credit policy consistency and identifies outlier exposures."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Business development pipeline KPIs — tracks opportunity conversion, weighted pipeline value, bid win rates, and strategic pursuit performance."
  source: "`vibe_construction_v1`.`client`.`client_opportunity`"
  dimensions:
    - name: "opportunity_status"
      expr: opportunity_status
      comment: "Current stage of the opportunity (Identified, Qualifying, Bidding, Won, Lost, No-Bid)."
    - name: "pipeline_stage"
      expr: pipeline_stage
      comment: "CRM pipeline stage for funnel analysis and conversion tracking."
    - name: "win_loss_outcome"
      expr: win_loss_outcome
      comment: "Final outcome of the opportunity (Won, Lost, No-Bid, Withdrawn) for win rate analysis."
    - name: "bid_no_bid_decision"
      expr: bid_no_bid_decision
      comment: "Bid/No-Bid decision outcome for pursuit strategy analysis."
    - name: "project_type"
      expr: project_type
      comment: "Type of construction project (Civil, Building, Infrastructure, etc.) for sector mix analysis."
    - name: "sector"
      expr: sector
      comment: "Market sector of the opportunity for strategic portfolio analysis."
    - name: "project_location_country"
      expr: project_location_country
      comment: "Country where the project is located for geographic pipeline analysis."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contract delivery model (D&B, EPC, Alliance, etc.) for commercial strategy analysis."
    - name: "strategic_priority"
      expr: strategic_priority
      comment: "Strategic priority classification of the opportunity for resource allocation decisions."
    - name: "is_jv_bid"
      expr: is_jv_bid
      comment: "Whether the bid is a joint venture pursuit, for JV strategy tracking."
    - name: "expected_award_year"
      expr: YEAR(expected_award_date)
      comment: "Year the award is expected, for pipeline timing and revenue forecasting."
    - name: "bid_submission_year"
      expr: YEAR(bid_submission_date)
      comment: "Year the bid was submitted, for bid activity volume trending."
  measures:
    - name: "total_opportunities"
      expr: COUNT(1)
      comment: "Total number of client opportunities in the pipeline. Baseline volume metric for BD activity tracking."
    - name: "total_estimated_contract_value"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE))
      comment: "Total estimated contract value across all opportunities. Primary pipeline value metric used in board-level revenue forecasting."
    - name: "total_weighted_pipeline_value"
      expr: SUM(CAST(weighted_pipeline_value AS DOUBLE))
      comment: "Sum of probability-weighted pipeline values. The most reliable forward revenue indicator for executive planning."
    - name: "avg_probability_of_win_pct"
      expr: AVG(CAST(probability_of_win_pct AS DOUBLE))
      comment: "Average win probability across active opportunities. Signals overall pipeline quality and BD team confidence."
    - name: "total_bid_cost_estimate"
      expr: SUM(CAST(bid_cost_estimate AS DOUBLE))
      comment: "Total estimated cost to bid across all opportunities. Drives BD budget allocation and bid/no-bid ROI analysis."
    - name: "won_opportunity_count"
      expr: COUNT(CASE WHEN win_loss_outcome = 'Won' THEN 1 END)
      comment: "Number of opportunities won. Numerator for win rate calculation and BD performance measurement."
    - name: "lost_opportunity_count"
      expr: COUNT(CASE WHEN win_loss_outcome = 'Lost' THEN 1 END)
      comment: "Number of opportunities lost. Used with won count to compute win rate and identify loss patterns."
    - name: "won_contract_value"
      expr: SUM(CASE WHEN win_loss_outcome = 'Won' THEN CAST(estimated_contract_value AS DOUBLE) ELSE 0 END)
      comment: "Total contract value of won opportunities. Measures actual revenue secured from the BD pipeline."
    - name: "avg_estimated_contract_value"
      expr: AVG(CAST(estimated_contract_value AS DOUBLE))
      comment: "Average estimated contract value per opportunity. Tracks deal size trends and strategic positioning."
    - name: "jv_bid_count"
      expr: COUNT(CASE WHEN is_jv_bid = TRUE THEN 1 END)
      comment: "Number of joint venture bid opportunities. Tracks JV strategy execution and partnership pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_prequalification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prequalification programme KPIs — tracks approval rates, scoring performance, HSE compliance, and renewal pipeline for client qualification management."
  source: "`vibe_construction_v1`.`client`.`client_prequalification`"
  dimensions:
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Current status of the prequalification (Approved, Rejected, Pending, Expired)."
    - name: "work_category"
      expr: work_category
      comment: "Category of work the prequalification covers for scope-based analysis."
    - name: "procurement_category"
      expr: procurement_category
      comment: "Procurement category for spend and supplier segmentation."
    - name: "country_code"
      expr: country_code
      comment: "Country where the prequalification applies for geographic compliance tracking."
    - name: "hse_certification_required"
      expr: hse_certification_required
      comment: "Whether HSE certification was required as part of the prequalification."
    - name: "renewal_required"
      expr: renewal_required
      comment: "Whether the prequalification requires renewal, for expiry pipeline management."
    - name: "rfp_eligibility_flag"
      expr: rfp_eligibility_flag
      comment: "Whether the prequalified entity is eligible for RFP invitations."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the prequalification was submitted, for volume trending."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the prequalification expires, for renewal pipeline planning."
  measures:
    - name: "total_prequalifications"
      expr: COUNT(1)
      comment: "Total number of client prequalification records. Baseline volume for qualification programme management."
    - name: "approved_prequalification_count"
      expr: COUNT(CASE WHEN prequalification_status = 'Approved' THEN 1 END)
      comment: "Number of approved prequalifications. Defines the eligible bidder pool for procurement activities."
    - name: "expired_prequalification_count"
      expr: COUNT(CASE WHEN prequalification_status = 'Expired' THEN 1 END)
      comment: "Number of expired prequalifications. Triggers renewal outreach and procurement risk management."
    - name: "avg_prequalification_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average prequalification score across all submissions. Benchmarks supplier quality and identifies below-threshold performers."
    - name: "avg_minimum_passing_score"
      expr: AVG(CAST(minimum_passing_score AS DOUBLE))
      comment: "Average minimum passing score threshold. Tracks stringency of qualification standards across categories."
    - name: "avg_submitted_trir"
      expr: AVG(CAST(submitted_trir AS DOUBLE))
      comment: "Average Total Recordable Incident Rate submitted by clients. Key HSE performance benchmark for supplier qualification."
    - name: "avg_max_project_value"
      expr: AVG(CAST(max_project_value AS DOUBLE))
      comment: "Average maximum project value clients are prequalified for. Indicates the scale of work the qualified pool can deliver."
    - name: "rfp_eligible_count"
      expr: COUNT(CASE WHEN rfp_eligibility_flag = TRUE THEN 1 END)
      comment: "Number of prequalifications granting RFP eligibility. Defines the active tender-ready supplier pool."
    - name: "renewal_due_count"
      expr: COUNT(CASE WHEN renewal_required = TRUE THEN 1 END)
      comment: "Number of prequalifications requiring renewal. Drives proactive renewal outreach to maintain qualified supplier pool."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_project_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client project engagement KPIs — tracks contract value, satisfaction, retention, variation exposure, and relationship health across active project engagements."
  source: "`vibe_construction_v1`.`client`.`project_engagement`"
  dimensions:
    - name: "engagement_status"
      expr: engagement_status
      comment: "Current status of the project engagement (Active, Completed, Suspended, Terminated)."
    - name: "engagement_type"
      expr: engagement_type
      comment: "Type of engagement (Head Contract, Framework Call-Off, Alliance, etc.)."
    - name: "client_role"
      expr: client_role
      comment: "Role of the client in the engagement (Owner, Developer, Employer, etc.)."
    - name: "sector"
      expr: sector
      comment: "Market sector of the engagement for portfolio mix analysis."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method used (Competitive Tender, Negotiated, Framework, etc.)."
    - name: "relationship_tier"
      expr: relationship_tier
      comment: "Relationship tier classification for strategic account management."
    - name: "repeat_client"
      expr: repeat_client
      comment: "Whether the client is a repeat client — key loyalty and retention indicator."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current dispute status for legal risk monitoring."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of project funding (Government, Private, PPP, etc.) for risk and payment security analysis."
    - name: "engagement_start_year"
      expr: YEAR(engagement_start_date)
      comment: "Year the engagement commenced for cohort and revenue vintage analysis."
  measures:
    - name: "total_engagements"
      expr: COUNT(1)
      comment: "Total number of client project engagements. Baseline portfolio size metric."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contracted value across all project engagements. Primary revenue backlog metric for executive reporting."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average contract value per engagement. Tracks deal size trends and strategic positioning."
    - name: "total_approved_variation_value"
      expr: SUM(CAST(approved_variation_value AS DOUBLE))
      comment: "Total approved variation value across engagements. Measures scope growth and commercial management effectiveness."
    - name: "total_advance_payment_amount"
      expr: SUM(CAST(advance_payment_amount AS DOUBLE))
      comment: "Total advance payments made to clients. Tracks cash flow exposure from advance payment obligations."
    - name: "avg_satisfaction_score"
      expr: AVG(CAST(satisfaction_score AS DOUBLE))
      comment: "Average client satisfaction score across engagements. Leading indicator of repeat business and relationship health."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage held across engagements. Impacts cash flow and final account settlement timing."
    - name: "avg_liquidated_damages_rate"
      expr: AVG(CAST(liquidated_damages_rate AS DOUBLE))
      comment: "Average liquidated damages rate across engagements. Quantifies schedule risk exposure in the contract portfolio."
    - name: "repeat_client_engagement_count"
      expr: COUNT(CASE WHEN repeat_client = TRUE THEN 1 END)
      comment: "Number of engagements with repeat clients. Key loyalty metric — repeat clients reduce BD cost and improve win rates."
    - name: "avg_jv_participation_percentage"
      expr: AVG(CAST(jv_participation_percentage AS DOUBLE))
      comment: "Average JV participation percentage across joint venture engagements. Tracks risk and reward sharing in JV portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client satisfaction and relationship health KPIs — tracks NPS, satisfaction scores across dimensions, and escalation rates to drive client experience improvements."
  source: "`vibe_construction_v1`.`client`.`survey`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Type of survey (Post-Project, Mid-Project, Annual Relationship Review, etc.)."
    - name: "survey_status"
      expr: survey_status
      comment: "Current status of the survey (Sent, Completed, Overdue, Cancelled)."
    - name: "nps_category"
      expr: nps_category
      comment: "NPS category (Promoter, Passive, Detractor) for loyalty segmentation."
    - name: "client_sector"
      expr: client_sector
      comment: "Client sector for satisfaction benchmarking across market segments."
    - name: "channel"
      expr: channel
      comment: "Survey delivery channel (Email, Phone, In-Person) for response quality analysis."
    - name: "relationship_risk_level"
      expr: relationship_risk_level
      comment: "Assessed relationship risk level (Low, Medium, High, Critical) for account management prioritisation."
    - name: "follow_up_status"
      expr: follow_up_status
      comment: "Status of follow-up actions triggered by survey responses."
    - name: "repeat_client_flag"
      expr: repeat_client_flag
      comment: "Whether the surveyed client is a repeat client, for loyalty cohort analysis."
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Whether the survey response triggered an escalation, for relationship risk monitoring."
    - name: "response_year"
      expr: YEAR(response_date)
      comment: "Year the survey was completed, for satisfaction trend analysis over time."
  measures:
    - name: "total_surveys"
      expr: COUNT(1)
      comment: "Total number of client surveys issued. Baseline metric for client engagement programme activity."
    - name: "completed_survey_count"
      expr: COUNT(CASE WHEN survey_status = 'Completed' THEN 1 END)
      comment: "Number of completed surveys. Numerator for response rate calculation and programme effectiveness."
    - name: "avg_overall_satisfaction_score"
      expr: AVG(CAST(overall_satisfaction_score AS DOUBLE))
      comment: "Average overall client satisfaction score. Primary client experience KPI used in executive dashboards and QBRs."
    - name: "avg_relationship_health_score"
      expr: AVG(CAST(relationship_health_score AS DOUBLE))
      comment: "Average relationship health score. Leading indicator of account retention risk and repeat business probability."
    - name: "avg_safety_score"
      expr: AVG(CAST(safety_score AS DOUBLE))
      comment: "Average client-rated safety performance score. Tracks HSE reputation and compliance perception."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average client-rated quality score. Drives quality improvement initiatives and contractor performance benchmarking."
    - name: "avg_schedule_score"
      expr: AVG(CAST(schedule_score AS DOUBLE))
      comment: "Average client-rated schedule performance score. Identifies delivery reliability issues requiring operational intervention."
    - name: "avg_cost_management_score"
      expr: AVG(CAST(cost_management_score AS DOUBLE))
      comment: "Average client-rated cost management score. Signals commercial management effectiveness from the client perspective."
    - name: "escalation_count"
      expr: COUNT(CASE WHEN escalation_required_flag = TRUE THEN 1 END)
      comment: "Number of surveys that triggered an escalation. Critical relationship risk metric requiring immediate management attention."
    - name: "promoter_count"
      expr: COUNT(CASE WHEN nps_category = 'Promoter' THEN 1 END)
      comment: "Number of Promoter responses. Numerator for NPS calculation and advocacy programme targeting."
    - name: "detractor_count"
      expr: COUNT(CASE WHEN nps_category = 'Detractor' THEN 1 END)
      comment: "Number of Detractor responses. Triggers relationship recovery actions and churn risk management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_rfp_issuance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFP pipeline and commercial terms KPIs — tracks tender activity, contract value pipeline, evaluation criteria weighting, and bid bond requirements across client-issued RFPs."
  source: "`vibe_construction_v1`.`client`.`rfp_issuance`"
  dimensions:
    - name: "rfp_status"
      expr: rfp_status
      comment: "Current status of the RFP (Draft, Issued, Closed, Awarded, Cancelled)."
    - name: "solicitation_type"
      expr: solicitation_type
      comment: "Type of solicitation (Open Tender, Selective Tender, Negotiated, etc.)."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type specified in the RFP (Lump Sum, GMP, Cost-Plus, etc.)."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Project delivery model (D&B, EPC, CM, etc.) for commercial strategy analysis."
    - name: "project_sector"
      expr: project_sector
      comment: "Sector of the project being tendered for market mix analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country where the RFP is issued for geographic pipeline analysis."
    - name: "leed_certification_required"
      expr: leed_certification_required
      comment: "Whether LEED certification is required, for sustainability-driven tender tracking."
    - name: "performance_bond_required"
      expr: performance_bond_required
      comment: "Whether a performance bond is required, for risk and surety management."
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the RFP was issued for tender volume trending."
  measures:
    - name: "total_rfps_issued"
      expr: COUNT(1)
      comment: "Total number of RFPs issued. Baseline tender activity metric for BD pipeline management."
    - name: "total_estimated_contract_value"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE))
      comment: "Total estimated contract value across all issued RFPs. Measures the total tender pipeline value available to pursue."
    - name: "avg_estimated_contract_value"
      expr: AVG(CAST(estimated_contract_value AS DOUBLE))
      comment: "Average estimated contract value per RFP. Tracks deal size trends in the client tender market."
    - name: "avg_technical_score_weight"
      expr: AVG(CAST(technical_score_weight AS DOUBLE))
      comment: "Average technical evaluation weighting across RFPs. Indicates how technically demanding the client tender market is."
    - name: "avg_commercial_score_weight"
      expr: AVG(CAST(commercial_score_weight AS DOUBLE))
      comment: "Average commercial evaluation weighting across RFPs. Balances against technical weight to understand price sensitivity."
    - name: "avg_liquidated_damages_rate"
      expr: AVG(CAST(liquidated_damages_rate AS DOUBLE))
      comment: "Average liquidated damages rate across RFPs. Quantifies schedule risk exposure in the tender pipeline."
    - name: "avg_local_content_requirement_pct"
      expr: AVG(CAST(local_content_requirement_pct AS DOUBLE))
      comment: "Average local content requirement percentage. Tracks regulatory and social value obligations in the tender market."
    - name: "performance_bond_required_count"
      expr: COUNT(CASE WHEN performance_bond_required = TRUE THEN 1 END)
      comment: "Number of RFPs requiring a performance bond. Drives surety and bonding capacity planning."
    - name: "bid_bond_required_count"
      expr: COUNT(CASE WHEN bid_bond_required = TRUE THEN 1 END)
      comment: "Number of RFPs requiring a bid bond. Informs bid cost budgeting and bonding facility requirements."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_framework_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Framework agreement portfolio KPIs — tracks committed and ceiling values, utilisation, and commercial terms across client framework agreements."
  source: "`vibe_construction_v1`.`client`.`client_framework_agreement`"
  dimensions:
    - name: "client_framework_agreement_status"
      expr: client_framework_agreement_status
      comment: "Current status of the framework agreement (Active, Expired, Terminated, Pending)."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of framework agreement (Panel, Sole Source, Multi-Supplier, etc.)."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model under the framework for commercial strategy analysis."
    - name: "procurement_route"
      expr: procurement_route
      comment: "Procurement route used to establish the framework."
    - name: "sector"
      expr: sector
      comment: "Market sector covered by the framework agreement."
    - name: "country_code"
      expr: country_code
      comment: "Country where the framework agreement applies."
    - name: "performance_bond_required"
      expr: performance_bond_required
      comment: "Whether a performance bond is required under the framework."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the framework agreement became effective for portfolio vintage analysis."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the framework agreement expires for renewal pipeline management."
  measures:
    - name: "total_framework_agreements"
      expr: COUNT(1)
      comment: "Total number of client framework agreements. Baseline portfolio size metric."
    - name: "total_ceiling_value"
      expr: SUM(CAST(ceiling_value AS DOUBLE))
      comment: "Total ceiling value across all framework agreements. Represents the maximum revenue opportunity from the framework portfolio."
    - name: "total_committed_value"
      expr: SUM(CAST(committed_value AS DOUBLE))
      comment: "Total committed value called off against framework agreements. Measures actual revenue secured from frameworks."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across framework agreements. Impacts cash flow forecasting for framework call-offs."
    - name: "avg_liquidated_damages_rate"
      expr: AVG(CAST(liquidated_damages_rate AS DOUBLE))
      comment: "Average liquidated damages rate across frameworks. Quantifies schedule risk exposure in the framework portfolio."
    - name: "avg_max_calloff_value"
      expr: AVG(CAST(max_calloff_value AS DOUBLE))
      comment: "Average maximum call-off value per framework. Informs project sizing and resource planning for framework delivery."
    - name: "active_framework_count"
      expr: COUNT(CASE WHEN client_framework_agreement_status = 'Active' THEN 1 END)
      comment: "Number of currently active framework agreements. Defines the live revenue-generating framework portfolio."
    - name: "insurance_required_count"
      expr: COUNT(CASE WHEN insurance_required = TRUE THEN 1 END)
      comment: "Number of frameworks requiring insurance compliance. Drives insurance management and compliance monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client engagement activity KPIs — tracks interaction volume, entertainment spend, follow-up compliance, and executive engagement rates to measure BD relationship investment."
  source: "`vibe_construction_v1`.`client`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of client interaction (Meeting, Call, Site Visit, Entertainment, etc.)."
    - name: "interaction_status"
      expr: interaction_status
      comment: "Status of the interaction (Planned, Completed, Cancelled)."
    - name: "channel"
      expr: channel
      comment: "Communication channel used (In-Person, Video, Phone, Email) for engagement mix analysis."
    - name: "client_seniority_level"
      expr: client_seniority_level
      comment: "Seniority level of the client attendees for executive engagement tracking."
    - name: "is_executive_engagement"
      expr: is_executive_engagement
      comment: "Whether the interaction involved executive-level participants — key relationship depth indicator."
    - name: "followup_completed"
      expr: followup_completed
      comment: "Whether follow-up actions were completed — measures BD team responsiveness."
    - name: "gifts_hospitality_declared"
      expr: gifts_hospitality_declared
      comment: "Whether gifts or hospitality were declared — compliance and ethics monitoring."
    - name: "sentiment_indicator"
      expr: sentiment_indicator
      comment: "Sentiment of the interaction (Positive, Neutral, Negative) for relationship health tracking."
    - name: "interaction_year"
      expr: YEAR(interaction_date)
      comment: "Year of the interaction for engagement activity trending."
  measures:
    - name: "total_interactions"
      expr: COUNT(1)
      comment: "Total number of client interactions. Baseline BD activity metric for relationship investment tracking."
    - name: "total_entertainment_cost"
      expr: SUM(CAST(entertainment_cost AS DOUBLE))
      comment: "Total entertainment and hospitality spend across all interactions. Tracks BD investment and ethics compliance exposure."
    - name: "avg_entertainment_cost_per_interaction"
      expr: AVG(CAST(entertainment_cost AS DOUBLE))
      comment: "Average entertainment cost per interaction. Benchmarks BD spend efficiency and identifies outlier hospitality events."
    - name: "executive_engagement_count"
      expr: COUNT(CASE WHEN is_executive_engagement = TRUE THEN 1 END)
      comment: "Number of executive-level client interactions. Measures depth of strategic relationship investment."
    - name: "followup_completed_count"
      expr: COUNT(CASE WHEN followup_completed = TRUE THEN 1 END)
      comment: "Number of interactions with completed follow-up actions. Measures BD team responsiveness and commitment fulfilment."
    - name: "gifts_hospitality_declared_count"
      expr: COUNT(CASE WHEN gifts_hospitality_declared = TRUE THEN 1 END)
      comment: "Number of interactions with declared gifts or hospitality. Tracks ethics and anti-bribery compliance exposure."
    - name: "unique_accounts_engaged"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct client accounts engaged. Measures breadth of active client relationship management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_account_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corporate structure and ownership KPIs — tracks JV arrangements, ownership concentration, and hierarchy complexity across the client account network."
  source: "`vibe_construction_v1`.`client`.`account_hierarchy`"
  dimensions:
    - name: "hierarchy_status"
      expr: hierarchy_status
      comment: "Current status of the hierarchy relationship (Active, Dissolved, Restructured)."
    - name: "relationship_type"
      expr: relationship_type
      comment: "Type of corporate relationship (Parent-Subsidiary, JV, Associate, etc.)."
    - name: "arrangement_type"
      expr: arrangement_type
      comment: "Arrangement type for the hierarchy (Consolidated, Equity Method, etc.)."
    - name: "consolidation_method"
      expr: consolidation_method
      comment: "Accounting consolidation method applied to this hierarchy relationship."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the hierarchy relationship for regional portfolio analysis."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the corporate hierarchy (Ultimate Parent, Intermediate, Subsidiary)."
    - name: "is_primary_hierarchy"
      expr: is_primary_hierarchy
      comment: "Whether this is the primary hierarchy path for consolidation purposes."
    - name: "effective_from_year"
      expr: YEAR(effective_from_date)
      comment: "Year the hierarchy relationship became effective."
  measures:
    - name: "total_hierarchy_relationships"
      expr: COUNT(1)
      comment: "Total number of account hierarchy relationships. Baseline metric for corporate structure complexity."
    - name: "avg_ownership_percentage"
      expr: AVG(CAST(ownership_percentage AS DOUBLE))
      comment: "Average ownership percentage across hierarchy relationships. Tracks concentration of ownership and consolidation exposure."
    - name: "avg_voting_rights_percentage"
      expr: AVG(CAST(voting_rights_percentage AS DOUBLE))
      comment: "Average voting rights percentage. Identifies control structures that differ from economic ownership."
    - name: "majority_owned_count"
      expr: COUNT(CASE WHEN CAST(ownership_percentage AS DOUBLE) > 50 THEN 1 END)
      comment: "Number of relationships where ownership exceeds 50%. Identifies subsidiaries requiring full consolidation."
    - name: "active_hierarchy_count"
      expr: COUNT(CASE WHEN hierarchy_status = 'Active' THEN 1 END)
      comment: "Number of currently active hierarchy relationships. Defines the live corporate structure for consolidation reporting."
    - name: "unique_parent_accounts"
      expr: COUNT(DISTINCT parent_account_id)
      comment: "Number of distinct parent accounts in the hierarchy. Measures the breadth of the corporate group structure."
$$;