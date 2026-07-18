-- Metric views for domain: client | Business: Advertising | Version: 1 | Generated on: 2026-05-08 02:24:04

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`client_advertiser`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core advertiser account metrics tracking client base size, onboarding velocity, churn, and account health across tiers and segments"
  source: "`advertising_ecm`.`client`.`advertiser`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the advertiser account (active, inactive, suspended, etc.)"
    - name: "account_tier"
      expr: account_tier
      comment: "Strategic tier classification of the advertiser account"
    - name: "onboarding_year"
      expr: YEAR(onboarding_date)
      comment: "Year the advertiser was onboarded"
    - name: "onboarding_quarter"
      expr: CONCAT('Q', QUARTER(onboarding_date), '-', YEAR(onboarding_date))
      comment: "Quarter and year the advertiser was onboarded"
    - name: "churn_year"
      expr: YEAR(churn_date)
      comment: "Year the advertiser churned"
    - name: "is_agency_managed"
      expr: is_agency_managed
      comment: "Whether the advertiser is managed through an agency"
    - name: "iab_industry_vertical"
      expr: iab_industry_vertical
      comment: "IAB industry vertical classification"
    - name: "preferred_currency"
      expr: preferred_currency
      comment: "Preferred currency for billing and reporting"
    - name: "gdpr_consent_flag"
      expr: gdpr_consent_flag
      comment: "Whether GDPR consent has been obtained"
    - name: "ccpa_consent_flag"
      expr: ccpa_consent_flag
      comment: "Whether CCPA consent has been obtained"
  measures:
    - name: "total_advertisers"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Total number of unique advertiser accounts"
    - name: "active_advertisers"
      expr: COUNT(DISTINCT CASE WHEN account_status = 'active' THEN advertiser_id END)
      comment: "Number of advertisers with active account status"
    - name: "churned_advertisers"
      expr: COUNT(DISTINCT CASE WHEN churn_date IS NOT NULL THEN advertiser_id END)
      comment: "Number of advertisers who have churned"
    - name: "agency_managed_advertisers"
      expr: COUNT(DISTINCT CASE WHEN is_agency_managed = TRUE THEN advertiser_id END)
      comment: "Number of advertisers managed through agencies"
    - name: "gdpr_compliant_advertisers"
      expr: COUNT(DISTINCT CASE WHEN gdpr_consent_flag = TRUE THEN advertiser_id END)
      comment: "Number of advertisers with GDPR consent on file"
$$;


CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`client_brand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand portfolio metrics tracking brand count, budget allocation, programmatic eligibility, and brand health across categories and tiers"
  source: "`advertising_ecm`.`client`.`client_brand`"
  dimensions:
    - name: "brand_status"
      expr: brand_status
      comment: "Current operational status of the brand"
    - name: "brand_tier"
      expr: brand_tier
      comment: "Strategic tier classification of the brand"
    - name: "brand_category"
      expr: brand_category
      comment: "Primary category classification of the brand"
    - name: "sub_category"
      expr: sub_category
      comment: "Sub-category classification of the brand"
    - name: "iab_category_code"
      expr: iab_category_code
      comment: "IAB category code for the brand"
    - name: "programmatic_eligible"
      expr: programmatic_eligible
      comment: "Whether the brand is eligible for programmatic advertising"
    - name: "digital_advertising_enabled"
      expr: digital_advertising_enabled
      comment: "Whether digital advertising is enabled for the brand"
    - name: "launch_year"
      expr: YEAR(launch_date)
      comment: "Year the brand was launched"
    - name: "budget_currency"
      expr: budget_currency
      comment: "Currency for the brand's media budget"
    - name: "safety_level"
      expr: safety_level
      comment: "Brand safety level classification"
  measures:
    - name: "total_brands"
      expr: COUNT(DISTINCT client_brand_id)
      comment: "Total number of unique client brands"
    - name: "active_brands"
      expr: COUNT(DISTINCT CASE WHEN brand_status = 'active' THEN client_brand_id END)
      comment: "Number of brands with active status"
    - name: "programmatic_eligible_brands"
      expr: COUNT(DISTINCT CASE WHEN programmatic_eligible = TRUE THEN client_brand_id END)
      comment: "Number of brands eligible for programmatic advertising"
    - name: "total_annual_media_budget"
      expr: SUM(CAST(annual_media_budget AS DOUBLE))
      comment: "Total annual media budget across all brands"
    - name: "avg_annual_media_budget"
      expr: AVG(CAST(annual_media_budget AS DOUBLE))
      comment: "Average annual media budget per brand"
    - name: "avg_sov_target_pct"
      expr: AVG(CAST(sov_target_pct AS DOUBLE))
      comment: "Average share of voice target percentage across brands"
$$;


CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`client_agency_relationship`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agency relationship performance metrics tracking relationship health, billings, commission rates, and competitive conflicts across relationship types and tiers"
  source: "`advertising_ecm`.`client`.`agency_relationship`"
  dimensions:
    - name: "relationship_status"
      expr: relationship_status
      comment: "Current status of the agency relationship"
    - name: "relationship_type"
      expr: relationship_type
      comment: "Type of agency relationship (AOR, project-based, retainer, etc.)"
    - name: "relationship_tier"
      expr: relationship_tier
      comment: "Strategic tier classification of the relationship"
    - name: "aor_designation"
      expr: aor_designation
      comment: "Agency of Record designation"
    - name: "fee_structure_type"
      expr: fee_structure_type
      comment: "Type of fee structure (commission, retainer, hybrid, etc.)"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the relationship"
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Whether the relationship is exclusive"
    - name: "competitive_conflict_flag"
      expr: competitive_conflict_flag
      comment: "Whether a competitive conflict exists"
    - name: "relationship_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the relationship started"
    - name: "fee_currency_code"
      expr: fee_currency_code
      comment: "Currency for fees and billings"
  measures:
    - name: "total_relationships"
      expr: COUNT(DISTINCT agency_relationship_id)
      comment: "Total number of unique agency relationships"
    - name: "active_relationships"
      expr: COUNT(DISTINCT CASE WHEN relationship_status = 'active' THEN agency_relationship_id END)
      comment: "Number of active agency relationships"
    - name: "aor_relationships"
      expr: COUNT(DISTINCT CASE WHEN aor_designation IS NOT NULL THEN agency_relationship_id END)
      comment: "Number of Agency of Record relationships"
    - name: "exclusive_relationships"
      expr: COUNT(DISTINCT CASE WHEN is_exclusive = TRUE THEN agency_relationship_id END)
      comment: "Number of exclusive agency relationships"
    - name: "relationships_with_conflicts"
      expr: COUNT(DISTINCT CASE WHEN competitive_conflict_flag = TRUE THEN agency_relationship_id END)
      comment: "Number of relationships with competitive conflicts"
    - name: "total_estimated_annual_billings"
      expr: SUM(CAST(estimated_annual_billings AS DOUBLE))
      comment: "Total estimated annual billings across all relationships"
    - name: "avg_estimated_annual_billings"
      expr: AVG(CAST(estimated_annual_billings AS DOUBLE))
      comment: "Average estimated annual billings per relationship"
    - name: "total_annual_fees"
      expr: SUM(CAST(annual_fee_amount AS DOUBLE))
      comment: "Total annual fee amounts across all relationships"
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate percentage across relationships"
$$;


CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`client_revenue_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue planning and performance metrics tracking target attainment, pipeline health, and forecast accuracy across accounts, service lines, and time periods"
  source: "`advertising_ecm`.`client`.`revenue_target`"
  dimensions:
    - name: "target_status"
      expr: target_status
      comment: "Current status of the revenue target"
    - name: "target_type"
      expr: target_type
      comment: "Type of revenue target (new business, renewal, upsell, etc.)"
    - name: "target_period_type"
      expr: target_period_type
      comment: "Period type for the target (monthly, quarterly, annual)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for the revenue target"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for the revenue target"
    - name: "service_line"
      expr: service_line
      comment: "Service line for the revenue target"
    - name: "confidence_level"
      expr: confidence_level
      comment: "Confidence level in achieving the target"
    - name: "is_stretch_target"
      expr: is_stretch_target
      comment: "Whether this is a stretch target"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for the revenue target"
    - name: "target_setting_method"
      expr: target_setting_method
      comment: "Method used to set the target"
  measures:
    - name: "total_targets"
      expr: COUNT(DISTINCT revenue_target_id)
      comment: "Total number of unique revenue targets"
    - name: "active_targets"
      expr: COUNT(DISTINCT CASE WHEN target_status = 'active' THEN revenue_target_id END)
      comment: "Number of active revenue targets"
    - name: "total_target_amount"
      expr: SUM(CAST(target_amount AS DOUBLE))
      comment: "Total revenue target amount in local currency"
    - name: "total_target_amount_usd"
      expr: SUM(CAST(target_amount_usd AS DOUBLE))
      comment: "Total revenue target amount in USD"
    - name: "total_pipeline_amount"
      expr: SUM(CAST(pipeline_amount AS DOUBLE))
      comment: "Total pipeline amount across all targets"
    - name: "avg_target_amount_usd"
      expr: AVG(CAST(target_amount_usd AS DOUBLE))
      comment: "Average revenue target amount in USD"
    - name: "avg_account_growth_rate_pct"
      expr: AVG(CAST(account_growth_rate_pct AS DOUBLE))
      comment: "Average account growth rate percentage"
    - name: "avg_roas_target"
      expr: AVG(CAST(roas_target AS DOUBLE))
      comment: "Average return on ad spend target"
    - name: "avg_contracted_sow_coverage_pct"
      expr: AVG(CAST(contracted_sow_coverage_pct AS DOUBLE))
      comment: "Average percentage of target covered by contracted scope of work"
