-- Metric views for domain: passenger | Business: Airlines | Version: 1 | Generated on: 2026-05-07 15:08:57

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`passenger_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core passenger profile metrics tracking profile quality, completeness, segmentation, and opt-in rates. Used by CRM, loyalty, and marketing teams to assess the health and richness of the passenger master data asset."
  source: "`airlines_ecm`.`passenger`.`profile`"
  dimensions:
    - name: "passenger_type"
      expr: passenger_type
      comment: "Classifies the passenger (e.g. adult, child, infant, unaccompanied minor) for segmentation and service planning."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Business-defined customer segment (e.g. leisure, corporate, frequent flyer) used for targeted marketing and service differentiation."
    - name: "profile_status"
      expr: profile_status
      comment: "Current lifecycle status of the passenger profile (e.g. active, inactive, merged, deleted)."
    - name: "nationality"
      expr: nationality
      comment: "Passenger nationality, used for regulatory reporting, route demand analysis, and personalisation."
    - name: "country_of_residence"
      expr: country_of_residence
      comment: "Country where the passenger resides, used for market segmentation and demand forecasting."
    - name: "gender"
      expr: gender
      comment: "Passenger gender, used for demographic analysis and personalisation."
    - name: "preferred_language"
      expr: preferred_language
      comment: "Passenger preferred communication language, used for localisation and service quality."
    - name: "vip_indicator"
      expr: vip_indicator
      comment: "Flags whether the passenger holds VIP status, enabling premium service prioritisation."
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Indicates whether the passenger has opted in to marketing communications."
    - name: "creation_source"
      expr: creation_source
      comment: "Channel or system through which the profile was originally created (e.g. web, mobile, GDS, airport)."
    - name: "profile_created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month in which the passenger profile was created, used for cohort and growth trend analysis."
  measures:
    - name: "total_active_profiles"
      expr: COUNT(CASE WHEN profile_status = 'ACTIVE' THEN profile_id END)
      comment: "Total number of active passenger profiles. Tracks the size of the addressable passenger base for marketing, loyalty, and service planning."
    - name: "avg_profile_completeness_score"
      expr: AVG(CAST(completeness_score AS DOUBLE))
      comment: "Average profile completeness score across all passengers. Low scores indicate data quality gaps that impair personalisation, regulatory compliance, and ancillary revenue targeting."
    - name: "vip_passenger_count"
      expr: COUNT(CASE WHEN vip_indicator = TRUE THEN profile_id END)
      comment: "Number of passengers flagged as VIP. Drives premium service resource allocation and high-value customer retention strategy."
    - name: "marketing_opt_in_count"
      expr: COUNT(CASE WHEN marketing_opt_in = TRUE THEN profile_id END)
      comment: "Number of passengers who have opted in to marketing communications. Directly determines the reachable audience for revenue-generating campaigns."
    - name: "data_sharing_consent_count"
      expr: COUNT(CASE WHEN data_sharing_consent = TRUE THEN profile_id END)
      comment: "Number of passengers who have granted data sharing consent. Critical for GDPR/privacy compliance and data monetisation eligibility."
    - name: "unaccompanied_minor_profile_count"
      expr: COUNT(CASE WHEN passenger_type = 'UNACCOMPANIED_MINOR' THEN profile_id END)
      comment: "Number of unaccompanied minor profiles. Drives staffing, guardian verification, and duty-of-care compliance planning."
    - name: "linked_ffp_profile_count"
      expr: COUNT(CASE WHEN ffp_member_id IS NOT NULL THEN profile_id END)
      comment: "Number of passenger profiles linked to a frequent flyer programme membership. Indicates loyalty programme penetration and data enrichment coverage."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`passenger_accessibility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accessibility and special assistance metrics for passengers requiring mobility, medical, or cognitive support. Used by ground operations, cabin crew planning, and compliance teams to ensure duty-of-care obligations are met and resources are correctly allocated."
  source: "`airlines_ecm`.`passenger`.`profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the accessibility profile (e.g. active, expired, pending review)."
  measures:
    - name: "Row Count"
      expr: COUNT(1)
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`passenger_apis_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advance Passenger Information System (APIS) submission compliance and quality metrics. Used by regulatory compliance, border control liaison, and operations teams to monitor submission timeliness, resubmission rates, and authority response outcomes."
  source: "`airlines_ecm`.`passenger`.`apis_submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the APIS submission (e.g. ACCEPTED, REJECTED, PENDING) used to track compliance outcomes."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the APIS data was submitted (e.g. SITA, ARINC, direct API) for channel performance monitoring."
    - name: "submission_method"
      expr: submission_method
      comment: "Technical method used for submission (e.g. batch, real-time) affecting latency and compliance risk."
    - name: "border_authority_code"
      expr: border_authority_code
      comment: "Code identifying the border authority receiving the APIS submission, used for jurisdiction-level compliance reporting."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for the flight, used to segment compliance metrics by regulatory jurisdiction."
    - name: "compliance_mandate"
      expr: compliance_mandate
      comment: "Regulatory mandate under which the submission is made (e.g. US CBP, UK UKBF, EU EES) for mandate-specific compliance tracking."
    - name: "resubmission_flag"
      expr: resubmission_flag
      comment: "Indicates whether this is a corrective resubmission of a prior APIS record, used to measure first-time accuracy rates."
    - name: "authority_response_code"
      expr: authority_response_code
      comment: "Response code returned by the border authority (e.g. OK, MATCH, REJECT) for outcome analysis."
    - name: "submission_date"
      expr: DATE_TRUNC('DAY', submission_timestamp)
      comment: "Date of APIS submission, used for daily compliance volume and timeliness trend analysis."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of APIS submission, used for monthly regulatory compliance reporting."
  measures:
    - name: "total_apis_submissions"
      expr: COUNT(1)
      comment: "Total number of APIS submissions processed. Baseline volume metric for regulatory compliance workload and system throughput monitoring."
    - name: "accepted_submission_count"
      expr: COUNT(CASE WHEN submission_status = 'ACCEPTED' THEN apis_submission_id END)
      comment: "Number of APIS submissions accepted by the border authority. Core compliance KPI — low acceptance rates trigger regulatory escalation."
    - name: "rejected_submission_count"
      expr: COUNT(CASE WHEN submission_status = 'REJECTED' THEN apis_submission_id END)
      comment: "Number of APIS submissions rejected by the border authority. Rejections carry regulatory penalty risk and require immediate remediation."
    - name: "resubmission_count"
      expr: COUNT(CASE WHEN resubmission_flag = TRUE THEN apis_submission_id END)
      comment: "Number of corrective resubmissions. High resubmission volumes indicate data quality issues in the originating booking or document capture process."
    - name: "distinct_passengers_submitted"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct passengers for whom APIS data has been submitted. Used to measure APIS coverage against total boarded passengers."
    - name: "distinct_flights_with_apis"
      expr: COUNT(DISTINCT flight_leg_id)
      comment: "Number of distinct flight legs for which at least one APIS submission exists. Measures APIS coverage across the operated schedule."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`passenger_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Passenger data consent and privacy compliance metrics. Used by the Data Protection Officer, legal, and marketing teams to monitor consent coverage, opt-in rates, expiry risk, and GDPR/regulatory compliance posture."
  source: "`airlines_ecm`.`passenger`.`consent`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent granted (e.g. marketing, data sharing, third-party transfer) for granular compliance tracking."
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent record (e.g. active, withdrawn, expired) for compliance posture assessment."
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal basis under which data is processed (e.g. consent, legitimate interest, contract) for GDPR Article 6 compliance reporting."
    - name: "processing_purpose"
      expr: processing_purpose
      comment: "Purpose for which data is processed (e.g. personalisation, analytics, safety) enabling purpose-limitation compliance monitoring."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Regulatory jurisdiction applicable to the consent record (e.g. EU, UK, US) for multi-jurisdiction compliance reporting."
    - name: "channel"
      expr: channel
      comment: "Channel through which consent was captured (e.g. web, mobile app, call centre) for consent quality and channel attribution analysis."
    - name: "opt_in_flag"
      expr: opt_in_flag
      comment: "Indicates whether the passenger opted in (TRUE) or out (FALSE) for the given consent type."
    - name: "minor_consent_flag"
      expr: minor_consent_flag
      comment: "Indicates whether this is a consent record for a minor passenger, requiring parental/guardian authorisation."
    - name: "dpo_review_flag"
      expr: dpo_review_flag
      comment: "Indicates whether the consent record has been flagged for Data Protection Officer review."
    - name: "consent_granted_month"
      expr: DATE_TRUNC('MONTH', granted_timestamp)
      comment: "Month in which consent was granted, used for consent acquisition trend analysis."
  measures:
    - name: "total_active_consents"
      expr: COUNT(CASE WHEN consent_status = 'ACTIVE' THEN consent_id END)
      comment: "Total number of active consent records. Represents the legally valid consent base for data processing activities — a core privacy compliance KPI."
    - name: "opt_in_consent_count"
      expr: COUNT(CASE WHEN opt_in_flag = TRUE AND consent_status = 'ACTIVE' THEN consent_id END)
      comment: "Number of active opt-in consents. Directly determines the legally reachable audience for marketing and data-driven revenue programmes."
    - name: "withdrawn_consent_count"
      expr: COUNT(CASE WHEN consent_status = 'WITHDRAWN' THEN consent_id END)
      comment: "Number of withdrawn consents. Rising withdrawal rates signal customer trust erosion and require immediate CX and privacy programme intervention."
    - name: "expiring_consent_count"
      expr: COUNT(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 30) AND consent_status = 'ACTIVE' THEN consent_id END)
      comment: "Number of active consents expiring within the next 30 days. Drives proactive consent renewal campaigns to prevent compliance gaps."
    - name: "dpo_review_pending_count"
      expr: COUNT(CASE WHEN dpo_review_flag = TRUE THEN consent_id END)
      comment: "Number of consent records flagged for DPO review. Tracks the open compliance review workload for the Data Protection Officer."
    - name: "minor_consent_count"
      expr: COUNT(CASE WHEN minor_consent_flag = TRUE THEN consent_id END)
      comment: "Number of consent records for minor passengers. Requires heightened compliance scrutiny and parental verification, tracked separately for regulatory audit purposes."
    - name: "distinct_passengers_with_consent"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct passengers with at least one consent record. Measures consent programme coverage across the passenger base."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`passenger_loyalty_linkage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Passenger loyalty programme linkage quality and engagement metrics. Used by the loyalty programme team, CRM, and commercial strategy to monitor FFP linkage health, tier distribution, data quality, and reciprocal benefit eligibility."
  source: "`airlines_ecm`.`passenger`.`loyalty_linkage`"
  dimensions:
    - name: "linkage_status"
      expr: linkage_status
      comment: "Current status of the loyalty linkage (e.g. active, suspended, unlinked) for programme health monitoring."
    - name: "linkage_type"
      expr: linkage_type
      comment: "Type of loyalty linkage (e.g. own programme, partner airline, alliance) for programme mix analysis."
    - name: "ffp_program_code"
      expr: ffp_program_code
      comment: "Frequent flyer programme code (e.g. own airline FFP, Star Alliance partner) for programme-level performance segmentation."
    - name: "alliance_code"
      expr: alliance_code
      comment: "Alliance affiliation of the linked FFP (e.g. Star Alliance, oneworld, SkyTeam) for alliance-level benefit and revenue analysis."
    - name: "sync_status"
      expr: sync_status
      comment: "Data synchronisation status between the passenger profile and the FFP system, used to identify stale or failed sync records."
    - name: "recognition_priority"
      expr: recognition_priority
      comment: "Priority order for tier recognition when a passenger holds multiple FFP linkages, used for service delivery consistency."
    - name: "reciprocal_benefit_eligible_flag"
      expr: reciprocal_benefit_eligible_flag
      comment: "Indicates whether the passenger is eligible for reciprocal benefits on partner airlines, affecting revenue sharing and service delivery."
    - name: "auto_recognition_enabled_flag"
      expr: auto_recognition_enabled_flag
      comment: "Indicates whether automatic tier recognition is enabled for this linkage, affecting check-in and boarding service delivery."
    - name: "tier_effective_month"
      expr: DATE_TRUNC('MONTH', tier_effective_date)
      comment: "Month in which the current tier status became effective, used for tier upgrade/downgrade trend analysis."
  measures:
    - name: "total_active_linkages"
      expr: COUNT(CASE WHEN linkage_status = 'ACTIVE' THEN loyalty_linkage_id END)
      comment: "Total number of active loyalty programme linkages. Measures the breadth of loyalty programme engagement across the passenger base."
    - name: "distinct_linked_passengers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct passengers with at least one loyalty linkage. Tracks loyalty programme penetration as a strategic retention KPI."
    - name: "reciprocal_benefit_eligible_count"
      expr: COUNT(CASE WHEN reciprocal_benefit_eligible_flag = TRUE AND linkage_status = 'ACTIVE' THEN loyalty_linkage_id END)
      comment: "Number of active linkages eligible for reciprocal partner benefits. Drives partner revenue sharing calculations and premium service delivery planning."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across loyalty linkage records. Low scores indicate matching or synchronisation issues that impair tier recognition and benefit delivery, directly affecting premium passenger satisfaction."
    - name: "sync_failed_linkage_count"
      expr: COUNT(CASE WHEN sync_status = 'FAILED' THEN loyalty_linkage_id END)
      comment: "Number of loyalty linkages with a failed synchronisation status. Failed syncs result in incorrect tier recognition at check-in, degrading the premium passenger experience and generating service recovery costs."
    - name: "unlinked_this_period_count"
      expr: COUNT(CASE WHEN linkage_status = 'UNLINKED' THEN loyalty_linkage_id END)
      comment: "Number of loyalty linkages that have been unlinked. Rising unlink rates signal loyalty programme churn and require retention intervention."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`passenger_ssr_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Special Service Request (SSR) operational and revenue metrics. Used by ground operations, cabin crew planning, catering, and ancillary revenue teams to monitor SSR volumes, fulfilment quality, chargeable service revenue, and medical clearance compliance."
  source: "`airlines_ecm`.`passenger`.`ssr_record`"
  dimensions:
    - name: "ssr_code"
      expr: ssr_code
      comment: "IATA SSR code (e.g. WCHR, VGML, UMNR, MEDA) identifying the type of special service requested."
    - name: "ssr_category"
      expr: ssr_category
      comment: "High-level category of the SSR (e.g. meal, wheelchair, medical, unaccompanied minor) for operational planning and resource allocation."
    - name: "ssr_status"
      expr: ssr_status
      comment: "Current fulfilment status of the SSR (e.g. requested, confirmed, delivered, cancelled) for operational tracking."
    - name: "is_chargeable"
      expr: is_chargeable
      comment: "Indicates whether the SSR generates ancillary revenue, used to separate operational obligations from revenue-generating services."
    - name: "charge_currency_code"
      expr: charge_currency_code
      comment: "Currency in which the SSR charge is denominated, used for multi-currency revenue reporting."
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the SSR was booked (e.g. web, mobile, call centre, airport) for channel attribution analysis."
    - name: "medical_clearance_status"
      expr: medical_clearance_status
      comment: "Status of medical clearance for SSRs requiring it (e.g. approved, pending, rejected) for compliance monitoring."
    - name: "requires_medical_clearance"
      expr: requires_medical_clearance
      comment: "Indicates whether the SSR requires a medical clearance before fulfilment."
    - name: "is_interline"
      expr: is_interline
      comment: "Indicates whether the SSR applies to an interline segment, affecting partner airline coordination and fulfilment responsibility."
    - name: "ssr_request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month in which the SSR was requested, used for demand trend analysis and operational planning."
  measures:
    - name: "total_ssr_requests"
      expr: COUNT(1)
      comment: "Total number of SSR records. Baseline operational volume metric for ground handling, catering, and crew briefing resource planning."
    - name: "confirmed_ssr_count"
      expr: COUNT(CASE WHEN ssr_status = 'CONFIRMED' THEN ssr_record_id END)
      comment: "Number of SSRs in confirmed status. Confirmed SSRs represent committed service obligations that must be resourced and delivered."
    - name: "cancelled_ssr_count"
      expr: COUNT(CASE WHEN ssr_status = 'CANCELLED' THEN ssr_record_id END)
      comment: "Number of cancelled SSRs. High cancellation rates may indicate booking friction or service quality issues in the SSR fulfilment process."
    - name: "total_ssr_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total revenue generated from chargeable SSRs. A direct ancillary revenue KPI tracked by commercial and revenue management teams."
    - name: "avg_ssr_charge_amount"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge amount per chargeable SSR. Used to benchmark ancillary pricing effectiveness and identify upsell opportunities."
    - name: "medical_clearance_pending_count"
      expr: COUNT(CASE WHEN requires_medical_clearance = TRUE AND medical_clearance_status = 'PENDING' THEN ssr_record_id END)
      comment: "Number of SSRs awaiting medical clearance. Unresolved medical clearances are an operational risk — passengers cannot board without clearance, creating potential flight delay exposure."
    - name: "distinct_passengers_with_ssr"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct passengers with at least one SSR. Measures the breadth of special service demand across the passenger base for capacity planning."
    - name: "interline_ssr_count"
      expr: COUNT(CASE WHEN is_interline = TRUE THEN ssr_record_id END)
      comment: "Number of SSRs applicable to interline segments. Interline SSRs require partner airline coordination and are a key metric for alliance and codeshare service quality management."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`passenger_travel_identity_document`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Travel identity document validity, verification, and APIS transmission metrics. Used by compliance, check-in operations, and border control liaison teams to monitor document expiry risk, verification coverage, and secure flight programme compliance."
  source: "`airlines_ecm`.`passenger`.`travel_identity_document`"
  dimensions:
    - name: "document_type"
      expr: document_type
      comment: "Type of travel document (e.g. passport, national ID, visa) for document mix and regulatory compliance analysis."
    - name: "issuing_country_code"
      expr: issuing_country_code
      comment: "Country that issued the travel document, used for nationality-based regulatory and visa requirement analysis."
    - name: "nationality_code"
      expr: nationality_code
      comment: "Nationality recorded on the travel document, used for border control and regulatory reporting."
    - name: "verification_status"
      expr: verification_status
      comment: "Current document verification status (e.g. verified, pending, failed) for check-in compliance monitoring."
    - name: "secure_flight_status"
      expr: secure_flight_status
      comment: "Status of the document within the TSA Secure Flight programme (e.g. cleared, selectee, inhibited) for US-bound flight compliance."
    - name: "apis_transmitted_flag"
      expr: apis_transmitted_flag
      comment: "Indicates whether the document data has been transmitted via APIS, used to measure APIS coverage and identify gaps."
    - name: "is_primary_document"
      expr: is_primary_document
      comment: "Indicates whether this is the passenger's primary travel document, used to focus compliance checks on the authoritative document."
    - name: "visa_required_flag"
      expr: visa_required_flag
      comment: "Indicates whether a visa is required for the passenger's destination, used for check-in compliance and TIMATIC validation."
    - name: "document_source"
      expr: document_source
      comment: "Source system or channel through which the document was captured (e.g. self-service kiosk, agent, mobile app) for data quality attribution."
    - name: "expiry_year_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month in which the travel document expires, used for proactive expiry risk monitoring and passenger communication."
  measures:
    - name: "total_travel_documents"
      expr: COUNT(1)
      comment: "Total number of travel identity documents on file. Baseline metric for document coverage assessment across the passenger base."
    - name: "verified_document_count"
      expr: COUNT(CASE WHEN verification_status = 'VERIFIED' THEN travel_identity_document_id END)
      comment: "Number of travel documents with verified status. Verified documents reduce check-in friction and border control risk — a key operational quality KPI."
    - name: "expiring_document_count_90_days"
      expr: COUNT(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND expiry_date >= CURRENT_DATE() THEN travel_identity_document_id END)
      comment: "Number of travel documents expiring within 90 days. Passengers with expiring documents may be denied boarding — proactive outreach reduces no-show and denied boarding costs."
    - name: "apis_transmitted_document_count"
      expr: COUNT(CASE WHEN apis_transmitted_flag = TRUE THEN travel_identity_document_id END)
      comment: "Number of documents for which APIS data has been successfully transmitted. Measures APIS data coverage and regulatory submission completeness."
    - name: "visa_required_passenger_count"
      expr: COUNT(CASE WHEN visa_required_flag = TRUE THEN travel_identity_document_id END)
      comment: "Number of document records flagged as requiring a visa. Drives TIMATIC compliance checks and check-in agent workload planning for visa-sensitive routes."
    - name: "distinct_passengers_with_documents"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct passengers with at least one travel document on file. Measures document capture coverage across the passenger base — gaps indicate check-in compliance risk."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`passenger_traveller_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Passenger traveller segmentation and commercial value metrics. Used by commercial strategy, revenue management, and CRM teams to monitor segment distribution, churn risk, ancillary propensity, and lifetime value tier composition across the passenger base."
  source: "`airlines_ecm`.`passenger`.`traveller_segment`"
  dimensions:
    - name: "segment_name"
      expr: segment_name
      comment: "Business name of the traveller segment (e.g. High-Value Leisure, Corporate Frequent Flyer) for commercial strategy reporting."
    - name: "segment_category"
      expr: segment_category
      comment: "High-level category of the segment (e.g. leisure, corporate, VFR, crew) for portfolio-level analysis."
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment assignment (e.g. active, expired, under review) for data currency monitoring."
    - name: "lifetime_value_tier"
      expr: lifetime_value_tier
      comment: "Lifetime value tier of the passenger (e.g. platinum, gold, silver, bronze) for revenue prioritisation and service differentiation."
    - name: "loyalty_engagement_level"
      expr: loyalty_engagement_level
      comment: "Level of loyalty programme engagement (e.g. highly engaged, at risk, dormant) for retention programme targeting."
    - name: "travel_frequency_band"
      expr: travel_frequency_band
      comment: "Frequency band of travel (e.g. weekly, monthly, occasional) for demand forecasting and loyalty tier management."
    - name: "price_sensitivity_indicator"
      expr: price_sensitivity_indicator
      comment: "Indicator of price sensitivity (e.g. price-driven, value-driven, premium) for fare and ancillary pricing strategy."
    - name: "booking_channel_preference"
      expr: booking_channel_preference
      comment: "Preferred booking channel (e.g. direct web, OTA, GDS, mobile) for channel strategy and distribution cost management."
    - name: "corporate_affiliation_flag"
      expr: corporate_affiliation_flag
      comment: "Indicates whether the passenger has a corporate travel affiliation, used for B2B revenue tracking and corporate account management."
    - name: "targeting_eligible_flag"
      expr: targeting_eligible_flag
      comment: "Indicates whether the passenger is eligible for targeted marketing campaigns based on consent and segment criteria."
    - name: "segment_assignment_month"
      expr: DATE_TRUNC('MONTH', assignment_date)
      comment: "Month in which the segment was assigned, used for cohort analysis and model refresh tracking."
  measures:
    - name: "total_active_segment_assignments"
      expr: COUNT(CASE WHEN segment_status = 'ACTIVE' THEN traveller_segment_id END)
      comment: "Total number of active traveller segment assignments. Measures the coverage and currency of the segmentation model across the passenger base."
    - name: "distinct_segmented_passengers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct passengers with an active segment assignment. Measures segmentation model coverage — unsegmented passengers cannot be targeted for revenue optimisation."
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score across segmented passengers. Rising average churn risk is an early warning indicator requiring retention programme intervention to protect revenue."
    - name: "avg_ancillary_propensity_score"
      expr: AVG(CAST(ancillary_propensity_score AS DOUBLE))
      comment: "Average ancillary purchase propensity score. Drives ancillary revenue targeting strategy — higher scores indicate greater upsell opportunity per passenger."
    - name: "avg_revenue_contribution_score"
      expr: AVG(CAST(revenue_contribution_score AS DOUBLE))
      comment: "Average revenue contribution score across the passenger base. A composite commercial value indicator used by revenue management to prioritise service investment."
    - name: "high_churn_risk_passenger_count"
      expr: COUNT(CASE WHEN churn_risk_score >= 0.7 THEN traveller_segment_id END)
      comment: "Number of passengers with a churn risk score of 0.7 or above. High-risk passengers represent immediate retention programme targets — tracking this count drives proactive loyalty intervention."
    - name: "targeting_eligible_passenger_count"
      expr: COUNT(CASE WHEN targeting_eligible_flag = TRUE AND segment_status = 'ACTIVE' THEN traveller_segment_id END)
      comment: "Number of active segment assignments where the passenger is eligible for targeted marketing. Defines the actionable audience size for commercial campaigns."
    - name: "corporate_affiliated_passenger_count"
      expr: COUNT(CASE WHEN corporate_affiliation_flag = TRUE THEN traveller_segment_id END)
      comment: "Number of passengers with a corporate travel affiliation. Tracks the size of the B2B revenue base and informs corporate account management resource allocation."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`passenger_watchlist_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Passenger watchlist screening and security compliance metrics. Used by security, compliance, and operations teams to monitor screening volumes, match rates, resolution timeliness, and regulatory submission coverage across all departure stations."
  source: "`airlines_ecm`.`passenger`.`watchlist_check`"
  dimensions:
    - name: "check_status"
      expr: check_status
      comment: "Current status of the watchlist check (e.g. clear, match, pending, escalated) for security operations monitoring."
    - name: "match_status"
      expr: match_status
      comment: "Outcome of the watchlist match evaluation (e.g. confirmed match, false positive, cleared) for security resolution tracking."
    - name: "screening_program"
      expr: screening_program
      comment: "Security screening programme under which the check was performed (e.g. TSA Secure Flight, EU PNR, UK Prevent) for programme-level compliance reporting."
    - name: "screening_jurisdiction"
      expr: screening_jurisdiction
      comment: "Regulatory jurisdiction governing the screening check, used for multi-jurisdiction compliance reporting."
    - name: "screening_system"
      expr: screening_system
      comment: "System used to perform the watchlist check (e.g. SITA Passenger Screening, Amadeus) for system performance and audit trail."
    - name: "watchlist_name"
      expr: watchlist_name
      comment: "Name of the watchlist against which the passenger was checked (e.g. OFAC SDN, Interpol, national no-fly list) for list-level match analysis."
    - name: "resolution_action"
      expr: resolution_action
      comment: "Action taken to resolve a watchlist match (e.g. cleared, denied boarding, escalated to authority) for security outcome tracking."
    - name: "selectee_indicator"
      expr: selectee_indicator
      comment: "Indicates whether the passenger has been designated as a selectee for enhanced security screening."
    - name: "boarding_pass_issued"
      expr: boarding_pass_issued
      comment: "Indicates whether a boarding pass was issued following the watchlist check, used to measure check-to-board conversion and identify blocked passengers."
    - name: "check_date"
      expr: DATE_TRUNC('DAY', check_timestamp)
      comment: "Date on which the watchlist check was performed, used for daily security volume and compliance trend analysis."
  measures:
    - name: "total_watchlist_checks"
      expr: COUNT(1)
      comment: "Total number of watchlist checks performed. Baseline security screening volume metric used to verify that all passengers are being screened as required by regulation."
    - name: "match_identified_count"
      expr: COUNT(CASE WHEN match_status IN ('CONFIRMED_MATCH', 'POTENTIAL_MATCH') THEN watchlist_check_id END)
      comment: "Number of watchlist checks resulting in a confirmed or potential match. A critical security KPI — each match requires immediate escalation and resolution action."
    - name: "boarding_pass_denied_count"
      expr: COUNT(CASE WHEN boarding_pass_issued = FALSE THEN watchlist_check_id END)
      comment: "Number of passengers denied a boarding pass following a watchlist check. Tracks the operational impact of security screening on passenger flow and regulatory compliance outcomes."
    - name: "selectee_count"
      expr: COUNT(CASE WHEN selectee_indicator = TRUE THEN watchlist_check_id END)
      comment: "Number of passengers designated as selectees for enhanced screening. Drives enhanced screening resource allocation at security checkpoints."
    - name: "avg_match_score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average watchlist match score across all checks. Used to calibrate screening algorithm thresholds — high average scores may indicate over-matching causing operational disruption."
    - name: "unresolved_match_count"
      expr: COUNT(CASE WHEN match_status IN ('CONFIRMED_MATCH', 'POTENTIAL_MATCH') AND resolution_action IS NULL THEN watchlist_check_id END)
      comment: "Number of watchlist matches without a recorded resolution action. Unresolved matches represent open security risks and regulatory non-compliance — requires immediate operational escalation."
    - name: "distinct_passengers_screened"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct passengers who have undergone a watchlist check. Measures screening coverage against the total boarded passenger population for compliance gap analysis."
$$;
