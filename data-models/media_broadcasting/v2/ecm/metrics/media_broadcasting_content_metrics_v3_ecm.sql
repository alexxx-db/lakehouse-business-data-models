-- Metric views for domain: content | Business: Media_Broadcasting | Version: 3 | Generated on: 2026-07-10 19:06:42

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_acquisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks content acquisition performance including cost, royalty obligations, and rights coverage. Used by content strategy and finance teams to evaluate acquisition spend efficiency and rights portfolio health."
  source: "`vibe_media_broadcasting_v1`.`content`.`acquisition`"
  dimensions:
    - name: "acquisition_status"
      expr: acquisition_status
      comment: "Current status of the acquisition (e.g., active, expired, pending) for pipeline and portfolio segmentation."
    - name: "acquisition_type"
      expr: acquisition_type
      comment: "Type of acquisition (e.g., license, buyout, co-production) for cost structure analysis."
    - name: "delivery_format"
      expr: delivery_format
      comment: "Format in which content was delivered, used to assess technical readiness and format mix."
    - name: "territory_scope"
      expr: territory_scope
      comment: "Geographic scope of the acquisition rights, used for territory-level rights analysis."
    - name: "content_window_type"
      expr: content_window_type
      comment: "Type of content window (e.g., SVOD, linear, theatrical) for windowing strategy analysis."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the acquisition is exclusive, used to assess competitive positioning of the content portfolio."
    - name: "clearance_status"
      expr: clearance_status
      comment: "Rights clearance status of the acquisition, used to identify content ready for distribution."
    - name: "acquisition_date_month"
      expr: DATE_TRUNC('MONTH', acquisition_date)
      comment: "Month of acquisition for trend analysis of content investment over time."
    - name: "license_end_date_year"
      expr: YEAR(license_end_date)
      comment: "Year the license expires, used to forecast rights renewal obligations."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total spend on content acquisitions. Core financial KPI for content investment tracking and budget management."
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per acquisition deal. Used to benchmark deal economics and negotiate future agreements."
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee obligations across all acquisitions. Critical for cash flow forecasting and liability management."
    - name: "avg_royalty_rate_percent"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate across acquisitions. Used to assess cost structure of the rights portfolio and negotiate competitive rates."
    - name: "total_acquisitions"
      expr: COUNT(1)
      comment: "Total number of acquisition records. Baseline volume metric for portfolio size and acquisition activity."
    - name: "exclusive_acquisition_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END)
      comment: "Number of exclusive acquisitions. Measures competitive differentiation of the content portfolio."
    - name: "cleared_acquisition_count"
      expr: COUNT(CASE WHEN clearance_status = 'cleared' THEN 1 END)
      comment: "Number of acquisitions with cleared rights status. Indicates content ready for distribution and monetization."
    - name: "sublicensing_eligible_count"
      expr: COUNT(CASE WHEN sublicensing_allowed_flag = TRUE THEN 1 END)
      comment: "Number of acquisitions where sublicensing is permitted. Identifies revenue expansion opportunities through sub-distribution."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_episode`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures episode-level content production and broadcast readiness. Used by programming, operations, and content strategy teams to track episode pipeline health, accessibility compliance, and broadcast readiness."
  source: "`vibe_media_broadcasting_v1`.`content`.`content_episode`"
  dimensions:
    - name: "episode_status"
      expr: episode_status
      comment: "Current lifecycle status of the episode (e.g., in production, delivered, archived) for pipeline tracking."
    - name: "episode_type"
      expr: episode_type
      comment: "Type of episode (e.g., regular, special, pilot) for content mix analysis."
    - name: "rights_clearance_status"
      expr: rights_clearance_status
      comment: "Rights clearance status of the episode, used to identify episodes ready for broadcast."
    - name: "premiere_flag"
      expr: premiere_flag
      comment: "Whether the episode is a premiere, used to segment high-priority content events."
    - name: "rerun_flag"
      expr: rerun_flag
      comment: "Whether the episode is a rerun, used to assess original vs. repeat content mix."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the episode for localization and market coverage analysis."
    - name: "original_air_date_month"
      expr: DATE_TRUNC('MONTH', original_air_date)
      comment: "Month of original air date for episode volume trend analysis."
    - name: "audio_description_available"
      expr: audio_description_available
      comment: "Whether audio description is available, used to track accessibility compliance."
    - name: "closed_caption_available"
      expr: closed_caption_available
      comment: "Whether closed captioning is available, used to track accessibility and regulatory compliance."
  measures:
    - name: "total_episodes"
      expr: COUNT(1)
      comment: "Total number of episodes in the catalog. Baseline measure for content volume and pipeline size."
    - name: "broadcast_ready_episode_count"
      expr: COUNT(CASE WHEN rights_clearance_status = 'cleared' THEN 1 END)
      comment: "Number of episodes with cleared rights ready for broadcast. Directly measures distribution-ready inventory."
    - name: "accessibility_compliant_episode_count"
      expr: COUNT(CASE WHEN audio_description_available = TRUE AND closed_caption_available = TRUE THEN 1 END)
      comment: "Episodes meeting both audio description and closed caption accessibility requirements. Tracks regulatory compliance posture."
    - name: "premiere_episode_count"
      expr: COUNT(CASE WHEN premiere_flag = TRUE THEN 1 END)
      comment: "Number of premiere episodes. Measures high-value original content events that drive audience acquisition."
    - name: "music_cue_sheet_submitted_count"
      expr: COUNT(CASE WHEN music_cue_sheet_submitted = TRUE THEN 1 END)
      comment: "Episodes with music cue sheets submitted. Tracks royalty compliance readiness for broadcast."
    - name: "vod_available_episode_count"
      expr: COUNT(CASE WHEN vod_available_from_date IS NOT NULL THEN 1 END)
      comment: "Number of episodes available on VOD. Measures digital distribution footprint and streaming inventory depth."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks content version quality, technical readiness, and distribution preparation. Used by technical operations and content delivery teams to manage version pipeline health and QC pass rates."
  source: "`vibe_media_broadcasting_v1`.`content`.`version`"
  dimensions:
    - name: "version_status"
      expr: version_status
      comment: "Current status of the content version (e.g., approved, in QC, archived) for pipeline management."
    - name: "version_type"
      expr: version_type
      comment: "Type of version (e.g., master, proxy, localized) for version mix analysis."
    - name: "qc_status"
      expr: qc_status
      comment: "Quality control status of the version. Used to track QC throughput and failure rates."
    - name: "target_platform"
      expr: target_platform
      comment: "Target distribution platform for the version, used for platform-specific readiness analysis."
    - name: "target_territory"
      expr: target_territory
      comment: "Target territory for the version, used for geographic distribution readiness."
    - name: "file_format"
      expr: file_format
      comment: "File format of the version (e.g., MXF, MP4) for technical inventory analysis."
    - name: "audio_description_available"
      expr: audio_description_available
      comment: "Whether audio description is available in this version, for accessibility compliance tracking."
    - name: "broadcast_safe"
      expr: broadcast_safe
      comment: "Whether the version is certified broadcast safe, critical for linear playout readiness."
    - name: "qc_completed_date_month"
      expr: DATE_TRUNC('MONTH', qc_completed_date)
      comment: "Month QC was completed, used to track QC throughput trends over time."
  measures:
    - name: "total_versions"
      expr: COUNT(1)
      comment: "Total number of content versions. Baseline measure for version catalog size and production throughput."
    - name: "qc_passed_version_count"
      expr: COUNT(CASE WHEN qc_status = 'passed' THEN 1 END)
      comment: "Number of versions that passed QC. Measures quality throughput and readiness for distribution."
    - name: "broadcast_safe_version_count"
      expr: COUNT(CASE WHEN broadcast_safe = TRUE THEN 1 END)
      comment: "Number of broadcast-safe versions. Directly measures linear distribution-ready inventory."
    - name: "total_file_size_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total storage footprint of all content versions in bytes. Used for infrastructure capacity planning and storage cost management."
    - name: "avg_file_size_bytes"
      expr: AVG(CAST(file_size_bytes AS DOUBLE))
      comment: "Average file size per version. Used to benchmark storage efficiency and forecast ingest infrastructure needs."
    - name: "avg_frame_rate"
      expr: AVG(CAST(frame_rate AS DOUBLE))
      comment: "Average frame rate across versions. Used to assess technical format mix and platform compatibility."
    - name: "distinct_platform_count"
      expr: COUNT(DISTINCT target_platform)
      comment: "Number of distinct platforms targeted by content versions. Measures distribution platform breadth."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_localization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures localization throughput, cost, and quality across languages and territories. Used by localization operations and content strategy teams to manage global content delivery efficiency."
  source: "`vibe_media_broadcasting_v1`.`content`.`localization`"
  dimensions:
    - name: "localization_status"
      expr: localization_status
      comment: "Current status of the localization job (e.g., in progress, delivered, approved) for pipeline tracking."
    - name: "localization_type"
      expr: localization_type
      comment: "Type of localization (e.g., dubbing, subtitling, metadata) for cost and effort segmentation."
    - name: "target_language_code"
      expr: target_language_code
      comment: "Target language for the localization, used to analyze language coverage and investment."
    - name: "target_territory_code"
      expr: target_territory_code
      comment: "Target territory for the localization, used for geographic distribution readiness analysis."
    - name: "qc_pass_flag"
      expr: qc_pass_flag
      comment: "Whether the localization passed quality control, used to track quality rates by language and vendor."
    - name: "compliance_certification_flag"
      expr: compliance_certification_flag
      comment: "Whether the localization has compliance certification, used to track regulatory readiness."
    - name: "order_date_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the localization was ordered, used for volume and spend trend analysis."
    - name: "accessibility_standard_met"
      expr: accessibility_standard_met
      comment: "Accessibility standard achieved by the localization, used for compliance reporting."
  measures:
    - name: "total_localization_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total spend on content localization. Core financial KPI for global content investment management."
    - name: "avg_localization_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per localization job. Used to benchmark vendor pricing and identify cost optimization opportunities."
    - name: "total_localizations"
      expr: COUNT(1)
      comment: "Total number of localization jobs. Measures global content delivery throughput."
    - name: "qc_passed_localization_count"
      expr: COUNT(CASE WHEN qc_pass_flag = TRUE THEN 1 END)
      comment: "Number of localizations that passed QC. Measures quality delivery rate and vendor performance."
    - name: "distinct_language_count"
      expr: COUNT(DISTINCT target_language_code)
      comment: "Number of distinct languages localized. Measures global language coverage of the content catalog."
    - name: "distinct_territory_count"
      expr: COUNT(DISTINCT target_territory_code)
      comment: "Number of distinct territories covered by localizations. Measures geographic distribution reach."
    - name: "avg_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration of localized content in minutes. Used to estimate localization effort and cost per minute benchmarks."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_compliance_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks content compliance violations, financial penalties, and remediation status. Used by compliance, legal, and operations teams to manage regulatory risk and remediation effectiveness."
  source: "`vibe_media_broadcasting_v1`.`content`.`compliance_finding`"
  dimensions:
    - name: "compliance_type"
      expr: compliance_type
      comment: "Type of compliance violation (e.g., content rating, captioning, political ad) for risk categorization."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the compliance finding, used to prioritize remediation and escalation."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the finding, used to track remediation pipeline."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body that issued or governs the finding, used for regulator-level risk analysis."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether the violation is a recurrence, used to identify systemic compliance failures."
    - name: "makegoods_required_flag"
      expr: makegoods_required_flag
      comment: "Whether makegoods are required as a result of the finding, used to quantify operational impact."
    - name: "finding_date_month"
      expr: DATE_TRUNC('MONTH', finding_date)
      comment: "Month the finding was identified, used for compliance incident trend analysis."
    - name: "affected_platform"
      expr: affected_platform
      comment: "Platform affected by the compliance finding, used for platform-level risk assessment."
  measures:
    - name: "total_compliance_findings"
      expr: COUNT(1)
      comment: "Total number of compliance findings. Baseline measure for regulatory risk exposure volume."
    - name: "total_fine_amount"
      expr: SUM(CAST(fine_amount AS DOUBLE))
      comment: "Total financial penalties from compliance violations. Critical KPI for regulatory cost management and risk quantification."
    - name: "avg_fine_amount"
      expr: AVG(CAST(fine_amount AS DOUBLE))
      comment: "Average fine per compliance finding. Used to benchmark penalty severity and prioritize compliance investment."
    - name: "total_remediation_cost"
      expr: SUM(CAST(remediation_cost AS DOUBLE))
      comment: "Total cost of remediating compliance findings. Used to quantify the operational cost of non-compliance."
    - name: "unresolved_finding_count"
      expr: COUNT(CASE WHEN resolution_status != 'resolved' THEN 1 END)
      comment: "Number of open/unresolved compliance findings. Measures current regulatory risk backlog requiring action."
    - name: "recurrent_finding_count"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Number of recurring compliance violations. Identifies systemic process failures requiring structural remediation."
    - name: "makegood_required_count"
      expr: COUNT(CASE WHEN makegoods_required_flag = TRUE THEN 1 END)
      comment: "Number of findings requiring makegoods. Quantifies operational disruption from compliance failures."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_ingest_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures content ingest throughput, quality control outcomes, and technical performance. Used by media operations and technology teams to manage ingest pipeline efficiency and QC pass rates."
  source: "`vibe_media_broadcasting_v1`.`content`.`ingest_event`"
  dimensions:
    - name: "ingest_status"
      expr: ingest_status
      comment: "Status of the ingest job (e.g., completed, failed, in progress) for pipeline health monitoring."
    - name: "ingest_source_type"
      expr: ingest_source_type
      comment: "Source type of the ingest (e.g., satellite, FTP, cloud) for supply chain analysis."
    - name: "automated_qc_result"
      expr: automated_qc_result
      comment: "Result of automated QC check, used to track automated quality gate performance."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method used to deliver content for ingest, used for supply chain efficiency analysis."
    - name: "source_format"
      expr: source_format
      comment: "Source file format of ingested content, used for format mix and transcoding cost analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the ingest job, used to assess SLA compliance by priority tier."
    - name: "ingest_timestamp_month"
      expr: DATE_TRUNC('MONTH', ingest_timestamp)
      comment: "Month of ingest for volume trend analysis."
    - name: "closed_caption_detected_flag"
      expr: closed_caption_detected_flag
      comment: "Whether closed captions were detected in the ingested content, for accessibility compliance tracking."
  measures:
    - name: "total_ingest_events"
      expr: COUNT(1)
      comment: "Total number of ingest events. Baseline measure for ingest pipeline throughput."
    - name: "successful_ingest_count"
      expr: COUNT(CASE WHEN ingest_status = 'completed' THEN 1 END)
      comment: "Number of successfully completed ingest jobs. Measures operational throughput and pipeline reliability."
    - name: "failed_ingest_count"
      expr: COUNT(CASE WHEN ingest_status = 'failed' THEN 1 END)
      comment: "Number of failed ingest jobs. Tracks operational failure rate requiring investigation and remediation."
    - name: "total_source_file_size_bytes"
      expr: SUM(CAST(source_file_size_bytes AS DOUBLE))
      comment: "Total volume of content ingested in bytes. Used for infrastructure capacity planning and bandwidth cost management."
    - name: "avg_source_duration_seconds"
      expr: AVG(CAST(source_duration_seconds AS DOUBLE))
      comment: "Average duration of ingested content in seconds. Used to benchmark ingest processing time and resource allocation."
    - name: "avg_source_frame_rate"
      expr: AVG(CAST(source_frame_rate AS DOUBLE))
      comment: "Average frame rate of ingested content. Used to assess technical format mix and transcoding pipeline requirements."
    - name: "caption_detected_ingest_count"
      expr: COUNT(CASE WHEN closed_caption_detected_flag = TRUE THEN 1 END)
      comment: "Number of ingest events where closed captions were detected. Tracks accessibility compliance of incoming content supply."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_series`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures the content series catalog depth, syndication eligibility, and accessibility coverage. Used by content strategy and programming teams to evaluate franchise portfolio health and distribution readiness."
  source: "`vibe_media_broadcasting_v1`.`content`.`series`"
  dimensions:
    - name: "series_status"
      expr: series_status
      comment: "Current lifecycle status of the series (e.g., active, completed, cancelled) for portfolio management."
    - name: "series_type"
      expr: series_type
      comment: "Type of series (e.g., scripted, unscripted, documentary) for content mix analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the series was produced, used for content origin and co-production analysis."
    - name: "language_original"
      expr: language_original
      comment: "Original language of the series, used for localization investment planning."
    - name: "syndication_eligible"
      expr: syndication_eligible
      comment: "Whether the series is eligible for syndication, used to identify revenue expansion opportunities."
    - name: "audio_description_available"
      expr: audio_description_available
      comment: "Whether audio description is available, used to track accessibility compliance at the series level."
    - name: "premiere_date_year"
      expr: YEAR(premiere_date)
      comment: "Year of series premiere, used for vintage analysis of the content portfolio."
    - name: "target_demographic"
      expr: target_demographic
      comment: "Target audience demographic for the series, used for audience alignment and advertising yield analysis."
  measures:
    - name: "total_series"
      expr: COUNT(1)
      comment: "Total number of series in the catalog. Baseline measure for franchise portfolio size."
    - name: "syndication_eligible_series_count"
      expr: COUNT(CASE WHEN syndication_eligible = TRUE THEN 1 END)
      comment: "Number of series eligible for syndication. Measures revenue expansion potential through secondary distribution."
    - name: "accessible_series_count"
      expr: COUNT(CASE WHEN audio_description_available = TRUE AND closed_caption_available = TRUE THEN 1 END)
      comment: "Number of series with both audio description and closed captioning. Tracks accessibility compliance at the franchise level."
    - name: "distinct_origin_country_count"
      expr: COUNT(DISTINCT country_of_origin)
      comment: "Number of distinct countries of origin in the series catalog. Measures geographic diversity of content supply."
    - name: "active_series_count"
      expr: COUNT(CASE WHEN series_status = 'active' THEN 1 END)
      comment: "Number of currently active series. Measures the live programming portfolio available for scheduling and monetization."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_windowing_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks content windowing strategy execution including revenue model mix, exclusivity tiers, and window status. Used by content strategy and distribution teams to optimize release sequencing and revenue maximization."
  source: "`vibe_media_broadcasting_v1`.`content`.`windowing_plan`"
  dimensions:
    - name: "window_status"
      expr: window_status
      comment: "Current status of the windowing plan (e.g., active, closed, planned) for distribution pipeline management."
    - name: "window_type"
      expr: window_type
      comment: "Type of distribution window (e.g., theatrical, SVOD, linear) for windowing strategy analysis."
    - name: "revenue_model"
      expr: revenue_model
      comment: "Revenue model for the window (e.g., subscription, transactional, ad-supported) for monetization mix analysis."
    - name: "exclusivity_tier"
      expr: exclusivity_tier
      comment: "Exclusivity tier of the window, used to assess competitive positioning and premium content strategy."
    - name: "territory_code"
      expr: territory_code
      comment: "Territory for the windowing plan, used for geographic distribution strategy analysis."
    - name: "bundle_eligibility"
      expr: bundle_eligibility
      comment: "Whether the content is eligible for bundle packaging, used to assess bundling strategy opportunities."
    - name: "planned_open_date_month"
      expr: DATE_TRUNC('MONTH', planned_open_date)
      comment: "Month the window is planned to open, used for release calendar planning."
    - name: "abr_enabled"
      expr: abr_enabled
      comment: "Whether adaptive bitrate streaming is enabled for this window, used to assess streaming quality delivery."
  measures:
    - name: "total_windowing_plans"
      expr: COUNT(1)
      comment: "Total number of windowing plans. Baseline measure for distribution strategy coverage across the content catalog."
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee obligations across windowing plans. Critical for revenue forecasting and cash flow management."
    - name: "avg_price_point"
      expr: AVG(CAST(price_point AS DOUBLE))
      comment: "Average price point across windowing plans. Used to benchmark monetization rates and optimize pricing strategy."
    - name: "active_window_count"
      expr: COUNT(CASE WHEN window_status = 'active' THEN 1 END)
      comment: "Number of currently active distribution windows. Measures live monetization surface area across the catalog."
    - name: "bundle_eligible_window_count"
      expr: COUNT(CASE WHEN bundle_eligibility = TRUE THEN 1 END)
      comment: "Number of windows eligible for bundle packaging. Identifies content available for subscriber value enhancement."
    - name: "distinct_territory_count"
      expr: COUNT(DISTINCT territory_code)
      comment: "Number of distinct territories covered by windowing plans. Measures geographic distribution reach of the content strategy."
    - name: "download_enabled_window_count"
      expr: COUNT(CASE WHEN download_to_go_enabled = TRUE THEN 1 END)
      comment: "Number of windows with download-to-go enabled. Measures offline viewing availability for subscriber experience."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_lifecycle_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks content lifecycle transitions, SLA compliance, and operational efficiency. Used by content operations and technology teams to manage content pipeline throughput and identify SLA breach patterns."
  source: "`vibe_media_broadcasting_v1`.`content`.`lifecycle_event`"
  dimensions:
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Stage of the content lifecycle (e.g., ingest, QC, distribution) for pipeline stage analysis."
    - name: "new_status"
      expr: new_status
      comment: "Status transitioned to in this lifecycle event, used to track content state progression."
    - name: "delivery_platform"
      expr: delivery_platform
      comment: "Platform targeted by this lifecycle event, used for platform-specific pipeline analysis."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether this lifecycle event breached its SLA target, used to identify operational bottlenecks."
    - name: "automated_flag"
      expr: automated_flag
      comment: "Whether the lifecycle transition was automated, used to measure automation coverage and efficiency."
    - name: "rollback_flag"
      expr: rollback_flag
      comment: "Whether this event involved a rollback, used to track pipeline quality and rework rates."
    - name: "transition_timestamp_month"
      expr: DATE_TRUNC('MONTH', transition_timestamp)
      comment: "Month of the lifecycle transition for throughput trend analysis."
    - name: "compliance_checkpoint_passed"
      expr: compliance_checkpoint_passed
      comment: "Whether the compliance checkpoint was passed at this lifecycle stage, for compliance gate tracking."
  measures:
    - name: "total_lifecycle_events"
      expr: COUNT(1)
      comment: "Total number of lifecycle events. Baseline measure for content pipeline throughput volume."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of lifecycle events that breached SLA targets. Critical operational KPI for pipeline performance management."
    - name: "rollback_event_count"
      expr: COUNT(CASE WHEN rollback_flag = TRUE THEN 1 END)
      comment: "Number of lifecycle events requiring rollback. Measures pipeline quality and rework rate."
    - name: "avg_transition_duration_hours"
      expr: AVG(CAST(transition_duration_hours AS DOUBLE))
      comment: "Average time to complete a lifecycle transition in hours. Used to benchmark pipeline speed and identify bottlenecks."
    - name: "compliance_checkpoint_passed_count"
      expr: COUNT(CASE WHEN compliance_checkpoint_passed = TRUE THEN 1 END)
      comment: "Number of lifecycle events that passed compliance checkpoints. Measures compliance gate effectiveness."
    - name: "automated_event_count"
      expr: COUNT(CASE WHEN automated_flag = TRUE THEN 1 END)
      comment: "Number of automated lifecycle transitions. Measures automation coverage and operational efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures content package portfolio value, distribution coverage, and commercial performance. Used by distribution and commercial teams to manage package economics and partner deal structuring."
  source: "`vibe_media_broadcasting_v1`.`content`.`package`"
  dimensions:
    - name: "package_status"
      expr: package_status
      comment: "Current status of the content package (e.g., active, expired, draft) for portfolio management."
    - name: "package_type"
      expr: package_type
      comment: "Type of content package (e.g., SVOD, linear, AVOD) for commercial model analysis."
    - name: "commercial_context"
      expr: commercial_context
      comment: "Commercial context of the package, used to segment packages by business model."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the package is exclusive, used to assess competitive differentiation."
    - name: "territory_scope"
      expr: territory_scope
      comment: "Geographic scope of the package, used for territory-level distribution analysis."
    - name: "drm_required_flag"
      expr: drm_required_flag
      comment: "Whether DRM is required for the package, used to assess content protection requirements."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the package became effective, used for package launch trend analysis."
    - name: "language_primary"
      expr: language_primary
      comment: "Primary language of the package, used for language market coverage analysis."
  measures:
    - name: "total_packages"
      expr: COUNT(1)
      comment: "Total number of content packages. Baseline measure for distribution portfolio breadth."
    - name: "total_package_value_usd"
      expr: SUM(CAST(value_usd AS DOUBLE))
      comment: "Total commercial value of all content packages in USD. Core financial KPI for distribution revenue potential."
    - name: "avg_package_value_usd"
      expr: AVG(CAST(value_usd AS DOUBLE))
      comment: "Average value per content package. Used to benchmark deal economics and pricing strategy."
    - name: "total_runtime_hours"
      expr: SUM(CAST(total_runtime_hours AS DOUBLE))
      comment: "Total content runtime hours across all packages. Measures content volume available for distribution."
    - name: "active_package_count"
      expr: COUNT(CASE WHEN package_status = 'active' THEN 1 END)
      comment: "Number of currently active packages. Measures live distribution inventory available for monetization."
    - name: "exclusive_package_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END)
      comment: "Number of exclusive content packages. Measures competitive differentiation of the distribution portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_episode_transmission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks episode broadcast transmission performance including viewership, signal quality, and technical issues. Used by broadcast operations and programming teams to monitor on-air performance and audience delivery."
  source: "`vibe_media_broadcasting_v1`.`content`.`episode_transmission`"
  dimensions:
    - name: "transmission_status"
      expr: transmission_status
      comment: "Status of the transmission (e.g., completed, failed, interrupted) for broadcast reliability analysis."
    - name: "transmission_quality"
      expr: transmission_quality
      comment: "Quality rating of the transmission, used to track broadcast technical performance."
    - name: "technical_issues_flag"
      expr: technical_issues_flag
      comment: "Whether technical issues occurred during transmission, used to identify reliability problems."
    - name: "air_date_month"
      expr: DATE_TRUNC('MONTH', air_date)
      comment: "Month of air date for transmission volume and viewership trend analysis."
  measures:
    - name: "total_transmissions"
      expr: COUNT(1)
      comment: "Total number of episode transmissions. Baseline measure for broadcast output volume."
    - name: "total_viewer_count"
      expr: SUM(CAST(viewer_count AS DOUBLE))
      comment: "Total cumulative viewers across all episode transmissions. Core audience delivery KPI for programming and advertising yield."
    - name: "avg_viewer_count"
      expr: AVG(CAST(viewer_count AS DOUBLE))
      comment: "Average viewers per transmission. Used to benchmark episode audience performance and inform scheduling decisions."
    - name: "avg_signal_strength_dbm"
      expr: AVG(CAST(signal_strength_dbm AS DOUBLE))
      comment: "Average signal strength in dBm across transmissions. Used to monitor broadcast technical quality and infrastructure health."
    - name: "technical_issue_transmission_count"
      expr: COUNT(CASE WHEN technical_issues_flag = TRUE THEN 1 END)
      comment: "Number of transmissions with technical issues. Measures broadcast reliability and operational quality."
    - name: "avg_transmission_duration_seconds"
      expr: AVG(CAST(transmission_duration_seconds AS DOUBLE))
      comment: "Average transmission duration in seconds. Used to verify broadcast completeness and scheduling accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_genre_buy_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks genre-based advertising buy agreements including spend commitments and exclusivity. Used by ad sales and content strategy teams to manage genre monetization and advertiser category relationships."
  source: "`vibe_media_broadcasting_v1`.`content`.`genre_buy_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the genre buy agreement (e.g., active, expired, pending) for pipeline management."
    - name: "category_exclusivity_flag"
      expr: category_exclusivity_flag
      comment: "Whether the agreement grants category exclusivity, used to assess competitive advertising positioning."
    - name: "preferred_genre_flag"
      expr: preferred_genre_flag
      comment: "Whether this is a preferred genre designation for the advertiser, used to track premium genre relationships."
    - name: "contract_start_date_month"
      expr: DATE_TRUNC('MONTH', contract_start_date)
      comment: "Month the agreement started, used for cohort analysis of genre buy agreement activity."
    - name: "contract_end_date_year"
      expr: YEAR(contract_end_date)
      comment: "Year the agreement expires, used to forecast renewal pipeline and revenue at risk."
  measures:
    - name: "total_genre_buy_agreements"
      expr: COUNT(1)
      comment: "Total number of genre buy agreements. Baseline measure for genre monetization activity."
    - name: "total_minimum_spend_commitment"
      expr: SUM(CAST(minimum_spend_commitment AS DOUBLE))
      comment: "Total minimum spend committed across all genre buy agreements. Core revenue assurance KPI for ad sales forecasting."
    - name: "avg_minimum_spend_commitment"
      expr: AVG(CAST(minimum_spend_commitment AS DOUBLE))
      comment: "Average minimum spend per genre buy agreement. Used to benchmark deal size and negotiate future agreements."
    - name: "avg_genre_cpm_premium_percent"
      expr: AVG(CAST(genre_cpm_premium_percent AS DOUBLE))
      comment: "Average CPM premium percentage for genre buys. Measures the monetization premium achieved through genre targeting."
    - name: "exclusive_agreement_count"
      expr: COUNT(CASE WHEN category_exclusivity_flag = TRUE THEN 1 END)
      comment: "Number of exclusive genre buy agreements. Measures premium advertiser relationships and competitive ad positioning."
    - name: "distinct_advertiser_count"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of distinct advertisers with genre buy agreements. Measures advertiser base breadth for genre monetization."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_billing_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NOTE: Per VREQ-037, content.billing_line is designated for migration to the billing domain. This minimal metric view is provided for current-state tracking. Tracks billing line records by cost center allocation. Used by finance teams for cost attribution and financial reporting."
  source: "`vibe_media_broadcasting_v1`.`content`.`billing_line`"
  dimensions:
    - name: "finance_cost_center_id"
      expr: finance_cost_center_id
      comment: "Cost center to which the billing line is allocated. Used to segment billing volume by cost center for financial reporting."
  measures:
    - name: "total_billing_lines"
      expr: COUNT(1)
      comment: "Total number of billing lines. Baseline measure for billing transaction volume by cost center."
    - name: "distinct_cost_center_count"
      expr: COUNT(DISTINCT finance_cost_center_id)
      comment: "Number of distinct cost centers with billing line allocations. Used to assess cost center coverage and financial reporting completeness."
$$;