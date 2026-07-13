-- Metric views for domain: customer | Business: Retail | Version: 2 | Generated on: 2026-07-12 14:06:09

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core customer profile metrics tracking acquisition, lifecycle distribution, and identity quality across the customer master. Used by marketing, CRM, and executive teams to understand the active customer base composition and data quality health."
  source: "`vibe_retail_v1`.`customer`.`profile`"
  dimensions:
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Customer lifecycle stage (e.g., prospect, active, lapsed, churned) for cohort segmentation and lifecycle management reporting."
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which the customer was acquired (e.g., organic, paid search, referral, in-store) for acquisition source analysis."
    - name: "customer_type"
      expr: customer_type
      comment: "Legal-entity type of the customer (individual vs. organization) for B2C vs. B2B segmentation."
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the customer profile (active, inactive, merged, deleted) for active base sizing."
    - name: "preferred_language"
      expr: preferred_language
      comment: "Customer preferred language for localization and communication strategy analysis."
    - name: "preferred_contact_method"
      expr: preferred_contact_method
      comment: "Customer preferred contact method (email, SMS, phone, push) for channel mix planning."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Customer loyalty tier at the time of profile record for tier-based performance analysis."
    - name: "gender"
      expr: gender
      comment: "Customer gender for demographic segmentation and assortment planning."
    - name: "acquisition_year_month"
      expr: DATE_TRUNC('month', acquisition_date)
      comment: "Month of customer acquisition for cohort and vintage analysis."
    - name: "is_current_record"
      expr: is_current
      comment: "Flag indicating whether this is the current SCD-2 version of the profile record, used to filter to the active golden record."
  measures:
    - name: "total_active_profiles"
      expr: COUNT(CASE WHEN profile_status = 'active' AND is_current = TRUE THEN profile_id END)
      comment: "Total number of active, current customer profiles. Core KPI for sizing the addressable customer base and tracking net customer growth."
    - name: "total_profiles"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total distinct customer profiles including all statuses. Used as the denominator for activation and churn rate calculations."
    - name: "avg_mdm_confidence_score"
      expr: AVG(CAST(mdm_confidence_score AS DOUBLE))
      comment: "Average identity resolution confidence score from the customer master data system. Tracks data quality of the golden record — low scores indicate identity matching issues requiring remediation."
    - name: "min_mdm_confidence_score"
      expr: MIN(CAST(mdm_confidence_score AS DOUBLE))
      comment: "Minimum identity resolution confidence score across all profiles. Flags the worst-quality identity records for data stewardship prioritization."
    - name: "profiles_with_mobile"
      expr: COUNT(CASE WHEN mobile_number IS NOT NULL AND mobile_number <> '' THEN profile_id END)
      comment: "Number of profiles with a mobile number on record. Drives SMS and push notification reachability estimates for campaign planning."
    - name: "profiles_with_email"
      expr: COUNT(CASE WHEN email_address IS NOT NULL AND email_address <> '' THEN profile_id END)
      comment: "Number of profiles with an email address on record. Drives email channel reachability and deliverability baseline for marketing operations."
    - name: "new_profiles_count"
      expr: COUNT(CASE WHEN is_current = TRUE THEN profile_id END)
      comment: "Count of current (non-superseded) profile records. Used alongside total_profiles to measure SCD-2 churn and record freshness."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer account financial and operational metrics covering credit exposure, account status distribution, and B2B account health. Used by finance, credit risk, and sales operations teams for portfolio management and credit limit governance."
  source: "`vibe_retail_v1`.`customer`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the account (active, suspended, closed) for portfolio health segmentation."
    - name: "account_type"
      expr: account_type
      comment: "Type of account (retail, wholesale, corporate, employee) for segment-level financial analysis."
    - name: "tier"
      expr: tier
      comment: "Account tier (e.g., standard, silver, gold, platinum) for value-tier performance benchmarking."
    - name: "preferred_channel"
      expr: preferred_channel
      comment: "Preferred purchase channel for the account (in-store, online, mobile) for channel mix and omnichannel strategy."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the account is denominated for multi-currency credit exposure reporting."
    - name: "b2b_pricing_flag"
      expr: b2b_pricing_flag
      comment: "Indicates whether the account has B2B negotiated pricing, used to separate B2B from B2C account analytics."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Indicates tax-exempt status for compliance and revenue reporting adjustments."
    - name: "loyalty_program_enrolled"
      expr: loyalty_program_enrolled
      comment: "Whether the account is enrolled in the loyalty program, for loyalty penetration rate analysis."
    - name: "is_current_record"
      expr: is_current
      comment: "SCD-2 current record flag to filter to the active version of each account."
    - name: "open_year_month"
      expr: DATE_TRUNC('month', open_date)
      comment: "Month the account was opened for vintage cohort and account acquisition trend analysis."
  measures:
    - name: "total_active_accounts"
      expr: COUNT(CASE WHEN account_status = 'active' AND is_current = TRUE THEN account_id END)
      comment: "Total number of currently active accounts. Primary KPI for measuring the active customer account base size."
    - name: "total_credit_limit_extended"
      expr: SUM(CASE WHEN account_status = 'active' AND is_current = TRUE THEN CAST(credit_limit AS DOUBLE) ELSE 0 END)
      comment: "Total credit limit extended across all active accounts. Key risk metric for credit exposure management and treasury planning."
    - name: "avg_credit_limit"
      expr: AVG(CASE WHEN account_status = 'active' AND is_current = TRUE THEN CAST(credit_limit AS DOUBLE) END)
      comment: "Average credit limit per active account. Benchmarks credit generosity and informs credit policy calibration."
    - name: "suspended_accounts_count"
      expr: COUNT(CASE WHEN account_status = 'suspended' AND is_current = TRUE THEN account_id END)
      comment: "Number of currently suspended accounts. Operational risk indicator for collections and customer recovery programs."
    - name: "loyalty_enrolled_accounts"
      expr: COUNT(CASE WHEN loyalty_program_enrolled = TRUE AND is_current = TRUE THEN account_id END)
      comment: "Number of accounts enrolled in the loyalty program. Drives loyalty penetration rate and program ROI calculations."
    - name: "tax_exempt_accounts_count"
      expr: COUNT(CASE WHEN tax_exempt_flag = TRUE AND is_current = TRUE THEN account_id END)
      comment: "Number of tax-exempt accounts. Required for revenue recognition adjustments and tax compliance reporting."
    - name: "b2b_accounts_count"
      expr: COUNT(CASE WHEN b2b_pricing_flag = TRUE AND is_current = TRUE THEN account_id END)
      comment: "Number of accounts with B2B negotiated pricing. Tracks B2B portfolio size for wholesale and corporate sales strategy."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer interaction engagement metrics covering channel activity, sentiment, and campaign response. Used by marketing, CRM, and customer experience teams to measure engagement quality, channel effectiveness, and NPS trends."
  source: "`vibe_retail_v1`.`customer`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of customer interaction (email, SMS, call, chat, in-store visit, web session) for channel-level engagement analysis."
    - name: "channel"
      expr: channel
      comment: "Interaction channel (digital, physical, contact-center) for omnichannel engagement mix reporting."
    - name: "direction"
      expr: direction
      comment: "Direction of interaction (inbound vs. outbound) for contact center workload and proactive outreach analysis."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the interaction (resolved, escalated, converted, no-action) for effectiveness and resolution rate tracking."
    - name: "device_type"
      expr: device_type
      comment: "Device used during the interaction (mobile, desktop, tablet, in-store terminal) for device mix and UX optimization."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the interaction (delivered, bounced, failed, pending) for communication deliverability monitoring."
    - name: "interaction_year_month"
      expr: DATE_TRUNC('month', interaction_timestamp)
      comment: "Month of the interaction for trend analysis of engagement volume and seasonality."
    - name: "digital_property"
      expr: digital_property
      comment: "Digital property where the interaction occurred (website, mobile app, email) for property-level engagement analysis."
  measures:
    - name: "total_interactions"
      expr: COUNT(interaction_id)
      comment: "Total number of customer interactions. Baseline engagement volume KPI used to track customer touchpoint frequency and contact center load."
    - name: "distinct_engaged_customers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct customers with at least one interaction. Measures active engagement breadth — a key input to reachability and churn risk models."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across all interactions. Tracks overall customer satisfaction trend — declining scores trigger CX intervention programs."
    - name: "email_open_count"
      expr: COUNT(CASE WHEN email_opened_flag = TRUE THEN interaction_id END)
      comment: "Number of email interactions where the email was opened. Core email marketing KPI for measuring message relevance and subject line effectiveness."
    - name: "email_click_count"
      expr: COUNT(CASE WHEN email_clicked_flag = TRUE THEN interaction_id END)
      comment: "Number of email interactions where a link was clicked. Measures email engagement depth and call-to-action effectiveness."
    - name: "unsubscribe_count"
      expr: COUNT(CASE WHEN unsubscribed_flag = TRUE THEN interaction_id END)
      comment: "Number of interactions resulting in an unsubscribe. Tracks list attrition rate — a leading indicator of email fatigue and over-communication."
    - name: "total_interaction_duration_seconds"
      expr: SUM(CAST(duration_seconds AS DOUBLE))
      comment: "Total interaction duration in seconds across all interactions. Drives contact center cost modeling and average handle time benchmarking."
    - name: "avg_interaction_duration_seconds"
      expr: AVG(CAST(duration_seconds AS DOUBLE))
      comment: "Average interaction duration in seconds. Key contact center efficiency KPI — used to benchmark handle time and identify training needs."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer contact record quality and reachability metrics. Used by marketing operations and data governance teams to monitor contact data completeness, verification rates, and channel reachability for campaign execution."
  source: "`vibe_retail_v1`.`customer`.`contact`"
  dimensions:
    - name: "contact_type"
      expr: contact_type
      comment: "Type of contact record (email, mobile, phone, social) for channel-specific reachability analysis."
    - name: "contact_status"
      expr: contact_status
      comment: "Status of the contact record (active, bounced, unsubscribed, invalid) for deliverability and suppression management."
    - name: "is_primary"
      expr: is_primary
      comment: "Whether this is the primary contact record for the customer, for primary channel reachability reporting."
    - name: "is_verified"
      expr: is_verified
      comment: "Whether the contact has been verified, for data quality and verified reachability rate tracking."
    - name: "country_code"
      expr: country_code
      comment: "Country code of the contact for geographic reachability and compliance (e.g., GDPR jurisdiction) analysis."
    - name: "language_preference"
      expr: language_preference
      comment: "Language preference associated with the contact for localized communication planning."
    - name: "consent_source"
      expr: consent_source
      comment: "Source system or channel where consent for this contact was captured, for consent audit traceability."
  measures:
    - name: "total_active_contacts"
      expr: COUNT(CASE WHEN contact_status = 'active' THEN contact_id END)
      comment: "Total number of active contact records. Measures the reachable contact universe for campaign execution planning."
    - name: "verified_contacts_count"
      expr: COUNT(CASE WHEN is_verified = TRUE THEN contact_id END)
      comment: "Number of verified contact records. Tracks contact data quality — verified contacts have higher deliverability and lower bounce risk."
    - name: "primary_contacts_count"
      expr: COUNT(CASE WHEN is_primary = TRUE THEN contact_id END)
      comment: "Number of primary contact records. Represents the preferred reachability channel per customer for single-touch campaign targeting."
    - name: "distinct_reachable_customers"
      expr: COUNT(DISTINCT CASE WHEN contact_status = 'active' THEN profile_id END)
      comment: "Number of distinct customers with at least one active contact record. Core reachability KPI for campaign audience sizing."
    - name: "distinct_verified_customers"
      expr: COUNT(DISTINCT CASE WHEN is_verified = TRUE THEN profile_id END)
      comment: "Number of distinct customers with at least one verified contact. Measures high-confidence reachability for premium campaign segments."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_b2b_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "B2B contract portfolio metrics covering contract value, credit exposure, renewal risk, and discount depth. Used by B2B sales, finance, and procurement teams to manage corporate customer contract health and revenue commitments."
  source: "`vibe_retail_v1`.`customer`.`b2b_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the B2B contract (active, expired, terminated, pending-renewal) for portfolio health segmentation."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of B2B contract (master, amendment, renewal, framework) for contract structure analysis."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency (monthly, quarterly, annual) for cash flow forecasting and AR management."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency revenue and credit exposure reporting."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the contract auto-renews, for renewal pipeline and revenue retention forecasting."
    - name: "pricing_tier"
      expr: pricing_tier
      comment: "Negotiated pricing tier for the contract for discount depth and margin impact analysis."
    - name: "renewal_type"
      expr: renewal_type
      comment: "Type of renewal (auto, manual, renegotiated) for contract lifecycle management."
    - name: "effective_start_year_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the contract became effective for contract vintage and cohort analysis."
  measures:
    - name: "total_active_contracts"
      expr: COUNT(CASE WHEN contract_status = 'active' THEN b2b_contract_id END)
      comment: "Total number of active B2B contracts. Core B2B portfolio size KPI for sales coverage and account management planning."
    - name: "total_contract_value"
      expr: SUM(CASE WHEN contract_status = 'active' THEN CAST(contract_value AS DOUBLE) ELSE 0 END)
      comment: "Total committed contract value across active B2B contracts. Primary revenue commitment KPI for B2B sales forecasting and financial planning."
    - name: "avg_contract_value"
      expr: AVG(CASE WHEN contract_status = 'active' THEN CAST(contract_value AS DOUBLE) END)
      comment: "Average contract value per active B2B contract. Benchmarks deal size and informs sales strategy for upsell and expansion opportunities."
    - name: "total_credit_limit_b2b"
      expr: SUM(CASE WHEN contract_status = 'active' THEN CAST(credit_limit AS DOUBLE) ELSE 0 END)
      comment: "Total credit limit extended across active B2B contracts. Key credit risk metric for B2B portfolio exposure management."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across B2B contracts. Tracks margin erosion from negotiated discounts — a critical input to B2B profitability analysis."
    - name: "total_volume_commitment"
      expr: SUM(CASE WHEN contract_status = 'active' THEN CAST(volume_commitment AS DOUBLE) ELSE 0 END)
      comment: "Total volume commitment across active B2B contracts. Drives demand planning and inventory allocation for corporate accounts."
    - name: "contracts_expiring_soon"
      expr: COUNT(CASE WHEN contract_status = 'active' AND effective_end_date <= DATE_ADD(CURRENT_DATE(), 90) THEN b2b_contract_id END)
      comment: "Number of active contracts expiring within 90 days. Renewal risk KPI that triggers proactive account management outreach to prevent revenue churn."
    - name: "auto_renewal_contracts_count"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE AND contract_status = 'active' THEN b2b_contract_id END)
      comment: "Number of active contracts set to auto-renew. Measures predictable recurring revenue base and reduces manual renewal workload tracking."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_wishlist`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer wishlist and gift registry engagement metrics covering conversion rates, item value, and sharing behavior. Used by merchandising, marketing, and e-commerce teams to identify high-intent purchase signals and optimize product discovery."
  source: "`vibe_retail_v1`.`customer`.`wishlist`"
  dimensions:
    - name: "wishlist_type"
      expr: wishlist_type
      comment: "Type of wishlist (personal, gift-registry, baby-registry, wedding) for registry-specific conversion and revenue analysis."
    - name: "wishlist_status"
      expr: wishlist_status
      comment: "Current status of the wishlist (active, archived, converted, deleted) for active engagement base sizing."
    - name: "channel"
      expr: channel
      comment: "Channel where the wishlist was created (web, mobile, in-store) for channel-specific wishlist behavior analysis."
    - name: "conversion_status"
      expr: conversion_status
      comment: "Conversion status of the wishlist (not-converted, partially-converted, fully-converted) for purchase intent funnel analysis."
    - name: "visibility"
      expr: visibility
      comment: "Visibility setting of the wishlist (private, shared, public) for social commerce and sharing behavior analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device type used to create the wishlist (mobile, desktop, tablet) for device-specific UX optimization."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the wishlist value for multi-currency intent analysis."
    - name: "created_year_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the wishlist was created for seasonal demand signal and registry trend analysis."
  measures:
    - name: "total_active_wishlists"
      expr: COUNT(CASE WHEN wishlist_status = 'active' THEN wishlist_id END)
      comment: "Total number of active wishlists. Measures high-intent purchase pipeline size — a leading indicator of future conversion revenue."
    - name: "total_wishlist_value"
      expr: SUM(CASE WHEN wishlist_status = 'active' THEN CAST(total_value_amount AS DOUBLE) ELSE 0 END)
      comment: "Total monetary value of items across active wishlists. Quantifies the latent purchase intent pipeline for demand planning and targeted promotion investment."
    - name: "avg_wishlist_value"
      expr: AVG(CASE WHEN wishlist_status = 'active' THEN CAST(total_value_amount AS DOUBLE) END)
      comment: "Average value per active wishlist. Benchmarks purchase intent depth and informs personalized offer thresholds for wishlist conversion campaigns."
    - name: "avg_conversion_rate_pct"
      expr: AVG(CAST(conversion_rate_percentage AS DOUBLE))
      comment: "Average wishlist-to-purchase conversion rate percentage. Core e-commerce KPI measuring how effectively wishlists translate to completed purchases."
    - name: "distinct_customers_with_wishlists"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct customers with at least one wishlist. Measures wishlist feature adoption and high-intent customer segment size."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_targeting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign targeting effectiveness metrics covering reach, conversion, and budget efficiency. Used by marketing and campaign management teams to evaluate audience targeting performance and optimize campaign investment allocation."
  source: "`vibe_retail_v1`.`customer`.`targeting`"
  dimensions:
    - name: "targeting_status"
      expr: targeting_status
      comment: "Status of the targeting record (active, paused, completed, cancelled) for in-flight vs. completed campaign analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the targeting (high, medium, low) for resource allocation and campaign scheduling analysis."
    - name: "activation_year_month"
      expr: DATE_TRUNC('month', activation_timestamp)
      comment: "Month the targeting was activated for campaign launch trend and seasonal marketing analysis."
  measures:
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocation_amount AS DOUBLE))
      comment: "Total marketing budget allocated across all targeting records. Core marketing spend KPI for budget utilization and campaign investment tracking."
    - name: "total_actual_reach"
      expr: SUM(CAST(actual_reached_count AS BIGINT))
      comment: "Total number of customers actually reached across all targeting activations. Measures campaign delivery effectiveness vs. estimated reach."
    - name: "total_estimated_reach"
      expr: SUM(CAST(estimated_reach AS BIGINT))
      comment: "Total estimated reach across all targeting records. Used as the denominator for reach efficiency calculations in campaign planning."
    - name: "avg_conversion_rate_pct"
      expr: AVG(CAST(conversion_rate_percent AS DOUBLE))
      comment: "Average conversion rate percentage across targeting activations. Primary campaign effectiveness KPI — drives decisions on audience refinement and creative optimization."
    - name: "avg_response_rate_pct"
      expr: AVG(CAST(response_rate_percent AS DOUBLE))
      comment: "Average response rate percentage across targeting activations. Measures audience engagement quality and message relevance for campaign optimization."
    - name: "distinct_campaigns_targeted"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns with active targeting records. Measures campaign portfolio breadth and marketing program scale."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_segment_banner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Segment-level banner advertising performance metrics covering impressions, clicks, conversions, and attributed revenue. Used by digital marketing and e-commerce teams to evaluate banner campaign ROI by customer segment."
  source: "`vibe_retail_v1`.`customer`.`targeting`"
  dimensions:
    - name: "targeting_status"
      expr: targeting_status
      comment: "Status of the banner targeting record (active, completed, paused) for in-flight vs. historical performance analysis."
  measures:
    - name: "Row Count"
      expr: COUNT(1)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_privacy_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Privacy rights request processing metrics covering request volume, completion rates, and SLA compliance. Used by privacy, legal, and compliance teams to demonstrate GDPR/CCPA regulatory adherence and manage data subject rights obligations."
  source: "`vibe_retail_v1`.`customer`.`privacy_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of privacy request (erasure, access, portability, rectification, restriction) for regulatory obligation tracking by right type."
    - name: "request_status"
      expr: request_status
      comment: "Current status of the request (pending, in-progress, completed, denied, appealed) for SLA compliance monitoring."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the request (GDPR, CCPA, PIPEDA) for jurisdiction-specific compliance reporting."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the request was submitted (web portal, email, phone, in-store) for intake channel analysis."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the completed request (fulfilled, denied, partially-fulfilled) for compliance posture and denial rate tracking."
    - name: "extension_granted_flag"
      expr: extension_granted_flag
      comment: "Whether a processing extension was granted, for SLA exception tracking and regulatory risk monitoring."
    - name: "submission_year_month"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Month the privacy request was submitted for volume trend and regulatory reporting period analysis."
  measures:
    - name: "total_privacy_requests"
      expr: COUNT(privacy_request_id)
      comment: "Total number of privacy rights requests received. Core regulatory compliance KPI — volume trends inform privacy program resourcing and regulatory risk exposure."
    - name: "completed_requests_count"
      expr: COUNT(CASE WHEN request_status = 'completed' THEN privacy_request_id END)
      comment: "Number of privacy requests successfully completed. Measures regulatory obligation fulfillment rate — a key metric for GDPR/CCPA audit readiness."
    - name: "pending_requests_count"
      expr: COUNT(CASE WHEN request_status IN ('pending', 'in-progress') THEN privacy_request_id END)
      comment: "Number of privacy requests currently pending or in-progress. Operational backlog KPI for privacy team capacity planning and SLA breach prevention."
    - name: "denied_requests_count"
      expr: COUNT(CASE WHEN outcome = 'denied' THEN privacy_request_id END)
      comment: "Number of privacy requests denied. Tracks denial rate — high denial rates may indicate regulatory risk and require legal review."
    - name: "distinct_customers_requesting"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct customers who have submitted privacy requests. Measures the breadth of data subject rights exercise across the customer base."
    - name: "requests_with_extension"
      expr: COUNT(CASE WHEN extension_granted_flag = TRUE THEN privacy_request_id END)
      comment: "Number of requests where a processing extension was granted. Tracks SLA exception volume — a leading indicator of processing capacity constraints."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level spending, loyalty, and demographic metrics for household-based marketing and analytics. Used by marketing, loyalty, and category management teams to understand household economics and target household-level promotions."
  source: "`vibe_retail_v1`.`customer`.`household`"
  dimensions:
    - name: "household_status"
      expr: household_status
      comment: "Status of the household record (active, inactive, merged) for active household base sizing."
    - name: "household_type"
      expr: household_type
      comment: "Type of household (single, family, multi-generational, shared) for demographic segmentation and assortment planning."
    - name: "estimated_income_band"
      expr: estimated_income_band
      comment: "Estimated household income band for socioeconomic segmentation and premium product targeting."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty tier of the household for tier-based household value analysis and upgrade targeting."
    - name: "preferred_channel"
      expr: preferred_channel
      comment: "Preferred shopping channel for the household for omnichannel engagement strategy."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the household for localized communication and assortment planning."
    - name: "country_code"
      expr: country_code
      comment: "Country of the household for geographic market analysis and regional strategy."
    - name: "size"
      expr: size
      comment: "Household size category for basket size benchmarking and bulk purchase propensity analysis."
  measures:
    - name: "total_active_households"
      expr: COUNT(CASE WHEN household_status = 'active' THEN household_id END)
      comment: "Total number of active households. Core household analytics KPI for measuring the addressable household universe for targeted marketing."
    - name: "total_household_spend"
      expr: SUM(CAST(total_spend_amount AS DOUBLE))
      comment: "Total spend amount across all households. Measures aggregate household revenue contribution — the primary household-level financial KPI."
    - name: "avg_household_spend"
      expr: AVG(CAST(total_spend_amount AS DOUBLE))
      comment: "Average spend per household. Benchmarks household value and informs spend-based segmentation thresholds for tiered marketing programs."
    - name: "avg_basket_value"
      expr: AVG(CAST(average_basket_value AS DOUBLE))
      comment: "Average basket value per household. Key retail KPI for measuring transaction size and identifying upsell and cross-sell opportunities."
    - name: "total_combined_cltv"
      expr: SUM(CAST(combined_cltv AS DOUBLE))
      comment: "Total combined customer lifetime value across all households. Measures the aggregate long-term revenue potential of the household portfolio for strategic investment prioritization."
    - name: "avg_combined_cltv"
      expr: AVG(CAST(combined_cltv AS DOUBLE))
      comment: "Average combined customer lifetime value per household. Benchmarks household economic value for tier qualification and retention investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_identity_link`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer identity resolution quality metrics covering link confidence, validation rates, and identifier coverage. Used by data governance and MDM teams to monitor the health of the customer identity graph and prioritize resolution improvements."
  source: "`vibe_retail_v1`.`customer`.`identity_link`"
  dimensions:
    - name: "identifier_type"
      expr: identifier_type
      comment: "Type of identifier used for linking (email, loyalty-id, device-id, cookie, phone) for identity graph coverage analysis by identifier type."
    - name: "link_status"
      expr: link_status
      comment: "Status of the identity link (active, merged, superseded, invalidated) for active identity graph health monitoring."
    - name: "link_method"
      expr: link_method
      comment: "Method used to establish the link (deterministic, probabilistic, manual) for resolution quality and confidence stratification."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the identity link (validated, pending, failed) for data quality governance reporting."
    - name: "channel"
      expr: channel
      comment: "Channel where the identifier was observed (web, mobile, in-store, call-center) for cross-channel identity coverage analysis."
    - name: "is_primary_identifier"
      expr: is_primary_identifier
      comment: "Whether this is the primary identifier for the customer profile, for primary identity coverage and golden record completeness."
  measures:
    - name: "total_active_identity_links"
      expr: COUNT(CASE WHEN link_status = 'active' THEN identity_link_id END)
      comment: "Total number of active identity links in the customer identity graph. Measures identity resolution coverage and graph completeness."
    - name: "avg_link_confidence_score"
      expr: AVG(CAST(link_confidence_score AS DOUBLE))
      comment: "Average confidence score of identity links. Core identity graph quality KPI — low scores indicate probabilistic links requiring validation or deterministic enrichment."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across identity links. Tracks overall identity data health — declining scores trigger data stewardship and enrichment programs."
    - name: "distinct_resolved_profiles"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct customer profiles with at least one identity link. Measures the breadth of identity resolution across the customer base."
    - name: "validated_links_count"
      expr: COUNT(CASE WHEN validation_status = 'validated' THEN identity_link_id END)
      comment: "Number of validated identity links. Measures the high-confidence portion of the identity graph for reliable cross-channel attribution."
    - name: "primary_identifier_coverage"
      expr: COUNT(CASE WHEN is_primary_identifier = TRUE AND link_status = 'active' THEN identity_link_id END)
      comment: "Number of active primary identifier links. Measures golden record completeness — every resolved profile should have exactly one primary identifier."
$$;