-- Metric views for domain: sequencing | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 15:25:46

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`sequencing_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core sequencing run performance and quality metrics for operational and strategic decision-making"
  source: "`genomics_biotech_ecm`.`sequencing`.`sequencing_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Current status of the sequencing run (e.g., completed, failed, in-progress)"
    - name: "qc_status"
      expr: qc_status
      comment: "Quality control status indicating pass/fail/pending"
    - name: "run_type"
      expr: run_type
      comment: "Type of sequencing run (e.g., production, validation, research)"
    - name: "run_mode"
      expr: run_mode
      comment: "Sequencing run mode configuration"
    - name: "flow_cell_type"
      expr: flow_cell_type
      comment: "Type of flow cell used in the run"
    - name: "is_paired_end"
      expr: is_paired_end
      comment: "Whether the run uses paired-end sequencing"
    - name: "data_retention_category"
      expr: data_retention_category
      comment: "Data retention classification for compliance and storage management"
    - name: "demultiplexing_status"
      expr: demultiplexing_status
      comment: "Status of sample demultiplexing process"
    - name: "run_start_date"
      expr: DATE_TRUNC('day', start_timestamp)
      comment: "Date the sequencing run started"
    - name: "run_start_month"
      expr: DATE_TRUNC('month', start_timestamp)
      comment: "Month the sequencing run started"
    - name: "run_end_date"
      expr: DATE_TRUNC('day', end_timestamp)
      comment: "Date the sequencing run completed"
  measures:
    - name: "total_sequencing_runs"
      expr: COUNT(1)
      comment: "Total number of sequencing runs executed"
    - name: "total_output_yield_gb"
      expr: SUM(CAST(output_yield_gb AS DOUBLE))
      comment: "Total sequencing output in gigabases across all runs"
    - name: "avg_output_yield_gb"
      expr: AVG(CAST(output_yield_gb AS DOUBLE))
      comment: "Average sequencing output per run in gigabases"
    - name: "avg_cluster_density"
      expr: AVG(CAST(cluster_density AS DOUBLE))
      comment: "Average cluster density across runs (K/mm²)"
    - name: "avg_cluster_pf_pct"
      expr: AVG(CAST(cluster_pf_pct AS DOUBLE))
      comment: "Average percentage of clusters passing filter"
    - name: "avg_q30_pct"
      expr: AVG(CAST(q30_pct AS DOUBLE))
      comment: "Average percentage of bases with quality score ≥30"
    - name: "avg_error_rate_pct"
      expr: AVG(CAST(error_rate_pct AS DOUBLE))
      comment: "Average sequencing error rate percentage"
    - name: "avg_phix_spike_in_pct"
      expr: AVG(CAST(phix_spike_in_pct AS DOUBLE))
      comment: "Average PhiX control spike-in percentage for quality monitoring"
    - name: "qc_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN qc_status = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sequencing runs passing quality control"
    - name: "run_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN run_status = 'Completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sequencing runs successfully completed"
    - name: "distinct_instruments"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique sequencing instruments utilized"
    - name: "distinct_protocols"
      expr: COUNT(DISTINCT sequencing_protocol_id)
      comment: "Number of unique sequencing protocols executed"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`sequencing_coverage_stat`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sequencing coverage and quality metrics critical for assessing data adequacy and clinical/research validity"
  source: "`genomics_biotech_ecm`.`sequencing`.`coverage_stat`"
  dimensions:
    - name: "qc_status"
      expr: qc_status
      comment: "Quality control status of the coverage analysis"
    - name: "approved_for_analysis"
      expr: approved_for_analysis
      comment: "Whether the coverage data is approved for downstream analysis"
    - name: "resequencing_required"
      expr: resequencing_required
      comment: "Flag indicating if sample requires resequencing due to insufficient coverage"
    - name: "assay_type"
      expr: assay_type
      comment: "Type of sequencing assay (e.g., WGS, WES, targeted panel)"
    - name: "reference_genome_version"
      expr: reference_genome_version
      comment: "Reference genome build used for alignment"
    - name: "qc_failure_reason"
      expr: qc_failure_reason
      comment: "Reason for quality control failure if applicable"
    - name: "computed_date"
      expr: DATE_TRUNC('day', computed_timestamp)
      comment: "Date when coverage statistics were computed"
    - name: "computed_month"
      expr: DATE_TRUNC('month', computed_timestamp)
      comment: "Month when coverage statistics were computed"
  measures:
    - name: "total_coverage_analyses"
      expr: COUNT(1)
      comment: "Total number of coverage analyses performed"
    - name: "avg_mean_coverage_depth"
      expr: AVG(CAST(mean_coverage_depth AS DOUBLE))
      comment: "Average mean coverage depth across all samples"
    - name: "avg_median_coverage_depth"
      expr: AVG(CAST(median_coverage_depth AS DOUBLE))
      comment: "Average median coverage depth across all samples"
    - name: "avg_pct_bases_at_30x"
      expr: AVG(CAST(pct_bases_at_30x AS DOUBLE))
      comment: "Average percentage of bases covered at 30x or greater"
    - name: "avg_pct_bases_at_100x"
      expr: AVG(CAST(pct_bases_at_100x AS DOUBLE))
      comment: "Average percentage of bases covered at 100x or greater"
    - name: "avg_mapping_rate_pct"
      expr: AVG(CAST(mapping_rate_pct AS DOUBLE))
      comment: "Average percentage of reads successfully mapped to reference"
    - name: "avg_on_target_rate_pct"
      expr: AVG(CAST(on_target_rate_pct AS DOUBLE))
      comment: "Average percentage of reads mapping to target regions"
    - name: "avg_duplication_rate_pct"
      expr: AVG(CAST(duplication_rate_pct AS DOUBLE))
      comment: "Average PCR duplication rate percentage"
    - name: "avg_coverage_uniformity_pct"
      expr: AVG(CAST(coverage_uniformity_pct AS DOUBLE))
      comment: "Average coverage uniformity percentage across target regions"
    - name: "avg_pct_q30_bases"
      expr: AVG(CAST(pct_q30_bases AS DOUBLE))
      comment: "Average percentage of bases with quality score ≥30"
    - name: "total_mapped_reads"
      expr: SUM(CAST(mapped_reads AS BIGINT))
      comment: "Total number of reads mapped across all samples"
    - name: "total_reads"
      expr: SUM(CAST(total_reads AS BIGINT))
      comment: "Total number of sequencing reads across all samples"
    - name: "qc_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN qc_status = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of samples passing coverage quality control"
    - name: "resequencing_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN resequencing_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of samples requiring resequencing due to quality issues"
    - name: "approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN approved_for_analysis = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of samples approved for downstream analysis"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`sequencing_library`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Library preparation quality and throughput metrics for assessing prep efficiency and sample readiness"
  source: "`genomics_biotech_ecm`.`sequencing`.`library`"
  dimensions:
    - name: "qc_status"
      expr: qc_status
      comment: "Quality control status of the library"
    - name: "library_type"
      expr: library_type
      comment: "Type of library preparation (e.g., PCR-free, amplified)"
    - name: "nucleic_acid_type"
      expr: nucleic_acid_type
      comment: "Type of nucleic acid (DNA or RNA)"
    - name: "is_paired_end"
      expr: is_paired_end
      comment: "Whether library is prepared for paired-end sequencing"
    - name: "is_pcr_free"
      expr: is_pcr_free
      comment: "Whether library preparation is PCR-free"
    - name: "intended_use"
      expr: intended_use
      comment: "Intended application of the library (clinical, research, validation)"
    - name: "consent_flag"
      expr: consent_flag
      comment: "Patient consent status for data use"
    - name: "resequencing_flag"
      expr: resequencing_flag
      comment: "Flag indicating if this is a resequencing library"
    - name: "qc_failure_reason"
      expr: qc_failure_reason
      comment: "Reason for quality control failure if applicable"
    - name: "prep_date"
      expr: prep_date
      comment: "Date the library was prepared"
    - name: "prep_month"
      expr: DATE_TRUNC('month', CAST(prep_date AS TIMESTAMP))
      comment: "Month the library was prepared"
  measures:
    - name: "total_libraries"
      expr: COUNT(1)
      comment: "Total number of libraries prepared"
    - name: "avg_concentration_nm"
      expr: AVG(CAST(concentration_nm AS DOUBLE))
      comment: "Average library concentration in nanomolar"
    - name: "avg_input_dna_mass_ng"
      expr: AVG(CAST(input_dna_mass_ng AS DOUBLE))
      comment: "Average input DNA mass in nanograms"
    - name: "avg_volume_remaining_ul"
      expr: AVG(CAST(volume_remaining_ul AS DOUBLE))
      comment: "Average remaining library volume in microliters"
    - name: "qc_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN qc_status = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of libraries passing quality control"
    - name: "resequencing_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN resequencing_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of libraries flagged for resequencing"
    - name: "pcr_free_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_pcr_free = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of libraries prepared using PCR-free methods"
    - name: "paired_end_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_paired_end = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of libraries prepared for paired-end sequencing"
    - name: "distinct_assay_versions"
      expr: COUNT(DISTINCT assay_version_id)
      comment: "Number of unique assay versions used in library preparation"
    - name: "distinct_projects"
      expr: COUNT(DISTINCT project_id)
      comment: "Number of unique projects associated with libraries"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`sequencing_run_lane`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Per-lane sequencing performance metrics for instrument utilization and quality monitoring"
  source: "`genomics_biotech_ecm`.`sequencing`.`run_lane`"
  dimensions:
    - name: "lane_qc_status"
      expr: lane_qc_status
      comment: "Quality control status of the sequencing lane"
    - name: "lane_number"
      expr: lane_number
      comment: "Physical lane number on the flow cell"
    - name: "demultiplexing_status"
      expr: demultiplexing_status
      comment: "Status of sample demultiplexing for this lane"
    - name: "requeue_required"
      expr: requeue_required
      comment: "Whether the lane requires resequencing"
    - name: "run_mode"
      expr: run_mode
      comment: "Sequencing run mode for this lane"
    - name: "sequencing_application"
      expr: sequencing_application
      comment: "Application type for this sequencing lane"
    - name: "lane_failure_reason"
      expr: lane_failure_reason
      comment: "Reason for lane failure if applicable"
    - name: "lane_start_date"
      expr: DATE_TRUNC('day', lane_start_timestamp)
      comment: "Date the lane sequencing started"
    - name: "lane_start_month"
      expr: DATE_TRUNC('month', lane_start_timestamp)
      comment: "Month the lane sequencing started"
  measures:
    - name: "total_lanes_sequenced"
      expr: COUNT(1)
      comment: "Total number of sequencing lanes executed"
    - name: "total_lane_yield_gb"
      expr: SUM(CAST(lane_yield_gb AS DOUBLE))
      comment: "Total sequencing yield in gigabases across all lanes"
    - name: "avg_lane_yield_gb"
      expr: AVG(CAST(lane_yield_gb AS DOUBLE))
      comment: "Average sequencing yield per lane in gigabases"
    - name: "avg_cluster_density_k_per_mm2"
      expr: AVG(CAST(cluster_density_k_per_mm2 AS DOUBLE))
      comment: "Average cluster density in thousands per square millimeter"
    - name: "avg_clusters_passing_filter_pct"
      expr: AVG(CAST(clusters_passing_filter_pct AS DOUBLE))
      comment: "Average percentage of clusters passing filter quality thresholds"
    - name: "avg_mean_phred_q30_pct"
      expr: AVG(CAST(mean_phred_q30_pct AS DOUBLE))
      comment: "Average percentage of bases with Phred quality score ≥30"
    - name: "avg_mean_phred_score"
      expr: AVG(CAST(mean_phred_score AS DOUBLE))
      comment: "Average Phred quality score across all bases"
    - name: "avg_error_rate_pct"
      expr: AVG(CAST(error_rate_pct AS DOUBLE))
      comment: "Average sequencing error rate percentage"
    - name: "avg_phix_alignment_pct"
      expr: AVG(CAST(phix_alignment_pct AS DOUBLE))
      comment: "Average PhiX control alignment percentage for quality assessment"
    - name: "avg_undetermined_reads_pct"
      expr: AVG(CAST(undetermined_reads_pct AS DOUBLE))
      comment: "Average percentage of reads that could not be demultiplexed"
    - name: "total_reads_passing_filter"
      expr: SUM(CAST(reads_passing_filter AS BIGINT))
      comment: "Total number of reads passing filter across all lanes"
    - name: "total_reads"
      expr: SUM(CAST(total_reads AS BIGINT))
      comment: "Total number of reads generated across all lanes"
    - name: "lane_qc_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN lane_qc_status = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lanes passing quality control"
    - name: "lane_requeue_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN requeue_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lanes requiring resequencing"
    - name: "distinct_flow_cells"
      expr: COUNT(DISTINCT flow_cell_id)
      comment: "Number of unique flow cells utilized"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`sequencing_demux_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demultiplexing performance and sample assignment metrics for assessing index quality and data distribution"
  source: "`genomics_biotech_ecm`.`sequencing`.`demux_result`"
  dimensions:
    - name: "demux_status"
      expr: demux_status
      comment: "Status of the demultiplexing process"
    - name: "qc_pass_flag"
      expr: qc_pass_flag
      comment: "Whether demultiplexing passed quality control"
    - name: "reprocessing_flag"
      expr: reprocessing_flag
      comment: "Whether this is a reprocessed demultiplexing result"
    - name: "data_release_flag"
      expr: data_release_flag
      comment: "Whether data has been released for downstream use"
    - name: "run_use_type"
      expr: run_use_type
      comment: "Type of run usage (production, validation, research)"
    - name: "sequencing_type"
      expr: sequencing_type
      comment: "Type of sequencing performed"
    - name: "instrument_platform"
      expr: instrument_platform
      comment: "Sequencing instrument platform used"
    - name: "lane_number"
      expr: lane_number
      comment: "Lane number where sample was sequenced"
    - name: "qc_failure_reason"
      expr: qc_failure_reason
      comment: "Reason for quality control failure if applicable"
    - name: "demux_completion_date"
      expr: DATE_TRUNC('day', demux_completion_timestamp)
      comment: "Date demultiplexing was completed"
    - name: "demux_completion_month"
      expr: DATE_TRUNC('month', demux_completion_timestamp)
      comment: "Month demultiplexing was completed"
  measures:
    - name: "total_demux_results"
      expr: COUNT(1)
      comment: "Total number of demultiplexing results generated"
    - name: "total_assigned_reads"
      expr: SUM(CAST(assigned_read_count AS BIGINT))
      comment: "Total number of reads successfully assigned to samples"
    - name: "avg_assigned_read_count"
      expr: AVG(CAST(assigned_read_count AS BIGINT))
      comment: "Average number of reads assigned per sample"
    - name: "avg_assigned_read_pct"
      expr: AVG(CAST(assigned_read_pct AS DOUBLE))
      comment: "Average percentage of lane reads assigned to this sample"
    - name: "total_undetermined_reads"
      expr: SUM(CAST(undetermined_read_count AS BIGINT))
      comment: "Total number of reads that could not be assigned to any sample"
    - name: "avg_undetermined_read_pct"
      expr: AVG(CAST(undetermined_read_pct AS DOUBLE))
      comment: "Average percentage of undetermined reads per lane"
    - name: "total_index_mismatches"
      expr: SUM(CAST(index_mismatch_count AS BIGINT))
      comment: "Total number of index sequence mismatches detected"
    - name: "avg_mean_phred_score_r1"
      expr: AVG(CAST(mean_phred_score_r1 AS DOUBLE))
      comment: "Average Phred quality score for Read 1"
    - name: "avg_mean_phred_score_r2"
      expr: AVG(CAST(mean_phred_score_r2 AS DOUBLE))
      comment: "Average Phred quality score for Read 2"
    - name: "avg_pct_q30_r1"
      expr: AVG(CAST(pct_q30_r1 AS DOUBLE))
      comment: "Average percentage of Q30 bases in Read 1"
    - name: "avg_pct_q30_r2"
      expr: AVG(CAST(pct_q30_r2 AS DOUBLE))
      comment: "Average percentage of Q30 bases in Read 2"
    - name: "demux_qc_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN qc_pass_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of demultiplexing results passing quality control"
    - name: "reprocessing_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reprocessing_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of samples requiring demultiplexing reprocessing"
    - name: "data_release_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN data_release_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of demultiplexed data released for downstream use"
    - name: "distinct_sequencing_runs"
      expr: COUNT(DISTINCT sequencing_run_id)
      comment: "Number of unique sequencing runs demultiplexed"
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`sequencing_library_prep_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Library preparation batch performance and quality metrics for process optimization and compliance monitoring"
  source: "`genomics_biotech_ecm`.`sequencing`.`library_prep_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of the library preparation run"
    - name: "batch_qc_outcome"
      expr: batch_qc_outcome
      comment: "Overall quality control outcome for the batch"
    - name: "use_type"
      expr: use_type
      comment: "Type of use (production, validation, research)"
    - name: "library_type"
      expr: library_type
      comment: "Type of library prepared in this run"
    - name: "input_material_type"
      expr: input_material_type
      comment: "Type of input material (DNA, RNA, etc.)"
    - name: "fragmentation_method"
      expr: fragmentation_method
      comment: "Method used for DNA/RNA fragmentation"
    - name: "size_selection_method"
      expr: size_selection_method
      comment: "Method used for fragment size selection"
    - name: "end_repair_performed"
      expr: end_repair_performed
      comment: "Whether end repair was performed"
    - name: "sop_deviation_flag"
      expr: sop_deviation_flag
      comment: "Flag indicating deviation from standard operating procedure"
    - name: "index_collision_check_passed"
      expr: index_collision_check_passed
      comment: "Whether index collision check passed"
    - name: "start_date"
      expr: DATE_TRUNC('day', start_timestamp)
      comment: "Date the library prep run started"
    - name: "start_month"
      expr: DATE_TRUNC('month', start_timestamp)
      comment: "Month the library prep run started"
  measures:
    - name: "total_prep_runs"
      expr: COUNT(1)
      comment: "Total number of library preparation runs executed"
    - name: "avg_input_dna_amount_ng"
      expr: AVG(CAST(input_dna_amount_ng AS DOUBLE))
      comment: "Average input DNA amount in nanograms"
    - name: "avg_final_library_concentration_nm"
      expr: AVG(CAST(final_library_concentration_nm AS DOUBLE))
      comment: "Average final library concentration in nanomolar"
    - name: "avg_final_pooling_volume_ul"
      expr: AVG(CAST(final_pooling_volume_ul AS DOUBLE))
      comment: "Average final pooling volume in microliters"
    - name: "avg_adapter_dimer_pct"
      expr: AVG(CAST(adapter_dimer_pct AS DOUBLE))
      comment: "Average adapter dimer contamination percentage"
    - name: "sop_deviation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sop_deviation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prep runs with SOP deviations"
    - name: "index_collision_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN index_collision_check_passed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prep runs passing index collision checks"
    - name: "distinct_protocols"
      expr: COUNT(DISTINCT research_protocol_id)
      comment: "Number of unique research protocols used"
    - name: "distinct_kit_lots"
      expr: COUNT(DISTINCT lot_id)
      comment: "Number of unique kit lots utilized"
    - name: "distinct_projects"
      expr: COUNT(DISTINCT project_id)
      comment: "Number of unique projects processed"
$$;
