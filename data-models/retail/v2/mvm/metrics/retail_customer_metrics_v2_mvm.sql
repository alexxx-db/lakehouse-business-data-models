-- Metric views for domain: customer | Business: Retail | Version: 2 | Generated on: 2026-07-12 15:23:39

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic account-level KPIs tracking customer value, credit exposure, and account health for portfolio management and risk decisions"
  source: "`vibe_retail_v1`.`customer`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the account (active, suspended, closed) for cohort analysis"
    - name: "account_type"
      expr: account_type
      comment: "Type of account (B2C, B2B, employee, etc.) for segmentation"
    - name: "tier"
      expr: tier
      comment: "Account tier or segment classification for value-based analysis"
    - name: "loyalty_program_enrolled"
      expr: loyalty_program_enrolled
      comment: "Whether account is enrolled in loyalty program for engagement analysis"
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Tax exemption status for compliance and revenue recognition"
    - name: "b2b_pricing_flag"
      expr: b2b_pricing_flag
      comment: "Whether account receives B2B pricing for margin analysis"
    - name: "preferred_channel"
      expr: preferred_channel
      comment: "Preferred shopping channel (online, in-store, mobile) for channel strategy"
    - name: "currency_code"
      expr: currency_code
      comment: "Account currency for multi-currency reporting"
    - name: "open_year"
      expr: YEAR(open_date)
      comment: "Year account was opened for cohort and vintage analysis"
    - name: "open_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month account was opened for acquisition trend analysis"
    - name: "account_age_days"
      expr: DATEDIFF(CURRENT_DATE(), open_date)
      comment: "Days since account opening for lifecycle analysis"
    - name: "is_current"
      expr: is_current
      comment: "Whether this is the current version of the account record (SCD Type 2)"
  measures:
    - name: "total_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Total number of unique accounts for portfolio size tracking"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit extended across all accounts for risk exposure management"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account for underwriting policy evaluation"
    - name: "active_accounts"
      expr: COUNT(DISTINCT CASE WHEN account_status = 'active' THEN account_id END)
      comment: "Number of active accounts for health monitoring"
    - name: "suspended_accounts"
      expr: COUNT(DISTINCT CASE WHEN account_status = 'suspended' THEN account_id END)
      comment: "Number of suspended accounts for risk and collections focus"
    - name: "loyalty_enrolled_accounts"
      expr: COUNT(DISTINCT CASE WHEN loyalty_program_enrolled = TRUE THEN account_id END)
      comment: "Number of accounts enrolled in loyalty program for engagement strategy"
    - name: "loyalty_enrollment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN loyalty_program_enrolled = TRUE THEN account_id END) / NULLIF(COUNT(DISTINCT account_id), 0), 2)
      comment: "Percentage of accounts enrolled in loyalty program for program effectiveness"
    - name: "b2b_accounts"
      expr: COUNT(DISTINCT CASE WHEN b2b_pricing_flag = TRUE THEN account_id END)
      comment: "Number of B2B accounts for commercial segment sizing"
    - name: "tax_exempt_accounts"
      expr: COUNT(DISTINCT CASE WHEN tax_exempt_flag = TRUE THEN account_id END)
      comment: "Number of tax-exempt accounts for compliance and revenue planning"
    - name: "employee_discount_eligible_accounts"
      expr: COUNT(DISTINCT CASE WHEN employee_discount_eligible = TRUE THEN account_id END)
      comment: "Number of employee-eligible accounts for internal program tracking"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer profile KPIs for demographic analysis, acquisition effectiveness, and lifecycle management decisions"
  source: "`vibe_retail_v1`.`customer`.`profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current profile status for active customer base analysis"
    - name: "customer_type"
      expr: customer_type
      comment: "Type of customer (individual, business, etc.) for segmentation"
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Customer lifecycle stage (prospect, active, at-risk, churned) for retention strategy"
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty program tier for value-based segmentation"
    - name: "gender"
      expr: gender
      comment: "Customer gender for demographic analysis"
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which customer was acquired for CAC and ROAS analysis"
    - name: "preferred_contact_method"
      expr: preferred_contact_method
      comment: "Preferred contact method for marketing optimization"
    - name: "preferred_language"
      expr: preferred_language
      comment: "Preferred language for localization strategy"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year customer was acquired for cohort analysis"
    - name: "acquisition_month"
      expr: DATE_TRUNC('MONTH', acquisition_date)
      comment: "Month customer was acquired for acquisition trend analysis"
    - name: "age_group"
      expr: CASE WHEN DATEDIFF(CURRENT_DATE(), date_of_birth) / 365 < 25 THEN 'Under 25' WHEN DATEDIFF(CURRENT_DATE(), date_of_birth) / 365 BETWEEN 25 AND 34 THEN '25-34' WHEN DATEDIFF(CURRENT_DATE(), date_of_birth) / 365 BETWEEN 35 AND 44 THEN '35-44' WHEN DATEDIFF(CURRENT_DATE(), date_of_birth) / 365 BETWEEN 45 AND 54 THEN '45-54' WHEN DATEDIFF(CURRENT_DATE(), date_of_birth) / 365 BETWEEN 55 AND 64 THEN '55-64' WHEN DATEDIFF(CURRENT_DATE(), date_of_birth) / 365 >= 65 THEN '65+' ELSE 'Unknown' END
      comment: "Age group bucketing for demographic targeting"
    - name: "gdpr_consent_status"
      expr: CASE WHEN gdpr_consent_date IS NOT NULL THEN 'Consented' ELSE 'Not Consented' END
      comment: "GDPR consent status for compliance and marketing eligibility"
    - name: "ccpa_opt_out_status"
      expr: CASE WHEN ccpa_opt_out_date IS NOT NULL THEN 'Opted Out' ELSE 'Active' END
      comment: "CCPA opt-out status for privacy compliance"
    - name: "is_current"
      expr: is_current
      comment: "Whether this is the current version of the profile record (SCD Type 2)"
  measures:
    - name: "total_profiles"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total number of unique customer profiles for customer base sizing"
    - name: "active_profiles"
      expr: COUNT(DISTINCT CASE WHEN profile_status = 'active' THEN profile_id END)
      comment: "Number of active customer profiles for active customer base tracking"
    - name: "avg_mdm_confidence_score"
      expr: AVG(CAST(mdm_confidence_score AS DOUBLE))
      comment: "Average MDM confidence score for data quality assessment"
    - name: "gdpr_consented_profiles"
      expr: COUNT(DISTINCT CASE WHEN gdpr_consent_date IS NOT NULL THEN profile_id END)
      comment: "Number of profiles with GDPR consent for marketing reach estimation"
    - name: "gdpr_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN gdpr_consent_date IS NOT NULL THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of profiles with GDPR consent for compliance and marketing effectiveness"
    - name: "ccpa_opt_out_profiles"
      expr: COUNT(DISTINCT CASE WHEN ccpa_opt_out_date IS NOT NULL THEN profile_id END)
      comment: "Number of profiles that opted out under CCPA for privacy compliance tracking"
    - name: "ccpa_opt_out_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN ccpa_opt_out_date IS NOT NULL THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of profiles opted out under CCPA for privacy impact assessment"
    - name: "profiles_with_mobile"
      expr: COUNT(DISTINCT CASE WHEN mobile_number IS NOT NULL THEN profile_id END)
      comment: "Number of profiles with mobile numbers for SMS marketing reach"
    - name: "profiles_with_email"
      expr: COUNT(DISTINCT CASE WHEN email_address IS NOT NULL THEN profile_id END)
      comment: "Number of profiles with email addresses for email marketing reach"
    - name: "high_confidence_profiles"
      expr: COUNT(DISTINCT CASE WHEN CAST(mdm_confidence_score AS DOUBLE) >= 0.8 THEN profile_id END)
      comment: "Number of profiles with high MDM confidence (>=0.8) for data quality monitoring"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_address`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Address-level KPIs for delivery network optimization, geographic expansion planning, and address quality management"
  source: "`vibe_retail_v1`.`customer`.`address`"
  dimensions:
    - name: "address_status"
      expr: address_status
      comment: "Current address status for active address base tracking"
    - name: "address_type"
      expr: address_type
      comment: "Type of address (billing, shipping, both) for fulfillment analysis"
    - name: "country_code"
      expr: country_code
      comment: "Country code for geographic market analysis"
    - name: "state_province"
      expr: state_province
      comment: "State or province for regional analysis"
    - name: "city"
      expr: city
      comment: "City for local market analysis"
    - name: "postal_code"
      expr: postal_code
      comment: "Postal code for micro-market and delivery zone analysis"
    - name: "residential_flag"
      expr: residential_flag
      comment: "Whether address is residential for delivery strategy"
    - name: "po_box_flag"
      expr: po_box_flag
      comment: "Whether address is a PO box for delivery constraint planning"
    - name: "military_address_flag"
      expr: military_address_flag
      comment: "Whether address is military for special handling requirements"
    - name: "validation_status"
      expr: validation_status
      comment: "Address validation status for data quality monitoring"
    - name: "standardization_flag"
      expr: standardization_flag
      comment: "Whether address has been standardized for quality assessment"
    - name: "is_default_shipping"
      expr: is_default_shipping
      comment: "Whether this is the default shipping address for primary address analysis"
    - name: "is_default_billing"
      expr: is_default_billing
      comment: "Whether this is the default billing address for payment analysis"
    - name: "tax_jurisdiction_code"
      expr: tax_jurisdiction_code
      comment: "Tax jurisdiction for tax calculation and compliance"
  measures:
    - name: "total_addresses"
      expr: COUNT(DISTINCT address_id)
      comment: "Total number of unique addresses for address base sizing"
    - name: "active_addresses"
      expr: COUNT(DISTINCT CASE WHEN address_status = 'active' THEN address_id END)
      comment: "Number of active addresses for current delivery network reach"
    - name: "validated_addresses"
      expr: COUNT(DISTINCT CASE WHEN validation_status = 'validated' THEN address_id END)
      comment: "Number of validated addresses for data quality and delivery success rate"
    - name: "address_validation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN validation_status = 'validated' THEN address_id END) / NULLIF(COUNT(DISTINCT address_id), 0), 2)
      comment: "Percentage of addresses validated for data quality KPI"
    - name: "standardized_addresses"
      expr: COUNT(DISTINCT CASE WHEN standardization_flag = TRUE THEN address_id END)
      comment: "Number of standardized addresses for data quality tracking"
    - name: "residential_addresses"
      expr: COUNT(DISTINCT CASE WHEN residential_flag = TRUE THEN address_id END)
      comment: "Number of residential addresses for B2C delivery planning"
    - name: "commercial_addresses"
      expr: COUNT(DISTINCT CASE WHEN residential_flag = FALSE THEN address_id END)
      comment: "Number of commercial addresses for B2B delivery planning"
    - name: "po_box_addresses"
      expr: COUNT(DISTINCT CASE WHEN po_box_flag = TRUE THEN address_id END)
      comment: "Number of PO box addresses for delivery constraint planning"
    - name: "military_addresses"
      expr: COUNT(DISTINCT CASE WHEN military_address_flag = TRUE THEN address_id END)
      comment: "Number of military addresses for special handling logistics"
    - name: "addresses_with_coordinates"
      expr: COUNT(DISTINCT CASE WHEN latitude IS NOT NULL AND longitude IS NOT NULL THEN address_id END)
      comment: "Number of addresses with geocoding for route optimization capability"
    - name: "geocoding_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN latitude IS NOT NULL AND longitude IS NOT NULL THEN address_id END) / NULLIF(COUNT(DISTINCT address_id), 0), 2)
      comment: "Percentage of addresses with geocoding for delivery optimization readiness"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contact method KPIs for marketing reachability, contact quality, and multi-channel engagement strategy"
  source: "`vibe_retail_v1`.`customer`.`contact`"
  dimensions:
    - name: "contact_status"
      expr: contact_status
      comment: "Current contact status for reachability analysis"
    - name: "contact_type"
      expr: contact_type
      comment: "Type of contact method (email, phone, SMS, etc.) for channel mix analysis"
    - name: "is_verified"
      expr: is_verified
      comment: "Whether contact has been verified for quality and deliverability"
    - name: "is_primary"
      expr: is_primary
      comment: "Whether this is the primary contact method for prioritization"
    - name: "language_preference"
      expr: language_preference
      comment: "Language preference for localized communication"
    - name: "consent_source"
      expr: consent_source
      comment: "Source of consent for compliance tracking"
    - name: "country_code"
      expr: country_code
      comment: "Country code for international contact strategy"
    - name: "verification_year"
      expr: YEAR(verification_date)
      comment: "Year contact was verified for data freshness analysis"
  measures:
    - name: "total_contacts"
      expr: COUNT(DISTINCT contact_id)
      comment: "Total number of unique contact methods for reachability inventory"
    - name: "active_contacts"
      expr: COUNT(DISTINCT CASE WHEN contact_status = 'active' THEN contact_id END)
      comment: "Number of active contact methods for current marketing reach"
    - name: "verified_contacts"
      expr: COUNT(DISTINCT CASE WHEN is_verified = TRUE THEN contact_id END)
      comment: "Number of verified contact methods for deliverability confidence"
    - name: "contact_verification_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_verified = TRUE THEN contact_id END) / NULLIF(COUNT(DISTINCT contact_id), 0), 2)
      comment: "Percentage of contacts verified for data quality and campaign effectiveness"
    - name: "primary_contacts"
      expr: COUNT(DISTINCT CASE WHEN is_primary = TRUE THEN contact_id END)
      comment: "Number of primary contact methods for preferred channel analysis"
    - name: "bounced_contacts"
      expr: COUNT(DISTINCT CASE WHEN bounce_count IS NOT NULL AND bounce_count != '0' THEN contact_id END)
      comment: "Number of contacts with bounce history for list hygiene"
    - name: "unique_profiles_with_contact"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customer profiles with at least one contact method for reachability coverage"
    - name: "unique_accounts_with_contact"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique accounts with at least one contact method for account reachability"
$$;