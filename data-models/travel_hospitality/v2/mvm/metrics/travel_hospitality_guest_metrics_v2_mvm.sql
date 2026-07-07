-- Metric views for domain: guest | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-27 02:47:23

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core guest profile metrics tracking active guest population, loyalty enrollment, marketing reachability, and VIP composition — essential for CRM strategy, loyalty program investment, and guest acquisition decisions."
  source: "`vibe_travel_hospitality_v1`.`guest`.`profile`"
  dimensions:
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Guest loyalty tier (e.g. Silver, Gold, Platinum) for segmenting KPIs by loyalty value band."
    - name: "guest_type"
      expr: guest_type
      comment: "Classification of guest (e.g. leisure, corporate, group) for demand-mix analysis."
    - name: "vip_status"
      expr: vip_status
      comment: "VIP designation level on the guest profile for high-touch service segmentation."
    - name: "country_of_residence_code"
      expr: country_of_residence_code
      comment: "Guest country of residence for geographic demand and compliance analysis."
    - name: "profile_status"
      expr: profile_status
      comment: "Active/inactive/merged status of the guest profile for data quality and reachable audience sizing."
    - name: "gender"
      expr: gender
      comment: "Guest gender for demographic segmentation and personalization strategy."
    - name: "preferred_language_code"
      expr: preferred_language_code
      comment: "Guest preferred language for localization and communication strategy."
    - name: "loyalty_enrollment_year"
      expr: YEAR(loyalty_enrollment_date)
      comment: "Year of loyalty program enrollment for cohort-based loyalty growth analysis."
    - name: "creation_year"
      expr: YEAR(created_timestamp)
      comment: "Year the guest profile was created for new guest acquisition trend analysis."
  measures:
    - name: "active_guest_profiles"
      expr: COUNT(CASE WHEN profile_status = 'ACTIVE' THEN profile_id END)
      comment: "Count of active guest profiles. Measures the reachable, engaged guest base — a primary CRM health KPI used to size marketing audiences and track acquisition performance."
    - name: "loyalty_enrolled_guests"
      expr: COUNT(CASE WHEN loyalty_member_number IS NOT NULL THEN profile_id END)
      comment: "Count of guests enrolled in the loyalty program. Directly tied to loyalty revenue uplift and repeat-stay rates — a key metric for loyalty program ROI decisions."
    - name: "loyalty_enrollment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN loyalty_member_number IS NOT NULL THEN profile_id END) / NULLIF(COUNT(profile_id), 0), 2)
      comment: "Percentage of guest profiles enrolled in the loyalty program. Tracks loyalty penetration — a strategic KPI for loyalty investment and enrollment campaign effectiveness."
    - name: "marketing_opt_in_guests"
      expr: COUNT(CASE WHEN marketing_opt_in = TRUE THEN profile_id END)
      comment: "Count of guests who have opted into marketing communications. Defines the addressable marketing audience — critical for campaign planning and revenue generation."
    - name: "marketing_opt_in_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN marketing_opt_in = TRUE THEN profile_id END) / NULLIF(COUNT(profile_id), 0), 2)
      comment: "Percentage of guest profiles opted into marketing. A compliance and commercial KPI — declining rates signal consent erosion and reduced campaign reach."
    - name: "vip_guest_count"
      expr: COUNT(CASE WHEN vip_status IS NOT NULL AND vip_status != '' THEN profile_id END)
      comment: "Count of guests with an active VIP designation. VIP guests drive disproportionate revenue — tracking this population informs high-touch service staffing and amenity budget."
    - name: "gdpr_erasure_requested_count"
      expr: COUNT(CASE WHEN gdpr_erasure_requested = TRUE THEN profile_id END)
      comment: "Count of guest profiles with a pending GDPR erasure request. A regulatory compliance KPI — elevated counts trigger legal and data governance escalation."
    - name: "merged_profile_count"
      expr: COUNT(CASE WHEN is_merge_survivor = FALSE AND merged_into_profile_id IS NOT NULL THEN profile_id END)
      comment: "Count of guest profiles that have been merged into a survivor profile. Tracks duplicate resolution throughput — a data quality KPI that affects loyalty accuracy and personalization."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_stay_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest stay performance metrics covering revenue, length of stay, ancillary attachment, satisfaction scores, and service recovery — the primary operational and financial KPI layer for the guest domain."
  source: "`vibe_travel_hospitality_v1`.`guest`.`stay_history`"
  dimensions:
    - name: "stay_status"
      expr: stay_status
      comment: "Status of the stay record (e.g. checked-out, cancelled, no-show) for filtering completed stays in revenue analysis."
    - name: "guest_type"
      expr: guest_type
      comment: "Guest classification (leisure, corporate, group) for demand-mix and revenue segmentation."
    - name: "loyalty_tier_at_stay"
      expr: loyalty_tier_at_stay
      comment: "Loyalty tier of the guest at the time of stay for tier-based revenue and behavior analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the stay for financial reconciliation and channel analysis."
    - name: "arrival_month"
      expr: DATE_TRUNC('MONTH', arrival_date)
      comment: "Month of guest arrival for seasonal demand and revenue trend analysis."
    - name: "arrival_year"
      expr: YEAR(arrival_date)
      comment: "Year of guest arrival for year-over-year performance comparison."
    - name: "booking_month"
      expr: DATE_TRUNC('MONTH', booking_date)
      comment: "Month the stay was booked for lead-time and booking window analysis."
    - name: "complimentary_flag"
      expr: complimentary_flag
      comment: "Indicates whether the stay was complimentary — used to separate revenue-generating stays from comp stays in financial reporting."
    - name: "service_recovery_flag"
      expr: service_recovery_flag
      comment: "Indicates whether a service recovery action was taken during the stay — used to track operational quality incidents."
    - name: "vip_code"
      expr: vip_code
      comment: "VIP code assigned at the time of stay for high-value guest experience analysis."
  measures:
    - name: "total_room_revenue"
      expr: SUM(CAST(room_revenue AS DOUBLE))
      comment: "Total room revenue across all stays. The primary top-line revenue KPI for the guest domain — used in every financial review and forecasting model."
    - name: "total_ancillary_revenue"
      expr: SUM(CAST(ancillary_revenue AS DOUBLE))
      comment: "Total ancillary revenue (spa, F&B, activities, etc.) generated by guests. Tracks revenue diversification beyond room revenue — a strategic KPI for ancillary growth initiatives."
    - name: "total_fb_revenue"
      expr: SUM(CAST(fb_revenue AS DOUBLE))
      comment: "Total food and beverage revenue from guest stays. F&B is a major ancillary revenue stream — tracked separately for outlet performance and menu strategy decisions."
    - name: "total_folio_amount"
      expr: SUM(CAST(total_folio_amount AS DOUBLE))
      comment: "Total guest folio value including all charges. Represents total guest spend — the most comprehensive revenue KPI for guest lifetime value calculations."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected across stays. Required for regulatory tax reporting and financial reconciliation."
    - name: "avg_daily_rate"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average Daily Rate across stays. A foundational hospitality KPI used in RevPAR calculations and rate strategy benchmarking — appears on every revenue management dashboard."
    - name: "avg_total_folio_per_stay"
      expr: AVG(CAST(total_folio_amount AS DOUBLE))
      comment: "Average total guest spend per stay. Measures guest value per visit — used to benchmark upsell effectiveness and compare segment profitability."
    - name: "avg_ancillary_revenue_per_stay"
      expr: AVG(CAST(ancillary_revenue AS DOUBLE))
      comment: "Average ancillary revenue per stay. Tracks ancillary attachment efficiency — a KPI for F&B, spa, and activity revenue strategy decisions."
    - name: "avg_gss_score"
      expr: AVG(CAST(gss_score AS DOUBLE))
      comment: "Average Guest Satisfaction Score across stays. The primary guest experience quality KPI — directly tied to repeat-stay rates, online reputation, and brand investment decisions."
    - name: "total_stays"
      expr: COUNT(stay_history_id)
      comment: "Total number of stay records. Baseline volume KPI for occupancy trend analysis and year-over-year demand comparison."
    - name: "unique_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of distinct guests with a stay record. Measures actual guest reach — used to calculate repeat-visit rates and loyalty program penetration."
    - name: "service_recovery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN service_recovery_flag = TRUE THEN stay_history_id END) / NULLIF(COUNT(stay_history_id), 0), 2)
      comment: "Percentage of stays requiring a service recovery action. A guest experience quality KPI — elevated rates signal operational failures that drive churn and negative reviews."
    - name: "complimentary_stay_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN complimentary_flag = TRUE THEN stay_history_id END) / NULLIF(COUNT(stay_history_id), 0), 2)
      comment: "Percentage of stays that were complimentary. Tracks comp room usage — a cost control KPI monitored by revenue management and finance to prevent margin erosion."
    - name: "ancillary_revenue_attachment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ancillary_revenue > 0 THEN stay_history_id END) / NULLIF(COUNT(stay_history_id), 0), 2)
      comment: "Percentage of stays with any ancillary revenue. Measures upsell penetration — a strategic KPI for ancillary revenue growth programs and front-desk incentive design."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_communication_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest communication consent metrics tracking opt-in rates, consent health, double opt-in compliance, and suppression list exposure — critical for GDPR/regulatory compliance and addressable marketing audience management."
  source: "`vibe_travel_hospitality_v1`.`guest`.`communication_consent`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent captured (e.g. email marketing, SMS, profiling) for consent portfolio analysis."
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent record (e.g. granted, withdrawn, expired) for compliance reporting."
    - name: "consent_method"
      expr: consent_method
      comment: "Method by which consent was captured (e.g. web form, in-person, API) for consent quality analysis."
    - name: "consent_source"
      expr: consent_source
      comment: "Source system or channel that captured the consent for data lineage and audit purposes."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction governing the consent record (e.g. EU, UK, US) for regional compliance reporting."
    - name: "legal_basis"
      expr: legal_basis
      comment: "GDPR or equivalent legal basis for processing (e.g. consent, legitimate interest) for regulatory audit."
    - name: "consent_purpose"
      expr: consent_purpose
      comment: "Business purpose for which consent was obtained (e.g. marketing, analytics) for purpose-limitation compliance."
    - name: "consent_granted_month"
      expr: DATE_TRUNC('MONTH', consent_granted_date)
      comment: "Month consent was granted for trend analysis of consent acquisition rates."
    - name: "guest_country_code"
      expr: guest_country_code
      comment: "Country of the guest at consent capture for geographic compliance segmentation."
  measures:
    - name: "active_consents"
      expr: COUNT(CASE WHEN consent_status = 'GRANTED' AND record_active_flag = TRUE THEN communication_consent_id END)
      comment: "Count of currently active, granted consent records. Defines the legally compliant addressable marketing audience — a primary compliance and commercial KPI."
    - name: "consent_withdrawal_count"
      expr: COUNT(CASE WHEN consent_status = 'WITHDRAWN' THEN communication_consent_id END)
      comment: "Count of withdrawn consent records. Tracks opt-out volume — rising withdrawals signal brand trust issues or over-communication, triggering marketing strategy review."
    - name: "consent_withdrawal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_status = 'WITHDRAWN' THEN communication_consent_id END) / NULLIF(COUNT(communication_consent_id), 0), 2)
      comment: "Percentage of consent records that have been withdrawn. A regulatory risk KPI — high withdrawal rates in specific jurisdictions may indicate compliance gaps or consent fatigue."
    - name: "double_opt_in_confirmed_count"
      expr: COUNT(CASE WHEN double_opt_in_flag = TRUE AND double_opt_in_confirmed_timestamp IS NOT NULL THEN communication_consent_id END)
      comment: "Count of consents confirmed via double opt-in. Double opt-in is a gold-standard compliance mechanism — tracking confirmed DOI volume is essential for GDPR audit readiness."
    - name: "double_opt_in_confirmation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN double_opt_in_flag = TRUE AND double_opt_in_confirmed_timestamp IS NOT NULL THEN communication_consent_id END) / NULLIF(COUNT(CASE WHEN double_opt_in_flag = TRUE THEN communication_consent_id END), 0), 2)
      comment: "Percentage of double opt-in requests that were confirmed by the guest. Low confirmation rates indicate friction in the consent journey — actionable for UX and email deliverability teams."
    - name: "suppression_list_count"
      expr: COUNT(CASE WHEN suppression_list_flag = TRUE THEN communication_consent_id END)
      comment: "Count of guest records on the suppression list. Suppressed contacts must not receive communications — tracking this volume is a hard compliance requirement under CAN-SPAM and GDPR."
    - name: "profiling_consent_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN profiling_consent_flag = TRUE THEN communication_consent_id END) / NULLIF(COUNT(communication_consent_id), 0), 2)
      comment: "Percentage of guests who have consented to profiling. Profiling consent unlocks personalization and AI-driven recommendations — a strategic KPI for data-driven marketing capability."
    - name: "third_party_sharing_consent_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN third_party_sharing_consent_flag = TRUE THEN communication_consent_id END) / NULLIF(COUNT(communication_consent_id), 0), 2)
      comment: "Percentage of guests who have consented to third-party data sharing. Governs partner marketing and data monetization eligibility — a compliance and commercial KPI for partnership decisions."
    - name: "expired_consent_count"
      expr: COUNT(CASE WHEN consent_expiry_date < CURRENT_DATE() AND consent_status != 'WITHDRAWN' THEN communication_consent_id END)
      comment: "Count of consent records that have passed their expiry date without being renewed or withdrawn. Expired consents create regulatory exposure — this KPI drives consent renewal campaign prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_preference`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest preference metrics tracking preference capture volume, fulfillment rates, ADA requirement prevalence, and allergy/dietary risk — used to drive personalization investment, operational readiness, and duty-of-care compliance."
  source: "`vibe_travel_hospitality_v1`.`guest`.`preference`"
  dimensions:
    - name: "preference_type"
      expr: preference_type
      comment: "Type of guest preference (e.g. bed type, dietary, amenity) for preference portfolio analysis."
    - name: "preference_status"
      expr: preference_status
      comment: "Current status of the preference record (e.g. active, expired, fulfilled) for operational tracking."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Whether the preference was fulfilled during the stay — a direct measure of personalization execution quality."
    - name: "data_classification"
      expr: data_classification
      comment: "Data sensitivity classification of the preference (e.g. PII, sensitive health) for data governance reporting."
    - name: "loyalty_tier_at_capture"
      expr: loyalty_tier_at_capture
      comment: "Guest loyalty tier when the preference was captured for tier-based personalization analysis."
    - name: "source"
      expr: source
      comment: "Source system or channel where the preference was captured for data quality and completeness analysis."
    - name: "consent_given"
      expr: consent_given
      comment: "Whether the guest gave explicit consent for this preference to be stored and used — a compliance dimension."
  measures:
    - name: "total_active_preferences"
      expr: COUNT(CASE WHEN preference_status = 'ACTIVE' THEN preference_id END)
      comment: "Count of active guest preference records. Measures the depth of guest preference data available for personalization — a KPI for CRM data richness and personalization program maturity."
    - name: "preference_fulfillment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fulfillment_status = 'FULFILLED' THEN preference_id END) / NULLIF(COUNT(CASE WHEN fulfillment_status IS NOT NULL THEN preference_id END), 0), 2)
      comment: "Percentage of preferences that were successfully fulfilled. Directly measures personalization execution quality — low fulfillment rates drive guest dissatisfaction and loyalty erosion."
    - name: "ada_requirement_count"
      expr: COUNT(CASE WHEN is_ada_requirement = TRUE THEN preference_id END)
      comment: "Count of preferences flagged as ADA (Americans with Disabilities Act) requirements. ADA non-compliance carries legal liability — this KPI ensures operational teams are aware of mandatory accommodation volume."
    - name: "allergy_preference_count"
      expr: COUNT(CASE WHEN is_allergy = TRUE THEN preference_id END)
      comment: "Count of guest preferences flagged as allergy-related. Allergy mismanagement is a duty-of-care and liability risk — tracking allergy preference volume informs F&B and housekeeping safety protocols."
    - name: "mandatory_preference_unfulfilled_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE AND fulfillment_status != 'FULFILLED' THEN preference_id END)
      comment: "Count of mandatory preferences that were not fulfilled. Mandatory preferences represent guest expectations that, if unmet, directly cause complaints and loyalty defection — a critical operational risk KPI."
    - name: "unique_guests_with_preferences"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of distinct guests with at least one preference on record. Measures personalization data coverage across the guest base — used to track CRM enrichment program progress."
    - name: "avg_room_temperature_preference_celsius"
      expr: AVG(CAST(room_temperature_celsius AS DOUBLE))
      comment: "Average preferred room temperature in Celsius across guests. Informs HVAC default settings and energy management strategy — a compound KPI linking guest comfort to operational cost."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_vip_designation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "VIP guest designation metrics tracking active VIP population, upgrade eligibility, special handling requirements, and revenue thresholds — used to manage high-value guest experience investment and operational readiness."
  source: "`vibe_travel_hospitality_v1`.`guest`.`vip_designation`"
  dimensions:
    - name: "vip_level"
      expr: vip_level
      comment: "VIP tier level (e.g. VIP1, VIP2, Celebrity) for stratified high-value guest analysis."
    - name: "designation_status"
      expr: designation_status
      comment: "Current status of the VIP designation (e.g. active, expired, revoked) for active VIP population management."
    - name: "designation_scope"
      expr: designation_scope
      comment: "Scope of the VIP designation (e.g. property-level, chain-wide) for operational planning."
    - name: "designation_reason"
      expr: designation_reason
      comment: "Reason for VIP designation (e.g. loyalty, revenue, celebrity) for VIP program composition analysis."
    - name: "amenity_tier_code"
      expr: amenity_tier_code
      comment: "Amenity tier assigned to the VIP guest for amenity cost and fulfillment planning."
    - name: "effective_from_year"
      expr: YEAR(effective_from)
      comment: "Year the VIP designation became effective for cohort and tenure analysis."
    - name: "upgrade_eligible"
      expr: upgrade_eligible
      comment: "Whether the VIP guest is eligible for a room upgrade — used to plan upgrade inventory allocation."
    - name: "gm_greeting_required"
      expr: gm_greeting_required
      comment: "Whether a General Manager greeting is required for this VIP — used to schedule GM time and track high-touch service obligations."
  measures:
    - name: "active_vip_designations"
      expr: COUNT(CASE WHEN designation_status = 'ACTIVE' THEN vip_designation_id END)
      comment: "Count of currently active VIP designations. Defines the high-touch service workload — used by operations to staff concierge, pre-arrival, and amenity fulfillment teams."
    - name: "upgrade_eligible_vip_count"
      expr: COUNT(CASE WHEN upgrade_eligible = TRUE AND designation_status = 'ACTIVE' THEN vip_designation_id END)
      comment: "Count of active VIP guests eligible for room upgrades. Drives upgrade inventory pre-allocation decisions — a revenue management and guest satisfaction KPI."
    - name: "gm_greeting_required_count"
      expr: COUNT(CASE WHEN gm_greeting_required = TRUE AND designation_status = 'ACTIVE' THEN vip_designation_id END)
      comment: "Count of active VIP designations requiring a GM greeting. Directly informs GM scheduling and high-touch service capacity planning — an operational readiness KPI."
    - name: "security_escort_required_count"
      expr: COUNT(CASE WHEN security_escort_required = TRUE AND designation_status = 'ACTIVE' THEN vip_designation_id END)
      comment: "Count of active VIP guests requiring a security escort. A safety and operational planning KPI — security resource allocation depends on this count."
    - name: "media_blackout_vip_count"
      expr: COUNT(CASE WHEN media_blackout = TRUE AND designation_status = 'ACTIVE' THEN vip_designation_id END)
      comment: "Count of active VIP guests with a media blackout policy. Tracks privacy-sensitive VIP guests — a risk management KPI to prevent reputational incidents from unauthorized media exposure."
    - name: "avg_revenue_threshold_amount"
      expr: AVG(CAST(revenue_threshold_amount AS DOUBLE))
      comment: "Average revenue threshold amount associated with VIP designations. Benchmarks the revenue contribution bar for VIP status — used to calibrate VIP program entry criteria and ROI."
    - name: "total_revenue_threshold_amount"
      expr: SUM(CAST(revenue_threshold_amount AS DOUBLE))
      comment: "Total revenue threshold amount across all VIP designations. Represents the aggregate revenue commitment associated with the VIP portfolio — a financial planning KPI for high-value guest program investment."
    - name: "vip_expiring_within_30_days"
      expr: COUNT(CASE WHEN designation_status = 'ACTIVE' AND effective_until BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 30) THEN vip_designation_id END)
      comment: "Count of active VIP designations expiring within the next 30 days. A proactive retention KPI — enables CRM teams to trigger renewal outreach before high-value guests lose their VIP status."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_corporate_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corporate account metrics tracking active account portfolio, revenue targets, credit exposure, and contract health — used by sales, revenue management, and finance to manage B2B hospitality relationships."
  source: "`vibe_travel_hospitality_v1`.`guest`.`corporate_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the corporate account (e.g. active, suspended, closed) for portfolio health analysis."
    - name: "account_type"
      expr: account_type
      comment: "Type of corporate account (e.g. corporate, government, NGO) for segment-level revenue analysis."
    - name: "vip_tier"
      expr: vip_tier
      comment: "VIP tier assigned to the corporate account for high-value account management prioritization."
    - name: "rate_program_type"
      expr: rate_program_type
      comment: "Rate program type associated with the account (e.g. negotiated, LRA, BAR) for rate strategy analysis."
    - name: "direct_billing_enabled"
      expr: direct_billing_enabled
      comment: "Whether direct billing is enabled for the account — a financial operations dimension for AR management."
    - name: "loyalty_program_eligible"
      expr: loyalty_program_eligible
      comment: "Whether the corporate account is eligible for the loyalty program — for loyalty-linked corporate revenue analysis."
    - name: "contract_start_year"
      expr: YEAR(contract_start_date)
      comment: "Year the corporate contract started for contract vintage and renewal cycle analysis."
    - name: "billing_address_country_code"
      expr: billing_address_country_code
      comment: "Country of the corporate account billing address for geographic revenue and compliance analysis."
  measures:
    - name: "active_corporate_accounts"
      expr: COUNT(CASE WHEN account_status = 'ACTIVE' THEN corporate_account_id END)
      comment: "Count of active corporate accounts. The primary B2B portfolio size KPI — used by sales leadership to track account base growth and churn."
    - name: "total_annual_revenue_target"
      expr: SUM(CAST(annual_revenue_target AS DOUBLE))
      comment: "Total annual revenue target across all corporate accounts. Represents the committed B2B revenue pipeline — a critical financial planning KPI for sales quota setting and forecasting."
    - name: "avg_annual_revenue_target"
      expr: AVG(CAST(annual_revenue_target AS DOUBLE))
      comment: "Average annual revenue target per corporate account. Benchmarks account value — used to identify under-performing accounts and prioritize account manager resource allocation."
    - name: "total_credit_limit_exposure"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all corporate accounts. Measures aggregate credit exposure — a financial risk KPI monitored by finance and credit management teams."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average negotiated discount percentage across corporate accounts. Tracks rate dilution from corporate contracts — a revenue management KPI for contract negotiation strategy."
    - name: "direct_billing_account_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN direct_billing_enabled = TRUE THEN corporate_account_id END) / NULLIF(COUNT(corporate_account_id), 0), 2)
      comment: "Percentage of corporate accounts with direct billing enabled. Tracks AR complexity and cash flow risk — accounts with direct billing require active credit monitoring."
    - name: "contracts_expiring_within_90_days"
      expr: COUNT(CASE WHEN account_status = 'ACTIVE' AND contract_end_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN corporate_account_id END)
      comment: "Count of active corporate contracts expiring within 90 days. A proactive sales KPI — enables account managers to initiate renewal negotiations before revenue is at risk."
    - name: "mice_eligible_account_count"
      expr: COUNT(CASE WHEN mice_eligible = TRUE AND account_status = 'ACTIVE' THEN corporate_account_id END)
      comment: "Count of active corporate accounts eligible for MICE (Meetings, Incentives, Conferences, Exhibitions) business. MICE is a high-value revenue segment — tracking eligible accounts informs group sales targeting."
$$;