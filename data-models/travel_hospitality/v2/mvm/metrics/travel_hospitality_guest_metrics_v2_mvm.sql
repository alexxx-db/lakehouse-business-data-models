-- Metric views for domain: guest | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-07-10 22:17:24

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_stay_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core guest stay performance metrics covering revenue, ADR, ancillary yield, and guest satisfaction. Primary fact table for evaluating guest value, stay economics, and operational quality across properties and segments."
  source: "`vibe_travel_hospitality_v1`.`guest`.`stay_history`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — enables property-level benchmarking and performance comparison."
    - name: "stay_status"
      expr: stay_status
      comment: "Status of the stay (e.g. checked-out, no-show, cancelled) — used to filter to completed stays for revenue analysis."
    - name: "guest_type"
      expr: guest_type
      comment: "Classification of the guest (e.g. leisure, corporate, group) — key segmentation dimension for revenue and satisfaction analysis."
    - name: "loyalty_tier_at_stay"
      expr: loyalty_tier_at_stay
      comment: "Loyalty program tier the guest held at time of stay — enables tier-based revenue and satisfaction stratification."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the stay — informs payment channel mix and direct billing analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the stay was billed — required for multi-currency revenue reporting."
    - name: "channel_id"
      expr: channel_id
      comment: "Booking channel identifier — enables channel contribution and cost-of-acquisition analysis."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Market segment identifier — supports revenue management segmentation and displacement analysis."
    - name: "arrival_month"
      expr: DATE_TRUNC('MONTH', arrival_date)
      comment: "Month of guest arrival — enables monthly trend analysis of stay volume and revenue."
    - name: "arrival_year"
      expr: YEAR(arrival_date)
      comment: "Year of guest arrival — supports year-over-year performance comparisons."
    - name: "booking_month"
      expr: DATE_TRUNC('MONTH', booking_date)
      comment: "Month the booking was made — used to analyze booking lead time patterns and demand forecasting."
    - name: "complimentary_flag"
      expr: complimentary_flag
      comment: "Indicates whether the stay was complimentary — used to separate revenue-generating stays from comp stays in KPI calculations."
    - name: "service_recovery_flag"
      expr: service_recovery_flag
      comment: "Indicates whether a service recovery action was taken during the stay — used to track service failure rates."
    - name: "corporate_account_id"
      expr: corporate_account_id
      comment: "Corporate account associated with the stay — enables corporate account revenue contribution analysis."
  measures:
    - name: "total_room_revenue"
      expr: SUM(CAST(room_revenue AS DOUBLE))
      comment: "Total room revenue across all stays. Core top-line revenue KPI for property and portfolio performance reviews."
    - name: "total_ancillary_revenue"
      expr: SUM(CAST(ancillary_revenue AS DOUBLE))
      comment: "Total ancillary revenue (spa, dining, parking, etc.) generated across stays. Measures non-room revenue contribution and upsell effectiveness."
    - name: "total_fb_revenue"
      expr: SUM(CAST(fb_revenue AS DOUBLE))
      comment: "Total food and beverage revenue across stays. Key outlet performance indicator and attachment rate driver."
    - name: "total_folio_amount"
      expr: SUM(CAST(total_folio_amount AS DOUBLE))
      comment: "Total billed folio amount across all stays including room, F&B, ancillary, and taxes. Represents gross guest spend."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across stays. Required for regulatory reporting and net revenue reconciliation."
    - name: "avg_daily_rate"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average Daily Rate across stays. Fundamental revenue management KPI used in every QBR and board deck to assess pricing performance."
    - name: "avg_room_revenue_per_stay"
      expr: AVG(CAST(room_revenue AS DOUBLE))
      comment: "Average room revenue per stay record. Complements ADR by capturing total room spend per stay rather than per night."
    - name: "avg_total_folio_per_stay"
      expr: AVG(CAST(total_folio_amount AS DOUBLE))
      comment: "Average total guest spend per stay including all charges. Measures overall guest value and upsell effectiveness."
    - name: "avg_ancillary_revenue_per_stay"
      expr: AVG(CAST(ancillary_revenue AS DOUBLE))
      comment: "Average ancillary revenue per stay. Tracks non-room revenue yield per guest visit — key metric for ancillary monetization strategy."
    - name: "avg_gss_score"
      expr: AVG(CAST(gss_score AS DOUBLE))
      comment: "Average Guest Satisfaction Score across stays. Primary guest experience KPI — directly linked to loyalty, repeat visits, and brand reputation."
    - name: "total_stays"
      expr: COUNT(1)
      comment: "Total number of stay records. Baseline volume metric for occupancy and throughput analysis."
    - name: "unique_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of distinct guest profiles with stays. Measures guest reach and repeat visitation base."
    - name: "service_recovery_stays"
      expr: SUM(CASE WHEN service_recovery_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of stays that required a service recovery action. Tracks operational failure frequency — high values trigger quality intervention."
    - name: "complimentary_stays"
      expr: SUM(CASE WHEN complimentary_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of complimentary stays. Monitors comp room usage against policy thresholds — excess comps erode RevPAR."
    - name: "repeat_guest_stays"
      expr: COUNT(DISTINCT CASE WHEN member_id IS NOT NULL THEN profile_id END)
      comment: "Count of distinct loyalty member guests with stays. Proxy for repeat/loyal guest volume — key retention KPI."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest profile quality, consent, and segmentation metrics. Enables CRM health monitoring, data completeness governance, and loyalty enrollment performance tracking."
  source: "`vibe_travel_hospitality_v1`.`guest`.`profile`"
  dimensions:
    - name: "guest_type"
      expr: guest_type
      comment: "Classification of the guest (e.g. leisure, corporate, group) — primary segmentation dimension for profile analysis."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Current loyalty program tier of the guest — enables tier distribution and upgrade funnel analysis."
    - name: "profile_status"
      expr: profile_status
      comment: "Active/inactive/merged status of the profile — used to filter to actionable profiles and track data hygiene."
    - name: "country_of_residence_code"
      expr: country_of_residence_code
      comment: "Guest country of residence — enables geographic segmentation of the guest base."
    - name: "nationality_country_code"
      expr: nationality_country_code
      comment: "Guest nationality — supports international guest mix analysis and visa/compliance reporting."
    - name: "vip_status"
      expr: vip_status
      comment: "VIP designation status of the guest — used to stratify high-value guest profiles for targeted service."
    - name: "preferred_language_code"
      expr: preferred_language_code
      comment: "Guest preferred language — informs localization and communication strategy."
    - name: "gender"
      expr: gender
      comment: "Guest gender — used for demographic segmentation in marketing and service personalization."
    - name: "property_id"
      expr: property_id
      comment: "Property where the guest profile was first created — identifies acquisition source property."
    - name: "loyalty_enrollment_month"
      expr: DATE_TRUNC('MONTH', loyalty_enrollment_date)
      comment: "Month of loyalty program enrollment — tracks enrollment velocity and campaign effectiveness over time."
    - name: "profile_created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the profile was created — enables cohort analysis of guest acquisition."
    - name: "is_merge_survivor"
      expr: is_merge_survivor
      comment: "Whether this profile survived a merge operation — used to assess deduplication outcomes."
    - name: "gdpr_erasure_requested"
      expr: gdpr_erasure_requested
      comment: "Whether a GDPR erasure has been requested for this profile — critical compliance dimension."
  measures:
    - name: "total_active_profiles"
      expr: SUM(CASE WHEN profile_status = 'ACTIVE' THEN 1 ELSE 0 END)
      comment: "Total number of active guest profiles. Baseline CRM size metric — tracks guest base growth and churn."
    - name: "total_loyalty_enrolled_profiles"
      expr: SUM(CASE WHEN member_id IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of profiles enrolled in the loyalty program. Measures loyalty program penetration across the guest base."
    - name: "loyalty_enrollment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN member_id IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of guest profiles enrolled in the loyalty program. Key loyalty acquisition KPI — low rates indicate enrollment conversion gaps."
    - name: "email_opt_in_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN email_opt_in = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of guest profiles with email marketing opt-in. Measures marketable audience size — directly impacts campaign reach and revenue."
    - name: "marketing_opt_in_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN marketing_opt_in = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of guest profiles opted into marketing communications. Core consent health KPI for CRM and digital marketing teams."
    - name: "sms_opt_in_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sms_opt_in = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of guest profiles opted into SMS communications. Tracks SMS channel consent coverage for mobile marketing strategy."
    - name: "gdpr_erasure_request_count"
      expr: SUM(CASE WHEN gdpr_erasure_requested = TRUE THEN 1 ELSE 0 END)
      comment: "Number of profiles with active GDPR erasure requests. Critical compliance KPI — high volumes trigger legal and data governance escalation."
    - name: "vip_profile_count"
      expr: SUM(CASE WHEN vip_status IS NOT NULL AND vip_status != '' THEN 1 ELSE 0 END)
      comment: "Number of guest profiles with an active VIP designation. Tracks high-value guest base size for premium service resource planning."
    - name: "profile_completeness_with_mobile"
      expr: ROUND(100.0 * SUM(CASE WHEN mobile_phone IS NOT NULL AND mobile_phone != '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of profiles with a mobile phone number on record. Measures contact data completeness — gaps reduce reachability for pre-arrival and upsell communications."
    - name: "merged_profile_count"
      expr: SUM(CASE WHEN merged_into_profile_id IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of profiles that have been merged into another profile. Tracks deduplication volume — high counts indicate data quality issues in source systems."
    - name: "total_profiles"
      expr: COUNT(1)
      comment: "Total guest profile count including all statuses. Baseline denominator for profile health and consent rate calculations."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_communication_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest communication consent health and compliance metrics. Tracks consent coverage, opt-in/opt-out rates, double opt-in confirmation, and suppression list volumes — critical for GDPR/CCPA compliance and marketable audience management."
  source: "`vibe_travel_hospitality_v1`.`guest`.`communication_consent`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent captured (e.g. email marketing, SMS, profiling) — primary dimension for consent coverage analysis by channel."
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent record (e.g. granted, withdrawn, expired) — used to filter to active consents."
    - name: "consent_method"
      expr: consent_method
      comment: "Method by which consent was captured (e.g. web form, in-person, email) — informs consent quality and audit defensibility."
    - name: "consent_source"
      expr: consent_source
      comment: "Source system or touchpoint where consent was collected — enables channel-level consent acquisition analysis."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction governing the consent (e.g. EU, UK, US-CA) — mandatory dimension for GDPR/CCPA compliance reporting."
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal basis for processing (e.g. consent, legitimate interest, contract) — required for GDPR Article 6 compliance reporting."
    - name: "consent_purpose"
      expr: consent_purpose
      comment: "Purpose for which consent was granted (e.g. direct marketing, analytics, third-party sharing) — granular consent purpose tracking."
    - name: "property_id"
      expr: property_id
      comment: "Property where consent was captured — enables property-level consent compliance monitoring."
    - name: "guest_country_code"
      expr: guest_country_code
      comment: "Country of the guest at time of consent — supports geographic consent compliance analysis."
    - name: "consent_granted_month"
      expr: DATE_TRUNC('MONTH', consent_granted_date)
      comment: "Month consent was granted — tracks consent acquisition velocity and campaign-driven consent spikes."
    - name: "consent_language_code"
      expr: consent_language_code
      comment: "Language in which consent was presented — ensures consent was given in the guest's language as required by GDPR."
    - name: "double_opt_in_flag"
      expr: double_opt_in_flag
      comment: "Whether double opt-in confirmation was required — used to segment high-quality confirmed consents."
  measures:
    - name: "total_active_consents"
      expr: SUM(CASE WHEN consent_status = 'GRANTED' THEN 1 ELSE 0 END)
      comment: "Total number of active granted consent records. Measures the size of the legally marketable audience — directly impacts campaign reach."
    - name: "total_withdrawn_consents"
      expr: SUM(CASE WHEN consent_status = 'WITHDRAWN' THEN 1 ELSE 0 END)
      comment: "Total number of withdrawn consent records. Tracks opt-out volume — rising withdrawals signal brand trust or communication frequency issues."
    - name: "consent_withdrawal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_status = 'WITHDRAWN' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records that have been withdrawn. Key compliance and CRM health KPI — high rates indicate consent fatigue or regulatory risk."
    - name: "double_opt_in_confirmation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN double_opt_in_flag = TRUE AND double_opt_in_confirmed_timestamp IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN double_opt_in_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of double opt-in requests that were confirmed by the guest. Measures email list quality — low confirmation rates indicate deliverability or UX issues in the confirmation flow."
    - name: "profiling_consent_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN profiling_consent_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records with profiling consent granted. Measures the audience eligible for AI/ML personalization — critical for data-driven personalization strategy."
    - name: "third_party_sharing_consent_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN third_party_sharing_consent_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records permitting third-party data sharing. Governs partner data sharing eligibility — compliance teams use this to validate data sharing agreements."
    - name: "suppression_list_count"
      expr: SUM(CASE WHEN suppression_list_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of guest consent records on the suppression list. Tracks do-not-contact volume — must be honored in all outbound communications to avoid regulatory penalties."
    - name: "total_consent_records"
      expr: COUNT(1)
      comment: "Total consent records across all statuses. Baseline denominator for consent rate calculations and audit completeness checks."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_corporate_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corporate account portfolio metrics covering revenue targets, credit exposure, contract coverage, and account health. Enables B2B sales and account management teams to monitor corporate segment performance and risk."
  source: "`vibe_travel_hospitality_v1`.`guest`.`corporate_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the corporate account (e.g. active, suspended, closed) — primary filter for active portfolio analysis."
    - name: "account_type"
      expr: account_type
      comment: "Type of corporate account (e.g. negotiated, preferred, transient) — enables account tier segmentation."
    - name: "vip_tier"
      expr: vip_tier
      comment: "VIP tier assigned to the corporate account — used to stratify high-value accounts for priority service and account management."
    - name: "rate_program_type"
      expr: rate_program_type
      comment: "Rate program type associated with the account (e.g. LNR, GDS, direct) — informs rate strategy and channel mix analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the corporate account — enables property-level corporate account portfolio analysis."
    - name: "billing_address_country_code"
      expr: billing_address_country_code
      comment: "Country of the corporate account billing address — supports geographic portfolio analysis and tax jurisdiction reporting."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for the account (e.g. net 30, direct billing) — used to assess credit risk and cash flow exposure."
    - name: "tax_exempt_status"
      expr: tax_exempt_status
      comment: "Tax exemption status of the account — required for revenue reporting and tax compliance."
    - name: "contract_start_month"
      expr: DATE_TRUNC('MONTH', contract_start_date)
      comment: "Month the contract became effective — tracks contract renewal cycles and new account acquisition timing."
    - name: "contract_end_month"
      expr: DATE_TRUNC('MONTH', contract_end_date)
      comment: "Month the contract expires — enables proactive contract renewal pipeline management."
    - name: "direct_billing_enabled"
      expr: direct_billing_enabled
      comment: "Whether direct billing is enabled for the account — used to segment accounts by billing method and assess AR exposure."
    - name: "loyalty_program_eligible"
      expr: loyalty_program_eligible
      comment: "Whether the corporate account is eligible for loyalty program benefits — tracks loyalty-eligible corporate volume."
    - name: "mice_eligible"
      expr: mice_eligible
      comment: "Whether the account is eligible for MICE (Meetings, Incentives, Conferences, Exhibitions) business — segments event-capable corporate accounts."
  measures:
    - name: "total_active_accounts"
      expr: SUM(CASE WHEN account_status = 'ACTIVE' THEN 1 ELSE 0 END)
      comment: "Total number of active corporate accounts. Baseline B2B portfolio size metric — tracks corporate segment growth."
    - name: "total_annual_revenue_target"
      expr: SUM(CAST(annual_revenue_target AS DOUBLE))
      comment: "Sum of annual revenue targets across all corporate accounts. Measures total contracted revenue commitment from the corporate segment."
    - name: "avg_annual_revenue_target"
      expr: AVG(CAST(annual_revenue_target AS DOUBLE))
      comment: "Average annual revenue target per corporate account. Benchmarks account value — used to identify under-performing accounts relative to portfolio average."
    - name: "total_credit_limit_exposure"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all corporate accounts. Measures aggregate credit exposure — monitored by finance for AR risk management."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per corporate account. Benchmarks credit policy application — outliers may indicate inconsistent credit approval processes."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average negotiated discount percentage across corporate accounts. Tracks rate integrity — high averages indicate margin erosion from over-discounting."
    - name: "direct_billing_account_count"
      expr: SUM(CASE WHEN direct_billing_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Number of accounts with direct billing enabled. Measures AR exposure scope — used by finance to manage billing operations and credit risk."
    - name: "contracts_expiring_within_90_days"
      expr: SUM(CASE WHEN contract_end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 ELSE 0 END)
      comment: "Number of corporate contracts expiring within the next 90 days. Critical pipeline metric for account management — drives proactive renewal outreach to protect contracted revenue."
    - name: "mice_eligible_account_count"
      expr: SUM(CASE WHEN mice_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Number of corporate accounts eligible for MICE business. Measures the addressable corporate events market — informs group sales strategy and venue investment decisions."
    - name: "loyalty_eligible_account_count"
      expr: SUM(CASE WHEN loyalty_program_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Number of corporate accounts eligible for loyalty program benefits. Tracks loyalty program penetration in the corporate segment — low rates indicate enrollment opportunity."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_vip_designation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "VIP guest designation metrics covering active VIP portfolio, service requirement complexity, revenue thresholds, and designation health. Enables guest experience and operations teams to manage high-value guest service delivery."
  source: "`vibe_travel_hospitality_v1`.`guest`.`vip_designation`"
  dimensions:
    - name: "vip_level"
      expr: vip_level
      comment: "VIP level assigned to the guest (e.g. VIP1, VIP2, Celebrity) — primary stratification dimension for high-value guest analysis."
    - name: "designation_status"
      expr: designation_status
      comment: "Current status of the VIP designation (e.g. active, expired, revoked) — used to filter to active designations."
    - name: "designation_scope"
      expr: designation_scope
      comment: "Scope of the designation (e.g. property-specific, chain-wide) — determines where VIP protocols apply."
    - name: "designation_reason"
      expr: designation_reason
      comment: "Reason for the VIP designation (e.g. loyalty status, corporate account, celebrity) — informs designation policy and resource allocation."
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the VIP designation — enables property-level VIP guest load analysis."
    - name: "amenity_tier_code"
      expr: amenity_tier_code
      comment: "Amenity tier assigned to the VIP guest — determines amenity package cost and service complexity."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the VIP designation became effective — tracks designation volume trends over time."
    - name: "upgrade_eligible"
      expr: upgrade_eligible
      comment: "Whether the VIP guest is eligible for a room upgrade — used to plan upgrade inventory allocation."
    - name: "gm_greeting_required"
      expr: gm_greeting_required
      comment: "Whether a General Manager greeting is required for this VIP — used to schedule GM time and assess operational load."
    - name: "security_escort_required"
      expr: security_escort_required
      comment: "Whether a security escort is required for this VIP — informs security staffing and operational planning."
    - name: "media_blackout"
      expr: media_blackout
      comment: "Whether a media blackout is in effect for this guest — critical privacy and security protocol flag."
  measures:
    - name: "total_active_vip_designations"
      expr: SUM(CASE WHEN designation_status = 'ACTIVE' THEN 1 ELSE 0 END)
      comment: "Total number of currently active VIP designations. Baseline metric for VIP guest load — drives staffing and amenity inventory planning."
    - name: "unique_vip_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of distinct guest profiles with VIP designations. Measures the size of the high-value guest portfolio — key metric for loyalty and guest experience strategy."
    - name: "avg_revenue_threshold"
      expr: AVG(CAST(revenue_threshold_amount AS DOUBLE))
      comment: "Average revenue threshold amount set for VIP designation eligibility. Benchmarks the revenue bar for VIP status — used to calibrate designation criteria against actual guest spend."
    - name: "total_revenue_threshold"
      expr: SUM(CAST(revenue_threshold_amount AS DOUBLE))
      comment: "Sum of revenue threshold amounts across all VIP designations. Represents the total contracted revenue commitment associated with VIP-level guests."
    - name: "gm_greeting_required_count"
      expr: SUM(CASE WHEN gm_greeting_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of active VIP designations requiring a GM greeting. Directly drives GM schedule planning — high counts during peak periods require advance coordination."
    - name: "security_escort_required_count"
      expr: SUM(CASE WHEN security_escort_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of VIP designations requiring a security escort. Informs security staffing requirements — used by operations to ensure adequate security coverage for high-profile guests."
    - name: "upgrade_eligible_vip_count"
      expr: SUM(CASE WHEN upgrade_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Number of VIP guests eligible for room upgrades. Drives upgrade inventory allocation decisions — ensures high-value guests receive priority upgrade consideration."
    - name: "media_blackout_vip_count"
      expr: SUM(CASE WHEN media_blackout = TRUE THEN 1 ELSE 0 END)
      comment: "Number of VIP guests with active media blackout requirements. Critical privacy compliance metric — ensures front-line staff are briefed on media-sensitive guests."
    - name: "vip_designation_expiry_within_30_days"
      expr: SUM(CASE WHEN effective_until BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 30) AND designation_status = 'ACTIVE' THEN 1 ELSE 0 END)
      comment: "Number of active VIP designations expiring within 30 days. Enables proactive renewal outreach — prevents inadvertent downgrade of high-value guests due to expired designations."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_preference`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest preference capture and fulfillment metrics. Tracks preference coverage, fulfillment rates, ADA requirement volumes, and allergy flag rates — enabling personalization effectiveness and compliance monitoring."
  source: "`vibe_travel_hospitality_v1`.`guest`.`preference`"
  dimensions:
    - name: "preference_type"
      expr: preference_type
      comment: "Type of preference (e.g. bed type, dietary, room temperature, housekeeping) — primary dimension for preference category analysis."
    - name: "preference_status"
      expr: preference_status
      comment: "Current status of the preference record (e.g. active, expired, fulfilled) — used to filter to actionable preferences."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Whether the preference was fulfilled during the stay — key operational quality dimension for personalization effectiveness."
    - name: "category"
      expr: preference_category
      comment: "High-level preference category — enables rolled-up analysis across preference types."
    - name: "property_id"
      expr: property_id
      comment: "Property where the preference applies — enables property-level preference fulfillment benchmarking."
    - name: "loyalty_tier_at_capture"
      expr: loyalty_tier_at_capture
      comment: "Loyalty tier of the guest when the preference was captured — enables tier-based preference profile analysis."
    - name: "source"
      expr: source
      comment: "Source system or touchpoint where the preference was captured — informs preference data collection channel effectiveness."
    - name: "is_ada_requirement"
      expr: is_ada_requirement
      comment: "Whether the preference is an ADA accessibility requirement — mandatory compliance dimension for disability accommodation tracking."
    - name: "is_allergy"
      expr: is_allergy
      comment: "Whether the preference is an allergy — critical safety dimension requiring operational priority handling."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the preference is mandatory (must be fulfilled) — used to prioritize fulfillment operations."
    - name: "consent_given"
      expr: consent_given
      comment: "Whether the guest gave consent for this preference to be stored and used — required for GDPR-compliant preference management."
    - name: "preference_captured_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the preference was captured — tracks preference data collection velocity over time."
  measures:
    - name: "total_active_preferences"
      expr: SUM(CASE WHEN preference_status = 'ACTIVE' THEN 1 ELSE 0 END)
      comment: "Total number of active guest preference records. Measures the depth of guest preference data available for personalization — a key input to personalization ROI."
    - name: "unique_guests_with_preferences"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of distinct guest profiles with at least one preference on record. Measures personalization data coverage across the guest base."
    - name: "preference_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN fulfillment_status = 'FULFILLED' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of guest preferences that were fulfilled. Core personalization effectiveness KPI — low rates indicate operational gaps in preference delivery."
    - name: "mandatory_preference_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_mandatory = TRUE AND fulfillment_status = 'FULFILLED' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN is_mandatory = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Fulfillment rate for mandatory preferences only. Stricter operational KPI — failure to fulfill mandatory preferences directly impacts guest satisfaction scores and complaint rates."
    - name: "ada_requirement_count"
      expr: SUM(CASE WHEN is_ada_requirement = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of ADA accessibility requirements on record. Compliance metric — ensures the property is tracking and fulfilling legal accessibility obligations."
    - name: "allergy_preference_count"
      expr: SUM(CASE WHEN is_allergy = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of allergy-related preferences on record. Critical safety metric — high volumes require F&B and housekeeping teams to be briefed on allergy protocols."
    - name: "avg_room_temperature_preference_celsius"
      expr: AVG(CAST(room_temperature_celsius AS DOUBLE))
      comment: "Average preferred room temperature in Celsius across guests with temperature preferences. Informs HVAC default settings and energy management strategy."
    - name: "consent_given_preference_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_given = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of preference records with explicit guest consent. Measures GDPR-compliant preference data coverage — preferences without consent cannot be used for personalization."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest segment assignment quality, revenue contribution, and loyalty economics metrics. Enables revenue management and CRM teams to evaluate segment performance, assignment confidence, and yield contribution."
  source: "`vibe_travel_hospitality_v1`.`guest`.`segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of segment (e.g. transient, group, corporate, wholesale) — primary revenue management segmentation dimension."
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment assignment (e.g. active, superseded, expired) — used to filter to current assignments."
    - name: "category"
      expr: segment_category
      comment: "High-level segment category — enables rolled-up segment performance analysis."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign the guest to this segment (e.g. rule-based, ML model, manual) — informs assignment quality and model performance."
    - name: "rate_strategy_type"
      expr: rate_strategy_type
      comment: "Rate strategy associated with the segment (e.g. BAR, negotiated, opaque) — links segment to pricing strategy."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level of the segment in the hierarchy (e.g. market, sub-market, micro) — enables hierarchical segment roll-up analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the segment assignment — enables property-level segment mix analysis."
    - name: "yield_management_flag"
      expr: yield_management_flag
      comment: "Whether the segment is subject to yield management controls — used to separate yield-managed from fixed-rate segments."
    - name: "loyalty_points_eligible"
      expr: loyalty_points_eligible
      comment: "Whether guests in this segment earn loyalty points — tracks loyalty-eligible segment volume."
    - name: "commission_eligible"
      expr: commission_eligible
      comment: "Whether the segment is commission-eligible — used to calculate total commission liability by segment."
    - name: "assignment_effective_month"
      expr: DATE_TRUNC('MONTH', assignment_effective_date)
      comment: "Month the segment assignment became effective — tracks segment migration patterns over time."
  measures:
    - name: "total_segment_assignments"
      expr: COUNT(1)
      comment: "Total number of guest segment assignment records. Baseline volume metric for segment coverage analysis."
    - name: "unique_guests_assigned"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of distinct guest profiles with a segment assignment. Measures segmentation coverage across the guest base — ungrouped guests cannot be targeted by segment-based strategies."
    - name: "avg_assignment_confidence_score"
      expr: AVG(CAST(assignment_confidence_score AS DOUBLE))
      comment: "Average confidence score of segment assignments. Measures segmentation model quality — low scores indicate the model is uncertain and assignments may be unreliable for targeting."
    - name: "avg_adr_index_vs_property"
      expr: AVG(CAST(adr_index_vs_property AS DOUBLE))
      comment: "Average ADR index of segment guests relative to property average. Measures segment rate premium or discount — used by revenue management to evaluate segment pricing strategy."
    - name: "avg_ancillary_revenue_per_stay"
      expr: AVG(CAST(ancillary_revenue_per_stay AS DOUBLE))
      comment: "Average ancillary revenue per stay for guests in this segment. Measures segment-level ancillary yield — informs upsell strategy by segment."
    - name: "avg_los_days"
      expr: AVG(CAST(average_los_days AS DOUBLE))
      comment: "Average length of stay for guests in this segment. Key revenue management input — longer LOS segments contribute more room nights and are prioritized during displacement analysis."
    - name: "avg_fb_attachment_rate_pct"
      expr: AVG(CAST(fb_attachment_rate_pct AS DOUBLE))
      comment: "Average F&B attachment rate for guests in this segment. Measures F&B revenue capture by segment — informs outlet staffing and menu strategy for high-attachment segments."
    - name: "avg_revpar_contribution_pct"
      expr: AVG(CAST(revpar_contribution_pct AS DOUBLE))
      comment: "Average RevPAR contribution percentage for this segment. Measures each segment's share of total RevPAR — core revenue management KPI for segment mix optimization."
    - name: "avg_loyalty_points_multiplier"
      expr: AVG(CAST(loyalty_points_multiplier AS DOUBLE))
      comment: "Average loyalty points multiplier for guests in this segment. Measures loyalty cost per segment — high multipliers increase loyalty liability and must be balanced against revenue contribution."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate for commission-eligible segments. Tracks distribution cost by segment — high commission rates erode net revenue and inform channel strategy decisions."
$$;
