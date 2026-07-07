-- Metric views for domain: client | Business: Construction | Version: 2 | Generated on: 2026-06-27 01:50:09

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the client account portfolio — tracks account health, credit exposure, revenue potential, and relationship pipeline across client tiers, segments, and industry sectors."
  source: "`vibe_construction_v1`.`client`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current lifecycle status of the account (e.g. Active, Inactive, Prospect) — used to filter and segment active vs. dormant client base."
    - name: "account_type"
      expr: account_type
      comment: "Classification of the account (e.g. Owner, Developer, Government) — drives segmentation of revenue and pipeline by client category."
    - name: "client_tier"
      expr: client_tier
      comment: "Strategic tier assigned to the client (e.g. Tier 1, Tier 2, Tier 3) — used to prioritise business development effort and resource allocation."
    - name: "industry_sector"
      expr: industry_sector
      comment: "Industry sector of the client (e.g. Infrastructure, Commercial, Residential) — enables sector-level portfolio analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the account — supports geographic segmentation of the client portfolio."
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Current prequalification standing of the account — indicates readiness to bid on new work."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating assigned to the account — used to assess financial risk concentration across the portfolio."
    - name: "preferred_contract_type"
      expr: preferred_contract_type
      comment: "Client's preferred contract delivery type (e.g. Lump Sum, GMP, Cost-Plus) — informs commercial strategy."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Standard payment terms agreed with the client — relevant to cash flow and working capital planning."
    - name: "relationship_start_year"
      expr: YEAR(relationship_start_date)
      comment: "Year the client relationship commenced — enables cohort analysis of account tenure and loyalty."
    - name: "hse_compliance_required"
      expr: hse_compliance_required
      comment: "Flag indicating whether HSE compliance is mandated for this account — used to assess regulatory risk exposure."
    - name: "is_jv_entity"
      expr: is_jv_entity
      comment: "Indicates whether the account is a joint-venture entity — relevant for partnership and risk-sharing analysis."
  measures:
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total number of client accounts — baseline measure for portfolio size and growth tracking."
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Sum of declared annual revenue across all client accounts — proxy for total addressable market value within the portfolio."
    - name: "avg_annual_revenue_per_account"
      expr: AVG(CAST(annual_revenue AS DOUBLE))
      comment: "Average annual revenue per client account — indicates the typical scale of clients in the portfolio and supports tier benchmarking."
    - name: "total_credit_limit_exposure"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all accounts — measures aggregate financial exposure and informs credit risk management."
    - name: "avg_credit_limit_per_account"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account — benchmarks credit policy consistency and identifies outliers requiring review."
    - name: "active_account_count"
      expr: COUNT(CASE WHEN account_status = 'Active' THEN 1 END)
      comment: "Number of accounts with Active status — core measure of the live, revenue-generating client base."
    - name: "prequalified_account_count"
      expr: COUNT(CASE WHEN prequalification_status = 'Approved' THEN 1 END)
      comment: "Number of accounts with an approved prequalification — indicates the pool of clients eligible to receive RFPs and bid invitations."
    - name: "hse_compliant_account_count"
      expr: COUNT(CASE WHEN hse_compliance_required = TRUE THEN 1 END)
      comment: "Number of accounts requiring HSE compliance — quantifies regulatory risk exposure across the portfolio."
    - name: "jv_entity_count"
      expr: COUNT(CASE WHEN is_jv_entity = TRUE THEN 1 END)
      comment: "Number of accounts that are joint-venture entities — tracks the scale of JV partnership arrangements in the client base."
    - name: "distinct_country_count"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of distinct countries represented in the account portfolio — measures geographic diversification of the client base."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Business development pipeline KPIs — tracks opportunity volume, estimated contract value, win/loss performance, bid investment, and pipeline conversion across sectors, project types, and delivery models."
  source: "`vibe_construction_v1`.`client`.`opportunity`"
  dimensions:
    - name: "opportunity_status"
      expr: opportunity_status
      comment: "Current status of the opportunity (e.g. Open, Won, Lost, Withdrawn) — primary filter for pipeline vs. closed business analysis."
    - name: "pipeline_stage"
      expr: pipeline_stage
      comment: "Stage of the opportunity in the BD pipeline (e.g. Identify, Qualify, Bid, Award) — enables funnel analysis and stage-gate reporting."
    - name: "win_loss_outcome"
      expr: win_loss_outcome
      comment: "Final outcome of the opportunity (Win, Loss, No Bid) — used to compute win rates and analyse competitive performance."
    - name: "bid_no_bid_decision"
      expr: bid_no_bid_decision
      comment: "Decision to bid or not bid on the opportunity — tracks bid selectivity and resource allocation discipline."
    - name: "sector"
      expr: sector
      comment: "Industry sector of the opportunity (e.g. Infrastructure, Commercial, Industrial) — enables sector-level pipeline analysis."
    - name: "project_type"
      expr: project_type
      comment: "Type of construction project (e.g. New Build, Refurbishment, Civil) — supports portfolio mix analysis."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contract delivery model (e.g. Design & Build, EPC, Alliance) — informs commercial strategy and risk profiling."
    - name: "project_location_country"
      expr: project_location_country
      comment: "Country where the project is located — enables geographic pipeline analysis."
    - name: "project_location_region"
      expr: project_location_region
      comment: "Region where the project is located — supports regional business development performance tracking."
    - name: "strategic_priority"
      expr: strategic_priority
      comment: "Strategic priority classification of the opportunity — used to focus executive attention on high-priority pursuits."
    - name: "is_jv_bid"
      expr: is_jv_bid
      comment: "Indicates whether the bid is a joint-venture submission — tracks JV strategy execution."
    - name: "expected_award_year"
      expr: YEAR(expected_award_date)
      comment: "Year the award is expected — enables forward-looking pipeline scheduling and revenue forecasting."
    - name: "loss_reason"
      expr: loss_reason
      comment: "Reason for losing the opportunity — drives root-cause analysis of competitive losses."
  measures:
    - name: "total_opportunities"
      expr: COUNT(1)
      comment: "Total number of opportunities in the pipeline — baseline measure of BD activity volume."
    - name: "total_estimated_contract_value"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE))
      comment: "Sum of estimated contract values across all opportunities — measures total pipeline value available to the business."
    - name: "avg_estimated_contract_value"
      expr: AVG(CAST(estimated_contract_value AS DOUBLE))
      comment: "Average estimated contract value per opportunity — benchmarks deal size and informs resource allocation per pursuit."
    - name: "total_weighted_pipeline_value"
      expr: SUM(CAST(weighted_pipeline_value AS DOUBLE))
      comment: "Sum of probability-weighted pipeline values — risk-adjusted measure of expected revenue from the active pipeline, used in revenue forecasting."
    - name: "avg_probability_of_win_pct"
      expr: AVG(CAST(probability_of_win_pct AS DOUBLE))
      comment: "Average win probability across open opportunities — indicates overall pipeline quality and BD confidence level."
    - name: "total_bid_cost_estimate"
      expr: SUM(CAST(bid_cost_estimate AS DOUBLE))
      comment: "Total estimated cost of bidding across all opportunities — measures BD investment and supports bid cost efficiency analysis."
    - name: "won_opportunity_count"
      expr: COUNT(CASE WHEN win_loss_outcome = 'Win' THEN 1 END)
      comment: "Number of opportunities won — primary measure of BD conversion success."
    - name: "lost_opportunity_count"
      expr: COUNT(CASE WHEN win_loss_outcome = 'Loss' THEN 1 END)
      comment: "Number of opportunities lost — used alongside won count to compute win rate and analyse competitive performance."
    - name: "total_won_contract_value"
      expr: SUM(CASE WHEN win_loss_outcome = 'Win' THEN CAST(estimated_contract_value AS DOUBLE) ELSE 0 END)
      comment: "Total estimated contract value of won opportunities — measures revenue secured from BD activity."
    - name: "total_lost_contract_value"
      expr: SUM(CASE WHEN win_loss_outcome = 'Loss' THEN CAST(estimated_contract_value AS DOUBLE) ELSE 0 END)
      comment: "Total estimated contract value of lost opportunities — quantifies revenue missed and informs competitive strategy."
    - name: "jv_bid_count"
      expr: COUNT(CASE WHEN is_jv_bid = TRUE THEN 1 END)
      comment: "Number of opportunities pursued as joint-venture bids — tracks execution of JV growth strategy."
    - name: "distinct_account_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct client accounts with active opportunities — measures breadth of BD engagement across the client portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_master_services_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract portfolio KPIs for Master Services Agreements and framework contracts — tracks committed value, ceiling value, retention exposure, liquidated damages risk, and contract lifecycle health."
  source: "`vibe_construction_v1`.`client`.`master_services_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of agreement (e.g. MSA, Framework, Call-Off) — enables analysis by contract structure."
    - name: "client_framework_agreement_status"
      expr: client_framework_agreement_status
      comment: "Current status of the framework agreement (e.g. Active, Expired, Terminated) — primary filter for live vs. closed contract analysis."
    - name: "sector"
      expr: sector
      comment: "Industry sector covered by the agreement — supports sector-level contract portfolio analysis."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model specified in the agreement (e.g. EPC, Alliance, D&B) — informs commercial risk profiling."
    - name: "procurement_route"
      expr: procurement_route
      comment: "Procurement route used to award the agreement (e.g. Competitive Tender, Negotiated) — tracks procurement strategy execution."
    - name: "country_code"
      expr: country_code
      comment: "Country jurisdiction of the agreement — enables geographic contract portfolio analysis."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region covered by the agreement — supports regional revenue and risk analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the agreement — required for multi-currency portfolio analysis and FX risk assessment."
    - name: "performance_bond_required"
      expr: performance_bond_required
      comment: "Indicates whether a performance bond is required — tracks financial security obligations across the contract portfolio."
    - name: "insurance_required"
      expr: insurance_required
      comment: "Indicates whether insurance is required under the agreement — supports compliance and risk management reporting."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the agreement became effective — enables cohort analysis of contract vintage and renewal cycles."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the agreement expires — supports forward-looking contract renewal pipeline management."
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total number of master services agreements — baseline measure of the contracted client relationship portfolio."
    - name: "total_ceiling_value"
      expr: SUM(CAST(ceiling_value AS DOUBLE))
      comment: "Sum of ceiling values across all agreements — measures the maximum contracted revenue capacity available under framework arrangements."
    - name: "total_committed_value"
      expr: SUM(CAST(committed_value AS DOUBLE))
      comment: "Sum of committed values across all agreements — measures revenue already committed under active contracts, a key input to revenue backlog reporting."
    - name: "avg_committed_value_per_agreement"
      expr: AVG(CAST(committed_value AS DOUBLE))
      comment: "Average committed value per agreement — benchmarks deal size and informs contract management resource allocation."
    - name: "total_retention_exposure"
      expr: SUM(CAST(retention_percentage AS DOUBLE) * CAST(committed_value AS DOUBLE) / NULLIF(100.0, 0))
      comment: "Estimated total retention amount held across all agreements (retention % × committed value) — quantifies cash tied up in retention and informs working capital planning."
    - name: "total_liquidated_damages_rate_exposure"
      expr: SUM(CAST(liquidated_damages_rate AS DOUBLE))
      comment: "Sum of liquidated damages rates across all agreements — measures aggregate LD risk exposure in the contract portfolio."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across agreements — benchmarks retention terms and identifies portfolios with above-average cash retention risk."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN client_framework_agreement_status = 'Active' THEN 1 END)
      comment: "Number of currently active agreements — measures the live contracted client relationship base."
    - name: "performance_bond_required_count"
      expr: COUNT(CASE WHEN performance_bond_required = TRUE THEN 1 END)
      comment: "Number of agreements requiring a performance bond — tracks financial security obligations and bonding capacity requirements."
    - name: "total_max_calloff_value"
      expr: SUM(CAST(max_calloff_value AS DOUBLE))
      comment: "Sum of maximum call-off values across all framework agreements — measures the upper bound of revenue callable under framework arrangements."
    - name: "distinct_client_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct clients with active MSAs — measures the breadth of the contracted client relationship portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_prequalification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prequalification programme KPIs — tracks approval rates, scoring performance, TRIR compliance, expiry pipeline, and eligibility for RFP/RFQ across procurement categories and geographies."
  source: "`vibe_construction_v1`.`client`.`prequalification`"
  dimensions:
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Current status of the prequalification (e.g. Approved, Rejected, Pending, Expired) — primary filter for eligibility analysis."
    - name: "procurement_category"
      expr: procurement_category
      comment: "Procurement category covered by the prequalification (e.g. Civil, MEP, Fit-Out) — enables category-level supplier readiness analysis."
    - name: "work_category"
      expr: work_category
      comment: "Specific work category assessed in the prequalification — supports granular capability and eligibility tracking."
    - name: "country_code"
      expr: country_code
      comment: "Country jurisdiction of the prequalification — enables geographic analysis of supplier readiness."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope covered by the prequalification — indicates the operational reach of approved suppliers."
    - name: "rfp_eligibility_flag"
      expr: rfp_eligibility_flag
      comment: "Indicates whether the prequalification grants RFP eligibility — directly measures the pool of clients eligible to receive tender invitations."
    - name: "rfq_eligibility_flag"
      expr: rfq_eligibility_flag
      comment: "Indicates whether the prequalification grants RFQ eligibility — measures the pool eligible for quotation requests."
    - name: "hse_certification_required"
      expr: hse_certification_required
      comment: "Indicates whether HSE certification was required for this prequalification — tracks safety compliance requirements."
    - name: "renewal_required"
      expr: renewal_required
      comment: "Indicates whether the prequalification requires renewal — used to manage the renewal pipeline and avoid eligibility lapses."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the prequalification expires — enables forward-looking renewal pipeline management."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the prequalification was submitted — supports cohort analysis of prequalification activity."
  measures:
    - name: "total_prequalifications"
      expr: COUNT(1)
      comment: "Total number of prequalification records — baseline measure of prequalification programme activity."
    - name: "approved_prequalification_count"
      expr: COUNT(CASE WHEN prequalification_status = 'Approved' THEN 1 END)
      comment: "Number of approved prequalifications — measures the pool of clients cleared to receive RFPs and bid invitations."
    - name: "rejected_prequalification_count"
      expr: COUNT(CASE WHEN prequalification_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected prequalifications — used alongside approved count to compute pass rate and identify systemic qualification barriers."
    - name: "rfp_eligible_count"
      expr: COUNT(CASE WHEN rfp_eligibility_flag = TRUE THEN 1 END)
      comment: "Number of prequalifications granting RFP eligibility — measures the active tender-ready client pool."
    - name: "avg_prequalification_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average prequalification score across all submissions — benchmarks overall quality of the prequalified client base."
    - name: "avg_submitted_trir"
      expr: AVG(CAST(submitted_trir AS DOUBLE))
      comment: "Average Total Recordable Incident Rate submitted by clients — key HSE performance indicator used to assess safety culture across the client base."
    - name: "trir_non_compliant_count"
      expr: COUNT(CASE WHEN CAST(submitted_trir AS DOUBLE) > CAST(trir_threshold AS DOUBLE) THEN 1 END)
      comment: "Number of prequalifications where the submitted TRIR exceeds the threshold — identifies clients failing HSE safety benchmarks, a critical risk management metric."
    - name: "total_max_project_value_approved"
      expr: SUM(CASE WHEN prequalification_status = 'Approved' THEN CAST(max_project_value AS DOUBLE) ELSE 0 END)
      comment: "Sum of maximum project values for approved prequalifications — measures the total project value capacity of the prequalified client pool."
    - name: "avg_minimum_passing_score"
      expr: AVG(CAST(minimum_passing_score AS DOUBLE))
      comment: "Average minimum passing score threshold across prequalifications — benchmarks the stringency of qualification standards applied."
    - name: "renewal_due_count"
      expr: COUNT(CASE WHEN renewal_required = TRUE THEN 1 END)
      comment: "Number of prequalifications flagged for renewal — measures the upcoming renewal workload and risk of eligibility lapses."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_rfp_issuance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFP issuance and tender pipeline KPIs — tracks tender volume, estimated contract value, evaluation weighting, bond requirements, and submission timelines to support procurement governance and BD pipeline management."
  source: "`vibe_construction_v1`.`client`.`rfp_issuance`"
  dimensions:
    - name: "rfp_status"
      expr: rfp_status
      comment: "Current status of the RFP (e.g. Issued, Closed, Awarded, Cancelled) — primary filter for active vs. closed tender analysis."
    - name: "solicitation_type"
      expr: solicitation_type
      comment: "Type of solicitation (e.g. Open Tender, Selective Tender, Negotiated) — tracks procurement strategy and market engagement approach."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type specified in the RFP (e.g. Lump Sum, Cost-Plus, GMP) — informs commercial risk profiling of the tender pipeline."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model specified in the RFP (e.g. D&B, EPC, Traditional) — supports portfolio mix analysis."
    - name: "project_sector"
      expr: project_sector
      comment: "Sector of the project being tendered — enables sector-level tender pipeline analysis."
    - name: "client_sector"
      expr: client_sector
      comment: "Sector classification of the issuing client — supports client-type analysis of tender activity."
    - name: "country_code"
      expr: country_code
      comment: "Country where the RFP is issued — enables geographic tender pipeline analysis."
    - name: "bim_required"
      expr: bim_required
      comment: "Indicates whether BIM is required for the tender — tracks digital delivery requirements across the pipeline."
    - name: "leed_certification_required"
      expr: leed_certification_required
      comment: "Indicates whether LEED certification is required — tracks sustainability requirements in the tender pipeline."
    - name: "performance_bond_required"
      expr: performance_bond_required
      comment: "Indicates whether a performance bond is required — tracks financial security obligations in the tender pipeline."
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the RFP was issued — enables year-over-year tender volume and value trend analysis."
    - name: "leed_certification_level"
      expr: leed_certification_level
      comment: "LEED certification level required (e.g. Silver, Gold, Platinum) — tracks sustainability ambition across the tender pipeline."
  measures:
    - name: "total_rfps_issued"
      expr: COUNT(1)
      comment: "Total number of RFPs issued — baseline measure of tender pipeline activity and BD opportunity flow."
    - name: "total_estimated_contract_value"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE))
      comment: "Sum of estimated contract values across all issued RFPs — measures total tender pipeline value available for award."
    - name: "avg_estimated_contract_value"
      expr: AVG(CAST(estimated_contract_value AS DOUBLE))
      comment: "Average estimated contract value per RFP — benchmarks deal size in the tender pipeline and informs bid resource planning."
    - name: "total_bid_bond_exposure"
      expr: SUM(CAST(bid_bond_percentage AS DOUBLE) * CAST(estimated_contract_value AS DOUBLE) / NULLIF(100.0, 0))
      comment: "Estimated total bid bond value required across all RFPs (bid bond % × estimated contract value) — measures aggregate bonding capacity required to pursue the full tender pipeline."
    - name: "avg_technical_score_weight"
      expr: AVG(CAST(technical_score_weight AS DOUBLE))
      comment: "Average technical evaluation weighting across RFPs — indicates how technically demanding the tender pipeline is, informing bid strategy and resource allocation."
    - name: "avg_commercial_score_weight"
      expr: AVG(CAST(commercial_score_weight AS DOUBLE))
      comment: "Average commercial evaluation weighting across RFPs — benchmarks price competitiveness requirements across the tender pipeline."
    - name: "bim_required_rfp_count"
      expr: COUNT(CASE WHEN bim_required = TRUE THEN 1 END)
      comment: "Number of RFPs requiring BIM — tracks digital delivery mandate penetration in the tender pipeline."
    - name: "leed_required_rfp_count"
      expr: COUNT(CASE WHEN leed_certification_required = TRUE THEN 1 END)
      comment: "Number of RFPs requiring LEED certification — measures sustainability requirement prevalence in the tender pipeline."
    - name: "performance_bond_required_rfp_count"
      expr: COUNT(CASE WHEN performance_bond_required = TRUE THEN 1 END)
      comment: "Number of RFPs requiring a performance bond — quantifies bonding obligations in the active tender pipeline."
    - name: "avg_liquidated_damages_rate"
      expr: AVG(CAST(liquidated_damages_rate AS DOUBLE))
      comment: "Average liquidated damages rate across RFPs — benchmarks LD risk exposure in the tender pipeline and informs commercial risk assessment."
    - name: "avg_local_content_requirement_pct"
      expr: AVG(CAST(local_content_requirement_pct AS DOUBLE))
      comment: "Average local content requirement percentage across RFPs — tracks regulatory and client-driven local sourcing obligations in the pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client contact relationship KPIs — tracks decision-maker coverage, engagement health, communication consent, and executive sponsor presence across the client contact network."
  source: "`vibe_construction_v1`.`client`.`contact`"
  dimensions:
    - name: "contact_status"
      expr: contact_status
      comment: "Current status of the contact (e.g. Active, Inactive, Do Not Contact) — primary filter for reachable vs. dormant contacts."
    - name: "contact_type"
      expr: contact_type
      comment: "Classification of the contact (e.g. Technical, Commercial, Executive) — enables segmentation of the contact network by role type."
    - name: "job_title"
      expr: job_title
      comment: "Job title of the contact — supports seniority and role-based analysis of relationship coverage."
    - name: "department"
      expr: department
      comment: "Department of the contact within their organisation — enables analysis of relationship depth across client departments."
    - name: "decision_authority_level"
      expr: decision_authority_level
      comment: "Level of decision-making authority held by the contact — used to assess quality of relationship coverage at key decision points."
    - name: "relationship_health"
      expr: relationship_health
      comment: "Health rating of the relationship with the contact (e.g. Strong, At Risk, Weak) — key indicator for account management intervention."
    - name: "preferred_communication_channel"
      expr: preferred_communication_channel
      comment: "Contact's preferred communication channel (e.g. Email, Phone, In-Person) — informs engagement strategy."
    - name: "is_decision_maker"
      expr: is_decision_maker
      comment: "Indicates whether the contact is a decision maker — critical for assessing quality of BD relationship coverage."
    - name: "is_executive_sponsor"
      expr: is_executive_sponsor
      comment: "Indicates whether the contact is an executive sponsor — tracks senior-level relationship coverage across the client portfolio."
    - name: "data_consent_status"
      expr: data_consent_status
      comment: "Current data consent status of the contact — required for GDPR/privacy compliance reporting."
    - name: "last_activity_year"
      expr: YEAR(last_activity_date)
      comment: "Year of the most recent activity with the contact — enables recency analysis and identification of dormant relationships."
  measures:
    - name: "total_contacts"
      expr: COUNT(1)
      comment: "Total number of client contacts — baseline measure of the relationship network size."
    - name: "decision_maker_count"
      expr: COUNT(CASE WHEN is_decision_maker = TRUE THEN 1 END)
      comment: "Number of contacts identified as decision makers — measures quality of BD relationship coverage at key decision points."
    - name: "executive_sponsor_count"
      expr: COUNT(CASE WHEN is_executive_sponsor = TRUE THEN 1 END)
      comment: "Number of contacts identified as executive sponsors — tracks senior-level relationship coverage, a leading indicator of account retention and growth."
    - name: "do_not_contact_count"
      expr: COUNT(CASE WHEN do_not_contact = TRUE THEN 1 END)
      comment: "Number of contacts flagged as Do Not Contact — measures the proportion of the network that is unreachable, informing compliance and list hygiene."
    - name: "email_opt_out_count"
      expr: COUNT(CASE WHEN email_opt_out = TRUE THEN 1 END)
      comment: "Number of contacts who have opted out of email communications — tracks email reachability and consent compliance."
    - name: "active_contact_count"
      expr: COUNT(CASE WHEN contact_status = 'Active' THEN 1 END)
      comment: "Number of active contacts — measures the reachable, engageable portion of the client contact network."
    - name: "distinct_account_coverage"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct client accounts with at least one contact record — measures breadth of relationship coverage across the account portfolio."
    - name: "at_risk_relationship_count"
      expr: COUNT(CASE WHEN relationship_health = 'At Risk' THEN 1 END)
      comment: "Number of contacts with an At Risk relationship health rating — identifies relationships requiring immediate account management intervention."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client segment portfolio KPIs — tracks segment pipeline targets, revenue band sizing, win rate targets, and strategic tier distribution to support market segmentation strategy and BD resource allocation."
  source: "`vibe_construction_v1`.`client`.`segment`"
  dimensions:
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment (e.g. Active, Inactive, Under Review) — primary filter for live vs. retired segments."
    - name: "strategic_tier"
      expr: strategic_tier
      comment: "Strategic tier of the segment (e.g. Priority, Core, Opportunistic) — used to allocate BD investment and executive focus."
    - name: "sector"
      expr: sector
      comment: "Industry sector of the segment — enables sector-level portfolio strategy analysis."
    - name: "sub_sector"
      expr: sub_sector
      comment: "Sub-sector of the segment — supports granular market segmentation analysis."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the segment — enables regional strategy and resource allocation analysis."
    - name: "primary_country_code"
      expr: primary_country_code
      comment: "Primary country of the segment — supports country-level market strategy analysis."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Typical delivery model for the segment — informs commercial capability requirements."
    - name: "procurement_category"
      expr: procurement_category
      comment: "Procurement category of the segment — supports category management and supply chain strategy."
    - name: "is_global_segment"
      expr: is_global_segment
      comment: "Indicates whether the segment is a global segment — distinguishes global from regional market strategies."
    - name: "esg_focus"
      expr: esg_focus
      comment: "Indicates whether the segment has an ESG focus — tracks sustainability-driven market segments."
    - name: "effective_year"
      expr: YEAR(effective_from)
      comment: "Year the segment became effective — enables cohort analysis of segment strategy evolution."
  measures:
    - name: "total_segments"
      expr: COUNT(1)
      comment: "Total number of client segments — baseline measure of market segmentation breadth."
    - name: "total_target_pipeline_value_usd"
      expr: SUM(CAST(target_pipeline_value_usd AS DOUBLE))
      comment: "Sum of target pipeline values across all segments in USD — measures the total BD pipeline target set by the business, a key input to annual planning."
    - name: "avg_target_win_rate_pct"
      expr: AVG(CAST(target_win_rate_pct AS DOUBLE))
      comment: "Average target win rate percentage across segments — benchmarks the ambition level of the BD strategy and informs pipeline sizing requirements."
    - name: "total_revenue_band_max_usd"
      expr: SUM(CAST(revenue_band_max_usd AS DOUBLE))
      comment: "Sum of maximum revenue band values across all segments — measures the upper bound of total addressable market value across the segmented client base."
    - name: "avg_typical_project_value_max_usd"
      expr: AVG(CAST(typical_project_value_max_usd AS DOUBLE))
      comment: "Average of the maximum typical project value across segments — benchmarks deal size expectations and informs bid strategy by segment."
    - name: "active_segment_count"
      expr: COUNT(CASE WHEN segment_status = 'Active' THEN 1 END)
      comment: "Number of currently active segments — measures the live market segmentation footprint."
    - name: "esg_focused_segment_count"
      expr: COUNT(CASE WHEN esg_focus = TRUE THEN 1 END)
      comment: "Number of segments with an ESG focus — tracks the scale of sustainability-driven market strategy."
    - name: "global_segment_count"
      expr: COUNT(CASE WHEN is_global_segment = TRUE THEN 1 END)
      comment: "Number of global segments — measures the breadth of the global market strategy vs. regional focus."
    - name: "prequalification_required_segment_count"
      expr: COUNT(CASE WHEN prequalification_required = TRUE THEN 1 END)
      comment: "Number of segments requiring prequalification — tracks the proportion of the market strategy that mandates formal supplier qualification."
$$;