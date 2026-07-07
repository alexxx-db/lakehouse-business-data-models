-- Metric views for domain: guest | Business: Travel Hospitality | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_communication_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest consent and privacy compliance metrics. Drives GDPR/CCPA compliance monitoring, marketing eligibility management, and consent lifecycle governance."
  source: "`vibe_travel_hospitality_v1`.`guest`.`communication_consent`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent (marketing, profiling, third-party sharing) — primary filter for consent portfolio analysis."
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent record (granted, withdrawn, expired) — critical for compliance monitoring."
    - name: "consent_method"
      expr: consent_method
      comment: "Method by which consent was captured (web, in-person, email) — measures consent channel effectiveness."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the consent (GDPR, CCPA, etc.) — enables jurisdiction-level compliance reporting."
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal basis for processing (legitimate interest, consent, contract) — required for GDPR compliance reporting."
    - name: "consent_source"
      expr: consent_source
      comment: "Source system or channel where consent was captured — enables consent provenance analysis."
    - name: "consent_granted_date"
      expr: DATE_TRUNC('month', consent_granted_date)
      comment: "Month consent was granted — enables consent volume trend and campaign consent capture analysis."
  measures:
    - name: "total_active_consents"
      expr: SUM(CASE WHEN consent_status = 'granted' AND record_active_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of currently active granted consents — measures addressable marketing audience under consent compliance."
    - name: "total_consent_records"
      expr: COUNT(1)
      comment: "Total consent records — baseline for consent portfolio size and compliance audit coverage."
    - name: "consent_withdrawal_count"
      expr: SUM(CASE WHEN consent_status = 'withdrawn' THEN 1 ELSE 0 END)
      comment: "Count of withdrawn consents — monitors opt-out trends and marketing list attrition."
    - name: "consent_withdrawal_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_status = 'withdrawn' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consents that have been withdrawn — key compliance and brand trust KPI."
    - name: "double_opt_in_confirmed_count"
      expr: SUM(CASE WHEN double_opt_in_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of double opt-in confirmed consents — measures highest-quality consent tier for email marketing compliance."
    - name: "double_opt_in_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN double_opt_in_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consents with double opt-in confirmation — measures consent quality and email deliverability risk."
    - name: "suppression_list_count"
      expr: SUM(CASE WHEN suppression_list_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of guests on suppression lists — measures do-not-contact compliance exposure."
    - name: "profiling_consent_count"
      expr: SUM(CASE WHEN profiling_consent_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of guests with profiling consent — measures addressable audience for AI/ML personalization under GDPR."
    - name: "third_party_sharing_consent_count"
      expr: SUM(CASE WHEN third_party_sharing_consent_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of guests consenting to third-party data sharing — measures partner marketing addressable audience."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_corporate_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corporate account performance and portfolio metrics. Drives account management investment, contract renewal decisions, and corporate segment revenue strategy."
  source: "`vibe_travel_hospitality_v1`.`guest`.`corporate_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Status of the corporate account (active, inactive, prospect) — primary filter for active portfolio analysis."
    - name: "account_type"
      expr: account_type
      comment: "Type of corporate account (direct, TMC, consortia) — enables account type mix and revenue analysis."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment of the corporate account — supports revenue mix and pricing strategy analysis."
    - name: "rate_program_type"
      expr: rate_program_type
      comment: "Rate program type (LRA, non-LRA, consortia) — enables rate program economics analysis."
    - name: "billing_address_country_code"
      expr: billing_address_country_code
      comment: "Country of the corporate account — enables geographic market analysis and contract compliance."
    - name: "loyalty_program_eligible"
      expr: loyalty_program_eligible
      comment: "Whether the account is eligible for loyalty program — measures loyalty-linked corporate volume."
    - name: "mice_eligible"
      expr: mice_eligible
      comment: "Whether the account is eligible for MICE business — measures MICE pipeline from corporate accounts."
    - name: "contract_start_date"
      expr: DATE_TRUNC('year', contract_start_date)
      comment: "Contract start year — enables cohort analysis of account contract vintage and renewal cycles."
  measures:
    - name: "total_annual_revenue_target"
      expr: SUM(CAST(annual_revenue_target AS DOUBLE))
      comment: "Total annual revenue target across corporate accounts — measures contracted corporate revenue pipeline."
    - name: "avg_annual_revenue_target"
      expr: AVG(CAST(annual_revenue_target AS DOUBLE))
      comment: "Average annual revenue target per corporate account — benchmarks account value for portfolio prioritization."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across corporate accounts — measures financial exposure and credit risk."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage across corporate accounts — monitors rate integrity and negotiation outcomes."
    - name: "total_active_accounts"
      expr: SUM(CASE WHEN account_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active corporate accounts — measures active corporate portfolio size for account management resourcing."
    - name: "direct_billing_enabled_count"
      expr: SUM(CASE WHEN direct_billing_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts with direct billing enabled — measures accounts receivable exposure and billing complexity."
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total corporate account records — baseline portfolio size KPI."
    - name: "loyalty_eligible_account_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN loyalty_program_eligible = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corporate accounts eligible for loyalty program — measures loyalty program corporate penetration."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_loyalty_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest promotion and loyalty enrollment metrics tracking enrollment volume, completion rates, and bonus award performance — KPIs for loyalty program growth and promotional campaign effectiveness."
  source: "`vibe_travel_hospitality_v1`.`guest`.`guest_enrollment`"
  dimensions:
    - name: "guest_enrollment_status"
      expr: guest_enrollment_status
      comment: "Current status of the enrollment (e.g., active, completed, opted-out) for funnel analysis."
    - name: "enrollment_channel"
      expr: channel
      comment: "Channel through which the guest enrolled (e.g., web, mobile, front desk) for channel effectiveness analysis."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', guest_enrollment_date)
      comment: "Month of enrollment for trend analysis of loyalty program growth."
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month of enrollment completion for measuring program completion velocity."
  measures:
    - name: "total_enrollments"
      expr: COUNT(DISTINCT guest_enrollment_id)
      comment: "Total number of guest enrollments — primary volume KPI for loyalty and promotional program growth."
    - name: "completed_enrollment_count"
      expr: COUNT(DISTINCT CASE WHEN guest_enrollment_status = 'COMPLETED' THEN guest_enrollment_id END)
      comment: "Number of enrollments that reached completion — measures program engagement and fulfillment effectiveness."
    - name: "enrollment_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN guest_enrollment_status = 'COMPLETED' THEN guest_enrollment_id END) / NULLIF(COUNT(DISTINCT guest_enrollment_id), 0), 2)
      comment: "Percentage of enrollments that were completed — key KPI for promotional program design and incentive calibration."
    - name: "bonus_awarded_enrollment_count"
      expr: COUNT(DISTINCT CASE WHEN bonus_awarded_flag = TRUE THEN guest_enrollment_id END)
      comment: "Number of enrollments where a bonus was awarded — measures bonus fulfillment rate and promotional cost."
    - name: "opt_out_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN opt_out_date IS NOT NULL THEN guest_enrollment_id END) / NULLIF(COUNT(DISTINCT guest_enrollment_id), 0), 2)
      comment: "Percentage of enrollments that resulted in opt-out — elevated rates signal program design or communication issues."
    - name: "average_progress_value"
      expr: AVG(CAST(progress_value AS DOUBLE))
      comment: "Average progress value across active enrollments — measures engagement depth within promotional programs."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_group_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group business performance metrics covering contracted room nights, pickup, attrition, and deposit compliance. Drives group sales strategy and revenue management decisions."
  source: "`vibe_travel_hospitality_v1`.`guest`.`guest_group_block`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property hosting the group block — enables property-level group business performance analysis."
    - name: "block_status"
      expr: block_status
      comment: "Current status of the group block (tentative, definite, cancelled) — primary filter for active pipeline analysis."
    - name: "group_type"
      expr: group_type
      comment: "Type of group (corporate, association, leisure, MICE) — enables group segment mix and revenue analysis."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment of the group — supports revenue mix and displacement analysis."
    - name: "arrival_date"
      expr: DATE_TRUNC('month', arrival_date)
      comment: "Arrival month of the group — enables forward-looking group pipeline and pace analysis."
    - name: "source_of_business_code"
      expr: source_of_business_code
      comment: "Source of business for the group — measures channel effectiveness for group sales."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the group contract — required for multi-currency revenue consolidation."
  measures:
    - name: "total_contracted_revenue"
      expr: SUM(CAST(contracted_rate_amount AS DOUBLE))
      comment: "Total contracted rate revenue across group blocks — primary group revenue pipeline KPI."
    - name: "avg_contracted_rate"
      expr: AVG(CAST(contracted_rate_amount AS DOUBLE))
      comment: "Average contracted rate per group block — measures group rate quality vs transient displacement."
    - name: "total_deposit_required"
      expr: SUM(CAST(deposit_required_amount AS DOUBLE))
      comment: "Total deposit amounts required across group blocks — measures financial commitment and cash flow exposure."
    - name: "total_deposit_received"
      expr: SUM(CAST(deposit_received_amount AS DOUBLE))
      comment: "Total deposits actually received — measures deposit compliance and financial risk mitigation."
    - name: "deposit_collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(deposit_received_amount AS DOUBLE)) / NULLIF(SUM(CAST(deposit_required_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of required deposits collected — monitors group financial risk and contract compliance."
    - name: "avg_attrition_pct"
      expr: AVG(CAST(attrition_pct AS DOUBLE))
      comment: "Average attrition percentage across group blocks — measures group pickup performance vs contracted commitment."
    - name: "avg_wash_pct"
      expr: AVG(CAST(wash_pct AS DOUBLE))
      comment: "Average wash percentage applied to group blocks — measures revenue management adjustment to group commitments."
    - name: "total_group_blocks"
      expr: COUNT(1)
      comment: "Total number of group blocks — baseline volume KPI for group sales pipeline sizing."
    - name: "active_group_block_count"
      expr: SUM(CASE WHEN block_status NOT IN ('cancelled', 'lost') THEN 1 ELSE 0 END)
      comment: "Count of active (non-cancelled) group blocks — measures live group pipeline for revenue forecasting."
    - name: "repeat_group_count"
      expr: SUM(CASE WHEN repeat_group_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of repeat group bookings — measures group loyalty and account retention performance."
    - name: "vip_group_count"
      expr: SUM(CASE WHEN vip_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of VIP-flagged group blocks — measures high-touch group volume requiring elevated service resources."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level guest metrics tracking multi-member household value, loyalty status, and revenue contribution — KPIs for household-based marketing, family program design, and lifetime value expansion strategies."
  source: "`vibe_travel_hospitality_v1`.`guest`.`household`"
  filter: household_status = 'ACTIVE'
  dimensions:
    - name: "household_type"
      expr: household_type
      comment: "Type of household (e.g., family, couple, solo) for household segment analysis."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty tier of the household for tier-based value analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the household for geographic distribution analysis."
    - name: "preferred_currency"
      expr: preferred_currency
      comment: "Preferred currency of the household for multi-currency revenue reporting."
    - name: "last_stay_month"
      expr: DATE_TRUNC('MONTH', last_stay_date)
      comment: "Month of the household's last stay for recency analysis and re-engagement targeting."
    - name: "vip_flag"
      expr: CAST(vip_flag AS STRING)
      comment: "Whether the household has VIP status for premium service planning."
  measures:
    - name: "total_active_households"
      expr: COUNT(DISTINCT household_id)
      comment: "Total number of active households — measures the household-level CRM database size for family program planning."
    - name: "total_household_lifetime_revenue"
      expr: SUM(CAST(lifetime_revenue AS DOUBLE))
      comment: "Total lifetime revenue across all active households — aggregate household portfolio value KPI."
    - name: "average_household_lifetime_revenue"
      expr: AVG(CAST(lifetime_revenue AS DOUBLE))
      comment: "Average lifetime revenue per household — used to benchmark household value and identify upsell opportunities."
    - name: "average_household_adr"
      expr: AVG(CAST(average_daily_rate AS DOUBLE))
      comment: "Average daily rate across household stays — measures household price sensitivity and rate strategy effectiveness."
    - name: "marketing_opted_in_household_count"
      expr: COUNT(DISTINCT CASE WHEN marketing_opt_in = TRUE THEN household_id END)
      comment: "Number of households opted into marketing — determines the household-level marketable audience size."
    - name: "vip_household_count"
      expr: COUNT(DISTINCT CASE WHEN vip_flag = TRUE THEN household_id END)
      comment: "Number of VIP households — sizes the premium household segment for elevated service resource planning."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_lifetime_value`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest lifetime value and predictive analytics metrics. Drives CRM investment decisions, loyalty program economics, and churn prevention strategy."
  source: "`vibe_travel_hospitality_v1`.`guest`.`lifetime_value`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property scope for LTV calculation — enables property-level guest value benchmarking."
    - name: "ltv_tier"
      expr: ltv_tier
      comment: "LTV tier classification (e.g., platinum, gold, silver) — primary segmentation for CRM investment prioritization."
    - name: "loyalty_tier_code"
      expr: loyalty_tier_code
      comment: "Loyalty program tier at time of LTV calculation — links LTV to loyalty program economics."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment for LTV analysis — enables segment-level value and investment decisions."
    - name: "churn_risk_flag"
      expr: churn_risk_flag
      comment: "Boolean flag indicating high churn risk — primary filter for retention campaign targeting."
    - name: "calculation_date"
      expr: DATE_TRUNC('month', calculation_date)
      comment: "Month of LTV calculation — enables trend analysis of portfolio value over time."
    - name: "preferred_brand_code"
      expr: preferred_brand_code
      comment: "Guest preferred brand — supports brand-level LTV and loyalty investment analysis."
    - name: "vip_flag"
      expr: vip_flag
      comment: "VIP designation flag — enables VIP vs non-VIP LTV comparison for service investment decisions."
  measures:
    - name: "total_ltv_score"
      expr: SUM(CAST(ltv_score AS DOUBLE))
      comment: "Sum of LTV scores across guest portfolio — measures total predicted value of the guest base."
    - name: "avg_ltv_score"
      expr: AVG(CAST(ltv_score AS DOUBLE))
      comment: "Average LTV score per guest — primary KPI for CRM investment prioritization and portfolio health."
    - name: "total_lifetime_revenue"
      expr: SUM(CAST(total_revenue AS DOUBLE))
      comment: "Total realized lifetime revenue across all guests — measures cumulative guest portfolio value."
    - name: "avg_lifetime_revenue_per_guest"
      expr: AVG(CAST(total_revenue AS DOUBLE))
      comment: "Average lifetime revenue per guest — core metric for CRM ROI and acquisition cost benchmarking."
    - name: "total_projected_12m_revenue"
      expr: SUM(CAST(projected_12m_revenue AS DOUBLE))
      comment: "Total projected 12-month revenue across guest portfolio — forward-looking revenue pipeline KPI."
    - name: "avg_projected_12m_revenue"
      expr: AVG(CAST(projected_12m_revenue AS DOUBLE))
      comment: "Average projected 12-month revenue per guest — drives CRM budget allocation decisions."
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score across guest portfolio — monitors overall retention risk level."
    - name: "high_churn_risk_guest_count"
      expr: SUM(CASE WHEN churn_risk_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of guests flagged as high churn risk — drives retention campaign sizing and urgency."
    - name: "avg_adr"
      expr: AVG(CAST(average_daily_rate AS DOUBLE))
      comment: "Average ADR across guest lifetime value records — measures rate quality of the guest portfolio."
    - name: "avg_length_of_stay"
      expr: AVG(CAST(average_length_of_stay AS DOUBLE))
      comment: "Average length of stay across guest LTV records — measures stay depth and revenue opportunity."
    - name: "avg_nps_score"
      expr: AVG(CAST(average_nps_score AS DOUBLE))
      comment: "Average NPS score across guest portfolio — links guest satisfaction to lifetime value for experience investment decisions."
    - name: "avg_gss_score"
      expr: AVG(CAST(average_gss_score AS DOUBLE))
      comment: "Average GSS score across guest LTV records — measures satisfaction quality of high-value guests."
    - name: "total_room_revenue"
      expr: SUM(CAST(total_room_revenue AS DOUBLE))
      comment: "Total room revenue contribution across guest portfolio — measures rooms division share of LTV."
    - name: "total_ancillary_revenue"
      expr: SUM(CAST(total_ancillary_revenue AS DOUBLE))
      comment: "Total ancillary revenue contribution across guest portfolio — measures upsell share of LTV."
    - name: "avg_next_stay_propensity_score"
      expr: AVG(CAST(next_stay_propensity_score AS DOUBLE))
      comment: "Average next-stay propensity score — forward-looking demand signal for targeted re-engagement campaigns."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across LTV records — monitors CRM data completeness for model reliability."
    - name: "unique_guest_count"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of unique guests with LTV records — measures CRM coverage of the active guest base."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_predictive_score`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "AI/ML predictive scoring metrics for churn risk, upsell propensity, and next-best-offer targeting. Drives personalization, retention, and revenue optimization campaigns."
  source: "`vibe_travel_hospitality_v1`.`guest`.`predictive_score`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property scope for predictive scores — enables property-level AI/ML activation and targeting."
    - name: "score_type"
      expr: score_type
      comment: "Type of predictive score (churn, upsell, NBO) — primary filter for campaign type selection."
    - name: "model_version"
      expr: model_version
      comment: "ML model version that produced the score — enables model performance comparison and governance."
    - name: "prediction_date"
      expr: DATE_TRUNC('month', prediction_date)
      comment: "Month of prediction — enables trend analysis of model output volume and score distribution."
    - name: "next_best_offer_code"
      expr: next_best_offer_code
      comment: "Next best offer code recommended — measures offer distribution and campaign targeting coverage."
  measures:
    - name: "total_scored_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of unique guests with active predictive scores — measures AI/ML model coverage of the guest base."
    - name: "total_score_records"
      expr: COUNT(1)
      comment: "Total predictive score records — baseline volume for model run monitoring and coverage tracking."
    - name: "avg_score_value"
      expr: AVG(CAST(score_value AS DOUBLE))
      comment: "Average predictive score value across all scored guests — monitors overall model output distribution."
    - name: "avg_next_best_offer_score"
      expr: AVG(CAST(next_best_offer_score AS DOUBLE))
      comment: "Average next-best-offer propensity score — measures strength of NBO recommendations for campaign ROI forecasting."
    - name: "high_upsell_propensity_count"
      expr: SUM(CASE WHEN score_type = 'upsell' AND score_value >= 0.7 THEN 1 ELSE 0 END)
      comment: "Count of guests with high upsell propensity (score >= 0.7) — sizes the upsell campaign addressable audience."
    - name: "expired_score_count"
      expr: SUM(CASE WHEN expires_at_timestamp < CURRENT_TIMESTAMP() THEN 1 ELSE 0 END)
      comment: "Count of expired predictive scores — monitors model freshness and triggers re-scoring pipeline runs."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_privacy_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Privacy request (DSAR/erasure/rectification) operational metrics. Drives GDPR/CCPA compliance SLA monitoring, regulatory risk management, and privacy operations resourcing."
  source: "`vibe_travel_hospitality_v1`.`guest`.`privacy_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of privacy request (access, erasure, rectification, portability) — primary filter for compliance workload analysis."
    - name: "request_status"
      expr: request_status
      comment: "Current status of the request (open, in-progress, completed, rejected) — operational SLA monitoring dimension."
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction (GDPR, CCPA, LGPD) — enables jurisdiction-level compliance reporting."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the request was submitted — measures request intake channel distribution."
    - name: "submission_date"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of request submission — enables trend analysis of privacy request volume for resourcing."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the privacy request (fulfilled, rejected, partially fulfilled) — measures compliance effectiveness."
  measures:
    - name: "total_requests"
      expr: COUNT(1)
      comment: "Total privacy requests received — baseline volume KPI for compliance operations resourcing and regulatory reporting."
    - name: "open_request_count"
      expr: SUM(CASE WHEN request_status NOT IN ('completed', 'rejected', 'closed') THEN 1 ELSE 0 END)
      comment: "Count of open/in-progress privacy requests — measures current compliance operations backlog."
    - name: "legal_hold_count"
      expr: SUM(CASE WHEN legal_hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of requests under legal hold — measures legal risk exposure requiring escalated handling."
    - name: "extension_granted_count"
      expr: SUM(CASE WHEN extension_granted_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of requests granted deadline extensions — monitors SLA compliance risk and regulatory exposure."
    - name: "third_party_notification_required_count"
      expr: SUM(CASE WHEN third_party_notification_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of requests requiring third-party notification — measures downstream data processor compliance obligations."
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN request_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of privacy requests completed — primary GDPR/CCPA SLA compliance KPI for regulatory reporting."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest profile quality, consent, and loyalty enrollment metrics. Drives CRM data governance, marketing eligibility, and loyalty program growth decisions."
  source: "`vibe_travel_hospitality_v1`.`guest`.`profile`"
  dimensions:
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Current loyalty tier of the guest — primary segmentation for loyalty program investment and benefit design."
    - name: "guest_type"
      expr: guest_type
      comment: "Guest classification type (leisure, corporate, group) — enables segment-level profile quality analysis."
    - name: "profile_status"
      expr: profile_status
      comment: "Active/inactive/merged status of the profile — critical for CRM data quality and active base sizing."
    - name: "country_of_residence_code"
      expr: country_of_residence_code
      comment: "Guest country of residence — enables geographic market analysis and GDPR jurisdiction scoping."
    - name: "preferred_language_code"
      expr: preferred_language_code
      comment: "Guest preferred language — drives localization and communication personalization decisions."
    - name: "loyalty_enrollment_date"
      expr: DATE_TRUNC('month', loyalty_enrollment_date)
      comment: "Month of loyalty enrollment — enables cohort analysis of loyalty program growth."
    - name: "vip_status"
      expr: vip_status
      comment: "VIP status classification — enables VIP segment sizing and service investment analysis."
    - name: "is_merge_survivor"
      expr: is_merge_survivor
      comment: "Whether this profile survived a merge — filters to canonical profiles for accurate guest counting."
  measures:
    - name: "total_active_profiles"
      expr: SUM(CASE WHEN profile_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active guest profiles — primary CRM base size KPI for marketing reach and loyalty program scale."
    - name: "total_profiles"
      expr: COUNT(1)
      comment: "Total guest profile records including all statuses — baseline for data quality and deduplication analysis."
    - name: "loyalty_enrolled_count"
      expr: SUM(CASE WHEN loyalty_member_number IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of profiles with loyalty membership — measures loyalty program enrollment penetration."
    - name: "loyalty_enrollment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN loyalty_member_number IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of profiles enrolled in loyalty program — key loyalty growth and acquisition KPI."
    - name: "marketing_opt_in_count"
      expr: SUM(CASE WHEN marketing_opt_in = TRUE THEN 1 ELSE 0 END)
      comment: "Count of profiles opted into marketing communications — measures addressable marketing audience size."
    - name: "marketing_opt_in_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN marketing_opt_in = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of profiles opted into marketing — critical for campaign reach planning and consent compliance."
    - name: "gdpr_erasure_requested_count"
      expr: SUM(CASE WHEN gdpr_erasure_requested = TRUE THEN 1 ELSE 0 END)
      comment: "Count of profiles with active GDPR erasure requests — monitors privacy compliance risk and operational backlog."
    - name: "merged_profile_count"
      expr: SUM(CASE WHEN merged_into_profile_id IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of profiles that have been merged — measures CRM deduplication activity and data quality improvement."
    - name: "vip_profile_count"
      expr: SUM(CASE WHEN vip_status IS NOT NULL AND vip_status != '' THEN 1 ELSE 0 END)
      comment: "Count of profiles with VIP status — measures VIP segment size for service resource planning."
    - name: "sms_opt_in_count"
      expr: SUM(CASE WHEN sms_opt_in = TRUE THEN 1 ELSE 0 END)
      comment: "Count of profiles opted into SMS communications — measures mobile channel addressable audience."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_profile_merge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest profile merge quality and data governance metrics — KPIs for CRM data quality management, deduplication effectiveness, and GDPR consent continuity during profile consolidation."
  source: "`vibe_travel_hospitality_v1`.`guest`.`profile_merge_history`"
  dimensions:
    - name: "merge_status"
      expr: merge_status
      comment: "Status of the merge operation (e.g., completed, failed, rolled back) for data quality monitoring."
    - name: "merge_method"
      expr: merge_method
      comment: "Method used for the merge (e.g., automatic, manual, rule-based) for process quality analysis."
    - name: "merge_reason"
      expr: merge_reason
      comment: "Reason for the merge (e.g., duplicate detection, guest request) for root cause analysis."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the merge for data quality governance reporting."
    - name: "merge_month"
      expr: DATE_TRUNC('MONTH', merge_timestamp)
      comment: "Month the merge was executed for trend analysis of deduplication activity."
  measures:
    - name: "total_profile_merges"
      expr: COUNT(DISTINCT profile_merge_history_id)
      comment: "Total number of profile merge operations — measures deduplication activity and CRM data quality investment."
    - name: "successful_merge_count"
      expr: COUNT(DISTINCT CASE WHEN merge_status = 'COMPLETED' THEN profile_merge_history_id END)
      comment: "Number of successfully completed profile merges — measures deduplication throughput and effectiveness."
    - name: "merge_success_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN merge_status = 'COMPLETED' THEN profile_merge_history_id END) / NULLIF(COUNT(DISTINCT profile_merge_history_id), 0), 2)
      comment: "Percentage of merge operations that completed successfully — low rates indicate data quality or system issues."
    - name: "average_matching_confidence_score"
      expr: AVG(CAST(matching_confidence_score AS DOUBLE))
      comment: "Average confidence score of profile matching — measures algorithmic merge quality and risk of false positives."
    - name: "gdpr_consent_retained_merge_count"
      expr: COUNT(DISTINCT CASE WHEN gdpr_consent_retained = TRUE THEN profile_merge_history_id END)
      comment: "Number of merges where GDPR consent was successfully retained — critical compliance KPI for data subject rights continuity."
    - name: "rollback_eligible_merge_count"
      expr: COUNT(DISTINCT CASE WHEN rollback_eligible_flag = TRUE THEN profile_merge_history_id END)
      comment: "Number of merges still eligible for rollback — measures reversibility window for data governance risk management."
    - name: "total_loyalty_points_transferred"
      expr: SUM(CAST(loyalty_points_transferred AS DOUBLE))
      comment: "Total loyalty points transferred during profile merges — financial impact KPI for loyalty liability management."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_profile_merge_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest profile deduplication and merge quality metrics. Drives CRM data governance, identity resolution effectiveness, and GDPR compliance for merged records."
  source: "`vibe_travel_hospitality_v1`.`guest`.`profile_merge_history`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the merge was initiated — enables property-level data quality analysis."
    - name: "merge_status"
      expr: merge_status
      comment: "Status of the merge operation (completed, failed, rolled-back) — monitors merge pipeline reliability."
    - name: "merge_method"
      expr: merge_method
      comment: "Method used for merge (automated, manual, bulk) — measures automation rate of deduplication operations."
    - name: "merge_reason"
      expr: merge_reason
      comment: "Reason for the merge (duplicate detection, guest request, system migration) — enables root cause analysis."
    - name: "merge_timestamp"
      expr: DATE_TRUNC('month', merge_timestamp)
      comment: "Month of merge operation — enables trend analysis of deduplication activity volume."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the merge (validated, failed, pending) — monitors merge quality assurance."
  measures:
    - name: "total_merges"
      expr: COUNT(1)
      comment: "Total profile merge operations — baseline KPI for CRM deduplication activity and data quality investment."
    - name: "successful_merge_count"
      expr: SUM(CASE WHEN merge_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of successfully completed merges — measures deduplication pipeline effectiveness."
    - name: "merge_success_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN merge_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of merge operations that completed successfully — primary data quality pipeline reliability KPI."
    - name: "rollback_eligible_count"
      expr: SUM(CASE WHEN rollback_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of merges still eligible for rollback — measures reversible merge exposure for data governance risk."
    - name: "avg_matching_confidence_score"
      expr: AVG(CAST(matching_confidence_score AS DOUBLE))
      comment: "Average confidence score of merge matching — monitors identity resolution algorithm quality."
    - name: "gdpr_consent_retained_count"
      expr: SUM(CASE WHEN gdpr_consent_retained = TRUE THEN 1 ELSE 0 END)
      comment: "Count of merges where GDPR consent was retained — monitors privacy compliance in deduplication operations."
    - name: "avg_loyalty_points_transferred"
      expr: AVG(CAST(loyalty_points_transferred AS DOUBLE))
      comment: "Average loyalty points transferred per merge — measures loyalty program impact of deduplication operations."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest segmentation metrics tracking segment assignment quality, revenue contribution by segment, and loyalty program eligibility — KPIs for revenue strategy, pricing, and targeted marketing investment decisions."
  source: "`vibe_travel_hospitality_v1`.`guest`.`segment`"
  filter: segment_status = 'ACTIVE'
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of segment (e.g., behavioral, demographic, value-based) for segmentation strategy analysis."
    - name: "segment_category"
      expr: segment_category
      comment: "Category of the segment for hierarchical reporting and campaign targeting."
    - name: "rate_strategy_type"
      expr: rate_strategy_type
      comment: "Rate strategy associated with the segment for pricing alignment analysis."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign guests to the segment (e.g., rule-based, ML model) for data quality governance."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Hierarchy level of the segment for parent-child segment reporting."
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', assignment_date)
      comment: "Month of segment assignment for trend analysis of segment population changes."
  measures:
    - name: "total_segment_assignments"
      expr: COUNT(DISTINCT segment_id)
      comment: "Total number of active segment assignments — measures segmentation coverage across the guest base."
    - name: "unique_segmented_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guests with an active segment assignment — measures segmentation model coverage."
    - name: "average_assignment_confidence_score"
      expr: AVG(CAST(assignment_confidence_score AS DOUBLE))
      comment: "Average confidence score of segment assignments — low scores indicate model retraining or rule refinement is needed."
    - name: "average_revpar_contribution_pct"
      expr: AVG(CAST(revpar_contribution_pct AS DOUBLE))
      comment: "Average RevPAR contribution percentage by segment — used to prioritize high-value segments in revenue strategy."
    - name: "average_ancillary_revenue_per_stay"
      expr: AVG(CAST(ancillary_revenue_per_stay AS DOUBLE))
      comment: "Average ancillary revenue per stay by segment — informs upsell strategy and package design by segment."
    - name: "average_fb_attachment_rate_pct"
      expr: AVG(CAST(fb_attachment_rate_pct AS DOUBLE))
      comment: "Average F&B attachment rate by segment — identifies segments with high F&B affinity for targeted promotions."
    - name: "loyalty_eligible_segment_count"
      expr: COUNT(DISTINCT CASE WHEN loyalty_points_eligible = TRUE THEN segment_id END)
      comment: "Number of segments eligible for loyalty points earning — measures loyalty program reach across segmentation model."
    - name: "yield_managed_segment_count"
      expr: COUNT(DISTINCT CASE WHEN yield_management_flag = TRUE THEN segment_id END)
      comment: "Number of segments subject to yield management — measures revenue management coverage across the segment portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_segment_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest segment membership and assignment quality metrics. Drives marketing segmentation effectiveness, CRM targeting precision, and segment lifecycle management."
  source: "`vibe_travel_hospitality_v1`.`guest`.`segment_membership`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current status of segment membership (active, expired, pending) — primary filter for active segment population."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign guest to segment (rules-based, ML, manual) — measures segmentation automation quality."
    - name: "assignment_reason_code"
      expr: assignment_reason_code
      comment: "Reason code for segment assignment — enables assignment quality and override analysis."
    - name: "assignment_date"
      expr: DATE_TRUNC('month', assignment_date)
      comment: "Month of segment assignment — enables trend analysis of segmentation activity and model refresh cycles."
    - name: "assignment_expiry_date"
      expr: DATE_TRUNC('month', assignment_expiry_date)
      comment: "Month segment membership expires — enables proactive re-segmentation planning."
  measures:
    - name: "total_active_memberships"
      expr: SUM(CASE WHEN membership_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active segment memberships — measures current segmented audience size for campaign targeting."
    - name: "total_memberships"
      expr: COUNT(1)
      comment: "Total segment membership records — baseline for segmentation coverage and model output volume."
    - name: "unique_segmented_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of unique guests with segment assignments — measures segmentation model coverage of the guest base."
    - name: "avg_assignment_confidence_score"
      expr: AVG(CAST(assignment_confidence_score AS DOUBLE))
      comment: "Average confidence score of segment assignments — monitors ML segmentation model quality and reliability."
    - name: "high_confidence_assignment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN assignment_confidence_score >= 0.8 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of segment assignments with high confidence (>=0.8) — measures segmentation model precision for targeting quality."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_stay_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core guest stay performance metrics covering revenue, ADR, length of stay, ancillary attachment, and loyalty engagement. Primary KPI surface for revenue management and guest experience steering."
  source: "`vibe_travel_hospitality_v1`.`guest`.`stay_history`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the stay occurred — enables property-level performance benchmarking."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment classification (e.g., transient, group, corporate) for revenue mix analysis."
    - name: "booking_channel_code"
      expr: booking_channel_code
      comment: "Channel through which the booking was made — critical for distribution cost and channel mix analysis."
    - name: "stay_status"
      expr: stay_status
      comment: "Status of the stay record (checked-in, checked-out, no-show, cancelled) for operational filtering."
    - name: "loyalty_tier_at_stay"
      expr: loyalty_tier_at_stay
      comment: "Guest loyalty tier at time of stay — enables tier-based revenue and behavior analysis."
    - name: "room_type_code"
      expr: room_type_code
      comment: "Room type occupied — supports room-type revenue mix and upsell analysis."
    - name: "rate_plan_code"
      expr: rate_plan_code
      comment: "Rate plan applied to the stay — supports rate strategy and yield analysis."
    - name: "arrival_date"
      expr: DATE_TRUNC('month', arrival_date)
      comment: "Arrival month bucket for trend analysis of stay volume and revenue over time."
    - name: "guest_type"
      expr: guest_type
      comment: "Classification of guest type (leisure, business, group) for segment-level performance analysis."
    - name: "vip_code"
      expr: vip_code
      comment: "VIP designation code at time of stay — enables VIP segment revenue and service analysis."
  measures:
    - name: "total_room_revenue"
      expr: SUM(CAST(room_revenue AS DOUBLE))
      comment: "Total room revenue across all stays. Primary top-line revenue KPI for rooms division."
    - name: "total_ancillary_revenue"
      expr: SUM(CAST(ancillary_revenue AS DOUBLE))
      comment: "Total ancillary (non-room) revenue — measures upsell and attachment performance."
    - name: "total_fb_revenue"
      expr: SUM(CAST(fb_revenue AS DOUBLE))
      comment: "Total food and beverage revenue attached to stays — measures F&B attachment rate contribution."
    - name: "total_folio_revenue"
      expr: SUM(CAST(total_folio_amount AS DOUBLE))
      comment: "Total folio amount including all charges — comprehensive revenue per stay portfolio measure."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across stays — required for financial reporting and compliance."
    - name: "avg_daily_rate"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average Daily Rate across stays. Core RevPAR component and pricing performance KPI. (Column renamed from revpar per VREQ-044 — correctly measures revenue per occupied room night = ADR.)"
    - name: "avg_length_of_stay_nights"
      expr: AVG(CAST(length_of_stay_nights AS DOUBLE))
      comment: "Average length of stay in nights. Drives revenue forecasting and operational planning. (Uses length_of_stay_nights per VREQ-064.)"
    - name: "avg_gss_score"
      expr: AVG(CAST(gss_score AS DOUBLE))
      comment: "Average Guest Satisfaction Score across stays — primary guest experience quality KPI."
    - name: "total_stay_count"
      expr: COUNT(1)
      comment: "Total number of stay records — baseline volume KPI for occupancy and demand analysis."
    - name: "unique_guest_count"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of unique guests with stays — measures guest reach and repeat visitation base."
    - name: "service_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN service_recovery_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stays requiring service recovery — key guest experience quality and operational risk KPI."
    - name: "complimentary_stay_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN complimentary_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stays that were complimentary — monitors comp room cost and loyalty program economics."
    - name: "avg_room_revenue_per_stay"
      expr: AVG(CAST(room_revenue AS DOUBLE))
      comment: "Average room revenue per stay record — measures per-stay monetization effectiveness."
    - name: "avg_total_folio_per_stay"
      expr: AVG(CAST(total_folio_amount AS DOUBLE))
      comment: "Average total folio value per stay — comprehensive per-stay spend KPI for revenue management."
    - name: "avg_ancillary_revenue_per_stay"
      expr: AVG(CAST(ancillary_revenue AS DOUBLE))
      comment: "Average ancillary revenue per stay — measures upsell and cross-sell effectiveness per visit."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_vip_designation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "VIP guest designation and service commitment metrics. Drives VIP program economics, service resource allocation, and high-value guest retention strategy."
  source: "`vibe_travel_hospitality_v1`.`guest`.`vip_designation`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property of the VIP designation — enables property-level VIP portfolio and service resource analysis."
    - name: "vip_level"
      expr: vip_level
      comment: "VIP level classification — primary segmentation for service tier investment and resource allocation."
    - name: "designation_status"
      expr: designation_status
      comment: "Current status of the VIP designation (active, expired, revoked) — filters to active VIP commitments."
    - name: "designation_scope"
      expr: designation_scope
      comment: "Scope of the VIP designation (property, brand, global) — measures VIP program reach and commitment level."
    - name: "effective_from"
      expr: DATE_TRUNC('year', effective_from)
      comment: "Year VIP designation became effective — enables cohort analysis of VIP program growth."
    - name: "designation_reason"
      expr: designation_reason
      comment: "Reason for VIP designation (revenue, loyalty, celebrity, etc.) — measures VIP qualification criteria distribution."
  measures:
    - name: "total_active_vip_designations"
      expr: SUM(CASE WHEN designation_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active VIP designations — measures current VIP portfolio size for service resource planning."
    - name: "total_vip_designations"
      expr: COUNT(1)
      comment: "Total VIP designation records — baseline for VIP program scale and historical trend analysis."
    - name: "unique_vip_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of unique guests with VIP designations — measures VIP program reach across the guest base."
    - name: "avg_revenue_threshold"
      expr: AVG(CAST(revenue_threshold_amount AS DOUBLE))
      comment: "Average revenue threshold for VIP qualification — monitors VIP program economics and qualification bar."
    - name: "total_revenue_threshold"
      expr: SUM(CAST(revenue_threshold_amount AS DOUBLE))
      comment: "Total revenue threshold committed across VIP designations — measures total VIP program revenue commitment."
    - name: "gm_greeting_required_count"
      expr: SUM(CASE WHEN gm_greeting_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of VIP guests requiring GM greeting — measures high-touch service commitment volume for GM scheduling."
    - name: "security_escort_required_count"
      expr: SUM(CASE WHEN security_escort_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of VIP guests requiring security escort — measures security resource commitment for VIP arrivals."
    - name: "upgrade_eligible_count"
      expr: SUM(CASE WHEN upgrade_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of VIP guests eligible for room upgrades — measures upgrade inventory commitment and upsell opportunity cost."
    - name: "media_blackout_count"
      expr: SUM(CASE WHEN media_blackout = TRUE THEN 1 ELSE 0 END)
      comment: "Count of VIP guests with media blackout policy — measures privacy-sensitive VIP handling volume."
$$;