$$;


CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`client_nps_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client satisfaction and loyalty metrics tracking NPS scores, response rates, at-risk accounts, and sentiment trends across segments and touchpoints"
  source: "`advertising_ecm`.`client`.`nps_response`"
  dimensions:
    - name: "response_status"
      expr: response_status
      comment: "Status of the NPS survey response"
    - name: "survey_type"
      expr: survey_type
      comment: "Type of NPS survey conducted"
    - name: "survey_channel"
      expr: survey_channel
      comment: "Channel through which the survey was delivered"
    - name: "respondent_category"
      expr: respondent_category
      comment: "Category of respondent (promoter, passive, detractor)"
    - name: "respondent_role"
      expr: respondent_role
      comment: "Role of the survey respondent"
    - name: "at_risk_flag"
      expr: at_risk_flag
      comment: "Whether the account is flagged as at-risk based on response"
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Whether follow-up action is required"
    - name: "follow_up_status"
      expr: follow_up_status
      comment: "Status of follow-up actions"
    - name: "business_segment"
      expr: business_segment
      comment: "Business segment of the respondent"
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical of the respondent"
    - name: "survey_year"
      expr: YEAR(survey_date)
      comment: "Year the survey was conducted"
    - name: "survey_quarter"
      expr: CONCAT('Q', QUARTER(survey_date), '-', YEAR(survey_date))
      comment: "Quarter and year the survey was conducted"
  measures:
    - name: "total_responses"
      expr: COUNT(DISTINCT nps_response_id)
      comment: "Total number of unique NPS survey responses"
    - name: "completed_responses"
      expr: COUNT(DISTINCT CASE WHEN response_status = 'completed' THEN nps_response_id END)
      comment: "Number of completed NPS survey responses"
    - name: "at_risk_accounts"
      expr: COUNT(DISTINCT CASE WHEN at_risk_flag = TRUE THEN advertiser_id END)
      comment: "Number of unique accounts flagged as at-risk"
    - name: "responses_requiring_followup"
      expr: COUNT(DISTINCT CASE WHEN follow_up_required = TRUE THEN nps_response_id END)
      comment: "Number of responses requiring follow-up action"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score across all responses"
    - name: "avg_relationship_aspect_rating"
      expr: AVG(CAST(relationship_aspect_rating AS DOUBLE))
      comment: "Average rating for specific relationship aspects"
$$;


CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`client_onboarding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client onboarding efficiency metrics tracking cycle time, completion rates, blocker resolution, and service tier performance"
  source: "`advertising_ecm`.`client`.`client_onboarding`"
  dimensions:
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current status of the onboarding process"
    - name: "onboarding_type"
      expr: onboarding_type
      comment: "Type of onboarding (new client, reactivation, migration, etc.)"
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier for the onboarding"
    - name: "kickoff_year"
      expr: YEAR(kickoff_date)
      comment: "Year the onboarding was kicked off"
    - name: "kickoff_quarter"
      expr: CONCAT('Q', QUARTER(kickoff_date), '-', YEAR(kickoff_date))
      comment: "Quarter and year the onboarding was kicked off"
    - name: "msa_signed_flag"
      expr: msa_signed_flag
      comment: "Whether the Master Service Agreement has been signed"
    - name: "billing_code_created_flag"
      expr: billing_code_created_flag
      comment: "Whether billing code has been created"
    - name: "dam_access_provisioned_flag"
      expr: dam_access_provisioned_flag
      comment: "Whether Digital Asset Management access has been provisioned"
    - name: "analytics_dashboard_created_flag"
      expr: analytics_dashboard_created_flag
      comment: "Whether analytics dashboard has been created"
  measures:
    - name: "total_onboardings"
      expr: COUNT(DISTINCT client_onboarding_id)
      comment: "Total number of unique client onboarding processes"
    - name: "completed_onboardings"
      expr: COUNT(DISTINCT CASE WHEN onboarding_status = 'completed' THEN client_onboarding_id END)
      comment: "Number of completed onboarding processes"
    - name: "in_progress_onboardings"
      expr: COUNT(DISTINCT CASE WHEN onboarding_status = 'in_progress' THEN client_onboarding_id END)
      comment: "Number of onboarding processes currently in progress"
    - name: "onboardings_with_msa"
      expr: COUNT(DISTINCT CASE WHEN msa_signed_flag = TRUE THEN client_onboarding_id END)
      comment: "Number of onboardings with signed Master Service Agreement"
    - name: "onboardings_with_billing_setup"
      expr: COUNT(DISTINCT CASE WHEN billing_code_created_flag = TRUE THEN client_onboarding_id END)
      comment: "Number of onboardings with billing code created"
    - name: "onboardings_with_dam_access"
      expr: COUNT(DISTINCT CASE WHEN dam_access_provisioned_flag = TRUE THEN client_onboarding_id END)
      comment: "Number of onboardings with DAM access provisioned"
    - name: "onboardings_with_analytics"
      expr: COUNT(DISTINCT CASE WHEN analytics_dashboard_created_flag = TRUE THEN client_onboarding_id END)
      comment: "Number of onboardings with analytics dashboard created"
