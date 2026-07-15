-- Metric views for domain: content | Business: Sports Entertainment | Version: 1 | Generated on: 2026-05-09 01:35:39

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`content_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core content asset metrics tracking file size, duration, and asset lifecycle for digital media management and storage optimization"
  source: "`sports_entertainment_ecm`.`content`.`asset`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Type of content asset (video, audio, image, document)"
    - name: "content_rating"
      expr: content_rating
      comment: "Content rating classification for audience appropriateness"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the asset (draft, published, archived, expired)"
    - name: "sport_discipline"
      expr: sport_discipline
      comment: "Sport or discipline featured in the content"
    - name: "language_code"
      expr: language_code
      comment: "Primary language of the content asset"
    - name: "is_live_clip"
      expr: is_live_clip
      comment: "Flag indicating whether asset is from live event coverage"
    - name: "is_ugc"
      expr: is_ugc
      comment: "Flag indicating user-generated content"
    - name: "drm_status"
      expr: drm_status
      comment: "Digital rights management protection status"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month when asset was created"
    - name: "published_month"
      expr: DATE_TRUNC('MONTH', published_timestamp)
      comment: "Month when asset was published"
  measures:
    - name: "total_assets"
      expr: COUNT(1)
      comment: "Total number of content assets"
    - name: "total_storage_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total storage consumed by assets in bytes"
    - name: "avg_file_size_mb"
      expr: AVG(CAST(file_size_bytes AS DOUBLE)) / 1048576.0
      comment: "Average file size in megabytes per asset"
    - name: "total_duration_hours"
      expr: SUM(CAST(frame_rate AS DOUBLE))
      comment: "Total content duration in hours across all assets"
    - name: "avg_frame_rate"
      expr: AVG(CAST(frame_rate AS DOUBLE))
      comment: "Average frame rate across video assets"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`content_asset_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content usage and rights tracking metrics for royalty calculation, rights compliance, and content monetization analysis"
  source: "`sports_entertainment_ecm`.`content`.`asset_usage`"
  dimensions:
    - name: "usage_type"
      expr: usage_type
      comment: "Type of content usage (broadcast, streaming, social, syndication)"
    - name: "usage_status"
      expr: usage_status
      comment: "Current status of the usage record"
    - name: "territory_code"
      expr: territory_code
      comment: "Geographic territory where content was used"
    - name: "license_type"
      expr: license_type
      comment: "Type of license governing the usage"
    - name: "rights_clearance_status"
      expr: rights_clearance_status
      comment: "Status of rights clearance for this usage"
    - name: "is_rights_expired"
      expr: is_rights_expired
      comment: "Flag indicating whether usage rights have expired"
    - name: "royalty_applicable"
      expr: royalty_applicable
      comment: "Flag indicating whether royalty payments apply"
    - name: "is_ugc"
      expr: is_ugc
      comment: "Flag indicating user-generated content usage"
    - name: "usage_month"
      expr: DATE_TRUNC('MONTH', usage_date)
      comment: "Month when content was used"
    - name: "rights_clearance_month"
      expr: DATE_TRUNC('MONTH', rights_clearance_date)
      comment: "Month when rights were cleared"
  measures:
    - name: "total_usages"
      expr: COUNT(1)
      comment: "Total number of content usage instances"
    - name: "total_royalty_amount"
      expr: SUM(CAST(royalty_amount AS DOUBLE))
      comment: "Total royalty payments owed or paid for content usage"
    - name: "avg_royalty_amount"
      expr: AVG(CAST(royalty_amount AS DOUBLE))
      comment: "Average royalty amount per usage instance"
    - name: "avg_royalty_rate_pct"
      expr: AVG(CAST(royalty_rate AS DOUBLE))
      comment: "Average royalty rate percentage across usages"
    - name: "distinct_assets_used"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique assets used"
    - name: "distinct_territories"
      expr: COUNT(DISTINCT territory_code)
      comment: "Number of unique territories where content was used"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`content_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content approval workflow metrics tracking review cycle time, approval rates, and compliance gate performance for editorial governance"
  source: "`sports_entertainment_ecm`.`content`.`approval`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current status of the approval request"
    - name: "decision"
      expr: decision
      comment: "Final approval decision (approved, rejected, revision requested)"
    - name: "review_type"
      expr: review_type
      comment: "Type of review being conducted"
    - name: "stage"
      expr: stage
      comment: "Current workflow stage of the approval"
    - name: "content_type"
      expr: content_type
      comment: "Type of content being approved"
    - name: "content_sensitivity_level"
      expr: content_sensitivity_level
      comment: "Sensitivity classification of the content"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Flag indicating whether approval SLA was breached"
    - name: "brand_safety_verified"
      expr: brand_safety_verified
      comment: "Flag indicating brand safety verification completion"
    - name: "publish_gate_cleared"
      expr: publish_gate_cleared
      comment: "Flag indicating all publish gates have been cleared"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month when approval was submitted"
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_timestamp)
      comment: "Month when approval decision was made"
  measures:
    - name: "total_approvals"
      expr: COUNT(1)
      comment: "Total number of approval requests"
    - name: "distinct_content_assets"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique content assets under review"
    - name: "distinct_reviewers"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of unique employees performing reviews"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`content_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content licensing revenue and rights management metrics tracking license fees, revenue share, and territory coverage for rights monetization"
  source: "`sports_entertainment_ecm`.`content`.`content_license`"
  dimensions:
    - name: "license_status"
      expr: license_status
      comment: "Current status of the content license"
    - name: "deal_type"
      expr: deal_type
      comment: "Type of licensing deal (flat fee, revenue share, hybrid)"
    - name: "license_scope"
      expr: license_scope
      comment: "Scope of rights granted under the license"
    - name: "usage_type"
      expr: usage_type
      comment: "Type of usage permitted under the license"
    - name: "rights_territory"
      expr: rights_territory
      comment: "Geographic territory covered by the license"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Flag indicating exclusive licensing rights"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Flag indicating automatic renewal terms"
    - name: "sublicense_permitted"
      expr: sublicense_permitted
      comment: "Flag indicating whether sublicensing is allowed"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for license fees and payments"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month when license becomes effective"
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month when license expires"
  measures:
    - name: "total_licenses"
      expr: COUNT(1)
      comment: "Total number of content licenses"
    - name: "total_license_fee_revenue"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total license fee revenue across all licenses"
    - name: "avg_license_fee"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average license fee per agreement"
    - name: "total_flat_fee_revenue"
      expr: SUM(CAST(flat_fee_amount AS DOUBLE))
      comment: "Total flat fee revenue from licenses"
    - name: "avg_revenue_share_pct"
      expr: AVG(CAST(revenue_share_pct AS DOUBLE))
      comment: "Average revenue share percentage across licenses"
    - name: "avg_royalty_rate_pct"
      expr: AVG(CAST(royalty_rate AS DOUBLE))
      comment: "Average royalty rate percentage"
    - name: "avg_cpm_rate"
      expr: AVG(CAST(cpm_rate AS DOUBLE))
      comment: "Average cost per thousand impressions rate"
    - name: "distinct_licensees"
      expr: COUNT(DISTINCT licensee_corporate_entity_id)
      comment: "Number of unique licensee entities"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`content_syndication_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content syndication deal performance metrics tracking syndication fees, revenue share, and partner distribution for content monetization strategy"
  source: "`sports_entertainment_ecm`.`content`.`syndication_deal`"
  dimensions:
    - name: "deal_status"
      expr: deal_status
      comment: "Current status of the syndication deal"
    - name: "deal_type"
      expr: deal_type
      comment: "Type of syndication deal structure"
    - name: "partner_type"
      expr: partner_type
      comment: "Type of syndication partner"
    - name: "content_asset_type"
      expr: content_asset_type
      comment: "Type of content being syndicated"
    - name: "sport_discipline"
      expr: sport_discipline
      comment: "Sport discipline covered by syndication deal"
    - name: "delivery_format"
      expr: delivery_format
      comment: "Format for content delivery to syndication partner"
    - name: "territory_exclusivity_flag"
      expr: territory_exclusivity_flag
      comment: "Flag indicating exclusive territory rights"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Flag indicating automatic renewal terms"
    - name: "sublicensing_permitted"
      expr: sublicensing_permitted
      comment: "Flag indicating whether partner can sublicense"
    - name: "fee_currency_code"
      expr: fee_currency_code
      comment: "Currency for syndication fees"
    - name: "contract_start_month"
      expr: DATE_TRUNC('MONTH', contract_start_date)
      comment: "Month when syndication contract starts"
    - name: "signed_month"
      expr: DATE_TRUNC('MONTH', signed_date)
      comment: "Month when deal was signed"
  measures:
    - name: "total_syndication_deals"
      expr: COUNT(1)
      comment: "Total number of syndication deals"
    - name: "total_syndication_fee_revenue"
      expr: SUM(CAST(syndication_fee_amount AS DOUBLE))
      comment: "Total syndication fee revenue across all deals"
    - name: "avg_syndication_fee"
      expr: AVG(CAST(syndication_fee_amount AS DOUBLE))
      comment: "Average syndication fee per deal"
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee amounts across deals"
    - name: "avg_revenue_share_pct"
      expr: AVG(CAST(revenue_share_percent AS DOUBLE))
      comment: "Average revenue share percentage across syndication deals"
    - name: "distinct_syndication_partners"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique syndication partners"
    - name: "distinct_territories"
      expr: COUNT(DISTINCT territory_id)
      comment: "Number of unique territories covered by syndication deals"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`content_rights_clearance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rights clearance and compliance metrics tracking clearance status, license fees, and territory coverage for legal risk management"
  source: "`sports_entertainment_ecm`.`content`.`rights_clearance`"
  dimensions:
    - name: "clearance_status"
      expr: clearance_status
      comment: "Current status of rights clearance"
    - name: "clearance_type"
      expr: clearance_type
      comment: "Type of rights clearance required"
    - name: "conflict_resolution_status"
      expr: conflict_resolution_status
      comment: "Status of any rights conflict resolution"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Flag indicating exclusive rights"
    - name: "geo_blocking_enabled"
      expr: geo_blocking_enabled
      comment: "Flag indicating geographic blocking requirements"
    - name: "sublicensing_permitted"
      expr: sublicensing_permitted
      comment: "Flag indicating whether sublicensing is allowed"
    - name: "watermarking_required"
      expr: watermarking_required
      comment: "Flag indicating watermarking requirement"
    - name: "offline_download_permitted"
      expr: offline_download_permitted
      comment: "Flag indicating offline download permission"
    - name: "rights_conflict_flag"
      expr: rights_conflict_flag
      comment: "Flag indicating detected rights conflicts"
    - name: "ugc_source_flag"
      expr: ugc_source_flag
      comment: "Flag indicating user-generated content source"
    - name: "license_fee_currency_code"
      expr: license_fee_currency_code
      comment: "Currency for license fees"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_from_date)
      comment: "Month when rights clearance becomes effective"
  measures:
    - name: "total_rights_clearances"
      expr: COUNT(1)
      comment: "Total number of rights clearance records"
    - name: "total_license_fee_amount"
      expr: SUM(CAST(license_fee_amount AS DOUBLE))
      comment: "Total license fees for rights clearances"
    - name: "avg_license_fee"
      expr: AVG(CAST(license_fee_amount AS DOUBLE))
      comment: "Average license fee per clearance"
    - name: "avg_royalty_rate_pct"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate percentage across clearances"
    - name: "distinct_content_assets"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique content assets with rights clearance"
    - name: "distinct_territories"
      expr: COUNT(DISTINCT territory_id)
      comment: "Number of unique territories with rights clearance"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`content_rights_conflict`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rights conflict detection and resolution metrics tracking conflict severity, financial exposure, and resolution time for legal risk mitigation"
  source: "`sports_entertainment_ecm`.`content`.`rights_conflict`"
  dimensions:
    - name: "conflict_status"
      expr: conflict_status
      comment: "Current status of the rights conflict"
    - name: "conflict_type"
      expr: conflict_type
      comment: "Type of rights conflict detected"
    - name: "conflict_severity"
      expr: conflict_severity
      comment: "Severity level of the conflict"
    - name: "conflict_source"
      expr: conflict_source
      comment: "Source system or process that detected the conflict"
    - name: "resolution_action"
      expr: resolution_action
      comment: "Action taken to resolve the conflict"
    - name: "is_content_blocked"
      expr: is_content_blocked
      comment: "Flag indicating whether content was blocked due to conflict"
    - name: "is_pre_publication"
      expr: is_pre_publication
      comment: "Flag indicating conflict detected before publication"
    - name: "is_repeat_conflict"
      expr: is_repeat_conflict
      comment: "Flag indicating recurring conflict"
    - name: "gdpr_relevant"
      expr: gdpr_relevant
      comment: "Flag indicating GDPR relevance"
    - name: "ccpa_relevant"
      expr: ccpa_relevant
      comment: "Flag indicating CCPA relevance"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for financial exposure"
    - name: "detected_month"
      expr: DATE_TRUNC('MONTH', detected_timestamp)
      comment: "Month when conflict was detected"
    - name: "resolution_month"
      expr: DATE_TRUNC('MONTH', resolution_timestamp)
      comment: "Month when conflict was resolved"
  measures:
    - name: "total_rights_conflicts"
      expr: COUNT(1)
      comment: "Total number of rights conflicts detected"
    - name: "total_financial_exposure"
      expr: SUM(CAST(financial_exposure_amount AS DOUBLE))
      comment: "Total financial exposure from rights conflicts"
    - name: "avg_financial_exposure"
      expr: AVG(CAST(financial_exposure_amount AS DOUBLE))
      comment: "Average financial exposure per conflict"
    - name: "distinct_assets_in_conflict"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique assets involved in rights conflicts"
    - name: "distinct_licenses_in_conflict"
      expr: COUNT(DISTINCT content_license_id)
      comment: "Number of unique licenses involved in conflicts"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`content_publish_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content publishing and distribution metrics tracking publish success rates, distribution status, and channel performance for content operations"
  source: "`sports_entertainment_ecm`.`content`.`publish_event`"
  dimensions:
    - name: "distribution_status"
      expr: distribution_status
      comment: "Status of content distribution"
    - name: "content_type"
      expr: content_type
      comment: "Type of content being published"
    - name: "content_rating"
      expr: content_rating
      comment: "Content rating classification"
    - name: "moderation_status"
      expr: moderation_status
      comment: "Content moderation status"
    - name: "drm_scheme"
      expr: drm_scheme
      comment: "Digital rights management scheme applied"
    - name: "encoding_profile"
      expr: encoding_profile
      comment: "Encoding profile used for distribution"
    - name: "is_live_content"
      expr: is_live_content
      comment: "Flag indicating live content"
    - name: "is_ppv"
      expr: is_ppv
      comment: "Flag indicating pay-per-view content"
    - name: "geo_restriction_applied"
      expr: geo_restriction_applied
      comment: "Flag indicating geographic restrictions applied"
    - name: "ugc_source_flag"
      expr: ugc_source_flag
      comment: "Flag indicating user-generated content source"
    - name: "publish_month"
      expr: DATE_TRUNC('MONTH', publish_timestamp)
      comment: "Month when content was published"
    - name: "scheduled_publish_month"
      expr: DATE_TRUNC('MONTH', scheduled_publish_timestamp)
      comment: "Month when content was scheduled for publish"
  measures:
    - name: "total_publish_events"
      expr: COUNT(1)
      comment: "Total number of content publish events"
    - name: "total_asset_file_size_mb"
      expr: SUM(CAST(asset_file_size_mb AS DOUBLE))
      comment: "Total file size of published assets in megabytes"
    - name: "avg_asset_file_size_mb"
      expr: AVG(CAST(asset_file_size_mb AS DOUBLE))
      comment: "Average file size per published asset in megabytes"
    - name: "distinct_assets_published"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique assets published"
    - name: "distinct_channels"
      expr: COUNT(DISTINCT platform_channel_id)
      comment: "Number of unique distribution channels used"
    - name: "distinct_publishers"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of unique employees publishing content"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`content_ugc_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "User-generated content submission and moderation metrics tracking submission volume, moderation decisions, and content quality for community engagement"
  source: "`sports_entertainment_ecm`.`content`.`ugc_submission`"
  dimensions:
    - name: "moderation_status"
      expr: moderation_status
      comment: "Current moderation status of UGC submission"
    - name: "content_type"
      expr: content_type
      comment: "Type of user-generated content"
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which content was submitted"
    - name: "device_type"
      expr: device_type
      comment: "Device type used for submission"
    - name: "geo_country_code"
      expr: geo_country_code
      comment: "Country code of submission origin"
    - name: "rights_consent_flag"
      expr: rights_consent_flag
      comment: "Flag indicating user granted usage rights"
    - name: "is_featured"
      expr: is_featured
      comment: "Flag indicating featured content"
    - name: "broadcast_eligible_flag"
      expr: broadcast_eligible_flag
      comment: "Flag indicating eligibility for broadcast"
    - name: "ott_distribution_flag"
      expr: ott_distribution_flag
      comment: "Flag indicating OTT distribution eligibility"
    - name: "gdpr_erasure_requested_flag"
      expr: gdpr_erasure_requested_flag
      comment: "Flag indicating GDPR erasure request"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month when content was submitted"
    - name: "moderation_decision_month"
      expr: DATE_TRUNC('MONTH', moderation_decision_timestamp)
      comment: "Month when moderation decision was made"
  measures:
    - name: "total_ugc_submissions"
      expr: COUNT(1)
      comment: "Total number of user-generated content submissions"
    - name: "total_file_size_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total file size of UGC submissions in bytes"
    - name: "avg_file_size_mb"
      expr: AVG(CAST(file_size_bytes AS DOUBLE)) / 1048576.0
      comment: "Average file size per submission in megabytes"
    - name: "avg_content_quality_score"
      expr: AVG(CAST(content_quality_score AS DOUBLE))
      comment: "Average content quality score across submissions"
    - name: "distinct_submitters"
      expr: COUNT(DISTINCT fan_account_id)
      comment: "Number of unique fan accounts submitting content"
    - name: "distinct_creators"
      expr: COUNT(DISTINCT creator_profile_id)
      comment: "Number of unique creator profiles submitting content"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`content_creator_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Creator partnership and performance metrics tracking follower growth, engagement rates, and partnership revenue for influencer management"
  source: "`sports_entertainment_ecm`.`content`.`creator_profile`"
  dimensions:
    - name: "creator_type"
      expr: creator_type
      comment: "Type of content creator (athlete, influencer, journalist, fan)"
    - name: "partnership_status"
      expr: partnership_status
      comment: "Current status of creator partnership"
    - name: "partnership_tier"
      expr: partnership_tier
      comment: "Partnership tier level"
    - name: "primary_platform"
      expr: primary_platform
      comment: "Primary social media platform for creator"
    - name: "content_niche"
      expr: content_niche
      comment: "Content niche or specialization"
    - name: "brand_safety_rating"
      expr: brand_safety_rating
      comment: "Brand safety rating for creator content"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Flag indicating exclusive partnership"
    - name: "nil_eligible_flag"
      expr: nil_eligible_flag
      comment: "Flag indicating NIL (Name, Image, Likeness) eligibility"
    - name: "ugc_consent_flag"
      expr: ugc_consent_flag
      comment: "Flag indicating UGC usage consent granted"
    - name: "country_code"
      expr: country_code
      comment: "Country code of creator location"
    - name: "onboarding_month"
      expr: DATE_TRUNC('MONTH', onboarding_date)
      comment: "Month when creator was onboarded"
  measures:
    - name: "total_creators"
      expr: COUNT(1)
      comment: "Total number of content creators"
    - name: "total_follower_count"
      expr: SUM(CAST(follower_count AS DOUBLE))
      comment: "Total follower count across all creators"
    - name: "avg_follower_count"
      expr: AVG(CAST(follower_count AS DOUBLE))
      comment: "Average follower count per creator"
    - name: "avg_engagement_rate_pct"
      expr: AVG(CAST(engagement_rate_pct AS DOUBLE))
      comment: "Average engagement rate percentage across creators"
    - name: "total_avg_views"
      expr: SUM(CAST(average_views_per_post AS DOUBLE))
      comment: "Total average views per post across all creators"
    - name: "avg_views_per_post"
      expr: AVG(CAST(average_views_per_post AS DOUBLE))
      comment: "Average views per post across creators"
    - name: "total_flat_fee_amount"
      expr: SUM(CAST(flat_fee_amount AS DOUBLE))
      comment: "Total flat fee payments to creators"
    - name: "avg_revenue_share_pct"
      expr: AVG(CAST(revenue_share_pct AS DOUBLE))
      comment: "Average revenue share percentage with creators"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`content_ingest_job`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content ingest pipeline performance metrics tracking ingest volume, processing time, and quality control for media operations efficiency"
  source: "`sports_entertainment_ecm`.`content`.`ingest_job`"
  dimensions:
    - name: "job_status"
      expr: job_status
      comment: "Current status of the ingest job"
    - name: "content_type"
      expr: content_type
      comment: "Type of content being ingested"
    - name: "source_type"
      expr: source_type
      comment: "Source type of ingested content"
    - name: "ingest_channel"
      expr: ingest_channel
      comment: "Channel through which content was ingested"
    - name: "qc_status"
      expr: qc_status
      comment: "Quality control status"
    - name: "moderation_status"
      expr: moderation_status
      comment: "Content moderation status"
    - name: "drm_clearance_status"
      expr: drm_clearance_status
      comment: "DRM clearance status"
    - name: "cdn_distribution_status"
      expr: cdn_distribution_status
      comment: "CDN distribution status"
    - name: "is_ugc"
      expr: is_ugc
      comment: "Flag indicating user-generated content"
    - name: "broadcast_rights_flag"
      expr: broadcast_rights_flag
      comment: "Flag indicating broadcast rights cleared"
    - name: "ott_rights_flag"
      expr: ott_rights_flag
      comment: "Flag indicating OTT rights cleared"
    - name: "ingest_month"
      expr: DATE_TRUNC('MONTH', ingest_timestamp)
      comment: "Month when content was ingested"
    - name: "completed_month"
      expr: DATE_TRUNC('MONTH', completed_timestamp)
      comment: "Month when ingest job completed"
  measures:
    - name: "total_ingest_jobs"
      expr: COUNT(1)
      comment: "Total number of content ingest jobs"
    - name: "total_file_size_mb"
      expr: SUM(CAST(total_file_size_mb AS DOUBLE))
      comment: "Total file size ingested in megabytes"
    - name: "avg_file_size_mb"
      expr: AVG(CAST(total_file_size_mb AS DOUBLE))
      comment: "Average file size per ingest job in megabytes"
    - name: "total_duration_hours"
      expr: SUM(CAST(duration_seconds AS DOUBLE)) / 3600.0
      comment: "Total content duration ingested in hours"
    - name: "avg_ingest_duration_seconds"
      expr: AVG(CAST(ingest_duration_seconds AS DOUBLE))
      comment: "Average ingest processing time in seconds"
    - name: "avg_qc_score"
      expr: AVG(CAST(qc_score AS DOUBLE))
      comment: "Average quality control score across ingest jobs"
    - name: "avg_frame_rate"
      expr: AVG(CAST(frame_rate AS DOUBLE))
      comment: "Average frame rate of ingested video content"
    - name: "distinct_source_systems"
      expr: COUNT(DISTINCT source_system_code)
      comment: "Number of unique source systems feeding content"
$$;
