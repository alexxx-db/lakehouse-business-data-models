-- Metric views for domain: content | Business: Media_Broadcasting | Version: 3 | Generated on: 2026-07-10 21:10:12

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_acquisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content acquisition deal performance and cost metrics, tracking licensing costs, rights windows, and deal economics."
  source: "`vibe_media_broadcasting_v1`.`content`.`acquisition`"
  dimensions:
    - name: "acquisition_type"
      expr: acquisition_type
      comment: "Type of content acquisition (e.g., license, purchase, co-production)"
    - name: "acquisition_status"
      expr: acquisition_status
      comment: "Current status of the acquisition deal"
    - name: "content_window_type"
      expr: content_window_type
      comment: "Distribution window type (e.g., theatrical, SVOD, AVOD, linear)"
    - name: "cost_currency"
      expr: cost_currency
      comment: "Currency denomination for acquisition costs"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the acquisition includes exclusive rights"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year the content was acquired"
    - name: "acquisition_quarter"
      expr: CONCAT('Q', QUARTER(acquisition_date), '-', YEAR(acquisition_date))
      comment: "Quarter and year of acquisition"
    - name: "license_duration_days"
      expr: DATEDIFF(license_end_date, license_start_date)
      comment: "Total duration of the license period in days"
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total acquisition cost across all deals - primary spend metric for content investment decisions"
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee commitments - key cash flow and risk metric for content financing"
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per acquisition deal - benchmarking metric for deal economics"
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate across deals - key metric for ongoing content cost structure"
    - name: "acquisition_deal_count"
      expr: COUNT(DISTINCT acquisition_id)
      comment: "Number of unique acquisition deals - volume metric for content sourcing activity"
    - name: "exclusive_deal_count"
      expr: COUNT(DISTINCT CASE WHEN exclusivity_flag = TRUE THEN acquisition_id END)
      comment: "Number of exclusive acquisition deals - strategic metric for competitive positioning"
    - name: "exclusive_deal_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN exclusivity_flag = TRUE THEN acquisition_id END) / NULLIF(COUNT(DISTINCT acquisition_id), 0), 2)
      comment: "Percentage of deals that are exclusive - key strategic metric for content differentiation and competitive moat"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_episode`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Episode-level content performance and availability metrics, tracking broadcast activity, VOD windows, and content readiness."
  source: "`vibe_media_broadcasting_v1`.`content`.`content_episode`"
  dimensions:
    - name: "episode_status"
      expr: episode_status
      comment: "Current production/distribution status of the episode"
    - name: "episode_type"
      expr: episode_type
      comment: "Type of episode (e.g., regular, special, pilot, finale)"
    - name: "premiere_flag"
      expr: premiere_flag
      comment: "Whether this is a premiere episode"
    - name: "rerun_flag"
      expr: rerun_flag
      comment: "Whether this is a rerun broadcast"
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the episode content"
    - name: "closed_caption_available"
      expr: closed_caption_available
      comment: "Whether closed captions are available for accessibility"
    - name: "audio_description_available"
      expr: audio_description_available
      comment: "Whether audio description is available for accessibility"
    - name: "original_air_year"
      expr: YEAR(original_air_date)
      comment: "Year of original broadcast"
    - name: "vod_availability_status"
      expr: CASE WHEN vod_available_from_date IS NOT NULL AND vod_available_until_date IS NOT NULL THEN 'Windowed' WHEN vod_available_from_date IS NOT NULL THEN 'Available' ELSE 'Not Available' END
      comment: "Current VOD availability status based on window dates"
  measures:
    - name: "total_episode_count"
      expr: COUNT(DISTINCT content_episode_id)
      comment: "Total number of unique episodes - primary inventory metric for content library size"
    - name: "premiere_episode_count"
      expr: COUNT(DISTINCT CASE WHEN premiere_flag = TRUE THEN content_episode_id END)
      comment: "Number of premiere episodes - key metric for new content production velocity"
    - name: "accessible_episode_count"
      expr: COUNT(DISTINCT CASE WHEN closed_caption_available = TRUE AND audio_description_available = TRUE THEN content_episode_id END)
      comment: "Number of fully accessible episodes - compliance and inclusivity metric for regulatory requirements"
    - name: "accessibility_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN closed_caption_available = TRUE AND audio_description_available = TRUE THEN content_episode_id END) / NULLIF(COUNT(DISTINCT content_episode_id), 0), 2)
      comment: "Percentage of episodes with full accessibility features - critical compliance metric for FCC and international regulatory requirements"
    - name: "avg_runtime_minutes"
      expr: AVG(CAST(runtime_seconds AS DOUBLE) / 60.0)
      comment: "Average episode runtime in minutes - scheduling and programming metric for linear broadcast planning"
    - name: "vod_enabled_episode_count"
      expr: COUNT(DISTINCT CASE WHEN vod_available_from_date IS NOT NULL THEN content_episode_id END)
      comment: "Number of episodes available for VOD - key metric for digital distribution strategy and revenue opportunity"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_series`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Series-level content portfolio metrics, tracking franchise performance, production status, and syndication eligibility."
  source: "`vibe_media_broadcasting_v1`.`content`.`series`"
  dimensions:
    - name: "series_status"
      expr: series_status
      comment: "Current production status of the series (e.g., active, ended, hiatus)"
    - name: "series_type"
      expr: series_type
      comment: "Type of series (e.g., scripted, reality, documentary, news)"
    - name: "syndication_eligible"
      expr: syndication_eligible
      comment: "Whether the series meets criteria for syndication"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the series was originally produced"
    - name: "language_original"
      expr: language_original
      comment: "Original language of the series"
    - name: "target_demographic"
      expr: target_demographic
      comment: "Primary target audience demographic"
    - name: "premiere_year"
      expr: YEAR(premiere_date)
      comment: "Year the series premiered"
    - name: "series_age_years"
      expr: CAST(DATEDIFF(CURRENT_DATE(), premiere_date) / 365.25 AS INT)
      comment: "Age of the series in years since premiere"
  measures:
    - name: "total_series_count"
      expr: COUNT(DISTINCT series_id)
      comment: "Total number of unique series - primary portfolio size metric for content library breadth"
    - name: "active_series_count"
      expr: COUNT(DISTINCT CASE WHEN series_status = 'Active' THEN series_id END)
      comment: "Number of series currently in active production - key metric for production pipeline health"
    - name: "syndication_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN syndication_eligible = TRUE THEN series_id END)
      comment: "Number of series eligible for syndication - critical revenue opportunity metric for secondary market monetization"
    - name: "syndication_eligibility_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN syndication_eligible = TRUE THEN series_id END) / NULLIF(COUNT(DISTINCT series_id), 0), 2)
      comment: "Percentage of series portfolio eligible for syndication - strategic metric for long-tail revenue potential and library value"
    - name: "avg_episode_runtime_minutes"
      expr: AVG(CAST(episode_runtime_minutes AS DOUBLE))
      comment: "Average episode runtime across series - programming and scheduling metric for linear broadcast planning"
    - name: "avg_total_episode_count"
      expr: AVG(CAST(total_episode_count AS DOUBLE))
      comment: "Average number of episodes per series - portfolio depth metric for content volume and production scale"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_windowing_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content windowing strategy and revenue model metrics, tracking distribution windows, pricing, and exclusivity across platforms."
  source: "`vibe_media_broadcasting_v1`.`content`.`windowing_plan`"
  dimensions:
    - name: "window_type"
      expr: window_type
      comment: "Type of distribution window (e.g., theatrical, PVOD, SVOD, AVOD, linear)"
    - name: "window_status"
      expr: window_status
      comment: "Current status of the windowing plan"
    - name: "revenue_model"
      expr: revenue_model
      comment: "Revenue model for this window (e.g., subscription, transactional, ad-supported)"
    - name: "exclusivity_tier"
      expr: exclusivity_tier
      comment: "Level of exclusivity for this distribution window"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for pricing and guarantees"
    - name: "download_to_go_enabled"
      expr: download_to_go_enabled
      comment: "Whether offline download is enabled for this window"
    - name: "promotional_pricing_flag"
      expr: promotional_pricing_flag
      comment: "Whether promotional pricing is active"
    - name: "planned_open_year"
      expr: YEAR(planned_open_date)
      comment: "Year the window is planned to open"
    - name: "window_duration_days"
      expr: DATEDIFF(planned_close_date, planned_open_date)
      comment: "Duration of the distribution window in days"
  measures:
    - name: "total_windowing_plans"
      expr: COUNT(DISTINCT windowing_plan_id)
      comment: "Total number of windowing plans - complexity metric for distribution strategy"
    - name: "total_minimum_guarantee_revenue"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee revenue across all windows - critical cash flow and revenue floor metric for financial planning"
    - name: "avg_minimum_guarantee"
      expr: AVG(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Average minimum guarantee per window - benchmarking metric for deal economics"
    - name: "avg_price_point"
      expr: AVG(CAST(price_point AS DOUBLE))
      comment: "Average price point across transactional windows - pricing strategy metric for consumer-facing monetization"
    - name: "download_enabled_window_count"
      expr: COUNT(DISTINCT CASE WHEN download_to_go_enabled = TRUE THEN windowing_plan_id END)
      comment: "Number of windows with offline download enabled - consumer experience and competitive positioning metric"
    - name: "promotional_window_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN promotional_pricing_flag = TRUE THEN windowing_plan_id END) / NULLIF(COUNT(DISTINCT windowing_plan_id), 0), 2)
      comment: "Percentage of windows with promotional pricing - marketing intensity and discount strategy metric for subscriber acquisition"
    - name: "avg_window_duration_days"
      expr: AVG(DATEDIFF(planned_close_date, planned_open_date))
      comment: "Average duration of distribution windows in days - windowing strategy metric for content availability and scarcity management"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content version quality control and technical readiness metrics, tracking QC status, format compliance, and broadcast safety."
  source: "`vibe_media_broadcasting_v1`.`content`.`version`"
  dimensions:
    - name: "version_status"
      expr: version_status
      comment: "Current status of the content version"
    - name: "version_type"
      expr: version_type
      comment: "Type of version (e.g., theatrical, broadcast, streaming, international)"
    - name: "qc_status"
      expr: qc_status
      comment: "Quality control status"
    - name: "broadcast_safe"
      expr: broadcast_safe
      comment: "Whether the version is approved for broadcast"
    - name: "resolution"
      expr: resolution
      comment: "Video resolution (e.g., SD, HD, 4K)"
    - name: "hdr_format"
      expr: hdr_format
      comment: "HDR format (e.g., HDR10, Dolby Vision)"
    - name: "audio_description_available"
      expr: audio_description_available
      comment: "Whether audio description track is available"
    - name: "closed_caption_available"
      expr: closed_caption_available
      comment: "Whether closed captions are available"
    - name: "qc_completion_year"
      expr: YEAR(qc_completed_date)
      comment: "Year QC was completed"
  measures:
    - name: "total_version_count"
      expr: COUNT(DISTINCT version_id)
      comment: "Total number of content versions - inventory metric for technical asset management"
    - name: "broadcast_safe_version_count"
      expr: COUNT(DISTINCT CASE WHEN broadcast_safe = TRUE THEN version_id END)
      comment: "Number of broadcast-safe versions - operational readiness metric for linear distribution"
    - name: "broadcast_safety_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN broadcast_safe = TRUE THEN version_id END) / NULLIF(COUNT(DISTINCT version_id), 0), 2)
      comment: "Percentage of versions that are broadcast-safe - critical operational metric for linear channel readiness and compliance"
    - name: "qc_passed_version_count"
      expr: COUNT(DISTINCT CASE WHEN qc_status = 'Passed' THEN version_id END)
      comment: "Number of versions that passed QC - quality assurance metric for content readiness"
    - name: "qc_pass_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN qc_status = 'Passed' THEN version_id END) / NULLIF(COUNT(DISTINCT version_id), 0), 2)
      comment: "Percentage of versions passing QC - quality control efficiency metric for production and post-production process health"
    - name: "avg_file_size_gb"
      expr: AVG(CAST(file_size_bytes AS DOUBLE) / 1073741824.0)
      comment: "Average file size in gigabytes - storage and bandwidth planning metric for infrastructure capacity"
    - name: "avg_frame_rate"
      expr: AVG(CAST(frame_rate AS DOUBLE))
      comment: "Average frame rate across versions - technical quality metric for video production standards"
    - name: "accessible_version_count"
      expr: COUNT(DISTINCT CASE WHEN audio_description_available = TRUE AND closed_caption_available = TRUE THEN version_id END)
      comment: "Number of fully accessible versions - compliance metric for accessibility regulations and inclusive distribution"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_talent_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent participation and credit metrics, tracking union eligibility, residuals obligations, and credit approval workflow."
  source: "`vibe_media_broadcasting_v1`.`content`.`talent_credit`"
  dimensions:
    - name: "credit_type"
      expr: credit_type
      comment: "Type of credit (e.g., cast, director, producer, writer)"
    - name: "credit_category"
      expr: credit_category
      comment: "Category of credit (e.g., above-the-line, below-the-line)"
    - name: "credit_approval_status"
      expr: credit_approval_status
      comment: "Approval status of the credit"
    - name: "residuals_eligibility_flag"
      expr: residuals_eligibility_flag
      comment: "Whether the talent is eligible for residuals payments"
    - name: "union_affiliation_flag"
      expr: union_affiliation_flag
      comment: "Whether the talent has union affiliation"
    - name: "pseudonym_flag"
      expr: pseudonym_flag
      comment: "Whether the credit uses a pseudonym"
    - name: "credit_approval_year"
      expr: YEAR(credit_approval_date)
      comment: "Year the credit was approved"
  measures:
    - name: "total_talent_credits"
      expr: COUNT(DISTINCT talent_credit_id)
      comment: "Total number of talent credits - volume metric for production scale and talent engagement"
    - name: "residuals_eligible_credit_count"
      expr: COUNT(DISTINCT CASE WHEN residuals_eligibility_flag = TRUE THEN talent_credit_id END)
      comment: "Number of credits eligible for residuals - financial liability metric for ongoing talent payment obligations"
    - name: "residuals_eligibility_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN residuals_eligibility_flag = TRUE THEN talent_credit_id END) / NULLIF(COUNT(DISTINCT talent_credit_id), 0), 2)
      comment: "Percentage of credits eligible for residuals - critical financial metric for long-term cost structure and union compliance"
    - name: "union_affiliated_credit_count"
      expr: COUNT(DISTINCT CASE WHEN union_affiliation_flag = TRUE THEN talent_credit_id END)
      comment: "Number of union-affiliated credits - compliance metric for labor relations and collective bargaining obligations"
    - name: "union_affiliation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN union_affiliation_flag = TRUE THEN talent_credit_id END) / NULLIF(COUNT(DISTINCT talent_credit_id), 0), 2)
      comment: "Percentage of credits with union affiliation - labor relations metric for union compliance and production cost structure"
    - name: "approved_credit_count"
      expr: COUNT(DISTINCT CASE WHEN credit_approval_status = 'Approved' THEN talent_credit_id END)
      comment: "Number of approved credits - workflow efficiency metric for credit approval process"
    - name: "unique_talent_count"
      expr: COUNT(DISTINCT talent_profile_id)
      comment: "Number of unique talent profiles credited - talent pool diversity metric for production resource breadth"
$$;