-- Metric views for domain: content | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-30 06:47:57

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_title`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core content title performance metrics including availability, runtime, and rights status tracking for strategic content portfolio management."
  source: "`vibe_media_broadcasting_v1`.`content`.`title`"
  dimensions:
    - name: "content_type"
      expr: content_type
      comment: "Type of content (movie, episode, special, etc.) for portfolio segmentation"
    - name: "content_status"
      expr: content_status
      comment: "Current lifecycle status of the title (active, archived, in production, etc.)"
    - name: "rights_status"
      expr: rights_status
      comment: "Rights clearance and availability status for distribution planning"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where content was produced for geographic portfolio analysis"
    - name: "original_language"
      expr: original_language
      comment: "Original language of the content for localization strategy"
    - name: "production_year"
      expr: production_year
      comment: "Year content was produced for catalog freshness analysis"
    - name: "release_year"
      expr: YEAR(release_date)
      comment: "Year content was released for launch performance tracking"
    - name: "release_quarter"
      expr: CONCAT(CAST(YEAR(release_date) AS STRING), '-Q', CAST(QUARTER(release_date) AS STRING))
      comment: "Release quarter for seasonal performance analysis"
    - name: "hd_available"
      expr: hd_available_flag
      comment: "HD availability flag for quality tier analysis"
    - name: "uhd_4k_available"
      expr: uhd_4k_available_flag
      comment: "4K UHD availability flag for premium content tracking"
    - name: "closed_caption_available"
      expr: closed_caption_available_flag
      comment: "Closed caption availability for accessibility compliance"
    - name: "audio_description_available"
      expr: audio_description_available_flag
      comment: "Audio description availability for accessibility compliance"
    - name: "theatrical_release"
      expr: theatrical_release_flag
      comment: "Whether content had theatrical release for windowing strategy"
    - name: "premiere_flag"
      expr: premiere_flag
      comment: "Whether content is a premiere for marketing prioritization"
  measures:
    - name: "total_titles"
      expr: COUNT(DISTINCT title_id)
      comment: "Total unique titles in the content catalog for portfolio size tracking"
    - name: "total_runtime_hours"
      expr: SUM(CAST(runtime_seconds AS DOUBLE)) / 3600.0
      comment: "Total content runtime in hours for inventory volume measurement"
    - name: "avg_runtime_minutes"
      expr: AVG(CAST(runtime_seconds AS DOUBLE)) / 60.0
      comment: "Average title runtime in minutes for content format analysis"
    - name: "hd_availability_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN hd_available_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of titles available in HD for quality portfolio assessment"
    - name: "uhd_4k_availability_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN uhd_4k_available_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of titles available in 4K UHD for premium content strategy"
    - name: "accessibility_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN closed_caption_available_flag = TRUE AND audio_description_available_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of titles with full accessibility features for regulatory compliance tracking"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_acquisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content acquisition financial and rights metrics for investment ROI analysis and licensing portfolio management."
  source: "`vibe_media_broadcasting_v1`.`content`.`acquisition`"
  dimensions:
    - name: "acquisition_type"
      expr: acquisition_type
      comment: "Type of acquisition (license, purchase, co-production, etc.) for sourcing strategy"
    - name: "acquisition_status"
      expr: acquisition_status
      comment: "Current status of the acquisition deal for pipeline tracking"
    - name: "clearance_status"
      expr: clearance_status
      comment: "Rights clearance status for legal compliance monitoring"
    - name: "cost_currency"
      expr: cost_currency
      comment: "Currency of acquisition cost for multi-currency portfolio analysis"
    - name: "territory_scope"
      expr: territory_scope
      comment: "Geographic territory covered by the acquisition for regional strategy"
    - name: "content_window_type"
      expr: content_window_type
      comment: "Type of distribution window (theatrical, SVOD, AVOD, etc.) for windowing strategy"
    - name: "exclusivity"
      expr: exclusivity_flag
      comment: "Whether acquisition includes exclusive rights for competitive positioning"
    - name: "sublicensing_allowed"
      expr: sublicensing_allowed_flag
      comment: "Whether sublicensing is permitted for revenue opportunity assessment"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year of acquisition for investment trend analysis"
    - name: "acquisition_quarter"
      expr: CONCAT(CAST(YEAR(acquisition_date) AS STRING), '-Q', CAST(QUARTER(acquisition_date) AS STRING))
      comment: "Quarter of acquisition for seasonal investment pattern tracking"
    - name: "license_year"
      expr: YEAR(license_start_date)
      comment: "Year license period begins for rights availability planning"
  measures:
    - name: "total_acquisitions"
      expr: COUNT(DISTINCT acquisition_id)
      comment: "Total number of content acquisitions for deal volume tracking"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total acquisition investment for budget and ROI analysis"
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per acquisition for pricing benchmark analysis"
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee commitments for financial liability tracking"
    - name: "avg_royalty_rate_pct"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate across acquisitions for cost structure analysis"
    - name: "exclusivity_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN exclusivity_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of acquisitions with exclusive rights for competitive advantage measurement"
    - name: "sublicensing_opportunity_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sublicensing_allowed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of acquisitions allowing sublicensing for revenue diversification potential"
    - name: "clearance_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN clearance_status = 'Cleared' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of acquisitions with completed rights clearance for operational readiness"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_series`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Series-level content performance and portfolio metrics for franchise management and long-form content strategy."
  source: "`vibe_media_broadcasting_v1`.`content`.`series`"
  dimensions:
    - name: "series_type"
      expr: series_type
      comment: "Type of series (scripted, reality, news, sports, etc.) for genre strategy"
    - name: "series_status"
      expr: series_status
      comment: "Current status (active, ended, hiatus, cancelled) for portfolio lifecycle management"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where series was produced for geographic content strategy"
    - name: "original_language"
      expr: language_original
      comment: "Original language of the series for localization planning"
    - name: "syndication_eligible"
      expr: syndication_eligible
      comment: "Whether series is eligible for syndication for revenue opportunity assessment"
    - name: "audio_description_available"
      expr: audio_description_available
      comment: "Audio description availability for accessibility compliance"
    - name: "closed_caption_available"
      expr: closed_caption_available
      comment: "Closed caption availability for accessibility compliance"
    - name: "premiere_year"
      expr: YEAR(premiere_date)
      comment: "Year series premiered for launch cohort analysis"
    - name: "franchise_name"
      expr: franchise_name
      comment: "Franchise the series belongs to for IP portfolio management"
  measures:
    - name: "total_series"
      expr: COUNT(DISTINCT series_id)
      comment: "Total number of series in the catalog for portfolio breadth tracking"
    - name: "total_episodes"
      expr: SUM(CAST(total_episode_count AS DOUBLE))
      comment: "Total episode count across all series for content volume measurement"
    - name: "total_seasons"
      expr: SUM(CAST(total_season_count AS DOUBLE))
      comment: "Total season count across all series for long-form content depth"
    - name: "avg_episodes_per_series"
      expr: AVG(CAST(total_episode_count AS DOUBLE))
      comment: "Average episodes per series for content format analysis"
    - name: "avg_seasons_per_series"
      expr: AVG(CAST(total_season_count AS DOUBLE))
      comment: "Average seasons per series for franchise longevity assessment"
    - name: "avg_episode_runtime_minutes"
      expr: AVG(CAST(episode_runtime_minutes AS DOUBLE))
      comment: "Average episode runtime for programming and scheduling strategy"
    - name: "syndication_eligible_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN syndication_eligible = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of series eligible for syndication for revenue diversification potential"
    - name: "active_series_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN series_status = 'Active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of series currently active for portfolio vitality measurement"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_episode`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Episode-level content metrics for episodic programming performance and VOD availability tracking."
  source: "`vibe_media_broadcasting_v1`.`content`.`content_episode`"
  dimensions:
    - name: "episode_type"
      expr: episode_type
      comment: "Type of episode (regular, premiere, finale, special) for programming strategy"
    - name: "episode_status"
      expr: episode_status
      comment: "Current status of the episode for availability tracking"
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the episode for localization analysis"
    - name: "rights_clearance_status"
      expr: rights_clearance_status
      comment: "Rights clearance status for legal compliance and distribution readiness"
    - name: "premiere_flag"
      expr: premiere_flag
      comment: "Whether episode is a premiere for marketing prioritization"
    - name: "rerun_flag"
      expr: rerun_flag
      comment: "Whether episode is a rerun for programming mix analysis"
    - name: "breaking_news_flag"
      expr: breaking_news_flag
      comment: "Whether episode contains breaking news for news programming tracking"
    - name: "closed_caption_available"
      expr: closed_caption_available
      comment: "Closed caption availability for accessibility compliance"
    - name: "audio_description_available"
      expr: audio_description_available
      comment: "Audio description availability for accessibility compliance"
    - name: "subtitles_available"
      expr: subtitles_available
      comment: "Subtitle availability for international distribution readiness"
    - name: "music_cue_sheet_submitted"
      expr: music_cue_sheet_submitted
      comment: "Whether music cue sheet has been submitted for royalty compliance"
    - name: "original_air_year"
      expr: YEAR(original_air_date)
      comment: "Year episode originally aired for catalog freshness analysis"
    - name: "vod_availability_year"
      expr: YEAR(vod_available_from_date)
      comment: "Year episode became available on VOD for windowing strategy"
  measures:
    - name: "total_episodes"
      expr: COUNT(DISTINCT content_episode_id)
      comment: "Total number of episodes for content volume tracking"
    - name: "total_runtime_hours"
      expr: SUM(CAST(runtime_seconds AS DOUBLE)) / 3600.0
      comment: "Total episode runtime in hours for programming inventory measurement"
    - name: "avg_runtime_minutes"
      expr: AVG(CAST(runtime_seconds AS DOUBLE)) / 60.0
      comment: "Average episode runtime in minutes for scheduling and format analysis"
    - name: "total_broadcast_count"
      expr: SUM(CAST(broadcast_count AS DOUBLE))
      comment: "Total number of broadcasts across all episodes for utilization tracking"
    - name: "avg_broadcast_count_per_episode"
      expr: AVG(CAST(broadcast_count AS DOUBLE))
      comment: "Average broadcasts per episode for content reuse efficiency"
    - name: "premiere_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN premiere_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of episodes that are premieres for fresh content mix measurement"
    - name: "rerun_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN rerun_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of episodes that are reruns for programming efficiency analysis"
    - name: "accessibility_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN closed_caption_available = TRUE AND audio_description_available = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of episodes with full accessibility features for regulatory compliance"
    - name: "rights_cleared_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN rights_clearance_status = 'Cleared' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of episodes with cleared rights for distribution readiness"
    - name: "music_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN music_cue_sheet_submitted = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of episodes with submitted music cue sheets for royalty compliance"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content package performance and commercial value metrics for bundling strategy and partner distribution deals."
  source: "`vibe_media_broadcasting_v1`.`content`.`package`"
  dimensions:
    - name: "package_type"
      expr: package_type
      comment: "Type of content package (bundle, collection, channel, etc.) for product strategy"
    - name: "package_status"
      expr: package_status
      comment: "Current status of the package for lifecycle management"
    - name: "commercial_context"
      expr: commercial_context
      comment: "Commercial context (SVOD, AVOD, TVOD, linear, etc.) for monetization strategy"
    - name: "territory_scope"
      expr: territory_scope
      comment: "Geographic territory for the package for regional distribution strategy"
    - name: "language_primary"
      expr: language_primary
      comment: "Primary language of the package for localization planning"
    - name: "exclusivity"
      expr: exclusivity_flag
      comment: "Whether package has exclusive content for competitive positioning"
    - name: "drm_required"
      expr: drm_required_flag
      comment: "Whether DRM is required for security and compliance planning"
    - name: "hd_available"
      expr: hd_available_flag
      comment: "HD availability for quality tier analysis"
    - name: "uhd_4k_available"
      expr: uhd_4k_available_flag
      comment: "4K UHD availability for premium package positioning"
    - name: "closed_caption_available"
      expr: closed_caption_available_flag
      comment: "Closed caption availability for accessibility compliance"
    - name: "audio_description_available"
      expr: audio_description_available_flag
      comment: "Audio description availability for accessibility compliance"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year package became effective for launch cohort analysis"
  measures:
    - name: "total_packages"
      expr: COUNT(DISTINCT package_id)
      comment: "Total number of content packages for product portfolio breadth"
    - name: "total_package_value_usd"
      expr: SUM(CAST(value_usd AS DOUBLE))
      comment: "Total commercial value of packages in USD for revenue potential assessment"
    - name: "avg_package_value_usd"
      expr: AVG(CAST(value_usd AS DOUBLE))
      comment: "Average package value in USD for pricing strategy analysis"
    - name: "total_runtime_hours"
      expr: SUM(CAST(total_runtime_hours AS DOUBLE))
      comment: "Total runtime hours across all packages for content volume measurement"
    - name: "avg_runtime_hours_per_package"
      expr: AVG(CAST(total_runtime_hours AS DOUBLE))
      comment: "Average runtime hours per package for bundle size analysis"
    - name: "total_title_count"
      expr: SUM(CAST(total_title_count AS DOUBLE))
      comment: "Total titles across all packages for content breadth measurement"
    - name: "avg_titles_per_package"
      expr: AVG(CAST(total_title_count AS DOUBLE))
      comment: "Average titles per package for bundling strategy analysis"
    - name: "exclusivity_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN exclusivity_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of packages with exclusive content for competitive advantage measurement"
    - name: "premium_quality_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN uhd_4k_available_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of packages available in 4K UHD for premium positioning"
    - name: "accessibility_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN closed_caption_available_flag = TRUE AND audio_description_available_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of packages with full accessibility features for regulatory compliance"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content version quality control and technical compliance metrics for operational excellence and distribution readiness."
  source: "`vibe_media_broadcasting_v1`.`content`.`version`"
  dimensions:
    - name: "version_type"
      expr: version_type
      comment: "Type of version (master, proxy, distribution, localized, etc.) for asset management"
    - name: "version_status"
      expr: version_status
      comment: "Current status of the version for workflow tracking"
    - name: "qc_status"
      expr: qc_status
      comment: "Quality control status for operational readiness assessment"
    - name: "editorial_workflow_state"
      expr: editorial_workflow_state
      comment: "Editorial workflow state for production pipeline tracking"
    - name: "file_format"
      expr: file_format
      comment: "File format of the version for technical compatibility analysis"
    - name: "video_codec"
      expr: video_codec
      comment: "Video codec used for encoding efficiency and compatibility"
    - name: "audio_codec"
      expr: audio_codec
      comment: "Audio codec used for quality and compatibility analysis"
    - name: "resolution"
      expr: resolution
      comment: "Video resolution for quality tier segmentation"
    - name: "hdr_format"
      expr: hdr_format
      comment: "HDR format for premium quality tracking"
    - name: "aspect_ratio"
      expr: aspect_ratio
      comment: "Aspect ratio for format compatibility analysis"
    - name: "color_space"
      expr: color_space
      comment: "Color space standard for technical compliance"
    - name: "primary_language"
      expr: primary_language_code
      comment: "Primary language of the version for localization tracking"
    - name: "target_territory"
      expr: target_territory
      comment: "Target territory for the version for regional distribution planning"
    - name: "broadcast_safe"
      expr: broadcast_safe
      comment: "Whether version is broadcast safe for linear distribution readiness"
    - name: "audio_description_available"
      expr: audio_description_available
      comment: "Audio description availability for accessibility compliance"
    - name: "closed_caption_available"
      expr: closed_caption_available
      comment: "Closed caption availability for accessibility compliance"
    - name: "qc_completed_year"
      expr: YEAR(qc_completed_date)
      comment: "Year QC was completed for throughput analysis"
  measures:
    - name: "total_versions"
      expr: COUNT(DISTINCT version_id)
      comment: "Total number of content versions for asset inventory tracking"
    - name: "total_storage_size_tb"
      expr: SUM(CAST(file_size_bytes AS DOUBLE)) / 1099511627776.0
      comment: "Total storage size in terabytes for infrastructure capacity planning"
    - name: "avg_file_size_gb"
      expr: AVG(CAST(file_size_bytes AS DOUBLE)) / 1073741824.0
      comment: "Average file size in gigabytes for storage efficiency analysis"
    - name: "avg_frame_rate"
      expr: AVG(CAST(frame_rate AS DOUBLE))
      comment: "Average frame rate across versions for technical standard tracking"
    - name: "total_runtime_hours"
      expr: SUM(CAST(runtime_seconds AS DOUBLE)) / 3600.0
      comment: "Total runtime hours across all versions for content volume measurement"
    - name: "avg_runtime_minutes"
      expr: AVG(CAST(runtime_seconds AS DOUBLE)) / 60.0
      comment: "Average runtime in minutes for format analysis"
    - name: "qc_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN qc_status = 'Passed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of versions passing QC for quality assurance performance"
    - name: "broadcast_safe_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN broadcast_safe = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of versions that are broadcast safe for linear distribution readiness"
    - name: "accessibility_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN closed_caption_available = TRUE AND audio_description_available = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of versions with full accessibility features for regulatory compliance"
    - name: "hdr_availability_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN hdr_format IS NOT NULL AND hdr_format != '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of versions with HDR format for premium quality portfolio assessment"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_lifecycle_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content lifecycle workflow efficiency and SLA compliance metrics for operational performance management."
  source: "`vibe_media_broadcasting_v1`.`content`.`lifecycle_event`"
  dimensions:
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Stage in content lifecycle (ingest, QC, approval, distribution, archive) for workflow analysis"
    - name: "new_status"
      expr: new_status
      comment: "New status after transition for state tracking"
    - name: "previous_status"
      expr: previous_status
      comment: "Previous status before transition for workflow pattern analysis"
    - name: "qc_status"
      expr: qc_status
      comment: "Quality control status for quality gate tracking"
    - name: "delivery_platform"
      expr: delivery_platform
      comment: "Target delivery platform for distribution channel analysis"
    - name: "responsible_team"
      expr: responsible_team
      comment: "Team responsible for the lifecycle event for accountability tracking"
    - name: "system_source"
      expr: system_source
      comment: "System that triggered the event for integration monitoring"
    - name: "automated_flag"
      expr: automated_flag
      comment: "Whether event was automated for process efficiency analysis"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether SLA was breached for compliance tracking"
    - name: "blocking_resolved_flag"
      expr: blocking_resolved_flag
      comment: "Whether blocking condition was resolved for bottleneck analysis"
    - name: "compliance_checkpoint_passed"
      expr: compliance_checkpoint_passed
      comment: "Whether compliance checkpoint was passed for regulatory tracking"
    - name: "rollback_flag"
      expr: rollback_flag
      comment: "Whether event was rolled back for error rate analysis"
    - name: "transition_year"
      expr: YEAR(transition_timestamp)
      comment: "Year of lifecycle transition for trend analysis"
    - name: "transition_month"
      expr: DATE_TRUNC('MONTH', transition_timestamp)
      comment: "Month of lifecycle transition for operational performance tracking"
  measures:
    - name: "total_lifecycle_events"
      expr: COUNT(DISTINCT lifecycle_event_id)
      comment: "Total number of lifecycle events for workflow activity volume"
    - name: "avg_transition_duration_hours"
      expr: AVG(CAST(transition_duration_hours AS DOUBLE))
      comment: "Average transition duration in hours for workflow efficiency measurement"
    - name: "total_transition_duration_hours"
      expr: SUM(CAST(transition_duration_hours AS DOUBLE))
      comment: "Total transition duration hours for capacity planning"
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = FALSE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events meeting SLA for operational performance tracking"
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events breaching SLA for risk and escalation management"
    - name: "automation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN automated_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of automated lifecycle events for process efficiency measurement"
    - name: "compliance_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_checkpoint_passed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events passing compliance checkpoints for regulatory adherence"
    - name: "rollback_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN rollback_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events requiring rollback for error rate and quality tracking"
    - name: "blocking_resolution_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN blocking_resolved_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of blocking conditions resolved for bottleneck management"
$$;