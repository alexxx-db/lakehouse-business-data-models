-- Metric views for domain: quality | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-02 04:05:05

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_analytical_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key quality KPIs derived from analytical laboratory results"
  source: "`vibe_water_utilities_v1`.`quality`.`analytical_result`"
  dimensions:
    - name: "analysis_date"
      expr: analysis_date
      comment: "Date the analysis was performed"
    - name: "contaminant_id"
      expr: contaminant_id
      comment: "Identifier of the contaminant tested"
    - name: "analytical_method"
      expr: analytical_method
      comment: "Laboratory method used for analysis"
  measures:
    - name: "total_analytical_results"
      expr: COUNT(1)
      comment: "Total number of analytical result records"
    - name: "average_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average measured value across all analytical results"
    - name: "exceedance_count"
      expr: SUM(CASE WHEN compliance_exceeded THEN 1 ELSE 0 END)
      comment: "Count of results where compliance was exceeded"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_bacteriological_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bacteriological water quality metrics for regulatory compliance"
  source: "`vibe_water_utilities_v1`.`quality`.`bacteriological_result`"
  dimensions:
    - name: "analysis_date"
      expr: analysis_date
      comment: "Date the bacteriological analysis was completed"
    - name: "contaminant_id"
      expr: contaminant_id
      comment: "Contaminant being measured"
    - name: "sample_type"
      expr: sample_type
      comment: "Type of water sample (e.g., raw, treated)"
  measures:
    - name: "total_bacteriological_samples"
      expr: COUNT(1)
      comment: "Total number of bacteriological samples processed"
    - name: "average_e_coli_cfu"
      expr: AVG(CAST(e_coli_cfu AS DOUBLE))
      comment: "Average E. coli concentration (CFU) per sample"
    - name: "average_total_coliform_cfu"
      expr: AVG(CAST(total_coliform_cfu AS DOUBLE))
      comment: "Average total coliform concentration (CFU) per sample"
    - name: "mcl_exceedance_count"
      expr: SUM(CASE WHEN mcl_exceeded_flag THEN 1 ELSE 0 END)
      comment: "Number of samples that exceeded the Maximum Contaminant Level"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_effluent_quality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Effluent discharge quality KPIs for operational monitoring"
  source: "`vibe_water_utilities_v1`.`quality`.`effluent_quality`"
  dimensions:
    - name: "analysis_completion_date"
      expr: analysis_completion_date
      comment: "Date the effluent sample analysis was completed"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status for the sample"
  measures:
    - name: "total_effluent_samples"
      expr: COUNT(1)
      comment: "Total effluent quality records collected"
    - name: "average_bod5_mg_l"
      expr: AVG(CAST(bod5_mg_l AS DOUBLE))
      comment: "Average BOD5 concentration in effluent (mg/L)"
    - name: "average_ammonia_nitrogen_mg_l"
      expr: AVG(CAST(ammonia_nitrogen_mg_l AS DOUBLE))
      comment: "Average ammonia nitrogen concentration in effluent (mg/L)"
    - name: "total_flow_mgd"
      expr: SUM(CAST(flow_rate_mgd AS DOUBLE))
      comment: "Cumulative effluent flow volume (MGD) across all records"
    - name: "non_compliant_count"
      expr: SUM(CASE WHEN compliance_status = 'Non-compliant' THEN 1 ELSE 0 END)
      comment: "Count of effluent samples flagged as non‑compliant"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`quality_source_water_quality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Source water quality monitoring metrics for early detection of issues"
  source: "`vibe_water_utilities_v1`.`quality`.`source_water_quality`"
  dimensions:
    - name: "source_type"
      expr: source_type
      comment: "Type of source water (e.g., river, reservoir)"
    - name: "analysis_method"
      expr: analysis_method
      comment: "Laboratory method used for source water analysis"
  measures:
    - name: "total_source_water_samples"
      expr: COUNT(1)
      comment: "Total number of source water quality samples"
    - name: "average_turbidity_ntu"
      expr: AVG(CAST(turbidity_ntu AS DOUBLE))
      comment: "Average turbidity (NTU) of source water"
    - name: "average_ph_level"
      expr: AVG(CAST(ph_level AS DOUBLE))
      comment: "Average pH of source water"
    - name: "regulatory_exceedance_count"
      expr: SUM(CASE WHEN regulatory_exceedance THEN 1 ELSE 0 END)
      comment: "Count of samples that exceeded regulatory limits"
$$;