$$;


CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`client_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client engagement metrics tracking interaction volume, sentiment, escalations, and touchpoint effectiveness across channels and business topics"
  source: "`advertising_ecm`.`client`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of client interaction (meeting, call, email, etc.)"
    - name: "interaction_status"
      expr: interaction_status
      comment: "Status of the interaction"
    - name: "channel"
      expr: channel
      comment: "Communication channel used for the interaction"
    - name: "direction"
      expr: direction
      comment: "Direction of the interaction (inbound, outbound)"
    - name: "business_topic"
      expr: business_topic
      comment: "Primary business topic discussed"
    - name: "client_sentiment"
      expr: client_sentiment
      comment: "Client sentiment during the interaction"
    - name: "is_escalation"
      expr: is_escalation
      comment: "Whether the interaction was an escalation"
    - name: "is_qbr"
      expr: is_qbr
      comment: "Whether the interaction was a Quarterly Business Review"
    - name: "priority"
      expr: priority
      comment: "Priority level of the interaction"
    - name: "interaction_year"
      expr: YEAR(interaction_date)
      comment: "Year the interaction occurred"
    - name: "interaction_quarter"
      expr: CONCAT('Q', QUARTER(interaction_date), '-', YEAR(interaction_date))
      comment: "Quarter and year the interaction occurred"
    - name: "interaction_month"
      expr: DATE_TRUNC('MONTH', interaction_date)
      comment: "Month the interaction occurred"
  measures:
    - name: "total_interactions"
      expr: COUNT(DISTINCT interaction_id)
      comment: "Total number of unique client interactions"
    - name: "escalation_interactions"
      expr: COUNT(DISTINCT CASE WHEN is_escalation = TRUE THEN interaction_id END)
      comment: "Number of interactions that were escalations"
    - name: "qbr_interactions"
      expr: COUNT(DISTINCT CASE WHEN is_qbr = TRUE THEN interaction_id END)
      comment: "Number of Quarterly Business Review interactions"
    - name: "unique_clients_interacted"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of unique clients with interactions"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average NPS score captured during interactions"
$$;


CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`client_competitive_conflict`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Competitive conflict management metrics tracking conflict volume, severity, resolution time, and waiver rates across categories and markets"
  source: "`advertising_ecm`.`client`.`competitive_conflict`"
  dimensions:
    - name: "conflict_status"
      expr: conflict_status
      comment: "Current status of the competitive conflict"
    - name: "conflict_type"
      expr: conflict_type
      comment: "Type of competitive conflict"
    - name: "conflict_severity"
      expr: conflict_severity
      comment: "Severity level of the conflict"
    - name: "resolution_approach"
      expr: resolution_approach
      comment: "Approach taken to resolve the conflict"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the conflict"
    - name: "iab_category_code"
      expr: iab_category_code
      comment: "IAB category code for the conflict"
    - name: "legal_review_required"
      expr: legal_review_required
      comment: "Whether legal review is required"
    - name: "information_barrier_implemented"
      expr: information_barrier_implemented
      comment: "Whether information barriers have been implemented"
    - name: "pitch_eligibility_blocked"
      expr: pitch_eligibility_blocked
      comment: "Whether pitch eligibility is blocked due to conflict"
    - name: "declaration_year"
      expr: YEAR(declaration_date)
      comment: "Year the conflict was declared"
  measures:
    - name: "total_conflicts"
      expr: COUNT(DISTINCT competitive_conflict_id)
      comment: "Total number of unique competitive conflicts"
    - name: "active_conflicts"
      expr: COUNT(DISTINCT CASE WHEN conflict_status = 'active' THEN competitive_conflict_id END)
      comment: "Number of active competitive conflicts"
    - name: "resolved_conflicts"
      expr: COUNT(DISTINCT CASE WHEN conflict_status = 'resolved' THEN competitive_conflict_id END)
      comment: "Number of resolved competitive conflicts"
    - name: "high_severity_conflicts"
      expr: COUNT(DISTINCT CASE WHEN conflict_severity = 'high' THEN competitive_conflict_id END)
      comment: "Number of high-severity conflicts"
    - name: "conflicts_requiring_legal_review"
      expr: COUNT(DISTINCT CASE WHEN legal_review_required = TRUE THEN competitive_conflict_id END)
      comment: "Number of conflicts requiring legal review"
    - name: "conflicts_blocking_pitch"
      expr: COUNT(DISTINCT CASE WHEN pitch_eligibility_blocked = TRUE THEN competitive_conflict_id END)
      comment: "Number of conflicts blocking pitch eligibility"
    - name: "conflicts_with_barriers"
      expr: COUNT(DISTINCT CASE WHEN information_barrier_implemented = TRUE THEN competitive_conflict_id END)
      comment: "Number of conflicts with information barriers implemented"
$$;


CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`client_account_team`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Account team resource allocation metrics tracking team composition, FTE allocation, billing rates, and assignment coverage across roles and seniority levels"
  source: "`advertising_ecm`.`client`.`account_team`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the team assignment"
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of team assignment"
    - name: "role"
      expr: role
      comment: "Role of the team member on the account"
    - name: "seniority_level"
      expr: seniority_level
      comment: "Seniority level of the team member"
    - name: "team_function"
      expr: team_function
      comment: "Functional area of the team member"
    - name: "billing_rate_type"
      expr: billing_rate_type
      comment: "Type of billing rate applied"
    - name: "client_facing_flag"
      expr: client_facing_flag
      comment: "Whether the role is client-facing"
    - name: "is_primary_contact"
      expr: is_primary_contact
      comment: "Whether this is the primary client contact"
    - name: "is_backup_contact"
      expr: is_backup_contact
      comment: "Whether this is a backup client contact"
    - name: "qbr_presenter_flag"
      expr: qbr_presenter_flag
      comment: "Whether the team member presents at QBRs"
    - name: "conflict_of_interest_flag"
      expr: conflict_of_interest_flag
      comment: "Whether a conflict of interest exists"
    - name: "assignment_year"
      expr: YEAR(start_date)
      comment: "Year the assignment started"
  measures:
    - name: "total_assignments"
      expr: COUNT(DISTINCT account_team_id)
      comment: "Total number of unique account team assignments"
    - name: "active_assignments"
      expr: COUNT(DISTINCT CASE WHEN assignment_status = 'active' THEN account_team_id END)
      comment: "Number of active account team assignments"
    - name: "client_facing_assignments"
      expr: COUNT(DISTINCT CASE WHEN client_facing_flag = TRUE THEN account_team_id END)
      comment: "Number of client-facing assignments"
    - name: "unique_workers_assigned"
      expr: COUNT(DISTINCT worker_id)
      comment: "Number of unique workers assigned to accounts"
    - name: "total_fte_allocation"
      expr: SUM(CAST(fte_allocation_pct AS DOUBLE))
      comment: "Total FTE allocation percentage across all assignments"
    - name: "avg_fte_allocation_pct"
      expr: AVG(CAST(fte_allocation_pct AS DOUBLE))
      comment: "Average FTE allocation percentage per assignment"
    - name: "total_billing_rate_usd"
      expr: SUM(CAST(billing_rate_usd AS DOUBLE))
      comment: "Total billing rate in USD across all assignments"
    - name: "avg_billing_rate_usd"
      expr: AVG(CAST(billing_rate_usd AS DOUBLE))
      comment: "Average billing rate in USD per assignment"
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours_per_month AS DOUBLE))
      comment: "Total planned hours per month across all assignments"
    - name: "avg_planned_hours_per_month"
      expr: AVG(CAST(planned_hours_per_month AS DOUBLE))
      comment: "Average planned hours per month per assignment"
$$;
