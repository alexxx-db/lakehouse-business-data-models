-- Metric views for domain: client | Business: Construction | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic account portfolio metrics covering client tier distribution, credit exposure, pipeline health, and relationship lifecycle. Used by BD leadership and finance to steer client investment and risk decisions."
  source: "`vibe_construction_v1`.`client`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current lifecycle status of the account (e.g. Active, Inactive, Prospect) — primary filter for portfolio health views."
    - name: "account_type"
      expr: account_type
      comment: "Classification of the account (e.g. Owner, Developer, Government) — drives segmentation of revenue and pipeline."
    - name: "client_tier"
      expr: client_tier
      comment: "Strategic tier assigned to the client (e.g. Tier 1, Tier 2) — used to prioritise BD resource allocation."
    - name: "industry_sector"
      expr: industry_sector
      comment: "Industry sector of the client — enables sector-level pipeline and revenue analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the account — supports geographic portfolio analysis."
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Current prequalification standing of the account — determines eligibility for new bid opportunities."
    - name: "preferred_contract_type"
      expr: preferred_contract_type
      comment: "Client's preferred contract delivery model — informs commercial strategy and bid structuring."
    - name: "is_jv_entity"
      expr: is_jv_entity
      comment: "Flags accounts that are joint-venture entities — used to isolate JV-specific portfolio analysis."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating band of the account — used to stratify financial risk exposure."
    - name: "relationship_start_year"
      expr: YEAR(relationship_start_date)
      comment: "Year the client relationship commenced — supports cohort and tenure analysis."
  measures:
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total number of client accounts in the portfolio. Baseline measure for portfolio size tracking."
    - name: "active_accounts"
      expr: COUNT(CASE WHEN account_status = 'Active' THEN 1 END)
      comment: "Number of currently active client accounts. Executives use this to gauge the live client base size."
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Sum of declared annual revenue across all client accounts. Proxy for total addressable market within the portfolio."
    - name: "avg_annual_revenue_per_account"
      expr: AVG(CAST(annual_revenue AS DOUBLE))
      comment: "Average annual revenue per client account. Indicates the typical scale of clients in the portfolio."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Aggregate credit limit extended across all accounts. Used by finance to monitor total credit exposure ceiling."
    - name: "avg_credit_limit_per_account"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account. Benchmarks credit generosity relative to client tier or sector."
    - name: "prequalified_accounts"
      expr: COUNT(CASE WHEN prequalification_status = 'Approved' THEN 1 END)
      comment: "Number of accounts with an approved prequalification status. Determines the pool eligible for new bid invitations."
    - name: "prequalification_expiry_within_90_days"
      expr: COUNT(CASE WHEN prequalification_expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Accounts whose prequalification expires within 90 days. Triggers renewal actions to maintain bid-eligible client pool."
    - name: "jv_entity_accounts"
      expr: COUNT(CASE WHEN is_jv_entity = TRUE THEN 1 END)
      comment: "Number of accounts flagged as JV entities. Supports JV partnership portfolio management."
    - name: "hse_compliant_accounts"
      expr: COUNT(CASE WHEN hse_compliance_required = TRUE THEN 1 END)
      comment: "Accounts requiring HSE compliance verification. Used by HSE and contract teams to manage compliance obligations."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_account_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client credit risk and exposure metrics for finance and credit management. Tracks credit utilisation, overdue balances, DSO, and sovereign risk concentration to support credit committee decisions."
  source: "`vibe_construction_v1`.`client`.`account_credit_profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the credit profile (e.g. Active, Under Review, Suspended) — primary filter for credit risk dashboards."
    - name: "client_segment"
      expr: client_segment
      comment: "Client segment associated with the credit profile — enables segment-level credit risk analysis."
    - name: "external_credit_rating"
      expr: external_credit_rating
      comment: "External credit rating (e.g. AAA, BB) — used to stratify portfolio by credit quality."
    - name: "external_rating_agency"
      expr: external_rating_agency
      comment: "Agency that issued the external credit rating — supports rating source analysis."
    - name: "payment_history_rating"
      expr: payment_history_rating
      comment: "Historical payment behaviour rating — leading indicator of future default risk."
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Flags accounts currently on credit hold — critical operational dimension for AR and project teams."
    - name: "sovereign_risk_flag"
      expr: sovereign_risk_flag
      comment: "Flags accounts with sovereign risk exposure — used by finance to monitor country-level credit concentration."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the credit profile — supports multi-currency credit exposure analysis."
    - name: "credit_review_frequency"
      expr: credit_review_frequency
      comment: "How often the credit profile is reviewed — used to ensure high-risk accounts are reviewed more frequently."
  measures:
    - name: "total_credit_limit_amount"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended across all client credit profiles. Represents the maximum financial exposure the business has approved."
    - name: "total_current_exposure"
      expr: SUM(CAST(current_exposure_amount AS DOUBLE))
      comment: "Total current outstanding exposure across all clients. Compared against credit limits to assess utilisation."
    - name: "total_overdue_balance"
      expr: SUM(CAST(overdue_balance_amount AS DOUBLE))
      comment: "Total overdue receivables across all client credit profiles. Key AR health metric for finance leadership."
    - name: "total_ld_exposure"
      expr: SUM(CAST(liquidated_damages_exposure_amount AS DOUBLE))
      comment: "Total liquidated damages exposure across all client profiles. Quantifies contractual penalty risk on the receivables book."
    - name: "avg_dso_days"
      expr: AVG(CAST(dso_days AS DOUBLE))
      comment: "Average Days Sales Outstanding across all client credit profiles. Core cash-flow efficiency KPI for the CFO."
    - name: "accounts_on_credit_hold"
      expr: COUNT(CASE WHEN credit_hold_flag = TRUE THEN 1 END)
      comment: "Number of client accounts currently on credit hold. Triggers review by credit committee and project delivery teams."
    - name: "total_credit_insurance_limit"
      expr: SUM(CAST(credit_insurance_limit_amount AS DOUBLE))
      comment: "Total credit insurance coverage in place. Measures the portion of credit exposure that is insured."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage held across client credit profiles. Informs cash-flow forecasting and contract negotiation benchmarks."
    - name: "sovereign_risk_accounts"
      expr: COUNT(CASE WHEN sovereign_risk_flag = TRUE THEN 1 END)
      comment: "Number of client profiles with sovereign risk exposure. Used by finance to monitor country-level concentration risk."
    - name: "special_payment_arrangement_accounts"
      expr: COUNT(CASE WHEN special_payment_arrangement_flag = TRUE THEN 1 END)
      comment: "Number of clients on special payment arrangements. Indicates stressed receivables requiring active management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Business development pipeline metrics covering opportunity conversion, weighted pipeline value, bid economics, and win/loss performance. Core dashboard for BD directors and C-suite pipeline reviews."
  source: "`vibe_construction_v1`.`client`.`client_opportunity`"
  dimensions:
    - name: "opportunity_status"
      expr: opportunity_status
      comment: "Current stage of the opportunity (e.g. Identified, Qualified, Bid Submitted, Won, Lost) — primary pipeline funnel dimension."
    - name: "pipeline_stage"
      expr: pipeline_stage
      comment: "Granular pipeline stage within the BD funnel — used for stage-gate conversion analysis."
    - name: "project_type"
      expr: project_type
      comment: "Type of construction project (e.g. Infrastructure, Commercial, Energy) — enables sector-level pipeline analysis."
    - name: "sector"
      expr: sector
      comment: "Industry sector of the opportunity — drives strategic sector investment decisions."
    - name: "project_location_country"
      expr: project_location_country
      comment: "Country where the project will be delivered — supports geographic pipeline distribution analysis."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contract delivery model (e.g. EPC, D&B, PPP) — informs commercial strategy and resource planning."
    - name: "bid_no_bid_decision"
      expr: bid_no_bid_decision
      comment: "Outcome of the bid/no-bid gate decision — used to analyse bid selectivity and resource efficiency."
    - name: "win_loss_outcome"
      expr: win_loss_outcome
      comment: "Final win or loss outcome of the opportunity — primary dimension for win-rate analysis."
    - name: "is_jv_bid"
      expr: is_jv_bid
      comment: "Flags opportunities pursued as a joint venture — enables JV vs. solo bid performance comparison."
    - name: "strategic_priority"
      expr: strategic_priority
      comment: "Strategic priority classification of the opportunity — ensures high-priority pursuits receive adequate resource."
    - name: "expected_award_year"
      expr: YEAR(expected_award_date)
      comment: "Year the contract award is expected — supports annual pipeline forecasting."
    - name: "bid_submission_year"
      expr: YEAR(bid_submission_date)
      comment: "Year the bid was submitted — enables year-over-year bid volume trending."
  measures:
    - name: "total_opportunities"
      expr: COUNT(1)
      comment: "Total number of opportunities in the pipeline. Baseline measure for BD activity volume."
    - name: "total_estimated_contract_value"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE))
      comment: "Sum of estimated contract values across all opportunities. Represents the gross pipeline value before probability weighting."
    - name: "total_weighted_pipeline_value"
      expr: SUM(CAST(weighted_pipeline_value AS DOUBLE))
      comment: "Sum of probability-weighted pipeline values. The primary BD KPI for forecasting expected revenue from the pipeline."
    - name: "avg_estimated_contract_value"
      expr: AVG(CAST(estimated_contract_value AS DOUBLE))
      comment: "Average estimated contract value per opportunity. Indicates the typical deal size being pursued."
    - name: "total_bid_cost"
      expr: SUM(CAST(bid_cost_estimate AS DOUBLE))
      comment: "Total estimated cost of pursuing all opportunities in the pipeline. Used to manage BD spend efficiency."
    - name: "avg_probability_of_win_pct"
      expr: AVG(CAST(probability_of_win_pct AS DOUBLE))
      comment: "Average win probability across all active opportunities. Signals overall pipeline quality and BD confidence."
    - name: "won_opportunities"
      expr: COUNT(CASE WHEN win_loss_outcome = 'Won' THEN 1 END)
      comment: "Number of opportunities converted to contract awards. Numerator for win-rate calculation."
    - name: "lost_opportunities"
      expr: COUNT(CASE WHEN win_loss_outcome = 'Lost' THEN 1 END)
      comment: "Number of opportunities lost to competitors. Used to analyse loss patterns and improve bid strategy."
    - name: "won_contract_value"
      expr: SUM(CASE WHEN win_loss_outcome = 'Won' THEN CAST(estimated_contract_value AS DOUBLE) ELSE 0 END)
      comment: "Total estimated contract value of won opportunities. Measures BD revenue conversion performance."
    - name: "lost_contract_value"
      expr: SUM(CASE WHEN win_loss_outcome = 'Lost' THEN CAST(estimated_contract_value AS DOUBLE) ELSE 0 END)
      comment: "Total estimated contract value of lost opportunities. Quantifies missed revenue and informs competitive analysis."
    - name: "jv_opportunities"
      expr: COUNT(CASE WHEN is_jv_bid = TRUE THEN 1 END)
      comment: "Number of opportunities pursued as a joint venture. Tracks JV strategy execution."
    - name: "bid_submitted_opportunities"
      expr: COUNT(CASE WHEN opportunity_status = 'Bid Submitted' THEN 1 END)
      comment: "Number of opportunities at bid-submitted stage. Indicates near-term award pipeline volume."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_prequalification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client prequalification pipeline metrics tracking approval rates, scoring performance, TRIR compliance, and expiry risk. Used by procurement and BD teams to manage the eligible bidder pool."
  source: "`vibe_construction_v1`.`client`.`client_prequalification`"
  dimensions:
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Current status of the prequalification (e.g. Approved, Rejected, Pending, Expired) — primary funnel dimension."
    - name: "work_category"
      expr: work_category
      comment: "Category of work the prequalification covers — enables category-level eligible bidder pool analysis."
    - name: "procurement_category"
      expr: procurement_category
      comment: "Procurement category associated with the prequalification — aligns with sourcing strategy."
    - name: "country_code"
      expr: country_code
      comment: "Country of the prequalification — supports geographic eligible bidder pool management."
    - name: "hse_certification_required"
      expr: hse_certification_required
      comment: "Flags prequalifications requiring HSE certification — used to track HSE compliance gate performance."
    - name: "rfp_eligibility_flag"
      expr: rfp_eligibility_flag
      comment: "Flags clients eligible to receive RFPs — directly controls bid invitation lists."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the prequalification was submitted — enables year-over-year volume trending."
    - name: "renewal_required"
      expr: renewal_required
      comment: "Flags prequalifications requiring renewal — drives renewal workflow prioritisation."
  measures:
    - name: "total_prequalifications"
      expr: COUNT(1)
      comment: "Total number of client prequalification records. Baseline measure for prequalification programme volume."
    - name: "approved_prequalifications"
      expr: COUNT(CASE WHEN prequalification_status = 'Approved' THEN 1 END)
      comment: "Number of approved prequalifications. Defines the current eligible bidder pool size."
    - name: "rejected_prequalifications"
      expr: COUNT(CASE WHEN prequalification_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected prequalifications. Used to analyse rejection rates and identify systemic barriers."
    - name: "avg_prequalification_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average prequalification score across all submissions. Benchmarks the quality of the client pool."
    - name: "avg_submitted_trir"
      expr: AVG(CAST(submitted_trir AS DOUBLE))
      comment: "Average Total Recordable Incident Rate submitted by clients. Key HSE gate metric for contractor safety performance."
    - name: "trir_non_compliant_count"
      expr: COUNT(CASE WHEN submitted_trir > trir_threshold THEN 1 END)
      comment: "Number of prequalifications where submitted TRIR exceeds the threshold. Identifies HSE-non-compliant clients in the pool."
    - name: "expiring_within_90_days"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Prequalifications expiring within 90 days. Triggers renewal actions to prevent eligible bidder pool shrinkage."
    - name: "rfp_eligible_clients"
      expr: COUNT(CASE WHEN rfp_eligibility_flag = TRUE THEN 1 END)
      comment: "Number of clients currently eligible to receive RFPs. Directly governs the competitive bidding pool."
    - name: "avg_max_project_value"
      expr: AVG(CAST(max_project_value AS DOUBLE))
      comment: "Average maximum project value clients are prequalified for. Indicates the scale of work the eligible pool can deliver."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client engagement activity metrics tracking interaction volume, executive engagement frequency, entertainment spend, and follow-up compliance. Used by BD and account management to measure relationship investment and quality."
  source: "`vibe_construction_v1`.`client`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of client interaction (e.g. Meeting, Call, Site Visit, Entertainment) — primary activity classification dimension."
    - name: "interaction_status"
      expr: interaction_status
      comment: "Status of the interaction (e.g. Completed, Planned, Cancelled) — used to filter active vs. planned engagement."
    - name: "channel"
      expr: channel
      comment: "Communication channel used (e.g. In-Person, Video, Phone) — informs channel effectiveness analysis."
    - name: "client_seniority_level"
      expr: client_seniority_level
      comment: "Seniority level of the client attendees — used to measure executive engagement depth."
    - name: "is_executive_engagement"
      expr: is_executive_engagement
      comment: "Flags interactions involving executive-level participants — key dimension for strategic relationship tracking."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the interaction (e.g. Positive, Neutral, Negative) — used to assess relationship sentiment trends."
    - name: "sentiment_indicator"
      expr: sentiment_indicator
      comment: "Sentiment signal from the interaction — leading indicator of relationship health changes."
    - name: "interaction_year"
      expr: YEAR(interaction_date)
      comment: "Year of the interaction — supports year-over-year engagement activity trending."
    - name: "interaction_month"
      expr: DATE_TRUNC('MONTH', interaction_date)
      comment: "Month of the interaction — enables monthly engagement cadence analysis."
  measures:
    - name: "total_interactions"
      expr: COUNT(1)
      comment: "Total number of client interactions logged. Baseline measure for BD and account management activity volume."
    - name: "executive_interactions"
      expr: COUNT(CASE WHEN is_executive_engagement = TRUE THEN 1 END)
      comment: "Number of interactions involving executive-level client participants. Measures strategic relationship investment."
    - name: "total_entertainment_cost"
      expr: SUM(CAST(entertainment_cost AS DOUBLE))
      comment: "Total entertainment and hospitality spend on client interactions. Monitored for compliance with gifts and hospitality policies."
    - name: "avg_entertainment_cost_per_interaction"
      expr: AVG(CAST(entertainment_cost AS DOUBLE))
      comment: "Average entertainment cost per interaction. Benchmarks hospitality spend efficiency and policy compliance."
    - name: "interactions_with_open_followup"
      expr: COUNT(CASE WHEN followup_completed = FALSE AND followup_due_date < CURRENT_DATE THEN 1 END)
      comment: "Interactions with overdue follow-up actions. Measures BD team responsiveness and action closure discipline."
    - name: "unique_accounts_engaged"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct client accounts engaged. Measures breadth of active client relationship coverage."
    - name: "unique_contacts_engaged"
      expr: COUNT(DISTINCT contact_id)
      comment: "Number of distinct client contacts engaged. Measures depth of relationship penetration within client organisations."
    - name: "hospitality_declared_interactions"
      expr: COUNT(CASE WHEN gifts_hospitality_declared = TRUE THEN 1 END)
      comment: "Number of interactions where gifts or hospitality were declared. Supports anti-bribery compliance monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_jv_structure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Joint venture portfolio metrics tracking capital commitments, equity distribution, and JV lifecycle status. Used by corporate development and finance to manage JV risk and governance."
  source: "`vibe_construction_v1`.`client`.`jv_structure`"
  dimensions:
    - name: "jv_status"
      expr: jv_status
      comment: "Current status of the JV (e.g. Active, Dissolved, In Formation) — primary JV lifecycle dimension."
    - name: "jv_type"
      expr: jv_type
      comment: "Type of JV structure (e.g. Incorporated, Unincorporated, Consortium) — informs governance and liability analysis."
    - name: "project_sector"
      expr: project_sector
      comment: "Sector of the JV project — enables sector-level JV portfolio analysis."
    - name: "country_of_operation"
      expr: country_of_operation
      comment: "Country where the JV operates — supports geographic JV risk concentration analysis."
    - name: "is_lead_sponsor_internal"
      expr: is_lead_sponsor_internal
      comment: "Flags JVs where the internal entity is the lead sponsor — distinguishes lead vs. minority JV positions."
    - name: "liability_structure"
      expr: liability_structure
      comment: "Liability structure of the JV (e.g. Joint and Several, Several Only) — critical for risk quantification."
    - name: "formation_year"
      expr: YEAR(formation_date)
      comment: "Year the JV was formed — supports vintage analysis of the JV portfolio."
    - name: "is_active"
      expr: is_active
      comment: "Flags currently active JV structures — primary filter for live JV portfolio views."
  measures:
    - name: "total_jv_structures"
      expr: COUNT(1)
      comment: "Total number of JV structures in the portfolio. Baseline measure for JV programme scale."
    - name: "active_jv_structures"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active JV structures. Measures the live JV portfolio requiring active governance."
    - name: "total_committed_capital"
      expr: SUM(CAST(total_committed_capital AS DOUBLE))
      comment: "Total capital committed across all JV structures. Measures the aggregate financial exposure in the JV portfolio."
    - name: "avg_total_equity_pct"
      expr: AVG(CAST(total_equity_pct AS DOUBLE))
      comment: "Average total equity percentage held across JV structures. Benchmarks the typical ownership position in JV arrangements."
    - name: "lead_sponsor_jvs"
      expr: COUNT(CASE WHEN is_lead_sponsor_internal = TRUE THEN 1 END)
      comment: "Number of JVs where the internal entity is the lead sponsor. Measures leadership position in the JV portfolio."
    - name: "unique_jv_partners"
      expr: COUNT(DISTINCT primary_jv_account_id)
      comment: "Number of distinct JV partner accounts. Measures the breadth of the JV partnership network."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_project_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client project engagement metrics covering contract value, satisfaction, retention, and relationship health across active project deliveries. Used by account managers and project directors to manage client relationships."
  source: "`vibe_construction_v1`.`client`.`project_engagement`"
  dimensions:
    - name: "engagement_status"
      expr: engagement_status
      comment: "Current status of the project engagement (e.g. Active, Completed, Terminated) — primary lifecycle dimension."
    - name: "engagement_type"
      expr: engagement_type
      comment: "Type of engagement (e.g. EPC, PMC, Advisory) — enables delivery model performance comparison."
    - name: "sector"
      expr: sector
      comment: "Industry sector of the engagement — supports sector-level client satisfaction and revenue analysis."
    - name: "client_role"
      expr: client_role
      comment: "Role of the client in the engagement (e.g. Owner, Developer, Funder) — informs relationship management strategy."
    - name: "relationship_tier"
      expr: relationship_tier
      comment: "Tier of the client relationship — used to prioritise account management resources."
    - name: "repeat_client"
      expr: repeat_client
      comment: "Flags engagements with repeat clients — key indicator of client loyalty and relationship strength."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current dispute status on the engagement — used to identify at-risk relationships requiring intervention."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of project funding (e.g. Government, Private, Multilateral) — informs payment risk and commercial strategy."
    - name: "engagement_start_year"
      expr: YEAR(engagement_start_date)
      comment: "Year the engagement commenced — supports cohort and vintage analysis of the project portfolio."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method used (e.g. Competitive Tender, Negotiated) — enables procurement route performance analysis."
  measures:
    - name: "total_engagements"
      expr: COUNT(1)
      comment: "Total number of client project engagements. Baseline measure for portfolio breadth."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contracted value across all client project engagements. Primary revenue backlog measure for executive reporting."
    - name: "total_approved_variation_value"
      expr: SUM(CAST(approved_variation_value AS DOUBLE))
      comment: "Total value of approved contract variations. Measures scope growth and commercial management effectiveness."
    - name: "avg_satisfaction_score"
      expr: AVG(CAST(satisfaction_score AS DOUBLE))
      comment: "Average client satisfaction score across all engagements. Core client relationship health KPI for account management."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage held across engagements. Impacts cash-flow forecasting and working capital management."
    - name: "total_advance_payment"
      expr: SUM(CAST(advance_payment_amount AS DOUBLE))
      comment: "Total advance payments received across all engagements. Tracks mobilisation funding and advance recovery obligations."
    - name: "repeat_client_engagements"
      expr: COUNT(CASE WHEN repeat_client = TRUE THEN 1 END)
      comment: "Number of engagements with repeat clients. Measures client loyalty and the effectiveness of relationship management."
    - name: "engagements_in_dispute"
      expr: COUNT(CASE WHEN dispute_status IS NOT NULL AND dispute_status != 'None' THEN 1 END)
      comment: "Number of engagements with an active dispute. Flags relationship risk and potential revenue at risk."
    - name: "avg_jv_participation_pct"
      expr: AVG(CAST(jv_participation_percentage AS DOUBLE))
      comment: "Average JV participation percentage across JV engagements. Informs JV equity and profit-sharing analysis."
    - name: "avg_liquidated_damages_rate"
      expr: AVG(CAST(liquidated_damages_rate AS DOUBLE))
      comment: "Average liquidated damages rate across engagements. Benchmarks contractual penalty exposure in the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_rfp_issuance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFP pipeline metrics tracking issuance volume, estimated contract values, bid bond requirements, and evaluation weighting. Used by BD and procurement leadership to manage the competitive tender pipeline."
  source: "`vibe_construction_v1`.`client`.`rfp_issuance`"
  dimensions:
    - name: "rfp_status"
      expr: rfp_status
      comment: "Current status of the RFP (e.g. Issued, Closed, Awarded, Cancelled) — primary pipeline stage dimension."
    - name: "solicitation_type"
      expr: solicitation_type
      comment: "Type of solicitation (e.g. Open Tender, Selective Tender, Negotiated) — informs procurement route analysis."
    - name: "project_sector"
      expr: project_sector
      comment: "Sector of the project being tendered — enables sector-level tender pipeline analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type for the RFP (e.g. Lump Sum, Reimbursable, GMP) — informs commercial risk analysis."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model for the tendered project — supports delivery model performance benchmarking."
    - name: "country_code"
      expr: country_code
      comment: "Country where the RFP was issued — supports geographic tender pipeline analysis."
    - name: "leed_certification_required"
      expr: leed_certification_required
      comment: "Flags RFPs requiring LEED certification — tracks sustainability requirements in the tender pipeline."
    - name: "performance_bond_required"
      expr: performance_bond_required
      comment: "Flags RFPs requiring a performance bond — informs bonding capacity planning."
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the RFP was issued — supports year-over-year tender volume trending."
  measures:
    - name: "total_rfps_issued"
      expr: COUNT(1)
      comment: "Total number of RFPs issued. Baseline measure for tender pipeline activity volume."
    - name: "total_estimated_contract_value"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE))
      comment: "Total estimated contract value across all issued RFPs. Represents the gross tender pipeline value."
    - name: "avg_estimated_contract_value"
      expr: AVG(CAST(estimated_contract_value AS DOUBLE))
      comment: "Average estimated contract value per RFP. Benchmarks typical deal size in the tender pipeline."
    - name: "rfps_requiring_bid_bond"
      expr: COUNT(CASE WHEN bid_bond_required = TRUE THEN 1 END)
      comment: "Number of RFPs requiring a bid bond. Informs bonding capacity and cash management planning."
    - name: "rfps_requiring_performance_bond"
      expr: COUNT(CASE WHEN performance_bond_required = TRUE THEN 1 END)
      comment: "Number of RFPs requiring a performance bond. Tracks bonding obligations in the tender pipeline."
    - name: "avg_technical_score_weight"
      expr: AVG(CAST(technical_score_weight AS DOUBLE))
      comment: "Average technical evaluation weighting across RFPs. Indicates how technically demanding the tender pipeline is."
    - name: "avg_commercial_score_weight"
      expr: AVG(CAST(commercial_score_weight AS DOUBLE))
      comment: "Average commercial evaluation weighting across RFPs. Benchmarks price competitiveness requirements in the pipeline."
    - name: "avg_local_content_requirement_pct"
      expr: AVG(CAST(local_content_requirement_pct AS DOUBLE))
      comment: "Average local content requirement percentage across RFPs. Informs local subcontracting and workforce planning."
    - name: "rfps_with_ld_applicable"
      expr: COUNT(CASE WHEN liquidated_damages_applicable = TRUE THEN 1 END)
      comment: "Number of RFPs with liquidated damages clauses. Quantifies contractual penalty risk in the tender pipeline."
    - name: "total_ld_rate_exposure"
      expr: SUM(CAST(liquidated_damages_rate AS DOUBLE))
      comment: "Sum of liquidated damages rates across all RFPs. Aggregated proxy for contractual penalty exposure in the pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client segment strategy metrics tracking pipeline targets, win rate targets, and revenue band configuration. Used by BD strategy and marketing leadership to evaluate segment investment and performance."
  source: "`vibe_construction_v1`.`client`.`segment`"
  dimensions:
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment definition (e.g. Active, Archived) — primary filter for live segment analysis."
    - name: "sector"
      expr: sector
      comment: "Industry sector of the segment — enables sector-level strategic portfolio analysis."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the segment — supports regional BD strategy analysis."
    - name: "strategic_tier"
      expr: strategic_tier
      comment: "Strategic tier of the segment (e.g. Priority, Core, Opportunistic) — drives resource allocation decisions."
    - name: "is_global_segment"
      expr: is_global_segment
      comment: "Flags globally managed segments — distinguishes global vs. regional segment strategies."
    - name: "esg_focus"
      expr: esg_focus
      comment: "Flags segments with an ESG focus — tracks sustainability-driven market strategy."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Typical delivery model for the segment — informs commercial capability requirements."
  measures:
    - name: "total_segments"
      expr: COUNT(1)
      comment: "Total number of defined client segments. Baseline measure for market segmentation coverage."
    - name: "total_target_pipeline_value"
      expr: SUM(CAST(target_pipeline_value_usd AS DOUBLE))
      comment: "Total target pipeline value across all segments. Represents the aggregate BD pipeline ambition for the business."
    - name: "avg_target_win_rate_pct"
      expr: AVG(CAST(target_win_rate_pct AS DOUBLE))
      comment: "Average target win rate across all segments. Benchmarks the expected conversion performance for BD planning."
    - name: "total_revenue_band_max"
      expr: SUM(CAST(revenue_band_max_usd AS DOUBLE))
      comment: "Sum of maximum revenue band thresholds across segments. Represents the upper bound of the total addressable market across all segments."
    - name: "avg_typical_project_value_max"
      expr: AVG(CAST(typical_project_value_max_usd AS DOUBLE))
      comment: "Average maximum typical project value across segments. Informs deal-size expectations for BD resource planning."
    - name: "priority_segments"
      expr: COUNT(CASE WHEN strategic_tier = 'Priority' THEN 1 END)
      comment: "Number of segments classified as strategic priority. Ensures BD investment is concentrated on highest-value markets."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client satisfaction and relationship health metrics derived from project surveys. Used by account management and executive leadership to monitor NPS trends, satisfaction drivers, and escalation risk."
  source: "`vibe_construction_v1`.`client`.`survey`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Type of survey (e.g. Project Completion, Mid-Project, Annual Relationship) — primary survey classification dimension."
    - name: "survey_status"
      expr: survey_status
      comment: "Current status of the survey (e.g. Sent, Completed, Overdue) — used to track response completion."
    - name: "nps_category"
      expr: nps_category
      comment: "NPS category (Promoter, Passive, Detractor) — primary dimension for loyalty segmentation analysis."
    - name: "relationship_risk_level"
      expr: relationship_risk_level
      comment: "Risk level of the client relationship based on survey responses — triggers account management interventions."
    - name: "client_sector"
      expr: client_sector
      comment: "Sector of the client — enables sector-level satisfaction benchmarking."
    - name: "respondent_role"
      expr: respondent_role
      comment: "Role of the survey respondent — used to weight feedback by decision-maker seniority."
    - name: "repeat_client_flag"
      expr: repeat_client_flag
      comment: "Flags surveys from repeat clients — enables loyalty cohort satisfaction comparison."
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Flags surveys requiring escalation — drives urgent account management actions."
    - name: "administration_year"
      expr: YEAR(administration_date)
      comment: "Year the survey was administered — supports year-over-year satisfaction trending."
    - name: "project_milestone"
      expr: project_milestone
      comment: "Project milestone at which the survey was administered — enables milestone-specific satisfaction analysis."
  measures:
    - name: "total_surveys"
      expr: COUNT(1)
      comment: "Total number of surveys administered. Baseline measure for client feedback programme coverage."
    - name: "completed_surveys"
      expr: COUNT(CASE WHEN survey_status = 'Completed' THEN 1 END)
      comment: "Number of completed surveys. Numerator for response rate calculation."
    - name: "avg_overall_satisfaction_score"
      expr: AVG(CAST(overall_satisfaction_score AS DOUBLE))
      comment: "Average overall client satisfaction score. Primary client experience KPI for executive reporting and QBRs."
    - name: "avg_relationship_health_score"
      expr: AVG(CAST(relationship_health_score AS DOUBLE))
      comment: "Average relationship health score. Leading indicator of client retention and repeat business probability."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score from client surveys. Measures client perception of construction quality delivery."
    - name: "avg_schedule_score"
      expr: AVG(CAST(schedule_score AS DOUBLE))
      comment: "Average schedule performance score from client surveys. Measures client perception of on-time delivery."
    - name: "avg_safety_score"
      expr: AVG(CAST(safety_score AS DOUBLE))
      comment: "Average safety score from client surveys. Measures client perception of HSE performance on their projects."
    - name: "avg_cost_management_score"
      expr: AVG(CAST(cost_management_score AS DOUBLE))
      comment: "Average cost management score from client surveys. Measures client perception of budget control and commercial management."
    - name: "avg_communication_score"
      expr: AVG(CAST(communication_score AS DOUBLE))
      comment: "Average communication score from client surveys. Measures client satisfaction with reporting and stakeholder engagement."
    - name: "surveys_requiring_escalation"
      expr: COUNT(CASE WHEN escalation_required_flag = TRUE THEN 1 END)
      comment: "Number of surveys flagged for escalation. Identifies at-risk client relationships requiring immediate executive intervention."
    - name: "promoter_surveys"
      expr: COUNT(CASE WHEN nps_category = 'Promoter' THEN 1 END)
      comment: "Number of surveys from NPS Promoters. Numerator for net promoter score calculation and loyalty analysis."
    - name: "detractor_surveys"
      expr: COUNT(CASE WHEN nps_category = 'Detractor' THEN 1 END)
      comment: "Number of surveys from NPS Detractors. Identifies clients at highest risk of churn or reputational damage."
$$;
