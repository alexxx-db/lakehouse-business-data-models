-- Metric views for domain: mediaasset | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-30 04:55:25

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_ingest_job`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ingest throughput, success rate, and data volume KPIs for media asset onboarding operations."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job`"
  dimensions:
    - name: "job_status"
      expr: job_status
      comment: "Ingest job lifecycle status (completed, failed, in-progress) for success-rate analysis."
    - name: "ingest_source_type"
      expr: ingest_source_type
      comment: "Source channel of ingest (file, feed, tape) to compare pipeline performance."
    - name: "priority_level"
      expr: priority_level
      comment: "Job priority tier for SLA and capacity prioritization analysis."
    - name: "content_type"
      expr: content_type
      comment: "Type of content ingested for workload mix analysis."
    - name: "ingest_month"
      expr: DATE_TRUNC('MONTH', ingest_start_timestamp)
      comment: "Month of ingest start for trend reporting."
  measures:
    - name: "ingest_job_count"
      expr: COUNT(1)
      comment: "Total ingest jobs processed — baseline operational throughput."
    - name: "distinct_assets_ingested"
      expr: COUNT(DISTINCT media_asset_id)
      comment: "Unique media assets ingested — content acquisition volume."
    - name: "total_bytes_ingested"
      expr: SUM(CAST(bytes_transferred AS DOUBLE))
      comment: "Total data volume ingested for storage capacity and cost planning."
    - name: "avg_transfer_rate_mbps"
      expr: AVG(CAST(transfer_rate_mbps AS DOUBLE))
      comment: "Average transfer throughput — pipeline performance health indicator."
    - name: "avg_duration_seconds"
      expr: AVG(CAST(duration_seconds AS DOUBLE))
      comment: "Average media duration ingested per job."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_transcode_job`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transcoding cost, quality, and operational efficiency KPIs for the encode farm."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job`"
  dimensions:
    - name: "job_status"
      expr: job_status
      comment: "Transcode job status for success/failure rate analysis."
    - name: "job_type"
      expr: job_type
      comment: "Type of transcode (proxy, mezzanine, ABR) for workload analysis."
    - name: "job_priority"
      expr: job_priority
      comment: "Job priority tier for SLA management."
    - name: "transcoding_engine"
      expr: transcoding_engine
      comment: "Encoding engine/vendor for performance benchmarking."
    - name: "quality_validation_result"
      expr: quality_validation_result
      comment: "QC outcome of transcode for quality monitoring."
  measures:
    - name: "transcode_job_count"
      expr: COUNT(1)
      comment: "Total transcode jobs — encode farm throughput baseline."
    - name: "total_estimated_cost"
      expr: SUM(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Total estimated transcoding cost for budget control."
    - name: "avg_estimated_cost"
      expr: AVG(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Average cost per transcode job — unit economics indicator."
    - name: "avg_quality_validation_score"
      expr: AVG(CAST(quality_validation_score AS DOUBLE))
      comment: "Average output quality score for quality assurance steering."
    - name: "total_output_size_gb"
      expr: SUM(CAST(output_file_size_gb AS DOUBLE))
      comment: "Total transcoded output volume for storage forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_qc_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality control pass rates and defect KPIs for media asset compliance."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection`"
  dimensions:
    - name: "overall_result"
      expr: overall_result
      comment: "Overall QC result (pass/fail) — core quality steering dimension."
    - name: "qc_type"
      expr: qc_type
      comment: "Type of QC performed (automated, manual) for process analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "QC inspection workflow status."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval disposition of the inspected asset."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_timestamp)
      comment: "Month of inspection for trend tracking."
  measures:
    - name: "inspection_count"
      expr: COUNT(1)
      comment: "Total QC inspections performed — quality workload baseline."
    - name: "avg_loudness_lufs"
      expr: AVG(CAST(loudness_lufs AS DOUBLE))
      comment: "Average loudness measurement for broadcast loudness compliance."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_storage_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage capacity utilization and cost KPIs for the media asset estate."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`storage_location`"
  dimensions:
    - name: "storage_tier"
      expr: storage_tier
      comment: "Storage tier (hot, nearline, archive) for cost/utilization analysis."
    - name: "storage_type"
      expr: storage_type
      comment: "Storage technology type for infrastructure planning."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the location for availability analysis."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region for data-residency and capacity planning."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier of the storage location."
  measures:
    - name: "location_count"
      expr: COUNT(1)
      comment: "Total storage locations in inventory — estate baseline."
    - name: "total_capacity_tb"
      expr: SUM(CAST(total_capacity_tb AS DOUBLE))
      comment: "Total provisioned storage capacity for capacity planning."
    - name: "used_capacity_tb"
      expr: SUM(CAST(used_capacity_tb AS DOUBLE))
      comment: "Total consumed storage capacity for utilization tracking."
    - name: "available_capacity_tb"
      expr: SUM(CAST(available_capacity_tb AS DOUBLE))
      comment: "Total free storage capacity — runway indicator for procurement."
    - name: "avg_cost_per_tb_month"
      expr: AVG(CAST(cost_per_tb_per_month AS DOUBLE))
      comment: "Average storage cost per TB per month — unit cost steering metric."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_asset_storage_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset storage footprint and tiering cost KPIs across the storage estate."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment`"
  dimensions:
    - name: "storage_tier"
      expr: storage_tier
      comment: "Storage tier of the assignment for tiering cost analysis."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of the storage assignment (active, archived)."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Region of the stored asset for residency analysis."
    - name: "verification_status"
      expr: verification_status
      comment: "Checksum verification status for data integrity monitoring."
    - name: "access_frequency"
      expr: access_frequency
      comment: "Access frequency band for tiering optimization decisions."
  measures:
    - name: "assignment_count"
      expr: COUNT(1)
      comment: "Total asset storage assignments — placement baseline."
    - name: "total_stored_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total bytes under management across assignments for cost allocation."
    - name: "avg_storage_cost_per_gb"
      expr: AVG(CAST(storage_cost_per_gb AS DOUBLE))
      comment: "Average storage cost per GB — tiering efficiency metric."
    - name: "distinct_stored_assets"
      expr: COUNT(DISTINCT media_asset_id)
      comment: "Unique assets with active storage placement."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_archive_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Archive and restore operations, cost and SLA KPIs for long-term preservation."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`archive_record`"
  dimensions:
    - name: "archive_status"
      expr: archive_status
      comment: "Archive operation status for preservation workflow tracking."
    - name: "storage_tier"
      expr: storage_tier
      comment: "Archive storage tier for cost analysis."
    - name: "restore_sla_tier"
      expr: restore_sla_tier
      comment: "Restore SLA tier for retrieval performance analysis."
    - name: "archive_destination_type"
      expr: archive_destination_type
      comment: "Archive destination type (cloud, LTO, offsite)."
    - name: "archive_month"
      expr: DATE_TRUNC('MONTH', archive_date)
      comment: "Month of archival for trend analysis."
  measures:
    - name: "archive_record_count"
      expr: COUNT(1)
      comment: "Total archive records — preservation activity baseline."
    - name: "total_archived_bytes"
      expr: SUM(CAST(archive_file_size_bytes AS DOUBLE))
      comment: "Total archived data volume for preservation capacity planning."
    - name: "avg_archive_cost_per_gb"
      expr: AVG(CAST(archive_cost_per_gb AS DOUBLE))
      comment: "Average archive cost per GB — preservation unit economics."
    - name: "distinct_archived_assets"
      expr: COUNT(DISTINCT media_asset_id)
      comment: "Unique assets archived for retention coverage."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_deal_asset_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset licensing revenue and delivery KPIs from acquisition/content deals."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of licensed asset for fulfillment tracking."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the license is exclusive — deal value driver."
    - name: "territory_code"
      expr: territory_code
      comment: "Licensed territory for revenue-by-region analysis."
    - name: "license_start_month"
      expr: DATE_TRUNC('MONTH', license_term_start_date)
      comment: "Month the license term starts for revenue timing."
  measures:
    - name: "license_count"
      expr: COUNT(1)
      comment: "Total asset licenses — deal activity baseline."
    - name: "total_license_fee"
      expr: SUM(CAST(license_fee_amount AS DOUBLE))
      comment: "Total license fee value — licensing revenue KPI."
    - name: "avg_license_fee"
      expr: AVG(CAST(license_fee_amount AS DOUBLE))
      comment: "Average license fee per deal — pricing benchmark."
    - name: "distinct_licensed_assets"
      expr: COUNT(DISTINCT media_asset_id)
      comment: "Unique assets monetized through licensing."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_asset_access_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset access demand, approval, and governance KPIs for MAM access control."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Access request status for fulfillment and SLA analysis."
    - name: "access_type"
      expr: access_type
      comment: "Type of access requested (download, stream, edit)."
    - name: "requestor_department"
      expr: requestor_department
      comment: "Department requesting access for demand analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Request priority for SLA prioritization."
    - name: "rights_clearance_status"
      expr: rights_clearance_status
      comment: "Rights clearance status for compliance governance."
  measures:
    - name: "access_request_count"
      expr: COUNT(1)
      comment: "Total access requests — asset demand baseline."
    - name: "distinct_requested_assets"
      expr: COUNT(DISTINCT media_asset_id)
      comment: "Unique assets requested — content demand breadth."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_format_migration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Format migration throughput, quality, and duration KPIs for media modernization."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`format_migration`"
  dimensions:
    - name: "migration_status"
      expr: migration_status
      comment: "Migration job status for success-rate tracking."
    - name: "migration_type"
      expr: migration_type
      comment: "Type of migration for workload analysis."
    - name: "migration_priority"
      expr: migration_priority
      comment: "Migration priority tier for scheduling decisions."
    - name: "target_format"
      expr: target_format
      comment: "Target format of the migration for standardization tracking."
  measures:
    - name: "migration_count"
      expr: COUNT(1)
      comment: "Total format migrations — modernization activity baseline."
    - name: "avg_migration_duration_seconds"
      expr: AVG(CAST(migration_duration_seconds AS DOUBLE))
      comment: "Average migration job duration — pipeline efficiency metric."
    - name: "avg_quality_validation_score"
      expr: AVG(CAST(quality_validation_score AS DOUBLE))
      comment: "Average post-migration quality score for QA steering."
    - name: "total_target_bytes"
      expr: SUM(CAST(target_file_size_bytes AS DOUBLE))
      comment: "Total migrated output volume for capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_media_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Master media asset inventory, lifecycle, and storage footprint KPIs."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Asset lifecycle status (active, archived, purged) for inventory health."
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class for portfolio composition analysis."
    - name: "asset_type"
      expr: asset_type
      comment: "Asset type for content mix analysis."
    - name: "storage_tier"
      expr: storage_tier
      comment: "Current storage tier for cost/tiering analysis."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Whether asset is under legal hold — compliance risk dimension."
  measures:
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Total media assets in inventory — catalog size baseline."
    - name: "total_storage_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total asset storage footprint for cost and capacity steering."
    - name: "total_duration_seconds"
      expr: SUM(CAST(duration_seconds AS DOUBLE))
      comment: "Total media duration in catalog for content volume reporting."
    - name: "avg_bit_rate_mbps"
      expr: AVG(CAST(bit_rate_mbps AS DOUBLE))
      comment: "Average bit rate of assets — quality profile indicator."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_syndication_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Syndication clearance and delivery KPIs for distribution monetization."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`syndication_inventory`"
  dimensions:
    - name: "clearance_status"
      expr: clearance_status
      comment: "Clearance status for syndication readiness tracking."
    - name: "inclusion_status"
      expr: inclusion_status
      comment: "Inclusion status in the syndication package."
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month of delivery for syndication fulfillment timing."
  measures:
    - name: "inventory_count"
      expr: COUNT(1)
      comment: "Total syndication inventory items — distribution pipeline baseline."
    - name: "avg_clearance_percentage"
      expr: AVG(CAST(actual_clearance_percentage AS DOUBLE))
      comment: "Average actual clearance percentage — syndication yield KPI."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_watermark_forensic_match`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Forensic watermark piracy-detection KPIs for content protection."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`mediaasset_watermark_forensic_match`"
  dimensions:
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the forensic match for triage."
    - name: "detected_platform"
      expr: detected_platform
      comment: "Platform where piracy was detected for hotspot analysis."
    - name: "action_taken"
      expr: action_taken
      comment: "Enforcement action taken for response tracking."
    - name: "watermark_type"
      expr: watermark_type
      comment: "Watermark technology type for detection-method analysis."
  measures:
    - name: "match_count"
      expr: COUNT(1)
      comment: "Total forensic watermark matches — piracy incident baseline."
    - name: "avg_match_confidence"
      expr: AVG(CAST(match_confidence_score AS DOUBLE))
      comment: "Average match confidence score — detection quality indicator."
    - name: "distinct_compromised_assets"
      expr: COUNT(DISTINCT media_asset_id)
      comment: "Unique assets with leak detection — content protection exposure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_asset_collection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collection-level aggregation and metadata completeness."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection`"
  dimensions:
    - name: "collection_type"
      expr: collection_type
      comment: "Type of collection (e.g., Series, Playlist)."
    - name: "primary_genre"
      expr: primary_genre
      comment: "Primary genre of the collection."
    - name: "territory_code"
      expr: territory_code
      comment: "Geographic territory of collection."
    - name: "creation_date"
      expr: creation_date
      comment: "Date the collection was created."
  measures:
    - name: "collection_count"
      expr: COUNT(1)
      comment: "Total number of asset collections."
    - name: "total_collection_storage_gb"
      expr: SUM(CAST(total_storage_size_bytes AS DOUBLE)) / (1024*1024*1024)
      comment: "Aggregate storage size of collections in GB."
    - name: "total_collection_duration_seconds"
      expr: SUM(CAST(total_duration_seconds AS DOUBLE))
      comment: "Total duration of all assets in collections in seconds."
    - name: "legal_hold_collection_count"
      expr: SUM(CASE WHEN legal_hold_flag THEN 1 ELSE 0 END)
      comment: "Number of collections under legal hold."
    - name: "average_metadata_completeness_score"
      expr: AVG(CAST(metadata_completeness_score AS DOUBLE))
      comment: "Average metadata completeness score across collections."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_asset_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Version-level metrics for media assets."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`"
  dimensions:
    - name: "storage_tier"
      expr: storage_tier
      comment: "Storage tier for the version."
    - name: "version_status"
      expr: version_status
      comment: "Status of the version (e.g., Active, Deprecated)."
    - name: "video_codec"
      expr: video_codec
      comment: "Video codec used in the version."
    - name: "audio_codec"
      expr: audio_codec
      comment: "Audio codec used."
    - name: "resolution_width"
      expr: resolution_width
      comment: "Width resolution of the version."
    - name: "resolution_height"
      expr: resolution_height
      comment: "Height resolution of the version."
    - name: "drm_protection"
      expr: drm_protection
      comment: "Flag indicating DRM protection."
    - name: "created_timestamp"
      expr: created_timestamp
      comment: "Timestamp when version was created."
  measures:
    - name: "total_versions"
      expr: COUNT(1)
      comment: "Total number of asset versions."
    - name: "total_version_file_size_gb"
      expr: SUM(CAST(file_size_bytes AS DOUBLE)) / (1024*1024*1024)
      comment: "Total file size of versions in GB."
    - name: "average_version_duration_seconds"
      expr: AVG(CAST(duration_seconds AS DOUBLE))
      comment: "Average duration of versions."
    - name: "average_frame_rate"
      expr: AVG(CAST(frame_rate AS DOUBLE))
      comment: "Average frame rate across versions."
    - name: "distinct_version_numbers"
      expr: COUNT(DISTINCT version_number)
      comment: "Count of distinct version identifiers."
    - name: "drm_protected_version_count"
      expr: SUM(CASE WHEN drm_protection THEN 1 ELSE 0 END)
      comment: "Number of versions with DRM protection."
$$;