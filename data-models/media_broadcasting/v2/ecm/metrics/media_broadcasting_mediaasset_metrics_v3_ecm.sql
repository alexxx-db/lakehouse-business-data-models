-- Metric views for domain: mediaasset | Business: Media_Broadcasting | Version: 3 | Generated on: 2026-07-10 19:06:42

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_media_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core KPIs for the media asset catalog — storage footprint, duration inventory, and asset lifecycle health. Used by asset management, engineering, and finance to govern storage costs and content availability."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Classifies the asset (e.g. video, audio, image, document) for segmented analysis of storage and duration by type."
    - name: "asset_class"
      expr: asset_class
      comment: "Business classification of the asset (e.g. master, proxy, archive) enabling tier-level cost and quality analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle state of the asset (e.g. active, archived, purged) for operational health monitoring."
    - name: "storage_tier"
      expr: storage_tier
      comment: "Storage tier (e.g. hot, warm, cold, glacier) for cost allocation and tiering strategy decisions."
    - name: "content_classification"
      expr: content_classification
      comment: "Content sensitivity or rights classification enabling compliance-aware reporting."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Indicates whether the asset is under legal hold, critical for compliance and purge-eligibility analysis."
    - name: "file_format"
      expr: file_format
      comment: "Container/file format of the asset (e.g. MXF, MP4, MOV) for format migration planning."
    - name: "hdr_format"
      expr: hdr_format
      comment: "HDR format of the asset (e.g. HDR10, Dolby Vision) for premium content inventory tracking."
  measures:
    - name: "total_asset_count"
      expr: COUNT(1)
      comment: "Total number of media assets in the catalog. Baseline KPI for inventory size and growth tracking."
    - name: "total_storage_tb"
      expr: ROUND(SUM(CAST(file_size_bytes AS DOUBLE)) / NULLIF(1099511627776.0, 0), 4)
      comment: "Total storage consumed by all media assets in terabytes. Drives infrastructure capacity planning and storage cost forecasting."
    - name: "avg_asset_duration_seconds"
      expr: ROUND(AVG(CAST(duration_seconds AS DOUBLE)), 2)
      comment: "Average duration of media assets in seconds. Indicates content depth and informs transcoding and delivery cost estimates."
    - name: "total_content_hours"
      expr: ROUND(SUM(CAST(duration_seconds AS DOUBLE)) / NULLIF(3600.0, 0), 2)
      comment: "Total content hours across all media assets. Strategic KPI for content library depth and licensing valuation."
    - name: "legal_hold_asset_count"
      expr: COUNT(CASE WHEN legal_hold_flag = TRUE THEN 1 END)
      comment: "Number of assets currently under legal hold. Compliance KPI — elevated counts signal legal risk exposure and block purge workflows."
    - name: "avg_bitrate_mbps"
      expr: ROUND(AVG(CAST(bit_rate_mbps AS DOUBLE)), 4)
      comment: "Average bitrate across all media assets in Mbps. Informs transcoding profiles and delivery bandwidth planning."
    - name: "total_audio_sample_rate_khz_sum"
      expr: ROUND(SUM(CAST(audio_sample_rate_khz AS DOUBLE)), 2)
      comment: "Aggregate audio sample rate across assets — used as a proxy for audio quality inventory volume in format migration planning."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_transcode_job`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for transcoding pipeline performance. Used by engineering, post-production, and finance to monitor throughput, cost efficiency, and failure rates."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job`"
  dimensions:
    - name: "job_status"
      expr: job_status
      comment: "Current status of the transcode job (e.g. queued, running, completed, failed) for pipeline health monitoring."
    - name: "job_type"
      expr: job_type
      comment: "Type of transcode operation (e.g. proxy, mezzanine, delivery) for workload segmentation."
    - name: "job_priority"
      expr: job_priority
      comment: "Priority level of the transcode job for SLA compliance and queue management analysis."
    - name: "transcoding_engine"
      expr: transcoding_engine
      comment: "Transcoding engine or platform used (e.g. Elemental, FFmpeg) for vendor performance benchmarking."
    - name: "source_format"
      expr: source_format
      comment: "Source file format of the input asset for format-level throughput and failure analysis."
    - name: "quality_validation_result"
      expr: quality_validation_result
      comment: "Outcome of post-transcode quality validation (e.g. pass, fail, warning) for quality assurance tracking."
    - name: "migration_reason"
      expr: migration_reason
      comment: "Business reason driving the transcode (e.g. format migration, delivery, archive) for demand attribution."
  measures:
    - name: "total_transcode_jobs"
      expr: COUNT(1)
      comment: "Total number of transcode jobs submitted. Baseline throughput KPI for pipeline capacity planning."
    - name: "failed_job_count"
      expr: COUNT(CASE WHEN job_status = 'failed' THEN 1 END)
      comment: "Number of transcode jobs that failed. Operational risk KPI — high failure rates indicate pipeline instability or format incompatibilities."
    - name: "transcode_failure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN job_status = 'failed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transcode jobs that failed. Key quality KPI for SLA compliance and engineering escalation triggers."
    - name: "total_estimated_cost_usd"
      expr: ROUND(SUM(CAST(cost_estimate_usd AS DOUBLE)), 2)
      comment: "Total estimated cost of all transcode jobs in USD. Financial KPI for budget tracking and vendor cost management."
    - name: "avg_estimated_cost_usd"
      expr: ROUND(AVG(CAST(cost_estimate_usd AS DOUBLE)), 4)
      comment: "Average cost per transcode job in USD. Efficiency KPI for benchmarking transcoding cost per asset."
    - name: "total_output_file_size_gb"
      expr: ROUND(SUM(CAST(output_file_size_gb AS DOUBLE)), 2)
      comment: "Total output storage generated by transcode jobs in GB. Drives storage provisioning and capacity forecasting."
    - name: "avg_quality_validation_score"
      expr: ROUND(AVG(CAST(quality_validation_score AS DOUBLE)), 4)
      comment: "Average quality validation score across completed transcode jobs. Quality KPI — declining scores trigger pipeline review and codec parameter tuning."
    - name: "avg_source_bitrate_mbps"
      expr: ROUND(AVG(CAST(source_bitrate_mbps AS DOUBLE)), 4)
      comment: "Average source bitrate of assets entering the transcode pipeline in Mbps. Informs codec selection and output profile optimization."
    - name: "total_source_file_size_gb"
      expr: ROUND(SUM(CAST(source_file_size_gb AS DOUBLE)), 2)
      comment: "Total source file volume ingested into the transcode pipeline in GB. Capacity and throughput planning KPI."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_ingest_job`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for media ingest pipeline performance — throughput, transfer efficiency, and failure rates. Used by operations and engineering to ensure reliable content onboarding."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job`"
  dimensions:
    - name: "job_status"
      expr: job_status
      comment: "Current status of the ingest job (e.g. completed, failed, in-progress) for pipeline health monitoring."
    - name: "ingest_source_type"
      expr: ingest_source_type
      comment: "Source type of the ingest (e.g. satellite, FTP, cloud, tape) for channel-level throughput and failure analysis."
    - name: "content_type"
      expr: content_type
      comment: "Type of content being ingested (e.g. episode, promo, ad) for workload segmentation."
    - name: "source_format"
      expr: source_format
      comment: "Source file format of the ingested content for format compatibility and migration planning."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the ingest job for SLA compliance and queue management."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Indicates whether the ingested asset is under legal hold, affecting downstream processing eligibility."
    - name: "closed_caption_present"
      expr: closed_caption_present
      comment: "Whether closed captions were present in the ingested asset — compliance KPI for accessibility mandates."
  measures:
    - name: "total_ingest_jobs"
      expr: COUNT(1)
      comment: "Total number of ingest jobs executed. Baseline throughput KPI for content onboarding volume."
    - name: "failed_ingest_count"
      expr: COUNT(CASE WHEN job_status = 'failed' THEN 1 END)
      comment: "Number of ingest jobs that failed. Operational risk KPI — high counts indicate source delivery or format issues."
    - name: "ingest_failure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN job_status = 'failed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ingest jobs that failed. SLA compliance KPI — triggers engineering escalation when above threshold."
    - name: "total_bytes_transferred"
      expr: SUM(CAST(bytes_transferred AS DOUBLE))
      comment: "Total bytes transferred across all ingest jobs. Network throughput and capacity planning KPI."
    - name: "avg_transfer_rate_mbps"
      expr: ROUND(AVG(CAST(transfer_rate_mbps AS DOUBLE)), 4)
      comment: "Average transfer rate in Mbps across ingest jobs. Informs network infrastructure investment and SLA benchmarking."
    - name: "avg_duration_seconds"
      expr: ROUND(AVG(CAST(duration_seconds AS DOUBLE)), 2)
      comment: "Average duration of ingested content in seconds. Content depth KPI for library planning."
    - name: "closed_caption_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN closed_caption_present = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ingested assets that include closed captions. Regulatory compliance KPI for accessibility mandates (FCC, ADA)."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_qc_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality control KPIs for media asset inspections — pass rates, defect density, and loudness compliance. Used by QC supervisors and post-production leadership to maintain broadcast-ready quality standards."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the QC inspection (e.g. pending, completed, failed) for workflow tracking."
    - name: "overall_result"
      expr: overall_result
      comment: "Overall QC outcome (e.g. pass, fail, conditional pass) — primary quality gate KPI dimension."
    - name: "qc_type"
      expr: qc_type
      comment: "Type of QC inspection (e.g. automated, manual, compliance) for process-level quality analysis."
    - name: "qc_tool_name"
      expr: qc_tool_name
      comment: "QC tool or platform used (e.g. Cerify, Baton, Vidchecker) for vendor performance benchmarking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the inspection result for release gate tracking."
    - name: "hdr_format"
      expr: hdr_format
      comment: "HDR format detected during inspection for premium content quality segmentation."
    - name: "black_frame_detected"
      expr: black_frame_detected
      comment: "Whether black frames were detected during inspection — broadcast quality compliance indicator."
    - name: "freeze_frame_detected"
      expr: freeze_frame_detected
      comment: "Whether freeze frames were detected during inspection — broadcast quality compliance indicator."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of QC inspections performed. Baseline throughput KPI for QC pipeline capacity."
    - name: "qc_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_result = 'pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of QC inspections that passed. Primary quality KPI — declining pass rates trigger post-production review and vendor escalation."
    - name: "avg_loudness_lufs"
      expr: ROUND(AVG(CAST(loudness_lufs AS DOUBLE)), 4)
      comment: "Average measured loudness in LUFS across inspected assets. Broadcast compliance KPI — must align with ATSC A/85 and EBU R128 standards."
    - name: "black_frame_detection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN black_frame_detected = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections where black frames were detected. Broadcast quality KPI — high rates indicate upstream production or ingest defects."
    - name: "freeze_frame_detection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN freeze_frame_detected = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections where freeze frames were detected. Broadcast quality KPI — triggers re-ingest or re-encode workflows."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_archive_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for media asset archival operations — storage cost, retention compliance, and restore readiness. Used by archive operations, finance, and legal to govern long-term asset preservation costs and compliance."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`archive_record`"
  dimensions:
    - name: "archive_status"
      expr: archive_status
      comment: "Current status of the archive record (e.g. active, pending, restored, purged) for operational health monitoring."
    - name: "archive_destination_type"
      expr: archive_destination_type
      comment: "Type of archive destination (e.g. LTO tape, cloud vault, nearline) for cost and recovery time analysis."
    - name: "storage_tier"
      expr: storage_tier
      comment: "Storage tier of the archived asset for cost allocation and tiering strategy decisions."
    - name: "archive_format"
      expr: archive_format
      comment: "File format used for archival for format migration planning and compatibility tracking."
    - name: "restore_sla_tier"
      expr: restore_sla_tier
      comment: "SLA tier for restore operations (e.g. same-day, 48h, 7-day) for recovery readiness analysis."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Indicates whether the archived asset is under legal hold — affects purge eligibility and retention override."
    - name: "purge_approval_status"
      expr: purge_approval_status
      comment: "Approval status for scheduled purge operations — compliance gate for retention policy enforcement."
    - name: "oais_compliance_flag"
      expr: oais_compliance_flag
      comment: "Whether the archive record meets OAIS (Open Archival Information System) compliance standards."
  measures:
    - name: "total_archive_records"
      expr: COUNT(1)
      comment: "Total number of archive records. Baseline KPI for archive inventory size and growth."
    - name: "total_archive_file_size_tb"
      expr: ROUND(SUM(CAST(archive_file_size_bytes AS DOUBLE)) / NULLIF(1099511627776.0, 0), 4)
      comment: "Total archived storage volume in terabytes. Primary cost driver KPI for archive infrastructure and vendor contracts."
    - name: "total_archive_cost"
      expr: ROUND(SUM(CAST(archive_cost_per_gb AS DOUBLE) * CAST(archive_file_size_bytes AS DOUBLE) / NULLIF(1073741824.0, 0)), 2)
      comment: "Total estimated archive storage cost (cost_per_gb × file_size_gb). Financial KPI for archive budget management and vendor negotiation."
    - name: "avg_archive_cost_per_gb"
      expr: ROUND(AVG(CAST(archive_cost_per_gb AS DOUBLE)), 4)
      comment: "Average archive cost per GB across all archive records. Vendor benchmarking and cost efficiency KPI."
    - name: "legal_hold_archive_count"
      expr: COUNT(CASE WHEN legal_hold_flag = TRUE THEN 1 END)
      comment: "Number of archived assets under legal hold. Compliance KPI — these assets cannot be purged and represent locked storage cost."
    - name: "oais_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN oais_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of archive records meeting OAIS compliance standards. Governance KPI for long-term preservation quality."
    - name: "restore_test_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN restore_test_result = 'pass' THEN 1 END) / NULLIF(COUNT(CASE WHEN restore_test_result IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of restore tests that passed. Disaster recovery KPI — low rates indicate archive integrity risk and trigger remediation."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_storage_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for storage infrastructure capacity, utilization, and cost efficiency. Used by infrastructure engineering and finance to govern storage provisioning, cost per TB, and capacity headroom."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`storage_location`"
  dimensions:
    - name: "storage_type"
      expr: storage_type
      comment: "Type of storage system (e.g. SAN, NAS, object, tape) for infrastructure segmentation."
    - name: "storage_tier"
      expr: storage_tier
      comment: "Storage tier (e.g. hot, warm, cold) for cost and performance tier analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the storage location (e.g. active, decommissioned, maintenance) for availability tracking."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the storage location for geo-distributed capacity planning and data sovereignty compliance."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier of the storage location for recovery time objective (RTO) compliance analysis."
    - name: "encryption_enabled"
      expr: encryption_enabled
      comment: "Whether encryption is enabled on the storage location — security compliance KPI."
    - name: "replication_enabled"
      expr: replication_enabled
      comment: "Whether replication is enabled — resilience and disaster recovery readiness indicator."
    - name: "legal_hold_capable"
      expr: legal_hold_capable
      comment: "Whether the storage location supports legal hold operations — compliance infrastructure readiness KPI."
  measures:
    - name: "total_provisioned_capacity_tb"
      expr: ROUND(SUM(CAST(total_capacity_tb AS DOUBLE)), 2)
      comment: "Total provisioned storage capacity in TB across all locations. Infrastructure capacity planning KPI."
    - name: "total_used_capacity_tb"
      expr: ROUND(SUM(CAST(used_capacity_tb AS DOUBLE)), 2)
      comment: "Total used storage capacity in TB. Drives capacity expansion decisions and storage cost forecasting."
    - name: "total_available_capacity_tb"
      expr: ROUND(SUM(CAST(available_capacity_tb AS DOUBLE)), 2)
      comment: "Total available (unused) storage capacity in TB. Headroom KPI — low values trigger procurement and provisioning actions."
    - name: "avg_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(used_capacity_tb AS DOUBLE)) / NULLIF(SUM(CAST(total_capacity_tb AS DOUBLE)), 0), 2)
      comment: "Average storage utilization percentage across all locations. Primary infrastructure efficiency KPI — high utilization triggers capacity expansion."
    - name: "avg_cost_per_tb_per_month"
      expr: ROUND(AVG(CAST(cost_per_tb_per_month AS DOUBLE)), 4)
      comment: "Average storage cost per TB per month. Financial efficiency KPI for vendor benchmarking and tier optimization."
    - name: "avg_restore_time_objective_hours"
      expr: ROUND(AVG(CAST(restore_time_objective_hours AS DOUBLE)), 2)
      comment: "Average restore time objective in hours across storage locations. Disaster recovery readiness KPI — high values indicate recovery risk."
    - name: "encryption_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN encryption_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of storage locations with encryption enabled. Security compliance KPI — gaps trigger remediation for data protection mandates."
    - name: "replication_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN replication_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of storage locations with replication enabled. Resilience KPI — low coverage indicates single-point-of-failure risk."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_format_migration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for format migration operations — success rates, quality outcomes, and storage efficiency gains. Used by post-production and engineering leadership to govern format modernization programs."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`format_migration`"
  dimensions:
    - name: "migration_status"
      expr: migration_status
      comment: "Current status of the format migration (e.g. completed, failed, in-progress) for pipeline health monitoring."
    - name: "migration_type"
      expr: migration_type
      comment: "Type of migration (e.g. codec upgrade, container change, resolution upscale) for program-level analysis."
    - name: "migration_reason"
      expr: migration_reason
      comment: "Business reason driving the migration (e.g. archive, delivery, compliance) for demand attribution."
    - name: "migration_priority"
      expr: migration_priority
      comment: "Priority level of the migration job for SLA compliance and queue management."
    - name: "quality_validation_result"
      expr: quality_validation_result
      comment: "Outcome of post-migration quality validation (e.g. pass, fail) for quality assurance tracking."
    - name: "target_format"
      expr: target_format
      comment: "Target format of the migration (e.g. H.265, ProRes) for format adoption tracking."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Whether the asset being migrated is under legal hold — affects migration eligibility and compliance."
  measures:
    - name: "total_migrations"
      expr: COUNT(1)
      comment: "Total number of format migration jobs. Baseline throughput KPI for migration program scale."
    - name: "migration_success_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN migration_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of format migrations that completed successfully. Primary program health KPI — low rates trigger engineering review."
    - name: "avg_migration_duration_seconds"
      expr: ROUND(AVG(CAST(migration_duration_seconds AS DOUBLE)), 2)
      comment: "Average duration of format migration jobs in seconds. Throughput efficiency KPI for pipeline optimization."
    - name: "total_source_file_size_tb"
      expr: ROUND(SUM(CAST(source_file_size_bytes AS DOUBLE)) / NULLIF(1099511627776.0, 0), 4)
      comment: "Total source file volume processed by migrations in TB. Scale KPI for migration program capacity planning."
    - name: "total_target_file_size_tb"
      expr: ROUND(SUM(CAST(target_file_size_bytes AS DOUBLE)) / NULLIF(1099511627776.0, 0), 4)
      comment: "Total target file volume produced by migrations in TB. Storage impact KPI for post-migration capacity planning."
    - name: "storage_compression_ratio"
      expr: ROUND(SUM(CAST(source_file_size_bytes AS DOUBLE)) / NULLIF(SUM(CAST(target_file_size_bytes AS DOUBLE)), 0), 4)
      comment: "Ratio of source to target file size across migrations. Efficiency KPI — values above 1.0 indicate storage savings from format modernization."
    - name: "avg_quality_validation_score"
      expr: ROUND(AVG(CAST(quality_validation_score AS DOUBLE)), 4)
      comment: "Average quality validation score post-migration. Quality assurance KPI — declining scores indicate codec parameter or pipeline issues."
    - name: "avg_target_bitrate_kbps"
      expr: ROUND(AVG(CAST(target_bitrate_kbps AS DOUBLE)), 2)
      comment: "Average target bitrate of migrated assets in Kbps. Delivery optimization KPI for bandwidth and streaming cost management."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_asset_storage_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for asset-to-storage assignment efficiency, cost, and compliance. Used by storage operations and finance to optimize storage tier placement and track assignment lifecycle."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the storage assignment (e.g. active, expired, migrated) for lifecycle tracking."
    - name: "storage_tier"
      expr: storage_tier
      comment: "Storage tier of the assignment (e.g. hot, warm, cold) for cost allocation and tiering optimization."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the storage assignment for data sovereignty and latency analysis."
    - name: "access_frequency"
      expr: access_frequency
      comment: "Access frequency pattern of the assigned asset (e.g. frequent, infrequent, archive) for tier optimization."
    - name: "migration_trigger"
      expr: migration_trigger
      comment: "Reason the assignment was migrated (e.g. cost, compliance, expiry) for demand attribution."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Whether the assigned asset is under legal hold — affects migration eligibility and purge blocking."
    - name: "verification_status"
      expr: verification_status
      comment: "Checksum verification status of the storage assignment for data integrity compliance."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of asset storage assignments. Baseline KPI for storage placement inventory."
    - name: "total_assigned_file_size_tb"
      expr: ROUND(SUM(CAST(file_size_bytes AS DOUBLE)) / NULLIF(1099511627776.0, 0), 4)
      comment: "Total file size of all assigned assets in TB. Storage demand KPI for capacity planning."
    - name: "avg_storage_cost_per_gb"
      expr: ROUND(AVG(CAST(storage_cost_per_gb AS DOUBLE)), 4)
      comment: "Average storage cost per GB across all assignments. Financial efficiency KPI for tier optimization and vendor benchmarking."
    - name: "total_estimated_storage_cost"
      expr: ROUND(SUM(CAST(storage_cost_per_gb AS DOUBLE) * CAST(file_size_bytes AS DOUBLE) / NULLIF(1073741824.0, 0)), 2)
      comment: "Total estimated storage cost across all assignments (cost_per_gb × file_size_gb). Financial KPI for storage budget management."
    - name: "legal_hold_assignment_count"
      expr: COUNT(CASE WHEN legal_hold_flag = TRUE THEN 1 END)
      comment: "Number of storage assignments under legal hold. Compliance KPI — these cannot be migrated or purged, representing locked storage cost."
    - name: "verification_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'verified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of storage assignments with verified checksums. Data integrity KPI — low rates indicate storage corruption risk."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_asset_access_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for media asset access governance — request volumes, approval rates, DRM coverage, and rights clearance compliance. Used by rights management, legal, and operations to govern asset access workflows."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`asset_access_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Current status of the access request (e.g. pending, approved, rejected, expired) for workflow tracking."
    - name: "access_type"
      expr: access_type
      comment: "Type of access requested (e.g. download, stream, preview) for usage pattern analysis."
    - name: "access_purpose"
      expr: access_purpose
      comment: "Business purpose of the access request (e.g. editorial, delivery, review) for demand attribution."
    - name: "compliance_classification"
      expr: compliance_classification
      comment: "Compliance classification of the requested asset for rights and regulatory access control analysis."
    - name: "drm_applied"
      expr: drm_applied
      comment: "Whether DRM was applied to the accessed asset — security compliance KPI."
    - name: "rights_clearance_required"
      expr: rights_clearance_required
      comment: "Whether rights clearance was required for the access request — rights governance indicator."
    - name: "rights_clearance_status"
      expr: rights_clearance_status
      comment: "Status of rights clearance for the access request (e.g. cleared, pending, denied) for rights compliance tracking."
    - name: "watermark_applied"
      expr: watermark_applied
      comment: "Whether a watermark was applied to the accessed asset — content security and leak prevention KPI."
  measures:
    - name: "total_access_requests"
      expr: COUNT(1)
      comment: "Total number of asset access requests. Baseline demand KPI for access governance and capacity planning."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN request_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of access requests that were approved. Governance efficiency KPI — very low rates may indicate overly restrictive policies."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN request_status = 'rejected' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of access requests that were rejected. Rights compliance KPI — high rates indicate access policy friction or rights gaps."
    - name: "drm_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN drm_applied = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of approved access requests where DRM was applied. Content security KPI — gaps indicate unprotected asset distribution risk."
    - name: "rights_clearance_pending_count"
      expr: COUNT(CASE WHEN rights_clearance_required = TRUE AND rights_clearance_status = 'pending' THEN 1 END)
      comment: "Number of access requests awaiting rights clearance. Operational bottleneck KPI — high counts delay content delivery and monetization."
    - name: "watermark_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN watermark_applied = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of access requests where watermarking was applied. Content security KPI for leak prevention and forensic traceability."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_legal_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for legal hold governance — active hold counts, acknowledgment compliance, and hold lifecycle management. Used by legal, compliance, and records management to ensure chain-of-custody integrity."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the legal hold (e.g. active, released, expired) for compliance lifecycle tracking."
    - name: "hold_type"
      expr: hold_type
      comment: "Type of legal hold (e.g. litigation, regulatory, investigation) for legal risk categorization."
    - name: "hold_priority"
      expr: hold_priority
      comment: "Priority level of the legal hold for escalation and resource allocation decisions."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the legal hold (e.g. court, regulator, internal legal) for jurisdiction analysis."
    - name: "acknowledgment_required"
      expr: acknowledgment_required
      comment: "Whether custodian acknowledgment is required — compliance gate for hold validity."
    - name: "audit_trail_required"
      expr: audit_trail_required
      comment: "Whether an audit trail is required for the hold — governance and evidentiary integrity indicator."
    - name: "mam_system_lock_enabled"
      expr: mam_system_lock_enabled
      comment: "Whether the MAM system lock is enabled for the hold — technical enforcement KPI."
    - name: "retention_override_flag"
      expr: retention_override_flag
      comment: "Whether the hold overrides standard retention policy — compliance risk indicator for retention governance."
  measures:
    - name: "total_legal_holds"
      expr: COUNT(1)
      comment: "Total number of legal holds. Baseline KPI for legal risk exposure and compliance workload."
    - name: "active_hold_count"
      expr: COUNT(CASE WHEN hold_status = 'active' THEN 1 END)
      comment: "Number of currently active legal holds. Primary legal risk KPI — high counts indicate elevated litigation or regulatory exposure."
    - name: "acknowledgment_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN acknowledgment_required = FALSE OR (acknowledgment_required = TRUE AND mam_system_lock_enabled = TRUE) THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Proxy rate for holds where acknowledgment requirements are met (either not required or MAM lock is active). Compliance governance KPI."
    - name: "mam_lock_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mam_system_lock_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of legal holds with MAM system lock enabled. Technical enforcement KPI — gaps indicate assets may be accessible despite hold."
    - name: "retention_override_count"
      expr: COUNT(CASE WHEN retention_override_flag = TRUE THEN 1 END)
      comment: "Number of legal holds that override standard retention policy. Compliance risk KPI — each override requires legal justification and audit trail."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_retention_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for retention policy governance — policy coverage, lifecycle status, and compliance posture. Used by records management, legal, and compliance to ensure retention obligations are met."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy`"
  dimensions:
    - name: "policy_status"
      expr: policy_status
      comment: "Current status of the retention policy (e.g. active, superseded, expired) for governance lifecycle tracking."
    - name: "asset_class_scope"
      expr: asset_class_scope
      comment: "Asset class covered by the policy (e.g. master, proxy, archive) for coverage analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the retention policy for data sovereignty and regulatory jurisdiction analysis."
    - name: "post_retention_action"
      expr: post_retention_action
      comment: "Action taken after retention period expires (e.g. purge, archive, review) for compliance workflow planning."
    - name: "applies_to_legal_hold"
      expr: applies_to_legal_hold
      comment: "Whether the policy applies to assets under legal hold — critical compliance interaction indicator."
    - name: "applies_to_syndication_content"
      expr: applies_to_syndication_content
      comment: "Whether the policy applies to syndicated content — rights and distribution compliance indicator."
    - name: "format_migration_allowed"
      expr: format_migration_allowed
      comment: "Whether format migration is permitted under this policy — operational flexibility indicator."
    - name: "audit_trail_required"
      expr: audit_trail_required
      comment: "Whether an audit trail is required for policy actions — governance rigor indicator."
  measures:
    - name: "total_retention_policies"
      expr: COUNT(1)
      comment: "Total number of retention policies. Baseline KPI for policy inventory and governance coverage."
    - name: "active_policy_count"
      expr: COUNT(CASE WHEN policy_status = 'active' THEN 1 END)
      comment: "Number of currently active retention policies. Governance KPI — ensures adequate policy coverage across asset classes."
    - name: "legal_hold_compatible_policy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN applies_to_legal_hold = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of retention policies that apply to legal hold assets. Compliance coverage KPI — gaps indicate legal hold assets may lack retention governance."
    - name: "audit_trail_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN audit_trail_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of retention policies requiring audit trails. Governance rigor KPI for regulatory compliance posture."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_asset_collection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for media asset collection management — collection size, storage footprint, rights clearance, and metadata quality. Used by content operations and distribution teams to govern collection readiness for syndication and delivery."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection`"
  dimensions:
    - name: "asset_collection_status"
      expr: asset_collection_status
      comment: "Current status of the asset collection (e.g. active, archived, draft) for lifecycle tracking."
    - name: "collection_type"
      expr: collection_type
      comment: "Type of collection (e.g. series, season, campaign, anthology) for content portfolio segmentation."
    - name: "rights_clearance_status"
      expr: rights_clearance_status
      comment: "Rights clearance status of the collection for distribution eligibility analysis."
    - name: "qc_status"
      expr: qc_status
      comment: "QC status of the collection for broadcast readiness tracking."
    - name: "syndication_eligible_flag"
      expr: syndication_eligible_flag
      comment: "Whether the collection is eligible for syndication — revenue opportunity KPI."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Whether the collection is under legal hold — compliance and distribution block indicator."
    - name: "primary_genre"
      expr: primary_genre
      comment: "Primary genre of the collection for content portfolio and audience targeting analysis."
    - name: "language_code"
      expr: language_code
      comment: "Language of the collection for localization and international distribution planning."
  measures:
    - name: "total_collections"
      expr: COUNT(1)
      comment: "Total number of asset collections. Baseline KPI for content portfolio inventory."
    - name: "total_storage_size_tb"
      expr: ROUND(SUM(CAST(total_storage_size_bytes AS DOUBLE)) / NULLIF(1099511627776.0, 0), 4)
      comment: "Total storage consumed by all asset collections in TB. Infrastructure cost KPI for collection-level storage management."
    - name: "total_content_hours"
      expr: ROUND(SUM(CAST(total_duration_seconds AS DOUBLE)) / NULLIF(3600.0, 0), 2)
      comment: "Total content hours across all collections. Content library depth KPI for licensing and distribution valuation."
    - name: "avg_metadata_completeness_score"
      expr: ROUND(AVG(CAST(metadata_completeness_score AS DOUBLE)), 4)
      comment: "Average metadata completeness score across collections. Data quality KPI — low scores impair discoverability, search, and distribution workflows."
    - name: "syndication_eligible_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN syndication_eligible_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of collections eligible for syndication. Revenue opportunity KPI — directly linked to syndication deal pipeline."
    - name: "rights_cleared_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rights_clearance_status = 'cleared' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of collections with cleared rights. Distribution readiness KPI — uncleared collections cannot be monetized."
    - name: "closed_caption_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN closed_caption_available_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of collections with closed captions available. Accessibility compliance KPI for FCC and ADA mandates."
$$;