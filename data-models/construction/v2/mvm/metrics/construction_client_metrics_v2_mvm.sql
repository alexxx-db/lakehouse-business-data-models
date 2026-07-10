-- Metric views for domain: client | Business: Construction | Version: 2 | Generated on: 2026-07-10 14:32:32

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core client account metrics tracking revenue, credit exposure, and account portfolio composition"
  source: "`vibe_construction_v1`.`client`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the client account (active, inactive, suspended)"
    - name: "account_type"
      expr: account_type
      comment: "Classification of account type (e.g., general contractor, owner, subcontractor)"
    - name: "client_tier"
      expr: client_tier
      comment: "Strategic tier classification of the client (Tier 1, Tier 2, Tier 3)"
    - name: "country_code"
      expr: country_code
      comment: "Country where the client account is registered"
    - name: "industry_sector"
      expr: industry_sector
      comment: "Industry sector of the client (commercial, residential, infrastructure, industrial)"
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating assigned to the account"
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Current prequalification status of the account"
    - name: "bim_requirement_level"
      expr: bim_requirement_level
      comment: "BIM capability requirement level for this client"
    - name: "hse_compliance_required"
      expr: hse_compliance_required
      comment: "Whether HSE compliance is required for this client"
    - name: "leed_certification_required"
      expr: leed_certification_required
      comment: "Whether LEED certification is required for projects with this client"
    - name: "preferred_contract_type"
      expr: preferred_contract_type
      comment: "Preferred contract type for this client (lump sum, cost plus, unit price)"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Standard payment terms for the client"
    - name: "currency_code"
      expr: currency_code
      comment: "Primary currency for transactions with this client"
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year the account was created"
    - name: "relationship_tenure_years"
      expr: CASE WHEN relationship_start_date IS NOT NULL THEN FLOOR(DATEDIFF(CURRENT_DATE(), relationship_start_date) / 365.25) ELSE NULL END
      comment: "Number of complete years in the client relationship"
  measures:
    - name: "total_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Total number of unique client accounts"
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Sum of annual revenue across all client accounts"
    - name: "avg_annual_revenue"
      expr: AVG(CAST(annual_revenue AS DOUBLE))
      comment: "Average annual revenue per client account"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all client accounts"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per client account"
    - name: "accounts_with_active_projects"
      expr: COUNT(DISTINCT CASE WHEN last_project_award_date IS NOT NULL THEN account_id END)
      comment: "Number of accounts that have been awarded at least one project"
    - name: "accounts_requiring_hse"
      expr: COUNT(DISTINCT CASE WHEN hse_compliance_required = TRUE THEN account_id END)
      comment: "Number of accounts requiring HSE compliance"
    - name: "accounts_requiring_leed"
      expr: COUNT(DISTINCT CASE WHEN leed_certification_required = TRUE THEN account_id END)
      comment: "Number of accounts requiring LEED certification"
    - name: "accounts_do_not_contact"
      expr: COUNT(DISTINCT CASE WHEN do_not_contact = TRUE THEN account_id END)
      comment: "Number of accounts marked as do not contact"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_account_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk and payment performance metrics for client accounts"
  source: "`vibe_construction_v1`.`client`.`account_credit_profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the credit profile"
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Whether the account is currently on credit hold"
    - name: "external_credit_rating"
      expr: external_credit_rating
      comment: "External credit rating from rating agency"
    - name: "internal_credit_score"
      expr: internal_credit_score
      comment: "Internal credit score classification"
    - name: "payment_history_rating"
      expr: payment_history_rating
      comment: "Rating based on historical payment performance"
    - name: "client_segment"
      expr: client_segment
      comment: "Client segment classification"
    - name: "credit_insurance_flag"
      expr: credit_insurance_flag
      comment: "Whether credit insurance is in place for this account"
    - name: "sovereign_risk_flag"
      expr: sovereign_risk_flag
      comment: "Whether sovereign risk applies to this account"
    - name: "special_payment_arrangement_flag"
      expr: special_payment_arrangement_flag
      comment: "Whether special payment arrangements are in place"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for credit limits and exposures"
    - name: "credit_review_frequency"
      expr: credit_review_frequency
      comment: "Frequency of credit reviews for this account"
  measures:
    - name: "total_credit_profiles"
      expr: COUNT(DISTINCT account_credit_profile_id)
      comment: "Total number of credit profiles"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit across all profiles"
    - name: "total_current_exposure"
      expr: SUM(CAST(current_exposure_amount AS DOUBLE))
      comment: "Total current credit exposure across all accounts"
    - name: "total_overdue_balance"
      expr: SUM(CAST(overdue_balance_amount AS DOUBLE))
      comment: "Total overdue balance across all accounts"
    - name: "total_liquidated_damages_exposure"
      expr: SUM(CAST(liquidated_damages_exposure_amount AS DOUBLE))
      comment: "Total liquidated damages exposure across all accounts"
    - name: "avg_dso_days"
      expr: AVG(CAST(dso_days AS DOUBLE))
      comment: "Average days sales outstanding across all accounts"
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage held across accounts"
    - name: "accounts_on_credit_hold"
      expr: COUNT(DISTINCT CASE WHEN credit_hold_flag = TRUE THEN account_credit_profile_id END)
      comment: "Number of accounts currently on credit hold"
    - name: "accounts_with_credit_insurance"
      expr: COUNT(DISTINCT CASE WHEN credit_insurance_flag = TRUE THEN account_credit_profile_id END)
      comment: "Number of accounts with credit insurance coverage"
    - name: "total_credit_insurance_limit"
      expr: SUM(CAST(credit_insurance_limit_amount AS DOUBLE))
      comment: "Total credit insurance limit coverage across insured accounts"
    - name: "accounts_with_overdue_balance"
      expr: COUNT(DISTINCT CASE WHEN overdue_balance_amount > 0 THEN account_credit_profile_id END)
      comment: "Number of accounts with overdue balances"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales pipeline and opportunity conversion metrics for construction projects"
  source: "`vibe_construction_v1`.`client`.`client_opportunity`"
  dimensions:
    - name: "opportunity_status"
      expr: opportunity_status
      comment: "Current status of the opportunity"
    - name: "pipeline_stage"
      expr: pipeline_stage
      comment: "Current stage in the sales pipeline"
    - name: "win_loss_outcome"
      expr: win_loss_outcome
      comment: "Final outcome of the opportunity (won, lost, pending)"
    - name: "bid_no_bid_decision"
      expr: bid_no_bid_decision
      comment: "Decision whether to bid on the opportunity"
    - name: "sector"
      expr: sector
      comment: "Construction sector of the opportunity"
    - name: "project_type"
      expr: project_type
      comment: "Type of construction project"
    - name: "delivery_model"
      expr: delivery_model
      comment: "Project delivery model (design-build, design-bid-build, etc.)"
    - name: "project_location_country"
      expr: project_location_country
      comment: "Country where the project is located"
    - name: "project_location_region"
      expr: project_location_region
      comment: "Region where the project is located"
    - name: "strategic_priority"
      expr: strategic_priority
      comment: "Strategic priority level of the opportunity"
    - name: "is_jv_bid"
      expr: is_jv_bid
      comment: "Whether the bid is a joint venture"
    - name: "bim_required"
      expr: bim_required
      comment: "Whether BIM is required for the project"
    - name: "leed_certification_required"
      expr: leed_certification_required
      comment: "Whether LEED certification is required"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for opportunity value"
    - name: "expected_award_year"
      expr: YEAR(expected_award_date)
      comment: "Year the opportunity is expected to be awarded"
    - name: "expected_award_quarter"
      expr: CONCAT('Q', QUARTER(expected_award_date), '-', YEAR(expected_award_date))
      comment: "Quarter and year the opportunity is expected to be awarded"
  measures:
    - name: "total_opportunities"
      expr: COUNT(DISTINCT client_opportunity_id)
      comment: "Total number of opportunities in the pipeline"
    - name: "total_pipeline_value"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE))
      comment: "Total estimated contract value of all opportunities"
    - name: "total_weighted_pipeline_value"
      expr: SUM(CAST(weighted_pipeline_value AS DOUBLE))
      comment: "Total weighted pipeline value (probability-adjusted)"
    - name: "avg_opportunity_value"
      expr: AVG(CAST(estimated_contract_value AS DOUBLE))
      comment: "Average estimated contract value per opportunity"
    - name: "avg_probability_of_win"
      expr: AVG(CAST(probability_of_win_pct AS DOUBLE))
      comment: "Average probability of win percentage across opportunities"
    - name: "total_bid_cost_estimate"
      expr: SUM(CAST(bid_cost_estimate AS DOUBLE))
      comment: "Total estimated cost to prepare all bids"
    - name: "opportunities_won"
      expr: COUNT(DISTINCT CASE WHEN win_loss_outcome = 'Won' THEN client_opportunity_id END)
      comment: "Number of opportunities won"
    - name: "opportunities_lost"
      expr: COUNT(DISTINCT CASE WHEN win_loss_outcome = 'Lost' THEN client_opportunity_id END)
      comment: "Number of opportunities lost"
    - name: "opportunities_bid_decision"
      expr: COUNT(DISTINCT CASE WHEN bid_no_bid_decision = 'Bid' THEN client_opportunity_id END)
      comment: "Number of opportunities where decision was made to bid"
    - name: "opportunities_no_bid_decision"
      expr: COUNT(DISTINCT CASE WHEN bid_no_bid_decision = 'No Bid' THEN client_opportunity_id END)
      comment: "Number of opportunities where decision was made not to bid"
    - name: "jv_opportunities"
      expr: COUNT(DISTINCT CASE WHEN is_jv_bid = TRUE THEN client_opportunity_id END)
      comment: "Number of opportunities being pursued as joint ventures"
    - name: "bim_required_opportunities"
      expr: COUNT(DISTINCT CASE WHEN bim_required = TRUE THEN client_opportunity_id END)
      comment: "Number of opportunities requiring BIM"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client contact engagement and relationship health metrics"
  source: "`vibe_construction_v1`.`client`.`contact`"
  dimensions:
    - name: "contact_status"
      expr: contact_status
      comment: "Current status of the contact"
    - name: "contact_type"
      expr: contact_type
      comment: "Type or role classification of the contact"
    - name: "job_title"
      expr: job_title
      comment: "Job title of the contact"
    - name: "department"
      expr: department
      comment: "Department where the contact works"
    - name: "is_decision_maker"
      expr: is_decision_maker
      comment: "Whether the contact is a decision maker"
    - name: "is_executive_sponsor"
      expr: is_executive_sponsor
      comment: "Whether the contact is an executive sponsor"
    - name: "decision_authority_level"
      expr: decision_authority_level
      comment: "Level of decision-making authority"
    - name: "influence_score"
      expr: influence_score
      comment: "Influence score of the contact within their organization"
    - name: "relationship_health"
      expr: relationship_health
      comment: "Health status of the relationship with this contact"
    - name: "client_segment"
      expr: client_segment
      comment: "Client segment classification"
    - name: "preferred_communication_channel"
      expr: preferred_communication_channel
      comment: "Preferred channel for communication"
    - name: "do_not_contact"
      expr: do_not_contact
      comment: "Whether the contact should not be contacted"
    - name: "email_opt_out"
      expr: email_opt_out
      comment: "Whether the contact has opted out of email"
    - name: "data_consent_status"
      expr: data_consent_status
      comment: "Status of data consent from the contact"
  measures:
    - name: "total_contacts"
      expr: COUNT(DISTINCT contact_id)
      comment: "Total number of client contacts"
    - name: "decision_maker_contacts"
      expr: COUNT(DISTINCT CASE WHEN is_decision_maker = TRUE THEN contact_id END)
      comment: "Number of contacts who are decision makers"
    - name: "executive_sponsor_contacts"
      expr: COUNT(DISTINCT CASE WHEN is_executive_sponsor = TRUE THEN contact_id END)
      comment: "Number of contacts who are executive sponsors"
    - name: "primary_contacts"
      expr: COUNT(DISTINCT CASE WHEN is_primary_contact = TRUE THEN contact_id END)
      comment: "Number of contacts designated as primary"
    - name: "contacts_do_not_contact"
      expr: COUNT(DISTINCT CASE WHEN do_not_contact = TRUE THEN contact_id END)
      comment: "Number of contacts marked as do not contact"
    - name: "contacts_email_opt_out"
      expr: COUNT(DISTINCT CASE WHEN email_opt_out = TRUE THEN contact_id END)
      comment: "Number of contacts who have opted out of email"
    - name: "contacts_with_recent_activity"
      expr: COUNT(DISTINCT CASE WHEN last_activity_date >= DATE_SUB(CURRENT_DATE(), 90) THEN contact_id END)
      comment: "Number of contacts with activity in the last 90 days"
    - name: "contacts_with_recent_meeting"
      expr: COUNT(DISTINCT CASE WHEN last_meeting_date >= DATE_SUB(CURRENT_DATE(), 90) THEN contact_id END)
      comment: "Number of contacts with a meeting in the last 90 days"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client engagement activity and relationship development metrics"
  source: "`vibe_construction_v1`.`client`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of interaction (meeting, call, email, site visit)"
    - name: "interaction_status"
      expr: interaction_status
      comment: "Status of the interaction"
    - name: "channel"
      expr: channel
      comment: "Communication channel used for the interaction"
    - name: "purpose"
      expr: purpose
      comment: "Purpose of the interaction"
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the interaction"
    - name: "sentiment_indicator"
      expr: sentiment_indicator
      comment: "Sentiment indicator from the interaction (positive, neutral, negative)"
    - name: "is_executive_engagement"
      expr: is_executive_engagement
      comment: "Whether the interaction involved executive-level engagement"
    - name: "client_seniority_level"
      expr: client_seniority_level
      comment: "Seniority level of client participants"
    - name: "followup_completed"
      expr: followup_completed
      comment: "Whether follow-up actions have been completed"
    - name: "is_billable"
      expr: is_billable
      comment: "Whether the interaction is billable"
    - name: "gifts_hospitality_declared"
      expr: gifts_hospitality_declared
      comment: "Whether gifts or hospitality were declared"
    - name: "interaction_year"
      expr: YEAR(interaction_date)
      comment: "Year of the interaction"
    - name: "interaction_quarter"
      expr: CONCAT('Q', QUARTER(interaction_date), '-', YEAR(interaction_date))
      comment: "Quarter and year of the interaction"
    - name: "interaction_month"
      expr: DATE_TRUNC('MONTH', interaction_date)
      comment: "Month of the interaction"
  measures:
    - name: "total_interactions"
      expr: COUNT(DISTINCT interaction_id)
      comment: "Total number of client interactions"
    - name: "total_interaction_duration_hours"
      expr: SUM(CAST(duration_minutes AS DOUBLE)) / 60.0
      comment: "Total duration of all interactions in hours"
    - name: "avg_interaction_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration of interactions in minutes"
    - name: "total_entertainment_cost"
      expr: SUM(CAST(entertainment_cost AS DOUBLE))
      comment: "Total cost of entertainment and hospitality across interactions"
    - name: "avg_entertainment_cost"
      expr: AVG(CAST(entertainment_cost AS DOUBLE))
      comment: "Average entertainment cost per interaction"
    - name: "executive_engagements"
      expr: COUNT(DISTINCT CASE WHEN is_executive_engagement = TRUE THEN interaction_id END)
      comment: "Number of interactions involving executive-level engagement"
    - name: "billable_interactions"
      expr: COUNT(DISTINCT CASE WHEN is_billable = TRUE THEN interaction_id END)
      comment: "Number of billable interactions"
    - name: "interactions_with_followup_pending"
      expr: COUNT(DISTINCT CASE WHEN followup_completed = FALSE AND followup_due_date IS NOT NULL THEN interaction_id END)
      comment: "Number of interactions with pending follow-up actions"
    - name: "interactions_with_gifts_declared"
      expr: COUNT(DISTINCT CASE WHEN gifts_hospitality_declared = TRUE THEN interaction_id END)
      comment: "Number of interactions with declared gifts or hospitality"
    - name: "unique_accounts_engaged"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique client accounts engaged"
    - name: "unique_contacts_engaged"
      expr: COUNT(DISTINCT contact_id)
      comment: "Number of unique contacts engaged"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_prequalification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client prequalification performance and compliance metrics"
  source: "`vibe_construction_v1`.`client`.`prequalification`"
  dimensions:
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Current status of the prequalification"
    - name: "work_category"
      expr: work_category
      comment: "Category of work for which prequalification applies"
    - name: "procurement_category"
      expr: procurement_category
      comment: "Procurement category classification"
    - name: "contract_delivery_method"
      expr: contract_delivery_method
      comment: "Contract delivery method for prequalification"
    - name: "country_code"
      expr: country_code
      comment: "Country where prequalification applies"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the prequalification"
    - name: "hse_certification_required"
      expr: hse_certification_required
      comment: "Whether HSE certification is required"
    - name: "quality_certification_required"
      expr: quality_certification_required
      comment: "Whether quality certification is required"
    - name: "environmental_certification_required"
      expr: environmental_certification_required
      comment: "Whether environmental certification is required"
    - name: "leed_certification_required"
      expr: leed_certification_required
      comment: "Whether LEED certification is required"
    - name: "financial_audit_required"
      expr: financial_audit_required
      comment: "Whether financial audit is required"
    - name: "insurance_verification_required"
      expr: insurance_verification_required
      comment: "Whether insurance verification is required"
    - name: "rfp_eligibility_flag"
      expr: rfp_eligibility_flag
      comment: "Whether prequalification grants RFP eligibility"
    - name: "rfq_eligibility_flag"
      expr: rfq_eligibility_flag
      comment: "Whether prequalification grants RFQ eligibility"
    - name: "renewal_required"
      expr: renewal_required
      comment: "Whether renewal is required"
  measures:
    - name: "total_prequalifications"
      expr: COUNT(DISTINCT prequalification_id)
      comment: "Total number of prequalification records"
    - name: "active_prequalifications"
      expr: COUNT(DISTINCT CASE WHEN prequalification_status = 'Active' THEN prequalification_id END)
      comment: "Number of active prequalifications"
    - name: "expired_prequalifications"
      expr: COUNT(DISTINCT CASE WHEN prequalification_status = 'Expired' THEN prequalification_id END)
      comment: "Number of expired prequalifications"
    - name: "total_max_project_value"
      expr: SUM(CAST(max_project_value AS DOUBLE))
      comment: "Total maximum project value capacity across all prequalifications"
    - name: "avg_max_project_value"
      expr: AVG(CAST(max_project_value AS DOUBLE))
      comment: "Average maximum project value per prequalification"
    - name: "avg_prequalification_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average prequalification score"
    - name: "avg_submitted_trir"
      expr: AVG(CAST(submitted_trir AS DOUBLE))
      comment: "Average submitted Total Recordable Incident Rate"
    - name: "prequalifications_rfp_eligible"
      expr: COUNT(DISTINCT CASE WHEN rfp_eligibility_flag = TRUE THEN prequalification_id END)
      comment: "Number of prequalifications granting RFP eligibility"
    - name: "prequalifications_rfq_eligible"
      expr: COUNT(DISTINCT CASE WHEN rfq_eligibility_flag = TRUE THEN prequalification_id END)
      comment: "Number of prequalifications granting RFQ eligibility"
    - name: "prequalifications_requiring_renewal"
      expr: COUNT(DISTINCT CASE WHEN renewal_required = TRUE THEN prequalification_id END)
      comment: "Number of prequalifications requiring renewal"
    - name: "prequalifications_hse_required"
      expr: COUNT(DISTINCT CASE WHEN hse_certification_required = TRUE THEN prequalification_id END)
      comment: "Number of prequalifications requiring HSE certification"
    - name: "prequalifications_leed_required"
      expr: COUNT(DISTINCT CASE WHEN leed_certification_required = TRUE THEN prequalification_id END)
      comment: "Number of prequalifications requiring LEED certification"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_project_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client project engagement performance and satisfaction metrics"
  source: "`vibe_construction_v1`.`client`.`project_engagement`"
  dimensions:
    - name: "engagement_status"
      expr: engagement_status
      comment: "Current status of the project engagement"
    - name: "engagement_type"
      expr: engagement_type
      comment: "Type of project engagement"
    - name: "client_role"
      expr: client_role
      comment: "Role of the client in the engagement"
    - name: "sector"
      expr: sector
      comment: "Construction sector of the engagement"
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method used"
    - name: "relationship_tier"
      expr: relationship_tier
      comment: "Relationship tier classification"
    - name: "repeat_client"
      expr: repeat_client
      comment: "Whether this is a repeat client"
    - name: "dispute_status"
      expr: dispute_status
      comment: "Status of any disputes"
    - name: "bim_required"
      expr: bim_required
      comment: "Whether BIM is required for the engagement"
    - name: "leed_certification_required"
      expr: leed_certification_required
      comment: "Whether LEED certification is required"
    - name: "performance_bond_required"
      expr: performance_bond_required
      comment: "Whether performance bond is required"
    - name: "insurance_compliance_verified"
      expr: insurance_compliance_verified
      comment: "Whether insurance compliance has been verified"
    - name: "hse_requirements_classification"
      expr: hse_requirements_classification
      comment: "Classification of HSE requirements"
    - name: "contract_currency"
      expr: contract_currency
      comment: "Currency of the contract"
    - name: "funding_source"
      expr: funding_source
      comment: "Source of project funding"
  measures:
    - name: "total_engagements"
      expr: COUNT(DISTINCT project_engagement_id)
      comment: "Total number of project engagements"
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contract value across all engagements"
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average contract value per engagement"
    - name: "total_approved_variation_value"
      expr: SUM(CAST(approved_variation_value AS DOUBLE))
      comment: "Total value of approved variations across engagements"
    - name: "total_advance_payment"
      expr: SUM(CAST(advance_payment_amount AS DOUBLE))
      comment: "Total advance payment amount across engagements"
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across engagements"
    - name: "avg_liquidated_damages_rate"
      expr: AVG(CAST(liquidated_damages_rate AS DOUBLE))
      comment: "Average liquidated damages rate across engagements"
    - name: "avg_jv_participation_percentage"
      expr: AVG(CAST(jv_participation_percentage AS DOUBLE))
      comment: "Average joint venture participation percentage"
    - name: "avg_satisfaction_score"
      expr: AVG(CAST(satisfaction_score AS DOUBLE))
      comment: "Average client satisfaction score across engagements"
    - name: "engagements_with_satisfaction_survey"
      expr: COUNT(DISTINCT CASE WHEN satisfaction_survey_date IS NOT NULL THEN project_engagement_id END)
      comment: "Number of engagements with completed satisfaction surveys"
    - name: "repeat_client_engagements"
      expr: COUNT(DISTINCT CASE WHEN repeat_client = TRUE THEN project_engagement_id END)
      comment: "Number of engagements with repeat clients"
    - name: "engagements_with_disputes"
      expr: COUNT(DISTINCT CASE WHEN dispute_status IS NOT NULL AND dispute_status != 'None' THEN project_engagement_id END)
      comment: "Number of engagements with active or resolved disputes"
    - name: "engagements_bim_required"
      expr: COUNT(DISTINCT CASE WHEN bim_required = TRUE THEN project_engagement_id END)
      comment: "Number of engagements requiring BIM"
    - name: "engagements_leed_required"
      expr: COUNT(DISTINCT CASE WHEN leed_certification_required = TRUE THEN project_engagement_id END)
      comment: "Number of engagements requiring LEED certification"
    - name: "unique_clients_engaged"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique client accounts with project engagements"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_rfp_issuance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFP issuance and procurement process metrics"
  source: "`vibe_construction_v1`.`client`.`rfp_issuance`"
  dimensions:
    - name: "rfp_status"
      expr: rfp_status
      comment: "Current status of the RFP"
    - name: "solicitation_type"
      expr: solicitation_type
      comment: "Type of solicitation (RFP, RFQ, ITB)"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract being solicited"
    - name: "delivery_model"
      expr: delivery_model
      comment: "Project delivery model"
    - name: "project_sector"
      expr: project_sector
      comment: "Construction sector of the project"
    - name: "client_sector"
      expr: client_sector
      comment: "Sector classification of the client"
    - name: "country_code"
      expr: country_code
      comment: "Country where the project is located"
    - name: "project_location"
      expr: project_location
      comment: "Location of the project"
    - name: "bim_required"
      expr: bim_required
      comment: "Whether BIM is required"
    - name: "bim_level"
      expr: bim_level
      comment: "Required BIM level"
    - name: "leed_certification_required"
      expr: leed_certification_required
      comment: "Whether LEED certification is required"
    - name: "leed_certification_level"
      expr: leed_certification_level
      comment: "Required LEED certification level"
    - name: "bid_bond_required"
      expr: bid_bond_required
      comment: "Whether bid bond is required"
    - name: "performance_bond_required"
      expr: performance_bond_required
      comment: "Whether performance bond is required"
    - name: "liquidated_damages_applicable"
      expr: liquidated_damages_applicable
      comment: "Whether liquidated damages are applicable"
    - name: "pre_bid_meeting_mandatory"
      expr: pre_bid_meeting_mandatory
      comment: "Whether pre-bid meeting attendance is mandatory"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for contract value"
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the RFP was issued"
    - name: "issue_quarter"
      expr: CONCAT('Q', QUARTER(issue_date), '-', YEAR(issue_date))
      comment: "Quarter and year the RFP was issued"
  measures:
    - name: "total_rfps_issued"
      expr: COUNT(DISTINCT rfp_issuance_id)
      comment: "Total number of RFPs issued"
    - name: "total_estimated_contract_value"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE))
      comment: "Total estimated contract value of all RFPs"
    - name: "avg_estimated_contract_value"
      expr: AVG(CAST(estimated_contract_value AS DOUBLE))
      comment: "Average estimated contract value per RFP"
    - name: "avg_bid_bond_percentage"
      expr: AVG(CAST(bid_bond_percentage AS DOUBLE))
      comment: "Average bid bond percentage required"
    - name: "avg_performance_bond_percentage"
      expr: AVG(CAST(performance_bond_percentage AS DOUBLE))
      comment: "Average performance bond percentage required"
    - name: "avg_liquidated_damages_rate"
      expr: AVG(CAST(liquidated_damages_rate AS DOUBLE))
      comment: "Average liquidated damages rate"
    - name: "avg_local_content_requirement"
      expr: AVG(CAST(local_content_requirement_pct AS DOUBLE))
      comment: "Average local content requirement percentage"
    - name: "avg_technical_score_weight"
      expr: AVG(CAST(technical_score_weight AS DOUBLE))
      comment: "Average weight of technical score in evaluation"
    - name: "avg_commercial_score_weight"
      expr: AVG(CAST(commercial_score_weight AS DOUBLE))
      comment: "Average weight of commercial score in evaluation"
    - name: "rfps_with_bim_required"
      expr: COUNT(DISTINCT CASE WHEN bim_required = TRUE THEN rfp_issuance_id END)
      comment: "Number of RFPs requiring BIM"
    - name: "rfps_with_leed_required"
      expr: COUNT(DISTINCT CASE WHEN leed_certification_required = TRUE THEN rfp_issuance_id END)
      comment: "Number of RFPs requiring LEED certification"
    - name: "rfps_with_bid_bond"
      expr: COUNT(DISTINCT CASE WHEN bid_bond_required = TRUE THEN rfp_issuance_id END)
      comment: "Number of RFPs requiring bid bond"
    - name: "rfps_with_performance_bond"
      expr: COUNT(DISTINCT CASE WHEN performance_bond_required = TRUE THEN rfp_issuance_id END)
      comment: "Number of RFPs requiring performance bond"
    - name: "rfps_with_liquidated_damages"
      expr: COUNT(DISTINCT CASE WHEN liquidated_damages_applicable = TRUE THEN rfp_issuance_id END)
      comment: "Number of RFPs with liquidated damages applicable"
    - name: "rfps_with_mandatory_prebid"
      expr: COUNT(DISTINCT CASE WHEN pre_bid_meeting_mandatory = TRUE THEN rfp_issuance_id END)
      comment: "Number of RFPs with mandatory pre-bid meeting"
    - name: "rfps_with_addenda"
      expr: COUNT(DISTINCT CASE WHEN addendum_count > 0 THEN rfp_issuance_id END)
      comment: "Number of RFPs that have issued addenda"
$$;