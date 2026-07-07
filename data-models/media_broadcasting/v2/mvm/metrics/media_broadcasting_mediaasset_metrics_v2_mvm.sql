-- Metric views for domain: mediaasset | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-30 06:47:57

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_media_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core media asset inventory and lifecycle metrics tracking asset utilization, storage efficiency, and content portfolio health"
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Type of media asset (e.g., video, audio, image, document)"
    - name: "asset_class"
      expr: asset_class
      comment: "Classification of asset (e.g., master, proxy, mezzanine)"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the asset (e.g., active, archived, deprecated)"
    - name: "content_classification"
      expr: content_classification
      comment: "Content classification or rating of the asset"
    - name: "storage_tier"
      expr: storage_tier
      comment: "Storage tier where asset resides (e.g., hot, warm, cold, archive)"
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Whether asset is under legal hold"
    - name: "retention_policy_code"
      expr: retention_policy_code
      comment: "Retention policy governing asset lifecycle"
    - name: "codec"
      expr: codec
      comment: "Video or audio codec used for the asset"
    - name: "resolution"
      expr: resolution
      comment: "Video resolution (e.g., 1080p, 4K, 8K)"
    - name: "hdr_format"
      expr: hdr_format
      comment: "HDR format if applicable (e.g., HDR10, Dolby Vision)"
    - name: "ingest_year"
      expr: YEAR(ingest_timestamp)
      comment: "Year the asset was ingested"
    - name: "ingest_month"
      expr: DATE_TRUNC('MONTH', ingest_timestamp)
      comment: "Month the asset was ingested"
  measures:
    - name: "total_assets"
      expr: COUNT(1)
      comment: "Total number of media assets in inventory"
    - name: "total_storage_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total storage consumed by all assets in bytes"
    - name: "total_storage_tb"
      expr: SUM(CAST(file_size_bytes AS DOUBLE)) / 1099511627776.0
      comment: "Total storage consumed by all assets in terabytes"
    - name: "avg_file_size_gb"
      expr: AVG(CAST(file_size_bytes AS DOUBLE)) / 1073741824.0
      comment: "Average file size per asset in gigabytes"
    - name: "total_content_duration_hours"
      expr: SUM(CAST(duration_seconds AS DOUBLE)) / 3600.0
      comment: "Total duration of all content in hours"
    - name: "avg_content_duration_minutes"
      expr: AVG(CAST(duration_seconds AS DOUBLE)) / 60.0
      comment: "Average content duration per asset in minutes"
    - name: "avg_bitrate_mbps"
      expr: AVG(CAST(bit_rate_mbps AS DOUBLE))
      comment: "Average bitrate across assets in megabits per second"
    - name: "storage_efficiency_mb_per_minute"
      expr: SUM(CAST(file_size_bytes AS DOUBLE)) / 1048576.0 / NULLIF(SUM(CAST(duration_seconds AS DOUBLE)) / 60.0, 0)
      comment: "Storage efficiency measured as megabytes per minute of content"
    - name: "assets_under_legal_hold"
      expr: SUM(CASE WHEN legal_hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assets currently under legal hold"
    - name: "unique_asset_types"
      expr: COUNT(DISTINCT asset_type)
      comment: "Number of distinct asset types in inventory"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_storage_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage infrastructure capacity, utilization, and cost efficiency metrics for media asset storage locations"
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`storage_location`"
  dimensions:
    - name: "storage_type"
      expr: storage_type
      comment: "Type of storage system (e.g., SAN, NAS, object storage, tape)"
    - name: "storage_tier"
      expr: storage_tier
      comment: "Storage tier classification (e.g., hot, warm, cold, archive)"
    - name: "storage_vendor"
      expr: storage_vendor
      comment: "Vendor providing the storage solution"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region where storage is located"
    - name: "data_center_name"
      expr: data_center_name
      comment: "Name of the data center hosting the storage"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the storage location"
    - name: "sla_tier"
      expr: sla_tier
      comment: "Service level agreement tier for the storage"
    - name: "encryption_enabled"
      expr: encryption_enabled
      comment: "Whether encryption is enabled for this storage location"
    - name: "replication_enabled"
      expr: replication_enabled
      comment: "Whether replication is enabled for this storage location"
  measures:
    - name: "total_storage_locations"
      expr: COUNT(1)
      comment: "Total number of storage locations in the infrastructure"
    - name: "total_capacity_tb"
      expr: SUM(CAST(total_capacity_tb AS DOUBLE))
      comment: "Total provisioned storage capacity across all locations in terabytes"
    - name: "total_used_capacity_tb"
      expr: SUM(CAST(used_capacity_tb AS DOUBLE))
      comment: "Total used storage capacity across all locations in terabytes"
    - name: "total_available_capacity_tb"
      expr: SUM(CAST(available_capacity_tb AS DOUBLE))
      comment: "Total available storage capacity across all locations in terabytes"
    - name: "avg_utilization_pct"
      expr: AVG(CAST(used_capacity_tb AS DOUBLE) / NULLIF(CAST(total_capacity_tb AS DOUBLE), 0) * 100.0)
      comment: "Average storage utilization percentage across locations"
    - name: "total_monthly_storage_cost"
      expr: SUM(CAST(used_capacity_tb AS DOUBLE) * CAST(cost_per_tb_per_month AS DOUBLE))
      comment: "Total monthly storage cost based on used capacity and per-TB pricing"
    - name: "avg_cost_per_tb_per_month"
      expr: AVG(CAST(cost_per_tb_per_month AS DOUBLE))
      comment: "Average cost per terabyte per month across storage locations"
    - name: "avg_restore_time_objective_hours"
      expr: AVG(CAST(restore_time_objective_hours AS DOUBLE))
      comment: "Average restore time objective in hours across storage locations"
    - name: "locations_with_encryption"
      expr: SUM(CASE WHEN encryption_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of storage locations with encryption enabled"
    - name: "locations_with_replication"
      expr: SUM(CASE WHEN replication_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of storage locations with replication enabled"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_ingest_job`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media ingest pipeline performance, throughput, and quality metrics tracking content acquisition efficiency"
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job`"
  dimensions:
    - name: "job_status"
      expr: job_status
      comment: "Current status of the ingest job (e.g., pending, running, completed, failed)"
    - name: "content_type"
      expr: content_type
      comment: "Type of content being ingested"
    - name: "ingest_source_type"
      expr: ingest_source_type
      comment: "Source type for the ingest (e.g., file transfer, live feed, tape)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the ingest job"
    - name: "source_format"
      expr: source_format
      comment: "Format of the source media"
    - name: "target_format"
      expr: target_format
      comment: "Target format for the ingested media"
    - name: "codec"
      expr: codec
      comment: "Codec used for the ingested media"
    - name: "resolution"
      expr: resolution
      comment: "Resolution of the ingested media"
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Whether the ingested content is under legal hold"
    - name: "ingest_start_month"
      expr: DATE_TRUNC('MONTH', ingest_start_timestamp)
      comment: "Month when the ingest job started"
  measures:
    - name: "total_ingest_jobs"
      expr: COUNT(1)
      comment: "Total number of ingest jobs"
    - name: "completed_ingest_jobs"
      expr: SUM(CASE WHEN job_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of successfully completed ingest jobs"
    - name: "failed_ingest_jobs"
      expr: SUM(CASE WHEN job_status = 'failed' THEN 1 ELSE 0 END)
      comment: "Count of failed ingest jobs"
    - name: "total_bytes_ingested"
      expr: SUM(CAST(bytes_transferred AS DOUBLE))
      comment: "Total volume of data ingested in bytes"
    - name: "total_tb_ingested"
      expr: SUM(CAST(bytes_transferred AS DOUBLE)) / 1099511627776.0
      comment: "Total volume of data ingested in terabytes"
    - name: "total_content_duration_hours"
      expr: SUM(CAST(duration_seconds AS DOUBLE)) / 3600.0
      comment: "Total duration of ingested content in hours"
    - name: "avg_transfer_rate_mbps"
      expr: AVG(CAST(transfer_rate_mbps AS DOUBLE))
      comment: "Average transfer rate during ingest in megabits per second"
    - name: "avg_ingest_duration_minutes"
      expr: AVG((UNIX_TIMESTAMP(ingest_end_timestamp) - UNIX_TIMESTAMP(ingest_start_timestamp)) / 60.0)
      comment: "Average duration of ingest jobs in minutes"
    - name: "ingest_throughput_gb_per_hour"
      expr: SUM(CAST(bytes_transferred AS DOUBLE)) / 1073741824.0 / NULLIF(SUM((UNIX_TIMESTAMP(ingest_end_timestamp) - UNIX_TIMESTAMP(ingest_start_timestamp)) / 3600.0), 0)
      comment: "Ingest throughput measured as gigabytes per hour"
    - name: "jobs_with_closed_captions"
      expr: SUM(CASE WHEN closed_caption_present = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ingest jobs that included closed captions"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_transcode_job`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transcoding pipeline efficiency, quality, and cost metrics tracking media format conversion performance"
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job`"
  dimensions:
    - name: "job_status"
      expr: job_status
      comment: "Current status of the transcode job (e.g., queued, processing, completed, failed)"
    - name: "job_type"
      expr: job_type
      comment: "Type of transcoding job (e.g., format conversion, ABR ladder, proxy generation)"
    - name: "job_priority"
      expr: job_priority
      comment: "Priority level assigned to the transcode job"
    - name: "transcoding_engine"
      expr: transcoding_engine
      comment: "Transcoding engine or service used for the job"
    - name: "source_codec"
      expr: source_codec
      comment: "Codec of the source media"
    - name: "source_format"
      expr: source_format
      comment: "Format of the source media"
    - name: "source_resolution"
      expr: source_resolution
      comment: "Resolution of the source media"
    - name: "quality_validation_result"
      expr: quality_validation_result
      comment: "Result of quality validation after transcoding"
    - name: "processing_start_month"
      expr: DATE_TRUNC('MONTH', processing_start_timestamp)
      comment: "Month when the transcode job started processing"
  measures:
    - name: "total_transcode_jobs"
      expr: COUNT(1)
      comment: "Total number of transcode jobs"
    - name: "completed_transcode_jobs"
      expr: SUM(CASE WHEN job_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of successfully completed transcode jobs"
    - name: "failed_transcode_jobs"
      expr: SUM(CASE WHEN job_status = 'failed' THEN 1 ELSE 0 END)
      comment: "Count of failed transcode jobs"
    - name: "total_source_file_size_gb"
      expr: SUM(CAST(source_file_size_gb AS DOUBLE))
      comment: "Total size of source files transcoded in gigabytes"
    - name: "total_output_file_size_gb"
      expr: SUM(CAST(output_file_size_gb AS DOUBLE))
      comment: "Total size of output files produced in gigabytes"
    - name: "avg_compression_ratio"
      expr: AVG(CAST(source_file_size_gb AS DOUBLE) / NULLIF(CAST(output_file_size_gb AS DOUBLE), 0))
      comment: "Average compression ratio achieved during transcoding"
    - name: "total_processing_hours"
      expr: SUM((UNIX_TIMESTAMP(processing_end_timestamp) - UNIX_TIMESTAMP(processing_start_timestamp)) / 3600.0)
      comment: "Total processing time across all transcode jobs in hours"
    - name: "avg_processing_duration_minutes"
      expr: AVG((UNIX_TIMESTAMP(processing_end_timestamp) - UNIX_TIMESTAMP(processing_start_timestamp)) / 60.0)
      comment: "Average processing duration per transcode job in minutes"
    - name: "total_transcode_cost_usd"
      expr: SUM(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Total estimated cost of transcoding operations in USD"
    - name: "avg_cost_per_gb_transcoded"
      expr: SUM(CAST(cost_estimate_usd AS DOUBLE)) / NULLIF(SUM(CAST(source_file_size_gb AS DOUBLE)), 0)
      comment: "Average cost per gigabyte of source media transcoded in USD"
    - name: "avg_quality_validation_score"
      expr: AVG(CAST(quality_validation_score AS DOUBLE))
      comment: "Average quality validation score across transcode jobs"
    - name: "transcode_throughput_gb_per_hour"
      expr: SUM(CAST(source_file_size_gb AS DOUBLE)) / NULLIF(SUM((UNIX_TIMESTAMP(processing_end_timestamp) - UNIX_TIMESTAMP(processing_start_timestamp)) / 3600.0), 0)
      comment: "Transcoding throughput measured as gigabytes processed per hour"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_qc_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality control inspection results and defect metrics tracking media quality assurance effectiveness"
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the QC inspection"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status after QC inspection (e.g., approved, rejected, conditional)"
    - name: "overall_result"
      expr: overall_result
      comment: "Overall result of the QC inspection"
    - name: "qc_type"
      expr: qc_type
      comment: "Type of QC inspection performed (e.g., automated, manual, hybrid)"
    - name: "qc_tool_name"
      expr: qc_tool_name
      comment: "Name of the QC tool or system used"
    - name: "video_codec_compliance_result"
      expr: video_codec_compliance_result
      comment: "Result of video codec compliance check"
    - name: "audio_codec_compliance_result"
      expr: audio_codec_compliance_result
      comment: "Result of audio codec compliance check"
    - name: "loudness_compliance_result"
      expr: loudness_compliance_result
      comment: "Result of loudness compliance check"
    - name: "black_frame_detected"
      expr: black_frame_detected
      comment: "Whether black frames were detected during inspection"
    - name: "freeze_frame_detected"
      expr: freeze_frame_detected
      comment: "Whether freeze frames were detected during inspection"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_timestamp)
      comment: "Month when the QC inspection was performed"
  measures:
    - name: "total_qc_inspections"
      expr: COUNT(1)
      comment: "Total number of QC inspections performed"
    - name: "approved_inspections"
      expr: SUM(CASE WHEN approval_status = 'approved' THEN 1 ELSE 0 END)
      comment: "Count of inspections that were approved"
    - name: "rejected_inspections"
      expr: SUM(CASE WHEN approval_status = 'rejected' THEN 1 ELSE 0 END)
      comment: "Count of inspections that were rejected"
    - name: "avg_loudness_lufs"
      expr: AVG(CAST(loudness_lufs AS DOUBLE))
      comment: "Average loudness measurement in LUFS across inspections"
    - name: "inspections_with_black_frames"
      expr: SUM(CASE WHEN black_frame_detected = TRUE THEN 1 ELSE 0 END)
      comment: "Count of inspections where black frames were detected"
    - name: "inspections_with_freeze_frames"
      expr: SUM(CASE WHEN freeze_frame_detected = TRUE THEN 1 ELSE 0 END)
      comment: "Count of inspections where freeze frames were detected"
    - name: "first_pass_approval_rate_pct"
      expr: SUM(CASE WHEN approval_status = 'approved' THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(1), 0)
      comment: "Percentage of inspections approved on first pass"
    - name: "rejection_rate_pct"
      expr: SUM(CASE WHEN approval_status = 'rejected' THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(1), 0)
      comment: "Percentage of inspections that were rejected"
    - name: "defect_detection_rate_pct"
      expr: SUM(CASE WHEN black_frame_detected = TRUE OR freeze_frame_detected = TRUE THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(1), 0)
      comment: "Percentage of inspections where defects were detected"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_archive_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Archive operations and long-term preservation metrics tracking archival efficiency and compliance"
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`archive_record`"
  dimensions:
    - name: "archive_status"
      expr: archive_status
      comment: "Current status of the archive record (e.g., archived, restoring, restored)"
    - name: "archive_destination_type"
      expr: archive_destination_type
      comment: "Type of archive destination (e.g., tape, cloud vault, optical)"
    - name: "archive_system_name"
      expr: archive_system_name
      comment: "Name of the archive system used"
    - name: "archive_format"
      expr: archive_format
      comment: "Format used for archiving the media"
    - name: "storage_tier"
      expr: storage_tier
      comment: "Storage tier of the archive"
    - name: "retention_policy_code"
      expr: retention_policy_code
      comment: "Retention policy governing the archived asset"
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Whether the archived asset is under legal hold"
    - name: "oais_compliance_flag"
      expr: oais_compliance_flag
      comment: "Whether the archive is OAIS (Open Archival Information System) compliant"
    - name: "restore_sla_tier"
      expr: restore_sla_tier
      comment: "SLA tier for restore operations"
    - name: "restore_test_result"
      expr: restore_test_result
      comment: "Result of the most recent restore test"
    - name: "archive_year"
      expr: YEAR(archive_date)
      comment: "Year the asset was archived"
    - name: "archive_month"
      expr: DATE_TRUNC('MONTH', archive_date)
      comment: "Month the asset was archived"
  measures:
    - name: "total_archive_records"
      expr: COUNT(1)
      comment: "Total number of archive records"
    - name: "total_archived_bytes"
      expr: SUM(CAST(archive_file_size_bytes AS DOUBLE))
      comment: "Total volume of archived data in bytes"
    - name: "total_archived_tb"
      expr: SUM(CAST(archive_file_size_bytes AS DOUBLE)) / 1099511627776.0
      comment: "Total volume of archived data in terabytes"
    - name: "avg_archive_file_size_gb"
      expr: AVG(CAST(archive_file_size_bytes AS DOUBLE)) / 1073741824.0
      comment: "Average archive file size in gigabytes"
    - name: "total_archive_cost"
      expr: SUM(CAST(archive_file_size_bytes AS DOUBLE) / 1073741824.0 * CAST(archive_cost_per_gb AS DOUBLE))
      comment: "Total cost of archived storage based on volume and per-GB pricing"
    - name: "avg_archive_cost_per_gb"
      expr: AVG(CAST(archive_cost_per_gb AS DOUBLE))
      comment: "Average archive cost per gigabyte"
    - name: "assets_under_legal_hold"
      expr: SUM(CASE WHEN legal_hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of archived assets under legal hold"
    - name: "oais_compliant_archives"
      expr: SUM(CASE WHEN oais_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of archives that are OAIS compliant"
    - name: "avg_restore_duration_days"
      expr: AVG(DATEDIFF(restore_completion_date, restore_request_date))
      comment: "Average duration from restore request to completion in days"
    - name: "restore_test_success_rate_pct"
      expr: SUM(CASE WHEN restore_test_result = 'success' THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(1), 0)
      comment: "Percentage of restore tests that were successful"
$$;